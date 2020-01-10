CREATE DATABASE ShoppingSystem



CREATE TABLE Users(
username VARCHAR(20),
first_name VARCHAR(20),
last_name VARCHAR(20),
password VARCHAR(20),
email VARCHAR(50),

CONSTRAINT PK_Users Primary Key (username),
CONSTRAINT UQ_Email Unique(email)
);

CREATE TABLE User_Addresses(
username VARCHAR(20),
address VARCHAR(100),

CONSTRAINT PK_User_Addresses Primary Key(address,username),
CONSTRAINT fK_User_Addresses foreign Key(username) references Users ON DELETE CASCADE ON UPDATE CASCADE 
);

CREATE TABLE User_mobile_numbers(
username VARCHAR(20),
mobile_number VARCHAR(20),

CONSTRAINT PK_User_mobile_numbers Primary Key(mobile_number,username),
CONSTRAINT fK_User_mobile_numbers foreign Key(username) references Users ON DELETE CASCADE ON UPDATE CASCADE 
);


CREATE TABLE Customer(
username VARCHAR(20),
points INT,

CONSTRAINT fk_Customer foreign key (username) references Users ON DELETE CASCADE ON UPDATE CASCADE ,
CONSTRAINT pk_Customer Primary key (username)
);

CREATE TABLE Admins(
username VARCHAR(20),
CONSTRAINT fk_Admins foreign key (username) references Users ON DELETE CASCADE ON UPDATE CASCADE ,
CONSTRAINT pk_Admins Primary key (username)
);


CREATE TABLE Vendor(
username VARCHAR(20),
activated BIT default '0',
company_name VARCHAR(20),
bank_acc_no VARCHAR(20),
admin_username VARCHAR(20),


CONSTRAINT fk_Vendor1 foreign key (username) references Users ON DELETE CASCADE ON UPDATE CASCADE ,
CONSTRAINT fk_Vendor2 foreign key (admin_username) references Admins  ,
CONSTRAINT pk_Vendor Primary key (username)
);


CREATE TABLE Delivery_Person(
username VARCHAR(20),
is_activated BIT default '0' ,

CONSTRAINT pk_Delivery_Person primary key (username) ,
CONSTRAINT fk_Delivery_Person foreign key (username) references Users ON DELETE  CASCADE ON UPDATE CASCADE
);


CREATE TABLE Credit_Card(
number VARCHAR(20),
expiry_date date,
cvv_code VARCHAR(4),

CONSTRAINT Pk_Credit_Card primary key(number)
);


CREATE TABLE Delivery(
id int  identity , 
time_duration int,
fees decimal (5,3),
username varchar(20),
type varchar(20) ,

CONSTRAINT fk_Delivery foreign key (username) references Admins ON DELETE  SET NULL ON UPDATE CASCADE,
CONSTRAINT pk_Delivery primary key (id) 
);

create table Giftcard (
code varchar(10),
expiry_date datetime ,
amount int,
username varchar(20) ,

constraint pk_Giftcard primary key (code),
constraint fk_Giftcard foreign key (username) references Admins ON DELETE  SET NULL ON UPDATE CASCADE

);
CREATE TABLE Orders (
order_no int identity,
order_date datetime , 
total_amount decimal (10,2),
cash_amount decimal (10,2),
credit_amount decimal (10,2),
payment_type varchar(20),
order_status varchar(20) default 'not processed',
remaining_days int,
time_limit datetime,
gift_card_code_used VARCHAR(10),
customer_name  varchar(20),
delivery_id int ,
creditCard_number varchar(20)

constraint pk_Orders primary key (order_no),
constraint fk_Orders1 foreign key (customer_name) references customer ON DELETE  CASCADE ON UPDATE CASCADE,
constraint fk_Orders2 foreign key (delivery_id) references delivery ,
constraint fk_Orders3 foreign key (creditCard_number) references credit_card ON DELETE  SET NULL ON UPDATE CASCADE,
constraint fk_Orders4 foreign key (gift_card_code_used) references GiftCard 

);
CREATE TABLE Product (
serial_no int IDENTITY,
product_name varchar(20),
category varchar(20),
product_description text,
price decimal(10,2),
final_price decimal (10,2),
color varchar(20),
available bit, 
rate int,
vendor_username varchar(20),
customer_username varchar(20),
customer_order_id int 

constraint pk_Product primary key (serial_no),
constraint fk_Product1 foreign key (customer_order_id) references orders ON DELETE  SET NULL ON UPDATE CASCADE,  
constraint fk_Product2 foreign key (vendor_username) references Vendor, 
constraint fk_Product3 foreign key (customer_username) references Customer 

);
select * from User_mobile_numbers
CREATE TABLE CustomerAddstoCartProduct (
serial_no int ,
customer_name varchar(20),

constraint pk_CustomerAddstoCartProduct primary key (serial_no, customer_name),
constraint fk_CustomerAddstoCartProduct1 foreign key (serial_no)references Product ON DELETE  CASCADE ON UPDATE CASCADE ,
constraint fk_CustomerAddstoCartProduct2 foreign key (customer_name)references Customer 

);


