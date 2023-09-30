USE [Proyecto]
GO
/****** Object:  StoredProcedure [dbo].[AltaPedido]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Alter PROCEDURE [dbo].[AltaPedido] 
	-- Add the parameters for the stored procedure here
	@IdPedido int,
	@IdCliente int,
	@infoEnv varchar(40) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into Pedidos (idPedido, idCliente, fchPedido,estado, costo, informacionEntrega, viaje)
	values (@IdPedido, @IdCliente,(CONVERT(date,getdate())), 'Sin finalizar' ,0, @infoEnv, 'Sin asignar')
	


	
END
GO
/****** Object:  StoredProcedure [dbo].[AltaPedido_Lote]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Alter PROCEDURE [dbo].[AltaPedido_Lote] 
	-- Add the parameters for the stored procedure here
	@IdPedido int,
	@IdProducto int,
	@IdGranja int,
	@fchProduccion varchar(20),
	@Cantidad varchar(40),
	@CantLote varchar(40),
	@CantDisp varchar(40),
	@CantRess varchar(40)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin tran


	insert into Lotes_Pedidos (idPedido, idProducto, idGranja, fchProduccion, cantidad, cantidadViaje)
	Values (@IdPedido, @IdProducto, @IdGranja, CONVERT(DATE,@fchProduccion,103),  @Cantidad, '0') 
		if  @@ROWCOUNT>0   
	begin 



	Update Lotes set cantidad = @CantLote
	where idProducto = @IdProducto and
	idGranja = @IdGranja and 
	fchProduccion = CONVERT(DATE,@fchProduccion,103)
	end

	
	Update Productos set cantRes = @CantRess, cantTotal= @CantDisp
	where idProducto = @idProducto
	


	If not exists (Select * From Lotes_Pedidos Where idPedido = @IdPedido and 
	idProducto = @IdProducto and
	idGranja = @IdGranja and 
	fchProduccion =CONVERT(DATE,@fchProduccion,103))
	Begin
	raiserror('No se puedo crear el pedido del cliente',1,1);
		rollback;
	End

		Commit tran
	

	
END
GO
/****** Object:  StoredProcedure [dbo].[AltaPedido_Prod]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Alter PROCEDURE [dbo].[AltaPedido_Prod] 
	-- Add the parameters for the stored procedure here
	@IdPedido int,
	@IdProducto int,
	@Cantidad varchar(40),
	@CantidadRes varchar(40),
	@precio numeric(10,2)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin tran

	insert into Pedidos_Prod (idPedido, idProducto, cantidad)
	Values (@IdPedido, @IdProducto, @Cantidad) 
		if  @@ROWCOUNT>0   
	begin 

	Update Productos set cantRes = @CantidadRes
	where idProducto = @IdProducto 
	

	Update Pedidos set costo = @precio + costo
	where idPedido = @IdPedido

	end


	If not exists (Select * From Pedidos_Prod Where idPedido = @IdPedido)
	Begin
	raiserror('No se puedo crear el pedido del cliente',1,1);
		rollback;
	End

		Commit tran
	

	
END
GO
/****** Object:  StoredProcedure [dbo].[AltaViaje]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Alter PROCEDURE [dbo].[AltaViaje]
	@id int,
	@costo numeric(8,0),
	@fecha varchar(20),
	@camion int,
	@camionero int,
	@estado varchar(20)
AS
BEGIN

	BEGIN TRANSACTION
	insert into Viajes values (@id, @costo, @fecha, @camion, @camionero, @estado) 

	If not exists (Select * From Viajes Where idViaje = @id)
	Begin
	raiserror('No se pudo crear el Viaje',1,1);
		rollback;
	End

		Commit tran
	

END
GO
/****** Object:  StoredProcedure [dbo].[AltaViajePedido_Lote]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Alter  PROCEDURE [dbo].[AltaViajePedido_Lote] 
	-- Add the parameters for the stored procedure here
	@IdViaje int,
	@IdPedido int,
	@IdProducto int,
	@IdGranja int,
	@fchProduccion varchar(20),
	@Cantidad varchar(40),
	@CantViajeAct varchar(40)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin tran

	insert into Viajes_Lots_Ped(idViaje, idPedido, idProducto, idGranja, fchProduccion, cantidad)
	Values (@idViaje, @IdPedido, @IdProducto, @IdGranja, CONVERT(DATE,@fchProduccion,103),  @Cantidad) 
		if  @@ROWCOUNT>0   
	begin 



	Update Lotes_Pedidos set cantidadViaje = @Cantidad
	where idProducto = @IdProducto and
	idGranja = @IdGranja and 
	fchProduccion = CONVERT(DATE,@fchProduccion,103)
	and idPedido = @IdPedido
	end



	If not exists (Select * From Viajes_Lots_Ped Where idPedido = @IdPedido and 
	idProducto = @IdProducto and
	idGranja = @IdGranja and 
	fchProduccion =CONVERT(DATE,@fchProduccion,103) and 
	idViaje = @idViaje)
	Begin
	raiserror('No se puedo crear el Viaje de este Lote Pedido',1,1);
		rollback;
	End

		Commit tran
	

	
END
GO
/****** Object:  StoredProcedure [dbo].[BajaLotesPedido]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Alter PROCEDURE [dbo].[BajaLotesPedido]

@idPedido int, 
@IdGranja int,
@idProducto int,
@fchProduccion varchar(20),
@cantLote varchar(40),
@CantDisp varchar(40),
@CantRess varchar(40)


AS
BEGIN
	
	delete from Lotes_Pedidos
	where idPedido =@idPedido and idProducto = @idProducto 
	and idGranja = @IdGranja and fchProduccion = CONVERT(DATE,@fchProduccion,103)

		if  @@ROWCOUNT>0   
	begin 

	Update Lotes set cantidad = @cantLote
	where idProducto = @idProducto 
	and idGranja = @IdGranja and fchProduccion = CONVERT(DATE,@fchProduccion,103)

	
	Update Productos set cantRes = @CantRess, cantTotal= @CantDisp
	where idProducto = @idProducto
	
	



	end


END
GO
/****** Object:  StoredProcedure [dbo].[BajaPedido]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Alter PROCEDURE [dbo].[BajaPedido]

@idPedido int
AS
BEGIN

	SET NOCOUNT ON;
	Begin  Tran



	Delete from Pedidos
	Where idPedido = @idPedido

	if exists (Select * from Pedidos where idPedido = @idPedido) 
	or exists (Select * from Pedidos_Prod where idPedido = @idPedido) 
		begin
		raiserror('No se pudo borrar el Lote',1,1);
			rollback;
		end
	else
		begin
	
			Commit Tran
		end


END
GO
/****** Object:  StoredProcedure [dbo].[BajaPedidoProd]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Alter PROCEDURE [dbo].[BajaPedidoProd]

@idPedido int, 
@idProducto int,

@cantRess varchar(40),
@precio numeric(10,2)

AS
BEGIN
	
	delete from Pedidos_Prod 
	where idPedido =@idPedido and idProducto = @idProducto

		if  @@ROWCOUNT>0   
	begin 

	Update Productos set cantRes = @cantRess
	where idProducto = @IdProducto 
	

	Update Pedidos set costo = @precio 
	where idPedido = @IdPedido

	end


END
GO
/****** Object:  StoredProcedure [dbo].[BajaViaje]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter PROCEDURE  [dbo].[BajaViaje] 
@id int
As
BEGIN

	SET NOCOUNT ON;

	BEGIN TRANSACTION
	Delete from Viajes where idViaje = @id

	If exists (Select * From Viajes Where idViaje = @id)
	Begin
	raiserror('No se pudo borrar el viaje',1,1);
		rollback;
	End

	Commit tran
	

End
GO
/****** Object:  StoredProcedure [dbo].[BajaViajePedido_Lote]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Alter PROCEDURE [dbo].[BajaViajePedido_Lote]

@idViaje int, 
@idPedido int, 
@IdGranja int,
@idProducto int,
@fchProduccion varchar(20),
@CantTotal varchar(40)


AS
BEGIN
	
	delete from Viajes_Lots_Ped
	where idViaje = @idViaje and  idPedido =@idPedido and idProducto = @idProducto 
	and idGranja = @IdGranja and fchProduccion = CONVERT(DATE,@fchProduccion,103)

		if  @@ROWCOUNT>0   
	begin 

	Update Lotes_Pedidos set cantidadViaje = @CantTotal
	where idPedido =@idPedido and idProducto = @idProducto 
	and idGranja = @IdGranja and fchProduccion = CONVERT(DATE,@fchProduccion,103)


	
	



	end


END
GO
/****** Object:  StoredProcedure [dbo].[BuscarPedidoFiltro]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Alter PROCEDURE [dbo].[BuscarPedidoFiltro]
	@NombreCli varchar(40),
	@Estado varchar(40),
	@Viaje varchar(40),
	@CostoMin numeric(10,2),
	@CostoMax numeric(10,2),
	@ordenar varchar(40)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	if @ordenar = ''
	begin 
	Select idPedido, Per.idPersona as idCliente, Per.nombre as NombreCli, estado, P.viaje as viaje, costo, fchPedido, fechaEntre, informacionEntrega   
	from Pedidos P inner join Personas Per on Per.idPersona = P.idCliente
	inner join Clientes C on P.idCliente = C.idCliente

	Where C.usuario like '%' + @NombreCli + '%' and P.estado like @Estado + '%' and P.viaje like @Viaje + '%'
	
	and P.costo >= @CostoMin and P.costo <= @CostoMax
	order by idPedido
	end

	if @ordenar = 'Cliente'
	begin 
	Select idPedido, Per.idPersona as idCliente, Per.nombre as NombreCli, estado,  P.viaje as viaje, costo, fchPedido, fechaEntre, informacionEntrega   
	from Pedidos P inner join Personas Per on Per.idPersona = P.idCliente
	inner join Clientes C on P.idCliente = C.idCliente

	Where C.usuario like '%' + @NombreCli + '%' and P.estado like @Estado + '%' and P.viaje like @Viaje + '%'
	and P.costo >= @CostoMin and P.costo <= @CostoMax
	order by Per.nombre
	end

		if @ordenar = 'Estado'
	begin 
	Select idPedido, Per.idPersona as idCliente, Per.nombre as NombreCli, estado,  P.viaje as viaje, costo, fchPedido, fechaEntre, informacionEntrega   
	from Pedidos P inner join Personas Per on Per.idPersona = P.idCliente
	inner join Clientes C on P.idCliente = C.idCliente

	Where C.usuario like '%' + @NombreCli + '%' and P.estado like @Estado + '%' and P.viaje like @Viaje + '%'
	and P.costo >= @CostoMin and P.costo <= @CostoMax
	order by estado
	end

			if @ordenar = 'Viaje'
	begin 
	Select idPedido, Per.idPersona as idCliente, Per.nombre as NombreCli, estado,  P.viaje as viaje, costo, fchPedido, fechaEntre, informacionEntrega   
	from Pedidos P inner join Personas Per on Per.idPersona = P.idCliente
	inner join Clientes C on P.idCliente = C.idCliente

	Where C.usuario like '%' + @NombreCli + '%' and P.estado like @Estado + '%' and P.viaje like @Viaje + '%'
	and P.costo >= @CostoMin and P.costo <= @CostoMax
	order by P.viaje
	end


			if @ordenar = 'Costo'
	begin 
	Select idPedido, Per.idPersona as idCliente, Per.nombre as NombreCli, estado,  P.viaje as viaje, costo, fchPedido, fechaEntre, informacionEntrega   
	from Pedidos P inner join Personas Per on Per.idPersona = P.idCliente
	Where Per.nombre like '%' + @NombreCli + '%' and P.estado like @Estado + '%' and P.viaje like @Viaje + '%'
	and P.costo >= @CostoMin and P.costo <= @CostoMax
	order by costo
	end


			if @ordenar = 'Fecha del pedido'
		begin 
	Select idPedido, Per.idPersona as idCliente, Per.nombre as NombreCli, estado,  P.viaje as viaje, costo, fchPedido, fechaEntre,  informacionEntrega   
	from Pedidos P inner join Personas Per on Per.idPersona = P.idCliente
	inner join Clientes C on P.idCliente = C.idCliente

	Where C.usuario like '%' + @NombreCli + '%' and P.estado like @Estado + '%' and P.viaje like @Viaje + '%'
	and P.costo >= @CostoMin and P.costo <= @CostoMax
	order by fchPedido
	end
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarPedidoLote]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter PROCEDURE [dbo].[BuscarPedidoLote]

@idPedido int



AS
BEGIN

	SET NOCOUNT ON;

	SELECT L.idPedido as idPedido, P.idProducto as idProducto, P.nombre as nombreProd ,G.idGranja as idGranja,G.nombre as nomGranja , L.fchProduccion as fchProduccion ,P.tipo as tipo, P.precio as precio, P.imagen as imagen,
	L.cantidad as cantidad, P.cantTotal as cantTotal, P.cantRes as cantRes, L.cantidadViaje as cantidadViaje


	from Lotes_Pedidos L inner join  Productos P on L.idProducto = P.idProducto 
	inner join  Granjas G on L.idGranja = G.idGranja
	where L.idPedido = @idPedido 


END
GO
/****** Object:  StoredProcedure [dbo].[BuscarPedidoProd]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter PROCEDURE [dbo].[BuscarPedidoProd]

@idPedido int

AS
BEGIN

	SET NOCOUNT ON;

	SELECT Pp.idPedido as idPedido, Pp.idProducto as idProducto, P.nombre as nombre, P.tipo as tipo, P.precio as precio, P.imagen as imagen,
	Pp.cantidad as cantidad, P.cantTotal as cantTotal, P.cantRes as cantRes
	from Pedidos_Prod Pp inner join  Productos P 
	on Pp.idProducto = P.idProducto
	where Pp.idPedido = @idPedido
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarProductoCatFiltro]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Alter PROCEDURE [dbo].[BuscarProductoCatFiltro] 
@buscar varchar(40),
@tipo varchar(40),
@tipoVen varchar(40),
@ordenar varchar(40)
AS
BEGIN
	if @ordenar = 'Nombre'
		begin
		Select idProducto, nombre, tipo, tipoVenta, precio,  imagen, cantTotal, cantRes from Productos
		Where nombre LIKE '%' + @buscar + '%' and (tipo LIKE   @tipo + '%') and ( tipoVenta LIKE   @tipoVen + '%')
		and (cantTotal != '0') and (cantRes != cantTotal)
		order by nombre
		end
	if @ordenar = 'Tipo'
		begin
		Select idProducto, nombre, tipo, tipoVenta, precio,  imagen, cantTotal, cantRes from Productos 
		Where nombre LIKE '%' + @buscar + '%' and (tipo LIKE   @tipo + '%') and ( tipoVenta LIKE   @tipoVen + '%')
		and (cantTotal != '0') and (cantRes != cantTotal)

		order by tipo
		end
		if @ordenar = 'Tipo de venta'
		begin
		Select idProducto, nombre, tipo, tipoVenta,precio,  imagen, cantTotal, cantRes from Productos 
		Where nombre LIKE '%' + @buscar + '%' and (tipo LIKE   @tipo + '%') and ( tipoVenta LIKE   @tipoVen + '%')
		and (cantTotal != '0') and (cantRes != cantTotal)

		order by tipoVenta
		end
else 
		begin
		Select idProducto, nombre, tipo, tipoVenta, precio,  imagen, cantTotal, cantRes  from Productos 
		Where nombre LIKE '%' + @buscar + '%' and (tipo LIKE   @tipo + '%') and ( tipoVenta LIKE   @tipoVen + '%')
		and (cantTotal != '0') and (cantRes != cantTotal)
		order by idProducto
		end
END

GO
/****** Object:  StoredProcedure [dbo].[BuscarProductoCli]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Alter PROCEDURE [dbo].[BuscarProductoCli]
 @idProducto int,
 @idCliente int
AS
BEGIN
	select Pp.idPedido as idPedido   from Pedidos_Prod Pp inner join Pedidos  P on  Pp.idPedido = P.idPedido
	where Pp.idProducto = @idProducto and P.idCliente = @idCliente



END
GO
/****** Object:  StoredProcedure [dbo].[BuscarProductoFiltro]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Alter PROCEDURE [dbo].[BuscarProductoFiltro] 
@nombre varchar(40),
@tipo varchar(40),
@tipoVenta varchar(40),
@precioMenor numeric(6,0),
@precioMayor numeric(6,0),
@ordenar varchar(40)
AS
BEGIN
	if @ordenar = ''
	begin
		Select idProducto, nombre, tipo, tipoVenta, imagen, cantTotal, cantRes, precio from Productos 
		Where nombre LIKE '%' + @nombre + '%' and tipo LIKE + '%' + @tipo + '%' and tipoVenta LIKE + '%' + @tipoVenta + '%'
		and precio >= @precioMenor and precio <= @precioMayor
		order by idProducto
	end

	if @ordenar = 'Nombre'
	begin
		Select idProducto, nombre, tipo, tipoVenta, imagen, cantTotal, cantRes, precio from Productos 
		Where nombre LIKE '%' + @nombre + '%' and tipo LIKE + '%' + @tipo + '%' and tipoVenta LIKE + '%' + @tipoVenta + '%'
		and precio >= @precioMenor and precio <= @precioMayor
		order by nombre
	end

	if @ordenar = 'Tipo'
	begin
		Select idProducto, nombre, tipo, tipoVenta, imagen, cantTotal, cantRes, precio from Productos 
		Where nombre LIKE '%' + @nombre + '%' and tipo LIKE + '%' + @tipo + '%' and tipoVenta LIKE + '%' + @tipoVenta + '%'
		and precio >= @precioMenor and precio <= @precioMayor
		order by tipo
	end

	if @ordenar = 'Tipo de venta'
	begin
		Select idProducto, nombre, tipo, tipoVenta, imagen, cantTotal, cantRes, precio from Productos 
		Where nombre LIKE '%' + @nombre + '%' and tipo LIKE + '%' + @tipo + '%' and tipoVenta LIKE + '%' + @tipoVenta + '%'
		and precio >= @precioMenor and precio <= @precioMayor
		order by tipoVenta
	end

	if @ordenar = 'Precio'
	begin
		Select idProducto, nombre, tipo, tipoVenta, imagen, cantTotal, cantRes, precio from Productos 
		Where nombre LIKE '%' + @nombre + '%' and tipo LIKE + '%' + @tipo + '%' and tipoVenta LIKE + '%' + @tipoVenta + '%'
		and precio >= @precioMenor and precio <= @precioMayor
		order by precio
	end
END

GO
/****** Object:  StoredProcedure [dbo].[listPedido]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Alter PROCEDURE [dbo].[listPedido] 
	-- Add the parameters for the stored procedure here
@idCli int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT idPedido, idCliente estado, fchPedido from Pedidos_Cli

END
GO
/****** Object:  StoredProcedure [dbo].[listPedidoCli]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Alter PROCEDURE [dbo].[listPedidoCli] 
	-- Add the parameters for the stored procedure here
@idCli int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT idPedido, idCliente, estado, fchPedido, costo, informacionEntrega from Pedidos
	where idCliente = @idCli
END
GO
/****** Object:  StoredProcedure [dbo].[listPedidoCli_Prod]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Alter PROCEDURE [dbo].[listPedidoCli_Prod] 
	-- Add the parameters for the stored procedure here
@idProducto int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT idPedido, idProducto, cantidad  from Pedidos_Prod
	where idProducto = @idProducto
END
GO
/****** Object:  StoredProcedure [dbo].[ModCantPedidoCli]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Alter PROCEDURE [dbo].[ModCantPedidoCli]

@idPedido int, 
@idProducto int,
@cant varchar(40),
@cantRess varchar(40),
@precio numeric(10,2)

AS
BEGIN
	
	update Pedidos_Prod set cantidad = @cant
	where idPedido =@idPedido and idProducto = @idProducto

		if  @@ROWCOUNT>0   
	begin 

	Update Productos set cantRes = @cantRess
	where idProducto = @IdProducto 
	

	Update Pedidos set costo = @precio 
	where idPedido = @IdPedido

	end


END
GO
/****** Object:  StoredProcedure [dbo].[ModCantPedidoLote]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Alter PROCEDURE [dbo].[ModCantPedidoLote]

@idPedido int,
@idGranja int,
@idProducto int,
@fchProduccion varchar(40),
@Cantidad varchar(40),
@CantLote varchar(40),
@CantDisp varchar(40),
@CantRess varchar(40)

AS
BEGIN
	
	update Lotes_Pedidos set cantidad = @Cantidad
	where idPedido =@idPedido and 
	idGranja = @idGranja and
	idProducto = @idProducto and
	fchProduccion = CONVERT(DATE,@fchProduccion,103)

		if  @@ROWCOUNT>0   
	begin 

	Update Lotes set cantidad = @CantLote
	where idProducto = @IdProducto and
	idGranja = @IdGranja and 
	fchProduccion = CONVERT(DATE,@fchProduccion,103)

	Update Productos set cantRes = @CantRess, cantTotal= @CantDisp
	where idProducto = @idProducto
	
	end


END
GO
/****** Object:  StoredProcedure [dbo].[ModificarViaje]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter PROCEDURE [dbo].[ModificarViaje]
	@id int,
	@costo numeric(8,0),
	@fecha varchar(20),
	@camion int,
	@camionero int,
	@estado varchar(20)

AS
BEGIN
    UPDATE Viajes SET costo = @costo, fecha = @fecha, idCamion = @camion, idCamionero = @camionero, estado = @estado  where idViaje = @id

	IF @estado = 'En viaje'
	begin
		UPDATE Camiones SET disponible = 'No disponible' where idCamion = @camion
		UPDATE Camioneros SET disponible = 'No disponible' where idCamionero = @camionero
	end
	IF @estado = 'Finalizado'
	begin
		UPDATE Camiones SET disponible = 'Disponible' where idCamion = @camion
		UPDATE Camioneros SET disponible = 'Disponible' where idCamionero = @camionero
	end
END
GO
/****** Object:  StoredProcedure [dbo].[ModPedViajeEst]    Script Date: 30/9/2023 1:22:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter  PROCEDURE [dbo].[ModPedViajeEst]

	@idPedido int,
	@estado varchar(20)

AS
BEGIN
   
	IF @estado = 'Confirmado' 
	begin
		Update Pedidos Set viaje = 'Asignado'
		where idPedido = @idPedido
	end
	IF @estado = 'Pendiente'
	begin
	Update Pedidos Set viaje = 'Sin asignar'
		where idPedido = @idPedido
	end
END
GO

Alter PROCEDURE [dbo].[ModCantPedidoCli]

@idPedido int, 
@idProducto int,
@cant varchar(40),
@cantRess varchar(40),
@precio numeric(10,2)

AS
BEGIN
	
	update Pedidos_Prod set cantidad = @cant
	where idPedido =@idPedido and idProducto = @idProducto

		if  @@ROWCOUNT>0   
	begin 

	Update Productos set cantRes = @cantRess
	where idProducto = @IdProducto 
	

	Update Pedidos set costo = @precio 
	where idPedido = @IdPedido

	end


END