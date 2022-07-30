Criar o banco:
CREATE DATABASE pratica_modelagem;

Criar a tabela states:
CREATE TABLE states(
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL
);

Criar a tabela cities:
CREATE TABLE cities(
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	"stateId" INTEGER NOT NULL REFERENCES states (id)
);

Criar a tabela customers:
CREATE TABLE customers(
	id SERIAL NOT NULL PRIMARY KEY,
	"fullName" TEXT NOT NULL,
	cpf VARCHAR(11) NOT NULL UNIQUE,
	email TEXT NOT NULL UNIQUE,
	password TEXT NOT NULL
);

Criar a tabela customerAddresses:
CREATE TABLE "customerAddresses"(
	id SERIAL NOT NULL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES customers (id),
	street TEXT NOT NULL,
	number INTEGER NOT NULL,
	complement TEXT,
	"postalCode" VARCHAR(8) NOT NULL,
	"cityId" INTEGER NOT NULL REFERENCES cities (id)
);

Criar a tabela customerPhones:
CREATE TABLE "customerPhones"(
	id SERIAL NOT NULL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES customers (id),
	number TEXT NOT NULL UNIQUE,
	type TEXT NOT NULL CHECK(type = 'landline' OR type = 'mobile')
);

Criar a tabela bankAccount:
CREATE TABLE "bankAccount"(
	id SERIAL NOT NULL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES customers (id),
	"accountNumber" TEXT NOT NULL,
	agency TEXT NOT NULL,
	"openDate" TIMESTAMP NOT NULL DEFAULT NOW(),
	"closeDate" TIMESTAMP DEFAULT NULL
);

Criar a tabela transactions:
CREATE TABLE transactions(
	id SERIAL NOT NULL PRIMARY KEY,
	"bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount" (id),
	amount INTEGER NOT NULL,
	type TEXT NOT NULL CHECK(type = 'deposit' OR type = 'withdraw'),
	description TEXT NOT NULL,
	cancelled TEXT NOT NULL
);

Criar a tabela creditCards:
CREATE TABLE "creditCards"(
	id SERIAL NOT NULL PRIMARY KEY,
	"bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount" (id),
	name TEXT NOT NULL,
	number TEXT NOT NULL,
	"securityCode" TEXT NOT NULL,
	"expirationMonth" INTEGER NOT NULL,
	"expirationYear" INTEGER NOT NULL,
	password TEXT NOT NULL,
	"limit" INTEGER NOT NULL
);
