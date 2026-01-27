-- Tables Creation:

-- Branch Table Creation:
CREATE TABLE branches (
        branch_ID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        branch_city VARCHAR(50) NOT NULL,
        branch_street VARCHAR(50) NOT NULL,
        branch_phone_country_code VARCHAR(7) NOT NULL,
        branch_phone_local_number VARCHAR(20) NOT NULL,
        UNIQUE (branch_phone_country_code,  branch_phone_local_number)
);

-- Customers Table Creation:
CREATE TABLE customers (
    customer_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    branch_ID INT,
    customer_dob DATE,
    customer_age INT,
    customer_city VARCHAR(50),
    customer_street VARCHAR(50),
    customer_first_name VARCHAR(50),
    customer_last_name VARCHAR(50),
    customer_country_code VARCHAR(7),
    customer_local_number VARCHAR(20),
    UNIQUE (customer_country_code, customer_local_number),
    FOREIGN KEY(branch_ID) REFERENCES branches(branch_ID)
);

-- Accounts Table Creation:
CREATE TABLE accounts(
        account_number INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        customer_id INT NOT NULL,
        date_of_creation DATE,
        account_balance DECIMAL(15,2) NOT NULL,
        account_type VARCHAR(20) NOT NULL,
        account_age INT NOT NULL,
        FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);


-- Transactions Table Creation:
CREATE TABLE transactions(
        transaction_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        account_number INT NOT NULL,
        transaction_date DATE,
        transaction_type VARCHAR(20) NOT NULL,
        transaction_amount DECIMAL(15,2) NOT NULL,
        FOREIGN KEY(account_number) REFERENCES accounts(account_number)
);


-- Employees Table Creation:
CREATE TABLE employees (
    employee_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    branch_ID INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    position VARCHAR(50) NOT NULL,
    FOREIGN KEY (branch_ID) REFERENCES branches(branch_ID)
);


