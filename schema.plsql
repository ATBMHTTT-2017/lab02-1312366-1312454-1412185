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
