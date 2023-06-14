trigger valorEntradaSaida on Conta_Pessoal__c (before insert, before update) {
    for (Conta_Pessoal__c conta : Trigger.new) {
        if (conta.ValorDespesa__c != null && conta.ValorReceita__c == null) {
            conta.ValorReceita__c = 0;
        }
        if (conta.ValorReceita__c != null && conta.ValorDespesa__c == null) {
            conta.ValorDespesa__c = 0;
        }
    }
}