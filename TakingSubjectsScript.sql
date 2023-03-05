CREATE DATABASE TakingSubjects;
GO

USE TakingSubjects;
GO

-- Table module
CREATE TABLE TblModule(
	moduleId INT IDENTITY(1,1) NOT NULL,
	moduleName VARCHAR(20) NOT NULL,
	moduleSpanishName VARCHAR(20) NOT NULL,
	CONSTRAINT PK_moduleId PRIMARY KEY(moduleId)
);

-- Table operation
CREATE TABLE TblOperation(
	operationId INT IDENTITY(1,1) NOT NULL,
	operationName VARCHAR(20) NOT NULL,
	operationSpanishName VARCHAR(30) NOT NULL,
	moduleId INT NOT NULL,
	CONSTRAINT PK_operationId PRIMARY KEY(operationId),
	CONSTRAINT FK_moduleId_operation FOREIGN KEY(moduleId)
	REFERENCES TblModule(moduleId)
);

-- Table role
CREATE TABLE TblRole(
	roleId INT IDENTITY(1,1) NOT NULL,
	roleName VARCHAR(20) NOT NULL,
	roleSpanishName VARCHAR(20) NOT NULL,
	CONSTRAINT PK_roleId PRIMARY KEY(roleId)
);

-- Table role_operation
CREATE TABLE TblRoleOperation(
	roleOperationId INT IDENTITY(1,1) NOT NULL,
	roleId INT NOT NULL,
	operationId INT NOT NULL,
	CONSTRAINT PK_roleOperationId PRIMARY KEY(roleOperationId),
	CONSTRAINT FK_roleId_roleOperation FOREIGN KEY(roleId)
	REFERENCES TblRole(roleId),
	CONSTRAINT FK_operationId_roleOperation FOREIGN KEY(operationId)
	REFERENCES TBlOperation(operationId)
);

-- Table user
CREATE TABLE TblUser(
	userId INT IDENTITY(1,1) NOT NULL,
	rut VARCHAR(10) NOT NULL,
	names VARCHAR(30) NOT NULL,
	lastNames VARCHAR(30) NOT NULL,
	phone VARCHAR(12) NOT NULL,
	password VARCHAR(256) NOT NULL,
	roleId INT NOT NULL,
	CONSTRAINT PK_userId PRIMARY KEY(userId),
	CONSTRAINT FK_roleId_user FOREIGN KEY(roleId)
	REFERENCES TblRole(roleId)
);

-- Table subject
CREATE TABLE TblSubject(
	subjectId INT IDENTITY(1,1) NOT NULL,
	subjectName VARCHAR(50) NOT NULL,
	subjectDescription VARCHAR(200) NOT NULL,
	subjectPeriod VARCHAR(30) NOT NULL,
	CONSTRAINT PK_subjectId PRIMARY KEY(subjectId)
);

-- Table room
CREATE TABLE TblClassroom(
	classroomId INT IDENTITY(1,1) NOT NULL,
	classroomName VARCHAR(30) NOT NULL,
	classroomType VARCHAR(30) NOT NULL,
	capacity INT NOT NULL,
	CONSTRAINT PK_classroomId PRIMARY KEY(classroomId)
);

-- Table section
CREATE TABLE TblSection(
	sectionId INT IDENTITY(1,1) NOT NULL,
	sectionName VARCHAR(20) NOT NULL,
	quota INT NOT NULL,
	totalRegistered INT NOT NULL,
	subjectId INT NOT NULL,
	classroomId INT NOT NULL,
	CONSTRAINT PK_sectionId PRIMARY KEY(sectionId),
	CONSTRAINT FK_subjectId_section FOREIGN KEY(subjectId)
	REFERENCES TblSubject(subjectId),
	CONSTRAINT FK_classroomId_section FOREIGN KEY(classroomId)
	REFERENCES TblClassRoom(classroomId)
);

-- Table registration
CREATE TABLE TblRegistration(
	registrationId INT IDENTITY(1,1) NOT NULL,
	registrationDate DATETIME NOT NULL,
	sectionId INT NOT NULL,
	userId INT NOT NULL,
	CONSTRAINT PK_registrationId PRIMARY KEY(registrationId),
	CONSTRAINT FK_sectionId_registration FOREIGN KEY(sectionId)
	REFERENCES TblSection(sectionId),
	CONSTRAINT FK_userId_registration FOREIGN kEY(userId)
	REFERENCES tblUser(userId)
);


-- Basic application data
-- Insert TblRole
INSERT INTO TblRole VALUES('Administrator', 'Administrador');
INSERT INTO TblRole VALUES('Coordinator', 'Coordinador');
INSERT INTO TblRole VALUES('Student', 'Estudiante');

-- Insert TblModule
INSERT INTO TblModule VALUES('Classroom', 'Sala');
INSERT INTO TblModule VALUES('Section', 'Sección');
INSERT INTO TblModule VALUES('Student', 'Estudiante');
INSERT INTO TblModule VALUES('Subject', 'Asignatura');
INSERT INTO TblModule VALUES('Profile', 'Perfil');
INSERT INTO TblModule VALUES('Administration', 'Administración');