CREATE TABLE TODAYS_DEALS (
deal_id int identity ,
deal_amount int,
expiry_date datetime,
admin_username varchar(20),

constraint pk_TODAYS_DEALS primary key (deal_id),
constraint fk_TODAYS_DEALS foreign key (admin_username) references Admins ON DELETE  SET NULL ON UPDATE CASCADE 

);




CREATE TABLE TODAYS_DEALS_PRODUCT (
deal_id int  ,
serial_no int,

constraint pk_TODAYS_DEALS_PRODUCT primary key (deal_id,serial_no),
constraint fk_TODAYS_DEALS_PRODUCT1 foreign key (serial_no) references Product  ,
constraint fk_TODAYS_DEALS_PRODUCT2 foreign key (deal_id) references Todays_Deals ON DELETE  CASCADE ON UPDATE CASCADE
);


CREATE TABLE offer(
offer_id int identity ,
offer_amount int,
expiry_date datetime,

constraint pk_offer primary key (offer_id),

);


create table offersOnProduct 
 (
offer_id int  ,
serial_no int,


constraint pk_offersOnProduct primary key (offer_id,serial_no),
constraint fk_offersOnProduct foreign key (serial_no) references Product ON DELETE  CASCADE ON UPDATE CASCADE,
constraint fk_offersOnProduct2 foreign key (offer_id) references offer ON DELETE  CASCADE ON UPDATE CASCADE

);


create table customer_question_product(
serial_no int,
customer_name varchar(20),
question varchar(50),
answer text ,

constraint pk_customer_question_product primary key (serial_no , customer_name),
constraint fk_customer_question_product1 foreign key (serial_no) references Product ON DELETE  CASCADE ON UPDATE CASCADE,
constraint fk_customer_question_product2 foreign key (customer_name) references Customer ,
);


create table wishlist (
username varchar(20),
name varchar(20),
constraint pk_wishlist primary key (username,name),
constraint fk_wishlist foreign key (username) references customer ON DELETE  CASCADE ON UPDATE CASCADE

);


create table Wishlist_Product (
username varchar(20),
wish_name  varchar(20),
serial_no int ,
constraint pk_Wishlist_Product primary key (username, wish_name,serial_no),
constraint fk_Wishlist_Product1  foreign key (username,wish_name) references wishlist ON DELETE  CASCADE ON UPDATE CASCADE, 
constraint fk_Wishlist_Product2  foreign key (serial_no) references Product 

); 

create table Admin_Customer_Giftcard (
code varchar(10),
customer_name varchar(20),
admin_username varchar(20),
remaining_points int
constraint  pk_Admin_Customer_Giftcard primary key (code, customer_name, admin_username),
constraint  fk_Admin_Customer_Giftcard1 foreign key  (code)references Giftcard ON DELETE  CASCADE ON UPDATE CASCADE, 
constraint  fk_Admin_Customer_Giftcard2 foreign key  (customer_name)references  Customer ,
constraint  fk_Admin_Customer_Giftcard3 foreign key  (admin_username) references Admins ,


);


create table Admin_Delivery_Order (
delivery_username varchar(20),
order_no int,
admin_username varchar(20),
delivery_window varchar(50),

constraint  pk_Admin_Delivery_Order primary key (delivery_username, order_no),
constraint  fk_Admin_Delivery_Order1 foreign key (delivery_username) references Delivery_Person ON DELETE  CASCADE ON UPDATE CASCADE, 
constraint  fk_Admin_Delivery_Order2 foreign key (order_no)references Orders ,
constraint  fk_Admin_Delivery_Order3 foreign key (admin_username)references Admins 
);

create table Customer_CreditCard (
customer_name varchar(20),
cc_number VARCHAR(20),


constraint pk_Customer_CreditCard  primary key (customer_name, cc_number),
constraint fk_Customer_CreditCard1  foreign key (customer_name)references Customer ON DELETE  CASCADE ON UPDATE CASCADE,
constraint fk_Customer_CreditCard2  foreign key (cc_number)references Credit_Card ON DELETE  CASCADE ON UPDATE CASCADE,

);
----------------------------------------------------------------------------------- 
--**************************THAT WAS THE SCHEMA****************************************
--------------------------------------------------------------------------------------------



go;
create proc customerRegister
@username varchar(20),@first_name varchar(20), @last_name varchar(20),@password varchar(20),@email
varchar(50)
AS 
BEGIN 

if(@username in (select Users.username from Users))
print 'Error, user already exists'
else
begin
insert into Users values (@username,@first_name, @last_name ,@password ,@email)
insert into Customer values (@username,0)
end
END

