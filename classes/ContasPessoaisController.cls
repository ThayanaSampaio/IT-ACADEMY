public with sharing class ContasPessoaisController {
    @AuraEnabled(cacheable=true)
    public static List<Conta_Pessoal__c> getContas(Id userId) {
        return [
            SELECT Id, Name, Tipo__c, Categoria__c, ValorReceita__c, ValorDespesa__c, Nome_Conta_Bancaria__c
            FROM Conta_Pessoal__c
            WHERE Usuario__c = :userId
        ];
    }
}