-- Insert TblOperation
INSERT INTO TblOperation VALUES('CreateClassroom', 'Crear sala', 1);
INSERT INTO TblOperation VALUES('SearchClassroom', 'Buscar sala', 1);
INSERT INTO TblOperation VALUES('UpdateClassroom', 'Actualizar sala',1);
INSERT INTO TblOperation VALUES('CreateSection', 'Crear sección', 2);
INSERT INTO TblOperation VALUES('CreateStudent', 'Crear estudiante', 3);
INSERT INTO TblOperation VALUES('SearchStudent', 'Buscar estudiante', 3);
INSERT INTO TblOperation VALUES('CreateSubject', 'Crear asignatura', 4);
INSERT INTO TblOperation VALUES('SearchSubject', 'Buscar asignatura', 4);
INSERT INTO TblOperation VALUES('TakeSubject', 'Tomar asignatura', 4);
INSERT INTO TblOperation VALUES('MyProfile', 'Mi perfil', 5);
INSERT INTO TblOperation VALUES('ChangePassword', 'Cambiar contraseña', 5);
INSERT INTO TblOperation VALUES('CreateRole', 'Crear rol', 6);
INSERT INTO TblOperation VALUES('ListRoles', 'Listar roles', 6);

-- Insert TblRoleOperation
-- Administrator
INSERT INTO TblRoleOperation VALUES(1, 1);
INSERT INTO TblRoleOperation VALUES(1, 2);
INSERT INTO TblRoleOperation VALUES(1, 3);
INSERT INTO TblRoleOperation VALUES(1, 4);
INSERT INTO TblRoleOperation VALUES(1, 5);
INSERT INTO TblRoleOperation VALUES(1, 6);
INSERT INTO TblRoleOperation VALUES(1, 7);
INSERT INTO TblRoleOperation VALUES(1, 8);
INSERT INTO TblRoleOperation VALUES(1, 9);
INSERT INTO TblRoleOperation VALUES(1, 10);
INSERT INTO TblRoleOperation VALUES(1, 11);
INSERT INTO TblRoleOperation VALUES(1, 12);
INSERT INTO TblRoleOperation VALUES(1, 13);

-- Coordinator
INSERT INTO TblRoleOperation VALUES(2, 1);
INSERT INTO TblRoleOperation VALUES(2, 2);
INSERT INTO TblRoleOperation VALUES(2, 3);
INSERT INTO TblRoleOperation VALUES(2, 4);
INSERT INTO TblRoleOperation VALUES(2, 5);
INSERT INTO TblRoleOperation VALUES(2, 6);
INSERT INTO TblRoleOperation VALUES(2, 7);
INSERT INTO TblRoleOperation VALUES(2, 8);
INSERT INTO TblRoleOperation VALUES(2, 10);
INSERT INTO TblRoleOperation VALUES(2, 11);

-- Student
INSERT INTO TblRoleOperation VALUES(3, 9);
INSERT INTO TblRoleOperation VALUES(3, 10);

-- Insert TblUser                                                              pass -> administrator
INSERT INTO TblUser VALUES('7087282-K', 'Jhon', 'Doe', '+56958254163', '4194d1706ed1f408d5e02d672777019f4d5385c766a8c6ca8acba3167d36a7b9', 1);
--                                                                                  pass -> coordinator
INSERT INTO TblUser VALUES('18655599-6', 'Jhon', 'Constantine', '+56966357484', 'bf24385098410391a81d92b2de72d3a2946d24f42ee387e51004a868281a2408', 2);
--                                                                               pass -> student
INSERT INTO TblUser VALUES('18624595-4', 'Jane', 'Deere', '+56989892544', '264c8c381bf16c982a4e59b0dd4c6f7808c51a05f64c35db42cc78a2a72875bb', 3);

-- Insert TblSubject
INSERT INTO TblSubject VALUES('Álgebra',
							  'Álgebra es la rama de la matemática que estudia la combinación de elementos de estructuras abstractas acorde a ciertas reglas',
							  'Otoño - Invierno');
INSERT INTO TblSubject VALUES('Fundamentos de bases de datos',
							  'La teoría de bases de datos incluye los principios formales para definir y manipular datos estructurados e interrelacionados.',
							  'Otoño - Invierno');
INSERT INTO TblSubject VALUES('Introducción a la programación',
							  'La programación es el proceso de transformar un método para resolver problemas en uno que pueda ser entendido por el computador.',
							  'Otoño - Invierno');
INSERT INTO TblSubject VALUES('Fundamentos de software',
							  'conceptualización de los sistemas de información en su campo dimensional y tipos en que éstos se presentan, además de proporcionar una introducción a las etapas del proceso de Ingeniería del Software',
							  'Otoño - Invierno');

-- Insert TblClassroom
INSERT INTO TblClassroom VALUES('Sala D-01', 'Laboratorio computación', 20);
INSERT INTO TblClassroom VALUES('Sala C-12', 'Sala audiovisual', 25);
INSERT INTO TblClassroom VALUES('Sala D-04', 'Sala normal', 25);