-- Loans Table Creation:
CREATE TABLE loans (
    loan_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    loan_type VARCHAR(30) NOT NULL,
    loan_amount DECIMAL(15,2) NOT NULL,
    loan_issue_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

ALTER TABLE loans
ADD COLUMN loan_age INT;

-- Employee Assistance Table Creation:
CREATE TABLE employee_assistance (
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    action_type VARCHAR(50) NOT NULL,
    action_date DATE NOT NULL,
    PRIMARY KEY (customer_id, employee_id, action_date),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);


-- Data Inserting

INSERT INTO branches (
    branch_city,
    branch_street,
    branch_phone_country_code,
    branch_phone_local_number
) VALUES
('Muscat', 'Al Khuwair Street', '+968', '24561234'),
('Muscat', 'Al Seeb Street', '+968', '24445566'),
('Salalah', '23rd July Street', '+968', '23214567'),
('Sohar', 'Falaj Street', '+968', '26891234'),
('Nizwa', 'Souq Nizwa Road', '+968', '25437890');


INSERT INTO customers (
    branch_ID,
    customer_dob,
    customer_city,
    customer_street,
    customer_first_name,
    customer_last_name,
    customer_country_code,
    customer_local_number
) VALUES
(1, '1984-02-14', 'Muscat', 'Ruwi', 'Majid', 'Al-Farsi', '+968', '98100001'),
(2, '1991-06-09', 'Muscat', 'Al Hail', 'Sultan', 'Al-Kalbani', '+968', '98100002'),
(3, '1989-11-21', 'Salalah', 'New Salalah', 'Hamood', 'Al-Shanfari', '+968', '98100003'),
(4, '1997-03-05', 'Sohar', 'Industrial Area', 'Zainab', 'Al-Balushi', '+968', '98100004'),

(1, '2002-07-17', 'Muscat', 'Al Amerat', 'Omar', 'Al-Muqbali', '+968', '98100005'),
(2, '1980-12-30', 'Muscat', 'Bosher', 'Yaqoob', 'Al-Hinai', '+968', '98100006'),
(3, '1995-09-01', 'Salalah', 'Haffa', 'Reem', 'Al-Rawahi', '+968', '98100007'),
(4, '1986-04-26', 'Sohar', 'Falaj', 'Khalfan', 'Al-Shidi', '+968', '98100008'),

(1, '1993-01-11', 'Muscat', 'Seeb', 'Laila', 'Al-Zadjali', '+968', '98100009'),
(2, '1999-05-23', 'Muscat', 'Al Mawaleh', 'Hamed', 'Al-Kharousi', '+968', '98100010'),
(3, '1987-08-14', 'Salalah', 'Awqad', 'Nawal', 'Al-Yaqoobi', '+968', '98100011'),
(4, '1990-10-06', 'Sohar', 'Al Wadi', 'Saeed', 'Al-Abri', '+968', '98100012'),

(1, '2001-03-29', 'Muscat', 'Ghubrah', 'Amal', 'Al-Raisi', '+968', '98100013'),
(2, '1983-07-18', 'Muscat', 'Qurum', 'Fahad', 'Al-Hooti', '+968', '98100014'),
(3, '1996-12-02', 'Salalah', 'Dahariz', 'Muna', 'Al-Hakmani', '+968', '98100015'),
(4, '1988-06-20', 'Sohar', 'Liwa Road', 'Nasser', 'Al-Mahrouqi', '+968', '98100016'),

(1, '1994-09-09', 'Muscat', 'Mabela', 'Tariq', 'Al-Busaidi', '+968', '98100017'),
(2, '2000-11-27', 'Muscat', 'Al Khoud', 'Ahlam', 'Al-Wahaibi', '+968', '98100018'),
(3, '1981-04-15', 'Salalah', 'East Salalah', 'Salem', 'Al-Kathiri', '+968', '98100019'),
(4, '1998-02-08', 'Sohar', 'Saham Road', 'Huda', 'Al-Falahi', '+968', '98100020');


INSERT INTO accounts (
    customer_id,
    date_of_creation,
    account_balance,
    account_type,
    account_age
) VALUES
(1,  '2020-01-15', 3500.00, 'Savings', 5),
(2,  '2019-06-20', 1200.50, 'Checking', 6),
(3,  '2021-03-10', 7800.00, 'Savings', 4),
(4,  '2018-11-05', 450.75,  'Checking', 7),
(5,  '2022-02-14', 9200.00, 'Savings', 3),

(6,  '2017-09-01', 15000.00,'Savings', 8),
(7,  '2020-07-18', 2600.40, 'Checking', 5),
(8,  '2019-12-30', 3400.00, 'Savings', 6),
(9,  '2021-08-22', 510.25,  'Checking', 4),
(10, '2018-04-09', 8900.00, 'Savings', 7),

(11, '2022-06-01', 1300.00, 'Checking', 3),
(12, '2020-10-17', 7600.00, 'Savings', 5),
(13, '2019-01-26', 4100.00, 'Checking', 6),
(14, '2021-11-11', 9800.00, 'Savings', 4),
(15, '2017-05-03', 22000.00,'Savings', 8),

(16, '2020-02-19', 670.90,  'Checking', 5),
(17, '2018-08-14', 5400.00, 'Savings', 7),
(18, '2022-09-07', 3100.00, 'Checking', 3),
(19, '2019-03-28', 8600.00, 'Savings', 6),
(20, '2021-12-01', 1250.00, 'Checking', 4);


INSERT INTO employees (
    branch_ID,
    first_name,
    last_name,
    position
) VALUES
(1, 'Ali',     'Al-Harthy',   'Branch Manager'),
(1, 'Salem',   'Al-Busaidi',  'Customer Service Officer'),
(1, 'Noor',    'Al-Lawati',   'Teller'),

(2, 'Khalid',  'Al-Rashdi',   'Branch Manager'),
(2, 'Aisha',   'Al-Habsi',    'Customer Service Officer'),
(2, 'Hamed',   'Al-Kharousi', 'Teller'),

(3, 'Saeed',   'Al-Shanfari', 'Branch Manager'),
(3, 'Mariam',  'Al-Yaqoobi',  'Loan Officer'),
(3, 'Faisal',  'Al-Mahrouqi', 'Customer Service Officer'),

(4, 'Yousef',  'Al-Balushi',  'Branch Manager'),
(4, 'Fatma',   'Al-Falahi',   'Loan Officer'),
(4, 'Ibrahim', 'Al-Abri',     'Teller');



INSERT INTO loans (
    customer_id,
    employee_id,
    loan_type,
    loan_amount,
    loan_issue_date,
    loan_age
) VALUES
(1,  1,  'Personal',  5000.00,  '2020-03-15', 5),
(2,  2,  'Car',      12000.00, '2019-07-20', 6),
(3,  3,  'Home',     85000.00, '2018-11-10', 7),
(4,  4,  'Personal', 3000.00,  '2021-01-05', 4),

(5,  5,  'Car',      15000.00, '2020-09-18', 5),
(6,  6,  'Home',     120000.00,'2017-06-01', 8),
(7,  7,  'Personal', 4500.00,  '2022-02-22', 3),
(8,  8,  'Car',      18000.00, '2019-12-30', 6),

(9,  9,  'Home',     95000.00, '2018-05-14', 7),
(10, 10, 'Personal', 6000.00,  '2021-07-07', 4),
(11, 11, 'Car',      22000.00, '2020-10-10', 5),
(12, 12, 'Home',     110000.00,'2016-04-25', 9),

(13, 1,  'Personal', 4000.00,  '2022-08-12', 3),
(14, 2,  'Car',      17000.00, '2019-03-09', 6),
(15, 3,  'Home',     140000.00,'2017-12-01', 8),
(16, 4,  'Personal', 5200.00,  '2021-09-19', 4),

(17, 5,  'Car',      20000.00, '2020-01-28', 5),
(18, 6,  'Home',     98000.00, '2018-06-06', 7),
(19, 7,  'Personal', 3500.00,  '2022-11-15', 3),
(20, 8,  'Car',      16000.00, '2019-08-21', 6);


INSERT INTO employee_assistance (
    customer_id,
    employee_id,
    action_type,
    action_date
) VALUES
(1,  2,  'Open Savings Account',   '2023-01-10'),
(2,  5,  'Process Car Loan',       '2023-01-18'),
(3,  8,  'Open Checking Account',  '2023-02-01'),
(4,  1,  'Process Home Loan',      '2023-02-15'),

(5,  6,  'Process Personal Loan',  '2023-03-05'),
(6,  9,  'Open Savings Account',   '2023-03-18'),
(7,  3,  'Process Car Loan',       '2023-04-02'),
(8,  10, 'Open Checking Account',  '2023-04-19'),

(9,  4,  'Process Home Loan',      '2023-05-07'),
(10, 11, 'Process Personal Loan',  '2023-05-25'),
(11, 7,  'Open Savings Account',   '2023-06-03'),
(12, 12, 'Process Car Loan',       '2023-06-21'),

(13, 2,  'Open Checking Account',  '2023-07-11'),
(14, 5,  'Process Home Loan',      '2023-07-29'),
(15, 8,  'Process Personal Loan',  '2023-08-10'),
(16, 1,  'Open Savings Account',   '2023-08-28'),

(17, 6,  'Process Car Loan',       '2023-09-12'),
(18, 9,  'Open Checking Account',  '2023-09-30'),
(19, 3,  'Process Home Loan',      '2023-10-15'),
(20, 10, 'Process Personal Loan',  '2023-11-02');




INSERT INTO transactions (
    account_number,
    transaction_date,
    transaction_type,
    transaction_amount
) VALUES
(2,  '2023-01-05', 'Deposit',     1500.00),
(2,  '2023-01-20', 'Withdrawal',   300.00),

(3,  '2023-02-02', 'Deposit',     2000.00),
(3,  '2023-02-18', 'Withdrawal',   500.00),

(4,  '2023-03-10', 'Deposit',     5000.00),
(4,  '2023-03-25', 'Transfer',     800.00),

(5,  '2023-01-15', 'Deposit',     1000.00),
(5,  '2023-02-01', 'Withdrawal',   200.00),

(6,  '2023-04-05', 'Deposit',     30INSERT INTO transactions (
    account_number,
    transaction_date,
    transaction_type,
    transaction_amount
) VALUES
(2,  '2023-01-05', 'Deposit',     1500.00),
(2,  '2023-01-20', 'Withdrawal',   300.00),

(3,  '2023-02-02', 'Deposit',     2000.00),
(3,  '2023-02-18', 'Withdrawal',   500.00),

(4,  '2023-03-10', 'Deposit',     5000.00),
(4,  '2023-03-25', 'Transfer',     800.00),

(5,  '2023-01-15', 'Deposit',     1000.00),
(5,  '2023-02-01', 'Withdrawal',   200.00),

(6,  '2023-04-05', 'Deposit',     3000.00),
(6,  '2023-04-22', 'Transfer',     600.00),

(7,  '2023-05-01', 'Deposit',     8000.00),
(7,  '2023-05-19', 'Withdrawal',  1200.00),

(8,  '2023-06-03', 'Deposit',     2500.00),
(8,  '2023-06-20', 'Transfer',     400.00),

(9,  '2023-07-10', 'Deposit',     1800.00),
(9,  '2023-07-29', 'Withdrawal',   300.00),

(10, '2023-08-04', 'Deposit',     4500.00),
(10, '2023-08-18', 'Transfer',     900.00),

(11, '2023-09-01', 'Deposit',     2200.00),
(11, '2023-09-14', 'Withdrawal',   500.00),

(12, '2023-10-02', 'Deposit',     1600.00),
(12, '2023-10-22', 'Transfer',     350.00),

(13, '2023-11-05', 'Deposit',     7000.00),
(13, '2023-11-18', 'Withdrawal',   900.00),

(14, '2023-12-01', 'Deposit',     2800.00),
(14, '2023-12-20', 'Transfer',     600.00),

(15, '2024-01-05', 'Deposit',     5200.00),
(16, '2024-01-10', 'Withdrawal',   700.00),
(17, '2024-01-15', 'Deposit',     3400.00),
(18, '2024-01-18', 'Transfer',     800.00);
00.00),
(6,  '2023-04-22', 'Transfer',     600.00),

(7,  '2023-05-01', 'Deposit',     8000.00),
(7,  '2023-05-19', 'Withdrawal',  1200.00),

(8,  '2023-06-03', 'Deposit',     2500.00),
(8,  '2023-06-20', 'Transfer',     400.00),

(9,  '2023-07-10', 'Deposit',     1800.00),
(9,  '2023-07-29', 'Withdrawal',   300.00),

(10, '2023-08-04', 'Deposit',     4500.00),
(10, '2023-08-18', 'Transfer',     900.00),

(11, '2023-09-01', 'Deposit',     2200.00),
(11, '2023-09-14', 'Withdrawal',   500.00),

(12, '2023-10-02', 'Deposit',     1600.00),
(12, '2023-10-22', 'Transfer',     350.00),

(13, '2023-11-05', 'Deposit',     7000.00),
(13, '2023-11-18', 'Withdrawal',   900.00),

(14, '2023-12-01', 'Deposit',     2800.00),
(14, '2023-12-20', 'Transfer',     600.00),

(15, '2024-01-05', 'Deposit',     5200.00),
(16, '2024-01-10', 'Withdrawal',   700.00),
(17, '2024-01-15', 'Deposit',     3400.00),
(18, '2024-01-18', 'Transfer',     800.00);
