-- phpMyAdmin SQL Dump
-- version 2.11.11.3
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- Généré le : Mar 10 Octobre 2017 à 11:38
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
-- Structure de la table `account_states`
--

DROP TABLE IF EXISTS `account_states`;
CREATE TABLE IF NOT EXISTS `account_states` (
  `acc_stt_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `acc_stt_name` varchar(16) DEFAULT NULL,
  `acc_stt_aff_order` tinyint(4) NOT NULL,
  `pipedrive_id` int(10) unsigned DEFAULT NULL COMMENT 'Pipedrive organization status key: 60c1315cab5aef573d9c21863eed0aa1416d112b',
  PRIMARY KEY (`acc_stt_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Contenu de la table `account_states`
--

INSERT INTO `account_states` (`acc_stt_id`, `acc_stt_name`, `acc_stt_aff_order`, `pipedrive_id`) VALUES
(1, 'Client', 4, 15),
(2, 'Prospect', 3, 14),
(3, 'Ancien Client', 5, 16),
(4, 'Lead', 2, 13),
(5, 'Curieux', 1, 13),
(6, 'Sans intérêt', 6, 13),
(7, 'Concurrent', 7, 98);
