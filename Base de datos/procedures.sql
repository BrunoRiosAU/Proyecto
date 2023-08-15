USE [Proyecto]
GO
/****** Object:  StoredProcedure [dbo].[AltaAdmin]    Script Date: 14/8/2023 21:49:37 ******/
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
	@estado varchar(40)

	
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

		Commit tran
	

END
GO
/****** Object:  StoredProcedure [dbo].[AltaCam]    Script Date: 14/8/2023 21:49:37 ******/
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
	@disponible varchar (40)



	
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

		Commit tran
	

END
GO
/****** Object:  StoredProcedure [dbo].[AltaCamionero]    Script Date: 14/8/2023 21:49:37 ******/
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
	@manejo varchar(20)

	
AS
BEGIN
	insert into Personas (idPersona, nombre, apellido, email, telefono, fchNacimiento) 
	values (@id, @nombre, @apellido, @email, @tele, @fchNac)
	if @@ROWCOUNT > 0
	begin
		insert into Camioneros(idCamionero, cedula, disponible, fchManejo) 
		values (@id, @cedula, @disp, @manejo)
	end
END
GO
/****** Object:  StoredProcedure [dbo].[AltaCli]    Script Date: 14/8/2023 21:49:37 ******/
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
/****** Object:  StoredProcedure [dbo].[AltaDeposito]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AltaDeposito]
	@id int,
	@capacidad varchar(20),
	@ubicacion varchar(50),
	@temperatura numeric(3,0),
	@condiciones varchar(80)
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

		Commit tran
	

END
GO
/****** Object:  StoredProcedure [dbo].[AltaFerti]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[AltaFerti]
	@id int,
	@nombre varchar(40),
	@tipo varchar(40),
	@pH numeric(2),
	@impacto varchar(30)
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

		Commit tran
	

END
GO
/****** Object:  StoredProcedure [dbo].[AltaGranja]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AltaGranja]
	@id int,
	@nombre varchar(30),
	@ubicacion varchar(50),
	@idCliente int
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
Commit tran
END
GO
/****** Object:  StoredProcedure [dbo].[AltaLote]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**/
CREATE PROCEDURE [dbo].[AltaLote]
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20),
	@cantidad numeric(10,0),
	@precio numeric(10,2),
	@idDeposito int
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRANSACTION
	insert into Lotes values (@idGranja, @idProducto, @fchProduccion, @cantidad, @precio, @idDeposito) 
	If not exists (Select * From Lotes Where idGranja = @idGranja and idProducto = @idProducto and fchProduccion = @fchProduccion)
	Begin
	raiserror('No se pudo crear el Lote',1,1);
		rollback;
	End
	
Commit tran
END

