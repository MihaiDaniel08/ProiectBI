CREATE TABLE [dbo].[Participanti_sesiune] (
    [id_client]       INT           NOT NULL,
    [id_sesiune]      INT           NOT NULL,
    [status_prezenta] NVARCHAR (50) DEFAULT ('Inscris') NOT NULL,

    CONSTRAINT [PK_Participanti_sesiune] PRIMARY KEY CLUSTERED ([id_client] ASC, [id_sesiune] ASC),

    CONSTRAINT [FK_Participanti_Clienti] FOREIGN KEY ([id_client]) 
        REFERENCES [dbo].[Clienti] ([id_client]) ON DELETE CASCADE,

    CONSTRAINT [FK_Participanti_Sesiuni] FOREIGN KEY ([id_sesiune]) 
        REFERENCES [dbo].[Sesiuni] ([id_sesiune]) ON DELETE CASCADE
);

INSERT INTO [dbo].[Participanti_sesiune] ([id_client], [id_sesiune], [status_prezenta]) VALUES 
(1, 1, 'Prezent'),
(2, 1, 'Prezent'),
(1, 2, 'Inscris'),
(3, 3, 'Inscris'),
(4, 1, 'Absent');

select * from Participanti_sesiune;