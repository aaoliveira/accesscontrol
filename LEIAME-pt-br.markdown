# Componente AccessControl para CakePHP

Objetivo - controlar o acesso dos usuários ao aplicativo. Ele controla o acesso a cada action de cada controller.
O controle associa o grupo do usuário ao action, gravando numa tabela. Quando cadastramos um grupo com um action, o componente garantirá acesso para todos os usuários do grupo nesse action.
Adicionei mais uma característica importante: um menu de topo que mostra ao usuário do site somente os controllers que ele tem acesso. Se não logado mostrará apenas o que foi liberado para o público no AppController pelo Auth allow.

## Requisitos

Não use tabelas com nomes users, groups nem privileges. Caso já tenha, precisará fazer as adaptações

## Passos:

- Efetuar o download
https://github.com/ribafs/accesscontrol
- Baixar, descompactar
- Importar para seu banco o script accesscontrol.sql, que contem as tabelas users, groups e privileges
- Caso seu aplicativo não seja um aplicativo de testes, recomenda-se um backup completo do seu aplicativo (todos os arquivos e todo o banco) antes de continuar
- Descompacte o arquivo AccessControl.zip e copie todo o conteúdo para dentro da pasta app/ da sua aplicação. A pasta View traz uma pasta Layout com um default.php. É util que integre o Element/menu com o seu layout, caso não sobrescreva o seu default.php. Segue também um element integrado ao layout default.php, que mostra um pequeno menu no topo. Para integrar ao seu layout adicione a linha seguinte abaixo da div header:
			<?php echo $this->element('menutopo');//Aqui?>
Este menu mostra somente o que o usuário tem acesso, filtrando o que não tem.

## TROCAR HASH DAS SENHAS

Quando mudamos o servidor do banco o hash das senhas dos usuários não são mais reconhecidos.
Precisamos editar os usuários e trocar as senhas de cada usuário para que voltem a funcionar.

Acesse
http://localhost/posts/users
Originalmente coloquei assim:
login - admin
senha - admin
Assim também para o usuário manager com senha manager.

Edite e apenas repira admin para o admin e manager para o manager e Salve.


## Adicionar ao AppController.php:

	public $components = array(
		'Session','AccessControl',
		'Auth' => array(
		    'loginRedirect' => array('controller' => 'posts', 'action' => 'index'),
		    'logoutRedirect' => array('controller' => 'users', 'action' => 'login'),
			'loginAction'    => '/users/login',
		    'authorize' => array('Controller')
		)
	);

	public function beforeFilter(){
		$this->set('title_for_layout','Seção de Administração para o Aplicativo');
		$this->set('current_user', $this->Auth->user());

        $this->Auth->allow('index');//'add'

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


## PRONTO

Já pode testar. Acesse:
http://localhost/posts
E tente acessar os actions add ou edit, por exemplo.


## Cadastrando as Permissões

Acesse como admin e cadastre todas os actions cujo acesso deseja tornar restrito.
Observe que as permissões para os controllers Users, Groups e Privileges já estão cadastradas e todas dão acesso somente ao admin. Altere se achar por bem.
Apenas cadastre agora as permissões das tabelas do seu aplicativo, as tabelas de conteúdo:
http://localhost/posts/privileges

Atente para não esquecer nenhum privilégio. Os que esquecer ou deixar de fora irão permitir acesso sem login.

## Actions Não Cadastrados

Os actions não cadastrados mostrarão a mensagem "Privilégio não cadastrado!".
Basta que cadastre este action para o usuário manager que a mensagem desaparecerá.


## Menu de topo

Após instalar e configurar o AccessControl faça os ajustes necessário no Elements/menutopo.ctp para adicionar suas tabelas e remover as que não deseja que apareças.


## Licença

Este componente é distribuído com a mesma licença do CakePHP, que é a licença MIT.


