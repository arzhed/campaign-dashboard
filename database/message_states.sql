-- phpMyAdmin SQL Dump
-- version 2.11.11.3
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- Généré le : Mar 10 Octobre 2017 à 11:40
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
-- Structure de la table `message_states`
--

CREATE TABLE IF NOT EXISTS `message_states` (
  `msg_stt_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `msg_stt_wf_act` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `msg_stt_wf_name` varchar(64) DEFAULT NULL,
  `msg_stt_name` varchar(32) NOT NULL DEFAULT '',
  `msg_stt_desc` text,
  `msg_stt_cre_dts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `msg_stt_cre_usr` varchar(32) NOT NULL DEFAULT '',
  `msg_stt_upd_dts` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `msg_stt_upd_usr` varchar(32) DEFAULT NULL,
  `msg_stt_del_dts` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `msg_stt_del_usr` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`msg_stt_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Contenu de la table `message_states`
--

INSERT INTO `message_states` (`msg_stt_id`, `msg_stt_wf_act`, `msg_stt_wf_name`, `msg_stt_name`, `msg_stt_desc`, `msg_stt_cre_dts`, `msg_stt_cre_usr`, `msg_stt_upd_dts`, `msg_stt_upd_usr`, `msg_stt_del_dts`, `msg_stt_del_usr`) VALUES
(1, 1, 'Création', 'Commandé', NULL, '2006-07-20 10:46:11', 'Systeme', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL),
(3, 1, 'Plannification', 'Plannifié', NULL, '2006-07-19 16:09:59', 'Systeme', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL),
(4, 1, 'Préparation', 'Préparé', NULL, '2006-07-19 16:09:59', 'Systeme', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL),
(5, 1, 'Forcer validation client', 'Validation en cours', NULL, '2006-10-16 17:37:31', 'Systeme', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL),
(6, 1, 'Validation', 'BAT', NULL, '2006-07-19 16:09:59', 'Systeme', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL),
(7, 1, 'Déploiement', 'En ligne', NULL, '2006-07-19 16:09:59', 'Systeme', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL),
(2, 1, 'Suspension', 'Suspendue', NULL, '2006-07-19 16:09:59', 'Systeme', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL),
(8, 1, 'Clôture', 'Clôturé', NULL, '2006-07-19 16:10:13', 'Systeme', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL),
(9, 0, 'Archivage', 'Archivé', NULL, '2010-10-12 19:31:29', 'Systeme', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL),
(10, 0, 'Annulation', 'Annulé', NULL, '2010-10-12 19:31:29', 'Systeme', '0000-00-00 00:00:00', NULL, '0000-00-00 00:00:00', NULL);
