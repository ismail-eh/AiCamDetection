-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 02 juin 2025 à 14:24
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `detection_camera`
--

-- --------------------------------------------------------

--
-- Structure de la table `alerts`
--

CREATE TABLE `alerts` (
  `id_Alert` int(11) NOT NULL,
  `type` enum('offline','blurry') NOT NULL,
  `id_Camera` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `alerts_history`
--

CREATE TABLE `alerts_history` (
  `id_User` int(11) NOT NULL,
  `id_Camera` int(11) NOT NULL,
  `id_Alert` int(11) NOT NULL,
  `start_alert` datetime NOT NULL,
  `performed_at` datetime NOT NULL,
  `alert_id` int(11) NOT NULL,
  `camera_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `camera`
--

CREATE TABLE `camera` (
  `id_Camera` int(11) NOT NULL,
  `nom_camera` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `ip_adress` varchar(255) DEFAULT NULL,
  `mac_adress` varchar(255) DEFAULT NULL,
  `Status_Camera` enum('normal','offline','blurry') NOT NULL,
  `id_User` int(11) NOT NULL,
  `id_Groupe` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `camera`
--

INSERT INTO `camera` (`id_Camera`, `nom_camera`, `location`, `ip_adress`, `mac_adress`, `Status_Camera`, `id_User`, `id_Groupe`) VALUES
(13, 'Caméra Hall', 'Hall d\'entrée', '192.168.1.10', '00:1A:2B:3C:4D:AA', 'normal', 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `groupe`
--

CREATE TABLE `groupe` (
  `id_Groupe` int(11) NOT NULL,
  `nom_groupe` varchar(255) NOT NULL,
  `id_User` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `groupe`
--

INSERT INTO `groupe` (`id_Groupe`, `nom_groupe`, `id_User`) VALUES
(1, 'Groupe Principal', 1);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id_User` int(11) NOT NULL,
  `nom_user` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id_User`, `nom_user`, `password`) VALUES
(1, 'admin', 'admin123'),
(2, 'admin', 'admin123');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `alerts`
--
ALTER TABLE `alerts`
  ADD PRIMARY KEY (`id_Alert`),
  ADD KEY `id_Camera` (`id_Camera`);

--
-- Index pour la table `alerts_history`
--
ALTER TABLE `alerts_history`
  ADD PRIMARY KEY (`id_User`,`id_Camera`,`id_Alert`),
  ADD KEY `id_Camera` (`id_Camera`),
  ADD KEY `id_Alert` (`id_Alert`);

--
-- Index pour la table `camera`
--
ALTER TABLE `camera`
  ADD PRIMARY KEY (`id_Camera`),
  ADD KEY `id_User` (`id_User`),
  ADD KEY `id_Groupe` (`id_Groupe`);

--
-- Index pour la table `groupe`
--
ALTER TABLE `groupe`
  ADD PRIMARY KEY (`id_Groupe`),
  ADD KEY `id_User` (`id_User`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_User`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `alerts`
--
ALTER TABLE `alerts`
  MODIFY `id_Alert` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `camera`
--
ALTER TABLE `camera`
  MODIFY `id_Camera` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `groupe`
--
ALTER TABLE `groupe`
  MODIFY `id_Groupe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id_User` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `alerts`
--
ALTER TABLE `alerts`
  ADD CONSTRAINT `alerts_ibfk_1` FOREIGN KEY (`id_Camera`) REFERENCES `camera` (`id_Camera`);

--
-- Contraintes pour la table `alerts_history`
--
ALTER TABLE `alerts_history`
  ADD CONSTRAINT `alerts_history_ibfk_1` FOREIGN KEY (`id_User`) REFERENCES `user` (`id_User`),
  ADD CONSTRAINT `alerts_history_ibfk_2` FOREIGN KEY (`id_Camera`) REFERENCES `camera` (`id_Camera`),
  ADD CONSTRAINT `alerts_history_ibfk_3` FOREIGN KEY (`id_Alert`) REFERENCES `alerts` (`id_Alert`);

--
-- Contraintes pour la table `camera`
--
ALTER TABLE `camera`
  ADD CONSTRAINT `camera_ibfk_1` FOREIGN KEY (`id_User`) REFERENCES `user` (`id_User`),
  ADD CONSTRAINT `camera_ibfk_2` FOREIGN KEY (`id_Groupe`) REFERENCES `groupe` (`id_Groupe`);

--
-- Contraintes pour la table `groupe`
--
ALTER TABLE `groupe`
  ADD CONSTRAINT `groupe_ibfk_1` FOREIGN KEY (`id_User`) REFERENCES `user` (`id_User`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
