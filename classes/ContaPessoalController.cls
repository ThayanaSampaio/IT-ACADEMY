public with sharing class ContaPessoalController {
    @AuraEnabled(cacheable=true)
    public static List<Conta_Pessoal__c> getContasPessoais(Id userId) {
        // Consulta para recuperar as contas pessoais relacionadas ao usuário
        
        return [SELECT Name, Tipo__c,  Nome_Conta_Bancaria__r.Name, ValorReceita__c, ValorDespesa__c, Data__c, Saldo_Atual__c, Saldo_Anterior__c
                FROM Conta_Pessoal__c
                WHERE Usuario__c = :userId];
    }
}