trigger PreencherCamposContaBancariaEmUsuario on Conta_Bancaria__c (after insert, after update) {
    
    
    // Obtém os IDs dos usuários associados às contas principais inseridas ou atualizadas
    Set<Id> usuarioIds = new Set<Id>();
    for (Conta_Bancaria__c contaBancaria : Trigger.new) {
        if (contaBancaria.Conta_Principal__c) {
            usuarioIds.add(contaBancaria.Usuario__c);
        }
    }

    // Verifica se existem IDs de usuários associados a contas principais
    if (!usuarioIds.isEmpty()) {
        // Consulta os usuários relacionados aos IDs obtidos
        List<Usuario__c> usuarios = [SELECT Id, Nome_do_Banco__c, Agencia__c, Numero_da_Conta__c, Saldo__c,
                                     (SELECT Id, Conta_Principal__c FROM Contas_Bancarias__r WHERE Conta_Principal__c = true LIMIT 2)
                                     FROM Usuario__c WHERE Id IN :usuarioIds];
        
        // Mapeia os usuários pelo ID
        Map<Id, Usuario__c> usuarioMap = new Map<Id, Usuario__c>(usuarios);

        // Percorre as contas bancárias inseridas ou atualizadas
        for (Conta_Bancaria__c contaBancaria : Trigger.new) {
            // Verifica se a conta é uma conta principal
            if (contaBancaria.Conta_Principal__c) {
                // Obtém o usuário associado à conta principal
                Usuario__c usuario = usuarioMap.get(contaBancaria.Usuario__c);
                
                // Verifica se o usuário já possui outra conta principal associada
                if (usuario.Contas_Bancarias__r.size() > 1) {
                    contaBancaria.addError('Já existe uma conta principal associada a este usuário.');
                } else {
                    // Preenche os campos do usuário com os valores da conta principal
                    usuario.Nome_do_Banco__c = contaBancaria.Name;
                    usuario.Agencia__c = contaBancaria.Agencia__c;
                    usuario.Numero_da_Conta__c = contaBancaria.Numero_da_Conta__c;
                    usuario.Saldo__c = contaBancaria.Saldo__c;
                }
            }
        }

        // Atualiza os usuários modificados
        update usuarioMap.values();
    }
}