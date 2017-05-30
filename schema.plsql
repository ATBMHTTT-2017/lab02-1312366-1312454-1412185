connect sys/sa as sysdba
alter session set "_ORACLE_SCRIPT"=true;

CREATE USER BT1N28 IDENTIFIED BY BT1N28;

GRANT CONNECT,RESOURCE,DBA TO BT1N28;

GRANT UNLIMITED TABLESPACE TO BT1N28;
GRANT CREATE SESSION  TO BT1N28;
GRANT CREATE ANY TABLE TO BT1N28;

create table BT1N28.ChiTieu_1312366_1312454_1412185(
    maChiTieu varchar2(20) primary key,
    tenChiTieu varchar2(100),
    soTien varchar2(512),
    duAn varchar2(20) not null
);

create table BT1N28.DuAn_1312366_1312454_1412185(
    maDA varchar2(20) primary key,
    tenDA varchar2(100),
    kinhPhi varchar2(512),
    phongChuTri varchar2(20) not null,
    truongDA varchar2(20) not null
);

create table BT1N28.PhongBan_1312366_1312454_1412185(
    maPhong varchar2(20) primary key,
    tenPhong varchar2(100),
    truongPhong varchar2(100),
    ngayNhanChuc date,
    soNhanVien int,
    chiNhanh varchar2(20)
);

create table BT1N28.PhanCong_1312366_1312454_1412185(
    maNV varchar2(20) not null,
    duAn varchar2(20) not null,
    vaiTro varchar2(100),
    phuCap varchar2(512),
    primary key(maNV,duAn)
);

create table BT1N28.NhanVien_1312366_1312454_1412185(
    maNV varchar2(20) primary key,
    hoTen varchar2(100),
    diaChi varchar2(100),
    dienThoai varchar2(15),
    email varchar2(100),
    maPhong varchar2(20) not null,
    chiNhanh varchar2(20) not null,
    luong varchar2(512)
    
);

create table BT1N28.ChiNhanh_1312366_1312454_1412185(
    maCN varchar2(20) primary key,
    tenCN varchar2(100),
    truongChiNhanh varchar2(20) not null
);

GRANT SELECT , INSERT, UPDATE , DELETE on BT1N28.ChiTieu_1312366_1312454_1412185 TO BT1N28;
GRANT SELECT , INSERT, UPDATE , DELETE on BT1N28.DuAn_1312366_1312454_1412185 TO BT1N28;
GRANT SELECT , INSERT, UPDATE , DELETE on BT1N28.PhanCong_1312366_1312454_1412185 TO BT1N28;
GRANT SELECT , INSERT, UPDATE , DELETE on BT1N28.PhongBan_1312366_1312454_1412185 TO BT1N28;
GRANT SELECT , INSERT, UPDATE , DELETE on BT1N28.ChiNhanh_1312366_1312454_1412185 TO BT1N28;
GRANT SELECT , INSERT, UPDATE , DELETE on BT1N28.NhanVien_1312366_1312454_1412185 TO BT1N28;

/*Thêm các ràng buộc khoá ngoại*/
alter table BT1N28.ChiTieu_1312366_1312454_1412185 add constraint FK_ChiTieu_DuAn foreign key (duAn) references BT1N28.DuAn_1312366_1312454_1412185(maDA);
alter table BT1N28.DuAn_1312366_1312454_1412185 add constraint FK_DuAn_PhongBan foreign key (phongChuTri) references BT1N28.PhongBan_1312366_1312454_1412185(maPhong);
alter table BT1N28.DuAn_1312366_1312454_1412185 add constraint FK_DuAn_NhanVien foreign key (truongDA) references BT1N28.NhanVien_1312366_1312454_1412185(maNV);
alter table BT1N28.PhanCong_1312366_1312454_1412185 add constraint FK_PhanCong_DuAn foreign key (duAn) references BT1N28.DuAn_1312366_1312454_1412185(maDA);
alter table BT1N28.PhanCong_1312366_1312454_1412185 add constraint FK_PhanCong_NhanVien foreign key (maNV) references BT1N28.NhanVien_1312366_1312454_1412185(maNV);
alter table BT1N28.PhongBan_1312366_1312454_1412185 add constraint FK_PhongBan_ChiNhanh foreign key (chiNhanh) references BT1N28.ChiNhanh_1312366_1312454_1412185(maCN);
alter table BT1N28.ChiNhanh_1312366_1312454_1412185 add constraint FK_ChiNhanh_NhanVien foreign key (truongChiNhanh) references BT1N28.NhanVien_1312366_1312454_1412185(maNV);
alter table BT1N28.NhanVien_1312366_1312454_1412185 add constraint FK_NhanVien_ChiNhanh foreign key (chiNhanh) references BT1N28.ChiNhanh_1312366_1312454_1412185(maCN);
alter table BT1N28.NhanVien_1312366_1312454_1412185 add constraint FK_NhanVien_PhongBan foreign key (maPhong) references BT1N28.PhongBan_1312366_1312454_1412185(maPhong);

grant execute on sys.dbms_crypto to BT1N28;

