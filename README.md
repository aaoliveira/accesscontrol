#AccessControl component

##Goal - to control user access to the application. It controls access to each action.
The control associates the user group to the action. When I register a group with a action, the component will ensure allow access to action for all users in the group.


##Hierarchy of Privileges

The not registered actions have public access.
The group admins have full access to everything in the application.
Permissions to the users group also give permission to groups admins and managers.
Permissions for group managers also also give permission to the admins, but not to users.
Direct permission for admins group does not provide access to the other groups.

The users table must initially be empty and be registered only after the settings via the Users controller. See more frante.

##Steps:

- Create your application, but do not use tables with names: users, groups or privileges
- Import for your database the script accesscontrol.sql
- Please do a full backup of your application before continuing
- Unzip the AccessControl.zip file and copy all content into the your application app/. He brings a folder with Layout/default.php. If you want to keep your then ignore the overwrite. Exists also an element integrated into default.php layout, which shows a small menu at the page top.

##Add to AppController.php:

    public $components = array(
        'Session','AccessControl',
        'Auth' => array(// Below is my controller initial in routes
            'loginRedirect' => array('/'),
            'logoutRedirect' => array('controller' => 'users', 'action' => 'login'),
			'authorize' => array('Controller')
        )
    );

    public function beforeFilter() {
		// Assim todos os usuários terão acesso ao action de todos os controllers
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

##If you want to allow access only to the actions registereds in Privileges:
And the control is entirely made by AccessControl and not with Auth, change the beforeFilter for:

    public function beforeFilter() {
		$controller=$this->params['controller']; 
		$action=$this->params['action']; 

		$this->AccessControl->go($controller,$action); 		 
		if($this->AccessControl->redir==true){ 
			$this->redirect(array('controller' => 'users','action' => 'login')); 
		}
    }


##To allow users to register users in database so let AppController:
Temporary changes. After undo.

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


##To register the users go to:
http://localhost/posts/users/add


##Registering Permissions

Log in as admin and sign all actions whose access you want to become restricted.
Note that the permissions for users, groups, and privileges are already registered and all give access only to the admin. Change it sees fit.
Just register now permissions tables on your system that are not in the default table privileges.

http://localhost/posts/privileges/

Be careful not to forget any. Those who forget allow public access.

##Try

To test well, register the three users: admin (group admins), manager (group managers) and user (group users) or others names.

Login as 'user' and try to access all actions.
Login as 'manager' and after as 'admin' and try permissions.


##Actions Not Registered

If you receive the message 'Restricted Area', even being logged, this indicates that the current action is not registered in privileges. Log in as admin and register this.


##Sample Application
I add a package with a sample application.
Only uncompress, create a database 'blog_sample' and import the script from root.

##License - MIT

##To tips and tutorials about CakePHP access:
http://ribafs.org seção CakePHP.
