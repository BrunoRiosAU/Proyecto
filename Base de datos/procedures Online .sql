USE [DBfrutasYverduras]
GO
/****** Object:  StoredProcedure [dbo].[AltaAdmin]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AltaAdmin]
	-- Add the parameters for the stored procedure here
	@id int,
	@nombre varchar(40),
	@apellido varchar(40),
	@email varchar(40),
	@tele varchar (40),
	@fchNac varchar (40),
	@user varchar(40),
	@pass varchar(40),
	@TipoAdm varchar(40),
	@estado varchar(40),
	@idAdmin int

	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
BEGIN TRANSACTION
	 insert into Personas (idPersona, nombre, apellido, email, telefono, fchNacimiento) 
	Values (@id, @nombre, @apellido, @email, @tele, @fchNac)
	
	if  @@ROWCOUNT>0   
	begin 
	insert into Admins(idAdmin,usuario,contrasena,tipoDeAdmin, estado) 
	Values (@id, @user, @pass, @TipoAdm, @estado) 
	end 



	If not exists (Select * From Personas Where idPersona = @id) or not exists (Select * From Admins Where idAdmin = @id)
	Begin
	raiserror('No se puedo crear la persona/admin',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Admins', 'Alta');
	end

	Commit tran
	

END
GO
/****** Object:  StoredProcedure [dbo].[AltaCam]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AltaCam]
	-- Add the parameters for the stored procedure here
	@id int,
	@marca varchar(40),
	@modelo varchar(40),
	@carga numeric(10,2),
	@disponible varchar (40),
	@idAdmin int


	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
BEGIN TRANSACTION
	 insert into Camiones (idCamion, marca, modelo, carga, disponible) 
	Values (@id, @marca, @modelo, @carga, @disponible)
	


	If not exists (Select * From Camiones Where idCamion = @id)
	Begin
	raiserror('No se puedo crear el Camion',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Camiones', 'Alta');
	end

		Commit tran
	

END
GO
/****** Object:  StoredProcedure [dbo].[AltaCamionero]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[AltaCamionero]
	@id int,
	@nombre varchar(40),
	@apellido varchar(40),
	@email varchar(40),
	@tele varchar (40),
	@fchNac varchar (20),
	@cedula varchar(11),
	@disp varchar(20),
	@manejo varchar(20),
	@idAdmin int

	
AS
BEGIN
BEGIN TRANSACTION

	insert into Personas (idPersona, nombre, apellido, email, telefono, fchNacimiento) 
	values (@id, @nombre, @apellido, @email, @tele, @fchNac)
	if @@ROWCOUNT > 0
	begin
		insert into Camioneros(idCamionero, cedula, disponible, fchManejo) 
		values (@id, @cedula, @disp, @manejo)
	end

		If not exists (Select * From Personas Where idPersona = @id) or not exists (Select * From Camioneros Where idCamionero = @id)
	Begin
	raiserror('No se puedo crear la persona/camionero',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin,CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Camioneros', 'Alta');
	end

		Commit tran

		End



GO
/****** Object:  StoredProcedure [dbo].[AltaCli]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AltaCli]
	-- Add the parameters for the stored procedure here
	@id int,
	@nombre varchar(40),
	@apellido varchar(40),
	@email varchar(40),
	@tele varchar (40),
	@fchNac varchar (40),
	@user varchar(40),
	@pass varchar(40),
	@dirr varchar(40)


	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
BEGIN TRANSACTION
	 insert into Personas (idPersona, nombre, apellido, email, telefono, fchNacimiento) 
	Values (@id, @nombre, @apellido, @email, @tele, @fchNac)
	
	if  @@ROWCOUNT>0   
	begin 
	insert into Clientes(idCliente,usuario,contrasena,direccion) 
	Values (@id, @user, @pass, @dirr) 
	end 



	If not exists (Select * From Personas Where idPersona = @id) or not exists (Select * From Clientes Where idCliente = @id)
	Begin
	raiserror('No se puedo crear la persona/Cliente',1,1);
		rollback;
	End

		Commit tran
	

END
GO
/****** Object:  StoredProcedure [dbo].[AltaDeposito]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AltaDeposito]
	@id int,
	@capacidad varchar(20),
	@ubicacion varchar(50),
	@temperatura numeric(3,0),
	@condiciones varchar(80),
	@idAdmin int
AS
BEGIN
	SET NOCOUNT ON;

BEGIN TRANSACTION
	insert into Depositos values (@id, @capacidad, @ubicacion, @temperatura, @condiciones) 

	If not exists (Select * From Depositos Where idDeposito = @id)
	Begin
	raiserror('No se pudo crear el Deposito',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Depositos', 'Alta');
	end

	Commit tran
	

END
GO
/****** Object:  StoredProcedure [dbo].[AltaFerti]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[AltaFerti]
	@id int,
	@nombre varchar(40),
	@tipo varchar(40),
	@pH numeric(4,2),
	@impacto varchar(30),
	@idAdmin int
AS
BEGIN
	SET NOCOUNT ON;

BEGIN TRANSACTION
	insert into Fertilizantes values (@id, @nombre, @tipo, @pH, @impacto) 

	If not exists (Select * From Fertilizantes Where idFerti = @id)
	Begin
	raiserror('No se pudo crear el Fertilizante',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Fertilizantes', 'Alta');
	end

		Commit tran
	

END
GO
/****** Object:  StoredProcedure [dbo].[AltaGranja]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AltaGranja]
	@id int,
	@nombre varchar(30),
	@ubicacion varchar(50),
	@idCliente int,
	@idAdmin int
AS
BEGIN
	SET NOCOUNT ON;

BEGIN TRANSACTION
	insert into Granjas values (@id, @nombre, @ubicacion, @idCliente) 
	If not exists (Select * From Granjas Where idGranja = @id)
	Begin
	raiserror('No se pudo crear la Granja',1,1);
		rollback;
	End
	else
	begin 
	insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Granja', 'Alta');
	end
Commit tran
END
GO
/****** Object:  StoredProcedure [dbo].[AltaLote]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AltaLote]
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20),
	@fchCaducidad varchar(20),
	@cantidad varchar(40),
	@precio numeric(10,2),
	@idDeposito int,
	@cantTotal varchar(40),
	@idAdmin int
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRANSACTION
	insert into Lotes(idGranja, idProducto, fchProduccion, fchCaducidad, cantidad, precio, idDeposito) values (@idGranja, @idProducto, @fchProduccion, @fchCaducidad, @cantidad, @precio, @idDeposito) 
	If not exists (Select * From Lotes Where idGranja = @idGranja and idProducto = @idProducto and fchProduccion = @fchProduccion)
	Begin
	raiserror('No se pudo crear el Lote',1,1);
		rollback;
	End
	else
	begin
		Commit tran 
		Update Productos set CantTotal = @cantTotal 
		where idProducto = @idProducto

		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Lotes', 'Alta');

	end

END

GO
/****** Object:  StoredProcedure [dbo].[AltaLoteFerti]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AltaLoteFerti]
	@idFertilizante int,
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20),
	@cantidad varchar(30),
	@idAdmin int
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRANSACTION
	insert into Lotes_Fertis values(@idFertilizante, @idGranja, @idProducto,  format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd'), @cantidad)
	If not exists (Select * From Lotes_Fertis Where idFertilizante = @idFertilizante and idGranja = @idGranja and idProducto = @idProducto and fchProduccion = format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd'))
	Begin
	raiserror('No se pudo crear el Lote_Ferti',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Lotes Fertis', 'Alta');
	end
	
Commit tran
END



GO
/****** Object:  StoredProcedure [dbo].[AltaLotePesti]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AltaLotePesti]
	@idPesticida int,
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20),
	@cantidad varchar(30),
	@idAdmin int
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRANSACTION
	insert into Lotes_Pestis values(@idPesticida, @idGranja, @idProducto, format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd'), @cantidad)
	If not exists (Select * From Lotes_Pestis Where idPesticida = @idPesticida and idGranja = @idGranja and idProducto = @idProducto and fchProduccion = format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd'))
	Begin
	raiserror('No se pudo crear el Lote_Pesti',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Lotes Pestis', 'Alta');
	end
	
Commit tran
END
GO
/****** Object:  StoredProcedure [dbo].[AltaPedido]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AltaPedido] 
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
/****** Object:  StoredProcedure [dbo].[AltaPedido_Lote]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AltaPedido_Lote] 
	-- Add the parameters for the stored procedure here
	@IdPedido int,
	@IdProducto int,
	@IdGranja int,
	@fchProduccion varchar(20),
	@Cantidad varchar(40),
	@CantLote varchar(40),
	@CantDisp varchar(40),
	@CantRess varchar(40),
	@idAdmin int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin tran


	insert into Lotes_Pedidos (idPedido, idProducto, idGranja, fchProduccion, cantidad, cantidadViaje)
	Values (@IdPedido, @IdProducto, @IdGranja, format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd'),  @Cantidad, '0') 
		if  @@ROWCOUNT>0   
	begin 



	Update Lotes set cantidad = @CantLote
	where idProducto = @IdProducto and
	idGranja = @IdGranja and 
	fchProduccion = format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd')
	end

	
	Update Productos set cantRes = @CantRess, cantTotal= @CantDisp
	where idProducto = @idProducto
	


	If not exists (Select * From Lotes_Pedidos Where idPedido = @IdPedido and 
	idProducto = @IdProducto and
	idGranja = @IdGranja and 
	fchProduccion =format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd'))
	Begin
	raiserror('No se puedo asignar la cantidad de lote al pedido',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Lotes Pedidos', 'Alta');
	end

		Commit tran
	

	
END
GO
/****** Object:  StoredProcedure [dbo].[AltaPedido_Prod]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AltaPedido_Prod] 
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
/****** Object:  StoredProcedure [dbo].[AltaPesti]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[AltaPesti]
	@id int,
	@nombre varchar(40),
	@tipo varchar(40),
	@pH numeric(4,2),
	@impacto varchar(30),
	@idAdmin int
AS
BEGIN
	SET NOCOUNT ON;

BEGIN TRANSACTION
	insert into Pesticidas values (@id, @nombre, @tipo, @pH, @impacto) 

	If not exists (Select * From Pesticidas Where idPesti = @id)
	Begin
	raiserror('No se pudo crear el Pesticida',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Pesticidas', 'Alta');
	end
		Commit tran
	

END
GO
/****** Object:  StoredProcedure [dbo].[AltaProducto]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AltaProducto]
	@id int,
	@nombre varchar(30),
	@tipo varchar(30),
	@tipoVenta varchar(15),
	@precio numeric(6,0),
	@imagen varchar(MAX),
	@idAdmin int
	
AS
BEGIN
	SET NOCOUNT ON;

BEGIN TRANSACTION
	insert into Productos (idProducto, nombre,precio,tipo,tipoVenta,imagen, cantTotal,cantRes) values (@id, @nombre, @precio, @tipo, @tipoVenta, @imagen, 0, 0) 
	If not exists (Select * From Productos Where idProducto = @id)
	Begin
	raiserror('No se pudo crear el Producto',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Productos', 'Alta');
	end
Commit tran
END
GO
/****** Object:  StoredProcedure [dbo].[AltaViaje]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AltaViaje]
	@id int,
	@costo numeric(8,0),
	@fecha varchar(20),
	@camion int,
	@camionero int,
	@estado varchar(20),
	@idAdmin int
AS
BEGIN

	BEGIN TRANSACTION
	insert into Viajes values (@id, @costo, @fecha, @camion, @camionero, @estado) 

	If not exists (Select * From Viajes Where idViaje = @id)
	Begin
	raiserror('No se pudo crear el Viaje',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Viajes', 'Alta');
	end

		Commit tran
	

END
GO
/****** Object:  StoredProcedure [dbo].[AltaViajePedido_Lote]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE  PROCEDURE [dbo].[AltaViajePedido_Lote] 
	-- Add the parameters for the stored procedure here
	@IdViaje int,
	@IdPedido int,
	@IdProducto int,
	@IdGranja int,
	@fchProduccion varchar(20),
	@Cantidad varchar(40),
	@CantViajeAct varchar(40),
	@idAdmin int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin tran

	insert into Viajes_Lots_Ped(idViaje, idPedido, idProducto, idGranja, fchProduccion, cantidad)
	Values (@idViaje, @IdPedido, @IdProducto, @IdGranja, format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd'),  @Cantidad) 
		if  @@ROWCOUNT>0   
	begin 



	Update Lotes_Pedidos set cantidadViaje = @Cantidad
	where idProducto = @IdProducto and
	idGranja = @IdGranja and 
	fchProduccion =format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd')
	and idPedido = @IdPedido
	end



	If not exists (Select * From Viajes_Lots_Ped Where idPedido = @IdPedido and 
	idProducto = @IdProducto and
	idGranja = @IdGranja and 
	fchProduccion =format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd') and 
	idViaje = @idViaje)
	Begin
	raiserror('No se puedo crear el Viaje de este Lote Pedido',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Viajes Lotes Pedidos', 'Alta');
	end

		Commit tran
	

	
END
GO
/****** Object:  StoredProcedure [dbo].[BajaAdmin]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[BajaAdmin] @id int, @idAdmin int
As
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from

	SET NOCOUNT ON;

	BEGIN TRANSACTION
	Delete from Admins where idAdmin = @id
	
	if  @@ROWCOUNT>0   
	begin 
	Delete from Personas where idPersona = @id
	end 
	If exists (Select * From Personas Where idPersona = @id) or exists (Select * From Admins Where idAdmin = @id)
	Begin
	raiserror('No se puedo borrar la persona/admin',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Admins', 'Baja');
		
	end
	Commit tran
		
	

End
GO
/****** Object:  StoredProcedure [dbo].[BajaCam]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[BajaCam] @id int, @idAdmin int
As
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from

	SET NOCOUNT ON;

	BEGIN TRANSACTION
	Delete from Camiones where idCamion = @id

	If exists (Select * From Camiones Where idCamion = @id)
	Begin
	raiserror('No se puedo borrar el camion',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Camiones', 'Baja');
	end
		Commit tran
	

End
GO
/****** Object:  StoredProcedure [dbo].[BajaCamionero]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[BajaCamionero]
	@id int,
	@idAdmin int
AS
BEGIN
	Begin Tran

	DELETE FROM Camioneros WHERE idCamionero = @id
	if @@ROWCOUNT > 0
	begin
		DELETE FROM Personas WHERE idPersona = @id
	end
	If exists (Select * From Personas Where idPersona = @id) or exists (Select * From Camioneros Where idCamionero = @id)
	Begin
	raiserror('No se puedo borrar la persona/admin',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin,CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Camioneros', 'Baja');
	end

		Commit tran
	

END
GO
/****** Object:  StoredProcedure [dbo].[BajaCli]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[BajaCli] @id int, @idAdmin int
As
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from

	SET NOCOUNT ON;

	BEGIN TRANSACTION
	Delete from Clientes where idCliente = @id
	
	if  @@ROWCOUNT>0   
	begin 
	Delete from Personas where idPersona = @id
	end 
	If exists (Select * From Personas Where idPersona = @id) or exists (Select * From Clientes Where idCliente = @id)
	Begin
	raiserror('No se puedo borrar la persona/admin',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Clientes', 'Baja');
	end

		Commit tran
	

End
GO
/****** Object:  StoredProcedure [dbo].[BajaDeposito]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[BajaDeposito] @id int, @idAdmin int
As
BEGIN

	SET NOCOUNT ON;

	BEGIN TRANSACTION
	Delete from Depositos where idDeposito = @id

	If exists (Select * From Depositos Where idDeposito = @id)
	Begin
	raiserror('No se pudo borrar el deposito',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Depositos', 'Baja');
	end
	Commit tran
	

End
GO
/****** Object:  StoredProcedure [dbo].[BajaFerti]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[BajaFerti] @id int, @idAdmin int
As
BEGIN

	SET NOCOUNT ON;

	BEGIN TRANSACTION
	Delete from Fertilizantes where idFerti = @id

	If exists (Select * From Fertilizantes Where idFerti = @id)
	Begin
	raiserror('No se pudo borrar el fertilizante',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Fertilizantes', 'Baja');
	end
	Commit tran
	

End
GO
/****** Object:  StoredProcedure [dbo].[BajaGranja]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[BajaGranja]
	@id int,
	@idAdmin int
As
BEGIN
	SET NOCOUNT ON;
	BEGIN TRANSACTION
	Delete from Granjas where idGranja = @id
	If exists (Select * From Granjas Where idGranja = @id)
	Begin
	raiserror('No se pudo borrar la Granja',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Granjas', 'Baja');
	end
Commit tran
End
GO
/****** Object:  StoredProcedure [dbo].[BajaLote]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[BajaLote]
	@nombreGranja varchar(30),
	@nombreProducto varchar(30),
	@fchProduccion varchar(20),
	@cantTotal varchar(40),
	@idAdmin int
As
BEGIN

	BEGIN TRANSACTION
	




		Delete L from Lotes_Pestis L
		inner join Granjas G on L.idGranja = G.idGranja
		inner join Productos P on L.idProducto = P.idProducto
		where G.nombre = @nombreGranja and P.nombre = @nombreProducto and  L.fchProduccion =  CONVERT(DATE,@fchProduccion,103)



		Delete L from Lotes_Fertis L
		inner join Granjas G on L.idGranja = G.idGranja 
		inner join Productos P on L.idProducto = P.idProducto
		where G.nombre = @nombreGranja and P.nombre = @nombreProducto and L.fchProduccion = CONVERT(DATE,@fchProduccion,103)


		
		Delete L from Lotes L 
		inner join Granjas G on L.idGranja = G.idGranja 
		inner join Productos P on L.idProducto = P.idProducto
		where G.nombre = @nombreGranja and P.nombre = @nombreProducto and L.fchProduccion = CONVERT(DATE,@fchProduccion,103)
	


		If exists (Select * From Lotes L 
		inner join Granjas G on L.idGranja = G.idGranja 
		inner join Productos P on L.idProducto = P.idProducto
		where G.nombre = @nombreGranja and P.nombre = @nombreProducto and L.fchProduccion = CONVERT(DATE,@fchProduccion,103))
		or exists (Select * From Lotes_Fertis L
		inner join Granjas G on L.idGranja = G.idGranja 
		inner join Productos P on L.idProducto = P.idProducto
		where G.nombre = @nombreGranja and P.nombre = @nombreProducto and L.fchProduccion = CONVERT(DATE,@fchProduccion,103)) 
		or exists (Select * From Lotes_Pestis L inner join Granjas G on L.idGranja = G.idGranja 
		inner join Productos P on L.idProducto = P.idProducto
		where G.nombre = @nombreGranja and P.nombre = @nombreProducto and L.fchProduccion = CONVERT(DATE,@fchProduccion,103))
		begin
			raiserror('No se pudo borrar el Lote',1,1);
			rollback;
		end
		else
		begin

		Update Productos set CantTotal = @cantTotal 
		where nombre = @nombreProducto


		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Lotes', 'Baja');

		Commit TRANSACTION
		end

		

End

/****** Object:  StoredProcedure [dbo].[BuscarLote]    Script Date: 15/8/2023 23:58:05 ******/
SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dbo].[BajaLoteFerti]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[BajaLoteFerti]
	@idFertilizante int,
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20),
	@idAdmin int
