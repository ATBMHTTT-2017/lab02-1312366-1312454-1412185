create or replace context NhanVien_context using Nhanvien_context_pak;
create or replace package Nhanvien_context_pak
as
  procedure DuAnQuanLy;
end;
/
create or replace package body Nhanvien_context_pak
as
  procedure DuAnQuanLy
  as
    DA table;
  begin
    dbms_session.set_context('NhanVien_context','DuAnQL','DA00');
    select MADA
    into DA
    from BT1N28.DUAN_366_454_185
    where DUAN_366_454_185.TRUONGDA=sys_context('userenv','SESSION_USER');
    dbms_session.set_context('NhanVien_context','DuAnQL',DA);
  end;
end;
  
create or replace trigger DuAnQuanLy_trg after logon on database
  begin
  BT1N28.Nhanvien_context_pak.DuAnQuanLy;
  end;

create or replace Package ThongTinNhanVien_Policy_pak
as
  function ChiTieuDuAn_Policy(D1 varchar2,d2 varchar2 ) return varchar2;
end;
/
create or replace Package body ThongTinNhanVien_Policy_pak
as
  function ChiTieuDuAn_Policy(D1 varchar2,d2 varchar2 ) return varchar2
  as
  predicate varchar(2000);
  begins
    predicate:='ChiTieu_366_454_185.duAn=sys_context(''NhanVien_context'',''DuAnQL'')';
    return predicate;
  end;  
end;

execute DBMS_RLS.ADD_POLICY(OBJECT_SCHEMA => 'BT1N28',OBJECT_NAME => 'CHITIEU_366_454_185',POLICY_NAME => 'ChiTieuDuAn_Policy' ,FUNCTION_SCHEMA => 'BT1N28' ,POLICY_FUNCTION => 'ThongTinNhanVien_Policy_pak.ChiTieuDuAn_Policy',STATEMENT_TYPES => 'select,insert,update', POLICY_TYPE =>DBMS_RLS.DYNAMIC);
