-- phpMyAdmin SQL Dump
-- version 2.11.11.3
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- Généré le : Mar 10 Octobre 2017 à 11:39
-- Version du serveur: 5.6.15
-- Version de PHP: 5.3.29

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `geops`
--

-- --------------------------------------------------------

--
-- Structure de la table `account_products`
--

DROP TABLE IF EXISTS `account_products`;
CREATE TABLE IF NOT EXISTS `account_products` (
  `prod_id` int(11) NOT NULL AUTO_INCREMENT,
  `acc_id` int(11) NOT NULL,
  `prod_name` varchar(32) NOT NULL,
  `prod_cre_dts` datetime NOT NULL,
  `prod_cre_usr` varchar(32) NOT NULL,
  `prod_upd_dts` datetime NOT NULL,
  `prod_upd_usr` varchar(32) NOT NULL,
  PRIMARY KEY (`prod_id`),
  KEY `acc_id` (`acc_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=72 ;

--
-- Contenu de la table `account_products`
--

INSERT INTO `account_products` (`prod_id`, `acc_id`, `prod_name`, `prod_cre_dts`, `prod_cre_usr`, `prod_upd_dts`, `prod_upd_usr`) VALUES
(1, 41, 'MAA', '2015-01-27 17:16:49', 'Amaury', '0000-00-00 00:00:00', ''),
(2, 41, 'MSP', '2015-01-27 17:16:53', 'Amaury', '0000-00-00 00:00:00', ''),
(3, 5, 'GTP', '2015-01-27 17:50:20', 'Levana', '2015-01-27 17:50:41', 'Levana'),
(4, 5, 'ACCES', '2015-01-27 17:50:27', 'Levana', '0000-00-00 00:00:00', ''),
(5, 5, 'SIRH', '2015-01-27 17:51:23', 'Levana', '0000-00-00 00:00:00', ''),
(7, 1235, 'produit_1', '2015-02-03 15:13:04', 'yoann', '0000-00-00 00:00:00', ''),
(8, 3270, 'Agence évènementielle', '2015-10-29 12:35:26', 'Pierre', '0000-00-00 00:00:00', ''),
(9, 38, 'Relieur', '2015-12-10 11:09:21', 'Levana', '0000-00-00 00:00:00', ''),
(10, 24, 'MG', '2015-12-10 11:12:46', 'Levana', '0000-00-00 00:00:00', ''),
(11, 24, 'EMBA', '2015-12-10 11:12:54', 'Levana', '2015-12-10 15:55:53', 'Levana'),
(12, 24, 'FC', '2015-12-10 11:13:06', 'Levana', '0000-00-00 00:00:00', ''),
(13, 24, 'FINANCE', '2015-12-10 11:13:55', 'Levana', '0000-00-00 00:00:00', ''),
(14, 24, 'RH', '2015-12-10 11:14:20', 'Levana', '0000-00-00 00:00:00', ''),
(15, 75, 'Espace TPE', '2015-12-10 12:06:09', 'Levana', '0000-00-00 00:00:00', ''),
(16, 75, 'LB', '2015-12-10 12:06:17', 'Levana', '0000-00-00 00:00:00', ''),
(17, 75, 'Data', '2015-12-10 12:11:44', 'Levana', '0000-00-00 00:00:00', ''),
(18, 75, 'LeadGen', '2015-12-10 12:11:53', 'Levana', '0000-00-00 00:00:00', ''),
(19, 52, 'COMPTA', '2015-12-10 12:23:23', 'Levana', '0000-00-00 00:00:00', ''),
(20, 52, 'GESCO', '2015-12-10 12:23:31', 'Levana', '0000-00-00 00:00:00', ''),
(21, 52, 'ONLINE', '2015-12-10 12:23:38', 'Levana', '0000-00-00 00:00:00', ''),
(22, 52, 'PAIE', '2015-12-10 12:23:47', 'Levana', '0000-00-00 00:00:00', ''),
(23, 52, 'TRESO', '2015-12-10 12:23:58', 'Levana', '0000-00-00 00:00:00', ''),
(24, 52, 'GPAO', '2015-12-10 12:24:06', 'Levana', '0000-00-00 00:00:00', ''),
(25, 443, 'DUA', '2015-12-10 15:50:08', 'Levana', '0000-00-00 00:00:00', ''),
(26, 443, 'AMP', '2015-12-10 15:50:14', 'Levana', '0000-00-00 00:00:00', ''),
(27, 443, 'EMBA', '2015-12-10 15:50:53', 'Levana', '0000-00-00 00:00:00', ''),
(28, 443, 'PGM', '2015-12-10 15:51:01', 'Levana', '0000-00-00 00:00:00', ''),
(29, 443, 'Divers', '2015-12-10 15:51:23', 'Levana', '0000-00-00 00:00:00', ''),
(30, 488, 'AMP', '2015-12-10 15:52:38', 'Levana', '0000-00-00 00:00:00', ''),
(31, 488, 'EMBA', '2015-12-10 15:53:12', 'Levana', '0000-00-00 00:00:00', ''),
(32, 488, 'ELEARNING', '2015-12-10 15:53:29', 'Levana', '0000-00-00 00:00:00', ''),
(33, 488, 'DIVERS', '2015-12-10 15:53:40', 'Levana', '0000-00-00 00:00:00', ''),
(34, 24, 'MKT', '2015-12-10 15:56:03', 'Levana', '2016-06-06 08:14:06', 'Virginie'),
(35, 24, 'DIVERS', '2015-12-10 15:56:37', 'Levana', '0000-00-00 00:00:00', ''),
(36, 52, 'ERP', '2015-12-10 15:58:12', 'Levana', '0000-00-00 00:00:00', ''),
(37, 52, 'CRM', '2015-12-10 15:58:19', 'Levana', '0000-00-00 00:00:00', ''),
(38, 443, 'FC', '2015-12-10 16:25:44', 'Laurence', '0000-00-00 00:00:00', ''),
(39, 488, 'CSM', '2016-01-29 12:46:56', 'Levana', '0000-00-00 00:00:00', ''),
(40, 41, 'NEOTOUCH', '2016-02-26 12:17:38', 'Laurence', '0000-00-00 00:00:00', ''),
(41, 921, 'CPA', '2016-02-26 16:49:32', 'Laurence', '0000-00-00 00:00:00', ''),
(42, 921, 'Parcours', '2016-02-26 16:49:39', 'Laurence', '0000-00-00 00:00:00', ''),
(43, 24, 'MMI', '2016-03-07 10:36:37', 'Laurence', '0000-00-00 00:00:00', ''),
(44, 2471, 'PAIE', '2016-04-07 12:44:57', 'Virginie', '0000-00-00 00:00:00', ''),
(45, 2471, 'TRY', '2016-04-07 12:46:08', 'Virginie', '0000-00-00 00:00:00', ''),
(46, 2471, 'GLOBAL', '2016-04-11 09:36:23', 'Virginie', '0000-00-00 00:00:00', ''),
(47, 24, 'NEGO', '2016-04-22 11:09:58', 'Virginie', '0000-00-00 00:00:00', ''),
(48, 24, 'MSI', '2016-05-20 09:15:35', 'Virginie', '0000-00-00 00:00:00', ''),
(49, 24, 'MOP', '2016-05-20 09:20:12', 'Virginie', '0000-00-00 00:00:00', ''),
(50, 488, 'GMAP', '2016-06-02 11:50:48', 'Laurence', '0000-00-00 00:00:00', ''),
(51, 24, 'SMIB', '2016-06-06 08:13:57', 'Virginie', '0000-00-00 00:00:00', ''),
(52, 24, 'SMIS', '2016-06-06 08:22:39', 'Virginie', '0000-00-00 00:00:00', ''),
(53, 47, 'CATALOGUE', '2016-06-06 11:50:02', 'Laurence', '0000-00-00 00:00:00', ''),
(54, 47, 'PLATEFORME', '2016-06-06 11:50:12', 'Laurence', '0000-00-00 00:00:00', ''),
(55, 2471, 'TPE PME', '2016-06-15 12:43:18', 'Laurence', '0000-00-00 00:00:00', ''),
(56, 2471, 'INFOGRAPHIE', '2016-06-15 12:46:12', 'Laurence', '0000-00-00 00:00:00', ''),
(57, 52, 'GEIDE', '2016-10-10 08:52:21', 'Virginie', '0000-00-00 00:00:00', ''),
(58, 52, 'SUMMIT', '2016-10-31 12:03:31', 'Sonia', '0000-00-00 00:00:00', ''),
(59, 2471, 'X3', '2016-11-04 12:21:02', 'Virginie', '0000-00-00 00:00:00', ''),
(60, 24, 'MGO', '2016-12-02 11:48:54', 'Virginie', '0000-00-00 00:00:00', ''),
(61, 47, 'SITE', '2016-12-20 12:28:57', 'Virginie', '0000-00-00 00:00:00', ''),
(62, 52, '100', '2017-01-23 09:00:23', 'Virginie', '0000-00-00 00:00:00', ''),
(63, 75, '3D', '2017-01-25 13:18:08', 'Levana', '0000-00-00 00:00:00', ''),
(64, 75, 'ETrack', '2017-01-25 13:18:39', 'Levana', '0000-00-00 00:00:00', ''),
(65, 75, 'EAutomate', '2017-01-25 13:18:54', 'Levana', '0000-00-00 00:00:00', ''),
(66, 75, 'Event', '2017-03-20 17:05:30', 'Sonia', '2017-04-06 14:43:22', 'Virginie'),
(67, 52, 'PEOPLE', '2017-04-06 10:55:22', 'Sonia', '0000-00-00 00:00:00', ''),
(68, 24, 'MGH', '2017-06-01 14:29:12', 'Virginie', '0000-00-00 00:00:00', ''),
(69, 52, '50C', '2017-07-10 14:09:42', 'Sonia', '0000-00-00 00:00:00', ''),
(70, 4706, 'GTP', '2017-09-04 10:52:16', 'Laurence', '0000-00-00 00:00:00', ''),
(71, 75, 'Belgique', '2017-09-28 12:29:43', 'Levana', '0000-00-00 00:00:00', '');