GO
/****** Object:  StoredProcedure [dbo].[AltaLoteFerti]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AltaLoteFerti]
	@idFertilizante int,
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20),
	@cantidad varchar(30)
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRANSACTION
	insert into Lotes_Fertis values(@idFertilizante, @idGranja, @idProducto, CONVERT(DATE,@fchProduccion,103), @cantidad)
	If not exists (Select * From Lotes_Fertis Where idFertilizante = @idFertilizante and idGranja = @idGranja and idProducto = @idProducto and fchProduccion = CONVERT(DATE,@fchProduccion,103))
	Begin
	raiserror('No se pudo crear el Lote_Ferti',1,1);
		rollback;
	End
	
Commit tran
END



GO
/****** Object:  StoredProcedure [dbo].[AltaLotePesti]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AltaLotePesti]
	@idPesticida int,
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20),
	@cantidad varchar(30)
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRANSACTION
	insert into Lotes_Pestis values(@idPesticida, @idGranja, @idProducto, CONVERT(DATE,@fchProduccion,103), @cantidad)
	If not exists (Select * From Lotes_Pestis Where idPesticida = @idPesticida and idGranja = @idGranja and idProducto = @idProducto and fchProduccion = CONVERT(DATE,@fchProduccion,103))
	Begin
	raiserror('No se pudo crear el Lote_Pesti',1,1);
		rollback;
	End
	
Commit tran
END
GO
/****** Object:  StoredProcedure [dbo].[AltaPesti]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[AltaPesti]
	@id int,
	@nombre varchar(40),
	@tipo varchar(40),
	@pH numeric(2),
	@impacto varchar(30)
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

		Commit tran
	

END
GO
/****** Object:  StoredProcedure [dbo].[AltaProducto]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AltaProducto]
	@id int,
	@nombre varchar(30),
	@tipo varchar(30),
	@tipoVenta varchar(15),
	@imagen varchar(MAX)
AS
BEGIN
	SET NOCOUNT ON;

BEGIN TRANSACTION
	insert into Productos values (@id, @nombre, @tipo, @tipoVenta, @imagen) 
	If not exists (Select * From Productos Where idProducto = @id)
	Begin
	raiserror('No se pudo crear el Producto',1,1);
		rollback;
	End
Commit tran
END
GO
/****** Object:  StoredProcedure [dbo].[BajaAdmin]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[BajaAdmin] @id int
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

		Commit tran
	

End
GO
/****** Object:  StoredProcedure [dbo].[BajaCam]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[BajaCam] @id int
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

		Commit tran
	

End
GO
/****** Object:  StoredProcedure [dbo].[BajaCamionero]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[BajaCamionero]
	@id int
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

		Commit tran
	

END
GO
/****** Object:  StoredProcedure [dbo].[BajaCli]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[BajaCli] @id int
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

		Commit tran
	

End
GO
/****** Object:  StoredProcedure [dbo].[BajaDeposito]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[BajaDeposito] @id int
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

	Commit tran
	

End
GO
/****** Object:  StoredProcedure [dbo].[BajaFerti]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[BajaFerti] @id int
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

	Commit tran
	

End
GO
/****** Object:  StoredProcedure [dbo].[BajaGranja]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[BajaGranja]
	@id int
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
Commit tran
End
GO
/****** Object:  StoredProcedure [dbo].[BajaLote]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[BajaLote]
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20)
As
BEGIN
	SET NOCOUNT ON;
	BEGIN TRANSACTION

		Delete from Lotes_Fertis where idGranja = @idGranja and idProducto = @idProducto and fchProduccion = CONVERT(DATE,@fchProduccion,103)
		Delete from Lotes where idGranja = @idGranja and idProducto = @idProducto and fchProduccion = CONVERT(DATE,@fchProduccion,103)
		If exists (Select * From Lotes Where idGranja = @idGranja and idProducto = @idProducto and fchProduccion = CONVERT(DATE,@fchProduccion,103))
		begin
			raiserror('No se pudo borrar el Lote',1,1);
			rollback;
		end

	
	
Commit tran
End

GO
/****** Object:  StoredProcedure [dbo].[BajaLoteFerti]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[BajaLoteFerti]
	@idFertilizante int,
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20)
As
BEGIN
	SET NOCOUNT ON;
	BEGIN TRANSACTION

		Delete from Lotes_Fertis where idFertilizante = @idFertilizante and idGranja = @idGranja and idProducto = @idProducto and fchProduccion = CONVERT(DATE,@fchProduccion,103)
		If exists (Select * From Lotes_Fertis Where idFertilizante = @idFertilizante and idGranja = @idGranja and idProducto = @idProducto and fchProduccion = CONVERT(DATE,@fchProduccion,103))
		begin
			raiserror('No se pudo borrar el Lote_Ferti',1,1);
			rollback;
		end

	
	
Commit tran
End

GO
/****** Object:  StoredProcedure [dbo].[BajaLotePesti]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[BajaLotePesti]
	@idPesticida int,
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20)
As
BEGIN
	SET NOCOUNT ON;
	BEGIN TRANSACTION

		Delete from Lotes_Pestis where idPesticida = @idPesticida and idGranja = @idGranja and idProducto = @idProducto and fchProduccion = CONVERT(DATE,@fchProduccion,103)
		If exists (Select * From Lotes_Pestis Where idPesticida = @idPesticida and idGranja = @idGranja and idProducto = @idProducto and fchProduccion = CONVERT(DATE,@fchProduccion,103))
		begin
			raiserror('No se pudo borrar el Lote_Pesti',1,1);
			rollback;
		end
Commit tran
End

GO
/****** Object:  StoredProcedure [dbo].[BajaPesti]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE  [dbo].[BajaPesti] @id int
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

	Commit tran
	

End
GO
/****** Object:  StoredProcedure [dbo].[BajaProducto]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[BajaProducto]
	@id int
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
Commit tran
End
GO
/****** Object:  StoredProcedure [dbo].[BuscarAdm]    Script Date: 14/8/2023 21:49:37 ******/
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
/****** Object:  StoredProcedure [dbo].[BuscarCam]    Script Date: 14/8/2023 21:49:37 ******/
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
/****** Object:  StoredProcedure [dbo].[BuscarCamionero]    Script Date: 14/8/2023 21:49:37 ******/
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
/****** Object:  StoredProcedure [dbo].[BuscarCli]    Script Date: 14/8/2023 21:49:37 ******/
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
/****** Object:  StoredProcedure [dbo].[BuscarDeposito]    Script Date: 14/8/2023 21:49:37 ******/
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
/****** Object:  StoredProcedure [dbo].[BuscarFerti]    Script Date: 14/8/2023 21:49:37 ******/
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
/****** Object:  StoredProcedure [dbo].[BuscarGranja]    Script Date: 14/8/2023 21:49:37 ******/
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
/****** Object:  StoredProcedure [dbo].[BuscarLote]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarLote] 
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	Select idGranja, idProducto, fchProduccion, cantidad, precio, idDeposito from Lotes 
	Where idGranja = @idGranja and idProducto = @idProducto and fchProduccion = CONVERT(DATE,@fchProduccion,103)
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarLote_Ferti]    Script Date: 14/8/2023 21:49:37 ******/
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
	Where idFertilizante = @idFertilizante and idGranja = @idGranja and idProducto = @idProducto and fchProduccion = CONVERT(DATE,@fchProduccion,103)
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarLote_Pesti]    Script Date: 14/8/2023 21:49:37 ******/
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
	Where idPesticida = @idPesticida and idGranja = @idGranja and idProducto = @idProducto and fchProduccion = CONVERT(DATE,@fchProduccion,103)
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarPesti]    Script Date: 14/8/2023 21:49:37 ******/
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
/****** Object:  StoredProcedure [dbo].[BuscarProducto]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[BuscarProducto] 
@id int
AS
BEGIN
	
	SET NOCOUNT ON;
	 	Select idProducto, nombre, tipo, tipoVenta, imagen from Productos Where idProducto = @id
END

GO
/****** Object:  StoredProcedure [dbo].[BuscarVarAdmin]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BuscarVarAdmin]
	-- Add the parameters for the stored procedure here
	@var varchar(40)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  A.usuario, A.tipoDeAdmin,  A.estado from Personas P inner join Admins A on P.idPersona = A.idAdmin
	where idPersona LIKE '%' + @var + '%'  or nombre LIKE '%' + @var + '%' or apellido LIKE '%' + @var +  '%' or email LIKE '%' + @var + '%' or usuario LIKE '%' + @var + '%' or tipoDeAdmin LIKE '%' + @var + '%' or estado LIKE '%' + @var + '%'
	order by  nombre


END
GO
/****** Object:  StoredProcedure [dbo].[BuscarVarCam]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BuscarVarCam]
	@var varchar(40)
AS
BEGIN
	SET NOCOUNT ON;
	Select idCamion, marca, modelo, carga, disponible from Camiones
	where idCamion LIKE '%' + marca + '%'  or modelo  LIKE '%' + @var + '%' or carga LIKE '%' + @var + '%' or disponible LIKE '%' + @var + '%'
	order by marca
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarVarCamionero]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BuscarVarCamionero]

	@var varchar(40)
AS
BEGIN
	SET NOCOUNT ON;
 
	Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  C.cedula, C.disponible, C.fchManejo from Personas P inner join Camioneros C on P.idPersona = C.idCamionero
	where idPersona LIKE '%' + @var + '%'  or nombre LIKE '%' + @var + '%' or apellido LIKE '%' + @var + '%' or email LIKE '%' + @var + '%' or cedula LIKE '%' + @var + '%' or disponible LIKE '%' + @var + '%' or fchManejo LIKE '%' + @var + '%'
	order by nombre


END
GO
/****** Object:  StoredProcedure [dbo].[BuscarVarCli]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BuscarVarCli]
	-- Add the parameters for the stored procedure here
	@var varchar(40)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  C.usuario, C.Direccion from Personas P inner join Clientes C on P.idPersona = C.idCliente
	where idPersona LIKE '%' + @var + '%'  or nombre LIKE '%' + @var + '%'  or apellido LIKE '%' + @var + '%' or email LIKE '%' + @var + '%' or usuario LIKE '%' + @var + '%' or Direccion LIKE '%' + @var + '%'
	order by nombre


END
GO
/****** Object:  StoredProcedure [dbo].[BuscarVarDeposito]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BuscarVarDeposito]

	@var varchar(40)
AS
BEGIN

	SET NOCOUNT ON;

	Select idDeposito, capacidad, ubicacion, temperatura, condiciones from Depositos
	where idDeposito LIKE '%' + @var + '%'  or capacidad  LIKE '%' + @var + '%' or ubicacion LIKE '%' + @var + '%' or condiciones LIKE '%' + @var + '%' or temperatura LIKE '%' + @var + '%'
	order by idDeposito


END
GO
/****** Object:  StoredProcedure [dbo].[BuscarVarFerti]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[BuscarVarFerti]

	@var varchar(40)
AS
BEGIN

	SET NOCOUNT ON;


		Select idFerti, nombre, tipo, pH, impacto from Fertilizantes
	where idFerti LIKE '%' + @var + '%'  or nombre  LIKE '%' + @var + '%' or tipo LIKE '%' + @var + '%'
	or pH LIKE '%' + @var + '%' or impacto LIKE '%' + @var + '%'
	order by nombre


END
GO
/****** Object:  StoredProcedure [dbo].[BuscarVarGranja]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarVarGranja]
	@var varchar(40)
AS
BEGIN
	SET NOCOUNT ON;
	Select idGranja, nombre, ubicacion, idCliente from Granjas
	where idGranja LIKE '%' + @var + '%'  or nombre  LIKE '%' + @var + '%' or ubicacion LIKE '%' + @var + '%' or idCliente LIKE '%' + @var + '%'
	order by nombre
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarVarLote]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarVarLote]
	@var varchar(40)
AS
BEGIN
	SET NOCOUNT ON;
	Select idGranja, idProducto, fchProduccion, cantidad, precio, idDeposito from Lotes
	where idGranja LIKE '%' + @var + '%'  or idProducto  LIKE '%' + @var + '%' or fchProduccion LIKE '%' + @var + '%' 
	or cantidad LIKE '%' + @var + '%' or precio LIKE '%' + @var + '%' or idDeposito LIKE '%' + @var + '%'
	order by fchProduccion
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarVarPesti]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[BuscarVarPesti]

	@var varchar(40)
AS
BEGIN

	SET NOCOUNT ON;


		Select idPesti, nombre, tipo, pH, impacto from Pesticidas
	where idPesti LIKE '%' + @var + '%'  or nombre  LIKE '%' + @var + '%' or tipo LIKE '%' + @var + '%'
	or pH LIKE '%' + @var + '%' or impacto LIKE '%' + @var + '%'
	order by nombre


END
GO
/****** Object:  StoredProcedure [dbo].[BuscarVarProducto]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarVarProducto]
	@var varchar(40)
AS
BEGIN
	SET NOCOUNT ON;
	Select idProducto, nombre, tipo, tipoVenta, imagen from Productos
	where idProducto LIKE '%' + @var + '%'  or nombre  LIKE '%' + @var + '%' or tipo LIKE '%' + @var + '%' or tipoVenta LIKE '%' + @var + '%'
	order by nombre
END
GO
/****** Object:  StoredProcedure [dbo].[IniciarSesionAdm]    Script Date: 14/8/2023 21:49:37 ******/
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
/****** Object:  StoredProcedure [dbo].[IniciarSesionCli]    Script Date: 14/8/2023 21:49:37 ******/
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
	

		Select idCliente  from Clientes
		where usuario = @User and contrasena = @Pass
