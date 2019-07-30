USE [X5.MQtest]
GO

CREATE PROCEDURE [dbo].[x5_selectCFOsByDivisionSAPIDsForPlans]
    @SAPIDs as SapIdTable READONLY,
	@DateStart date,
	@DateEnd date = null
AS
BEGIN


  IF (@DateEnd IS NULL)
	  SET @DateEnd = @DateStart
	IF (@DateEnd < @DateStart)
	  SET @DateEnd = '9999-12-31'


SET NOCOUNT ON;
 SELECT c.*,
		c.STATUS_ACT as 'Status',
		cl.MDM_ID AS 'ClusterID',
		cl.Name AS 'ClusterName',
		cl.CLASTER_SAP AS 'ClusterSAPID',
		d.MDM_ID AS 'DivisionID',
		d.Name AS 'DivisionName',
		d.DIVISION_SAP AS 'DivisionSAPID',
		c.FSTER as 'Format',
		c.TYPE as 'Type'
	FROM [X5.MQtest].[dbo].[CFO] c
	 INNER JOIN [X5.MQtest].[dbo].[Cluster] cl ON cl.MDM_ID = c.CURR_CLUSTER 
	 INNER JOIN [X5.MQtest].[dbo].[Division] d ON d.MDM_ID = c.CURR_DIVISION
	 INNER JOIN @SAPIDs SAPIDs ON SAPIDs.SAPID = cl.CLASTER_SAP
	ORDER BY 
	c.Name ASC;
END;

USE [X5.MQtest]
GO

CREATE PROCEDURE [dbo].[x5_selectCFOsBySAPIDs]
    @SAPIDs as SapIdTable READONLY,
	@DateStart date,
	@DateEnd date = null
AS
BEGIN
     SET NOCOUNT ON;

   	IF (@DateEnd IS NULL)
		SET @DateEnd = @DateStart
    IF (@DateEnd < @DateStart)
		SET @DateEnd = '9999-12-31'

SELECT c.*,
            c.STATUS_ACT as 'Status',
            c.CURR_CLUSTER AS 'ClusterID',
            cl.Name AS 'ClusterName',
            cl.CLASTER_SAP AS 'ClusterSAPID' FROM [X5.MQtest].[dbo].[CFO] c 
            INNER JOIN[X5.MQtest].[dbo].[Cluster] cl ON cl.MDM_ID = c.CURR_CLUSTER 
			INNER JOIN @SAPIDs SAPIDs ON SAPIDs.SAPID = cl.CLASTER_SAP
			ORDER BY 
			c.Name ASC;

END;

USE [X5.MQtest]
GO

CREATE PROCEDURE [dbo].[x5_selectCFOsForClusterBySAPIDsForPlans]
    @SAPIDs as SapIdTable READONLY,
	@DateStart date,
	@DateEnd date = null
AS
BEGIN
    SET NOCOUNT ON;

   	IF (@DateEnd IS NULL)
		SET @DateEnd = @DateStart
    IF (@DateEnd < @DateStart)
		SET @DateEnd = '9999-12-31'

SELECT c.*,
            c.STATUS_ACT as 'Status',
            c.CURR_CLUSTER AS 'ClusterID',
            cl.Name AS 'ClusterName',
            cl.CLASTER_SAP AS 'ClusterSAPID',
            d.MDM_ID AS 'DivisionID',
            d.Name AS 'DivisionName',
            d.DIVISION_SAP AS 'DivisionSAPID',
            c.FSTER as 'Format',
            c.TYPE as 'Type' 
			FROM [X5.MQtest].[dbo].[CFO] cc 

    INNER JOIN[X5.MQtest].[dbo].[CFO] c ON c.MDM_ID = cc.MDM_ID 
     INNER JOIN[X5.MQtest].[dbo].[Cluster] cl ON cl.MDM_ID = cc.CURR_CLUSTER 
       INNER JOIN[X5.MQtest].[dbo].[Division] d ON d.MDM_ID = cl.DIVISION_ID
	   INNER JOIN @SAPIDs SAPIDs ON SAPIDs.SAPID = cl.CLASTER_SAP
	    ORDER BY 
		c.Name ASC
END;

USE [X5.MQtest]
GO

