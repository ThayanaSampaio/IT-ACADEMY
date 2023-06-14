import { LightningElement, wire, api } from 'lwc';
import getTransacoes from '@salesforce/apex/TransacaoController.getTransacoes';
import getContasPessoais from '@salesforce/apex/ContaPessoalController.getContasPessoais';
import getContasBancarias from '@salesforce/apex/ContaBancariaController.getContasBancarias';

export default class HistoricoAlteracoes extends LightningElement {
    @api recordId;

    transacoes;
    contasPessoais;
    contasBancarias;
    

    @wire(getTransacoes, { userId: '$recordId' })
    wiredTransacoes({ error, data }) {
        if (data) {
            this.transacoes = data;
        } else if (error) {
            
        }
    }

    @wire(getContasPessoais, { userId: '$recordId' })
    wiredContasPessoais({ error, data }) {
        if (data) {
            this.contasPessoais = data;
        } else if (error) {
            
        }
    }

    @wire(getContasBancarias, { userId: '$recordId' })
    wiredContasBancarias({ error, data }) {
        if (data) {
            this.contasBancarias = data;
        } else if (error) {
          
        }
    }



    get historicoAlteracoes() {
        let historico = [];


        
        if (this.transacoes) {
            for (let transacao of this.transacoes) {
                let historicoItem = {
                    Name: transacao.Name,
                    Tipo__c: 'Transação',   
                    Valor_para_transferencia__c: transacao.Valor_para_transferencia__c,                    
                    Nome_Conta_Bancaria__c: transacao.Banco_de_Origem__r.Name,
                    Data__c: transacao.Data__c,
                    Saldo_Atual__c: transacao.Saldo_Atual__c,
                    Saldo_Anterior__c: transacao.Saldo_Anterior__c


                };
                historico.push(historicoItem);
            }
        }
        
        if (this.contasPessoais) { console.log(this.contasPessoais)
            for (let conta of this.contasPessoais) {                
                let historicoItem = {
                    Name: conta.Name,
                    Tipo__c: conta.Tipo__c,                
                    Nome_Conta_Bancaria__c: conta.Nome_Conta_Bancaria__r.Name,
                    Data__c: conta.Data__c,
                    Saldo_Atual__c: conta.Saldo_Atual__c,
                    Saldo_Anterior__c: conta.Saldo_Anterior__c
                };              
                if(conta.Tipo__c === 'Receita'){
                    historicoItem.Valor_para_transferencia__c = conta.ValorReceita__c;
                } else{historicoItem.Valor_para_transferencia__c = conta.ValorDespesa__c;}
                
                historico.push(historicoItem);
            }
        }

        
        return historico.sort((a, b) => {
            return new Date(b.Data__c) - new Date(a.Data__c);
        });
    }
}