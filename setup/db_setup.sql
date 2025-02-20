IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DemoTable]') AND type in (N'U'))
BEGIN
  CREATE TABLE [dbo].[DemoTable] ([data] VARCHAR(MAX))
  INSERT INTO [dbo].[DemoTable] ([data]) VALUES ('Unit 9 Workshop')
END
GO