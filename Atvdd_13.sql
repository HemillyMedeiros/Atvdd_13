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

--3. copie os dados do arquivo .csv p/ sua tabela.
COPY public.tb_higher_education (studendid, age, gender, hs_type, scholarship, work, activity, partner, salary, transport) 
FROM 'C:\student_prediction.csv' 
DELIMITER ',' CSV HEADER QUOTE '"' ESCAPE '"';

--4- Escreva os seguintes stored procedures (incluindo um bloco anônimo de teste para cada
um):
--4.1- Exibe o número de estudantes maiores de idade.
CREATE OR REPLACE FUNCTION retorna_maiores_idade()
RETURNS INTEGER AS
$$
DECLARE
  count_value INTEGER;
BEGIN
  SELECT COUNT(age) INTO count_value FROM tb_higher_education
  where age = 1 or age = 2 or age = 3;
  RAISE NOTICE 'A quatidade de estudantes maiores de idades é: %',  count_value;
END;
$$
LANGUAGE plpgsql;

select retorna_maiores_idade();

