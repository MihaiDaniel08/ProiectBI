CREATE TABLE [dbo].[Sesiuni] (
    [id_sesiune]      INT            IDENTITY (1, 1) NOT NULL,
    [titlu_sesiune]   NVARCHAR (150) NOT NULL,
    [tip_coaching]    NVARCHAR (50)  NOT NULL, -- Ex: Business, Life, Fitness
    [data_programata] DATETIME       NOT NULL,
    
    CONSTRAINT [PK_Sessions] PRIMARY KEY CLUSTERED ([id_sesiune] ASC),
    
    CONSTRAINT [CK_Sessions_Date] CHECK ([data_programata] >= '2020-01-01')
);

INSERT INTO [dbo].[Sesiuni] ([titlu_sesiune], [tip_coaching], [data_programata]) VALUES 
('Planificare Q2 2026', 'Business', '2026-04-10 10:00:00'),
('Mindfulness si Stress Management', 'Life Coaching', '2026-04-12 14:30:00'),
('Tehnici de Comunicare Asertiva', 'Career', '2026-04-15 09:00:00'),
('Setarea Obiectivelor SMART', 'General', '2026-04-20 18:00:00');

select * from sesiuni;