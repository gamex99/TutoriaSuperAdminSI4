USE [SurFe]
GO
/****** Object:  Table [dbo].[cliente]    Script Date: 8/4/2024 17:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cliente](
	[id_cliente] [int] IDENTITY(1,1) NOT NULL,
	[razon_social] [varchar](50) NULL,
	[idCondicionIVA] [int] NOT NULL,
	[tipo_factura] [int] NULL,
	[cuit] [varchar](50) NULL,
	[domicilio] [varchar](50) NULL,
	[localidad] [int] NULL,
	[provincia] [int] NULL,
	[cp] [varchar](50) NULL,
	[telefono] [varchar](50) NULL,
	[anulado] [bit] NOT NULL,
	[dni] [varchar](50) NULL,
	[tipo_documento] [int] NULL,
	[email] [varchar](50) NULL,
	[barrio] [varchar](50) NULL,
 CONSTRAINT [PK_cliente] PRIMARY KEY CLUSTERED 
(
	[id_cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[condicionIVA]    Script Date: 8/4/2024 17:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[condicionIVA](
	[idCondicionIVA] [int] NOT NULL,
	[descripcion] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_condicionIVA] PRIMARY KEY CLUSTERED 
(
	[idCondicionIVA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[detalle_factura]    Script Date: 8/4/2024 17:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detalle_factura](
	[id_detalle] [int] NULL,
	[id_factura] [int] NULL,
	[id_producto] [int] NULL,
	[cantidad] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[factura]    Script Date: 8/4/2024 17:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[factura](
	[id_factura] [int] IDENTITY(1,1) NOT NULL,
	[id_cliente] [varchar](50) NULL,
	[tipo_documento] [varchar](50) NULL,
	[fecha] [varchar](50) NULL,
	[total] [decimal](18, 0) NULL,
 CONSTRAINT [PK_factura] PRIMARY KEY CLUSTERED 
(
	[id_factura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[localidad]    Script Date: 8/4/2024 17:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[localidad](
	[id] [int] NULL,
	[localidad] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[producto]    Script Date: 8/4/2024 17:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[producto](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[barcode] [int] NULL,
	[detalle] [varchar](50) NULL,
	[stock] [int] NULL,
	[precio] [decimal](18, 2) NULL,
 CONSTRAINT [PK_producto] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[provincia]    Script Date: 8/4/2024 17:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[provincia](
	[id] [int] NULL,
	[provincia] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipo_documento]    Script Date: 8/4/2024 17:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipo_documento](
	[id] [int] NULL,
	[descripcion] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipo_factura]    Script Date: 8/4/2024 17:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipo_factura](
	[id] [int] NULL,
	[descripcion] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[GetProducto]    Script Date: 8/4/2024 17:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProducto]
	@filtro VARCHAR(50) = NULL
AS
BEGIN
	SELECT 
      p.barcode,
	  p.detalle,
      p.stock
      ,p.precio
      
 
 FROM producto p
  WHERE 
    CONVERT(NVARCHAR, detalle) LIKE '%' + @filtro + '%';
END
GO
/****** Object:  StoredProcedure [dbo].[GetSurfe]    Script Date: 8/4/2024 17:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetSurfe]
--parametros
@filtro varchar(50) = null
AS
BEGIN
--cuerpo del procedimiento
SET NOCOUNT ON;
select c.id_cliente, c.razon_social, c.tipo_factura, c.cuit, c.domicilio, c.localidad, c.provincia, c.cp
, c.telefono, iva.descripcion CondicionIVA, c.anulado
from cliente c, condicionIVA iva
where c.idCondicionIVA =iva.idCondicionIVA and  ( Convert(nvarchar,c.id_cliente) like '%'+@filtro+'%'  or
(upper(razon_social ) like '%'+ upper(@filtro ) + '%' and anulado = 0))
END
GO
/****** Object:  StoredProcedure [dbo].[GetSurFeFinal]    Script Date: 8/4/2024 17:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Otros procedimientos, declaraciones, etc.

-- Nuevo procedimiento almacenado
CREATE PROCEDURE [dbo].[GetSurFeFinal]
    -- Parámetros
    @filtro VARCHAR(50) = NULL
AS
BEGIN
    -- Cuerpo del procedimiento
    SET NOCOUNT ON;

    SELECT 
    c.id_cliente, 
    c.razon_social, 
    c.tipo_factura, 
    c.cuit, 
    c.domicilio, 
    c.localidad, 
    c.provincia, 
    c.cp,
    c.telefono, 
    iva.descripcion AS CondicionIVA,
    c.idCondicionIVA,
    c.anulado,
    loc.localidad AS localidad_loc,
    prov.provincia AS provincia_prov,
    tf.descripcion AS tipofactura,
	td.descripcion as documento,
	c.tipo_documento,
	c.dni,
	c.email,
	c.barrio

FROM 
    cliente c
INNER JOIN 
    condicionIVA iva ON c.idCondicionIVA = iva.idCondicionIVA
LEFT JOIN 
    localidad loc ON c.localidad = loc.id
LEFT JOIN 
    provincia prov ON c.provincia = prov.id
LEFT JOIN 
    tipo_factura tf ON c.tipo_factura = tf.id
	LEFT JOIN 
	tipo_documento td on c.tipo_documento = td.id
WHERE 
    (CONVERT(NVARCHAR, c.id_cliente) LIKE '%' + @filtro + '%' AND c.anulado = 0) OR
    (UPPER(razon_social) LIKE '%' + UPPER(@filtro) + '%' AND c.anulado = 0);
END
GO
/****** Object:  StoredProcedure [dbo].[GetSurfeNuevo]    Script Date: 8/4/2024 17:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Otros procedimientos, declaraciones, etc.

-- Nuevo procedimiento almacenado
CREATE PROCEDURE [dbo].[GetSurfeNuevo]
    -- Parámetros
    @filtro VARCHAR(50) = NULL
AS
BEGIN
    -- Cuerpo del procedimiento
    SET NOCOUNT ON;

    SELECT 
        c.id_cliente, 
        c.razon_social, 
        c.tipo_factura, 
        c.cuit, 
        c.domicilio, 
        c.localidad, 
        c.provincia, 
        c.cp,
        c.telefono, 
        iva.descripcion AS CondicionIVA,
		c.idCondicionIVA,
		c.anulado
    FROM 
        cliente c
    INNER JOIN 
        condicionIVA iva ON c.idCondicionIVA = iva.idCondicionIVA
    WHERE 
        (CONVERT(NVARCHAR, c.id_cliente) LIKE '%' + @filtro + '%' AND c.anulado = 0) OR
        (UPPER(razon_social) LIKE '%' + UPPER(@filtro) + '%' AND c.anulado = 0);
END
GO
/****** Object:  StoredProcedure [dbo].[InsertarDetalleFactura]    Script Date: 8/4/2024 17:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarDetalleFactura]
    @id_factura INT,
    @id_producto INT,
    @cantidad INT
AS
BEGIN
    -- Insertar datos en la tabla de detalle_factura
    INSERT INTO detalle_factura (id_factura, id_producto, cantidad)
    VALUES (@id_factura, @id_producto, @cantidad);
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertFactura]    Script Date: 8/4/2024 17:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertFactura]
    @id_cliente varchar(50),
    @tipo_documento varchar(50),
    @fecha varchar(50),
    @total DECIMAL(18, 2)
AS
BEGIN
    

   

    -- Insertar factura
    INSERT INTO factura ([id_cliente], [tipo_documento], [fecha],[total])
    VALUES (@id_cliente, @tipo_documento, @fecha, @total);

    -- Obtener el ID generado de la factura
    select  SCOPE_IDENTITY()

    
END
GO
/****** Object:  StoredProcedure [dbo].[InsertSurfe]    Script Date: 8/4/2024 17:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertSurfe]
 @razon_social varchar(50),
 @idCondicionIVA int,
 @tipo_factura varchar(50),
@cuit varchar(50),
@domicilio varchar(50),
@localidad int,
@provincia varchar(50),
@cp varchar(50),
@telefono varchar(50),
@anulado bit,
@tipo_documento int,
@dni varchar(50),
@barrio varchar(50),
@email varchar(50)
AS
BEGIN
INSERT INTO [dbo].[cliente]
           ([razon_social]
           ,[idCondicionIVA]
           ,[tipo_factura]
           ,[cuit]
           ,[domicilio]
           ,[localidad]
           ,[provincia]
           ,[cp]
           ,[telefono]
           ,[anulado]
		   ,[tipo_documento]
		   ,[dni]
		   ,[barrio]
		   ,[email])
     VALUES
           ( @razon_social,
 @idCondicionIVA ,
 @tipo_factura,
@cuit,
@domicilio,
@localidad,
@provincia,
@cp,
@telefono,
0,
@tipo_documento,
@dni,
@barrio,
@email)
select SCOPE_IDENTITY()
end
GO
/****** Object:  StoredProcedure [dbo].[SelectProducto]    Script Date: 8/4/2024 17:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectProducto]
    @filtro NVARCHAR(255)  -- Puedes ajustar la longitud del filtro según tus necesidades
AS
BEGIN
    SET NOCOUNT ON;

    -- Tu consulta SELECT con el filtro
    SELECT *
    FROM producto -- Reemplaza "TuTabla" con el nombre de tu tabla
    WHERE CONVERT(NVARCHAR(MAX), barcode) = @filtro;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateSurfe]    Script Date: 8/4/2024 17:19:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateSurfe]
 @razon_social varchar(50),
 @idCondicionIVA int,
 @tipo_factura varchar(50),
@cuit varchar(50),
@domicilio varchar(50),
@localidad int,
@provincia varchar(50),
@cp varchar(50),
@telefono varchar(50),
@anulado bit,
@tipo_documento int,
@dni varchar(50),
@barrio varchar(50),
@email varchar(50)

AS
BEGIN
update cliente set
	razon_social = @razon_social,
	idCondicionIVA = @idCondicionIVA,
	tipo_factura = @tipo_factura,
	domicilio = @domicilio,
	localidad = @localidad,
	provincia = @provincia,
	cp = @cp,
	telefono = @telefono,
	anulado = @anulado,
	tipo_documento = @tipo_documento,
	dni = @dni,
	barrio = @barrio,
	email = email
where cuit = @cuit
end
GO
