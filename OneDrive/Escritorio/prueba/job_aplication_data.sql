-- Vizualizamos los datos de las diferentes tablas

SELECT TOP (5) * FROM genero$
SELECT TOP (5) * FROM clientes$
SELECT TOP (5) * FROM moneda$
SELECT TOP (5) * FROM productos$
GO
  
------------------------------------------------------------

-- Creamos una vista de clientes
  
CREATE VIEW v_clientes AS
SELECT 
  c.*, 
  g.DESCRIPCION,
  DATEDIFF(YEAR, FECHA_NACIMIENTO, GETDATE()) AS EDAD

FROM dbo.clientes$ c
  LEFT JOIN dbo.genero$ g 
    ON c.GENERO = g.COD_GENERO;
GO
  
------------------------------------------------------------

-- Visualizamos los datos de la vista recién creada
  
SELECT * FROM dbo.v_clientes
GO

------------------------------------------------------------

-- Creamos una vista de saldo de productos
  
CREATE VIEW v_saldos_productos AS
SELECT 
  TOP (5) p.*, 
  m.DESCRIPCION,
  m.COTIZACION,
  p.SALDO_CAPITAL + p.SALDO_INTERES AS SALDO_TOTAL

FROM dbo.productos$ p
  LEFT JOIN dbo.moneda$ m 
    ON p.MONEDA = m.COD_MONEDA
GO
  
-------------------------------------------------------------
  
-- Visualizar los datos de la vista recién creada
  
SELECT * FROM dbo.v_saldos_productos
GO
------------------------------------------------------------

-- Visualizamos la tabla y agregamos una columna de saldo en guaranies, resultado del producto entre el saldo total y la cotización.
  
  SELECT 
  *,
  SALDO_TOTAL * COTIZACION AS SALDO_GS
FROM dbo.v_saldos_productos
GO

------------------------------------------------------------

-- Visualizamos el tipo cartera y la sumatoria del saldo total en guaranies
  
SELECT 
  TIPO_CARTERA, 
  SUM(SALDO_TOTAL * COTIZACION) AS SALDO_GS

FROM dbo.v_saldos_productos
GROUP BY
  TIPO_CARTERA
GO

------------------------------------------------------------

-- Visualizamos los datos de la vista recién creada y lo ordenamos por fecha de nacimiento ascendente
  
SELECT * FROM dbo.v_clientes ORDER BY FECHA_NACIMIENTO ASC
GO