END
GO
/****** Object:  StoredProcedure [dbo].[LstAdmin]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LstAdmin]

as
BEGIN

	SET NOCOUNT ON;

	Select P.idPersona, P.nombre, P.apellido, P.email, P.telefono, P.fchNacimiento,  A.usuario, A.tipoDeAdmin, A.estado from Personas P inner join Admins A on P.idPersona = A.idAdmin



END

GO
/****** Object:  StoredProcedure [dbo].[LstCam]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[LstCam]
as
BEGIN
	SET NOCOUNT ON;
	Select idCamion, marca, modelo, carga, disponible from Camiones
END
GO
/****** Object:  StoredProcedure [dbo].[LstCamioneros]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[LstCamioneros]
	
AS
BEGIN


	SELECT [idPersona],[nombre],[apellido],[email],[telefono],fchNacimiento, C.cedula, C.disponible, C.fchManejo FROM Camioneros C inner join Personas P on P.idPersona = C.idCamionero

END

GO
/****** Object:  StoredProcedure [dbo].[LstCliente]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LstCliente]
AS
BEGIN
	
	Select P.idPersona, P.nombre, P.apellido,p.email, P.telefono, P.fchNacimiento,  C.usuario, C.direccion  from Personas P inner join Clientes C on P.idPersona = C.idCliente
END
GO
/****** Object:  StoredProcedure [dbo].[LstDepositos]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LstDepositos]

as
BEGIN

	SET NOCOUNT ON;

	Select idDeposito, capacidad, ubicacion, temperatura, condiciones from Depositos



END
GO
/****** Object:  StoredProcedure [dbo].[LstFerti]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LstFerti]

as
BEGIN

	SET NOCOUNT ON;

	Select idFerti, nombre, tipo, pH, impacto from Fertilizantes



END
GO
/****** Object:  StoredProcedure [dbo].[LstFertisEnLote]    Script Date: 14/8/2023 21:49:37 ******/
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
END
GO
/****** Object:  StoredProcedure [dbo].[LstGranjas]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LstGranjas]
as
BEGIN
	SET NOCOUNT ON;
	Select idGranja, nombre, ubicacion, idCliente from Granjas
END
GO
/****** Object:  StoredProcedure [dbo].[LstIdCami]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[LstIdCami]

AS
BEGIN
	SET NOCOUNT ON;

	Select idCamion from Camiones
END

GO
/****** Object:  StoredProcedure [dbo].[LstIdDepositos]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[LstIdDepositos]

AS
BEGIN
	SET NOCOUNT ON;

	Select idDeposito from Depositos
END

GO
/****** Object:  StoredProcedure [dbo].[LstIdFerti]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[LstIdFerti]

AS
BEGIN
	SET NOCOUNT ON;

	Select idFerti from Fertilizantes
END

GO
/****** Object:  StoredProcedure [dbo].[LstIdGranjas]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LstIdGranjas]
AS
BEGIN
	SET NOCOUNT ON;
	Select idGranja from Granjas
END
GO
/****** Object:  StoredProcedure [dbo].[LstIdLotes]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LstIdLotes]
AS
BEGIN
	SET NOCOUNT ON;
	Select idGranja, idProducto, fchProduccion from Lotes
END

GO
/****** Object:  StoredProcedure [dbo].[LstIdPersonas]    Script Date: 14/8/2023 21:49:37 ******/
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
/****** Object:  StoredProcedure [dbo].[LstIdPesti]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[LstIdPesti]

AS
BEGIN
	SET NOCOUNT ON;

	Select idPesti from Pesticidas
END

GO
/****** Object:  StoredProcedure [dbo].[LstIdProducen]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LstIdProducen]
AS
BEGIN
	SET NOCOUNT ON;
	Select idGranja, idProducto, fchProduccion from Producen
END
/****** Object:  StoredProcedure [dbo].[LstIdProductos]    Script Date: 31/7/2023 18:31:19 ******/
SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dbo].[LstIdProductos]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LstIdProductos]
AS
BEGIN
	SET NOCOUNT ON;
	Select idProducto from Productos
