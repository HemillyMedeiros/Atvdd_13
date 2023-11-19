--1. estude e faça o download da base de dados disponível no link.

--2. crie uma tabela apropriada p/ o armazenamento dos itens.
DROP TABLE IF EXISTS tb_higher_education;
CREATE TABLE tb_higher_education(
    Studendid TEXT PRIMARY KEY,
    age INT,
    Gender INT,
    HS_type INT,
    Scholarship INT,
    Work TEXT,
    Activity INT,
    Partner INT,
    Salary INT,
    Transport INT,
    Grade INT
);
SELECT * FROM tb_higher_education;