-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema simulado2_dbb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema simulado2_dbb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `simulado2_dbb` DEFAULT CHARACTER SET utf8 ;
USE `simulado2_dbb` ;

-- -----------------------------------------------------
-- Table `simulado2_dbb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `simulado2_dbb`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `ativo` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `simulado2_dbb`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `simulado2_dbb`.`produto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `preco` DECIMAL(10,2) NOT NULL,
  `estoque_atual` INT NOT NULL DEFAULT 0,
  `estoque_minimo` INT NOT NULL,
  `ativo` TINYINT(1) NOT NULL DEFAULT 1,
  `categoria` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `simulado2_dbb`.`movimentacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `simulado2_dbb`.`movimentacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` INT NOT NULL COMMENT '1-entrada 2-saida\n',
  `data` DATE NOT NULL,
  `quantidade` INT NOT NULL,
  `saldo_anterior` INT NOT NULL,
  `produto_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_movimentacao_produto_idx` (`produto_id` ASC) VISIBLE,
  INDEX `fk_movimentacao_usuario1_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_movimentacao_produto`
    FOREIGN KEY (`produto_id`)
    REFERENCES `simulado2_dbb`.`produto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movimentacao_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `simulado2_dbb`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
