CREATE TABLE [dbo].[Clienti] (
    [id_client]     INT            IDENTITY (1, 1) NOT NULL,
    [nume]          NVARCHAR (100) NOT NULL,
    [email]         NVARCHAR (100) NOT NULL,
    [data_aderare]  DATETIME       DEFAULT (getdate()) NOT NULL,
    
    CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED ([id_client] ASC),
    CONSTRAINT [UQ_Clients_Email] UNIQUE NONCLUSTERED ([email] ASC)
);

INSERT INTO [dbo].[Clienti] ([nume], [email], [data_aderare]) VALUES 
('Andrei Ionescu', 'andrei.i@email.com', '2026-01-10'),
('Maria Enache', 'maria.enache@email.com', '2026-02-15'),
('Vlad Petrescu', 'vlad.p@email.com', '2026-03-01'),
('Elena Sandu', 'elena.s@email.com', '2026-03-05'),
('Mihai Popa', 'mihai.popa@email.com', '2026-03-10');