go;
create proc vendorRegister
@username varchar(20),@first_name varchar(20), @last_name varchar(20),@password varchar(20),@email
varchar(50) , @company_name varchar(20), @bank_acc_no varchar(20),@success bit output
AS 
BEGIN 
set @success ='1'
if(@username in (select Users.username from Users))
set @success ='0'
else
begin
insert into Users values (@username,@first_name, @last_name ,@password ,@email)
insert into Vendor  values (@username,'0',@company_name,@bank_acc_no,null)
end
END
go;
create proc userLogin
@username varchar(20), @password varchar(20),@success int output , @type int output
AS
begin
if( exists (select Users.username from Users where @username=username and  @password <> password ))begin
set @success=2;
end
else if(exists (select Users.username from Users where @username=username and  @password = password ) )
begin
set @success=1;
if(@username in (select username from Customer)) set @type=0
else if(@username in (select username from Vendor)) set @type=1
else if(@username in (select username from Admins)) set @type=2
else if(@username in (select username from Delivery_Person)) set @type=3
end
else
begin
set @success=0;
set @type= -1;
end
end

go;
create proc addMobile
@username varchar(20), @mobile_number varchar(20),@success BIT output
AS
begin

set @success ='1';
if(exists(select * from User_mobile_numbers where @username = username and @mobile_number=mobile_number))
set @success='0';

if(@username in (select username from Users) and (not exists (select * from User_mobile_numbers where @username=username and @mobile_number=mobile_number)) )
insert into User_mobile_numbers values (@username, @mobile_number)

end



go;
create proc addAddress
@username varchar(20), @address varchar(100)
AS
begin
if(@username in (select username from Users) and (not exists (select * from User_Addresses where @username=username and @address=address)))
insert into User_Addresses values (@username, @address)

end


go;
create proc showProducts
AS
begin 

select product_name,product_description,price,final_price,color from Product where available = '1';

end


go;
create proc ShowProductsbyPrice
AS
BEGIN 
select serial_no,product_name,product_description,price,color
from Product
where available = '1'
order by final_price 
end

go;
create proc searchbyname 
@text varchar(20)
AS 
begin 
select product_name,product_description,price,final_price,color
from Product
where product_name like ('%'+@text+'%') and available = '1'
end

go;
create proc AddQuestion 
@serial int, @customer varchar(20), @Question varchar(50)
AS
begin 

if (exists (select username  from Customer where username=@customer) and exists (select * from Product where serial_no=@serial))
insert into customer_question_product (serial_no,customer_name,question) values (@serial, @customer,@Question) 

end


select * from customerAddsToCartProduct


go; 
create proc addToCart
@customername varchar(20), @serial int AS
begin
if (exists (select *  from Customer where username=@customername ) 
and exists (select * from Product where serial_no=@serial and available='1') 
and not exists(select * from CustomerAddstoCartProduct where customer_name=@customername and serial_no=@serial))
begin 
insert into CustomerAddstoCartProduct (serial_no,customer_name) values (@serial,@customername);

end
end


go;
create proc removefromCart
@customername varchar(20), @serial int
AS
begin
if (exists ( select * from CustomerAddstoCartProduct where customer_name=@customername and serial_no = @serial))
begin

delete from CustomerAddstoCartProduct 
where customer_name=@customername and serial_no = @serial;

end
end

--new proc 
go;
create proc checkInCart 
@customername varchar(20), @serial int, @success bit output
as 
set @success='0'
if(exists(select * from CustomerAddstoCartProduct where customer_name=@customername and serial_no=@serial))
set @success='1'

go;
create proc getWishList
@customername varchar(20)
as
begin
select name from wishlist where @customername=username;
end; 


go;
create proc createWishlist 
@customername varchar(20), @name varchar(20),@success bit output
AS
begin
set @success='1';
if ( exists (select * from Customer where username=@customername) 
and not exists ( select * from wishlist where username=@customername and name=@name))
insert into wishlist (username, name) values (@customername ,@name )
else
set @success='0';
end


select * from Customer
select * from Users


select * from Wishlist_Product

go;
create proc AddtoWishlist 
@customername varchar(20), @wishlistname varchar(20), @serial int ,@success int output
AS
begin
if(not exists(select * from wishlist where username=@customername and name=@wishlistname))
set @success=0; -- wishlist name doesn't exist
else
begin 
if (exists (select *  from Customer where username=@customername ) 
and exists (select * from Product where serial_no=@serial) 
and not exists (select * from Wishlist_Product where username=@customername and wish_name=@wishlistname and serial_no=@serial ))
begin 
insert into Wishlist_Product(serial_no,username,wish_name) values (@serial,@customername,@wishlistname);
set @success=1; --added successfully
end
else
begin
set @success=2 --product already exists in this wishlist
exec removefromWishlist @customername, @wishlistname , @serial 
end
end

end 


go;
create proc removefromWishlist
@customername varchar(20), @wishlistname varchar(20), @serial int
AS
begin
if (exists (select * from Wishlist_Product where username=@customername and wish_name=@wishlistname and serial_no=@serial ))
begin 
delete from Wishlist_Product 
where serial_no=@serial and username =@customername and  wish_name = @wishlistname

end
end 

go;
create proc showWishlistProduct
@customername varchar(20), @name varchar(20)
AS 
begin 
select p.product_name,p.product_description,p.price,p.final_price,p.color 
from  Wishlist_Product w inner join Product p on p.serial_no =W.serial_no 
where W.username=@customername and w.wish_name=@name;
end


