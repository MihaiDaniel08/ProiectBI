CREATE TABLE [dbo].[Obiective] (
    [id_obiectiv]    INT            IDENTITY (1, 1) NOT NULL,
    [id_client]      INT            NOT NULL,
    [titlu_obiectiv] NVARCHAR (150) NOT NULL,
    [valoare_tinta]  FLOAT (53)     NOT NULL, -- Folosim FLOAT sau DECIMAL pentru precizie la masuratori

    CONSTRAINT [PK_Obiective] PRIMARY KEY CLUSTERED ([id_obiectiv] ASC),
    
    CONSTRAINT [FK_Obiective_Clients] FOREIGN KEY ([id_client]) 
        REFERENCES [dbo].[Clienti] ([id_client]) 
        ON DELETE CASCADE
);

INSERT INTO [dbo].[Obiective] ([id_client], [titlu_obiectiv], [valoare_tinta]) VALUES 
(1, 'Scadere in greutate', 85.0),
(1, 'Alergare 10km (timp min)', 50.0),
(2, 'Numar carti citite pe luna', 4.0),
(3, 'Economii lunare (RON)', 1000.0);

select * from obiective;