Desenvolvi um sistema de gerenciamento de despesas pessoais utilizando a plataforma Salesforce. Criei um aplicativo chamado "IT ACADEMY" que consiste em objetos como usuário, conta bancária, contas pessoais, transações, relatórios e painéis.


Esse aplicativo foi criado para que cada usuário possa ter várias contas pessoais e contas bancárias, realizar transações entre suas contas bancárias e ter tudo registrado em seu histórico. Permitindo que o usuário gerencie suas contas, faça suas transações e exibe relatórios em um painel.


Toda Conta bancária ao ser registrada começam com saldo zero, para isso foi criado uma Trigger  PreencherSaldoContaBancaria por Apex que faz esse processo. Ainda no objeto conta bancária existe uma trigger, que também é realizada por apex,  chamada PreencherCamposContaBancariaEmUsuario, onde ao ser selecionado uma Checkbox que define se a conta bancária é a conta principal do cliente, dessa forma o usuário pode ter várias contas bancárias e selecionar uma conta principal, cujo saldo é exibido na descrição do usuário. 


Já no objeto conta pessoal são armazenadas transações de receita ou despesa, incluindo valor, data, categoria e descrição. Nessas contas pessoais existem códigos de triggers chamada AtualizarSaldo implementada para atualizar as contas bancárias com base nas transações, somando os valores das receitas e subtraindo os valores das despesas, essa mesma Trigger serve para atualizar os campos Saldo atual e saldo anterior que aparece na lista de extrato. 


No objeto usuário foram criados  campos para despesa total, receita total e saldo total, que são atualizados com todas as alterações, independentemente do banco utilizado nas transações.

Antes de remover uma conta, o sistema alerta o usuário sobre a exclusão de todos os dados relacionados a ela.


Implementei um componente LWC (Lightning Web Component) que utiliza como linguagem base Javascript e HTML chamado historicoAlteracoes para exibir o extrato da conta, listando as transações ordenadas por data e calculando o saldo a cada transação.


No objeto Transação Foi implementado a  funcionalidade de transferência de fundos através da Trigger TrasacaoTrigger, permitindo que o usuário informe uma conta de destino e um valor a ser transferido. O sistema verifica se a conta de origem possui saldo suficiente e registra duas transações: uma retirada da conta de origem e um depósito na conta de destino.


Como uma funcionalidade adicional, criei triggers para preencher com zero as despesas ou receitas não associadas à conta pessoal e para preencher automaticamente os dados da conta bancária do usuário quando a conta principal é marcada.

