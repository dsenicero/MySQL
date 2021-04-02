-- CHAR, VARCHAR	A string of letters, symbols, and numbers.
-- INT, DECIMAL	Integer and decimal numbers that contain an exact value. 
-- FLOAT			Floating-point numbers that contain an approximate value.
-- DATE			Dates and times

SELECT 
    invoice_number, invoice_date, invoice_total
FROM
    invoices
WHERE
    invoice_date BETWEEN '2018-06-01' AND '2018-06-30'
ORDER BY invoice_date;

SELECT 
    invoice_id,
    invoice_id + 7 * 3 AS multiply_first,
    (invoice_id + 7) * 3 AS add_first
FROM
    invoices
ORDER BY invoice_id;

SELECT 
    CONCAT(vendor_name, '\'s Address: ') AS Vendor,
    CONCAT(vendor_city,
            ', ',
            vendor_state,
            ' ',
            vendor_zip_code) AS Address
FROM
    vendors;

SELECT 
    payment_total, LEFT(payment_total, 1)
FROM
    invoices;
    
SELECT 
    invoice_date 'Regular Date',
    DATE_FORMAT(invoice_date, '%m/%d/%y') AS 'MM/DD/YY',
    DATE_FORMAT(invoice_date, '%e-%b-%Y') AS 'DD-Mon-YYYY'
FROM
    invoices
ORDER BY invoice_date;

SELECT DISTINCT
    vendor_name 'Vendor Name',
    CONCAT(vendor_address1,
            ', ',
            vendor_city,
            ', ',
            vendor_state) 'Location',
    IFNULL(vendor_phone, 'NO PHONE') 'Phone Number',
    CONCAT(vendor_contact_first_name,
            ' ',
            vendor_contact_last_name) 'Vendor Contact'
FROM
    vendors
ORDER BY vendor_state , vendor_name;

SELECT 
    vendor_name,
    invoice_number,
    invoice_date,
    line_item_amount,
    account_description
FROM
    vendors v
        JOIN
    invoices i USING (vendor_id)
        JOIN
    invoice_line_items li USING (invoice_id)
        JOIN
    general_ledger_accounts gl USING (account_number)
WHERE
    invoice_total - payment_total - credit_total > 0
ORDER BY vendor_name , line_item_amount DESC;

SELECT 
    vendor_name,
    invoice_number,
    invoice_date,
    line_item_amount,
    account_description
FROM
    vendors v,
    invoices i,
    invoice_line_items li,
    general_ledger_accounts gl
WHERE
    v.vendor_name = i.vendor_name
        AND i.invoice_id = li.invoice_id
        AND li.account_number = gl.account_number
        AND invoice_total - payment_total - credit_total > 0
ORDER BY vendor_name , line_item_amount DESC;

use ex;
SELECT 
    department_name, last_name, project_number
FROM
    ex.departments d
        JOIN
    ex.employees e USING (department_number)
        LEFT JOIN
    ex.projects p USING (employee_id)
ORDER BY department_name , last_name;

SELECT 
    invoice_number, vendor_name
FROM
    ap.vendors
        NATURAL JOIN
    ap.invoices
ORDER BY invoice_number;

SELECT 
    department_name, last_name, project_number
FROM
    ex.departments
        JOIN
    ex.employees USING (department_number)
        LEFT JOIN
    ex.projects USING (employee_id)
ORDER BY department_name;

SELECT 
    invoice_number, vendor_name
FROM
    ap.vendors
        NATURAL JOIN
    ap.invoices
ORDER BY invoice_number;

SELECT 
    department_name AS dept_name, last_name, project_number
FROM
    ex.departments
        NATURAL JOIN
    ex.employees
        LEFT JOIN
    ex.projects USING (employee_id)
ORDER BY department_name;

SELECT 
    ex.departments.department_number,
    ex.departments.department_name,
    ex.employees.employee_id
FROM
    ex.departments,
    ex.employees
WHERE
    ex.departments.department_number = ex.employees.department_number
        AND ex.departments.department_number = 1
ORDER BY ex.departments.department_number;

SELECT 
    'Active' AS source,
    invoice_number,
    invoice_date,
    invoice_total
FROM
    ex.active_invoices
WHERE
    invoice_date >= '2018-06-01' 
UNION SELECT 
    'Paid' AS source,
    invoice_number,
    invoice_date,
    invoice_total
FROM
    ex.paid_invoices
WHERE
    invoice_date >= '2018-06-01'
ORDER BY invoice_total DESC;




use ap;
show columns from terms;
SELECT 
    *
FROM
    terms;
INSERT INTO terms values (6, 'Net due 120 days', 120);
UPDATE terms 
SET 
    terms_description = 'Net due 125 days',
    terms_due_days = 125
WHERE
    terms_id = 6;
DELETE FROM terms 
WHERE
    terms_id = 6;

