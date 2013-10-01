CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

INSERT INTO `groups` (`id`, `name`, `created`, `modified`) VALUES
(1, 'admins', '2013-06-22 17:05:29', '2013-06-22 17:05:29'),
(2, 'managers', '2013-06-23 10:57:28', '2013-06-23 10:57:28'),
(3, 'users', '2013-06-24 07:47:48', '2013-06-24 07:47:48');


CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` char(40) NOT NULL,
  `group_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4;

INSERT INTO `users` (`id`, `username`, `password`, `group_id`, `created`, `modified`) VALUES
(1, 'admin', '0a23209291207b4bca7aa7d2072ad5897a8b736e', 1, '2013-08-29 18:25:22', '2013-08-30 09:41:42'),
(2, 'manager', '298448e4963254818e8111b8853eaaaeb2996dc8', 2, '2013-08-29 18:25:32', '2013-08-30 09:41:52'),
(3, 'user', '210ffe2550ce6e65cd48b5a0af36d3f6cdd6efa4', 3, '2013-08-29 18:25:41', '2013-08-30 09:42:03');

CREATE TABLE IF NOT EXISTS `privileges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` char(11) NOT NULL,
  `controller` varchar(50) NOT NULL,
  `action` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `controller` (`controller`,`action`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

INSERT INTO `privileges` (`id`, `group_name`, `controller`, `action`) VALUES
(1, 'admins', 'privileges', 'add'),
(2, 'admins', 'privileges', 'edit'),
(3, 'admins', 'privileges', 'delete'),
(4, 'admins', 'privileges', 'view'),
(5, 'admins', 'privileges', 'index'),
(6, 'admins', 'users', 'add'),
(7, 'admins', 'users', 'edit'),
(8, 'admins', 'users', 'delete'),
(9, 'admins', 'users', 'view'),
(10, 'admins', 'users', 'index'),
(11, 'admins', 'groups', 'add'),
(12, 'admins', 'groups', 'edit'),
(13, 'admins', 'groups', 'delete'),
(14, 'admins', 'groups', 'view'),
(15, 'admins', 'groups', 'index');