/*Tạm thời vô hiệu hoá khoá chính để thêm dữ liệu*/
alter table BT1N28.ChiTieu_1312366_1312454_1412185 disable constraint FK_ChiTieu_DuAn;
alter table BT1N28.DuAn_1312366_1312454_1412185 disable constraint FK_DuAn_PhongBan;
alter table BT1N28.DuAn_1312366_1312454_1412185 disable constraint FK_DuAn_NhanVien;
alter table BT1N28.PhanCong_1312366_1312454_1412185 disable constraint FK_PhanCong_DuAn;
alter table BT1N28.PhanCong_1312366_1312454_1412185 disable constraint FK_PhanCong_NhanVien;
alter table BT1N28.PhongBan_1312366_1312454_1412185 disable constraint FK_PhongBan_ChiNhanh;
alter table BT1N28.ChiNhanh_1312366_1312454_1412185 disable constraint FK_ChiNhanh_NhanVien;
alter table BT1N28.NhanVien_1312366_1312454_1412185 disable constraint FK_NhanVien_ChiNhanh;
alter table BT1N28.NhanVien_1312366_1312454_1412185 disable constraint FK_NhanVien_PhongBan;

/*Script thêm dữ liệu*/

INSERT INTO BT1N28.PhongBan_1312366_1312454_1412185 (maPhong, tenPhong, truongPhong, ngayNhanChuc, soNhanVien, chiNhanh) VALUES ('P10', 'KeToan', 'nv56', NULL, 18, 'CN1');;
INSERT INTO BT1N28.PhongBan_1312366_1312454_1412185 (maPhong, tenPhong, truongPhong, ngayNhanChuc, soNhanVien, chiNhanh) VALUES ('P11', 'NhanSu', 'nv24', NULL, 6, 'CN3');;
INSERT INTO BT1N28.PhongBan_1312366_1312454_1412185 (maPhong, tenPhong, truongPhong, ngayNhanChuc, soNhanVien, chiNhanh) VALUES ('P12', 'NhanSu', 'nv50', NULL, 8, 'CN2');;
INSERT INTO BT1N28.PhongBan_1312366_1312454_1412185 (maPhong, tenPhong, truongPhong, ngayNhanChuc, soNhanVien, chiNhanh) VALUES ('P13', 'NhanSu', 'nv22', NULL, 7, 'CN1');;
INSERT INTO BT1N28.PhongBan_1312366_1312454_1412185 (maPhong, tenPhong, truongPhong, ngayNhanChuc, soNhanVien, chiNhanh) VALUES ('P14', 'NhanSu', 'nv30', NULL, 12, 'CN2');;
INSERT INTO BT1N28.PhongBan_1312366_1312454_1412185 (maPhong, tenPhong, truongPhong, ngayNhanChuc, soNhanVien, chiNhanh) VALUES ('P15', 'NhanSu', 'nv07', NULL, 18, 'CN1');;
INSERT INTO BT1N28.PhongBan_1312366_1312454_1412185 (maPhong, tenPhong, truongPhong, ngayNhanChuc, soNhanVien, chiNhanh) VALUES ('P16', 'NhanSu', 'nv46', NULL, 8, 'CN3');;
INSERT INTO BT1N28.PhongBan_1312366_1312454_1412185 (maPhong, tenPhong, truongPhong, ngayNhanChuc, soNhanVien, chiNhanh) VALUES ('P17', 'NhanSu', 'nv06', NULL, 1, 'CN1');;
INSERT INTO BT1N28.PhongBan_1312366_1312454_1412185 (maPhong, tenPhong, truongPhong, ngayNhanChuc, soNhanVien, chiNhanh) VALUES ('P18', 'KeToan', 'nv33', NULL, 17, 'CN2');;
INSERT INTO BT1N28.PhongBan_1312366_1312454_1412185 (maPhong, tenPhong, truongPhong, ngayNhanChuc, soNhanVien, chiNhanh) VALUES ('P19', 'KeToan', 'nv54', NULL, 16, 'CN2');;
INSERT INTO BT1N28.PhongBan_1312366_1312454_1412185 (maPhong, tenPhong, truongPhong, ngayNhanChuc, soNhanVien, chiNhanh) VALUES ('P20', 'KeToan', 'nv50', NULL, 5, 'CN2');;
INSERT INTO BT1N28.PhongBan_1312366_1312454_1412185 (maPhong, tenPhong, truongPhong, ngayNhanChuc, soNhanVien, chiNhanh) VALUES ('P21', 'KeToan', 'nv42', NULL, 15, 'CN2');;
INSERT INTO BT1N28.PhongBan_1312366_1312454_1412185 (maPhong, tenPhong, truongPhong, ngayNhanChuc, soNhanVien, chiNhanh) VALUES ('P22', 'KeToan', 'nv18', NULL, 1, 'CN1');;
INSERT INTO BT1N28.PhongBan_1312366_1312454_1412185 (maPhong, tenPhong, truongPhong, ngayNhanChuc, soNhanVien, chiNhanh) VALUES ('P23', 'KeToan', 'nv15', NULL, 15, 'CN2');;
INSERT INTO BT1N28.PhongBan_1312366_1312454_1412185 (maPhong, tenPhong, truongPhong, ngayNhanChuc, soNhanVien, chiNhanh) VALUES ('P24', 'KeHoach', 'nv42', NULL, 8, 'CN1');;
INSERT INTO BT1N28.PhongBan_1312366_1312454_1412185 (maPhong, tenPhong, truongPhong, ngayNhanChuc, soNhanVien, chiNhanh) VALUES ('P25', 'KeToan', 'nv11', NULL, 13, 'CN1');;
INSERT INTO BT1N28.PhongBan_1312366_1312454_1412185 (maPhong, tenPhong, truongPhong, ngayNhanChuc, soNhanVien, chiNhanh) VALUES ('P26', 'KeToan', 'nv58', NULL, 6, 'CN3');;
INSERT INTO BT1N28.PhongBan_1312366_1312454_1412185 (maPhong, tenPhong, truongPhong, ngayNhanChuc, soNhanVien, chiNhanh) VALUES ('P27', 'NhanSu', 'nv37', NULL, 13, 'CN3');;
INSERT INTO BT1N28.PhongBan_1312366_1312454_1412185 (maPhong, tenPhong, truongPhong, ngayNhanChuc, soNhanVien, chiNhanh) VALUES ('P28', 'KeHoach', 'nv33', NULL, 5, 'CN1');;
INSERT INTO BT1N28.PhongBan_1312366_1312454_1412185 (maPhong, tenPhong, truongPhong, ngayNhanChuc, soNhanVien, chiNhanh) VALUES ('P29', 'NhanSu', 'nv49', NULL, 2, 'CN2');;


INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv00', 'DA04', 'Web', '8000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv00', 'DA05', 'Service', '27000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv01', 'DA04', 'Corporate Care', '26000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv01', 'DA05', 'Accounting', '5000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv02', 'DA01', 'Marketing', '4000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv02', 'DA03', 'ConsumerSales', '23000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv03', 'DA01', 'Sales', '22000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv03', 'DA02', 'Technical', '3000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv04', 'DA01', 'Cutomer', '13000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv04', 'DA03', 'Prepaid Customer', '32000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv05', 'DA06', 'Cutomer', '28000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv05', 'DA08', 'Prepaid Customer', '7000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv06', 'DA01', 'Service', '22000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv06', 'DA03', 'Prepaid Customer', '1000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv07', 'DA02', 'Web', '39000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv07', 'DA08', 'Marketing', '20000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv08', 'DA02', NULL, 17000000);
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv08', 'DA08', 'Cutomer', '38000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv09', 'DA06', 'NationalSales', '19000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv09', 'DA08', 'AccessorySales', '38000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv10', 'DA03', 'Service', '32000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv10', 'DA09', 'Accounting', '11000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv11', 'DA05', 'Service', '31000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv12', 'DA01', 'Cutomer', '9000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv12', 'DA02', 'Technical', '30000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv13', 'DA04', 'Prepaid Customer', '13000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv14', 'DA01', 'Corporate Care', '9000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv15', 'DA07', 'Accounting', '34000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv15', 'DA09', 'Marketing', '15000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv16', 'DA02', 'CorporateSales', '8000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv16', 'DA08', 'Sales', '29000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv17', 'DA08', 'Cutomer', '7000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv18', 'DA07', 'Service', '3000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv19', 'DA01', 'Corporate Care', '17000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv20', 'DA02', 'Service', '21000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv20', 'DA08', 'Marketing', '2000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv21', 'DA01', 'Prepaid Customer', '31000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv21', 'DA03', 'Prepaid Customer', '10000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv22', 'DA01', 'Prepaid Customer', '40000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv22', 'DA03', 'Technical', '19000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv23', 'DA06', 'Corporate Care', '6000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv24', 'DA06', 'Service', '1000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv24', 'DA08', 'Cutomer', '20000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv25', 'DA07', 'Technical', '12000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv25', 'DA09', 'Accounting', '33000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv26', 'DA03', 'Cutomer', '18000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv27', 'DA06', 'Corporate Care', '37000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv27', 'DA08', 'Service', '16000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv28', 'DA04', 'Marketing', '4000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv28', 'DA07', 'Marketing', '25000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv29', 'DA04', 'Prepaid Customer', '17000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv29', 'DA05', 'Web', '36000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv30', 'DA01', 'Web', '18000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv30', 'DA02', 'Marketing', '39000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv31', 'DA09', 'Accounting', '19000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv32', 'DA08', 'BusinessSales', '15000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv33', 'DA03', 'Accounting', '5000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv33', 'DA09', 'Marketing', '24000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv34', 'DA07', 'Accounting', '12000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv35', 'DA04', 'Service', '35000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv35', 'DA07', 'Cutomer', '16000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv36', 'DA07', 'Service', '25000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv36', 'DA09', 'Corporate Care', '6000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv37', 'DA05', 'Technical', '36000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv37', 'DA06', 'Corporate Care', '15000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv38', 'DA01', 'Prepaid Customer', '31000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv38', 'DA02', 'Corporate Care', '12000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv39', 'DA03', 'Cutomer', '14000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv39', 'DA09', 'Service', '33000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv40', 'DA03', 'BusinessSales', '1000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv41', 'DA09', 'Service', '2000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv42', 'DA09', 'Prepaid Customer', '11000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv43', 'DA03', 'Marketing', '23000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv43', 'DA09', 'TechnicalSales', '2000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv44', 'DA06', 'Web', '14000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv45', 'DA05', 'Service', '18000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv45', 'DA06', 'Accounting', '37000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv46', 'DA02', 'Technical', '30000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv46', 'DA08', 'Corporate Care', '11000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv47', 'DA06', 'Accounting', '10000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv47', 'DA08', 'Cutomer', '29000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv48', 'DA05', 'Cutomer', '5000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv49', 'DA04', 'Service', '4000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv50', 'DA04', 'Corporate Care', '26000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv50', 'DA07', 'NationalSales', '7000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv51', 'DA04', 'Technical', '35000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv51', 'DA05', 'CorporateSales', '14000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv52', 'DA02', 'Prepaid Customer', '8000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv53', 'DA01', 'Technical', '40000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv53', 'DA02', 'Service', '21000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv54', 'DA04', 'Technical', '13000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv54', 'DA07', 'Service', '34000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv55', 'DA07', 'NationalSales', '3000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv55', 'DA09', 'Marketing', '24000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv56', 'DA05', 'Cutomer', '27000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv56', 'DA06', 'Marketing', '6000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv57', 'DA05', 'Accounting', '9000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv57', 'DA06', 'InternationalSales', '28000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv58', 'DA03', 'Accounting', '10000000');
INSERT INTO BT1N28.PhanCong_1312366_1312454_1412185 (maNV, duAn, vaiTro, phuCap) VALUES ('nv59', 'DA02', 'Technical', '16000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv00', 'Carolina Key', 'Quan 9', '09152483218', 'myuwj.kdcat@bjlsjl.com', 'P13', 'CN1', '19500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv01', 'Janice Rojas', 'Quan 4', '09652412861', 'rppt14@lgeuab.com', 'P15', 'CN3', '22000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv02', 'Rene Ortega', 'Quan 6', '09552956657', 'irxbf.urpuzht@jdqlpk.com', 'P28', 'CN1', '24000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv03', 'Jamie Novak', 'Quan 7', '09234334115', 'gvdq.xbwnowpp@hxfdjqt.efsc-a.org', 'P13', 'CN1', '28000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv04', 'Juliet Landry', 'Quan 4', '09993445487', 'hxzqjwj7@cjduck.org', 'P17', 'CN1', '31000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv05', 'Tammy Davis', 'Quan 2', '09596177487', 'wpgexinh.zggfikpl@vsajca.ocylca.org', 'P26', 'CN2', '25000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv06', 'Rosalind Glover', 'Quan 8', '09272534455', 'jnnw.yopejusfc@-rcnyh.org', 'P20', 'CN3', '2500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv07', 'Marta Evans', 'Quan 4', '09243328646', 'ooog.oodmfrpv@u-asdl.com', 'P19', 'CN1', '20000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv08', 'Daniele Payne', 'Quan 6', '09873458435', 'zuzsest2@hthedyl.pppifl.com', 'P25', 'CN1', '5500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv09', 'Annemarie Johnston', 'Quan 2', '09591735311', 'jnxrl.hamhmkzcw@qfrtrt.net', 'P12', 'CN1', '17500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv10', 'Rosalinda Horn', 'Quan 6', '09264949418', 'wjnlem2@ejmhvgeu.dowbwo.net', 'P15', 'CN3', '25500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv11', 'Carol Dunn', 'Quan 6', '09868942672', 'vfluik.jvklm@qgdbmu.org', 'P13', 'CN2', '16000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv12', 'Anitra Whitehead', 'Quan 7', '09717355877', 'prsjzb.faomwbq@jlkvm.ddcgfp.org', 'P24', 'CN1', '14500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv13', 'Lynnette Chavez', 'Quan 5', '09773525349', 'yxwezrma@ncugvvkc.ceygzh.org', 'P10', 'CN1', '26000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv14', 'Tania Robinson', 'Quan 1', '09991848539', 'tltchn8@ppzrzk.com', 'P14', 'CN3', '12500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv15', 'Rena Tucker', 'Quan 1', '09941494119', 'vaovd.zxciufcymu@eps-vh.org', 'P20', 'CN1', '18500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv16', 'Marina Flores', 'Quan 1', '09843655428', 'roesw54@zrr-pn.com', 'P28', 'CN2', '19000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv17', 'Corey David', 'Quan 6', '09123377621', 'trxsrld.rzmvepvzac@tfdmgrse.ilegis.net', 'P27', 'CN1', '11500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv18', 'Christy Powers', 'Quan 2', '09349783133', 'qjkmzt.dpjyx@fnwenl.net', 'P19', 'CN1', '27000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv19', 'Kathy Ingram', 'Quan 1', '09299921532', 'usckkw.xytpqt@rswt-h.com', 'P20', 'CN1', '4000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv20', 'Trudy Chavez', 'Quan 7', '09996448141', 'sdbaa@flmyncy.josob-.com', 'P21', 'CN1', '3500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv21', 'Layla Farmer', 'Quan 7', '09897173749', 'wpje86@oalri.mjkrsl.net', 'P12', 'CN3', '27500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv22', 'Tracy Young', 'Quan 1', '09365638287', 'blsirf796@gtatmb.com', 'P10', 'CN3', '10000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv23', 'Melonie Potts', 'Quan 6', '09131391881', 'ebfrdgd.fwnvltf@aqgddu.org', 'P16', 'CN2', '29000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv24', 'Marian Solomon', 'Quan 3', '09337582672', 'qsnbdmh.kugt@ytksbf.org', 'P10', 'CN1', '29500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv25', 'Suzette Cordova', 'Quan 8', '09743877676', 'ddhglajj.gqwfxsblor@kuetzsqbo.qjcvao.net', 'P18', 'CN1', '9500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv26', 'Janet Lloyd', 'Quan 6', '09212958724', 'jwczr5@yftbaw.org', 'P12', 'CN1', '2000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv27', 'Glenda Fleming', 'Quan 7', '09822426322', 'yjkys329@zfibs-.com', 'P25', 'CN3', '21000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv28', 'Shelley Aguilar', 'Quan 3', '09994882172', 'dunmheg.hnrhp@nbessnedg.nvfjnk.com', 'P17', 'CN2', '5000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv29', 'Angelita Baldwin', 'Quan 4', '09878671365', 'xifrsb43@sanqyk.aticlv.com', 'P21', 'CN1', '18000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv30', 'Lynette Duke', 'Quan 7', '09381362938', 'xkqmh.vimluriy@fqpsik.net', 'P24', 'CN2', '9000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv31', 'Holly Ramirez', 'Quan 1', '09914542498', 'yptptj.oocglldvv@dysyyxzn.hgikmj.org', 'P26', 'CN2', '17000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv32', 'Ann Johnson', 'Quan 5', '09736196227', 'dfmclz.beigzdzk@eleamk.net', 'P14', 'CN3', '13000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv33', 'Lara Larsen', 'Quan 4', '09841724214', 'fqnc.yypslze@lbyidv.net', 'P23', 'CN3', '7500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv34', 'Geneva Garrett', 'Quan 3', '09598484238', 'pltcia.euxlyoywu@unbgpz.org', 'P19', 'CN1', '6000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv35', 'Tabitha Dickerson', 'Quan 9', '09756566649', 'epbo615@mxaajpxa.iihq-q.net', 'P11', 'CN1', '4500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv36', 'Lee Barber', 'Quan 9', '09528322422', 'sbitqsdp@bucogc.zvcybn.net', 'P23', 'CN2', '14000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv37', 'Sofia Walker', 'Quan 8', '09252975413', 'xkaw.dvjdks@jgqdftn.pcladv.net', 'P27', 'CN3', '8000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv38', 'June Hobbs', 'Quan 3', '09719672557', 'axphpwdd.kgidxl@zmnvlg.com', 'P11', 'CN1', '20500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv39', 'Tomeka Bowen', 'Quan 4', '09437819913', 'mofvutxc.upmtxhcv@prmodj.twnbeq.com', 'P19', 'CN3', '15500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv40', 'Dianna Gilmore', 'Quan 5', '09411577791', 'gxnze843@kikbke.org', 'P21', 'CN3', '30000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv41', 'Julissa Summers', 'Quan 8', '09637484898', 'fsgoxjk0@orpa.evfscm.com', 'P12', 'CN3', '15000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv42', 'Emma Huang', 'Quan 5', '09457566848', 'qgaev@x-idnp.com', 'P25', 'CN2', NULL);
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv43', 'Myrna Melendez', 'Quan 7', '09999353579', 'hbgtpsxr48@uacc.ssaqfj.org', 'P22', 'CN2', '8500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv44', 'Carolina Floyd', 'Quan 3', '09475327557', 'kdiihts267@ddb-lt.org', 'P15', 'CN1', '12000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv45', 'Latosha Rollins', 'Quan 9', '09772791737', 'gdklqb74@bwucxn.zl-pwq.net', 'P29', 'CN3', '23000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv46', 'Nakia Mc Intyre', 'Quan 5', '09186932619', 'lopoer01@ftfapu.org', 'P29', 'CN2', '26500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv47', 'Louise Haas', 'Quan 8', '09569735583', 'qswmhzlb4@pwibby.net', 'P21', 'CN1', '10500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv48', 'Kari Mc Lean', 'Quan 1', '09632785865', 'fbrspiyv.eeceigc@eipyvi.com', 'P21', 'CN1', '7000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv49', 'Sunny Grimes', 'Quan 9', '09489915676', 'zskq60@mgkksv.jfozqf.org', 'P18', 'CN1', '11000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv50', 'Aisha Moyer', 'Quan 4', '09465838697', 'irdqw.xrelhuu@sawgby.net', 'P12', 'CN2', '21500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv51', 'Rosemary Frey', 'Quan 7', '09857983539', 'tbllmfh.rddnktey@tsfbzlwiq.xzuqwe.net', 'P13', 'CN3', '22500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv52', 'Jeana Baldwin', 'Quan 8', '09447339992', 'uidonkk6@zpmpcn.ourjrl.com', 'P20', 'CN1', '24500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv53', 'Destiny Phelps', 'Quan 9', NULL, 'jaemc.ibfh@coffjmqc.ppujf-.org', 'P21', 'CN2', '13500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv54', 'James Phillips', 'Quan 5', '09994373137', 'rqwqquu112@y-bnld.net', 'P24', 'CN2', '3000000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv55', 'Danelle Donovan', 'Quan 7', '09223947471', 'iknmhk70@magdpmdmx.jxxcvp.org', 'P19', 'CN2', '30500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv56', 'Kathrine Hoffman', 'Quan 8', '09143981824', 'jepms51@-hc-zh.org', 'P25', 'CN2', '6500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv57', 'Georgina Jefferson', 'Quan 7', '09248133969', 'slsdf590@cqaaduwdt.xouywv.org', 'P19', 'CN2', '16500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv58', 'Bessie Leon', 'Quan 2', '09188218589', 'rimqfw.dqhcep@lgcnae.net', 'P12', 'CN3', '23500000');
INSERT INTO BT1N28.NhanVien_1312366_1312454_1412185 (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('nv59', 'Demetra Clements', 'Quan 7', '09121678719', 'vkxjeea.mdyc@xxzkvgqpp.ollrt-.net', 'P22', 'CN1', '28500000');
INSERT INTO BT1N28.DuAn_1312366_1312454_1412185 (maDA, tenDA, kinhPhi, phongChuTri, truongDA) VALUES ('DA01', 'Creative + Media', '50000000', 'P23', 'nv06 ');;
INSERT INTO BT1N28.DuAn_1312366_1312454_1412185 (maDA, tenDA, kinhPhi, phongChuTri, truongDA) VALUES ('DA02', 'Business (+ Consumer); Services', '60000000', 'P22', 'nv30 ');;
INSERT INTO BT1N28.DuAn_1312366_1312454_1412185 (maDA, tenDA, kinhPhi, phongChuTri, truongDA) VALUES ('DA03', 'Software + Computer Services Business to Business (B2B);', '40000000', 'P24', 'nv19 ');;
INSERT INTO BT1N28.DuAn_1312366_1312454_1412185 (maDA, tenDA, kinhPhi, phongChuTri, truongDA) VALUES ('DA04', 'Business (+ Consumer); Services', '10000000', 'P12', 'nv44 ');;
INSERT INTO BT1N28.DuAn_1312366_1312454_1412185 (maDA, tenDA, kinhPhi, phongChuTri, truongDA) VALUES ('DA05', 'Food + Drink', '90000000', 'P28', 'nv14 ');;

INSERT INTO BT1N28.DuAn_1312366_1312454_1412185 (maDA, tenDA, kinhPhi, phongChuTri, truongDA) VALUES ('DA07', 'Agriculture, Horticulture + Fisheries', '20000000', 'P27', 'nv29 ');;



INSERT INTO BT1N28.ChiNhanh_1312366_1312454_1412185 (maCN, tenCN, truongChiNhanh) VALUES ('CN1', 'HaNoi', 'nv16 ');;
INSERT INTO BT1N28.ChiNhanh_1312366_1312454_1412185 (maCN, tenCN, truongChiNhanh) VALUES ('CN2', 'DaNang', 'nv31 ');;
INSERT INTO BT1N28.ChiNhanh_1312366_1312454_1412185 (maCN, tenCN, truongChiNhanh) VALUES ('CN3', 'HoChiMinh', 'nv51 ');;


INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT00', 'Chemicals', '6800000', 'DA06 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT01', 'Airports', '9300000', 'DA02 ');

INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT03', 'Aerospace (Civil)', '7100000', 'DA07 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT04', 'Textiles, Interior Textiles + Carpets', '4800000', 'DA06 ');

INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT06', 'Communications', '1800000', 'DA04 ');

INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT08', 'Textiles, Interior Textiles + Carpets', '10000000', 'DA04 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT09', 'Metallurgical Process Plant', '5800000', 'DA01 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT10', 'Business (+ Consumer) Services', '1600000', 'DA05 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT11', 'Food + Drink', '2600000', 'DA04 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT12', 'Food + Drink', '4100000', 'DA07 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT13', 'Financial Services', '2700000', 'DA05 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT14', 'Oil + Gas', '3600000', 'DA06 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT15', 'Railways', '4700000', 'DA04 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT16', 'Chemicals', '7700000', 'DA07 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT17', 'Textiles, Interior Textiles + Carpets', '8600000', 'DA02 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT18', 'Clothing, Footwear + Fashion', '3100000', 'DA07 ');





INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT20', 'Business (+ Consumer) Services', '3300000', 'DA05 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT21', 'Business (+ Consumer) Services', '2400000', 'DA01 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT22', 'Power', '9900000', 'DA06 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT23', 'Oil + Gas', '8700000', 'DA03 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT24', 'Ports + Logistics', '8000000', 'DA01 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT25', 'Software + Computer Services Business to Business (B2B)', '9500000', 'DA05 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT26', 'Airports', '7900000', 'DA05 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT27', 'Biotechnology + Pharmaceuticals', '6600000', 'DA02 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT28', 'Clothing, Footwear + Fashion', '1000000', 'DA08 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT29', 'Food + Drink', '5000000', 'DA03 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT30', 'Household Goods, Furniture + Furnishings', '1100000', 'DA05 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT31', 'Chemicals', '3500000', 'DA07 ');

INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT33', 'Creative + Media', '6200000', 'DA09 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT34', 'Education + Training', '5300000', 'DA09 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT35', 'Metals + Minerals', '8900000', 'DA06 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT36', 'Construction', '2100000', 'DA03 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT37', 'Giftware, Jewellery + Tableware', '9100000', 'DA01 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT38', 'Education + Training', '1300000', 'DA09 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT39', 'Marine', '8100000', 'DA09 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT40', 'Leisure + Tourism', '1600000', 'DA09 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT41', 'Water', '1400000', 'DA04 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT42', 'Oil + Gas', '1700000', 'DA02 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT43', 'Household Goods, Furniture + Furnishings', '5100000', 'DA03 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT44', 'Electronics + IT Hardware', '1500000', 'DA02 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT45', 'Creative + Media', '1500000', 'DA09 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT46', 'Software + Computer Services Business to Business (B2B)', '9400000', 'DA06 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT47', 'Mechanical Electrical + Process Engineering', '3700000', 'DA05 ');

INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT49', 'Education + Training', '1700000', 'DA05 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT50', 'Household Goods, Furniture + Furnishings', '7600000', 'DA06 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT51', 'Aerospace (Civil)', '2900000', 'DA04 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT52', 'Clothing, Footwear + Fashion', '7500000', 'DA04 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT53', 'Leisure + Tourism', '3900000', 'DA07 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT54', 'Communications', '9700000', 'DA07 ');


INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT57', 'Construction', '7800000', 'DA03 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT58', 'Metals + Minerals', '2200000', 'DA03 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT59', 'Chemicals', '2800000', 'DA04 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT60', 'Sports + leisure Infrastructure', '4600000', 'DA09 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT61', 'Fire, Police + Security', '4000000', 'DA03 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT62', 'Airports', '5500000', 'DA01 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT63', 'Mechanical Electrical + Process Engineering', NULL, 'DA02 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT64', 'Electronics + IT Hardware', '7000000', 'DA08 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT65', 'Education + Training', '6500000', 'DA07 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT66', 'Metallurgical Process Plant', '4200000', 'DA07 ');

INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT68', 'Clothing, Footwear + Fashion', '7200000', 'DA02 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT69', 'Creative + Media', '3000000', 'DA01 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT70', 'Metallurgical Process Plant', '1100000', 'DA07 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT71', 'Power', '1200000', 'DA05 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT72', 'Financial Services', '1900000', 'DA06 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT73', 'Construction', '5700000', 'DA06 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT74', 'Fire, Police + Security', '5400000', 'DA01 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT75', 'Mining', '1000000', 'DA04 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT76', 'Food + Drink', '5900000', 'DA08 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT77', 'Chemicals', '6700000', 'DA05 ');


INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT79', 'Metallurgical Process Plant', '2000000', 'DA01 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT80', 'Healthcare + Medical', '4300000', 'DA06 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT81', 'Mechanical Electrical + Process Engineering', '7300000', 'DA06 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT82', 'Food + Drink', '1400000', 'DA06 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT83', 'Textiles, Interior Textiles + Carpets', '9200000', 'DA04 ');

INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT85', 'Aerospace (Civil)', '1300000', 'DA08 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT86', 'Metallurgical Process Plant', '8800000', 'DA04 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT87', 'Construction', '5200000', 'DA06 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT88', 'Automotive', '3200000', 'DA02 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT89', 'Giftware, Jewellery + Tableware', '5600000', 'DA06 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT90', 'Clothing, Footwear + Fashion', '1200000', 'DA03 ');

INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT95', 'Mining', '8500000', 'DA07 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT96', 'Fire, Police + Security', '8200000', 'DA08 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT97', 'Chemicals', '4400000', 'DA03 ');
INSERT into BT1N28.ChiTieu_1312366_1312454_1412185 (maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT98', 'Fire, Police + Security', '2300000', 'DA05 ');

/* Tạo tài khoản và role */
create user nv00 identified by nv00
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 1
create user nv01 identified by nv01 
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 2
create user nv02 identified by nv02 
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 3
create user nv03 identified by nv03 
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 4
create user nv04 identified by nv04 
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 5
create user nv05 identified by nv05 
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 6
create user nv06 identified by nv06 
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 7
create user nv07 identified by nv07 
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 8
create user nv08 identified by nv08 
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 9
create user nv09 identified by nv09
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 10
create user nv10 identified by nv10
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 11
create user nv11 identified by nv11
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 12
create user nv12 identified by nv12
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 13
create user nv13 identified by nv13 
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 14
create user nv14 identified by nv14 
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 15
create user nv15 identified by nv15 
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 16
create user nv16 identified by nv16 
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 17
create user nv17 identified by nv17 
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 18
create user nv18 identified by nv18 
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 19
create user nv19 identified by nv19
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 20
create user nv20 identified by nv20
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 21
create user nv21 identified by nv21
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 22
create user nv22 identified by nv22
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 23
create user nv23 identified by nv23
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 24
create user nv24 identified by nv24
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 25
create user nv25 identified by nv25
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 26
create user nv26 identified by nv26
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 27
create user nv27 identified by nv27
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 28
create user nv28 identified by nv28
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 29
create user nv29 identified by nv29
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 30
create user nv30 identified by nv30
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 31
create user nv31 identified by nv31
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 32
create user nv32 identified by nv32
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 33
create user nv33 identified by nv33
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 34
create user nv34 identified by nv34
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 35
create user nv35 identified by nv35
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 36
create user nv36 identified by nv36
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 37
create user nv37 identified by nv37
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 38
create user nv38 identified by nv38
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 39
create user nv39 identified by nv39
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 40
create user nv40 identified by nv40
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 41
create user nv41 identified by nv41
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 42
create user nv42 identified by nv42
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 43
create user nv43 identified by nv43
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 44
create user nv44 identified by nv44
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 45
create user nv45 identified by nv45
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 46
create user nv46 identified by nv46
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 47
create user nv47 identified by nv47
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 48
create user nv48 identified by nv48
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 49
create user nv49 identified by nv49
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 50
create user nv50 identified by nv50
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 51
create user nv51 identified by nv51
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 52
create user nv52 identified by nv52
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 53
create user nv53 identified by nv53
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 54
create user nv54 identified by nv54
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 55
create user nv55 identified by nv55
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 56
create user nv56 identified by nv56
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 57
create user nv57 identified by nv57
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 58
create user nv58 identified by nv58
default tablespace users
temporary tablespace temp
account unlock;
-- Nhân viên 59
create user nv59 identified by nv59
default tablespace users
temporary tablespace temp
account unlock;


grant create session to nv00;
grant create session to nv01;
grant create session to nv02;
grant create session to nv03;
grant create session to nv04;
grant create session to nv05;
grant create session to nv06;
grant create session to nv07;
grant create session to nv08;
grant create session to nv09;
grant create session to nv10;
grant create session to nv11;
grant create session to nv12;
grant create session to nv13;
grant create session to nv14;
grant create session to nv15;
grant create session to nv16;
grant create session to nv17;
grant create session to nv18;
grant create session to nv19;
grant create session to nv20;
grant create session to nv21;
grant create session to nv22;
grant create session to nv23;
grant create session to nv24;
grant create session to nv25;
grant create session to nv26;
grant create session to nv27;
grant create session to nv28;
grant create session to nv29;
grant create session to nv30;
grant create session to nv31;
grant create session to nv32;
grant create session to nv33;
grant create session to nv34;
grant create session to nv35;
grant create session to nv36;
grant create session to nv37;
grant create session to nv38;
grant create session to nv39;
grant create session to nv40;
grant create session to nv41;
grant create session to nv42;
grant create session to nv43;
grant create session to nv44;
grant create session to nv45;
grant create session to nv46;
grant create session to nv47;
grant create session to nv48;
grant create session to nv49;
grant create session to nv50;
grant create session to nv51;
grant create session to nv52;
grant create session to nv53;
grant create session to nv54;
grant create session to nv55;
grant create session to nv56;
grant create session to nv57;
grant create session to nv58;
grant create session to nv59;

--2 Tao role
create role truong_du_an;
create role truong_chi_nhanh;
create role truong_phong;
create role nhan_vien;
--Cấp role cho nhân viên
--Trưởng dự án
grant truong_du_an to nv06;
grant truong_du_an to nv30;
grant truong_du_an to nv19;
grant truong_du_an to nv44;
grant truong_du_an to nv14;
grant truong_du_an to nv47;
grant truong_du_an to nv29;
grant truong_du_an to nv35;
--Trưởng phòng
grant truong_phong to nv56;
grant truong_phong to nv24;
grant truong_phong to nv50;
grant truong_phong to nv22;
grant truong_phong to nv30;
grant truong_phong to nv07;
grant truong_phong to nv46;
grant truong_phong to nv06;
grant truong_phong to nv33;
grant truong_phong to nv54;
grant truong_phong to nv42;
grant truong_phong to nv18;
grant truong_phong to nv15;
grant truong_phong to nv11;
grant truong_phong to nv58;
grant truong_phong to nv37;
grant truong_phong to nv49;

--Trưởng Chi Nhánh
grant truong_chi_nhanh to nv16;
grant truong_chi_nhanh to nv31;
grant truong_chi_nhanh to nv51;

-- Nhân viên bình thường
grant nhan_vien to nv00;
grant nhan_vien to nv01;
grant nhan_vien to nv02;
grant nhan_vien to nv03;
grant nhan_vien to nv04;
grant nhan_vien to nv05;
grant nhan_vien to nv07;
grant nhan_vien to nv08;
grant nhan_vien to nv09;
grant nhan_vien to nv10;
grant nhan_vien to nv12;
grant nhan_vien to nv13;
grant nhan_vien to nv17;
grant nhan_vien to nv20;
grant nhan_vien to nv21;
grant nhan_vien to nv23;
grant nhan_vien to nv25;
grant nhan_vien to nv26;
grant nhan_vien to nv27;
grant nhan_vien to nv28;
grant nhan_vien to nv32;
grant nhan_vien to nv34;
grant nhan_vien to nv36;
grant nhan_vien to nv38;
grant nhan_vien to nv39;
grant nhan_vien to nv40;
grant nhan_vien to nv41;
grant nhan_vien to nv43;
grant nhan_vien to nv45;
grant nhan_vien to nv48;
grant nhan_vien to nv52;
grant nhan_vien to nv53;
grant nhan_vien to nv55;
grant nhan_vien to nv57;
grant nhan_vien to nv59;

/* Enable lại các constraint */
alter table BT1N28.ChiTieu_1312366_1312454_1412185 enable constraint FK_ChiTieu_DuAn;

alter table BT1N28.DuAn_1312366_1312454_1412185 enable constraint FK_DuAn_PhongBan;
alter table BT1N28.DuAn_1312366_1312454_1412185 enable constraint FK_DuAn_NhanVien;

alter table BT1N28.PhanCong_1312366_1312454_1412185 enable constraint FK_PhanCong_DuAn;
alter table BT1N28.PhanCong_1312366_1312454_1412185 enable constraint FK_PhanCong_NhanVien;

alter table BT1N28.PhongBan_1312366_1312454_1412185 enable constraint FK_PhongBan_ChiNhanh;

alter table BT1N28.ChiNhanh_1312366_1312454_1412185 enable constraint FK_ChiNhanh_NhanVien;

alter table BT1N28.NhanVien_1312366_1312454_1412185 enable constraint FK_NhanVien_ChiNhanh;
alter table BT1N28.NhanVien_1312366_1312454_1412185 enable constraint FK_NhanVien_PhongBan;



