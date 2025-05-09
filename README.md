# ATV11_DATA_BASE
1.Crie uma trigger AFTER UPDATE na tabela produtos que:
✓Identifique quando a coluna quantidade for alterada.
✓Grave um registro na tabela log_estoque com:
✓id_produto: o ID do produto alterado.
✓quantidade_antiga: valor da quantidade antes da alteração (OLD.quantidade).
✓quantidade_nova: valor após a alteração (NEW.quantidade).
✓data_alteracao: data e hora da alteração (use NOW()).

2. Crie uma Function que receba como parâmetro o id de um produto e retorne a quantidade atual em estoque.

Tabela produtos (já existente):
CREATE TABLE produtos ( id INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(100),
quantidade INT );

Requisitos:
• A função deve se chamar get_quantidade_produto.
• Deve receber como parâmetro o ID do produto.
• Deve retornar um número inteiro (INT) com a quantidade.
• Pode ser utilizada dentro de um SELECT

3.Crie uma Procedure chamada atualiza_quantidade que:
Receba como parâmetros: o id do produto e o novo valor da quantidade.
Atualize o campo quantidade na tabela produtos.

Requisitos:
Nome da procedure: atualiza_quantidade.
Parâmetros: p_id INT, p_nova_quantidade INT.
Deve fazer um UPDATE na tabela produtos.
Após o UPDATE, retorne uma mensagem com SELECT 'Produto atualizado com sucesso';.
