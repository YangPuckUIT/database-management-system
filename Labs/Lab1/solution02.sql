create database Assignment2;
go

use Assignment2;
go

CREATE TABLE s_region (
    id VARCHAR(255) NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);


CREATE TABLE s_dept (
    id VARCHAR(255) NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    region_id VARCHAR(255),
    CONSTRAINT fk_dept_region FOREIGN KEY (region_id) REFERENCES s_region(id),
    CONSTRAINT uq_dept_name_region UNIQUE (name, region_id)
);


CREATE TABLE s_emp (
    id VARCHAR(255) NOT NULL PRIMARY KEY,
    last_name VARCHAR(255) NOT NULL,
    first_name VARCHAR(255),
    userid VARCHAR(255) NOT NULL UNIQUE,
    start_date DATETIME NOT NULL,
    comments VARCHAR(255),
    title VARCHAR(255),
    salary NUMERIC(11,2),
    commission_pct NUMERIC(4,2),
    dept_id VARCHAR(255),
    manager_id VARCHAR(255),
    CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) REFERENCES s_dept(id),
    CONSTRAINT fk_emp_manager FOREIGN KEY (manager_id) REFERENCES s_emp(id)
);


CREATE TABLE s_customer (
    id VARCHAR(255) NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    country VARCHAR(255),
    zip_code VARCHAR(255),
    credit_rating VARCHAR(255),
    comments VARCHAR(255),
    region_id VARCHAR(255),
    sales_rep_id VARCHAR(255),
    CONSTRAINT fk_cust_region FOREIGN KEY (region_id) REFERENCES s_region(id),
    CONSTRAINT fk_cust_emp FOREIGN KEY (sales_rep_id) REFERENCES s_emp(id)
);


CREATE TABLE s_product (
    id VARCHAR(255) NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    short_desc VARCHAR(255),
    suggested_whlsl_price NUMERIC(11,2),
    whlsl_units VARCHAR(255)
);


CREATE TABLE s_warehouse (
    id VARCHAR(255) NOT NULL PRIMARY KEY,
    address VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    country VARCHAR(255),
    zip_code VARCHAR(255),
    phone VARCHAR(255),
    region_id VARCHAR(255),
    manager_id VARCHAR(255),
    CONSTRAINT fk_wh_region FOREIGN KEY (region_id) REFERENCES s_region(id),
    CONSTRAINT fk_wh_emp FOREIGN KEY (manager_id) REFERENCES s_emp(id)
);


CREATE TABLE s_inventory (
    s_product_id VARCHAR(255) NOT NULL,
    s_warehouse_id VARCHAR(255) NOT NULL,
    amount_in_stock NUMERIC(9),
    reorder_point NUMERIC(9),
    max_in_stock NUMERIC(9),
    out_of_stock_explanation VARCHAR(255),
    restock_date DATETIME,
    CONSTRAINT pk_inventory PRIMARY KEY (s_product_id, s_warehouse_id),
    CONSTRAINT fk_inv_product FOREIGN KEY (s_product_id) REFERENCES s_product(id),
    CONSTRAINT fk_inv_wh FOREIGN KEY (s_warehouse_id) REFERENCES s_warehouse(id)
);


CREATE TABLE s_ord (
    id VARCHAR(255) NOT NULL PRIMARY KEY,
    date_ordered DATETIME NOT NULL,
    date_shipped DATETIME,
    total NUMERIC(11,2),
    payment_type VARCHAR(255) NOT NULL,
    order_filled VARCHAR(255),
    customer_id VARCHAR(255),
    sales_rep_id VARCHAR(255),
    CONSTRAINT fk_ord_customer FOREIGN KEY (customer_id) REFERENCES s_customer(id),
    CONSTRAINT fk_ord_emp FOREIGN KEY (sales_rep_id) REFERENCES s_emp(id)
);


CREATE TABLE s_item (
    item_id VARCHAR(255) NOT NULL,
    ord_id VARCHAR(255) NOT NULL,
    price NUMERIC(11,2),
    quantity NUMERIC(9),
    quantity_shipped NUMERIC(9),
    product_id VARCHAR(255) NOT NULL,
    CONSTRAINT pk_item PRIMARY KEY (item_id, ord_id),
    CONSTRAINT fk_item_order FOREIGN KEY (ord_id) REFERENCES s_ord(id),
    CONSTRAINT fk_item_product FOREIGN KEY (product_id) REFERENCES s_product(id)

);