As
BEGIN
	SET NOCOUNT ON;
	BEGIN TRANSACTION

		Delete from Lotes_Fertis where idFertilizante = @idFertilizante and idGranja = @idGranja and idProducto = @idProducto and fchProduccion = format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd')
		If exists (Select * From Lotes_Fertis Where idFertilizante = @idFertilizante and idGranja = @idGranja and idProducto = @idProducto and fchProduccion = format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd'))
		begin
			raiserror('No se pudo borrar el Lote_Ferti',1,1);
			rollback;
		end
		else
	begin
		insert into Auditoria values (@idAdmin,CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Lotes Fertis', 'Baja');
	end

	
	
Commit tran
End

GO
/****** Object:  StoredProcedure [dbo].[BajaLotePesti]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[BajaLotePesti]
	@idPesticida int,
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20),
	@idAdmin int
As
BEGIN
	SET NOCOUNT ON;
	BEGIN TRANSACTION

		Delete from Lotes_Pestis where idPesticida = @idPesticida and idGranja = @idGranja and idProducto = @idProducto and fchProduccion = format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd')
		If exists (Select * From Lotes_Pestis Where idPesticida = @idPesticida and idGranja = @idGranja and idProducto = @idProducto and fchProduccion = format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd'))
		begin
			raiserror('No se pudo borrar el Lote_Pesti',1,1);
			rollback;
		end
		else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Lotes Pestis', 'Baja');
	end
Commit tran
End

GO
/****** Object:  StoredProcedure [dbo].[BajaLotesPedido]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BajaLotesPedido]

@idPedido int, 
@IdGranja int,
@idProducto int,
@fchProduccion varchar(20),
@cantLote varchar(40),
@CantDisp varchar(40),
@CantRess varchar(40),
@idAdmin int


AS
BEGIN
	begin TRANSACTION

	delete from Lotes_Pedidos
	where idPedido =@idPedido and idProducto = @idProducto 
	and idGranja = @IdGranja and fchProduccion = format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd')

	if  @@ROWCOUNT>0   
	begin 

	Update Lotes set cantidad = @cantLote
	where idProducto = @idProducto 
	and idGranja = @IdGranja and fchProduccion = format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd')

	
	Update Productos set cantRes = @CantRess, cantTotal= @CantDisp
	where idProducto = @idProducto

		
	insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Lotes Pedidos', 'Baja');
	
	Commit tran
	end
	else
	begin
		raiserror('No se puedo crear la persona/admin',1,1);
		rollback;
		end

END
GO
/****** Object:  StoredProcedure [dbo].[BajaPedido]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BajaPedido]

@idPedido int,
@idAdmin int
AS
BEGIN

	SET NOCOUNT ON;
	Begin  Tran



	Delete from Pedidos
	Where idPedido = @idPedido

	if exists (Select * from Pedidos where idPedido = @idPedido) 
	or exists (Select * from Pedidos_Prod where idPedido = @idPedido) 
		begin
			raiserror('No se pudo borrar el Pedido',1,1);
			rollback;
		end
	else
	begin
		if @idAdmin != 0
		begin
			insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Pedidos', 'Baja');
			
		end
		Commit Tran
	end


END
GO
/****** Object:  StoredProcedure [dbo].[BajaPedidoProd]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BajaPedidoProd]


@idPedido int, 
@idProducto int,

@cantRess varchar(40),
@precio numeric(10,2),
@idAdmin int

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

	if @idAdmin != 0
	Begin 
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Pedidos Prod', 'Baja');
	end

	end


END
GO
/****** Object:  StoredProcedure [dbo].[BajaPesti]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE  [dbo].[BajaPesti] @id int, @idAdmin int
As
BEGIN

	SET NOCOUNT ON;

	BEGIN TRANSACTION
	Delete from Pesticidas where idPesti = @id

	If exists (Select * From Pesticidas Where idPesti = @id)
	Begin
	raiserror('No se pudo borrar el pesticida',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Pesticidas', 'Baja');
	end

	Commit tran
	

End
GO
/****** Object:  StoredProcedure [dbo].[BajaProducto]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[BajaProducto]
	@id int,
	@idAdmin int
As
BEGIN
	SET NOCOUNT ON;
	BEGIN TRANSACTION
	Delete from Productos where idProducto = @id
	If exists (Select * From Productos Where idProducto = @id)
	Begin
	raiserror('No se pudo borrar el Producto',1,1);
		rollback;
	End
	else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Productos', 'Baja');
	end
Commit tran
End
GO
/****** Object:  StoredProcedure [dbo].[BajaViaje]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[BajaViaje] 
@id int,
@idAdmin int
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
	else
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), GETDATE(), 120), 'Viajes', 'Baja');
	end

	Commit tran
	

End
GO
/****** Object:  StoredProcedure [dbo].[BajaViajePedido_Lote]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BajaViajePedido_Lote]

@idViaje int, 
@idPedido int, 
@IdGranja int,
@idProducto int,
@fchProduccion varchar(20),
@CantTotal varchar(40),
@idAdmin int


AS
BEGIN
	
	delete from Viajes_Lots_Ped
	where idViaje = @idViaje and  idPedido =@idPedido and idProducto = @idProducto 
	and idGranja = @IdGranja and fchProduccion = format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd')

		if  @@ROWCOUNT>0   
	begin 

	Update Lotes_Pedidos set cantidadViaje = @CantTotal
	where idPedido =@idPedido and idProducto = @idProducto 
	and idGranja = @IdGranja and fchProduccion = format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd')



	insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Viajes Lotes Pedidos', 'Baja');



	end


END
GO
/****** Object:  StoredProcedure [dbo].[BuscarAdm]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[BuscarAdm] 
	-- Add the parameters for the stored procedure here
@id int
AS
BEGIN
	
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	 	Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,   A.usuario, A.contrasena , A.tipoDeAdmin, A.estado
		from Personas P inner join Admins A on P.idPersona = A.idAdmin
	Where P.idPersona = @id
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarAdminFiltro]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[BuscarAdminFiltro]
	@nombre varchar(40),
	@apellido varchar(40),
	@email varchar(40),
	@usuario varchar(40),
	@tipoAdmin varchar(40),
	@estado varchar(40),
	@ordenar varchar(40)
AS
BEGIN

	if(@ordenar ='')
	begin
		Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  A.usuario, A.tipoDeAdmin,  A.estado from Personas P inner join Admins A on P.idPersona = A.idAdmin
		where  (nombre LIKE '%' + @nombre + '%' and apellido LIKE '%' + @apellido +  '%' and email LIKE '%' + @email + '%' and 
	 usuario LIKE '%' + @usuario + '%' and tipoDeAdmin like '%' + @tipoAdmin + '%' and  estado LIKE @estado + '%')
		order by  P.idPersona
	end


	if(@ordenar ='Nombre')
	begin
		Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  A.usuario, A.tipoDeAdmin,  A.estado from Personas P inner join Admins A on P.idPersona = A.idAdmin
		where  (nombre LIKE '%' + @nombre + '%' and apellido LIKE '%' + @apellido +  '%' and email LIKE '%' + @email + '%' and 
		 usuario LIKE '%' + @usuario + '%' and tipoDeAdmin like '%' + @tipoAdmin + '%' and  estado LIKE @estado + '%')
		order by  P.nombre
	end

	if(@ordenar ='Apellido')
	begin
		Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  A.usuario, A.tipoDeAdmin,  A.estado from Personas P inner join Admins A on P.idPersona = A.idAdmin
		where  (nombre LIKE '%' + @nombre + '%' and apellido LIKE '%' + @apellido +  '%' and email LIKE '%' + @email + '%' and 
		 usuario LIKE '%' + @usuario + '%' and tipoDeAdmin like '%' + @tipoAdmin + '%' and  estado LIKE @estado + '%'
		)
		order by  P.apellido
	end

	if(@ordenar ='Email')
	begin
		Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  A.usuario, A.tipoDeAdmin,  A.estado from Personas P inner join Admins A on P.idPersona = A.idAdmin
		where  (nombre LIKE '%' + @nombre + '%' and apellido LIKE '%' + @apellido +  '%' and email LIKE '%' + @email + '%' and 
		 usuario LIKE '%' + @usuario + '%' and tipoDeAdmin like '%' + @tipoAdmin + '%' and  estado LIKE @estado + '%'
		)
		order by  P.Email
	end

	if(@ordenar ='Usuario')
	begin
		Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  A.usuario, A.tipoDeAdmin,  A.estado from Personas P inner join Admins A on P.idPersona = A.idAdmin
		where  (nombre LIKE '%' + @nombre + '%' and apellido LIKE '%' + @apellido +  '%' and email LIKE '%' + @email + '%' and 
		 usuario LIKE '%' + @usuario + '%' and tipoDeAdmin like '%' + @tipoAdmin + '%' and  estado LIKE @estado + '%'
	)
		order by  A.usuario
	end

	if(@ordenar ='Tipo de Admin')
	begin
		Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  A.usuario, A.tipoDeAdmin,  A.estado from Personas P inner join Admins A on P.idPersona = A.idAdmin
		where  (nombre LIKE '%' + @nombre + '%' and apellido LIKE '%' + @apellido +  '%' and email LIKE '%' + @email + '%' and 
	 usuario LIKE '%' + @usuario + '%' and tipoDeAdmin like '%' + @tipoAdmin + '%' and  estado LIKE @estado + '%'
	)
		order by  A.tipoDeAdmin
	end

	if(@ordenar ='Estado')
	begin
		Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  A.usuario, A.tipoDeAdmin,  A.estado from Personas P inner join Admins A on P.idPersona = A.idAdmin
		where  (nombre LIKE '%' + @nombre + '%' and apellido LIKE '%' + @apellido +  '%' and email LIKE '%' + @email + '%' and 
	 usuario LIKE '%' + @usuario + '%' and tipoDeAdmin like '%' + @tipoAdmin + '%' and  estado LIKE @estado + '%'
		)
		order by  A.estado
	end
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarAuditoriaFiltro]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[BuscarAuditoriaFiltro]
	@admin int,
	@tabla varchar(20),
	@tipo varchar(10),
	@fchMenor varchar(20),
	@fchMayor varchar(20),
	@ordenar varchar(40)
AS
BEGIN

	if(@ordenar ='')
	begin
		if @admin = 0
		begin
			select A.idAuditoria, A.idAdmin, P.nombre as nombreAdmin, P.apellido as apellidoAdmin , format (A.fecha, 'dd/MM/yy hh:mm tt') as fecha, A.tabla, A.tipo from Auditoria A
			inner join Personas P on A.idAdmin = P.idPersona
			where A.tabla LIKE '%' + @tabla and A.tipo LIKE '%' + @tipo + '%' and A.fecha >= CONVERT(VARCHAR(16), @fchMenor, 120) and A.fecha <= CONVERT(VARCHAR(16), @fchMayor, 120)  
			order by A.idAuditoria Desc
		end
		else
		begin
			select A.idAuditoria, A.idAdmin, P.nombre as nombreAdmin, P.apellido as apellidoAdmin , format (A.fecha, 'dd/MM/yy hh:mm tt') as fecha, A.tabla, A.tipo from Auditoria A
			inner join Personas P on A.idAdmin = P.idPersona
			where A.tabla LIKE '%' + @tabla and A.tipo LIKE '%' + @tipo + '%' and A.fecha >=CONVERT(VARCHAR(16), @fchMenor, 120) and A.fecha <= CONVERT(VARCHAR(16), @fchMayor, 120) and A.idAdmin = @admin
			order by A.idAuditoria Desc
		end
	end


	if(@ordenar ='Recientes')
	begin
		if @admin = 0
		begin
			select A.idAuditoria, A.idAdmin, P.nombre as nombreAdmin, P.apellido as apellidoAdmin ,format (A.fecha, 'dd/MM/yy hh:mm tt') as fecha, A.tabla, A.tipo from Auditoria A
			inner join Personas P on A.idAdmin = P.idPersona
			where A.tabla LIKE '%' + @tabla and A.tipo LIKE '%' + @tipo + '%' and A.fecha >=CONVERT(VARCHAR(16), @fchMenor, 120) and A.fecha <= CONVERT(VARCHAR(16), @fchMayor, 120)
			order by A.fecha DESC
		end
		else
		begin
			select A.idAuditoria, A.idAdmin, P.nombre as nombreAdmin, P.apellido as apellidoAdmin ,format (A.fecha, 'dd/MM/yy hh:mm tt') as fecha, A.tabla, A.tipo from Auditoria A
			inner join Personas P on A.idAdmin = P.idPersona
			where A.tabla LIKE '%' + @tabla and A.tipo LIKE '%' + @tipo + '%' and A.fecha >= CONVERT(VARCHAR(16), @fchMenor, 120) and A.fecha <= CONVERT(VARCHAR(16), @fchMayor, 120) and A.idAdmin = @admin
			order by A.fecha DESC
		end
	end

	if(@ordenar ='Antiguos')
	begin
		if @admin = 0
		begin
			select A.idAuditoria, A.idAdmin, P.nombre as nombreAdmin, P.apellido as apellidoAdmin , format (A.fecha, 'dd/MM/yy hh:mm tt') as fecha, A.tabla, A.tipo from Auditoria A
			inner join Personas P on A.idAdmin = P.idPersona
			where A.tabla LIKE '%' + @tabla and A.tipo LIKE '%' + @tipo + '%' and A.fecha >= CONVERT(VARCHAR(16), @fchMenor, 120) and A.fecha <= CONVERT(VARCHAR(16), @fchMayor, 120)
			order by A.fecha ASC
		end
		else
		begin
			select A.idAuditoria, A.idAdmin, P.nombre as nombreAdmin, P.apellido as apellidoAdmin ,format (A.fecha, 'dd/MM/yy hh:mm tt') as fecha, A.tabla, A.tipo from Auditoria A
			inner join Personas P on A.idAdmin = P.idPersona
			where A.tabla LIKE '%' + @tabla and A.tipo LIKE '%' + @tipo + '%' and A.fecha >= CONVERT(VARCHAR(16), @fchMenor, 120) and A.fecha <= CONVERT(VARCHAR(16), @fchMayor, 120) and A.idAdmin = @admin
			order by A.fecha ASC
		end
	end

	if(@ordenar ='Tabla')
	begin
		if @admin = 0
		begin
			select A.idAuditoria, A.idAdmin, P.nombre as nombreAdmin, P.apellido as apellidoAdmin , format (A.fecha, 'dd/MM/yy hh:mm tt') as fecha, A.tabla, A.tipo from Auditoria A
			inner join Personas P on A.idAdmin = P.idPersona
			where A.tabla LIKE '%' + @tabla and A.tipo LIKE '%' + @tipo + '%' and A.fecha >= CONVERT(VARCHAR(16), @fchMenor, 120) and A.fecha <= CONVERT(VARCHAR(16), @fchMayor, 120)
			order by A.tabla
		end
		else
		begin
			select A.idAuditoria, A.idAdmin, P.nombre as nombreAdmin, P.apellido as apellidoAdmin , format (A.fecha, 'dd/MM/yy hh:mm tt') as fecha, A.tabla, A.tipo from Auditoria A
			inner join Personas P on A.idAdmin = P.idPersona
			where A.tabla LIKE '%' + @tabla and A.tipo LIKE '%' + @tipo + '%' and A.fecha >= CONVERT(VARCHAR(16), @fchMenor, 120) and A.fecha <= CONVERT(VARCHAR(16), @fchMayor, 120) and A.idAdmin = @admin
			order by A.tabla
		end
	end

	if(@ordenar ='Tipo')
	begin
		if @admin = 0
		begin
			select A.idAuditoria, A.idAdmin, P.nombre as nombreAdmin, P.apellido as apellidoAdmin , format (A.fecha, 'dd/MM/yy hh:mm tt') as fecha, A.tabla, A.tipo from Auditoria A
			inner join Personas P on A.idAdmin = P.idPersona
			where A.tabla LIKE '%' + @tabla and A.tipo LIKE '%' + @tipo + '%' and A.fecha >= CONVERT(VARCHAR(16), @fchMenor, 120) and A.fecha <= CONVERT(VARCHAR(16), @fchMayor, 120)
			order by A.tipo
		end
		else
		begin
			select A.idAuditoria, A.idAdmin, P.nombre as nombreAdmin, P.apellido as apellidoAdmin , format (A.fecha, 'dd/MM/yy hh:mm tt') as fecha, A.tabla, A.tipo from Auditoria A
			inner join Personas P on A.idAdmin = P.idPersona
			where A.tabla LIKE '%' + @tabla and A.tipo LIKE '%' + @tipo + '%' and A.fecha >= CONVERT(VARCHAR(16), @fchMenor, 120) and A.fecha <= CONVERT(VARCHAR(16), @fchMayor, 120) and A.idAdmin = @admin
			order by A.tipo
		end
	end
	if(@ordenar ='Admin')
	begin
		if @admin = 0
		begin
			select A.idAuditoria, A.idAdmin, P.nombre as nombreAdmin, P.apellido as apellidoAdmin , format (A.fecha, 'dd/MM/yy hh:mm tt') as fecha, A.tabla, A.tipo from Auditoria A
			inner join Personas P on A.idAdmin = P.idPersona
			where A.tabla LIKE '%' + @tabla and A.tipo LIKE '%' + @tipo + '%' and A.fecha >= CONVERT(VARCHAR(16), @fchMenor, 120) and A.fecha <= CONVERT(VARCHAR(16), @fchMayor, 120)
			order by P.nombre, P.apellido
		end
		else
		begin
			select A.idAuditoria, A.idAdmin, P.nombre as nombreAdmin, P.apellido as apellidoAdmin ,format (A.fecha, 'dd/MM/yy hh:mm tt') as fecha, A.tabla, A.tipo from Auditoria A
			inner join Personas P on A.idAdmin = P.idPersona
			where A.tabla LIKE '%' + @tabla and A.tipo LIKE '%' + @tipo + '%' and A.fecha >= CONVERT(VARCHAR(16), @fchMenor, 120) and A.fecha <= CONVERT(VARCHAR(16), @fchMayor, 120) and A.idAdmin = @admin
			order by P.nombre, P.apellido
		end
	end
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarCam]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[BuscarCam] 
@id int
AS
BEGIN
	
	SET NOCOUNT ON;
	 	Select idCamion, marca, modelo, carga, disponible from Camiones Where idCamion = @id
END

GO
/****** Object:  StoredProcedure [dbo].[BuscarCamionero]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BuscarCamionero]
@id int
AS
BEGIN

	SELECT [idCamionero],[nombre],[apellido],[email],[telefono],[fchNacimiento],[cedula], disponible, fchManejo FROM Camioneros C inner join Personas P on P.idPersona = C.idCamionero where idCamionero = @id

END
GO
/****** Object:  StoredProcedure [dbo].[BuscarCamioneroFiltro]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[BuscarCamioneroFiltro]
	@nombre varchar(40),
	@apellido varchar(40),
	@email varchar(40),
	@cedula varchar(40),
	@disponible varchar(40),
	@fchVencDesde varchar(40),
	@fchVencHasta varchar(40),
	@ordenar varchar(40)
AS
BEGIN

	if(@ordenar ='')
	begin
		Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  C.cedula, C.disponible, C.fchManejo from Personas P inner join Camioneros C on P.idPersona = C.idCamionero
		where  (nombre LIKE '%' + @nombre + '%' and apellido LIKE '%' + @apellido +  '%' and email LIKE '%' + @email + '%'  and cedula LIKE '%' + @cedula + '%' and disponible like '%' + @disponible + '%'
		 and (fchManejo >= @fchVencDesde and fchManejo <= @fchVencHasta))
		order by  P.idPersona
	end


	if(@ordenar ='Nombre')
	begin
		Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  C.cedula, C.disponible, C.fchManejo from Personas P inner join Camioneros C on P.idPersona = C.idCamionero
		where  (nombre LIKE '%' + @nombre + '%' and apellido LIKE '%' + @apellido +  '%' and email LIKE '%' + @email + '%' and cedula LIKE '%' + @cedula + '%' and disponible like '%' + @disponible + '%'
	   and (fchManejo >= @fchVencDesde and fchManejo <= @fchVencHasta))
		order by  P.nombre
	end

	if(@ordenar ='Apellido')
	begin
		Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  C.cedula, C.disponible, C.fchManejo from Personas P inner join Camioneros C on P.idPersona = C.idCamionero
		where  (nombre LIKE '%' + @nombre + '%' and apellido LIKE '%' + @apellido +  '%' and email LIKE '%' + @email + '%' and 
		cedula LIKE '%' + @cedula + '%' and disponible like '%' + @disponible + '%'
		 and (fchManejo >= @fchVencDesde and fchManejo <= @fchVencHasta))
		order by  P.apellido
	end

	if(@ordenar ='Email')
	begin
		Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  C.cedula, C.disponible, C.fchManejo from Personas P inner join Camioneros C on P.idPersona = C.idCamionero
		where  (nombre LIKE '%' + @nombre + '%' and apellido LIKE '%' + @apellido +  '%' and email LIKE '%' + @email + '%' and 
		 cedula LIKE '%' + @cedula + '%' and disponible like '%' + @disponible + '%'
		and (fchManejo >= @fchVencDesde and fchManejo <= @fchVencHasta))
		order by  P.email
	end

		if(@ordenar ='Fecha de vencimiento')
	begin
		Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  C.cedula, C.disponible, C.fchManejo from Personas P inner join Camioneros C on P.idPersona = C.idCamionero
		where  (nombre LIKE '%' + @nombre + '%' and apellido LIKE '%' + @apellido +  '%' and email LIKE '%' + @email + '%' and 
	cedula LIKE '%' + @cedula + '%' and disponible like '%' + @disponible + '%'
	 and (fchManejo >= @fchVencDesde and fchManejo <= @fchVencHasta))
		order by  C.fchManejo
	end

		if(@ordenar ='Cedula')
	begin
		Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  C.cedula, C.disponible, C.fchManejo from Personas P inner join Camioneros C on P.idPersona = C.idCamionero
		where  (nombre LIKE '%' + @nombre + '%' and apellido LIKE '%' + @apellido +  '%' and email LIKE '%' + @email + '%' and 
		 cedula LIKE '%' + @cedula + '%' and disponible like '%' + @disponible + '%'
		and (fchManejo >= @fchVencDesde and fchManejo <= @fchVencHasta))
		order by  C.cedula
	end

	if(@ordenar ='Disponibilidad')
	begin
		Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  C.cedula, C.disponible, C.fchManejo from Personas P inner join Camioneros C on P.idPersona = C.idCamionero
		where  (nombre LIKE '%' + @nombre + '%' and apellido LIKE '%' + @apellido +  '%' and email LIKE '%' + @email + '%' and 
		cedula LIKE '%' + @cedula + '%' and disponible like '%' + @disponible + '%'
		and (fchManejo >= @fchVencDesde and fchManejo <= @fchVencHasta))
		order by  C.disponible
	end


END
GO
/****** Object:  StoredProcedure [dbo].[BuscarCli]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[BuscarCli]
-- Add the parameters for the stored procedure here
@id int
AS
BEGIN
	
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	 	Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento, C.usuario, C.contrasena , C.direccion
		from Personas P inner join Clientes C on P.idPersona = C.idCliente
	Where P.idPersona = @id
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarCliFiltro]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[BuscarCliFiltro]
	@nombre varchar(40),
	@apellido varchar(40),
	@email varchar(40),
	@usuario varchar(40),
	@direccion varchar(60),
	@ordenar varchar(40)
AS
BEGIN

	if(@ordenar ='')
	begin
		Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  C.usuario, C.Direccion from Personas P inner join Clientes C on P.idPersona = C.idCliente
		where  (nombre LIKE '%' + @nombre + '%' and apellido LIKE '%' + @apellido +  '%' and email LIKE '%' + @email + '%'
		and usuario LIKE '%' + @usuario + '%' and Direccion like '%' + @direccion + '%'
		)
		order by  P.idPersona
	end


	if(@ordenar ='Nombre')
	begin
		Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  C.usuario, C.Direccion from Personas P inner join Clientes C on P.idPersona = C.idCliente
		where  (nombre LIKE '%' + @nombre + '%' and apellido LIKE '%' + @apellido +  '%' and email LIKE '%' + @email + '%'
		and usuario LIKE '%' + @usuario + '%' and Direccion like '%' + @direccion + '%')
		order by  P.nombre
	end

	if(@ordenar ='Apellido')
	begin
		Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  C.usuario, C.Direccion from Personas P inner join Clientes C on P.idPersona = C.idCliente
		where  (nombre LIKE '%' + @nombre + '%' and apellido LIKE '%' + @apellido +  '%' and email LIKE '%' + @email + '%'
		and usuario LIKE '%' + @usuario + '%' and Direccion like '%' + @direccion + '%'
		)
		order by  P.apellido
	end
		if(@ordenar ='Email')
	begin
		Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  C.usuario, C.Direccion from Personas P inner join Clientes C on P.idPersona = C.idCliente
		where  (nombre LIKE '%' + @nombre + '%' and apellido LIKE '%' + @apellido +  '%' and email LIKE '%' + @email + '%' 
		and usuario LIKE '%' + @usuario + '%' and Direccion like '%' + @direccion + '%')
		order by  P.email
	end

			if(@ordenar ='Usuario')
	begin
		Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  C.usuario, C.Direccion from Personas P inner join Clientes C on P.idPersona = C.idCliente
		where  (nombre LIKE '%' + @nombre + '%' and apellido LIKE '%' + @apellido +  '%' and email LIKE '%' + @email + '%' 
		and usuario LIKE '%' + @usuario + '%' and Direccion like '%' + @direccion + '%')
		order by  C.usuario
	end





	if(@ordenar ='Dirección')
	begin
		Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  C.usuario, C.Direccion from Personas P inner join Clientes C on P.idPersona = C.idCliente
		where  (nombre LIKE '%' + @nombre + '%' and apellido LIKE '%' + @apellido +  '%' and email LIKE '%' + @email + '%' 
		and usuario LIKE '%' + @usuario + '%' and Direccion like '%' + @direccion + '%')
		order by  C.Direccion
	end
END

GO
/****** Object:  StoredProcedure [dbo].[BuscarDeposito]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[BuscarDeposito] 
@id int
AS
BEGIN
	
	SET NOCOUNT ON;
	 	Select idDeposito, capacidad, ubicacion, temperatura, condiciones from Depositos Where idDeposito = @id
END

GO
/****** Object:  StoredProcedure [dbo].[BuscarDepositoFiltro]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[BuscarDepositoFiltro]
	@ubicacion varchar(40),
	@condiciones varchar(60),
	@capacidadMenor numeric(10,0),
	@capacidadMayor numeric(10,0),
	@temperaturaMenor numeric(3,0),
	@temperaturaMayor numeric(3,0),
	@ordenar varchar(40)
AS
BEGIN

	SET NOCOUNT ON;

	if @ordenar = ''
	begin
		Select idDeposito, capacidad, ubicacion, temperatura, condiciones from Depositos
		where  ubicacion LIKE '%' + @ubicacion + '%' and condiciones LIKE '%' + @condiciones + '%' and (capacidad >= @capacidadMenor and capacidad <= @capacidadMayor)
		and (temperatura >= @temperaturaMenor and temperatura <= @temperaturaMayor)
		order by idDeposito
	end

	if @ordenar = 'Condiciones'
	begin
		Select idDeposito, capacidad, ubicacion, temperatura, condiciones from Depositos
		where  ubicacion LIKE '%' + @ubicacion + '%' and condiciones LIKE '%' + @condiciones + '%' and (capacidad >= @capacidadMenor and capacidad <= @capacidadMayor)
		and (temperatura >= @temperaturaMenor and temperatura <= @temperaturaMayor)
		order by condiciones
	end

	if @ordenar = 'Ubicación'
	begin
		Select idDeposito, capacidad, ubicacion, temperatura, condiciones from Depositos
		where  ubicacion LIKE '%' + @ubicacion + '%' and condiciones LIKE '%' + @condiciones + '%' and (capacidad >= @capacidadMenor and capacidad <= @capacidadMayor)
		and (temperatura >= @temperaturaMenor and temperatura <= @temperaturaMayor)
		order by ubicacion
	end

	if @ordenar = 'Capacidad'
	begin
		Select idDeposito, capacidad, ubicacion, temperatura, condiciones from Depositos
		where  ubicacion LIKE '%' + @ubicacion + '%' and condiciones LIKE '%' + @condiciones + '%' and (capacidad >= @capacidadMenor and capacidad <= @capacidadMayor)
		and (temperatura >= @temperaturaMenor and temperatura <= @temperaturaMayor)
		order by capacidad
	end

	if @ordenar = 'Temperatura'
	begin
		Select idDeposito, capacidad, ubicacion, temperatura, condiciones from Depositos
		where  ubicacion LIKE '%' + @ubicacion + '%' and condiciones LIKE '%' + @condiciones + '%' and (capacidad >= @capacidadMenor and capacidad <= @capacidadMayor)
		and (temperatura >= @temperaturaMenor and temperatura <= @temperaturaMayor)
		order by temperatura
	end
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarFerti]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[BuscarFerti] 
@id int
AS
BEGIN
	
	SET NOCOUNT ON;
	 	Select idFerti, nombre, tipo, pH, impacto from Fertilizantes Where idFerti = @id
END

GO
/****** Object:  StoredProcedure [dbo].[BuscarFertilizanteFiltro]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarFertilizanteFiltro]
	@nombre varchar(40),
	@tipo varchar(40),
	@impacto varchar (40),
	@phMenor numeric(10,2),
	@phMayor numeric(10,2),
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20),
	@ordenar varchar(40)

AS
BEGIN

	SET NOCOUNT ON;

	if @ordenar = ''
	begin
		Select idFerti, nombre, tipo, pH, impacto from Fertilizantes F left join Lotes_Fertis L on L.idFertilizante = F.idFerti 
		Where (nombre  LIKE '%' + @nombre + '%' and tipo LIKE '%' + @tipo + '%' and impacto LIKE '%' + @impacto + '%' and (pH >= @phMenor and ph <= @phMayor)
		and ((L.idGranja != @idGranja or L.idGranja is NULL) or (L.idProducto != @idProducto or L.idProducto is NULL) or (L.fchProduccion != CONVERT(DATE,@fchProduccion,103) or L.fchProduccion is NULL)))
		group by idFerti, nombre, tipo, pH, impacto
		order by idFerti
	end
	if @ordenar = 'Nombre'
	begin
		Select idFerti, nombre, tipo, pH, impacto from Fertilizantes F left join Lotes_Fertis L on L.idFertilizante = F.idFerti 
		Where (nombre  LIKE '%' + @nombre + '%' and tipo LIKE '%' + @tipo + '%' and impacto LIKE '%' + @impacto + '%' and (pH >= @phMenor and ph <= @phMayor)
		and ((L.idGranja != @idGranja or L.idGranja is NULL) or (L.idProducto != @idProducto or L.idProducto is NULL) or (L.fchProduccion != CONVERT(DATE,@fchProduccion,103) or L.fchProduccion is NULL)))
		group by idFerti, nombre, tipo, pH, impacto
		order by nombre
	end

	if @ordenar = 'Tipo'
	begin
		Select idFerti, nombre, tipo, pH, impacto from Fertilizantes F left join Lotes_Fertis L on L.idFertilizante = F.idFerti 
		Where (nombre  LIKE '%' + @nombre + '%' and tipo LIKE '%' + @tipo + '%' and impacto LIKE '%' + @impacto + '%' and (pH >= @phMenor and ph <= @phMayor)
		and ((L.idGranja != @idGranja or L.idGranja is NULL) or (L.idProducto != @idProducto or L.idProducto is NULL) or (L.fchProduccion != CONVERT(DATE,@fchProduccion,103) or L.fchProduccion is NULL)))
		group by idFerti, nombre, tipo, pH, impacto
		order by tipo
	end


	if @ordenar = 'pH'
	begin
		Select idFerti, nombre, tipo, pH, impacto from Fertilizantes F left join Lotes_Fertis L on L.idFertilizante = F.idFerti 
		Where (nombre  LIKE '%' + @nombre + '%' and tipo LIKE '%' + @tipo + '%' and impacto LIKE '%' + @impacto + '%' and (pH >= @phMenor and ph <= @phMayor)
		and ((L.idGranja != @idGranja or L.idGranja is NULL) or (L.idProducto != @idProducto or L.idProducto is NULL) or (L.fchProduccion != CONVERT(DATE,@fchProduccion,103) or L.fchProduccion is NULL)))
		group by idFerti, nombre, tipo, pH, impacto
		order by pH
	end
	if @ordenar = 'Impacto'
	begin
		Select idFerti, nombre, tipo, pH, impacto from Fertilizantes F left join Lotes_Fertis L on L.idFertilizante = F.idFerti 
		Where (nombre  LIKE '%' + @nombre + '%' and tipo LIKE '%' + @tipo + '%' and impacto LIKE '%' + @impacto + '%' and (pH >= @phMenor and ph <= @phMayor)
		and ((L.idGranja != @idGranja or L.idGranja is NULL) or (L.idProducto != @idProducto or L.idProducto is NULL) or (L.fchProduccion != CONVERT(DATE,@fchProduccion,103) or L.fchProduccion is NULL)))
		group by idFerti, nombre, tipo, pH, impacto
		order by impacto
	end
	if @ordenar = 'Cantidad'
	begin
		Select idPesti, nombre, tipo, pH, impacto, cantidad from Pesticidas P left join Lotes_Pestis L on L.idPesticida = P.idPesti 
		Where (nombre  LIKE '%' + @nombre + '%' and tipo LIKE '%' + @tipo + '%' and impacto LIKE '%' + @impacto + '%' and (pH >= @phMenor and ph <= @phMayor)
		and ((L.idGranja != @idGranja or L.idGranja is NULL) or (L.idProducto != @idProducto or L.idProducto is NULL) or (L.fchProduccion != CONVERT(DATE,@fchProduccion,103) or L.fchProduccion is NULL)))
		group by idPesti, nombre, tipo, pH, impacto, cantidad
		order by cantidad
	end
end

GO
/****** Object:  StoredProcedure [dbo].[BuscarFiltrarLotes]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarFiltrarLotes]
	@granja int,
	@producto int,
	@deposito int,
	@precioMenor numeric(10,2),
	@precioMayor numeric(10,2),
	@fchProduccionMenor varchar(20),
	@fchProduccionMayor varchar(20),
	@fchCaducidadMenor varchar(20),
	@fchCaducidadMayor varchar(20),
	@ordenar varchar(40)
AS
BEGIN
	SET NOCOUNT ON;

	if @ordenar = ''
	begin
		if @granja = 0 and @producto = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto,  format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, format (L.fchCaducidad, 'dd/MM/yyyy') as fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
		end
		if @granja = 0 and @producto = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto,format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idDeposito = @deposito
		end
		if @granja = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idProducto = @producto
		end
		if @producto = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto,format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja
		end
		if @granja = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto,format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idProducto = @producto and L.idDeposito = @deposito
		end
		if @producto = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto,format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja and L.idDeposito = @deposito
		end
		if @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja and L.idProducto = @producto
		end
		else
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.idGranja = @granja and L.idProducto = @producto and L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idDeposito = @deposito
		end
	end



	if @ordenar = 'Granja'
	begin
		if @granja = 0 and @producto = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion,L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			order by G.nombre
		end
		if @granja = 0 and @producto = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion,L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idDeposito = @deposito
			order by G.nombre
		end
		if @granja = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idProducto = @producto
			order by G.nombre
		end
		if @producto = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto,format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion,L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja
			order by G.nombre
		end
		if @granja = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto,format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idProducto = @producto and L.idDeposito = @deposito
			order by G.nombre
		end
		if @producto = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto,format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja and L.idDeposito = @deposito
			order by G.nombre
		end
		if @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja and L.idProducto = @producto
			order by G.nombre
		end
		else
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.idGranja = @granja and L.idProducto = @producto and L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idDeposito = @deposito
			order by G.nombre
		end
	end


	if @ordenar = 'Producto'
	begin
		if @granja = 0 and @producto = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			order by P.nombre
		end
		if @granja = 0 and @producto = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idDeposito = @deposito
			order by P.nombre
		end
		if @granja = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idProducto = @producto
			order by P.nombre
		end
		if @producto = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja
			order by P.nombre
		end
		if @granja = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idProducto = @producto and L.idDeposito = @deposito
			order by P.nombre
		end
		if @producto = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto,format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja and L.idDeposito = @deposito
			order by P.nombre
		end
		if @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja and L.idProducto = @producto
			order by P.nombre
		end
		else
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto,format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.idGranja = @granja and L.idProducto = @producto and L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idDeposito = @deposito
			order by P.nombre
		end
	end


	if @ordenar = 'Fecha de producción'
	begin
		if @granja = 0 and @producto = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto,format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion,L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			order by L.fchProduccion
		end
		if @granja = 0 and @producto = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto,format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idDeposito = @deposito
			order by L.fchProduccion
		end
		if @granja = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idProducto = @producto
			order by L.fchProduccion
		end
		if @producto = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja
			order by L.fchProduccion
		end
		if @granja = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idProducto = @producto and L.idDeposito = @deposito
			order by L.fchProduccion
		end
		if @producto = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja and L.idDeposito = @deposito
			order by L.fchProduccion
		end
		if @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja and L.idProducto = @producto
			order by L.fchProduccion
		end
		else
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.idGranja = @granja and L.idProducto = @producto and L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idDeposito = @deposito
			order by L.fchProduccion
		end
	end

	if @ordenar = 'Fecha de caducidad'
	begin
		if @granja = 0 and @producto = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			order by L.fchCaducidad
		end
		if @granja = 0 and @producto = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idDeposito = @deposito
			order by L.fchCaducidad
		end
		if @granja = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idProducto = @producto
			order by L.fchCaducidad
		end
		if @producto = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja
			order by L.fchCaducidad
		end
		if @granja = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idProducto = @producto and L.idDeposito = @deposito
			order by L.fchCaducidad
		end
		if @producto = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja and L.idDeposito = @deposito
			order by L.fchCaducidad
		end
		if @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja and L.idProducto = @producto
			order by L.fchCaducidad
		end
		else
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.idGranja = @granja and L.idProducto = @producto and L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idDeposito = @deposito
			order by L.fchCaducidad
		end
	end

	
	if @ordenar = 'Cantidad de producción'
	begin
		if @granja = 0 and @producto = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			order by L.cantidad
		end
		if @granja = 0 and @producto = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idDeposito = @deposito
			order by L.cantidad
		end
		if @granja = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idProducto = @producto
			order by L.cantidad
		end
		if @producto = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja
			order by L.cantidad
		end
		if @granja = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idProducto = @producto and L.idDeposito = @deposito
			order by L.cantidad
		end
		if @producto = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja and L.idDeposito = @deposito
			order by L.cantidad
		end
		if @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja and L.idProducto = @producto
			order by L.cantidad
		end
		else
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.idGranja = @granja and L.idProducto = @producto and L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idDeposito = @deposito
			order by L.cantidad
		end
	end

	if @ordenar = 'Precio'
	begin
		if @granja = 0 and @producto = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto,format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			order by L.precio
		end
		if @granja = 0 and @producto = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idDeposito = @deposito
			order by L.precio
		end
		if @granja = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idProducto = @producto
			order by L.precio
		end
		if @producto = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja
			order by L.precio
		end
		if @granja = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto,format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idProducto = @producto and L.idDeposito = @deposito
			order by L.precio
		end
		if @producto = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja and L.idDeposito = @deposito
			order by L.precio
		end
		if @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja and L.idProducto = @producto
			order by L.precio
		end
		else
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.idGranja = @granja and L.idProducto = @producto and L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idDeposito = @deposito
			order by L.precio
		end


	if @ordenar = 'Depósito'
	begin
		if @granja = 0 and @producto = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			order by D.ubicacion
		end
		if @granja = 0 and @producto = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idDeposito = @deposito
			order by D.ubicacion
		end
		if @granja = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto,format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idProducto = @producto
			order by D.ubicacion
		end
		if @producto = 0 and @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja
			order by D.ubicacion
		end
		if @granja = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto,format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idProducto = @producto and L.idDeposito = @deposito
			order by D.ubicacion
		end
		if @producto = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja and L.idDeposito = @deposito
			order by D.ubicacion
		end
		if @deposito = 0
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto,format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idGranja = @granja and L.idProducto = @producto
			order by D.ubicacion
		end
		else
		begin
			Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
			inner join Granjas G on L.idGranja = G.idGranja 
			inner join Productos P on L.idProducto = P.idProducto
			inner join Depositos D on L.idDeposito = D.idDeposito
			where L.idGranja = @granja and L.idProducto = @producto and L.fchProduccion >= @fchProduccionMenor and L.fchProduccion <= @fchProduccionMayor
			and L.fchCaducidad >= @fchCaducidadMenor and L.fchCaducidad <= @fchCaducidadMayor and L.precio >= @precioMenor and L.precio <= @precioMayor 
			and L.idDeposito = @deposito
			order by D.ubicacion
		end
	end
end
end
GO
/****** Object:  StoredProcedure [dbo].[BuscarFiltroCam]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarFiltroCam]
	@marca varchar(40),
	@modelo varchar(40),
	@cargaMenor numeric(10,2),
	@cargaMayor numeric(10,2),
	@disponible varchar (40),
	@ordenar varchar(40)
AS
BEGIN
	SET NOCOUNT ON;


	if @ordenar = ''
	begin
		Select idCamion, marca, modelo, carga, disponible from Camiones
		Where (marca  LIKE '%' + @marca + '%'  and modelo  LIKE '%' + @modelo + '%' and (carga >= @cargaMenor and carga <= @cargaMayor) and disponible LIKE @disponible + '%')
		order by idCamion
	end

	if @ordenar = 'Marca'
	begin
		Select idCamion, marca, modelo, carga, disponible from Camiones
		Where (marca  LIKE '%' + @marca + '%'  and modelo  LIKE '%' + @modelo + '%' and (carga >= @cargaMenor and carga <= @cargaMayor) and disponible LIKE @disponible + '%')
		order by marca
	end

	if @ordenar = 'Modelo'
	begin
		Select idCamion, marca, modelo, carga, disponible from Camiones
		Where (marca  LIKE '%' + @marca + '%'  and modelo  LIKE '%' + @modelo + '%' and (carga >= @cargaMenor and carga <= @cargaMayor) and disponible LIKE @disponible + '%')
		order by modelo
	end
	
	if @ordenar = 'Carga'
	begin
		Select idCamion, marca, modelo, carga, disponible from Camiones
		Where (marca  LIKE '%' + @marca + '%'  and modelo  LIKE '%' + @modelo + '%' and (carga >= @cargaMenor and carga <= @cargaMayor) and disponible LIKE @disponible + '%')
		order by carga
	end

	if @ordenar = 'Disponible'
	begin
		Select idCamion, marca, modelo, carga, disponible from Camiones
		Where (marca  LIKE '%' + @marca + '%'  and modelo  LIKE '%' + @modelo + '%' and (carga >= @cargaMenor and carga <= @cargaMayor) and disponible LIKE @disponible + '%')
		order by disponible
	end

END
GO
/****** Object:  StoredProcedure [dbo].[BuscarGranja]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarGranja] 
@id int
AS
BEGIN
	SET NOCOUNT ON;
	Select idGranja, nombre, ubicacion, idCliente from Granjas Where idGranja = @id
END

GO
/****** Object:  StoredProcedure [dbo].[BuscarGranjaFiltro]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarGranjaFiltro]
	@nombre varchar(40),
	@ubicacion varchar(40),
	@idCli int,
	@ordenar varchar(40)
AS
BEGIN
	SET NOCOUNT ON;

	if @ordenar =''
	begin
		if @idCli != 0
		begin
			Select G.idGranja, G.nombre, G.ubicacion, P.idPersona as idCliente, P.nombre as nombreCliente from Granjas G inner join Personas P on G.idCliente = P.idPersona
			where G.nombre  LIKE '%' + @nombre + '%' and ubicacion LIKE '%' + @ubicacion + '%' and G.idCliente = @idCli
			order by idGranja
		end
		else
		begin
			Select G.idGranja, G.nombre, G.ubicacion, P.idPersona as idCliente, P.nombre as nombreCliente from Granjas G inner join Personas P on G.idCliente = P.idPersona
			where G.nombre  LIKE '%' + @nombre + '%' and ubicacion LIKE '%' + @ubicacion + '%'
			order by idGranja
		end
	end


	
	if @ordenar ='Nombre'
	begin
		if @idCli != 0
		begin
			Select G.idGranja, G.nombre, G.ubicacion,  P.idPersona as idCliente, P.nombre as nombreCliente from Granjas G inner join Personas P on G.idCliente = P.idPersona
			where G.nombre  LIKE '%' + @nombre + '%' and ubicacion LIKE '%' + @ubicacion + '%' and G.idCliente = @idCli
			order by G.nombre
		end
		else
		begin
			Select G.idGranja, G.nombre, G.ubicacion, P.idPersona as idCliente, P.nombre as nombreCliente from Granjas G inner join Personas P on G.idCliente = P.idPersona
			where G.nombre  LIKE '%' + @nombre + '%' and ubicacion LIKE '%' + @ubicacion + '%'
			order by G.nombre
		end
	end

	if @ordenar ='Ubicación'
	begin
		if @idCli != 0
		begin
			Select G.idGranja, G.nombre, G.ubicacion,  P.idPersona as idCliente, P.nombre as nombreCliente from Granjas G inner join Personas P on G.idCliente = P.idPersona
			where G.nombre  LIKE '%' + @nombre + '%' and ubicacion LIKE '%' + @ubicacion + '%' and G.idCliente = @idCli
			order by G.ubicacion
		end
		else
		begin
			Select G.idGranja, G.nombre, G.ubicacion,  P.idPersona as idCliente, P.nombre as nombreCliente from Granjas G inner join Personas P on G.idCliente = P.idPersona
			where G.nombre  LIKE '%' + @nombre + '%' and ubicacion LIKE '%' + @ubicacion + '%'
			order by G.ubicacion
		end
	end

	if @ordenar ='Nombre del dueño'
	begin
		if @idCli != 0
		begin
			Select G.idGranja, G.nombre, G.ubicacion,  P.idPersona as idCliente, P.nombre as nombreCliente from Granjas G inner join Personas P on G.idCliente = P.idPersona
			where G.nombre  LIKE '%' + @nombre + '%' and ubicacion LIKE '%' + @ubicacion + '%' and G.idCliente = @idCli
			order by P.nombre
		end
		else
		begin
			Select G.idGranja, G.nombre, G.ubicacion,  P.idPersona as idCliente, P.nombre as nombreCliente from Granjas G inner join Personas P on G.idCliente = P.idPersona
			where G.nombre  LIKE '%' + @nombre + '%' and ubicacion LIKE '%' + @ubicacion + '%'
			order by P.nombre
		end
	end
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarLote]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarLote] 
	@nombreGranja varchar(30),
	@nombreProducto varchar(30),
	@fchProduccion varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	Select L.idGranja, G.nombre as nombreGranja, L.idProducto, P.nombre as nombreProducto, L.fchProduccion, L.fchCaducidad, L.cantidad, L.precio, L.idDeposito, D.ubicacion as ubicacionDeposito from Lotes L 
	inner join Granjas G on L.idGranja = G.idGranja 
	inner join Productos P on L.idProducto = P.idProducto
	inner join Depositos D on L.idDeposito = D.idDeposito
	Where G.nombre = @nombreGranja and P.nombre = @nombreProducto and L.fchProduccion = format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd') 
END
						
GO
/****** Object:  StoredProcedure [dbo].[BuscarLote_Ferti]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarLote_Ferti] 
	@idFertilizante int,
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	Select idFertilizante, idGranja, idProducto, fchProduccion, cantidad from Lotes_Fertis
	Where idFertilizante = @idFertilizante and idGranja = @idGranja and idProducto = @idProducto and fchProduccion =format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd')
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarLote_Pesti]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarLote_Pesti] 
	@idPesticida int,
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	Select idPesticida, idGranja, idProducto, fchProduccion, cantidad from Lotes_Pestis
	Where idPesticida = @idPesticida and idGranja = @idGranja and idProducto = @idProducto and fchProduccion = format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd')
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarPedidoFiltro]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BuscarPedidoFiltro]
	@NombreCli varchar(40),
	@Estado varchar(40),
	@Viaje varchar(40),
	@CostoMin numeric(10,2),
	@CostoMax numeric(10,2),
	@fchPedidoMenor varchar(20),
	@fchPedidoMayor varchar(20),
	@fchEntregaMenor varchar(20),
	@fchEntregaMayor varchar(20),
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
	and P.costo >= @CostoMin and P.costo <= @CostoMax and P.fchPedido >= @fchPedidoMenor and P.fchPedido <= @fchPedidoMayor and ((P.fechaEntre >= @fchEntregaMenor and P.fechaEntre <= @fchEntregaMayor) or P.fechaEntre is null)
	order by idPedido
	end

	if @ordenar = 'Cliente'
	begin 
	Select idPedido, Per.idPersona as idCliente, Per.nombre as NombreCli, estado,  P.viaje as viaje, costo, fchPedido, fechaEntre, informacionEntrega   
	from Pedidos P inner join Personas Per on Per.idPersona = P.idCliente
	inner join Clientes C on P.idCliente = C.idCliente

	Where C.usuario like '%' + @NombreCli + '%' and P.estado like @Estado + '%' and P.viaje like @Viaje + '%'
	and P.costo >= @CostoMin and P.costo <= @CostoMax and P.fchPedido >= @fchPedidoMenor and P.fchPedido <= @fchPedidoMayor and ((P.fechaEntre >= @fchEntregaMenor and P.fechaEntre <= @fchEntregaMayor) or P.fechaEntre is null)
	order by Per.nombre
	end

		if @ordenar = 'Estado'
	begin 
	Select idPedido, Per.idPersona as idCliente, Per.nombre as NombreCli, estado,  P.viaje as viaje, costo, fchPedido, fechaEntre, informacionEntrega   
	from Pedidos P inner join Personas Per on Per.idPersona = P.idCliente
	inner join Clientes C on P.idCliente = C.idCliente

	Where C.usuario like '%' + @NombreCli + '%' and P.estado like @Estado + '%' and P.viaje like @Viaje + '%'
	and P.costo >= @CostoMin and P.costo <= @CostoMax and P.fchPedido >= @fchPedidoMenor and P.fchPedido <= @fchPedidoMayor and ((P.fechaEntre >= @fchEntregaMenor and P.fechaEntre <= @fchEntregaMayor) or P.fechaEntre is null)
	order by estado
	end

			if @ordenar = 'Viaje'
	begin 
	Select idPedido, Per.idPersona as idCliente, Per.nombre as NombreCli, estado,  P.viaje as viaje, costo, fchPedido, fechaEntre, informacionEntrega   
	from Pedidos P inner join Personas Per on Per.idPersona = P.idCliente
	inner join Clientes C on P.idCliente = C.idCliente

	Where C.usuario like '%' + @NombreCli + '%' and P.estado like @Estado + '%' and P.viaje like @Viaje + '%'
	and P.costo >= @CostoMin and P.costo <= @CostoMax and P.fchPedido >= @fchPedidoMenor and P.fchPedido <= @fchPedidoMayor and ((P.fechaEntre >= @fchEntregaMenor and P.fechaEntre <= @fchEntregaMayor) or P.fechaEntre is null)
	order by P.viaje
	end


			if @ordenar = 'Costo'
	begin 
	Select idPedido, Per.idPersona as idCliente, Per.nombre as NombreCli, estado,  P.viaje as viaje, costo, fchPedido, fechaEntre, informacionEntrega   
	from Pedidos P inner join Personas Per on Per.idPersona = P.idCliente
	Where Per.nombre like '%' + @NombreCli + '%' and P.estado like @Estado + '%' and P.viaje like @Viaje + '%'
	and P.costo >= @CostoMin and P.costo <= @CostoMax and P.fchPedido >= @fchPedidoMenor and P.fchPedido <= @fchPedidoMayor and ((P.fechaEntre >= @fchEntregaMenor and P.fechaEntre <= @fchEntregaMayor) or P.fechaEntre is null)
	order by costo
	end


	if @ordenar = 'Fecha del pedido'
	begin 
	Select idPedido, Per.idPersona as idCliente, Per.nombre as NombreCli, estado,  P.viaje as viaje, costo, fchPedido, fechaEntre,  informacionEntrega   
	from Pedidos P inner join Personas Per on Per.idPersona = P.idCliente
	inner join Clientes C on P.idCliente = C.idCliente

	Where C.usuario like '%' + @NombreCli + '%' and P.estado like @Estado + '%' and P.viaje like @Viaje + '%'
	and P.costo >= @CostoMin and P.costo <= @CostoMax and P.fchPedido >= @fchPedidoMenor and P.fchPedido <= @fchPedidoMayor and ((P.fechaEntre >= @fchEntregaMenor and P.fechaEntre <= @fchEntregaMayor) or P.fechaEntre is null)
	order by fchPedido
	end
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarPedidoLote]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BuscarPedidoLote]

@idPedido int



AS
BEGIN

	SET NOCOUNT ON;

	SELECT L.idPedido as idPedido, P.idProducto as idProducto, P.nombre as nombreProd ,G.idGranja as idGranja,G.nombre as nomGranja , format (L.fchProduccion, 'dd/MM/yyyy') as fchProduccion ,P.tipo as tipo, P.precio as precio, P.imagen as imagen,
	L.cantidad as cantidad, P.cantTotal as cantTotal, P.cantRes as cantRes, L.cantidadViaje as cantidadViaje


	from Lotes_Pedidos L inner join  Productos P on L.idProducto = P.idProducto 
	inner join  Granjas G on L.idGranja = G.idGranja
	where L.idPedido = @idPedido 


END
GO
/****** Object:  StoredProcedure [dbo].[BuscarPedidoProd]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BuscarPedidoProd]

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
/****** Object:  StoredProcedure [dbo].[BuscarPesti]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE PROCEDURE [dbo].[BuscarPesti] 
@id int
AS
BEGIN
	
	SET NOCOUNT ON;
	 	Select idPesti, nombre, tipo, pH, impacto from Pesticidas Where idPesti = @id
END

GO
/****** Object:  StoredProcedure [dbo].[BuscarPesticidaFiltro]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarPesticidaFiltro]
	@nombre varchar(40),
	@tipo varchar(40),
	@impacto varchar (40),
	@phMenor numeric(10,2),
	@phMayor numeric(10,2),
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20),
	@ordenar varchar(40)

AS
BEGIN

	SET NOCOUNT ON;

	if @ordenar = ''
	begin
		Select idPesti, nombre, tipo, pH, impacto from Pesticidas P left join Lotes_Pestis L on L.idPesticida = P.idPesti 
		Where (nombre  LIKE '%' + @nombre + '%' and tipo LIKE '%' + @tipo + '%' and impacto LIKE '%' + @impacto + '%' and (pH >= @phMenor and ph <= @phMayor)
		and ((L.idGranja != @idGranja or L.idGranja is NULL) or (L.idProducto != @idProducto or L.idProducto is NULL) or (L.fchProduccion != CONVERT(DATE,@fchProduccion,103) or L.fchProduccion is NULL)))
		group by idPesti, nombre, tipo, pH, impacto
		order by idPesti
	end
	if @ordenar = 'Nombre'
	begin
		Select idPesti, nombre, tipo, pH, impacto from Pesticidas P left join Lotes_Pestis L on L.idPesticida = P.idPesti 
		Where (nombre  LIKE '%' + @nombre + '%' and tipo LIKE '%' + @tipo + '%' and impacto LIKE '%' + @impacto + '%' and (pH >= @phMenor and ph <= @phMayor)
		and ((L.idGranja != @idGranja or L.idGranja is NULL) or (L.idProducto != @idProducto or L.idProducto is NULL) or (L.fchProduccion != CONVERT(DATE,@fchProduccion,103) or L.fchProduccion is NULL)))
		group by idPesti, nombre, tipo, pH, impacto
		order by nombre
	end
	if @ordenar = 'Tipo'
	begin
		Select idPesti, nombre, tipo, pH, impacto from Pesticidas P left join Lotes_Pestis L on L.idPesticida = P.idPesti 
		Where (nombre  LIKE '%' + @nombre + '%' and tipo LIKE '%' + @tipo + '%' and impacto LIKE '%' + @impacto + '%' and (pH >= @phMenor and ph <= @phMayor)
		and ((L.idGranja != @idGranja or L.idGranja is NULL) or (L.idProducto != @idProducto or L.idProducto is NULL) or (L.fchProduccion != CONVERT(DATE,@fchProduccion,103) or L.fchProduccion is NULL)))
		group by idPesti, nombre, tipo, pH, impacto
		order by tipo
	end


	if @ordenar = 'pH'
	begin
		Select idPesti, nombre, tipo, pH, impacto from Pesticidas P left join Lotes_Pestis L on L.idPesticida = P.idPesti 
		Where (nombre  LIKE '%' + @nombre + '%' and tipo LIKE '%' + @tipo + '%' and impacto LIKE '%' + @impacto + '%' and (pH >= @phMenor and ph <= @phMayor)
		and ((L.idGranja != @idGranja or L.idGranja is NULL) or (L.idProducto != @idProducto or L.idProducto is NULL) or (L.fchProduccion != CONVERT(DATE,@fchProduccion,103) or L.fchProduccion is NULL)))
		group by idPesti, nombre, tipo, pH, impacto
		order by pH
	end
	if @ordenar = 'Impacto'
	begin
		Select idPesti, nombre, tipo, pH, impacto from Pesticidas P left join Lotes_Pestis L on L.idPesticida = P.idPesti 
		Where (nombre  LIKE '%' + @nombre + '%' and tipo LIKE '%' + @tipo + '%' and impacto LIKE '%' + @impacto + '%' and (pH >= @phMenor and ph <= @phMayor)
		and ((L.idGranja != @idGranja or L.idGranja is NULL) or (L.idProducto != @idProducto or L.idProducto is NULL) or (L.fchProduccion != CONVERT(DATE,@fchProduccion,103) or L.fchProduccion is NULL)))
		group by idPesti, nombre, tipo, pH, impacto
		order by impacto
	end
	if @ordenar = 'Cantidad'
	begin
		Select idPesti, nombre, tipo, pH, impacto, cantidad from Pesticidas P left join Lotes_Pestis L on L.idPesticida = P.idPesti 
		Where (nombre  LIKE '%' + @nombre + '%' and tipo LIKE '%' + @tipo + '%' and impacto LIKE '%' + @impacto + '%' and (pH >= @phMenor and ph <= @phMayor)
		and ((L.idGranja != @idGranja or L.idGranja is NULL) or (L.idProducto != @idProducto or L.idProducto is NULL) or (L.fchProduccion != CONVERT(DATE,@fchProduccion,103) or L.fchProduccion is NULL)))
		group by idPesti, nombre, tipo, pH, impacto, cantidad
		order by cantidad
	end
end
GO
/****** Object:  StoredProcedure [dbo].[BuscarProducto]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[BuscarProducto] 
@id int
AS
BEGIN
	
	SET NOCOUNT ON;
	 	Select idProducto, nombre, tipo, precio, tipoVenta, imagen, CantTotal, cantRes from Productos Where idProducto = @id
END

GO
/****** Object:  StoredProcedure [dbo].[BuscarProductoCatFiltro]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarProductoCatFiltro] 
@nombre varchar(40),
@tipo varchar(40),
@tipoVen varchar(40),
@precioMenor numeric(6,0),
@precioMayor numeric(6,0),
@ordenar varchar(40)
AS
BEGIN
		if @ordenar ='Cantidad disponible'

			begin
		Select idProducto, nombre, tipo, tipoVenta, precio,  imagen, cantTotal, cantRes  from Productos 
		Where nombre LIKE '%' + @nombre + '%' and (tipo LIKE   @tipo + '%') and ( tipoVenta LIKE   @tipoVen + '%')
		and (precio >= @precioMenor and precio <= @precioMayor)
		and (cantTotal != '0') and (cantRes != cantTotal)
		order by idProducto
		end

	if @ordenar = 'Nombre'
		begin
		Select idProducto, nombre, tipo, tipoVenta, precio,  imagen, cantTotal, cantRes from Productos
		Where nombre LIKE '%' + @nombre + '%' and (tipo LIKE   @tipo + '%') and ( tipoVenta LIKE   @tipoVen + '%')
		and (precio >= @precioMenor and precio <= @precioMayor)
		and (cantTotal != '0') and (cantRes != cantTotal)
		order by nombre
		end
	if @ordenar = 'Tipo'
		begin
		Select idProducto, nombre, tipo, tipoVenta, precio,  imagen, cantTotal, cantRes from Productos 
		Where nombre LIKE '%' + @nombre + '%' and (tipo LIKE   @tipo + '%') and ( tipoVenta LIKE   @tipoVen + '%')
		and (precio >= @precioMenor and precio <= @precioMayor)
		and (cantTotal != '0') and (cantRes != cantTotal)

		order by tipo
		end
		if @ordenar = 'Tipo de venta'
		begin
		Select idProducto, nombre, tipo, tipoVenta,precio,  imagen, cantTotal, cantRes from Productos 
		Where nombre LIKE '%' + @nombre + '%' and (tipo LIKE   @tipo + '%') and ( tipoVenta LIKE   @tipoVen + '%')
		and (precio >= @precioMenor and precio <= @precioMayor)
		and (cantTotal != '0') and (cantRes != cantTotal)

		order by tipoVenta
		end
		if @ordenar ='Precio'

			begin
		Select idProducto, nombre, tipo, tipoVenta, precio,  imagen, cantTotal, cantRes  from Productos 
		Where nombre LIKE '%' + @nombre + '%' and (tipo LIKE   @tipo + '%') and ( tipoVenta LIKE   @tipoVen + '%')
		and (precio >= @precioMenor and precio <= @precioMayor)
		and (cantTotal != '0') and (cantRes != cantTotal)
		order by precio desc
		end

	
else 
		begin
		Select idProducto, nombre, tipo, tipoVenta, precio,  imagen, cantTotal, cantRes  from Productos 
		Where nombre LIKE '%' + @nombre + '%' and (tipo LIKE   @tipo + '%') and ( tipoVenta LIKE   @tipoVen + '%')
		and (precio >= @precioMenor and precio <= @precioMayor)
		and (cantTotal != '0') and (cantRes != cantTotal)
		order by idProducto
		end
END

GO
/****** Object:  StoredProcedure [dbo].[BuscarProductoCli]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BuscarProductoCli]
 @idProducto int,
 @idCliente int
AS
BEGIN
	select Pp.idPedido as idPedido   from Pedidos_Prod Pp inner join Pedidos  P on  Pp.idPedido = P.idPedido
	where Pp.idProducto = @idProducto and P.idCliente = @idCliente



END
GO
/****** Object:  StoredProcedure [dbo].[BuscarProductoClixNom]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BuscarProductoClixNom]

@idPedido int, 
 @nomProd varchar(40)
AS
BEGIN
	
	SELECT Pp.idPedido as idPedido, Pp.idProducto, P.nombre as nombre,  Pp.cantidad as cantidad from Pedidos_Prod Pp inner join  Productos P 
	on Pp.idProducto = P.idProducto
	where P.nombre = @nomProd and Pp.idPedido = @idPedido


END
GO
/****** Object:  StoredProcedure [dbo].[BuscarProductoFiltro]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarProductoFiltro] 
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

	if @ordenar = 'Cantidad disponible'
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
/****** Object:  StoredProcedure [dbo].[BuscarViaje]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BuscarViaje] 
@idViaje int

AS
BEGIN

		
			select V.idViaje, V.costo, V.fecha, V.idCamion, C.marca as marcaCamion, C.modelo as modeloCamion, V.idCamionero, P.nombre as nombreCamionero, V.estado from Viajes V 
			inner join Camiones C on C.idCamion = V.idCamion 
			inner join Personas P on P.idPersona = V.idCamionero
			where idViaje = @idViaje
		
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarViajeFiltro]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[BuscarViajeFiltro]
	@camion int,
	@camionero int,
	@estado varchar(20),
	@costoMenor numeric(8,0),
	@costoMayor numeric(8,0),
	@fechaMenor varchar(10),
	@fechaMayor varchar(10),
	@ordenar varchar(40)

AS 
BEGIN

	SET NOCOUNT ON;

	if @ordenar = ''
	begin
		if @camion = 0 and @camionero = 0
		begin
			select V.idViaje, V.costo, V.fecha, V.idCamion, C.marca as marcaCamion, C.modelo as modeloCamion, V.idCamionero, P.nombre as nombreCamionero, V.estado from Viajes V 
			inner join Camiones C on C.idCamion = V.idCamion 
			inner join Personas P on P.idPersona = V.idCamionero 
			where V.costo >= @costoMenor and V.costo <= @costoMayor and V.fecha >= @fechaMenor and V.fecha <= @fechaMayor 
			and V.estado LIKE '%' + @estado + '%'
		end
		if @camionero = 0
		begin
			select V.idViaje, V.costo, V.fecha, V.idCamion, C.marca as marcaCamion, C.modelo as modeloCamion, V.idCamionero, P.nombre as nombreCamionero, V.estado from Viajes V 
			inner join Camiones C on C.idCamion = V.idCamion 
			inner join Personas P on P.idPersona = V.idCamionero 
			where V.costo >= @costoMenor and V.costo <= @costoMayor and V.fecha >= @fechaMenor and V.fecha <= @fechaMayor 
			and V.estado LIKE '%' + @estado + '%' and V.idCamion = @camion
		end
		if @camion = 0
		begin
			select V.idViaje, V.costo, V.fecha, V.idCamion, C.marca as marcaCamion, C.modelo as modeloCamion, V.idCamionero, P.nombre as nombreCamionero, V.estado from Viajes V 
			inner join Camiones C on C.idCamion = V.idCamion 
			inner join Personas P on P.idPersona = V.idCamionero 
			where V.costo >= @costoMenor and V.costo <= @costoMayor and V.fecha >= @fechaMenor and V.fecha <= @fechaMayor 
			and V.estado LIKE '%' + @estado + '%' and V.idCamionero = @camionero
		end
		else
		begin
			select V.idViaje, V.costo, V.fecha, V.idCamion, C.marca as marcaCamion, C.modelo as modeloCamion, V.idCamionero, P.nombre as nombreCamionero, V.estado from Viajes V 
			inner join Camiones C on C.idCamion = V.idCamion 
			inner join Personas P on P.idPersona = V.idCamionero 
			where V.costo >= @costoMenor and V.costo <= @costoMayor and V.fecha >= @fechaMenor and V.fecha <= @fechaMayor 
			and V.estado LIKE '%' + @estado + '%' and V.idCamionero = @camionero and V.idCamion = @camion
		end
	end
	if @ordenar = 'Costo'
	begin
		if @camion = 0 and @camionero = 0
		begin
			select V.idViaje, V.costo, V.fecha, V.idCamion, C.marca as marcaCamion, C.modelo as modeloCamion, V.idCamionero, P.nombre as nombreCamionero, V.estado from Viajes V 
			inner join Camiones C on C.idCamion = V.idCamion 
			inner join Personas P on P.idPersona = V.idCamionero 
			where V.costo >= @costoMenor and V.costo <= @costoMayor and V.fecha >= @fechaMenor and V.fecha <= @fechaMayor 
			and V.estado LIKE '%' + @estado + '%'
			order by V.costo
		end
		if @camionero = 0
		begin
			select V.idViaje, V.costo, V.fecha, V.idCamion, C.marca as marcaCamion, C.modelo as modeloCamion, V.idCamionero, P.nombre as nombreCamionero, V.estado from Viajes V 
			inner join Camiones C on C.idCamion = V.idCamion 
			inner join Personas P on P.idPersona = V.idCamionero 
			where V.costo >= @costoMenor and V.costo <= @costoMayor and V.fecha >= @fechaMenor and V.fecha <= @fechaMayor 
			and V.estado LIKE '%' + @estado + '%' and V.idCamion = @camion
			order by V.costo
		end
		if @camion = 0
		begin
			select V.idViaje, V.costo, V.fecha, V.idCamion, C.marca as marcaCamion, C.modelo as modeloCamion, V.idCamionero, P.nombre as nombreCamionero, V.estado from Viajes V 
			inner join Camiones C on C.idCamion = V.idCamion 
			inner join Personas P on P.idPersona = V.idCamionero 
			where V.costo >= @costoMenor and V.costo <= @costoMayor and V.fecha >= @fechaMenor and V.fecha <= @fechaMayor 
			and V.estado LIKE '%' + @estado + '%' and V.idCamionero = @camionero
			order by V.costo
		end
		else
		begin
			select V.idViaje, V.costo, V.fecha, V.idCamion, C.marca as marcaCamion, C.modelo as modeloCamion, V.idCamionero, P.nombre as nombreCamionero, V.estado from Viajes V 
			inner join Camiones C on C.idCamion = V.idCamion 
			inner join Personas P on P.idPersona = V.idCamionero 
			where V.costo >= @costoMenor and V.costo <= @costoMayor and V.fecha >= @fechaMenor and V.fecha <= @fechaMayor 
			and V.estado LIKE '%' + @estado + '%' and V.idCamionero = @camionero and V.idCamion = @camion
			order by V.costo
		end
	end

	if @ordenar = 'Fecha'
	begin
		if @camion = 0 and @camionero = 0
		begin
			select V.idViaje, V.costo, V.fecha, V.idCamion, C.marca as marcaCamion, C.modelo as modeloCamion, V.idCamionero, P.nombre as nombreCamionero, V.estado from Viajes V 
			inner join Camiones C on C.idCamion = V.idCamion 
			inner join Personas P on P.idPersona = V.idCamionero 
			where V.costo >= @costoMenor and V.costo <= @costoMayor and V.fecha >= @fechaMenor and V.fecha <= @fechaMayor 
			and V.estado LIKE '%' + @estado + '%'
			order by V.fecha
		end
		if @camionero = 0
		begin
			select V.idViaje, V.costo, V.fecha, V.idCamion, C.marca as marcaCamion, C.modelo as modeloCamion, V.idCamionero, P.nombre as nombreCamionero, V.estado from Viajes V 
			inner join Camiones C on C.idCamion = V.idCamion 
			inner join Personas P on P.idPersona = V.idCamionero 
			where V.costo >= @costoMenor and V.costo <= @costoMayor and V.fecha >= @fechaMenor and V.fecha <= @fechaMayor 
			and V.estado LIKE '%' + @estado + '%' and V.idCamion = @camion
			order by V.fecha
		end
		if @camion = 0
		begin
			select V.idViaje, V.costo, V.fecha, V.idCamion, C.marca as marcaCamion, C.modelo as modeloCamion, V.idCamionero, P.nombre as nombreCamionero, V.estado from Viajes V 
			inner join Camiones C on C.idCamion = V.idCamion 
			inner join Personas P on P.idPersona = V.idCamionero 
			where V.costo >= @costoMenor and V.costo <= @costoMayor and V.fecha >= @fechaMenor and V.fecha <= @fechaMayor 
			and V.estado LIKE '%' + @estado + '%' and V.idCamionero = @camionero
			order by V.fecha
		end
		else
		begin
			select V.idViaje, V.costo, V.fecha, V.idCamion, C.marca as marcaCamion, C.modelo as modeloCamion, V.idCamionero, P.nombre as nombreCamionero, V.estado from Viajes V 
			inner join Camiones C on C.idCamion = V.idCamion 
			inner join Personas P on P.idPersona = V.idCamionero 
			where V.costo >= @costoMenor and V.costo <= @costoMayor and V.fecha >= @fechaMenor and V.fecha <= @fechaMayor 
			and V.estado LIKE '%' + @estado + '%' and V.idCamionero = @camionero and V.idCamion = @camion
			order by V.fecha
		end
	end


	if @ordenar = 'Estado'
	begin
		if @camion = 0 and @camionero = 0
		begin
			select V.idViaje, V.costo, V.fecha, V.idCamion, C.marca as marcaCamion, C.modelo as modeloCamion, V.idCamionero, P.nombre as nombreCamionero, V.estado from Viajes V 
			inner join Camiones C on C.idCamion = V.idCamion 
			inner join Personas P on P.idPersona = V.idCamionero 
			where V.costo >= @costoMenor and V.costo <= @costoMayor and V.fecha >= @fechaMenor and V.fecha <= @fechaMayor 
			and V.estado LIKE '%' + @estado + '%'
			order by V.estado
		end
		if @camionero = 0
		begin
			select V.idViaje, V.costo, V.fecha, V.idCamion, C.marca as marcaCamion, C.modelo as modeloCamion, V.idCamionero, P.nombre as nombreCamionero, V.estado from Viajes V 
			inner join Camiones C on C.idCamion = V.idCamion 
			inner join Personas P on P.idPersona = V.idCamionero 
			where V.costo >= @costoMenor and V.costo <= @costoMayor and V.fecha >= @fechaMenor and V.fecha <= @fechaMayor 
			and V.estado LIKE '%' + @estado + '%' and V.idCamion = @camion
			order by V.estado
		end
		if @camion = 0
		begin
			select V.idViaje, V.costo, V.fecha, V.idCamion, C.marca as marcaCamion, C.modelo as modeloCamion, V.idCamionero, P.nombre as nombreCamionero, V.estado from Viajes V 
			inner join Camiones C on C.idCamion = V.idCamion 
			inner join Personas P on P.idPersona = V.idCamionero 
			where V.costo >= @costoMenor and V.costo <= @costoMayor and V.fecha >= @fechaMenor and V.fecha <= @fechaMayor 
			and V.estado LIKE '%' + @estado + '%' and V.idCamionero = @camionero
			order by V.estado
		end
		else
		begin
			select V.idViaje, V.costo, V.fecha, V.idCamion, C.marca as marcaCamion, C.modelo as modeloCamion, V.idCamionero, P.nombre as nombreCamionero, V.estado from Viajes V 
			inner join Camiones C on C.idCamion = V.idCamion 
			inner join Personas P on P.idPersona = V.idCamionero 
			where V.costo >= @costoMenor and V.costo <= @costoMayor and V.fecha >= @fechaMenor and V.fecha <= @fechaMayor 
			and V.estado LIKE '%' + @estado + '%' and V.idCamionero = @camionero and V.idCamion = @camion
			order by V.estado
		end
	end
end

GO
/****** Object:  StoredProcedure [dbo].[BuscarViajePedLote]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BuscarViajePedLote]

@idPedido int,
@idViaje int


AS
BEGIN

	SET NOCOUNT ON;
			if @idViaje = 0 and  @idPedido = 0 
		begin 
				SELECT L.idViaje as idViaje, L.idPedido as idPedido, P.idProducto as idProducto, P.nombre as nombreProd ,G.idGranja as idGranja,G.nombre as nomGranja , 
			L.fchProduccion as fchProduccion, L.cantidad as cantidad
			from Viajes_Lots_Ped L inner join  Productos P on L.idProducto = P.idProducto 
			inner join  Granjas G on L.idGranja = G.idGranja
				
			end


	if @idPedido = 0
		begin

			SELECT L.idViaje as idViaje, L.idPedido as idPedido, P.idProducto as idProducto, P.nombre as nombreProd ,G.idGranja as idGranja,G.nombre as nomGranja , 
			L.fchProduccion as fchProduccion, L.cantidad as cantidad
			from Viajes_Lots_Ped L inner join  Productos P on L.idProducto = P.idProducto 
			inner join  Granjas G on L.idGranja = G.idGranja
			where   L.idViaje = @idViaje
		end

		if @idViaje = 0
		begin

			SELECT L.idViaje as idViaje, L.idPedido as idPedido, P.idProducto as idProducto, P.nombre as nombreProd ,G.idGranja as idGranja,G.nombre as nomGranja , 
			L.fchProduccion as fchProduccion, L.cantidad as cantidad
			from Viajes_Lots_Ped L inner join  Productos P on L.idProducto = P.idProducto 
			inner join  Granjas G on L.idGranja = G.idGranja
			where L.idPedido = @idPedido  
		
		end




	else
		begin 
				SELECT L.idViaje as idViaje, L.idPedido as idPedido, P.idProducto as idProducto, P.nombre as nombreProd ,G.idGranja as idGranja,G.nombre as nomGranja , 
			L.fchProduccion as fchProduccion, L.cantidad as cantidad
			from Viajes_Lots_Ped L inner join  Productos P on L.idProducto = P.idProducto 
			inner join  Granjas G on L.idGranja = G.idGranja
				where L.idPedido = @idPedido  
			and L.idViaje = @idViaje		
			end

END
GO
/****** Object:  StoredProcedure [dbo].[CambiarEstadoPed]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CambiarEstadoPed]
	@estado varchar(40),
	@idPedido int,
	@idAdmin int
AS
BEGIN
	Update  Pedidos set estado = @estado
	where idPedido = @idPedido

	if @estado = 'Finalizado'
	begin
		Update Pedidos set fechaEntre = CONVERT(VARCHAR(16), GETDATE(), 120) where idPedido = @idPedido
	end

	if @idAdmin != 0
	begin
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Pedidos', 'Modificar');
	end
END
GO
/****** Object:  StoredProcedure [dbo].[IniciarSesionAdm]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IniciarSesionAdm]
	-- Add the parameters for the stored procedure here
	@User varchar(40),
	@Pass varchar(1000)
As
BEGIN
	

		Select idAdmin  from Admins
		where usuario = @User and contrasena = @Pass 
		and estado = 'Habilitado'
END
GO
/****** Object:  StoredProcedure [dbo].[IniciarSesionCli]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IniciarSesionCli]
	-- Add the parameters for the stored procedure here
	@User varchar(40),
	@Pass varchar(1000)
As
BEGIN
	

		Select idCliente, usuario  from Clientes
		where usuario = @User and contrasena = @Pass
END
GO
/****** Object:  StoredProcedure [dbo].[listPedido]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[listPedido] 
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
/****** Object:  StoredProcedure [dbo].[listPedidoCli]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[listPedidoCli] 
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
/****** Object:  StoredProcedure [dbo].[listPedidoCli_Prod]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[listPedidoCli_Prod] 
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
/****** Object:  StoredProcedure [dbo].[LstFertisEnLote]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LstFertisEnLote]
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20)
as
BEGIN

	SET NOCOUNT ON;
	Select F.idFerti, F.nombre, F.tipo, L.cantidad from Fertilizantes F inner join Lotes_Fertis L on L.idFertilizante = F.idFerti 
	where L.idGranja = @idGranja and L.idProducto = @idProducto and L.fchProduccion = CONVERT(DATE,@fchProduccion,103)
	order by F.idFerti
END
GO
/****** Object:  StoredProcedure [dbo].[LstFertisEnLoteFiltro]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LstFertisEnLoteFiltro]
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20)
as
BEGIN

	SET NOCOUNT ON;

	
	if @idGranja = 0 and @idProducto = 0 
	begin
	Select F.idFerti, F.nombre, F.tipo, F.pH,  L.cantidad from Fertilizantes F inner join Lotes_Fertis L on L.idFertilizante = F.idFerti 

	end


	else
	
	begin
	Select F.idFerti, F.nombre, F.tipo, F.pH,  L.cantidad from Fertilizantes F inner join Lotes_Fertis L on L.idFertilizante = F.idFerti 
	where (L.idGranja = @idGranja and L.idProducto = @idProducto and L.fchProduccion = format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd'))
	order by F.idFerti
	end


END
GO
/****** Object:  StoredProcedure [dbo].[LstIdPersonas]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LstIdPersonas]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select idPersona from Personas
END
GO
/****** Object:  StoredProcedure [dbo].[LstPestiEnLoteFiltro]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LstPestiEnLoteFiltro]
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20)
as
BEGIN

	SET NOCOUNT ON;
	
	if @idGranja = 0 and @idProducto = 0 
	begin
	Select P.idPesti, P.nombre, P.tipo, P.pH,  L.cantidad from Pesticidas P inner join Lotes_Pestis L on L.idPesticida = P.idPesti 
	end


	else
	begin
	Select P.idPesti, P.nombre, P.tipo, P.pH,  L.cantidad from Pesticidas P inner join Lotes_Pestis L on L.idPesticida = P.idPesti 
	where (L.idGranja = @idGranja and L.idProducto = @idProducto and L.fchProduccion =format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd'))
	
	order by P.idPesti
	end


END
GO
/****** Object:  StoredProcedure [dbo].[LstPestisEnLote]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LstPestisEnLote]
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20)
as
BEGIN

	SET NOCOUNT ON;
	Select P.idPesti, P.nombre, P.tipo, L.cantidad from Pesticidas P inner join Lotes_Pestis L on L.idPesticida = P.idPesti
	where L.idGranja = @idGranja and L.idProducto = @idProducto and L.fchProduccion = CONVERT(DATE,@fchProduccion,103)
 order by P.idPesti

END

select * from Lotes_Pestis
GO
/****** Object:  StoredProcedure [dbo].[ModCantPedidoCli]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ModCantPedidoCli]

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
/****** Object:  StoredProcedure [dbo].[ModCantPedidoLote]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModCantPedidoLote]

@idPedido int,
@idGranja int,
@idProducto int,
@fchProduccion varchar(40),
@Cantidad varchar(40),
@CantLote varchar(40),
@CantDisp varchar(40),
@CantRess varchar(40),
@idAdmin int

AS
BEGIN
	
	update Lotes_Pedidos set cantidad = @Cantidad
	where idPedido =@idPedido and 
	idGranja = @idGranja and
	idProducto = @idProducto and
	fchProduccion = CONVERT(DATE,@fchProduccion,103)

	if  @@ROWCOUNT>0   
	insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Lotes Pedidos', 'Modificar');
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
/****** Object:  StoredProcedure [dbo].[ModificarAdm]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ModificarAdm]
	@id int,
	@nombre varchar(40),
	@apellido varchar(40),
	@fchNac varchar (40),
	
	@TipoAdm varchar(40),
	@estado varchar(40),
	@idAdmin int
AS
BEGIN
    UPDATE Admins SET tipoDeAdmin = @TipoAdm, estado = @estado  where idAdmin = @id
	
		UPDATE Personas SET nombre = @nombre, apellido = @apellido, fchNacimiento = @fchNac where idPersona = @id
		if  @@ROWCOUNT>0   
	begin 
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Admins', 'Modificar');
		end

END
GO
/****** Object:  StoredProcedure [dbo].[ModificarCam]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ModificarCam]
	@id int,
	@marca varchar(40),
	@modelo varchar(40),
	@carga numeric(10,2),
	@disponible varchar (40),
	@idAdmin int

AS
BEGIN
    UPDATE Camiones SET idCamion = @id, marca = @marca, modelo = @modelo, carga = @carga, disponible = @disponible where idCamion = @id

	if  @@ROWCOUNT>0   
	begin 
	insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Camiones', 'Modificar');
	end


END
GO
/****** Object:  StoredProcedure [dbo].[ModificarCamionero]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ModificarCamionero]
	@id int,
	@nombre varchar(40),
	@apellido varchar(40),
	@email varchar(40),
	@tele varchar (40),
	@fchNac varchar (40),
	@cedula varchar(11),
	@disp varchar(20),
	@manejo varchar(20),
	@idAdmin int
AS
BEGIN
    UPDATE Camioneros SET cedula = @cedula, disponible = @disp, fchManejo = @manejo where idCamionero = @id

		UPDATE Personas SET nombre = @nombre, apellido = @apellido, email = @email, telefono = @tele, fchNacimiento =@fchNac where idPersona = @id

		if  @@ROWCOUNT>0   
	begin 
		insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Camioneros', 'Modificar');
		end

END
GO
/****** Object:  StoredProcedure [dbo].[ModificarCli]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModificarCli]
	@id int,
	@nombre varchar(40),
	@apellido varchar(40),
	@email varchar(40),
	@tele varchar (40),
	@fchNac varchar (40),
	@user varchar(40),
	@pass varchar(40),
	@dirr varchar(40)

AS
BEGIN
	if @pass = ''
	begin
		UPDATE Clientes SET usuario = @user,  direccion = @dirr  where idCliente = @id
	end
	else
	begin
		UPDATE Clientes SET usuario = @user, contrasena = @pass,  direccion = @dirr  where idCliente = @id
	end
	if  @@ROWCOUNT>0   
	begin 
	UPDATE Personas SET nombre = @nombre, apellido = @apellido, email = @email, telefono = @tele, fchNacimiento = @fchNac where idPersona = @id
	end
END
GO
/****** Object:  StoredProcedure [dbo].[ModificarDeposito]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ModificarDeposito]
	@id int,
	@capacidad varchar(20),
	@ubicacion varchar(50),
	@temperatura numeric(3,0),
	@condiciones varchar(80),
	@idAdmin int

AS
BEGIN
    UPDATE Depositos SET capacidad = @capacidad, ubicacion = @ubicacion, temperatura = @temperatura, condiciones = @condiciones  where idDeposito = @id

	if  @@ROWCOUNT>0   
	begin 
	insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Depositos', 'Modificar');
	end
END
GO
/****** Object:  StoredProcedure [dbo].[ModificarFerti]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[ModificarFerti]
	@id int,
	@nombre varchar(40),
	@tipo varchar(40),
	@pH numeric(4,2),
	@impacto varchar(30),
	@idAdmin int

AS
BEGIN
    UPDATE Fertilizantes SET nombre = @nombre, tipo = @tipo, pH = @pH, impacto = @impacto  where idFerti = @id
	if  @@ROWCOUNT>0   
	begin 
	insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Fertilizantes', 'Modificar');
	end
END
GO
/****** Object:  StoredProcedure [dbo].[ModificarGranja]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModificarGranja]
	@id int,
	@nombre varchar(30),
	@ubicacion varchar(50),
	@idCliente int,
	@idAdmin int
AS
BEGIN
    UPDATE Granjas SET nombre = @nombre, ubicacion = @ubicacion, idCliente = @idCliente where idGranja = @id

	if  @@ROWCOUNT>0   
	begin 
	insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Granjas', 'Modificar');
	end
END
GO
/****** Object:  StoredProcedure [dbo].[ModificarLote]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModificarLote]
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20),
	@fchCaducidad varchar(20),
	@cantidad varchar(40),
	@precio numeric(10,2),
	@idDeposito int,
	@cantTotal varchar(40),
	@idAdmin int
AS
BEGIN
begin tran
    UPDATE Lotes SET fchCaducidad = @fchCaducidad, cantidad = @cantidad, precio = @precio, idDeposito = @idDeposito 
	where idGranja = @idGranja and idProducto = @idProducto and fchProduccion =  format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd') 
		if @@ROWCOUNT > 0
	begin
		 Update Productos set CantTotal = @cantTotal 
	 where idProducto = @idProducto
	 	if @@ROWCOUNT > 0
	begin

	 begin 
	 insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Lotes', 'Modificar');
	 commit tran 
	 end
	 end

	 end
	 else
	 begin  
	 raiserror('No se puedo modificar el lote',1,1);
		rollback;
	 end

	   
	

	end
	
GO
/****** Object:  StoredProcedure [dbo].[ModificarLoteFerti]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModificarLoteFerti]
	@idFertilizante int,
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20),
	@cantidad varchar(30),
	@idAdmin int
AS
BEGIN
    UPDATE Lotes_Fertis SET cantidad = @cantidad
	where idFertilizante = @idFertilizante and idGranja = @idGranja and idProducto = @idProducto and fchProduccion = format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd')
	if  @@ROWCOUNT>0   
	begin 
	insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Lotes Fertis', 'Modificar');
	end
END
GO
/****** Object:  StoredProcedure [dbo].[ModificarLotePesti]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModificarLotePesti]
	@idPesticida int,
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20),
	@cantidad varchar(30),
	@idAdmin int
AS
BEGIN
    UPDATE Lotes_Pestis SET cantidad = @cantidad
	where idPesticida = @idPesticida and idGranja = @idGranja and idProducto = @idProducto and fchProduccion =format( CONVERT(DATE,@fchProduccion),'yyyy-MM-dd')

	if  @@ROWCOUNT>0   
	begin 
	insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Lotes Pestis', 'Modificar');
	end
END
GO
/****** Object:  StoredProcedure [dbo].[ModificarPesti]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[ModificarPesti]
	@id int,
	@nombre varchar(40),
	@tipo varchar(40),
	@pH numeric(4,2),
	@impacto varchar(30),
	@idAdmin int

AS
BEGIN
    UPDATE Pesticidas SET nombre = @nombre, tipo = @tipo, pH = @pH, impacto = @impacto  where idPesti = @id
	if  @@ROWCOUNT>0   
	begin 
	insert into Auditoria values (@idAdmin,CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Pesticidas', 'Modificar');
	end
END
GO
/****** Object:  StoredProcedure [dbo].[ModificarProducto]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModificarProducto]
	@id int,
	@nombre varchar(30),
	@tipo varchar(30),
	@tipoVenta varchar(15),
	@imagen varchar(MAX),
	@precio numeric(6,0),
	@idAdmin int
AS
BEGIN
    UPDATE Productos SET nombre = @nombre, tipo = @tipo, tipoVenta = @tipoVenta, imagen = @imagen, precio = @precio where idProducto = @id

	if  @@ROWCOUNT>0   
	begin 
	insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Productos', 'Modificar');
	end
END
GO
/****** Object:  StoredProcedure [dbo].[ModificarViaje]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ModificarViaje]
	@id int,
	@costo numeric(8,0),
	@fecha varchar(20),
	@camion int,
	@camionero int,
	@estado varchar(20),
	@idAdmin int

AS
BEGIN
    UPDATE Viajes SET costo = @costo, fecha = @fecha, idCamion = @camion, idCamionero = @camionero, estado = @estado  where idViaje = @id
	if  @@ROWCOUNT>0   
	begin 
	insert into Auditoria values (@idAdmin,CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Viajes', 'Modificar');
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
	end
END
GO
/****** Object:  StoredProcedure [dbo].[ModPedViajeEst]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[ModPedViajeEst]

	@idPedido int,
	@estado varchar(20),
	@idAdmin int

AS
BEGIN


	IF @estado = 'Confirmado' 
	begin
		Update Pedidos Set viaje = 'Asignado'
		where idPedido = @idPedido
		
		if  @@ROWCOUNT>0   
		begin
		 insert into Auditoria values (@idAdmin,CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Pedidos', 'Modificar');
		end

	end
	IF @estado = 'Pendiente'
	begin

	Update Pedidos Set viaje = 'Sin asignar'
		where idPedido = @idPedido
			if  @@ROWCOUNT>0   
		begin
		 insert into Auditoria values (@idAdmin, CONVERT(VARCHAR(16), DATEADD(HOUR, 2, GETDATE()) , 120 ), 'Pedidos', 'Modificar');
		end

	end

END
GO
/****** Object:  StoredProcedure [dbo].[userRepetidoAdm]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[userRepetidoAdm]

AS
BEGIN

select usuario from Admins 


END
GO
/****** Object:  StoredProcedure [dbo].[userRepetidoCli]    Script Date: 26/10/2023 16:55:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[userRepetidoCli]

AS
BEGIN

select usuario from Clientes


END
GO
