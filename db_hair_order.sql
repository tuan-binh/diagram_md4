create database hair_order;
use hair_order;

create table users
(
    id_user   int auto_increment primary key,
    full_name varchar(150),
    phone     varchar(11) unique,
    password  varchar(255),
    address   text,
    status    bit
);

create table address
(
    id_address   int auto_increment primary key,
    address_name varchar(255),
    status       bit
);

create table roles
(
    id_role   int auto_increment primary key,
    role_name varchar(255) not null
);

create table role_details
(
    id_detail int auto_increment primary key,
    id_role   int not null,
    id_user   int not null,
    foreign key (id_role) references roles (id_role),
    foreign key (id_user) references users (id_user)
);

create table hair
(
    id       int auto_increment primary key,
    url_hair text not null,
    row_url  int
);

create table favourite
(
    id_favourite int auto_increment primary key,
    id_hair      int not null,
    id_user      int not null,
    foreign key (id_hair) references hair (id),
    foreign key (id_user) references users (id_user)
);

create table type
(
    id_type   int auto_increment primary key,
    type_name varchar(255),
    status    bit
);

create table times
(
    id_time int auto_increment primary key,
    time    varchar(255),
    status  bit
);

create table barber
(
    id_barber   int auto_increment primary key,
    barber_name varchar(255),
    url_avatar  text,
    status      bit
);

create table orders
(
    id_order  int auto_increment primary key,
    id_user   int not null,
    id_barber int not null,
    id_type   int not null,
    id_time   int not null,
    address   varchar(255),
    status    bit,
    foreign key (id_user) references users (id_user),
    foreign key (id_barber) references barber (id_barber),
    foreign key (id_type) references type (id_type),
    foreign key (id_time) references times (id_time)
);

alter table orders add column date varchar(255) after id_time;

create table reviews
(
    id_review int auto_increment primary key,
    comment   text,
    rate      int,
    id_order  int not null unique,
    foreign key (id_order) references orders (id_order)
);

create table user_no_account
(
    id int auto_increment primary key ,
    phone varchar(11),
    id_barber int not null,
    id_type   int not null,
    id_time   int not null,
    address   varchar(255),
    status    bit,
    foreign key (id_barber) references barber (id_barber),
    foreign key (id_type) references type (id_type),
    foreign key (id_time) references times (id_time)
);

alter table user_no_account add column date varchar(255) after id_time;

delimiter //
create trigger after_insert_user
    after insert
    on users
    for each row
begin
    insert into role_details (id_role, id_user) value (1, NEW.id_user);
end //

delimiter //
create trigger before_delete_hair
    before delete
    on hair
    for each row
begin
    delete from favourite where id_hair = OLD.id;
end //