CREATE PROCEDURE [dbo].[x5_selectCFOsForClusterBySAPIDs]
    @SAPIDs as SapIdTable READONLY,
	@DateStart date,
	@DateEnd date = null
AS
BEGIN
    SET NOCOUNT ON;

		IF (@DateEnd IS NULL)
	    SET @DateEnd = @DateStart
	    IF (@DateEnd < @DateStart)
	     SET @DateEnd = '9999-12-31'

             SELECT c.*,
              c.STATUS_ACT as 'Status',
              cl.MDM_ID AS 'ClusterID',
              cl.Name AS 'ClusterName',
              cl.CLASTER_SAP AS 'ClusterSAPID',
              d.MDM_ID AS 'DivisionID',
              d.Name AS 'DivisionName',
              d.DIVISION_SAP AS 'DivisionSAPID',
              c.FSTER as 'Format',
              c.TYPE as 'Type'
              FROM [X5.MQtest].[dbo].[CFO] c
              INNER JOIN[X5.MQtest].[dbo].[Cluster] cl ON cl.MDM_ID = c.CURR_CLUSTER 
              INNER JOIN[X5.MQtest].[dbo].[Division] d ON d.MDM_ID = c.CURR_DIVISION 
			  INNER JOIN @SAPIDs SAPIDs ON SAPIDs.SAPID = cl.CLASTER_SAP
			  ORDER BY 
			  c.Name ASC 
END;

USE [X5.MQtest]
GO

CREATE PROCEDURE [dbo].[x5_selectCFOsAll]
    @SAPIDs as SapIdTable READONLY,
	@DateStart date,
	@DateEnd date = null
AS
BEGIN
    SET NOCOUNT ON;

		IF (@DateEnd IS NULL)
	    SET @DateEnd = @DateStart
	    IF (@DateEnd < @DateStart)
	     SET @DateEnd = '9999-12-31'

SELECT c.*,
            c.STATUS_ACT as 'Status',
            cl.MDM_ID AS 'ClusterID',
            cl.Name AS 'ClusterName',
            cl.CLASTER_SAP AS 'ClusterSAPID',
            d.MDM_ID AS 'DivisionID',
            d.Name AS 'DivisionName',
            d.DIVISION_SAP AS 'DivisionSAPID',
            c.FSTER as 'Format',
            c.TYPE as 'Type'
            FROM [X5.MQtest].[dbo].[CFO] c 
			INNER JOIN[X5.MQtest].[dbo].[Cluster] cl ON cl.MDM_ID = c.CURR_CLUSTER 
            INNER JOIN[X5.MQtest].[dbo].[Division] d ON d.MDM_ID = c.CURR_DIVISION 
			--INNER JOIN @SAPIDsToQuery SAPIDs ON SAPIDs.SAPID = cl.CLASTER_SAP
			ORDER BY 
			c.Name ASC
END;

USE [X5.MQtest]
GO

CREATE PROCEDURE [dbo].[x5_selectClustersAll]
    @SAPIDs as SapIdTable READONLY,
	@DateStart date,
	@DateEnd date = null
AS
BEGIN
    SET NOCOUNT ON;

		DECLARE @SAPIDsToQuery as SapIdTable
	
	IF (@DateStart IS NULL)
		SET @DateStart = '1753-01-01'
 	IF (@DateEnd IS NULL OR @DateEnd < @DateStart)
		SET @DateEnd = '9999-12-31'

		IF NOT EXISTS(SELECT TOP 1 * FROM @SAPIDs) 
		INSERT INTO @SAPIDsToQuery 
		SELECT DISTINCT cl.CLASTER_SAP FROM
		[X5.MQtest].[dbo].[Cluster] cl	
	ELSE
		INSERT INTO @SAPIDsToQuery SELECT DISTINCT * FROM @SAPIDs

SELECT cl.*,
           d.MDM_ID AS 'DivisionID',
           d.Name AS 'DivisionName',
           d.DIVISION_SAP AS 'DivisionSAPID' 
		   FROM 
           [X5.MQtest].[dbo].[Cluster][cl] 
           INNER JOIN[X5.MQtest].[dbo].[Division] [d] ON[d].MDM_ID = cl.DIVISION_ID 
		   INNER JOIN @SAPIDsToQuery SAPIDs ON SAPIDs.SAPID = cl.CLASTER_SAP
		   ORDER BY 
		   cl.Name ASC
