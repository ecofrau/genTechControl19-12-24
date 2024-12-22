CREATE DATABASE tasks;
USE tasks;


CREATE TABLE store (
    id INT AUTO_INCREMENT PRIMARY KEY,  
    title VARCHAR(128) NOT NULL,       
    price INT,                         
    quantity INT                        
);

INSERT INTO store (title, price, quantity) 
VALUES 
    ('Skirt', 120, 10),
    ('Shirt', 55, 4),
    ('Jeanse', 135, 15);
    
    select * from store;
    
    SELECT * FROM store
WHERE price > 100;



SELECT * FROM store
WHERE LEFT(title, 1) = 'S';


SET SQL_SAFE_UPDATES = 0;


UPDATE store
SET quantity = quantity + 5
WHERE title = 'Jeanse';

    SET SQL_SAFE_UPDATES = 1;
    
    ALTER TABLE store
ADD COLUMN quality INT;

 select * from store;
SET SQL_SAFE_UPDATES = 0;



UPDATE store
SET quality = CASE
    WHEN price > 100 THEN 5
    WHEN price <= 100 THEN 4
    ELSE quality 
END;



DELETE FROM store
WHERE quantity < 10;
SELECT * FROM store;
SET SQL_SAFE_UPDATES = 1;



DESCRIBE store;

DROP TABLE store;
DROP DATABASE tasks;


-- 1. Создание базы данных
CREATE DATABASE shop;

-- 2. Выбор базы данных
USE shop;

-- 3. Создание таблицы SELLERS
CREATE TABLE SELLERS (
    SELL_ID INTEGER, 
    SNAME VARCHAR(20), 
    CITY VARCHAR(20), 
     COMM    NUMERIC(2, 2),
    BOSS_ID INTEGER
);

-- 4. Создание таблицы CUSTOMERS
CREATE TABLE CUSTOMERS (
    CUST_ID INTEGER, 
    CNAME VARCHAR(20), 
    CITY VARCHAR(20), 
    RATING INTEGER
);

-- 5. Создание таблицы ORDERS
CREATE TABLE ORDERS (
    ORDER_ID INTEGER, 
    AMT DECIMAL(7, 2),  -- Тип данных для суммы заказа
    ODATE DATE, 
    CUST_ID INTEGER,
    SELL_ID INTEGER 
);

-- 6. Вставка данных в таблицу SELLERS
INSERT INTO SELLERS VALUES(201, 'Олег', 'Москва', 0.12, 202);
INSERT INTO SELLERS VALUES(202, 'Лев', 'Сочи', 0.13, 204);
INSERT INTO SELLERS VALUES(203, 'Арсений', 'Владимир', 0.10, 204);
INSERT INTO SELLERS VALUES(204, 'Екатерина', 'Москва', 0.11, 205);
INSERT INTO SELLERS VALUES(205, 'Леонид', 'Казань', 0.15, NULL);

-- 7. Вставка данных в таблицу CUSTOMERS
INSERT INTO CUSTOMERS VALUES(301, 'Андрей', 'Москва', 100);
INSERT INTO CUSTOMERS VALUES(302, 'Михаил', 'Тула', 200);
INSERT INTO CUSTOMERS VALUES(303, 'Иван', 'Сочи', 200);
INSERT INTO CUSTOMERS VALUES(304, 'Дмитрий', 'Ярославль', 300);
INSERT INTO CUSTOMERS VALUES(305, 'Руслан', 'Москва', 100);
INSERT INTO CUSTOMERS VALUES(306, 'Артём', 'Тула', 100);
INSERT INTO CUSTOMERS VALUES(307, 'Юлия', 'Сочи', 300);

-- 8. Вставка данных в таблицу ORDERS
INSERT INTO ORDERS VALUES(101, 18.69, '2022-03-10', 308, 207);
INSERT INTO ORDERS VALUES(102, 5900.10, '2022-03-10', 307, 204);
INSERT INTO ORDERS VALUES(103, 767.19, '2022-03-10', 301, 201);
INSERT INTO ORDERS VALUES(104, 5160.45, '2022-03-10', 303, 202);
INSERT INTO ORDERS VALUES(105, 1098.16, '2022-03-10', 308, 207);
INSERT INTO ORDERS VALUES(106, 75.75, '2022-04-10', 304, 202); 
INSERT INTO ORDERS VALUES(107, 4723.00, '2022-05-10', 306, 201);
INSERT INTO ORDERS VALUES(108, 1713.23, '2022-04-10', 302, 203);
INSERT INTO ORDERS VALUES(109, 1309.95, '2022-06-10', 304, 203);
INSERT INTO ORDERS VALUES(110, 9891.88, '2022-06-10', 306, 201);

