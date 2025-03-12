-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema dbtaller
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dbtaller
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbtaller` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `dbtaller` ;

-- -----------------------------------------------------
-- Table `dbtaller`.`tipoproyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbtaller`.`tipoproyecto` (
  `tipo` CHAR(10) NOT NULL,
  `nombre` VARCHAR(150) NULL DEFAULT NULL,
  PRIMARY KEY (`tipo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbtaller`.`lineainv`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbtaller`.`lineainv` (
  `clavein` CHAR(10) NOT NULL,
  `nombre` VARCHAR(250) NULL DEFAULT NULL,
  PRIMARY KEY (`clavein`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbtaller`.`proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbtaller`.`proyecto` (
  `clave` CHAR(10) NOT NULL,
  `nombre` VARCHAR(250) NULL DEFAULT NULL,
  `clavein` CHAR(10) NULL DEFAULT NULL,
  `tipo` CHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`clave`),
  INDEX `corresponde` (`clavein` ASC) VISIBLE,
  INDEX `asignado` (`tipo` ASC) VISIBLE,
  CONSTRAINT `asignado`
    FOREIGN KEY (`tipo`)
    REFERENCES `dbtaller`.`tipoproyecto` (`tipo`),
  CONSTRAINT `corresponde`
    FOREIGN KEY (`clavein`)
    REFERENCES `dbtaller`.`lineainv` (`clavein`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbtaller`.`alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbtaller`.`alumno` (
  `nocontrol` CHAR(10) NOT NULL,
  `nombre` VARCHAR(150) NULL DEFAULT NULL,
  `clave` CHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`nocontrol`),
  INDEX `elige` (`clave` ASC) VISIBLE,
  CONSTRAINT `elige`
    FOREIGN KEY (`clave`)
    REFERENCES `dbtaller`.`proyecto` (`clave`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbtaller`.`datos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbtaller`.`datos` (
  `clave` CHAR(8) NULL DEFAULT NULL,
  `proyecto` VARCHAR(150) NULL DEFAULT NULL,
  `linea` CHAR(10) NULL DEFAULT NULL,
  `tipo` CHAR(5) NULL DEFAULT NULL,
  `nocontrol` CHAR(10) NULL DEFAULT NULL,
  `nombre_alumno` VARCHAR(150) NULL DEFAULT NULL,
  `nombreProf` VARCHAR(150) NULL DEFAULT NULL,
  `revisor1` VARCHAR(150) NULL DEFAULT NULL,
  `revisor2` VARCHAR(150) NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbtaller`.`profesor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbtaller`.`profesor` (
  `idprofesor` INT NOT NULL AUTO_INCREMENT,
  `nombreProf` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`idprofesor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `dbtaller`.`profesorproy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbtaller`.`profesorproy` (
  `idprofesor` INT NULL DEFAULT NULL,
  `clave` CHAR(10) NULL DEFAULT NULL,
  `calificacion` FLOAT NULL DEFAULT NULL,
  `rol` VARCHAR(45) NULL DEFAULT NULL,
  INDEX `asesora` (`idprofesor` ASC) VISIBLE,
  INDEX `asigna` (`clave` ASC) VISIBLE,
  CONSTRAINT `asesora`
    FOREIGN KEY (`idprofesor`)
    REFERENCES `dbtaller`.`profesor` (`idprofesor`),
  CONSTRAINT `asigna`
    FOREIGN KEY (`clave`)
    REFERENCES `dbtaller`.`proyecto` (`clave`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