GO;
create proc viewMyCart
@customer varchar(20)
AS
begin
select p.product_name,p.product_description,p.price,p.final_price,p.color from CustomerAddstoCartProduct c inner join product p on p.serial_no = c.serial_no
where @customer =c.customer_name;
end

----Testing Stopped here Good Night
go;
create proc calculatepriceOrder
@customername varchar(20),@sum decimal(10,2) output
as 
select @sum =sum (p.final_price) 
from Product p inner join CustomerAddstoCartProduct c on p.serial_no=c.serial_no 
where @customername=c.customer_name;

go;
create proc productsinorder
@customername varchar(20), @orderID int
as
begin
if(exists(select* from orders where @customername = customer_name and @orderID=order_no))
BEGIN

update Product  set customer_order_id=@orderID,available='0',customer_username=@customername
where serial_no in ( select C.serial_no from CustomerAddstoCartProduct C where C.customer_name=@customername);


delete from CustomerAddstoCartProduct 
where serial_no in(select p.serial_no from product p where customer_order_id=@orderID )AND customer_name<>@customername ;


select * from product where customer_order_id=@orderID;

END;
end;





go;
create proc emptyCart
@customername varchar(20)
as
begin
delete from CustomerAddstoCartProduct where @customername= customer_name;

end


declare @sum decimal(10,2)
declare @success bit 
declare @orderID int 
exec makeOrder 'sal', @sum output, @orderID output , @success output

--print @success
print @sum 


go;
create proc makeOrder
@customername varchar(20),@sum decimal(10,2) output ,@orderID int output, @success bit output
as
begin
set @success='0'
if(exists (select * from CustomerAddstoCartProduct where customer_name=@customername ))
begin
set @success ='1'
declare @tmpsum decimal(10,2)
exec calculatepriceOrder @customername,@tmpsum output
set @sum=@tmpsum;
insert into Orders(order_date,total_amount,customer_name) values (CURRENT_TIMESTAMP,@tmpsum,@customername);
--declare @orderID int;
  select  @orderID= max(order_no) from Orders
where customer_name=@customername;


exec productsinorder @customername , @orderID

exec emptyCart @customername;
end;
end;
go;
create proc getOrders
@customername varchar(20)
as
begin
select  order_no, total_amount from Orders where @customername =customer_name;
end;

exec cancelOrder 29
exec cancelOrder 30
exec cancelOrder 31
exec cancelOrder 32
exec cancelOrder 33
exec cancelOrder 34
exec cancelOrder 35
exec cancelOrder 36
exec cancelOrder 37
exec cancelOrder 38



go;
create proc cancelOrder
@customername varchar(20),@orderid int , @success int output
as
begin

set @success=2;

if(not exists(select * from Orders where order_no=@orderid and @customername = customer_name))
begin
set @success=0;
end
else
begin 
if(exists(select * from Orders where order_no=@orderid and (order_status='not processed' or order_status='in process')))
begin
set @success=1;
declare @points int;
declare @cash decimal(10,2);
declare @credit decimal(10,2);
declare @total decimal(10,2);
select @cash=cash_amount from Orders where order_no=@orderid;
select @credit=credit_amount from Orders where order_no=@orderid;
select @total = total_amount from Orders where order_no=@orderid;
set @points = @total -(@cash+@credit);
declare @cardreturn int 
set @cardreturn=0
if (exists (select * from Giftcard where  expiry_date >=CURRENT_TIMESTAMP and 
code in (select gift_card_code_used from Orders where order_no=@orderid) ))
begin 
declare @giftAmount int --original 
select @giftAmount = amount  from  Giftcard where code in (select gift_card_code_used from Orders where order_no=@orderid)
declare @giftAmountRem int --remaining 
select @giftAmountRem = remaining_points  from  Admin_Customer_Giftcard where code in (select gift_card_code_used from Orders where order_no=@orderid)

if (@points-(@giftAmount-@giftAmountRem) <=0)
begin 
set @cardreturn = @points 
set @points=0 
end
else 
begin 
set @cardreturn =(@giftAmount-@giftAmountRem) 
set @points = @points-@cardreturn 
end
end
if(not exists (select * from Giftcard where  expiry_date >=CURRENT_TIMESTAMP and 
code in (select gift_card_code_used from Orders where order_no=@orderid) ))
set @points=0;

update Customer 
set points = points+@points+@cardreturn where username in (select customer_name from Orders where order_no=@orderid) 


update Admin_Customer_Giftcard
set remaining_points=@cardreturn+remaining_points where code 
in(select gift_card_code_used from Orders where order_no=@orderid) 
update Product set available='1',customer_order_id=null,customer_username=null where customer_order_id=@orderid;
delete  from Admin_Delivery_Order where order_no=@orderid;
delete   Orders where order_no=@orderid ;

end;


end;
end;


go;
create proc returnProduct
@serialno int, @orderid int
as 
begin 

update product set available='1',customer_order_id=null,customer_username=null where @orderid=customer_order_id and serial_no=@serialno;

