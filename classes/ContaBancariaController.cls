public with sharing class ContaBancariaController {
    @AuraEnabled(cacheable=true)
    public static List<Conta_Bancaria__c> getContasBancarias(Id userId) {
        // Consulta para recuperar as contas bancárias relacionadas ao usuário
        
        return [SELECT Name, Saldo__c, Data__c, Saldo_Atual__c, Saldo_Anterior__c
                FROM Conta_Bancaria__c
                WHERE Usuario__c = :userId];
    }
}