END;

USE [X5.MQtest]
GO


CREATE PROCEDURE [dbo].[x5_selectDivisionsAll]
    @SAPIDs as SapIdTable READONLY,
	@DateStart date,
	@DateEnd date = null
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @SAPIDsToQuery as SapIdTable

	IF (@DateEnd IS NULL)
	    SET @DateEnd = @DateStart
	    IF (@DateEnd < @DateStart)
	     SET @DateEnd = '9999-12-31'

		 IF NOT EXISTS(SELECT TOP 1 * FROM @SAPIDs) 
		INSERT INTO @SAPIDsToQuery 
		SELECT DISTINCT d.DIVISION_SAP FROM
		[dbo].[Division] d		
	ELSE
		INSERT INTO @SAPIDsToQuery SELECT DISTINCT * FROM @SAPIDs

SELECT d.* 
FROM [X5.MQtest].[dbo].[DIVISION] d 
INNER JOIN @SAPIDsToQuery SAPIDs ON SAPIDs.SAPID = d.DIVISION_SAP
ORDER BY 
d.Name ASC
END;


USE [X5.MQtest]
GO


CREATE PROCEDURE [dbo].[x5_selectClustersBySAPIDs]
    @SAPIDs as SapIdTable READONLY,
	@DateStart date,
	@DateEnd date = null
AS
BEGIN
    SET NOCOUNT ON;

    IF (@DateEnd IS NULL)
		SET @DateEnd = @DateStart
    IF (@DateEnd < @DateStart)
		SET @DateEnd = '9999-12-31'


SELECT cl.*,
             d.MDM_ID AS 'DivisionID',
             d.Name AS 'DivisionName',
             d.DIVISION_SAP AS 'DivisionSAPID'
			  FROM 
             [X5.MQtest].[dbo].[CLUSTER] cl 
             INNER JOIN[X5.MQtest].[dbo].[Division] d ON d.MDM_ID = cl.DIVISION_ID 
			 INNER JOIN @SAPIDs SAPIDs ON SAPIDs.SAPID = cl.CLASTER_SAP
		     ORDER BY 
		     cl.Name ASC

             
END;

USE [X5.MQtest]
GO

CREATE PROCEDURE [dbo].[x5_selectClustersByDivisionSAPIDs]
    @SAPIDs as SapIdTable READONLY,
	@DateStart date,
	@DateEnd date = null
AS
BEGIN
    SET NOCOUNT ON;

	IF (@DateEnd IS NULL)
		SET @DateEnd = @DateStart
    IF (@DateEnd < @DateStart)
		SET @DateEnd = '9999-12-31'

SELECT cl.*,
          d.MDM_ID AS 'DivisionID',
          d.Name AS 'DivisionName',
          d.DIVISION_SAP AS 'DivisionSAPID'
		  FROM 
          [X5.MQtest].[dbo].[CLUSTER] cl 
          INNER JOIN[X5.MQtest].[dbo].[DIVISION] d ON d.MDM_ID = cl.DIVISION_ID
		  INNER JOIN @SAPIDs SAPIDs ON SAPIDs.SAPID = d.DIVISION_SAP
		   ORDER BY 
		   cl.Name ASC
END;

USE [X5.MQtest]
GO

CREATE PROCEDURE [dbo].[x5_selectDivisionsBySAPIDs]
    @SAPIDs as SapIdTable READONLY,
	@DateStart date,
	@DateEnd date = null
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @SAPIDsToQuery as SapIdTable

	IF (@DateEnd IS NULL)
		SET @DateEnd = @DateStart
    IF (@DateEnd < @DateStart)
		SET @DateEnd = '9999-12-31'

		IF NOT EXISTS(SELECT TOP 1 * FROM @SAPIDs) 
		INSERT INTO @SAPIDsToQuery 
		SELECT DISTINCT d.DIVISION_SAP FROM
		[dbo].[Division] d		
	ELSE
		INSERT INTO @SAPIDsToQuery SELECT DISTINCT * FROM @SAPIDs
		

    SELECT d.* 
	FROM [X5.MQtest].[dbo].[DIVISION] d
	INNER JOIN @SAPIDsToQuery SAPIDs ON SAPIDs.SAPID = d.DIVISION_SAP

END;