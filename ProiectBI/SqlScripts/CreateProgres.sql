CREATE TABLE [dbo].[Progres] (
    [id_progres]     INT        IDENTITY (1, 1) NOT NULL,
    [id_obiectiv]    INT        NOT NULL,
    [data_masurare]  DATE       DEFAULT (getdate()) NOT NULL,
    [valoare_atinsa] FLOAT (53) NOT NULL,

    CONSTRAINT [PK_Progres] PRIMARY KEY CLUSTERED ([id_progres] ASC),
    
    CONSTRAINT [FK_Progres_Obiective] FOREIGN KEY ([id_obiectiv]) 
        REFERENCES [dbo].[Obiective] ([id_obiectiv]) 
        ON DELETE CASCADE
);

INSERT INTO [dbo].[Progres] ([id_obiectiv], [data_masurare], [valoare_atinsa]) VALUES 
(1, '2026-01-15', 89.5),
(1, '2026-02-01', 88.2),
(1, '2026-02-15', 87.0),
(1, '2026-03-01', 86.1),
(3, '2026-02-10', 1.0),
(3, '2026-03-01', 3.0);

select * from progres;