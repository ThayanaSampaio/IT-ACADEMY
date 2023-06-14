trigger TransacaoTrigger on Transacao__c (before insert) {
    for (Transacao__c transacao : Trigger.new) {
        if (transacao.Valor_para_transferencia__c != null) {
            // Obter o saldo do banco de origem
            Conta_Bancaria__c bancoDeOrigem = [SELECT Saldo__c FROM Conta_Bancaria__c WHERE Id = :transacao.Banco_de_Origem__c];
            
            // Obter o saldo do banco de destino
            Conta_Bancaria__c bancoDeDestino = [SELECT Saldo__c FROM Conta_Bancaria__c WHERE Id = :transacao.Banco_de_Destino__c];
            transacao.Saldo_Anterior__c = bancoDeOrigem.Saldo__c;
            
            // Verificar se o saldo do banco de origem é suficiente para a transação
            if (bancoDeOrigem.Saldo__c >= transacao.Valor_para_transferencia__c) {
                // Atualizar os saldos dos bancos
                bancoDeOrigem.Saldo__c -= transacao.Valor_para_transferencia__c;
                bancoDeDestino.Saldo__c += transacao.Valor_para_transferencia__c;
                
                transacao.Saldo_Atual__c  = bancoDeOrigem.Saldo__c;
                
                
                // Atualizar os registros dos bancos
                update bancoDeOrigem;
                update bancoDeDestino;
            } else {
                //Erro para quando o saldo do banco de origem não é suficiente
                transacao.addError('O saldo do banco de origem não é suficiente para a transação.');
            }
        }
    }
}