declare @productFinPrice decimal(10,2);
select @productFinPrice =final_price from Product where @serialno=serial_no;

declare @pointsUsed int;
select @pointsUsed =(total_amount-(cash_amount+credit_amount)) from Orders where @orderid=order_no;

update orders set total_amount=total_amount-@productFinPrice where order_no=@orderid;
begin
if(exists(select * from Orders O inner join Admin_Customer_Giftcard A on A.code=o.gift_card_code_used  inner join Giftcard G 
on G.code=A.code where G.expiry_date>=CURRENT_TIMESTAMP))
begin
update customer set points=points+@pointsUsed
where username in (select O.customer_name from Orders O where @orderid=order_no)
declare @code varchar(10);
select @code= A.code from Orders O inner join Admin_Customer_Giftcard A 
on A.code=o.gift_card_code_used where O.order_no=@orderid


declare @cardAmount INT;
select @cardAmount  =amount from Giftcard where code=@code

update Admin_Customer_Giftcard set remaining_points=remaining_points+@pointsUsed where code=@code;

update Admin_Customer_Giftcard set remaining_points=@cardAmount where code=@code and remaining_points>@cardAmount;
end
end
end



go;
create proc ShowproductsIbought
@customername varchar(20)                  
as 
begin
select serial_no,product_name,category,product_description,price,final_price,color from Product  where customer_username=@customername
end;


go;
create  proc rate
@serialno int, @rate int , @customername varchar(20)
as
begin
update product set rate=@rate where serial_no=@serialno and
exists (select p.*
from Product p inner join Orders O on o.order_no=p.customer_order_id
where customer_name=@customername and p.serial_no=@serialno);
end;

go;
create proc SpecifyAmount 
@customername varchar(20), @orderID int, @cash decimal(10,2), @credit decimal(10,2),@success int output
AS
begin
declare @paymentType varchar(20);
if(@cash is null or @cash=0)
begin 
set @cash=0;
set @paymentType='credit';
end
if(@credit is null or @credit=0) 
begin
set @credit=0;
set @paymentType='cash';
end;

if(@credit =0 and @cash=0)set @paymentType='points';


declare @total decimal (10,2)
select @total = total_amount from Orders where order_no=@orderID 
declare @pointsUsed int 
set @pointsUsed = @total -(@cash+@credit) 
set @success=1;
if(not exists(select * from Orders where order_no=@orderID and customer_name=@customername))
set @success=0;
else
begin
if ( exists (select * from customer where @customername=username and points>=@pointsUsed)) 
begin
declare @code varchar(10);
select @code =a.code from Admin_Customer_Giftcard a inner join Giftcard g on a.code=g.code 
where @customername =a.customer_name and g.expiry_date>=CURRENT_TIMESTAMP;

update Admin_Customer_Giftcard
set remaining_points = remaining_points-@pointsUsed
where customer_name=@customername and code in 
(select a.code from Admin_Customer_Giftcard a inner join Giftcard g on a.code=g.code and g.expiry_date>=CURRENT_TIMESTAMP)

update Admin_Customer_Giftcard
set remaining_points = 0
where customer_name=@customername and remaining_points<0 and code in 
(select a.code from Admin_Customer_Giftcard a inner join Giftcard g on a.code=g.code and g.expiry_date>=CURRENT_TIMESTAMP)

update Customer 
set points=points-(@pointsUsed)
where @customername=username 

update orders 
set cash_amount = @cash ,credit_amount=@credit,gift_card_code_used=@code,payment_type=@paymentType
where order_no=@orderID

end
else
set @success= 2;
--print 'error : You do not have enough funds'-- check this with the team

end;
end;



go;
create proc AddCreditCard
@creditcardnumber varchar(20), @expirydate date , @cvv varchar(4), @customername varchar(20),@success BIT output
as 
begin

set @success='0';

if (not exists ( select * from Credit_Card where number = @creditcardnumber))
insert into Credit_Card (number,expiry_date,cvv_code) values (@creditcardnumber, @expirydate,@cvv) 

if (not exists (select * from Customer_CreditCard where customer_name=@customername and cc_number=@creditcardnumber))
begin
insert into Customer_CreditCard (customer_name,cc_number) values (@customername,@creditcardnumber)
set @success='1';
end;
end


go;
CREATE PROC ChooseCreditCard
@creditcard varchar(20), @orderid int ,@success bit output ,@username varchar(20)
AS
if(not exists(select * from Credit_Card where number=@creditcard) or not exists(select * from Orders where order_no=@orderid and @username= customer_name))
set @success = '0';
else
if(exists(select * from Credit_Card where number=@creditcard))
begin
set @success='1';
update  orders
SET creditCard_number =@creditcard 
where order_no=@orderid
end




go;
CREATE PROC viewDeliveryTypes
AS
SELECT type,time_duration,fees 
FROM Delivery


go;
create proc specifydeliverytype
@orderID int, @deliveryID int