SELECT 
    vendor_id,
    ROUND(AVG(invoice_total), 2) AS average_invoice_amount
FROM
    invoices
GROUP BY vendor_id
HAVING AVG(invoice_total) > 2000
ORDER BY average_invoice_amount DESC;

SELECT 
    vendor_name,
    vendor_state,
    ROUND(AVG(invoice_total), 2) AS average_invoice_amount
FROM
    vendors
        JOIN
    invoices ON vendors.vendor_id = invoices.vendor_id
GROUP BY vendor_name
HAVING AVG(invoice_total) > 2000
ORDER BY average_invoice_amount DESC;

SELECT 
    vendor_id, COUNT(*) AS invoice_qty
FROM
    invoices
GROUP BY vendor_id;

SELECT 
    vendor_state,
    vendor_city,
    COUNT(*) AS invoice_qty,
    ROUND(AVG(invoice_total), 2) AS invoice_avg
FROM
    invoices
        JOIN
    vendors ON invoices.vendor_id = vendors.vendor_id
GROUP BY vendor_state , vendor_city
ORDER BY vendor_state , vendor_city;

SELECT 
    vendor_state,
    vendor_city,
    COUNT(*) AS invoice_qty,
    ROUND(AVG(invoice_total), 2) AS invoice_avg
FROM
    invoices
        JOIN
    vendors ON invoices.vendor_id = vendors.vendor_id
GROUP BY vendor_state , vendor_city
HAVING COUNT(*) >= 2
ORDER BY vendor_state , vendor_city;

SELECT 
    vendor_name,
    COUNT(*) AS invoice_qty,
    ROUND(AVG(invoice_total), 2) AS invoice_avg
FROM
    vendors
        JOIN
    invoices ON vendors.vendor_id = invoices.vendor_id
GROUP BY vendor_name
HAVING AVG(invoice_total) > 500
ORDER BY invoice_qty DESC;

SELECT 
    vendor_name,
    COUNT(*) AS invoice_qty,
    ROUND(AVG(invoice_total), 2) AS invoice_avg
FROM
    vendors
        JOIN
    invoices ON vendors.vendor_id = invoices.vendor_id
WHERE
    invoice_total > 500
GROUP BY vendor_name
ORDER BY invoice_qty DESC;

SELECT 
    invoice_date,
    COUNT(*) AS invoice_qty,
    SUM(invoice_total) AS invoice_sum
FROM
    invoices
GROUP BY invoice_date
HAVING invoice_date BETWEEN '2018-05-01' AND '2018-05-31'
    AND COUNT(*) > 1
    AND SUM(invoice_total) > 100
ORDER BY invoice_date DESC;

SELECT 
    invoice_date,
    COUNT(*) AS invoice_qty,
    SUM(invoice_total) AS invoice_sum
FROM
    invoices
WHERE
    invoice_date BETWEEN '2018-05-01' AND '2018-05-31'
GROUP BY invoice_date
HAVING COUNT(*) > 1
    AND SUM(invoice_total) > 100
ORDER BY invoice_date DESC;

SELECT 
    vendor_id,
    COUNT(*) AS invoice_count,
    SUM(invoice_total) AS invoice_total
FROM
    invoices
GROUP BY vendor_id WITH ROLLUP;

SELECT 
    vendor_state, vendor_city, COUNT(*) AS qty_vendors
FROM
    vendors
WHERE
    vendor_state IN ('IA' , 'NJ')
GROUP BY vendor_state , vendor_city WITH ROLLUP;


SELECT 
    account_description, COUNT(*), SUM(line_item_amount)
FROM
    general_ledger_accounts gl
        JOIN
    invoice_line_items li USING (account_number)
GROUP BY account_number
HAVING COUNT(*) > 1;

SELECT 
    account_description,
    COUNT(*) AS line_item_count,
    SUM(line_item_amount) AS line_item_amt_sum
FROM
    general_ledger_accounts gl
        JOIN
    invoice_line_items li ON gl.account_number = li.account_number
GROUP BY gl.account_description
HAVING COUNT(*) > 1
ORDER BY line_item_amt_sum DESC

SELECT 
    account_description,
    COUNT(*) AS line_item_count,
    SUM(line_item_amount) AS line_item_amt_sum
FROM
    general_ledger_accounts gl
        JOIN
    invoice_line_items li ON gl.account_number = li.account_number
GROUP BY gl.account_description
HAVING COUNT(*) > 1
ORDER BY line_item_amt_sum DESC;

SELECT 
    account_description,
    COUNT(*) AS line_item_count,
    SUM(line_item_amount) AS line_item_amt_sum
FROM
    general_ledger_accounts gl
        JOIN
    invoice_line_items li ON gl.account_number = li.account_number
        JOIN
    invoices i ON li.invoice_id = i.invoice_id
WHERE
    invoice_date BETWEEN '2018-04-01' AND '2018-06-30'
