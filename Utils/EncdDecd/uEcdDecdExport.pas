unit uEcdDecdExport;

interface

uses SysUtils,RegIntf,RegPluginIntf;

procedure InstallPackage(Reg:IRegistry);//��װ��
procedure UnInstallPackage(Reg:IRegistry);//ж�ذ�
procedure RegisterPlugIn(Reg:IRegPlugin);//ע����

exports
  InstallPackage,
  UnInstallPackage,
  RegisterPlugIn;

implementation

uses MenuRegIntf;

const
  InstallKey='SYSTEM\LOADPACKAGE\UTILS';//����Ҫ�ĳ���Ӧ��KEY
  ValueKey='Package=%s;load=True';

procedure InstallPackage(Reg:IRegistry);
var ModuleFullName,ModuleName,Value:String;
begin
  //ע���
  if Reg.OpenKey(InstallKey,True) then
  begin
    ModuleFullName:=SysUtils.GetModuleName(HInstance);
    ModuleName:=ExtractFileName(ModuleFullName); 
    Value:=Format(ValueKey,[ModuleFullName]); 
    Reg.WriteString(ModuleName,Value);
    Reg.SaveData;
  end;
end;

procedure UnInstallPackage(Reg:IRegistry);
var ModuleName:String;
begin
  //ȡ��ע���
  if Reg.OpenKey(InstallKey) then
  begin
    ModuleName:=ExtractFileName(SysUtils.GetModuleName(HInstance)); 
    if Reg.DeleteValue(ModuleName) then
      Reg.SaveData;
  end;
end;

procedure RegisterPlugIn(Reg:IRegPlugin);
begin
  //����ע����(TPlugin)��...
end;


initialization

finalization

end.