-- Insert TblSection
INSERT INTO TblSection VALUES('MTAE01', 25, 1, 1, 3);
INSERT INTO TblSection VALUES('TI2002', 20, 1, 2, 1);
INSERT INTO TblSection VALUES('TI2002', 25, 1, 3, 1);
INSERT INTO TblSection VALUES('TI2002', 20, 1, 4, 2);

-- Insert TblRegistration
INSERT INTO TblRegistration VALUES(GETDATE(), 1, 3);
INSERT INTO TblRegistration VALUES(GETDATE(), 2, 3);
INSERT INTO TblRegistration VALUES(GETDATE(), 3, 3);
INSERT INTO TblRegistration VALUES(GETDATE(), 4, 3);

-- Application stored procedures
-- Stored procedure ClassroomInformation
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StoredProcedureClassroomInformation]
	@classroomId INT
AS
BEGIN
	SELECT
	CLA.classroomName AS CLASSROOM_NAME,
	SEC.sectionName AS SECTION_NAME,
	SUB.subjectName AS SUBJECT_NAME
	FROM TblClassroom AS CLA
		INNER JOIN TblSection AS SEC ON CLA.classroomId = SEC.classroomId
		INNER JOIN TblSubject AS SUB ON SUB.subjectId = SEC.sectionId
	WHERE CLA.classroomId = @classroomId;
END

-- Stored procedute FindSubjectByName
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StoredProcedureFindSubjectByName]
	@subjectName VARCHAR(50)
AS
BEGIN
	SELECT 
	SUB.subjectName AS SUBJECT_NAME,
	SEC.sectionName AS SECTION_NAME,
	CLAS.classRoomName AS CLASSROOM_NAME
	FROM TblSection AS SEC
		INNER JOIN TblSubject AS SUB ON SEC.subjectId = SUB.subjectId
		INNER JOIN TblClassroom AS CLAS ON SEC.classRoomId = CLAS.classRoomId
	WHERE SUB.subjectName = @subjectName;
END

-- Stored procedure GetAllSubjectsToTake
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StoredProcedureGetAllSubjectsToTake]

AS
BEGIN
	SELECT
	SUB.subjectName AS SUBJECT_NAME,
	SEC.sectionId AS SECTION_ID,
	SEC.sectionName AS SECTION_NAME,
	SEC.totalRegistered AS TOTAL_REGISTERED,
	CLASS.classroomName AS CLASSROOM_NAME
	FROM TblSubject AS SUB
		INNER JOIN TblSection AS SEC ON SEC.subjectId = SUB.subjectId
		INNER JOIN TblClassroom AS CLASS ON SEC.classroomId = CLASS.classroomId;
END

-- Stored procedure GetStudentInfoAboutSubjectsTakenByRut
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StoredProcedureGetStudentInfoAboutSubjectsTakenByRut] 
	@rut VARCHAR(10),
	@roleId INT
AS
BEGIN
	SELECT
	SUB.subjectName AS SUBJECT_NAME,
	SEC.sectionName AS SECTION_NAME,
	CLASS.classroomName AS CLASSROOM_NAME
	FROM TblRegistration AS REG
		INNER JOIN TblUser AS US ON REG.userId = US.userId
		INNER JOIN TblSection AS SEC ON REG.sectionId = SEC.sectionId
		INNER JOIN TblClassroom AS CLASS ON SEC.classroomId = CLASS.classroomId
		INNER JOIN TblSubject AS SUB ON SEC.subjectId = SUB.subjectId
	WHERE US.rut = @rut AND US.roleId = @roleId;
END

-- Stored procedure GetSubjectsTakenByUserId
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StoredProcedureGetSubjectsTakenByUserId] 
	@userId INT,
	@roleId INT
AS
BEGIN
	SELECT
	SUB.subjectName AS SUBJECT_NAME,
	SEC.sectionName AS SECTION_NAME,
	CLASS.classroomName AS CLASSROOM_NAME
	FROM TblRegistration AS REG
		INNER JOIN TblUser AS US ON REG.userId = US.userId
		INNER JOIN TblSection AS SEC ON REG.sectionId = SEC.sectionId
		INNER JOIN TblClassroom AS CLASS ON SEC.classroomId = CLASS.classroomId
		INNER JOIN TblSubject AS SUB ON SEC.subjectId = SUB.subjectId
	WHERE REG.userId = @userId AND US.roleId = @roleId;
END

-- Stored procedure AccesToModulesByRole
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[StoredProcedureAccessToModulesByRole]
	@roleId INT
AS
BEGIN
	SELECT
	ROL.roleId AS ROLE_ID,
	MODU.moduleId AS MODU_ID,
	OPE.operationId AS OPE_ID,
	CONCAT(MODU.moduleName, '.', OPE.operationName) AS NAME_MODU_OPE
	FROM TblRoleOperation AS ROL_OP
		INNER JOIN TblRole AS ROL ON ROL_OP.roleId = ROL.roleId
		INNER JOIN TblOperation AS OPE ON ROL_OP.operationId = OPE.operationId
		INNER JOIN TblModule AS MODU ON OPE.moduleId = MODU.moduleId
	WHERE ROL_OP.roleId = @roleId;
END
GO