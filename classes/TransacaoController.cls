public with sharing class TransacaoController {
    @AuraEnabled(cacheable=true)
    public static List<Transacao__c> getTransacoes(Id userId) {
        // Consulta para recuperar as transações relacionadas ao usuário
        // Filtre as transações pelos campos relevantes, como a conta bancária de origem ou destino
        return [SELECT Name, Banco_de_Origem__r.Name, Valor_para_transferencia__c, Data__c, Saldo_Atual__c, Saldo_Anterior__c
        FROM Transacao__c
        WHERE Usuario__c = :userId];
    }
}