As
if(exists(select* from Delivery where @deliveryID= id))
begin
declare @remainingDays int 
select @remainingDays=time_duration from Delivery where id=@deliveryID 
update Orders
set delivery_id=@deliveryID , remaining_days = @remainingDays,time_limit=CURRENT_TIMESTAMP+@remainingDays
where order_no=@orderID

end

go;
 create proc trackRemainingDays
@orderid int, @customername varchar(20),@days int output
AS
begin
declare @timelimit datetime
select @timelimit= time_limit
from Orders
where order_no=@orderid AND @customername=customer_name

SET @Days= datediff(day,CURRENT_TIMESTAMP,@timelimit);

if(@Days<0)
set @days=0;

update orders 
set remaining_days = @days
where order_no=@orderid
end


/*
go;
create proc recommend
@customername varchar(20)
as

begin

select serial_no,product_name,category,product_description,price,final_price,color from product where serial_no in


(
select top 3 p.serial_no
from Wishlist_Product w inner join Product p on p.serial_no=w.serial_no 
where p.category
in 
(
select top 3 p.category 
from CustomerAddstoCartProduct  C inner join Product x on c.serial_no=x.serial_no
where c.customer_name=@customername
or x.serial_no in(
select top 3 P.serial_no from Wishlist_Product W inner join Product p on(p.serial_no = W.serial_no) 
where W.username 
in
(
select top 3 C.username from customer C inner join CustomerAddstoCartProduct P on p.customer_name=C.username -- the top 3 similar customername
where C.username<> @customername and 
p.serial_no in(select Pro.serial_no from CustomerAddstoCartProduct Pro where @customername=Pro.customer_name )--my products
group by C.username
order by count(*) desc
)

group by p.serial_no
order by count(*) desc

)

group by category 
order by count(*) desc
)
group by p.serial_no , p.category
order by count(*) desc
)

end
*/




go;
create proc recommend
@customername varchar(20)
As
Begin
Declare @myt2 table (serial_no int)
insert @myt2 
Exec test2 @customername

Declare @myt1 table (serial_no int)
insert @myt1
Exec test1 @customername

select serial_no,product_name,category,product_description,price,final_price,color from Product where serial_no in (
select * from @myt1 union select * from @myt2)

end

go;
Create proc test1
@customername varchar(20)
As
Begin
select top 3 p1.serial_no from Wishlist_Product w1 inner join Product p1 on(p1.serial_no = w1.serial_no) 
where w1.username 
in
(
select top 3 c1.username from customer c1 inner join CustomerAddstoCartProduct p2 on p2.customer_name=c1.username -- the top 3 similar customername
where c1.username<> @customername and 
p2.serial_no in(select Pro.serial_no from CustomerAddstoCartProduct Pro where @customername=Pro.customer_name )--my products
group by c1.username
order by count(*) desc
)

group by p1.serial_no
order by count(*) desc
end

go;
Create proc test2
@customername varchar(20)
As
begin
select top 3 p.serial_no
from Wishlist_Product w inner join Product p on p.serial_no=w.serial_no 
where p.category
in 
(
select top 3 x.category 
from CustomerAddstoCartProduct  C inner join Product x on c.serial_no=x.serial_no
where c.customer_name=@customername


group by category 
order by count(*) desc
)
group by p.serial_no , p.category
order by count(*) desc
end





go;
create proc postProduct
@vendorUsername varchar(20), @product_name varchar(20) ,
@category varchar(20), @product_description text , @price decimal(10,2), @color varchar(20),@sucess bit output
as
begin
set @sucess = '0';
if(exists(select* from vendor where username=@vendorUsername AND activated='1'))
begin
set @sucess = '1';
insert into product(product_name,category,product_description,price,final_price,color,available,rate,vendor_username,customer_username,customer_order_id)
values (@product_name,@category,@product_description,@price,@price,@color,'1',null,@vendorUsername,null,null)
end;
end;

exec  vendorViewProducts 'philo'
go;
CREATE PROC vendorviewProducts
@vendorname varchar(20)
as
begin
if (exists (select * from Vendor where username=@vendorname and activated = '1')) 
SELECT *
FROM Product
WHERE vendor_username=@vendorname
end

go;
CREATE PROC EditProduct
@vendorname varchar(20), @serialnumber int, @product_name varchar(20) ,@category varchar(20),
@product_description text , @price decimal(10,2), @color varchar(20),@sucess int output
AS
set @sucess= '0';
if(@vendorname is null)
begin
select @vendorname = vendor_username from Product where @serialnumber=serial_no ;
end


if(@product_name is null)
begin
select @product_name = product_name from Product where @serialnumber=serial_no ;
end

if(@category is null)
begin
select @category = category from Product where @serialnumber=serial_no ;
end

if(@product_description is null)
begin
select @product_description = product_description from Product where @serialnumber=serial_no ;
end

if(@price is null)
begin
select @price = price from Product where @serialnumber=serial_no ;
end

if(@color is null)
begin
select @color = color from Product where @serialnumber=serial_no ;
end

if (exists (select * from Vendor where username=@vendorname and activated = '1')) 
set @sucess='1'
if(not exists (select * from Product where serial_no=@serialnumber and vendor_username=@vendorname))
set @sucess='2'