GROUP BY gl.account_description
HAVING COUNT(*) > 1
ORDER BY line_item_amt_sum DESC;

SELECT 
    account_description,
    COUNT(*) AS line_item_count,
    SUM(line_item_amount) AS line_item_amt_sum
FROM
    general_ledger_accounts
        NATURAL JOIN
    invoice_line_items
        NATURAL JOIN
    invoices
WHERE
    invoice_date BETWEEN '2018-04-01' AND '2018-06-30'
GROUP BY account_description
HAVING COUNT(*) > 1
ORDER BY line_item_amt_sum DESC;

SELECT 
    li.account_number, SUM(line_item_amount)
FROM
    general_ledger_accounts gl
        JOIN
    invoice_line_items li ON gl.account_number = li.account_number
GROUP BY account_number WITH ROLLUP;

SELECT 
    vendor_name,
    COUNT(DISTINCT li.account_number) AS 'Number of Accounts'
FROM
    vendors v
        JOIN
    invoices i ON v.vendor_id = i.vendor_id
        JOIN
    invoice_line_items li ON i.invoice_id = li.invoice_id
GROUP BY vendor_name
HAVING COUNT(DISTINCT li.account_number) > 1
ORDER BY vendor_name;

SELECT 
    invoice_number, invoice_date, invoice_total
FROM
    invoices
WHERE
    invoice_total > (SELECT 
            AVG(invoice_total)
        FROM
            invoices)
ORDER BY invoice_total;

SELECT 
    invoice_number, invoice_date, invoice_total, vendor_state
FROM
    invoices
        JOIN
    vendors ON invoices.vendor_id = vendors.vendor_id
WHERE
    vendor_state = 'CA'
ORDER BY invoice_date;

SELECT 
    invoice_number, invoice_date, invoice_total
FROM
    invoices
WHERE
    vendor_id IN (SELECT 
            vendor_id
        FROM
            vendors
        WHERE
            vendor_state = 'CA')
ORDER BY invoice_date;

SELECT 
    vendor_id, vendor_name, vendor_state
FROM
    vendors
WHERE
    vendor_id NOT IN (SELECT DISTINCT
            vendor_id
        FROM
            invoices)
ORDER BY vendor_id;

SELECT 
    v.vendor_id, vendor_name, vendor_state
FROM
    vendors v
        LEFT JOIN
    invoices i ON v.vendor_id = i.vendor_id
WHERE
    i.vendor_id IS NULL
ORDER BY v.vendor_id;

SELECT 
    invoice_number,
    invoice_date,
    invoice_total - payment_total - credit_total AS balance_due
FROM
    invoices
WHERE
    invoice_total - payment_total - credit_total > 0
        AND invoice_total - payment_total - credit_total < (SELECT 
            AVG(invoice_total - payment_total - credit_total)
        FROM
            invoices
        WHERE
            invoice_total - payment_total - credit_total > 0)
ORDER BY invoice_total DESC;

SELECT 
    vendor_name, invoice_number, invoice_total
FROM
    invoices i
        JOIN
    vendors v ON i.vendor_id = v.vendor_id
WHERE
    invoice_total > ALL (SELECT 
            invoice_total
        FROM
            invoices
        WHERE
            vendor_id = 34)
ORDER BY vendor_name;

SELECT 
    vendor_id, invoice_number, invoice_total
FROM
    invoices i
WHERE
    invoice_total > (SELECT 
            AVG(invoice_total)
        FROM
            invoices
        WHERE
            vendor_id = i.vendor_id)
ORDER BY vendor_id , invoice_total;

SELECT DISTINCT
    vendor_name
FROM
    vendors
        JOIN
    invoices ON vendors.vendor_id = invoices.vendor_id
ORDER BY vendor_name;

SELECT 
    vendor_name
FROM
    vendors
WHERE
    vendor_id IN (SELECT 
            vendor_id
        FROM
            invoices);

SELECT 
    vendor_name
FROM
    vendors
WHERE
    vendor_id IN (SELECT 
            vendor_id
        FROM
            invoices)
ORDER BY vendor_name;


use ap;
SELECT 
    invoice_id,
    invoice_date,
    invoice_total,
    CAST(invoice_date AS CHAR (10)) AS char_date,
    CAST(invoice_total AS SIGNED) AS integer_total
FROM
    invoices;

SELECT 
    CONCAT(vendor_name,
            CHAR(13, 10),
            vendor_address1,
            CHAR(13, 10),
            vendor_city,
            ', ',
            vendor_state,
            ' ',
            vendor_zip_code)
FROM
    vendors
WHERE
    vendor_id = 1;
    
SELECT 
    vendor_name,
    CONCAT_WS(', ',
            vendor_contact_last_name,
            vendor_contact_first_name) AS contact_name,
    RIGHT(vendor_phone, 8) AS phone
FROM
    vendors
WHERE
    LEFT(vendor_phone, 4) = '(559'
ORDER BY contact_name;