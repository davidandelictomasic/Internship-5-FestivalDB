
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
