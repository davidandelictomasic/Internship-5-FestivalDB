
CREATE TABLE festival (
    festival_id SERIAL PRIMARY KEY,
    naziv VARCHAR(100) NOT NULL,
    grad VARCHAR(100) NOT NULL,
    kapacitet_posjetitelja INT NOT NULL,
    datum_pocetka DATE NOT NULL,
    datum_zavrsetka DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    ima_kamp BOOLEAN DEFAULT FALSE
);
CREATE TABLE pozornica (
    pozornica_id SERIAL PRIMARY KEY,
    festival_id INT NOT NULL REFERENCES festival(festival_id),
    naziv VARCHAR(100) NOT NULL,
    lokacija_unutar_festivala VARCHAR(50),
    max_kapacitet INT NOT NULL,
    natkrivena BOOLEAN DEFAULT FALSE
);
CREATE TABLE izvodjac (
    izvodjac_id SERIAL PRIMARY KEY,
    naziv VARCHAR(100) NOT NULL,
    drzava VARCHAR(100),
    zanr VARCHAR(50),
    broj_clanova INT,
    aktivan BOOLEAN DEFAULT TRUE
);
CREATE TABLE nastup (
    nastup_id SERIAL PRIMARY KEY,
    festival_id INT NOT NULL REFERENCES festival(festival_id),
    pozornica_id INT NOT NULL REFERENCES pozornica(pozornica_id),
    izvodjac_id INT NOT NULL REFERENCES izvodjac(izvodjac_id),
    vrijeme_pocetka TIMESTAMP NOT NULL,
    vrijeme_zavrsetka TIMESTAMP NOT NULL,
    ocekivani_broj_posjetitelja INT
);
CREATE TABLE posjetitelj (
    posjetitelj_id SERIAL PRIMARY KEY,
    ime VARCHAR(100) NOT NULL,
    prezime VARCHAR(100) NOT NULL,
    datum_rodenja DATE NOT NULL,
    grad VARCHAR(100),
    email VARCHAR(150),
    drzava VARCHAR(100)
);
CREATE TABLE ulaznica (
    ulaznica_id SERIAL PRIMARY KEY,
    tip VARCHAR(50) NOT NULL,
    cijena NUMERIC(10,2) NOT NULL,
    opis TEXT,
    vrijedi_za VARCHAR(50)
);
CREATE TABLE narudzba (
    narudzba_id SERIAL PRIMARY KEY,
    posjetitelj_id INT NOT NULL REFERENCES posjetitelj(posjetitelj_id),
    festival_id INT NOT NULL REFERENCES festival(festival_id),
    datum_vrijeme_kupnje TIMESTAMP NOT NULL,
    ukupan_iznos NUMERIC(10,2) NOT NULL
);
CREATE TABLE stavka_narudzbe (
    stavka_id SERIAL PRIMARY KEY,
    narudzba_id INT NOT NULL REFERENCES narudzba(narudzba_id),
    ulaznica_id INT NOT NULL REFERENCES ulaznica(ulaznica_id),
    kolicina INT NOT NULL,
    cijena_po_komadu NUMERIC(10,2) NOT NULL
);