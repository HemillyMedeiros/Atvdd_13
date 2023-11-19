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
----------------------------------------------------------------------
-- CREATE OR REPLACE PROCEDURE retorna_maior_idade(OUT count_age INTEGER)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   SELECT COUNT(age) INTO count_age FROM tb_higher_education;
-- END;
-- $$;

-- CALL retorna_maior_idade(age);

-- drop procedure retorna_maior_idade();

--4.2 exibe o porcentual de estudantes de cada sexo.
CREATE OR REPLACE FUNCTION retorna_sexo_estudantes()
RETURNS INTEGER AS $$
DECLARE 
    count_gender_m INTEGER;
    count_gender_f INTEGER;
    total INTEGER;
BEGIN
    SELECT COUNT(gender) INTO count_gender_m FROM tb_higher_education
    WHERE gender = 2;
    RAISE NOTICE 'A quantidade de alunos do genero masculino é: %',count_gender_m;
    SELECT COUNT(gender) INTO count_gender_f FROM tb_higher_education
    WHERE gender = 1;
    RAISE NOTICE 'A quantidade de alunos do genero feminino é: %',count_gender_f;
    total := count_gender_f + count_gender_m;
    RAISE NOTICE 'A porcentagem de alunos do genero masculino é: % %%',  count_gender_m * 100 / 145;
    RAISE NOTICE 'A porcentagem de alunos do genero feminino é: % %%',  count_gender_f * 100 / 145;

END;
$$
LANGUAGE plpgsql;


SELECT retorna_sexo_estudantes();