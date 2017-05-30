/*Tạo packet lấy MANV khi NV vừa đăng nhập vào*/
connect sys/sa as sysdba;

GRANT EXECUTE ON DBMS_RLS TO SYSTEM;
GRANT EXECUTE ON DBMS_RLS TO BT1N28;

CREATE OR REPLACE CONTEXT ThongTinNhanVien USING NhanVien_pkg;
CREATE OR REPLACE PACKAGE NhanVien_pkg IS
PROCEDURE GetThongTinNhanVien;
END;
/

CREATE OR REPLACE PACKAGE BODY NhanVien_pkg IS
PROCEDURE GetThongTinNhanVien
AS
tenusername char(100);
tenphong char(100);
tenduan char(100);
BEGIN
tenusername := LOWER(SYS_CONTEXT('USERENV','SESSION_USER'));
DBMS_SESSION.set_context('ThongTinNhanVien','GetUsername',tenusername); 

SELECT distinct MAPHONG into tenphong FROM BT1N28.PHONGBAN_1312366_1312454_1412185 WHERE TRUONGPHONG = 
tenusername;
DBMS_SESSION.set_context('ThongTinNhanVien','GetPhong',tenphong); 

SELECT distinct MADA into tenduan FROM BT1N28.DUAN_1312366_1312454_1412185 
WHERE upper(PHONGCHUTRI) = upper(tenphong);
DBMS_SESSION.set_context('ThongTinNhanVien','GetDuAn',tenduan); 

EXCEPTION
WHEN NO_DATA_FOUND THEN NULL;
END GetThongTinNhanVien;
END;
/

CREATE OR REPLACE TRIGGER Set_ThongTinNhanVien AFTER LOGON ON database 
BEGIN NhanVien_pkg.GetThongTinNhanVien; 
EXCEPTION 
WHEN NO_DATA_FOUND 
THEN 
NULL;
E/ND;


grant execute on NhanVien_pkg to public;
grant execute on GetThongTinNhanVien to public;


/*Tạo function encrypt lương*/
connect BT1N28/BT1N28;

create or replace function encrypt_data_luong(
	data_luong IN VARCHAR2,
	key_manv IN VARCHAR2)
return raw DETERMINISTIC
IS
data_luong_r raw(1024) := utl_raw.cast_to_raw(data_luong);
key_manv_r raw(128) := utl_raw.cast_to_raw(key_manv);
encrypted_data_luong raw(1024);
hash_key raw(128);
BEGIN
    hash_key := dbms_crypto.hash(
			 src => key_manv_r,
			 typ => dbms_crypto.HASH_MD5);
    encrypted_data_luong := dbms_crypto.encrypt(
		src => data_luong_r,
		typ => dbms_crypto.DES_CBC_PKCS5,
		key => hash_key);
	return encrypted_data_luong;
END encrypt_data_luong;
/

create or replace function decrypt_data_luong(
	data_luong IN varchar2,
	key_manv IN VARCHAR2)
return varchar2 DETERMINISTIC
IS
key_manv_r raw(128) := UTL_RAW.cast_to_raw(key_manv);
decrypted_data_luong raw(1024);
manv varchar2(20); 
user_manv raw(128);
hash_key raw(128);
BEGIN
  manv := lower(regexp_replace(SYS_CONTEXT('ThongTinNhanVien', 'GetUsername'), '\W',''));
  user_manv := UTL_RAW.cast_to_raw(manv);
	if (user_manv = key_manv_r)  then
  hash_key := dbms_crypto.hash(
			 src => user_manv,
			 typ => dbms_crypto.HASH_MD5);
	decrypted_data_luong := dbms_crypto.decrypt( 
  src => data_luong, 
  typ => dbms_crypto.DES_CBC_PKCS5, 
  key => hash_key);
	return UTL_RAW.cast_to_varchar2(decrypted_data_luong);
	else
		return data_luong;
	end if;
END decrypt_data_luong;
/

/* Procedure của nhân viên khi muốn xem lương của chính mình */
create or replace procedure Luong_NhanVien (prc out sys_refcursor)
is
key_manv varchar2(128); 
Luong varchar2(1024);
begin
key_manv := lower(regexp_replace(SYS_CONTEXT('ThongTinNhanVien', 'GetUsername'), '\W',''));
open prc for select DECRYPT_DATA_LUONG(LUONG,key_manv) as LUONG from NhanVien_1312366_1312454_1412185 where MANV = key_manv;
end;
/



/* Mã hoá thông tin lương của nhân viên dựa vào MANV của NV đó */
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv00';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv01';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv02';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv03';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv04';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv05';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv06';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv07';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv08';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv09';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv10';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv11';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv12';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv13';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv14';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv15';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv16';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv17';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv18';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv19';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv20';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv21';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv22';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv23';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv24';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv25';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv26';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv27';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv28';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv29';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv30';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv31';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv32';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv33';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv34';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv35';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv36';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv37';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv38';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv39';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv40';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv41';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv42';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv43';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv44';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv45';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv46';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv47';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv48';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv49';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv50';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv51';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv52';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv53';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv54';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv55';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv56';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv57';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv58';
update NhanVien_1312366_1312454_1412185 set LUONG = encrypt_data_luong(LUONG,MANV) where MANV = 'nv59';


grant execute on Luong_NhanVien to public;
grant execute on decrypt_data_luong to public;


/* script để nhân viên có thể xem lương của mình */
variable NhanVien refcursor;
exec BT1N28.Luong_NhanVien(:NhanVien);
print NhanVien;


