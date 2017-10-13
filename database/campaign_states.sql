-- phpMyAdmin SQL Dump
-- version 2.11.11.3
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- Généré le : Mar 10 Octobre 2017 à 11:41
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
-- Structure de la table `campaign_states`
--

CREATE TABLE IF NOT EXISTS `campaign_states` (
  `camp_stt_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `camp_stt_wf_act` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `camp_stt_wf_name` varchar(64) DEFAULT NULL,
  `camp_stt_name` varchar(32) NOT NULL DEFAULT '',
  `camp_stt_desc` text,
  `camp_stt_cre_dts` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `camp_stt_cre_usr` varchar(32) NOT NULL DEFAULT '',
  `camp_stt_upd_dts` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `camp_stt_upd_usr` varchar(32) DEFAULT NULL,
  `camp_stt_del_dts` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `camp_stt_del_usr` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`camp_stt_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Contenu de la table `campaign_states`
--

INSERT INTO `campaign_states` (`camp_stt_id`, `camp_stt_wf_act`, `camp_stt_wf_name`, `camp_stt_name`, `camp_stt_desc`, `camp_stt_cre_dts`, `camp_stt_cre_usr`, `camp_stt_upd_dts`, `camp_stt_upd_usr`, `camp_stt_del_dts`, `camp_stt_del_usr`) VALUES
(1, 1, 'Création', 'Commandée', NULL, '2006-07-19 16:11:31', 'Systeme', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL),
(2, 1, 'Suspension', 'Suspendue', NULL, '2006-07-19 16:11:31', 'Systeme', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL),
(3, 1, 'Plannification', 'Plannifiée', NULL, '2006-07-19 16:11:31', 'Systeme', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL),
(4, 1, 'Préparation', 'Préparée', NULL, '2006-07-19 16:11:31', 'Systeme', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL),
(5, 1, 'Validation', 'BAT', NULL, '2006-07-19 16:11:31', 'Systeme', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL),
(6, 1, 'Déploiement', 'En ligne', NULL, '2006-07-19 16:11:31', 'Système', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL),
(7, 1, 'Clôture', 'Cloturée', NULL, '2006-07-19 16:11:31', 'Systeme', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL),
(8, 0, NULL, 'Archivée', NULL, '2006-07-19 15:54:42', 'Système', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL),
(9, 0, NULL, 'Annulée', NULL, '2006-07-19 15:54:42', 'Systeme', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL);