Declare @p decimal(10,2)
select @p= price from Product where serial_no=@serialnumber
if(@p <> @price)
begin
update Product
set product_name=@product_name,category=@category,product_description=@product_description,final_price=@price,price=@price,color=@color

where @serialnumber =serial_no AND vendor_username=@vendorname
end
else
begin
update Product
set product_name=@product_name,category=@category,product_description=@product_description,price=@price,color=@color

where @serialnumber =serial_no AND vendor_username=@vendorname
end


go;
CREATE PROC deleteProduct
@vendorname varchar(20), @serialnumber int
AS
if (exists (select * from Vendor where username=@vendorname and activated = '1')) 
delete Product
where @serialnumber =serial_no AND vendor_username=@vendorname


go;
create proc viewQuestions
@vendorname varchar(20)
As 
if (exists (select * from Vendor where username=@vendorname and activated = '1')) 
select Q.*
from customer_question_product  Q inner join Product P on Q.serial_no=P.serial_no 
where P.vendor_username=@vendorname


go;

create proc answerQuestions
@vendorname varchar(20), @serialno int, @customername varchar(20), @answer text
as
if (exists (select * from Vendor where username=@vendorname and activated = '1') AND exists(select * from Product where serial_no=@serialno AND vendor_username=@vendorname))
update customer_question_product
set answer=@answer
where serial_no=@serialno AND customer_name= @customername
--this is for test
select * from offer
go;
create proc addOffer
@offeramount int, @expiry_date datetime
as
begin
insert into offer(offer_amount,expiry_date) values (@offeramount,@expiry_date)
end

go;
create proc checkOfferonProduct
@serial int , @activeoffer BIT OUTPUT
as
begin
SET @activeoffer ='0'
if(exists(select * from Product P Inner join offersOnProduct O on P.serial_no= O.serial_no inner join 
offer F on O.offer_id=f.offer_id where f.expiry_date>=CURRENT_TIMESTAMP AND P.serial_no=@serial))
SET @activeoffer ='1'

end
exec getOffer
go;
create proc getOffer
AS
begin
select * from offer 
end


go;
create proc checkandremoveExpiredoffer 
@offerid int , @sucess bit output 
AS
set @sucess= '0'
begin 
if(exists(select* from offer where offer_id=@offerid and expiry_date<CURRENT_TIMESTAMP))
begin
set @sucess= '1'
declare @amount INT;
select @amount =offer_amount from offer where offer_id =@offerid;
update product set final_price=price 
where serial_no in (select serial_no from offersOnProduct where offer_id=@offerid)

delete offer where offer_id=@offerid;

end
end


go;
create proc applyOffer
@vendorname varchar(20), @offerid int, @serial int,@sucess  bit output
as
begin
set @sucess = '0';
declare @active BIT
exec checkOfferonProduct @serial,@active output

if(exists(select * from product
where serial_no=@serial and @vendorname=vendor_username) and 
exists(select*from Vendor where @vendorname=username and activated='1') and @active='0')
begin
declare @amount decimal(10,2);

if(exists(select * from offer where offer_id=@offerid and expiry_date>CURRENT_TIMESTAMP))
begin
set @sucess = '1';
select @amount =offer_amount from offer where offer_id =@offerid ;

update product set final_price=price*(1-(@amount/100.0)) where serial_no=@serial

insert into offersOnProduct(serial_no,offer_id) values (@serial,@offerid)
end
end;

end


go;
create proc activateVendors
@admin_username varchar(20),@vendor_username varchar(20)
as
begin 
if(exists (select * from Admins where username=@admin_username))
begin 
update Vendor
set admin_username=@admin_username , activated='1'
where username=@vendor_username 
end
end 

go;
create proc inviteDeliveryPerson
@delivery_username varchar(20), @delivery_email varchar(50)
as
begin
insert into Users (username,email) values (@delivery_username,@delivery_email)
insert into Delivery_Person (username,is_activated) values (@delivery_username,'0')
end

go;
create proc reviewOrders 
as
select * from Orders


go; 
create proc updateOrderStatusInProcess 
@order_no int
AS
update Orders 
set order_status='in process' 
where order_no=@order_no

go;
create proc addDelivery
@delivery_type varchar(20),@time_duration int,@fees decimal(5,3),@admin_username varchar(20)
as
begin 
if (exists (select * from Admins where username=@admin_username))
begin
insert into Delivery (type ,time_duration,fees,username) values (@delivery_type,@time_duration, @fees, @admin_username)

end
end 


go;
create proc assignOrdertoDelivery 
@delivery_username varchar(20),@order_no int,@admin_username varchar(20)
as 
begin 
if (exists (select * from Admins where username=@admin_username) and
exists (select * from Delivery_Person where username=@delivery_username and is_activated='1')
and exists (select * from Orders where order_no=@order_no))
begin
insert into Admin_Delivery_Order (admin_username,delivery_username,order_no) values (@admin_username,@delivery_username,@order_no)

end
end

go;

