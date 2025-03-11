/* 1. Identify revenue and potential revenue if all stock is sold */
SELECT 
    w.warehouseName, 
    SUM((p.MSRP - p.buyPrice) * od.quantityOrdered) AS TotalRevenue,
    SUM((p.MSRP - p.buyPrice) * p.quantityInStock) AS RevenueIfAllStockIsSold
FROM 
    products p
JOIN 
    warehouses w ON p.warehouseCode = w.warehouseCode
JOIN 
    orderdetails od ON p.productCode = od.productCode
GROUP BY 
    w.warehouseName
ORDER BY 
    TotalRevenue DESC;

/* 2. Analyze the top-selling products and their revenue */
SELECT 
    p.productName, 
    w.warehouseName, 
    SUM(od.quantityOrdered) AS TotalQuantitySold, 
    (SUM(od.quantityOrdered) * (p.MSRP - p.buyPrice)) AS TotalRevenue,
    p.quantityInStock
FROM 
    products p
JOIN 
    warehouses w ON p.warehouseCode = w.warehouseCode
JOIN 
    orderdetails od ON p.productCode = od.productCode
GROUP BY 
    p.productName, w.warehouseName, p.MSRP, p.buyPrice, p.quantityInStock
ORDER BY 
    TotalRevenue DESC;

/* 3. Identify inventory discrepancies across warehouses */
SELECT 
    p.productName,
    p.productLine,
    w.warehouseName,
    p.quantityInStock,
    SUM(od.quantityOrdered) AS TotalQuantityOrdered,
    (p.quantityInStock - SUM(od.quantityOrdered)) AS QuantityDifference
FROM 
    products p
JOIN 
    warehouses w ON p.warehouseCode = w.warehouseCode
JOIN 
    orderdetails od ON p.productCode = od.productCode
GROUP BY 
    p.productName, p.productLine, w.warehouseName, p.quantityInStock
ORDER BY 
    p.quantityInStock DESC;

/* 4. Identify high-demand months for strategic planning */
SELECT 
    YEAR(o.orderDate) AS Year,
    MONTH(o.orderDate) AS Month,
    SUM(od.quantityOrdered) AS TotalQuantityOrdered
FROM 
    orders o
JOIN 
    orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY 
    YEAR(o.orderDate), MONTH(o.orderDate)
ORDER BY 
    TotalQuantityOrdered DESC;

/* 5. See which warehouse has the most sales for each product type */
SELECT 
    p.productLine,
    w.warehouseName,
    SUM(od.quantityOrdered * (p.MSRP - p.buyPrice)) AS TotalRevenue,
    SUM(od.quantityOrdered) AS TotalUnitsSold,
    SUM(p.quantityInStock) AS TotalStockAvailable
FROM 
    products p
JOIN 
    orderdetails od ON p.productCode = od.productCode
JOIN 
    warehouses w ON p.warehouseCode = w.warehouseCode
GROUP BY 
    p.productLine, w.warehouseName
ORDER BY 
    TotalRevenue DESC;









