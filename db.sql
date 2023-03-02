-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 06, 2022 at 11:21 AM
-- Server version: 8.0.24
-- PHP Version: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `faq_api`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `strength` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `title`, `strength`, `created_at`, `updated_at`) VALUES
(23, 'Приемная комиссия', 10, '2022-06-06 04:33:35', '2022-06-06 04:33:35'),
(24, 'Очное отделение', 9, '2022-06-06 04:33:51', '2022-06-06 04:33:51'),
(25, 'Заочное отделение', 8, '2022-06-06 04:33:58', '2022-06-06 04:33:58'),
(26, 'Личный кабинет', 7, '2022-06-06 04:34:09', '2022-06-06 04:34:09'),
(27, 'Общежитие', 6, '2022-06-06 04:34:38', '2022-06-06 04:34:38'),
(29, 'Сайт колледжа', 5, '2022-06-06 05:18:00', '2022-06-06 05:18:00');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2022_05_23_144103_create_categories_table', 1),
(4, '2022_05_23_144104_create_questions_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` bigint UNSIGNED NOT NULL,
  `category_id` bigint UNSIGNED DEFAULT NULL,
  `question_text` longtext NOT NULL,
  `answer_text` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `sender_info` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `like_count` int DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `category_id`, `question_text`, `answer_text`, `sender_info`, `like_count`, `status`, `created_at`, `updated_at`) VALUES
(18, 23, 'Какие документы необходимы для поступления?', 'Документ об образовании, медицинская справка формы 086-у с заключением о профессиональной пригодности (только для поступающих на специальность «Монтаж и техническая эксплуатация промышленного оборудования»), 4 фотографий размером 3х4 см. Поступающий дополнительно может предоставить медицинскую карту из школы и копию сертификата прививок для формирования групп с уменьшенной нагрузкой и нормами на занятиях по физической культуре.', 'ФИО: Илья; E-mail: Ilya@yandex.ru', 0, 1, '2022-06-06 04:35:30', '2022-06-06 04:37:01'),
(19, 24, 'Какой период для подачи документов?', 'С 14 июня до 15 августа. При наличии свободных мест в колледже прием документов продлевается до 1 декабря текущего года.', 'ФИО: Антон; E-mail: Anton@yandex.ru', 0, 1, '2022-06-06 04:38:20', '2022-06-06 04:39:01'),
(20, 24, 'На каком языке ведется обучение?', 'Обучение ведется на русском языке.', 'ФИО: Владислав; E-mail: Vladislav@yandex.ru', 0, 1, '2022-06-06 04:41:25', '2022-06-06 04:41:36'),
(21, 23, 'В какое время можно обратиться в приемную комиссию?', 'Время работы приемной комиссии: понедельник – пятница: с 09:00 до 17:00, обеденный перерыв с 12:00 до 13:00', 'ФИО: Сергей; E-mail: Sergey@yandex.ru', 0, 1, '2022-06-06 04:42:24', '2022-06-06 04:43:28'),
(22, 27, 'Сколько мест в общежитии?', 'Общежитие колледжа представляет из себя 4-х этажное здание коридорного типа, рассчитанное на проживание 120 человек.', 'ФИО: Егор; E-mail: Egor@yandex.ru', 0, 1, '2022-06-06 04:44:17', '2022-06-06 04:44:38');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `questions_category_id_index` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