END
GO
/****** Object:  StoredProcedure [dbo].[LstLotes]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LstLotes]
as
BEGIN
	SET NOCOUNT ON;
	Select idGranja, idProducto, fchProduccion, cantidad, precio, idDeposito from Lotes
END

GO
/****** Object:  StoredProcedure [dbo].[LstPesti]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LstPesti]

as
BEGIN

	SET NOCOUNT ON;

	Select idPesti, nombre, tipo, pH, impacto from Pesticidas



END
GO
/****** Object:  StoredProcedure [dbo].[LstPestisEnLote]    Script Date: 14/8/2023 21:49:37 ******/
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
END

select * from Lotes_Pestis
GO
/****** Object:  StoredProcedure [dbo].[LstProductos]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LstProductos]
as
BEGIN
	SET NOCOUNT ON;
	Select idProducto, nombre, tipo, tipoVenta, imagen from Productos
END
GO
/****** Object:  StoredProcedure [dbo].[ModificarAdm]    Script Date: 14/8/2023 21:49:37 ******/
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
	@estado varchar(40)
AS
BEGIN
    UPDATE Admins SET tipoDeAdmin = @TipoAdm, estado = @estado  where idAdmin = @id
	
		UPDATE Personas SET nombre = @nombre, apellido = @apellido, fchNacimiento = @fchNac where idPersona = @id

