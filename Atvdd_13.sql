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

---bloco anonimo
DROP PROCEDURE notas_por_sexo();
CREATE OR REPLACE PROCEDURE notas_por_sexo(IN gender INT, INOUT Fail INT, INOUT DD INT, INOUT DC INT, INOUT CC INT, INOUT CB INT, INOUT BB INT, INOUT BA INT, INOUT AA INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(grade) INTO Fail FROM tb_higher_education
    where grade = 0;
    SELECT COUNT(grade) INTO DD FROM tb_higher_education
    where grade = 1;
    SELECT COUNT(grade) INTO DC FROM tb_higher_education
    where grade = 2;
    SELECT COUNT(grade) INTO CC FROM tb_higher_education
    where grade = 3;
    SELECT COUNT(grade) INTO CB FROM tb_higher_education
    where grade = 4;
    SELECT COUNT(grade) INTO BB FROM tb_higher_education
    where grade = 5;
    SELECT COUNT(grade) INTO BA FROM tb_higher_education
    where grade = 6;
    SELECT COUNT(grade) INTO AA FROM tb_higher_education
    where grade = 7;
    
    RAISE NOTICE '%', Fail;
    RAISE NOTICE '%', DD;
    RAISE NOTICE '%', DC;
    RAISE NOTICE '%', CC;
    RAISE NOTICE '%', BC;
    RAISE NOTICE '%', BB;
    RAISE NOTICE '%', BA;
    RAISE NOTICE '%', AA;
    
    
END;$$


CALL notas_por_sexo(1);
CALL notas_por_sexo(2);

--4.3 Recebe um sexo como parâmetro em modo IN 
CREATE OR REPLACE PROCEDURE notas_por_sexo2(IN gender INT, INOUT Fail INT, INOUT DD INT, INOUT DC INT, INOUT CC INT, INOUT CB INT, INOUT BB INT, INOUT BA INT, INOUT AA INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(*) INTO Fail FROM tb_higher_education
    where grade = 0;
    SELECT COUNT(*) INTO DD FROM tb_higher_education
    where grade = 1;
    SELECT COUNT(*) INTO DC FROM tb_higher_education
    where grade = 2;
    SELECT COUNT(*) INTO CC FROM tb_higher_education
    where grade = 3;
    SELECT COUNT(*) INTO CB FROM tb_higher_education
    where grade = 4;
    SELECT COUNT(*) INTO BB FROM tb_higher_education
    where grade = 5;
    SELECT COUNT(*) INTO BA FROM tb_higher_education
    where grade = 6;
    SELECT COUNT(*) INTO AA FROM tb_higher_education
    where grade = 7;
    
    RAISE NOTICE '%', Fail;
    RAISE NOTICE '%', DD;
    RAISE NOTICE '%', DC;
    RAISE NOTICE '%', CC;
    RAISE NOTICE '%', BC;
    RAISE NOTICE '%', BB;
    RAISE NOTICE '%', BA;
    RAISE NOTICE '%', AA;
    
    
END;$$

DO
$$
declare
    gender int := 1;
begin
    call notas_por_sexo2(Gender);
    raise notice'%', gender;
end;
$$

CALL notas_por_sexo2(2);

--5.1 Escreva as seguintes functions
CREATE OR REPLACE PROCEDURE calcular_percentual_notas(
  IN sexo_param INTEGER,
  OUT percentual_grade1 FLOAT,
  OUT percentual_grade2 FLOAT,
  OUT percentual_grade3 FLOAT,
  OUT percentual_grade4 FLOAT,
  OUT percentual_grade5 FLOAT,
  OUT percentual_grade6 FLOAT,
  OUT percentual_grade7 FLOAT,
  OUT percentual_grade8 FLOAT
)
AS $$
DECLARE 
    total_estudantes INTEGER;
BEGIN
    SELECT COUNT(*) INTO total_estudantes FROM tb_higher_education WHERE gender = sexo_param;
    
    SELECT 
        (COUNT(*) * 100.0) / total_estudantes INTO percentual_grade1
        FROM tb_higher_education WHERE gender = sexo_param AND grade = 1;
    
    SELECT 
        (COUNT(*) * 100.0) / total_estudantes INTO percentual_grade2
        FROM tb_higher_education WHERE gender = sexo_param AND grade = 2;
    
    SELECT 
        (COUNT(*) * 100.0) / total_estudantes INTO percentual_grade3
        FROM tb_higher_education WHERE gender = sexo_param AND grade = 3;
    
    SELECT 
        (COUNT(*) * 100.0) / total_estudantes INTO percentual_grade4
        FROM tb_higher_education WHERE gender = sexo_param AND grade = 4;
    
    SELECT 
        (COUNT(*) * 100.0) / total_estudantes INTO percentual_grade5
        FROM tb_higher_education WHERE gender = sexo_param AND grade = 5;
    
    SELECT 
        (COUNT(*) * 100.0) / total_estudantes INTO percentual_grade6
        FROM tb_higher_education WHERE gender = sexo_param AND grade = 6;
    
    SELECT 
        (COUNT(*) * 100.0) / total_estudantes INTO percentual_grade7
        FROM tb_higher_education WHERE gender = sexo_param AND grade = 7;
    
    SELECT 
        (COUNT(*) * 100.0) / total_estudantes INTO percentual_grade8
        FROM tb_higher_education WHERE gender = sexo_param AND grade = 8;
    
END;
$$ LANGUAGE plpgsql;


CALL calcular_percentual_notas(Gender);
CALL calcular_percentual_notas(1);
