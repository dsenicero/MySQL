SELECT 
    invoice_number, invoice_date, invoice_total
FROM
    invoices i
        JOIN
    vendors v USING (vendor_id)
WHERE
    vendor_state = 'TX'
ORDER BY invoice_date;

SELECT 
    vendor_name, vendor_city, vendor_state
FROM
    vendors
WHERE
    vendor_id IN (SELECT 
            vendor_id
        FROM
            vendors
        WHERE
            vendor_state = 'TX')
GROUP BY vendor_name;

SELECT 
    vendor_name
FROM
    vendors
WHERE
    vendor_state = 'TX';
        
SELECT 
    vendor_name,
    COUNT(*) AS number_of_invoices,
    MAX(invoice_total - payment_total - credit_total) AS balance_due
FROM
    vendors v
        JOIN
    invoices i ON v.vendor_id = i.vendor_id
WHERE
    invoice_total - payment_total - credit_total > (SELECT 
            AVG(invoice_total - payment_total - credit_total)
        FROM
            invoices)
GROUP BY vendor_name
ORDER BY balance_due DESC;

SELECT 
    v.vendor_name,
    i.invoice_number,
    i.invoice_date,
    i.invoice_total
FROM
    vendors v
        JOIN
    invoices i ON i.vendor_id = v.vendor_id
        AND i.invoice_date = (SELECT 
            MIN(invoice_date)
        FROM
            invoices
        WHERE
            vendor_id = v.vendor_id)
WHERE
    DATEDIFF(invoice_due_date, invoice_date) < 14
ORDER BY i.invoice_total DESC;

SELECT 
    vendor_name,
    invoice_number,
    invoice_date,
    invoice_due_date,
    invoice_total
FROM
    invoices i
        JOIN
    vendors v ON i.vendor_id = v.vendor_id
WHERE
    invoice_date = (SELECT 
            MIN(invoice_date)
        FROM
            invoices
        WHERE
            vendor_id = i.vendor_id)
        AND DATEDIFF(invoice_due_date, invoice_date) < 14
ORDER BY vendor_name;

SELECT 
    invoice_id,
    invoice_date,
    invoice_total,
    CAST(invoice_date AS CHAR (10)) AS char_date,
    CAST(invoice_total AS SIGNED) AS integer_total
FROM
    invoices;

SELECT 
    account_number, SUM(line_item_amount)
FROM
    invoice_line_items
WHERE
    line_item_amount > 2000
GROUP BY account_number WITH ROLLUP;

SELECT 
    account_number, SUM(line_item_amount)
FROM
    invoice_line_items
GROUP BY account_number WITH ROLLUP;

SELECT 
    account_number, line_item_amount
FROM
    invoice_line_items
WHERE
    line_item_amount > 2000
GROUP BY account_number WITH ROLLUP;

SELECT 
    CONCAT('$',
            CONVERT( invoice_total , DECIMAL (9 , 2 ))) as 'column'
FROM
    invoices;

SELECT 
    CONCAT('$', FORMAT(invoice_total, 2))
FROM
    invoices;

SELECT 
    vendor_name, vendor_city, vendor_state
FROM
    vendors
WHERE
    CONCAT(vendor_state, vendor_city) NOT IN (SELECT 
            CONCAT(vendor_state, vendor_city) AS vendor_city_state
        FROM
            vendors
        GROUP BY vendor_city_state
        HAVING COUNT(*) > 1)
ORDER BY vendor_state , vendor_city;

SELECT 
    account_description, COUNT(*), SUM(line_item_amount)
FROM
    general_ledger_accounts
        JOIN
    invoice_line_items USING (account_number)
GROUP BY account_description
HAVING COUNT(*) > 1
ORDER BY 3 DESC;


SELECT 
    vendor_name, invoice_number, invoice_total
FROM
    invoices i
        JOIN
    vendors v ON i.vendor_id = v.vendor_id
WHERE
    invoice_total > (SELECT 
            MAX(invoice_total)
        FROM
            invoices
        WHERE
            vendor_id = 34)
ORDER BY vendor_name;

#MONTH(), DAYOFMONTH(), YEAR(), and DATE_FORMAT()
#EXTRACT(), HOUR_SECOND(), HOUR(), HOUR_MINUTE()
#CASE/WHEN/THEN and IF Statements

select year();

SELECT 
    *
FROM
    invoices;
SELECT 
    invoice_id,
    ROUND(AVG(DATEDIFF(invoice_due_date, invoice_date))) AS avg_due_date
FROM
    invoices
GROUP BY invoice_id;

SELECT 
    float_value
FROM
    float_sample
WHERE
    ROUND(float_value, 2) = 5.00;

SELECT 
    invoice_number,
    invoice_date,
    DATE_ADD(invoice_date, INTERVAL 30 DAY) AS 'Date plus 30',
    payment_date,
    DATEDIFF(payment_date, invoice_date) AS 'Days to Pay'
FROM
    invoices;

SELECT CONCAT('$', FORMAT(12587.44, 2));

SELECT 
    vendor_contact_first_name,
    vendor_contact_last_name,
    CONCAT(LEFT(vendor_contact_first_name, 1),
            LEFT(vendor_contact_last_name, 1)) AS initials
FROM
    vendors;

SELECT 
    invoice_date,
    invoice_total,
    ROUND(invoice_total) AS nearest_dollar,
    ROUND(invoice_total, 1) AS nearest_dime
FROM
    invoices
ORDER BY invoice_date;

SELECT 1000 * (1 + .1) AS '10% More Than 1000';

SELECT 
    'Ed' AS first_name,
    'Williams' AS last_name,
    CONCAT(LEFT('Ed', 1), LEFT('Williams', 1)) AS initials;
    
SELECT 
    CURRENT_DATE,
    DATE_FORMAT(CURRENT_DATE, '%m/%d/%y') AS 'MM/DD/YY',
    DATE_FORMAT(CURRENT_DATE, '%e-%b-%Y') AS 'DD-Mon-YYYY';
    
SELECT 
    CURRENT_DATE,
    DATE_FORMAT(CURRENT_DATE, '%m/%d/%y') AS 'MM/DD/YY',
    DATE_FORMAT(CURRENT_DATE, '%e-%b-%Y') AS 'DD-Mon-YYYY',
    SYSDATE(),
    DATE_FORMAT(SYSDATE(), '%m/%d/%y') AS 'MM/DD/YY',
    DATE_FORMAT(SYSDATE(), '%e-%b-%Y') AS 'DD-Mon-YYYY';

SELECT 
    12345.6789 AS value,
    ROUND(12345.6789) AS nearest_dollar,
    ROUND(12345.6789, 1) AS nearest_dime;

SELECT 
    vendor_id, vendor_city, vendor_state
FROM
    vendors
WHERE
    vendor_id IN (50 , 51, 52, 53, 54, 55, 56, 57, 58, 59, 60)
ORDER BY vendor_id;

SELECT 
    vendor_id, vendor_city, vendor_state
FROM
    vendors
WHERE
    vendor_id IN (SELECT 
            vendor_id
        FROM
            vendors
        WHERE
            vendor_id >= 50 AND vendor_id <= 60)
ORDER BY vendor_id;
select vendor_id, vendor_city, vendor_state from vendors where vendor_id between 50 and 60 ORDER BY vendor_id;
SELECT DISTINCT
    vendor_city, vendor_state
FROM
    vendors
ORDER BY vendor_city;