END
GO
/****** Object:  StoredProcedure [dbo].[ModificarCam]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ModificarCam]
	@id int,
	@marca varchar(40),
	@modelo varchar(40),
	@carga numeric(10,2),
	@disponible varchar (40)

AS
BEGIN
    UPDATE Camiones SET idCamion = @id, marca = @marca, modelo = @modelo, carga = @carga, disponible = @disponible where idCamion = @id



END
GO
/****** Object:  StoredProcedure [dbo].[ModificarCamionero]    Script Date: 14/8/2023 21:49:37 ******/
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
	@manejo varchar(20)
AS
BEGIN
    UPDATE Camioneros SET cedula = @cedula, disponible = @disp, fchManejo = @manejo where idCamionero = @id

		UPDATE Personas SET nombre = @nombre, apellido = @apellido, email = @email, telefono = @tele, fchNacimiento =@fchNac where idPersona = @id

END
GO
/****** Object:  StoredProcedure [dbo].[ModificarCli]    Script Date: 14/8/2023 21:49:37 ******/
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
	@dirr varchar(40)

AS
BEGIN
    UPDATE Clientes SET usuario = @user ,  direccion = @dirr  where idCliente = @id
	
		UPDATE Personas SET nombre = @nombre, apellido = @apellido, email = @email, telefono = @tele, fchNacimiento = CONVERT(DATE,@fchNac,103) where idPersona = @id

