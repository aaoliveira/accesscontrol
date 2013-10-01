Componente AccessControl
========================

Objetivo - controlar o acesso dos usuários ao aplicativo. Ele controla o acesso a cada action.
O controle associa o grupo do usuário ao action. Quando cadastramos um grupo com um action, o componente garantirá acesso para todos os usuários do grupo nesse action.


Passos:
-------

- Criar sua aplicação, mas não use tabelas com nomes: users, groups nem privileges
- Importar para seu banco o script accesscontrol.sql
- Por favor, faça um backup completo do seu aplicativo antes de continuar
- Descompacte o arquivo AccessControl.zip e copie as pastas Controller, Model e View para dentro do app/ da sua aplicação. A pasta View traz uma pasta Layout com o default.php, caso não queira sobrescrever o seu ignore. Segue também um element integrado ao layout default.php, que mostra um pequeno menu no topo. Para integrar ao seu layout adicione a linha seguinte abaixo da div header:
			<?php echo $this->element('menutopo');//Aqui?>


Adicionar ao AppController.php:
-------------------------------

    public $components = array(
        'Session','AccessControl',
        'Auth' => array(// Below is my controller initial in routes
            'loginRedirect' => array('controller' => 'posts', 'action' => 'index'),
            'logoutRedirect' => array('controller' => 'users', 'action' => 'login'),
			'authorize' => array('Controller')
        )
    );

    public function beforeFilter() {
		// All users access index action from all constroller
		$this->Auth->allow('index');
		$controller=$this->params['controller']; 
		$action=$this->params['action']; 

		if($action != 'index'){// || $action != 'add'
			$this->AccessControl->go($controller,$action); 		 
			if($this->AccessControl->redir==true){ 
				$this->redirect(array('controller' => 'users','action' => 'login')); 
			}
		}
    }

	public function isAuthorized($user) {
	    return true;
	}


Cadastrando as Permissões
-------------------------

Acesse como admin e cadastre todas os actions cujo acesso deseja tornar restrito.
Observe que as permissões para users, groups e privileges já estão cadastradas e todas dão acesso somente ao admin. Altere se achar por bem.
Apenas cadastre agora as permissões das tabelas do seu sistema que não estão por padrão na tabela privileges.
http://localhost/posts/privileges

Sugestão
add, edit e delete - manager
index e view - user

Atente para não esquecer nenhum. Os que esquecer permitirão acesso público.

Testando
--------

Como já existem 3 usuários cadastrados: admin, manager e user (a senha é igual ao login de cada um), você já pode testar o componente, acessando, por exemplo, o action edit ou add do posts ou outra área restrita.



OUTRAS CONFIGURAÇÕES
====================

Negar Acesso Público a tudo no Aplicativo
-----------------------------------------

Mude o beforeFilter assim passando o controle total para o AccessControl.

    public function beforeFilter() {
		$controller=$this->params['controller']; 
		$action=$this->params['action']; 

		$this->AccessControl->go($controller,$action); 		 
		if($this->AccessControl->redir==true){ 
			$this->redirect(array('controller' => 'users','action' => 'login')); 
		}
    }


Actions Não Cadastrados
-----------------------

Se receber a mensagem 'Restricted Area', mesmo estando logado (exceto logo ao logar), isso indica que o action atual não está cadastrado no privileges. Acesse como admin e cadastre.


Aplicativo de Exemplo
---------------------

Adicionei um pacote com um aplicativo de exemplo, já com o componente AccessControl aplicado para mostrar o funcionamento de forma mais fácil: blog_sample.zip. Apenas descompacte, crie o banco 'blog_sample' e importe o script do raiz.

Ao executar e tiver a senha rejeitada, libere o acesso para index, add e edit e altere as senhas dos usuários pelo controller uses (como explicado acima).


Cadastrando Usuários 
--------------------
Somente faça isso se a senha 'admin' do usuário admin não for reconhecida

Para permitir cadastrar os usuários deixe o AppController assim:
Mudanças temporárias. Depois desfaça.

    public $components = array(
        'Session',//'AccessControl',
        'Auth' => array(// Below is my controller initial in routes
            'loginRedirect' => array('/'),
            'logoutRedirect' => array('controller' => 'users', 'action' => 'login'),
			'authorize' => array('Controller')
        )
    );

    public function beforeFilter() {
		$this->Auth->allow('index','add','edit');
/*
		$controller=$this->params['controller']; 
		$action=$this->params['action']; 

		if($action != 'index'){// || $action != 'add'
			$this->AccessControl->go($controller,$action); 		 
			if($this->AccessControl->redir==true){ 
				$this->redirect(array('controller' => 'users','action' => 'login')); 
			}
		}
*/
    }

	public function isAuthorized($user) {
	    return true;
	}


Possível Problema
-----------------

Se estiver acessando uma área restrita com um usuário que não deveria acessá-la, isso indica que o componente AccessControl está desativado. Veja se o comentou no AppController.php.


Dicas e Tutoriais sobre CakePHP - http://ribafs.org - CakePHP


Licença - MIT

