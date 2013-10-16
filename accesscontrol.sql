CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Extraindo dados da tabela `groups`
--

INSERT INTO `groups` (`id`, `name`, `created`, `modified`) VALUES
(1, 'admins', '2013-06-22 17:05:29', '2013-06-22 17:05:29'),
(2, 'managers', '2013-06-23 10:57:28', '2013-06-23 10:57:28'),
(3, 'users', '2013-06-24 07:47:48', '2013-06-24 07:47:48');

-- --------------------------------------------------------

--
-- Estrutura da tabela `privileges`
--

CREATE TABLE IF NOT EXISTS `privileges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` char(11) NOT NULL,
  `controller` varchar(50) NOT NULL,
  `action` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `controller` (`controller`,`action`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- Extraindo dados da tabela `privileges`
--

INSERT INTO `privileges` (`id`, `group_name`, `controller`, `action`) VALUES
(1, 'admins', 'privileges', 'add'),
(2, 'admins', 'privileges', 'edit'),
(3, 'admins', 'privileges', 'delete'),
(4, 'admins', 'privileges', 'view'),
(5, 'admins', 'privileges', 'index'),
(11, 'admins', 'groups', 'add'),
(12, 'admins', 'groups', 'edit'),
(13, 'admins', 'groups', 'delete'),
(14, 'admins', 'groups', 'view'),
(15, 'admins', 'groups', 'index'),
(18, 'admins', 'users', 'index'),
(19, 'admins', 'users', 'view'),
(20, 'admins', 'users', 'add'),
(21, 'admins', 'users', 'edit'),
(22, 'admins', 'users', 'delete'),
(23, 'managers', 'clientes', 'add'),
(24, 'managers', 'clientes', 'index');

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` char(40) NOT NULL,
  `group_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `group_id`, `created`, `modified`) VALUES
(1, 'admin', 'bd62c7c1e4f76ea4152077c3e87e8dcb25ea23a4', 1, '2013-08-29 18:25:22', '2013-10-15 12:31:10'),
(2, 'manager', '594de6d9ff3071c251e8d04401c7a2b246de1768', 2, '2013-08-29 18:25:32', '2013-10-15 12:31:17');