END
GO
/****** Object:  StoredProcedure [dbo].[ModificarDeposito]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[ModificarDeposito]
	@id int,
	@capacidad varchar(20),
	@ubicacion varchar(50),
	@temperatura numeric(3,0),
	@condiciones varchar(80)

AS
BEGIN
    UPDATE Depositos SET capacidad = @capacidad, ubicacion = @ubicacion, temperatura = @temperatura, condiciones = @condiciones  where idDeposito = @id
END
GO
/****** Object:  StoredProcedure [dbo].[ModificarFerti]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[ModificarFerti]
	@id int,
	@nombre varchar(40),
	@tipo varchar(40),
	@pH numeric(2),
	@impacto varchar(30)

AS
BEGIN
    UPDATE Fertilizantes SET nombre = @nombre, tipo = @tipo, pH = @pH, impacto = @impacto  where idFerti = @id
END
GO
/****** Object:  StoredProcedure [dbo].[ModificarGranja]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModificarGranja]
	@id int,
	@nombre varchar(30),
	@ubicacion varchar(50),
	@idCliente int
AS
BEGIN
    UPDATE Granjas SET nombre = @nombre, ubicacion = @ubicacion, idCliente = @idCliente where idGranja = @id
END
GO
/****** Object:  StoredProcedure [dbo].[ModificarLote]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModificarLote]
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20),
	@cantidad numeric(10,0),
	@precio numeric(10,2),
	@idDeposito int
AS
BEGIN
    UPDATE Lotes SET cantidad = @cantidad, precio = @precio, idDeposito = @idDeposito 
	where idGranja = @idGranja and idProducto = @idProducto and fchProduccion = @fchProduccion
END
GO
/****** Object:  StoredProcedure [dbo].[ModificarLoteFerti]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModificarLoteFerti]
	@idFertilizante int,
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20),
	@cantidad varchar(30)
AS
BEGIN
    UPDATE Lotes_Fertis SET cantidad = @cantidad
	where idFertilizante = @idFertilizante and idGranja = @idGranja and idProducto = @idProducto and fchProduccion = CONVERT(DATE,@fchProduccion,103)
END
GO
/****** Object:  StoredProcedure [dbo].[ModificarLotePesti]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModificarLotePesti]
	@idPesticida int,
	@idGranja int,
	@idProducto int,
	@fchProduccion varchar(20),
	@cantidad varchar(30)
AS
BEGIN
    UPDATE Lotes_Pestis SET cantidad = @cantidad
	where idPesticida = @idPesticida and idGranja = @idGranja and idProducto = @idProducto and fchProduccion = CONVERT(DATE,@fchProduccion,103)
END
GO
/****** Object:  StoredProcedure [dbo].[ModificarPesti]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[ModificarPesti]
	@id int,
	@nombre varchar(40),
	@tipo varchar(40),
	@pH numeric(2),
	@impacto varchar(30)

AS
BEGIN
    UPDATE Pesticidas SET nombre = @nombre, tipo = @tipo, pH = @pH, impacto = @impacto  where idPesti = @id
END
GO
/****** Object:  StoredProcedure [dbo].[ModificarProducto]    Script Date: 14/8/2023 21:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ModificarProducto]
	@id int,
	@nombre varchar(30),
	@tipo varchar(30),
	@tipoVenta varchar(15),
	@imagen varchar(MAX)
AS
BEGIN
    UPDATE Productos SET nombre = @nombre, tipo = @tipo, tipoVenta = @tipoVenta, imagen = @imagen where idProducto = @id
END
GO
/****** Object:  StoredProcedure [dbo].[userRepetidoAdm]    Script Date: 14/8/2023 21:49:37 ******/
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
/****** Object:  StoredProcedure [dbo].[userRepetidoCli]    Script Date: 14/8/2023 21:49:37 ******/
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
