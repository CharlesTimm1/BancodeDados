-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 02/09/2023 às 02:11
-- Versão do servidor: 10.4.28-MariaDB
-- Versão do PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `ativ5`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `autenticacoes`
--

CREATE TABLE `autenticacoes` (
  `id` int(11) NOT NULL,
  `ip_conectado` varchar(15) NOT NULL,
  `usuario` varchar(100) DEFAULT NULL,
  `senha` varchar(100) DEFAULT NULL,
  `mac` varchar(100) DEFAULT NULL,
  `observacoes` varchar(255) DEFAULT NULL,
  `situacao` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `tipo_pessoa` varchar(15) NOT NULL,
  `cpf` varchar(15) NOT NULL,
  `rg` varchar(15) NOT NULL,
  `data_nasc` date DEFAULT NULL,
  `cep` varchar(10) NOT NULL,
  `endereco` varchar(255) NOT NULL,
  `status` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `clientes`
--

INSERT INTO `clientes` (`id`, `nome`, `tipo_pessoa`, `cpf`, `rg`, `data_nasc`, `cep`, `endereco`, `status`) VALUES
(1, 'Charles', 'F', '598.958.598-56', '1564879856', '2003-04-22', '91110-460', 'Av Faria Lobato', 'A');

-- --------------------------------------------------------

--
-- Estrutura para tabela `contratos`
--

CREATE TABLE `contratos` (
  `id` int(11) NOT NULL,
  `numero` int(11) NOT NULL,
  `valor_plano` decimal(10,2) NOT NULL,
  `plano` varchar(255) NOT NULL,
  `situacao` varchar(1) NOT NULL,
  `inicio` date DEFAULT NULL,
  `vencimento` date DEFAULT NULL,
  `assinatura` varchar(3) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_equipamento` int(11) DEFAULT NULL,
  `id_autenticacao` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `contratos`
--

INSERT INTO `contratos` (`id`, `numero`, `valor_plano`, `plano`, `situacao`, `inicio`, `vencimento`, `assinatura`, `id_cliente`, `id_equipamento`, `id_autenticacao`) VALUES
(1, 12345, 0.00, '', '', NULL, NULL, NULL, NULL, NULL, NULL),
(3, 123456, 1215.00, 'PACOTE 300MB', 'A', NULL, NULL, NULL, 1, NULL, NULL);

--
-- Acionadores `contratos`
--
DELIMITER $$
CREATE TRIGGER `conceder_desconto` BEFORE INSERT ON `contratos` FOR EACH ROW BEGIN
    IF NEW.valor_plano > 1000.00 THEN
        SET NEW.valor_plano = NEW.valor_plano * 0.90; -- Aplica um desconto de 10%
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `equipamentos_cliente`
--

CREATE TABLE `equipamentos_cliente` (
  `id` int(11) NOT NULL,
  `equipamento` varchar(255) DEFAULT NULL,
  `serial` varchar(255) DEFAULT NULL,
  `ativacao` date DEFAULT NULL,
  `valor_equip` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `view_clientes`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `view_clientes` (
`nome` varchar(255)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `view_contrato`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `view_contrato` (
`numero` int(11)
);

-- --------------------------------------------------------

--
-- Estrutura para view `view_clientes`
--
DROP TABLE IF EXISTS `view_clientes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_clientes`  AS SELECT `clientes`.`nome` AS `nome` FROM `clientes` ;

-- --------------------------------------------------------

--
-- Estrutura para view `view_contrato`
--
DROP TABLE IF EXISTS `view_contrato`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_contrato`  AS SELECT `contratos`.`numero` AS `numero` FROM `contratos` ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `autenticacoes`
--
ALTER TABLE `autenticacoes`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `contratos`
--
ALTER TABLE `contratos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_equipamento` (`id_equipamento`),
  ADD KEY `id_autenticacao` (`id_autenticacao`);

--
-- Índices de tabela `equipamentos_cliente`
--
ALTER TABLE `equipamentos_cliente`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `contratos`
--
ALTER TABLE `contratos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `contratos`
--
ALTER TABLE `contratos`
  ADD CONSTRAINT `contratos_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `contratos_ibfk_2` FOREIGN KEY (`id_equipamento`) REFERENCES `equipamentos_cliente` (`id`),
  ADD CONSTRAINT `contratos_ibfk_3` FOREIGN KEY (`id_autenticacao`) REFERENCES `autenticacoes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
