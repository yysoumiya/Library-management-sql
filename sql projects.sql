create database LibraryDB;
use LibraryDB;
CREATE TABLE Books (
    book_id INT PRIMARY KEY,  
    title VARCHAR(255) NOT NULL,  
    author VARCHAR(255) NOT NULL,  
    publish_date DATE,  
    genre VARCHAR(100),  
    available_copies INT CHECK (available_copies >= 0)  
);

alter table books add column department  varchar(100);
alter table books drop column department;

CREATE TABLE Members (
    member_id INT PRIMARY KEY,  
    first_name VARCHAR(100) NOT NULL,  
    last_name VARCHAR(100) NOT NULL,  
    email VARCHAR(255) UNIQUE NOT NULL,  
    join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  
    phone_number VARCHAR(15),  
    address VARCHAR(255)  
);

INSERT INTO Books (book_id, title, author, publish_date, genre, available_copies)
VALUES 
(1, 'To Kill a Mockingbird', 'Harper Lee', '1960-07-11', 'Fiction', 5),
(2, '1984', 'George Orwell', '1949-06-08', 'Dystopian', 3),
(3, 'The Great Gatsby', 'F. Scott Fitzgerald', '1925-04-10', 'Fiction', 4),
(4, 'Moby Dick', 'Herman Melville', '1851-10-18', 'Adventure', 2),
(5, 'The Catcher in the Rye', 'J.D. Salinger', '1951-07-16', 'Fiction', 6),
(6, 'Pride and Prejudice', 'Jane Austen', '1813-01-28', 'Romance', 8),
(7, 'War and Peace', 'Leo Tolstoy', '1869-01-01', 'Historical Fiction', 3),
(8, 'The Odyssey', 'Homer', '800-01-01', 'Epic', 7),
(9, 'The Hobbit', 'J.R.R. Tolkien', '1937-09-21', 'Fantasy', 10),
(10, 'The Catcher in the Rye', 'J.D. Salinger', '1951-07-16', 'Fiction', 4);

select * from books;


INSERT INTO Members (member_id, first_name, last_name, email, join_date, phone_number, address)
VALUES 
(1, 'Alice', 'Johnson', 'alice.johnson@example.com', '2025-03-01 00:00:00', '78985455', '123 Main St, Springfield'),
(2, 'Bob', 'Smith', 'bob.smith@example.com', '2025-03-05 00:00:00', '77564865', '456 Elm St, Springfield'),
(3, 'Charlie', 'Davis', 'charlie.davis@example.com', '2025-03-10 00:00:00', '45895622', '789 Pine St, Springfield'),
(4, 'David', 'Williams', 'david.williams@example.com', '2025-03-12 00:00:00', '92657856', '101 Oak St, Springfield'),
(5, 'Eve', 'Brown', 'eve.brown@example.com', '2025-03-15 00:00:00', '96457865', '202 Maple St, Springfield'),
(6, 'Frank', 'Taylor', 'frank.taylor@example.com', '2025-03-18 00:00:00', '97568545', '303 Birch St, Springfield'),
(7, 'Grace', 'Moore', 'grace.moore@example.com', '2025-03-20 00:00:00', '789854852', '404 Cedar St, Springfield'),
(8, 'Hank', 'Miller', 'hank.miller@example.com', '2025-03-22 00:00:00', '99568745', '505 Walnut St, Springfield'),
(9, 'Ivy', 'Wilson', 'ivy.wilson@example.com', '2025-03-25 00:00:00', '89787598', '606 Pine St, Springfield'),
(10, 'Jack', 'Anderson', 'jack.anderson@example.com', '2025-03-27 00:00:00', '984545445', '707 Maple St, Springfield');



select * from members;
select * from books where book_id =2;
select * from members where first_name = "alice";
select * from books where available_copies > 8;
select * from books where available_copies < 8 and book_id >5;
select * from members where member_id =5 or first_name = "bob";
select * from members where member_id between 1 and 5;
select * from books where genre in ("fiction","Romance");
select * from books where genre not in ("fiction");
select * from members limit 1,1;
select * from members where first_name like "a%";
select * from members where first_name like "%a";
select * from members where first_name like "%a%";
select * from members where first_name not like "a%";
select distinct genre from books;
select * from books order by genre;
select * from books order by author desc;
select * from books order by author,book_id desc;
select * from books where genre = "fiction" order by available_copies;
select * from books order by
(case genre when "fiction" then 1
when "Romance" then 2
when  "Fantasy" then 3
else 100 end 
);
select count(*) from books;
select count(*)no_of_Romance from books where genre = "Romance";
select ucase (first_name) from members;
select first_name,CHAR_LENGTH (first_name) from members;
select now();
select date(now());
select CURDATE()
select count(*) from books group by genre;
select count(*) from books group by genre having count(*) >= 1;

select books.title,books.author,members.first_name,members.last_name,members.email
from books cross join members;

select books.title,books.author,members.first_name,members.last_name,members.email 
from books inner join members 
on books.available_copies > 0;

select books.title,books.author,members.first_name,members.last_name,members.email
from books left join members on books.book_id = members.member_id;

select Members.first_name,Members.last_name,Books.title AS book_title,Books.author
FROM Books JOIN members on Books.book_id = Members.member_id;

select * 
from Members 
where member_id in (select book_id from Books where genre = 'fiction');

delimiter $$
create procedure getinfo()
begin 
select * from members where member_id in  
(select book_id from books where genre = "Romance");
end $$
delimiter;

call getinfo();





