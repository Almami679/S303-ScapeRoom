-- MySQL Workbench Synchronization
-- Generated: 2024-12-18 10:38
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Pau

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `mydb`.`EscapeRoom` (
  `EscapeRoom_id` INT(11) NOT NULL AUTO_INCREMENT,
  `EscapeRoom_name` VARCHAR(45) NULL DEFAULT NULL,
  `EscapeRoom_price` DOUBLE NULL DEFAULT NULL,
  `EscapeRoom_theme` VARCHAR(45) NULL DEFAULT NULL,
  `EscapeRoom_deleted` TINYINT(4) NULL DEFAULT NULL,
  `EscapeRoom_createdAt` TIMESTAMP NULL DEFAULT NULL,
  `EscapeRoom_updatedAt` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`EscapeRoom_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Room` (
  `Room_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Room_name` VARCHAR(45) NULL DEFAULT NULL,
  `Room_difficulty` VARCHAR(45) NULL DEFAULT NULL,
  `Room_price` DOUBLE NULL DEFAULT NULL,
  `Room_escapeRoomId` INT(11) NULL DEFAULT NULL,
  `Room_deleted` TINYINT(4) NULL DEFAULT NULL,
  `Room_createdAt` TIMESTAMP NULL DEFAULT NULL,
  `Room_updatedAt` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`Room_id`),
  INDEX `fk_room_escaperoom_idx` (`Room_escapeRoomId` ASC) VISIBLE,
  CONSTRAINT `fk_room_escaperoom`
    FOREIGN KEY (`Room_escapeRoomId`)
    REFERENCES `mydb`.`EscapeRoom` (`EscapeRoom_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Tips` (
  `Tips_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Tips_text` TEXT NULL DEFAULT NULL,
  `Tips_Room_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`Tips_id`),
  INDEX `fk_rooms_tips_idx` (`Tips_Room_id` ASC) VISIBLE,
  CONSTRAINT `fk_rooms_tips`
    FOREIGN KEY (`Tips_Room_id`)
    REFERENCES `mydb`.`Room` (`Room_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`ObjectDeco` (
  `ObjectDeco_id` INT(11) NOT NULL AUTO_INCREMENT,
  `ObjectDeco_name` VARCHAR(45) NULL DEFAULT NULL,
  `ObjectDeco_material` VARCHAR(100) NULL DEFAULT NULL,
  `ObjectDeco_roomId` INT(11) NULL DEFAULT NULL,
  `ObjectDeco_price` DOUBLE NULL DEFAULT NULL,
  `ObjectDeco_delete` TINYINT(4) NULL DEFAULT NULL,
  `ObjectDeco_createdAt` TIMESTAMP NULL DEFAULT NULL,
  `ObjectDeco_updatedAt` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`ObjectDeco_id`),
  INDEX `fk_room_objectdeco_idx` (`ObjectDeco_roomId` ASC) VISIBLE,
  CONSTRAINT `fk_room_objectdeco`
    FOREIGN KEY (`ObjectDeco_roomId`)
    REFERENCES `mydb`.`Room` (`Room_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Game` (
  `Game_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Game_date` TIMESTAMP NULL DEFAULT NULL,
  `Game_escapeRoomId` INT(11) NULL DEFAULT NULL,
  `Game_delete` TINYINT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`Game_id`),
  INDEX `fk_escapeRoom_game_idx` (`Game_escapeRoomId` ASC) VISIBLE,
  CONSTRAINT `fk_escapeRoom_game`
    FOREIGN KEY (`Game_escapeRoomId`)
    REFERENCES `mydb`.`EscapeRoom` (`EscapeRoom_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`gameHasPlayer` (
  `gameHasPlayer_gameId` INT(11) NOT NULL,
  `gameHasPlayer_playerId` INT(11) NOT NULL,
  INDEX `fk_game_gameHasPlayer_idx` (`gameHasPlayer_gameId` ASC) VISIBLE,
  INDEX `fk_player_gameHasPlayer_idx` (`gameHasPlayer_playerId` ASC) VISIBLE,
  PRIMARY KEY (`gameHasPlayer_gameId`, `gameHasPlayer_playerId`),
  CONSTRAINT `fk_game_gameHasPlayer`
    FOREIGN KEY (`gameHasPlayer_gameId`)
    REFERENCES `mydb`.`Game` (`Game_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_player_gameHasPlayer`
    FOREIGN KEY (`gameHasPlayer_playerId`)
    REFERENCES `mydb`.`Player` (`Player_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Player` (
  `Player_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Player_name` VARCHAR(45) NULL DEFAULT NULL,
  `Player_email` VARCHAR(100) NULL DEFAULT NULL,
  `Player_consentNotif` TINYINT(4) NULL DEFAULT NULL,
  `Player_delete` TINYINT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`Player_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Sale` (
  `Sale_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Sale_date` TIMESTAMP NULL DEFAULT NULL,
  `Sale_price` DOUBLE NULL DEFAULT NULL,
  `Sale_gameId` INT(11) NULL DEFAULT NULL,
  `Sale_delete` TINYINT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`Sale_id`),
  INDEX `fk_game_sale_idx` (`Sale_gameId` ASC) VISIBLE,
  CONSTRAINT `fk_game_sale`
    FOREIGN KEY (`Sale_gameId`)
    REFERENCES `mydb`.`Game` (`Game_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Ticket` (
  `Ticket_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Ticket_saleId` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`Ticket_id`),
  INDEX `fk_sale_ticket_idx` (`Ticket_saleId` ASC) VISIBLE,
  CONSTRAINT `fk_sale_ticket`
    FOREIGN KEY (`Ticket_saleId`)
    REFERENCES `mydb`.`Sale` (`Sale_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Certificate` (
  `Certificate_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Certificate_gameId` INT(11) NULL DEFAULT NULL,
  `Certificate_text` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`Certificate_id`),
  INDEX `fk_game_certificate_idx` (`Certificate_gameId` ASC) VISIBLE,
  CONSTRAINT `fk_game_certificate`
    FOREIGN KEY (`Certificate_gameId`)
    REFERENCES `mydb`.`Game` (`Game_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Gift` (
  `Gift_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Gift_gameId` INT(11) NULL DEFAULT NULL,
  `Gift_text` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`Gift_id`),
  INDEX `fk_game_gift_idx` (`Gift_gameId` ASC) VISIBLE,
  CONSTRAINT `fk_game_gift`
    FOREIGN KEY (`Gift_gameId`)
    REFERENCES `mydb`.`Game` (`Game_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Notification` (
  `Notification_id` INT(11) NOT NULL AUTO_INCREMENT,
  `Notification_playerId` INT(11) NULL DEFAULT NULL,
  `Notification_text` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`Notification_id`),
  INDEX `fk_player_notification_idx` (`Notification_playerId` ASC) VISIBLE,
  CONSTRAINT `fk_player_notification`
    FOREIGN KEY (`Notification_playerId`)
    REFERENCES `mydb`.`Player` (`Player_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
