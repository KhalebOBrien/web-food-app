DROP DATABASE IF EXISTS `ecp`;

CREATE DATABASE IF NOT EXISTS `ecp`;

USE `ecp`;

CREATE TABLE IF NOT EXISTS `user`(
  `id` INT(5) NOT NULL AUTO_INCREMENT,
  `user_id` INT(5) NOT NULL,
  `full_name` VARCHAR(100) NOT NULL,
  `user_name` VARCHAR(100) NOT NULL,
  `password` VARCHAR(120) NOT NULL,
  `created` DATETIME NOT NULL,
  `updated` DATETIME NOT NULL,
  PRIMARY KEY(`id`)
);

CREATE TABLE IF NOT EXISTS `product_category`(
  `id` INT(5) NOT NULL AUTO_INCREMENT,
  `user_id` INT(5) NOT NULL,
  `parent_id` INT(5) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  `created` DATETIME NOT NULL,
  `updated` DATETIME NOT NULL,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`user_id`) REFERENCES user(`id`)
);

CREATE TABLE IF NOT EXISTS `brand`(
  `id` INT(5) NOT NULL AUTO_INCREMENT,
  `user_id` INT(5) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  `created` DATETIME NOT NULL,
  `updated` DATETIME NOT NULL,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`user_id`) REFERENCES user(`id`)
);

CREATE TABLE IF NOT EXISTS `product` (
  `id` INT(5) NOT NULL AUTO_INCREMENT,
  `category_id` INT(5) NOT NULL,
  `user_id` INT(5) NOT NULL,
  `brand_id` INT(5) NOT NULL,
  `stock_no` VARCHAR(10) NOT NULL,
  `name` VARCHAR(150) NOT NULL,
  `description` TEXT NULL,
  `image_url` VARCHAR(160) NOT NULL,
  `unit_price` DECIMAL(15, 2) NOT NULL,
  `shipping_fee` DECIMAL(15, 2) NOT NULL,
  `is_recommended` TINYINT(1) NOT NULL,
  `is_featured` TINYINT(1) NOT NULL,
  `created` DATETIME NOT NULL,
  `updated` DATETIME NOT NULL,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`category_id`) REFERENCES product_category(`id`),
  FOREIGN KEY(`user_id`) REFERENCES user(`id`),
  FOREIGN KEY(`brand_id`) REFERENCES brand(`id`)
);

CREATE TABLE IF NOT EXISTS `customer`(
  `id` INT(5) NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `phone_no` VARCHAR(14) NOT NULL,
  `created` DATETIME NOT NULL,
  `updated` DATETIME NOT NULL,
  PRIMARY KEY(`id`)
);

CREATE TABLE IF NOT EXISTS `wishlist`(
  `id` INT(5) NOT NULL AUTO_INCREMENT,
  `customer_id` INT(5) NOT NULL,
  `product_id` INT(5) NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`customer_id`) REFERENCES customer(`id`),
  FOREIGN KEY(`product_id`) REFERENCES product(`id`)
);

CREATE TABLE IF NOT EXISTS `state` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `billing_detail`(
  `id` INT(5) NOT NULL AUTO_INCREMENT,
  `state_id` INT(5) NOT NULL,
  `company_name` VARCHAR(100) NULL,
  `email` VARCHAR(50) NOT NULL,
  `title` VARCHAR(50) NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `middle_name` VARCHAR(50) NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `address` VARCHAR(100) NULL,
  `phone_no` VARCHAR(20) NOT NULL,
  `fax` VARCHAR(20) NULL,
  `special_note` VARCHAR(200) NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`state_id`) REFERENCES state(`id`)
);

CREATE TABLE IF NOT EXISTS `invoice` (
  `id` INT(5) NOT NULL AUTO_INCREMENT,
  `billing_id` INT(5) NOT NULL,
  `customer_id` INT(5) NOT NULL default '0',
  `invoice_no` VARCHAR(10),
  `total_items` INT(5),
  `total_amount` DECIMAL(15, 2),
  `shipping_fee` DECIMAL(15, 2) NOT NULL,
  `payment_type` VARCHAR(30),
  `date` DATETIME NOT NULL,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`billing_id`) REFERENCES billing_detail(`id`)
);

CREATE TABLE IF NOT EXISTS `invoice_detail` (
  `id` INT(5) NOT NULL AUTO_INCREMENT,
  `invoice_id` INT(5) NOT NULL,
  `product_id` INT(5) NOT NULL,
  `quantity` INT(5),
  `total_amount` DECIMAL(15, 2),
  `shipping_fee` DECIMAL(15, 2) NOT NULL,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`invoice_id`) REFERENCES invoice(`id`),
  FOREIGN KEY(`product_id`) REFERENCES product(`id`)
);

CREATE TABLE IF NOT EXISTS `shopping_cart` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `product_id` int(5) NOT NULL,
  `session_id` varchar(100) NOT NULL,
  `quantity` int(5) NOT NULL,
  `unit_price` decimal(15,2) NOT NULL,
  `shipping_fee` DECIMAL(15, 2) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  FOREIGN KEY(`product_id`) REFERENCES product(`id`)
);

--
-- Dumping data for table `state`
--

INSERT INTO `state` (`id`, `name`) VALUES
(1, 'Main gate security post'),
(2, 'Back gate security post'),
(3, 'Hospital'),
(4, 'Secondary school premises'),
(5, 'Faculty of Basic Medical Science'),
(6, 'Faculty of Humanities and social sciences'),
(7, 'Faculty of Law'),
(8, 'Faculty of Natural and applied science'),
(9, 'Main Male hostel'),
(10, 'Main Female Hostel'),
(11, 'Male Staff Quarters'),
(12, 'Female Staff Quarters');

INSERT INTO `user` VALUE(NULL, 1, 'GodsPower', 'admin', 'admin', NOW(), NOW());
