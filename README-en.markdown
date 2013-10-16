# Componente AccessControl for CakePHP

Goal - to control user access to application. It controls access to each action of each controller.
The setting are recorded in a table. 

## Requirements

Dont use table names with: users, groups or privileges. If you already have tables with this names, you need to make adaptations.

## Steps:
- Make download from:
	https://github.com/ribafs/accesscontrol
- Make download and uncompress
- Import for your database the script accesscontrol.sql, which contains the tables users, groups, and privileges
- If your application is not an application of tests, it is recommended a complete backup of your application (all files and all the bank) before continuing
- Unzip the file AccessControl.zip and copy all your folders to folder app/ from your application. The folder View Layout brings a folder with a default.php. It is useful to integrate the Element/menu with your layout, if you do not overwrite your default.php. Here also an element integrated into default.php layout, which shows a small menu at the top. To integrate into your layout add the following line below the header div:
			<?php echo $this->element('menutopo');//Here?>
This menu shows only what the user has access, filtering out what does not.


## Add to AppController.php:

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
		$this->set('title_for_layout','Admin Section to Cake Application');
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


## READY

Now you can test. go to:
http://localhost/posts
And try to access add or edit actions, for example.


## CHANGE PAASSOWR HASHS

When we change the database server the hash of the passwords from users are no longer recognized.
We need to edit the passwords for each user so that they return to work.
Comment all content of the AppController.php to continue.

Access
http://localhost/posts/users

Edit the admin password and the manager password. Only repira admin for the admin user and manager to manager user and Save.

Uncomment the AppController and continue.


## Registering Permissions

Log in as admin and register all actions whose access you want to become restricted.
Note that the permissions for the controllers Users, Groups and Privileges are already registered and all give access only to the admin. Change it sees fit.
Just register now permissions of your application tables, tables of contents:
http://localhost/posts/privileges

Be careful not to overlook any privilege. Those who forget or leave out will allow access without login.

## Actions not Registereds

The actions that are not registered will show the message "Privilege not registered".
Just register this action to the user manager that the message will disappear.

## Top Menu

After installing and configuring the AccessControl make the adjustments necessary in Elements/menutopo.ctp to add your tables and remove those that do not want you to appear.

## License

This component is distributed under the same CakePHP license, which is the MIT license.


