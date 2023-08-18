create database Assesment04Db 

use Assesment04Db

-- Create the Products table with FLOAT data type
create table Products
(PId int identity(500,1) primary key,
PName nvarchar(100) not null,
PPrice float,
PTax as (0.10 * PPrice) persisted,
PCompany nvarchar(50),
PQty int default 10)

-- Insert some sample records
Insert into Products (PName, PPrice, PCompany, PQty)
values
    ('Galaxy S21', 100, 'Samsung', 20),
    ('Iphone 13', 200, 'Apple', 15),
    ('Note 11Pro', 150, 'Redmi', 25),
    ('Htc 6', 80, 'HTC', 10),
    ('Realme C55', 300, 'RealMe', 30),
    ('Xiomi 10A', 250, 'Xiaomi', 5),
    ('Tab A7Lite', 120, 'Samsung', 12),
    ('Ipad', 180, 'Apple', 18),
    ('Redmi Note 12', 90, 'Redmi', 22),
    ('Desire 12', 220, 'HTC', 8);

	select * from Products
-- Create the procedure to display product details
create procedure dbo.GetProductDetails
AS
begin
    select PId, PName, PPrice + PTax AS PPricewithTax, PCompany, PQty * (PPrice + PTax) AS TotalPrice
    from Products;
end

exec GetProductDetails
-- Create the procedure to calculate total tax of PCompany
create procedure dbo.GetTotalTaxByCompany
    @Company nvarchar(50),
    @TotalTax float OUTPUT
with Encryption
AS
begin
    select @TotalTax = SUM(PTax)
    from Products
    where PCompany = @Company;
end
------------------------------------------------------------------------------------------
declare @Company nvarchar(50);
declare @TotalTax float;

set @Company = 'Apple'

-- Execute the GetTotalTaxByCompany procedure
exec GetTotalTaxByCompany @Company, @TotalTax OUTPUT;

-- Display the total tax
select @TotalTax AS TotalTax;