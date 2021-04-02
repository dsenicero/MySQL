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