create proc createTodaysDeal
@deal_amount int,@admin_username varchar(20),@expiry_date datetime
as 
begin 
if (exists (select * from Admins where username=@admin_username))
begin 

insert into TODAYS_DEALS (admin_username,deal_amount,expiry_date) values (@admin_username,@deal_amount,@expiry_date) 
end
end




go;
create proc checkTodaysDealOnProduct
@serial_no INT ,@activeDeal BIT output
AS
BEGIN
set @activeDeal='0'
if (exists(select * from TODAYS_DEALS t inner join TODAYS_DEALS_PRODUCT d on d.deal_id=t.deal_id 
where serial_no=@serial_no and t.expiry_date >= CURRENT_TIMESTAMP))
set @activeDeal='1'

END


go;
create proc addTodaysDealOnProduct
@deal_id int, @serial_no int
AS
begin 
if( not exists (select * from TODAYS_DEALS t inner join TODAYS_DEALS_PRODUCT d on d.deal_id=t.deal_id 
where serial_no=@serial_no and t.expiry_date >= CURRENT_TIMESTAMP))
Begin
insert into TODAYS_DEALS_PRODUCT (deal_id,serial_no) values (@deal_id,@serial_no)
Declare @amount decimal (10,2)
select @amount=deal_amount from TODAYS_DEALS where @deal_id=deal_id
update Product 
Set final_price = price*(1.0-(@amount/100.0)) where serial_no=@serial_no

end
end



go;
create proc removeExpiredDeal
@deal_iD int
AS 
begin
if(@deal_iD in (select deal_id from TODAYS_DEALS where expiry_date <CURRENT_TIMESTAMP))
begin
Declare @amount decimal (10,2)
select @amount=deal_amount from TODAYS_DEALS where @deal_id=deal_id
update Product 
Set final_price = price  where serial_no in 
(select p.serial_no from TODAYS_DEALS_PRODUCT P where P.deal_id=@deal_iD)
end
delete  todays_deals
where deal_id=@deal_iD and expiry_date< CURRENT_TIMESTAMP 

end 


go;
create proc createGiftCard
@code varchar(10),@expiry_date datetime,@amount int,@admin_username varchar(20)
AS 
begin 
if(not exists (select * from Giftcard where code=@code ))
insert into Giftcard(code ,expiry_date,amount,username) values (@code ,@expiry_date,@amount,@admin_username)
end 




go;
create proc removeExpiredGiftCard
@code varchar(10)
as 
begin
if(exists( select*from giftcard where @code=code and expiry_date< CURRENT_TIMESTAMP))
begin

update customer set points=points-A.remaining_points  
from Admin_Customer_Giftcard  A inner join Customer C on( c.username=A.customer_name and A.code=@code) 


delete giftcard where @code=code ;

end;
end;

go;
create proc checkGiftCardOnCustomer
@code varchar(10),
@activeGiftCard BIT Output
as 
begin
set @activeGiftCard ='0';
if(exists(select * from Giftcard where @code =code and expiry_date>=CURRENT_TIMESTAMP) 
and exists(select * from Admin_Customer_Giftcard where @code=code))
set @activeGiftCard ='1';
end



go;
create proc giveGiftCardtoCustomer
@code varchar(10),@customer_name varchar(20),@admin_username varchar(20)
as
begin
if(exists(select *from Giftcard where @code=code and expiry_date>=CURRENT_TIMESTAMP))
begin
declare @points int;
select @points=amount from Giftcard where @code =code;
if(not exists(select * from Admin_Customer_Giftcard where customer_name=@customer_name and code=@code))
begin
update customer set points=points+@points where @customer_name=username;
end

insert into Admin_Customer_Giftcard(code,customer_name,remaining_points,admin_username) values (@code,@customer_name,@points,@admin_username)


end
end

go;
create proc acceptAdminInvitation
@delivery_username varchar(20)
as
begin
update Delivery_Person set is_activated='1' where @delivery_username = username;
end


go;
create proc deliveryPersonUpdateInfo
@username varchar(20),@first_name varchar(20),@last_name varchar(20),@password varchar(20),@email
varchar(50)
as
begin
if(exists(select * from Delivery_Person where @username=username and is_activated='1'))
begin
update users set first_name=@first_name , last_name=@last_name,email=@email,password=@password 
where @username=username;
end
end


go;
create proc viewmyorders
@deliveryperson varchar(20)
as
begin
select O.* from Orders O inner join Admin_Delivery_Order A on O.order_no=A.order_no 
where A.delivery_username=@deliveryperson;
end;


go;
create proc specifyDeliveryWindow
@delivery_username varchar(20),@order_no int,@delivery_window varchar(50)
as
begin
update Admin_Delivery_Order set delivery_window =@delivery_window
where @order_no=order_no and @delivery_username=delivery_username

end;





go;
create proc updateOrderStatusOutforDelivery
@order_no int
as
begin
update Orders set order_status ='out for delivery' where @order_no=order_no;
end;



go;
create proc updateOrderStatusDelivered
@order_no int
as 
begin
update Orders set order_status ='delivered' where @order_no=order_no;

end