-- 9. Запрос для вывода продавцов, чьи имена начинаются на букву 'Л'
SELECT * FROM SELLERS
WHERE LEFT(SNAME, 1) = 'Л';


SELECT * FROM CUSTOMERS
WHERE CITY = 'Тула' AND RATING > 100;

SELECT * FROM SELLERS
WHERE COMM BETWEEN 0.10 AND 0.15;


SELECT * FROM ORDERS
WHERE AMT < 1000 AND ODATE > '2022-04-01';


SELECT * FROM SELLERS
WHERE CITY = 'Москва'
ORDER BY SELL_ID DESC;

SELECT * 
FROM orders
WHERE  CUST_ID = 304
ORDER BY AMT DESC;


SELECT 
    c.CNAME AS customer_name, 
    s.SNAME AS seller_name, 
    c.CITY
FROM 
    CUSTOMERS c
JOIN 
    ORDERS o ON c.CUST_ID = o.CUST_ID
JOIN 
    SELLERS s ON o.SELL_ID = s.SELL_ID
WHERE 
    c.CITY = s.CITY;

SELECT 
    ORDER_ID, 
    AMT, 
    ODATE, 
    CUST_ID, 
    SELL_ID
FROM 
    ORDERS
WHERE 
    MONTH(ODATE) = 3 AND YEAR(ODATE) = 2022;

SELECT 
    c.CNAME AS customer_name, 
    o.AMT AS order_amount
FROM 
    CUSTOMERS c
JOIN 
    ORDERS o ON c.CUST_ID = o.CUST_ID
WHERE 
    MONTH(o.ODATE) = 4 AND YEAR(o.ODATE) = 2022;

SELECT 
    s.SNAME AS seller_name, 
    c.CNAME AS customer_name
FROM 
    SELLERS s
JOIN 
    ORDERS o ON s.SELL_ID = o.SELL_ID
JOIN 
    CUSTOMERS c ON o.CUST_ID = c.CUST_ID;


SELECT 
    s.SNAME AS seller_name, 
    c.CITY AS customer_city
FROM 
    SELLERS s
JOIN 
    ORDERS o ON s.SELL_ID = o.SELL_ID
JOIN 
    CUSTOMERS c ON o.CUST_ID = c.CUST_ID;
    
    
    
    SELECT 
    c.CNAME AS customer_name, 
    s.SNAME AS seller_name
FROM 
    CUSTOMERS c
JOIN 
    ORDERS o ON c.CUST_ID = o.CUST_ID
JOIN 
    SELLERS s ON o.SELL_ID = s.SELL_ID;
    
    
    
    SELECT 
    s.SNAME AS seller_name
FROM 
    SELLERS s
LEFT JOIN 
    ORDERS o ON s.SELL_ID = o.SELL_ID
WHERE 
    o.ORDER_ID IS NULL;


SELECT 
    c.CNAME AS customer_name, 
    SUM(o.AMT) AS total_order_amount
FROM 
    CUSTOMERS c
JOIN 
    ORDERS o ON c.CUST_ID = o.CUST_ID
GROUP BY 
    c.CNAME;


SELECT 
    c.CNAME AS customer_name, 
    s.SNAME AS seller_name
FROM 
    CUSTOMERS c
LEFT JOIN 
    ORDERS o ON c.CUST_ID = o.CUST_ID
LEFT JOIN 
    SELLERS s ON o.SELL_ID = s.SELL_ID;
    
    
    SELECT 
    DISTINCT s.SNAME AS seller_name
FROM 
    SELLERS s
JOIN 
    ORDERS o ON s.SELL_ID = o.SELL_ID
JOIN 
    CUSTOMERS c ON o.CUST_ID = c.CUST_ID
WHERE 
    c.CITY = 'Тула';
    
    
    SELECT 
    o.ORDER_ID, 
    c.CNAME AS customer_name, 
    o.AMT AS order_amount
FROM 
    ORDERS o
JOIN 
    CUSTOMERS c ON o.CUST_ID = c.CUST_ID
WHERE 
    o.AMT > 5000;

SELECT 
    c.CNAME AS customer_name, 
    s.SNAME AS seller_name
FROM 
    CUSTOMERS c
JOIN 
    ORDERS o ON c.CUST_ID = o.CUST_ID
JOIN 
    SELLERS s ON o.SELL_ID = s.SELL_ID
WHERE 
    o.ODATE BETWEEN '2022-06-01' AND '2022-06-30';




