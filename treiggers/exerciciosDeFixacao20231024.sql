CREATE TRIGGER ad_cliente AFTER INSERT ON Clientes
for each row INSERT INTO Auditoria (mensagem) VALUES ("Novo cliente inserido em " + NOW());
 
CREATE TRIGGER aviso_d_exclusao BEFORE DELETE ON Clientes
FOR EACH ROW INSERT INTO Auditoria (mensagem) VALUES("Tentativa de exclusão de cliente");
 
CREATE TRIGGER ATUALIZACAO AFTER UPDATE ON Clientes
FOR EACH ROW INSERT INTO Auditoria (mensagem) VALUES(CONCAT('Nome antigo: ', OLD.nome, '; Novo nome: ', NEW.nome));

CREATE TRIGGER no_update BEFORE UPDATE on Clientes FOR EACH ROW
IF NEW.nome IS NULL OR NEW.nome = "" THEN
SIGNAL SQLSTATE '45000' SET
INSERT INTO Auditoria (mensagem) VALUES("Tentativa de UPDATE em valor null");
