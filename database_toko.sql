-- =====================================================
-- DATABASE MBDCS - TOKO
-- Nama : Mawar Pasaribu
-- Mata Kuliah : Manajemen Basis Data Client Server
-- =====================================================


-- =====================================================
-- 1. MEMBUAT DATABASE
-- =====================================================

CREATE DATABASE IF NOT EXISTS toko;

USE toko;


-- =====================================================
-- 2. MEMBUAT TABEL PELANGGAN
-- =====================================================

CREATE TABLE pelanggan (
    ID_Pelanggan INT PRIMARY KEY,
    Nama_Pelanggan VARCHAR(100),
    Kota VARCHAR(50),
    Provinsi VARCHAR(50)
);


-- =====================================================
-- 3. MEMBUAT TABEL PRODUK
-- =====================================================

CREATE TABLE produk (
    ID_Produk INT PRIMARY KEY,
    Nama_Produk VARCHAR(100),
    Kategori VARCHAR(50),
    Harga DECIMAL(12,2)
);


-- =====================================================
-- 4. MEMBUAT TABEL PEMBELIAN
-- =====================================================

CREATE TABLE pembelian (
    ID_Pembelian INT PRIMARY KEY,
    ID_Pelanggan INT,
    ID_Produk INT,
    Tanggal_Pembelian DATE,

    FOREIGN KEY (ID_Pelanggan)
        REFERENCES pelanggan(ID_Pelanggan),

    FOREIGN KEY (ID_Produk)
        REFERENCES produk(ID_Produk)
);


-- =====================================================
-- 5. MEMASUKKAN DATA PELANGGAN
-- =====================================================

INSERT INTO pelanggan
(ID_Pelanggan, Nama_Pelanggan, Kota, Provinsi)
VALUES
(1, 'John', 'Medan', 'Sumatera Utara'),
(2, 'Andi', 'Jakarta', 'DKI Jakarta'),
(3, 'Siti', 'Medan', 'Sumatera Utara'),
(4, 'Budi', 'Bandung', 'Jawa Barat'),
(5, 'Rina', 'Medan', 'Sumatera Utara');


-- =====================================================
-- 6. MEMASUKKAN DATA PRODUK
-- Kategori: Electronics, Fashion, Furniture
-- =====================================================

INSERT INTO produk
(ID_Produk, Nama_Produk, Kategori, Harga)
VALUES
(1, 'Laptop', 'Electronics', 8000000),
(2, 'Mouse', 'Electronics', 150000),
(3, 'Keyboard', 'Electronics', 300000),
(4, 'T-Shirt', 'Fashion', 100000),
(5, 'Jeans', 'Fashion', 350000),
(6, 'Kursi', 'Furniture', 750000);


-- =====================================================
-- 7. MEMASUKKAN 20 DATA DUMMY PEMBELIAN
-- =====================================================

INSERT INTO pembelian
(ID_Pembelian, ID_Pelanggan, ID_Produk, Tanggal_Pembelian)
VALUES
(1, 1, 1, '2026-09-01'),
(2, 2, 2, '2026-09-01'),
(3, 3, 1, '2026-09-02'),
(4, 1, 2, '2026-09-02'),
(5, 4, 4, '2026-09-03'),
(6, 5, 1, '2026-09-03'),
(7, 2, 3, '2026-09-04'),
(8, 3, 2, '2026-09-04'),
(9, 1, 1, '2026-09-05'),
(10, 5, 3, '2026-09-05'),
(11, 2, 4, '2026-09-06'),
(12, 3, 1, '2026-09-06'),
(13, 5, 2, '2026-09-07'),
(14, 1, 3, '2026-09-07'),
(15, 4, 6, '2026-09-08'),
(16, 5, 1, '2026-09-08'),
(17, 2, 5, '2026-09-09'),
(18, 3, 2, '2026-09-09'),
(19, 1, 1, '2026-09-10'),
(20, 5, 3, '2026-09-10');


-- =====================================================
-- 8. QUERY DASAR UNTUK MELIHAT DATA
-- =====================================================

-- Melihat seluruh pelanggan
SELECT * FROM pelanggan;

-- Melihat seluruh produk
SELECT * FROM produk;

-- Melihat seluruh pembelian
SELECT * FROM pembelian;


-- =====================================================
-- 9. QUERY JOIN
-- Menampilkan data pembelian lengkap
-- =====================================================

SELECT
    pelanggan.Nama_Pelanggan,
    pelanggan.Kota,
    produk.Nama_Produk,
    produk.Kategori,
    produk.Harga,
    pembelian.Tanggal_Pembelian
FROM pelanggan
INNER JOIN pembelian
    ON pelanggan.ID_Pelanggan = pembelian.ID_Pelanggan
INNER JOIN produk
    ON pembelian.ID_Produk = produk.ID_Produk;


-- =====================================================
-- 10. QUERY MENCARI PRODUK PALING BANYAK DIBELI
-- TUGAS NOMOR 2
-- =====================================================

SELECT
    produk.Nama_Produk,
    produk.Kategori,
    COUNT(pembelian.ID_Produk) AS Jumlah_Dibeli
FROM produk
INNER JOIN pembelian
    ON produk.ID_Produk = pembelian.ID_Produk
GROUP BY
    produk.ID_Produk,
    produk.Nama_Produk,
    produk.Kategori
ORDER BY Jumlah_Dibeli DESC;


-- =====================================================
-- 11. QUERY MENCARI PRODUK PALING SEDIKIT DIBELI
-- TUGAS NOMOR 3
-- =====================================================

SELECT
    produk.Nama_Produk,
    produk.Kategori,
    COUNT(pembelian.ID_Produk) AS Jumlah_Dibeli
FROM produk
INNER JOIN pembelian
    ON produk.ID_Produk = pembelian.ID_Produk
GROUP BY
    produk.ID_Produk,
    produk.Nama_Produk,
    produk.Kategori
ORDER BY Jumlah_Dibeli ASC;


-- =====================================================
-- 12. QUERY MENCARI KOTA DENGAN PEMBELIAN
-- KATEGORI ELECTRONICS TERBANYAK
-- TUGAS NOMOR 4
-- =====================================================

SELECT
    pelanggan.Kota,
    COUNT(*) AS Jumlah_Pembelian_Electronics
FROM pelanggan
INNER JOIN pembelian
    ON pelanggan.ID_Pelanggan = pembelian.ID_Pelanggan
INNER JOIN produk
    ON pembelian.ID_Produk = produk.ID_Produk
WHERE produk.Kategori = 'Electronics'
GROUP BY pelanggan.Kota
ORDER BY Jumlah_Pembelian_Electronics DESC;