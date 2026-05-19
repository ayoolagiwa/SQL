create table car (
	car_uid UUID NOT NULL PRIMARY KEY,
	make VARCHAR(100) NOT NULL,
	model VARCHAR(100) NOT NULL,
	price NUMERIC(19, 2) NOT NULL CHECK (price > 0 )
);

create table person (
	person_uid UUID NOT NULL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	gender VARCHAR(7) NOT NULL,
	email VARCHAR(100),
	date_of_birth DATE NOT NULL,
	country_of_birth VARCHAR(50) NOT NULL,
    car_uid UUID REFERENCES car(car_uid), UNIQUE(car_uid), UNIQUE(email)
);


insert into person (person_uid, first_name, last_name, gender, email, date_of_birth, country_of_birth)
values (uuid_generate_v4(), 'Jacob', 'Bazire', 'Male', 'jaccobbazire0@toplist.cz', '10/5/1986', 'Russia');

insert into person (person_uid, first_name, last_name, gender, email, date_of_birth, country_of_birth)
values (uuid_generate_v4(), 'Harman', 'Pedrocco', 'Male', null, '10/14/1992', 'China');

insert into person (person_uid, first_name, last_name, gender, email, date_of_birth, country_of_birth)
values (uuid_generate_v4(), 'Lorry', 'Caswall', 'Male', null, '2/4/1993', 'China');


insert into car (car_uid, make, model, price) values (uuid_generate_v4(), 'BMW', '5 Series', 4229613.57);
insert into car (car_uid, make, model, price) values (uuid_generate_v4(), 'Ford', 'Festiva', 3488142.0);
