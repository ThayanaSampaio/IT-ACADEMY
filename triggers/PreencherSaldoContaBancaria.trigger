trigger PreencherSaldoContaBancaria on Conta_Bancaria__c (before insert) {
    for (Conta_Bancaria__c contaBancaria : Trigger.new) {
        contaBancaria.Saldo__c = 0;
    }
}