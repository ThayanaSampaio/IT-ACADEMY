trigger AtualizarSaldo on Conta_Pessoal__c ( after Delete, before insert, before update ) {    
   
    List<Conta_Bancaria__c> contasAtualizar = new List<Conta_Bancaria__c>();  
    if ( Trigger.isInsert || Trigger.isUpdate){
        for (Conta_Pessoal__c cp : Trigger.new) {
            Conta_Bancaria__c cb = [SELECT Id, Usuario__c, Saldo__c FROM Conta_Bancaria__c WHERE Id = :cp.Nome_Conta_Bancaria__c];       
            cp.Saldo_Atual__c = cb.saldo__c;
            cb.saldo__c += cp.ValorReceita__c != null ? cp.ValorReceita__c : 0;
            cb.saldo__c -= cp.ValorDespesa__c != null ? cp.ValorDespesa__c : 0; 
            cp.Saldo_Anterior__c = cb.saldo__c;
            contasAtualizar.add(cb);
        }
    }
    if ( Trigger.isDelete){
        for (Conta_Pessoal__c cp : Trigger.old) {
            Conta_Bancaria__c cb = [SELECT Id, Usuario__c, Saldo__c FROM Conta_Bancaria__c WHERE Id = :cp.Nome_Conta_Bancaria__c];       
            cb.saldo__c -= cp.ValorReceita__c != null ? cp.ValorReceita__c : 0;
            cb.saldo__c += cp.ValorDespesa__c != null ? cp.ValorDespesa__c : 0;           
            contasAtualizar.add(cb);
        }
    }
    if (!contasAtualizar.isEmpty()) {
        update contasAtualizar;
    }
}