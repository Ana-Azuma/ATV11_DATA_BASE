create database controleEstoque;
use controleEstoque;

CREATE TABLE produtos (
    ID_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    quantidade INT
);

CREATE TABLE log_estoque (
    ID_log INT PRIMARY KEY AUTO_INCREMENT,
    ID_produto INT,
    quantidade_antiga INT,
    quantidade_nova INT,
    data_alteracao DATETIME,
    CONSTRAINT fk_produto FOREIGN KEY (ID_produto) REFERENCES produtos(ID_produto)
);

insert into 
	produtos (nome, quantidade)
    values ('Furadeira GSB', 35),
    ('Furadeira GSR', 20),
    ('Esmerilhadeira GWS', 25),
    ('Martelete GBH', 50),
    ('Vibrador de Concreto', 58);

-- Crie uma trigger AFTER UPDATE na tabela produtos --
DELIMITER //
CREATE TRIGGER trg_verQtd
AFTER UPDATE ON produtos 
FOR EACH ROW 
BEGIN 
    IF OLD.quantidade <> NEW.quantidade THEN 
        INSERT INTO log_estoque (ID_produto, quantidade_antiga, quantidade_nova, data_alteracao)
        VALUES (NEW.ID_produto, OLD.quantidade, NEW.quantidade, NOW());
    END IF;  
END //
DELIMITER ;

update produtos set quantidade = 1 where ID_produto = 3;
select *from log_estoque;
select *from produtos;

-- Crie uma Function que receba como parâmetro o id de um produto e retorne a quantidade atual em estoque  --
DELIMITER //
CREATE FUNCTION get_quantidade_produto(p_id INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_quantidade INT;

    SELECT quantidade
    INTO v_quantidade
    FROM produtos
    WHERE ID_produto = p_id;

    RETURN v_quantidade;
END //
DELIMITER ;

SELECT get_quantidade_produto(4) AS quantidade_em_estoque;

-- Crie uma Procedure chamada atualiza_quantidade --
DELIMITER //
CREATE PROCEDURE atualiza_quantidade (
    IN p_id INT,
    IN p_nova_quantidade INT
)
BEGIN
    UPDATE produtos
    SET quantidade = p_nova_quantidade
    WHERE ID_produto = p_id;

    SELECT 'Produto atualizado com sucesso' AS mensagem;
END //
DELIMITER ;
CALL atualiza_quantidade(3, 40);

