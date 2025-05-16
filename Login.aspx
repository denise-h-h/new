<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Login.aspx.vb" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script language="javascript" type ="text/javascript">
function startForm(){    
    if (history.length > 0) 
    {
        history.go(+1);
    }
    if (document.getElementById("logName").value.length > 0)
    {
        document.frmLogin.pwd.focus();
    } else {
        document.frmLogin.logName.focus();
    }    
}

function NextField(pField){
    if (window.event.keyCode==13) {
        window.frmLogin(pField).select();
        window.frmLogin(pField).focus();
    }
}

function submitForm(){
    if (window.event.keyCode==13){
        __doPostBack('btnLogin', '');
    }
}

function validate_form()
{    
    var Lname=document.getElementById("<%=logName.ClientID%>").value.toLowerCase()
    var Pwd=document.getElementById("<%=pwd.ClientID%>").value.toLowerCase()
    var chkEmptyL = (document.getElementById("<%=logName.ClientID%>").value.split(" ").join(""))
    var chkEmptyP = (document.getElementById("<%=pwd.ClientID%>").value.split(" ").join(""))
    
    if (chkEmptyL.length == 0)
    {
        alert("Please enter Login Name");
        document.getElementById("<%=logName.ClientID%>").focus();
        return false;
    }
    if (chkEmptyL.length > 0 )
    {
        if (Lname.indexOf("<") >=0 || Lname.indexOf("!") >=0 || Lname.indexOf("text/javascript") >=0 || Lname.indexOf("=") >=0 || 
            Lname.indexOf(">") >=0 || Lname.indexOf("select") >=0 || Lname.indexOf("@") >=0 || Lname.indexOf("?") >=0 ||
            Lname.indexOf(",") >=0 || Lname.indexOf("'") >=0 || Lname.indexOf("*") >=0 || Lname.indexOf("table") >=0 ||
            Lname.indexOf("insert") >=0 || Lname.indexOf("update") >=0 || Lname.indexOf("where") >=0 || Lname.indexOf("#") >=0 ||
            Lname.indexOf("delete") >=0 || Lname.indexOf("drop") >=0)
        {
            alert("Any script type language or symbol is not allowed here, please re-enter");
            document.getElementById("<%=logName.ClientID%>").value = "";
            document.getElementById("<%=logName.ClientID%>").focus();
            return false;
        }
    }   
    if (chkEmptyP.length == 0)
    {
        alert("Please enter Login Password");
        document.getElementById("<%=pwd.ClientID%>").focus();
        return false;
    }  
    if (chkEmptyP.length > 0 )
    {
        if (Pwd.indexOf("<") >=0 || Pwd.indexOf("!") >=0 || Pwd.indexOf("text/javascript") >=0 || Pwd.indexOf("=") >=0 || 
            Pwd.indexOf(">") >=0 || Pwd.indexOf("select") >=0 || Pwd.indexOf("@") >=0 || Pwd.indexOf("?") >=0 || Pwd.indexOf(",") >=0 || 
            Pwd.indexOf("'") >=0 || Pwd.indexOf("*") >=0 || Pwd.indexOf("table") >=0 || Pwd.indexOf("insert") >=0 || Pwd.indexOf("update") >=0 ||
            Pwd.indexOf("where") >=0 || Pwd.indexOf("#") >=0 || Pwd.indexOf("delete") >=0 || Pwd.indexOf("drop") >=0 )
        {
            alert("Any script type language or symbol is not allowed here, please re-enter");
            document.getElementById("<%=pwd.ClientID%>").value = "";
            document.getElementById("<%=pwd.ClientID%>").focus();
            return false;
        }
    }     
    return true;
}

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=big5" />
    <meta http-equiv="content" content="Nationmark. Call Checking System" />
    <meta http-equiv="keywords" content="Hong Kong, China, Asia, IBM, AS/400, solution, hardware, software, maintenance, contingency, backup site, PC, LAN" />
    <meta http-equiv="refresh" content="600" />
    <title>Nationmark. Call Checking System</title>
    <link rel="stylesheet" type="text/css" href="Css/default.css" />
</head>
<body background="images/Bg-0064.jpg" bgcolor="#DECFDD" text="#000000" onload="javascript:startForm();">
    <form id="frmLogin" runat="server">
        <div align="left">
            <center><br />
                <table border="0" cellpadding="0" cellspacing="0" width="640">
                    <tr>
                        <td valign="top" width="469">
                            <h1><b>Nationmark.</b></h1>
                            <h3><u>CALL CHECKING SYSTEM</u></h3>
                        </td>
                        <td width="146">
                            <img src="images/Nmark.gif" border="0" width="144" height="80" />
                        </td>
                    </tr>
                </table>
            </center>
        </div>
        
        <table width="100%" border="0" cellspacing="0" cellpadding="2" align="center" style="FONT-FAMILY: Arial; FONT-SIZE: 10pt">
            <tr> 
                <td colspan="2" align="center" height="17"><font color="ffffff" size="3">User Login</font></td>
            </tr>
            <tr> 
                <td colspan="2" height="36">
                    <div align="center">
                        <font size="3" face="Arial, Helvetica, sans-serif">Please Identify Yourself<br /></font>                        
                    </div>
                </td>
            </tr>           
            <tr> 
                <td width="41%" height="18" > 
                    <div align="right">
                        <font face="Arial,Verdana,Helvetica" size="2" color="#000066"><b>Login Name :</b></font>
                    </div>
                </td>
                <td width="59%" height="18" >
                    <font size="2" face="Arial, Helvetica, sans-serif">
                        <asp:TextBox runat="server" ID="logName" MaxLength="20" onkeypress="javascript:NextField('pwd');"></asp:TextBox>
                    </font></td>
            </tr>
            <tr> 
                <td width="41%" height="8"> 
                    <div align="right">
                        <font face="Arial,Verdana,Helvetica" size="2" color="#000066"><b>Password :</b></font></div>
                </td>
                <td width="59%" height="8" >
                    <font size="2" face="Arial, Helvetica, sans-serif">
                        <asp:TextBox runat="server" ID="pwd" TextMode="Password" MaxLength="20" 
                        onkeypress="javascript:submitForm();"></asp:TextBox>
                    </font></td>
            </tr>
			<tr>
				<td width="41%" height="18" >
				    <div align="right">
				        <font face="Arial,Verdana,Helvetica" size="2" color="#000066"><b>Company :</b></font></div>
				</td>
				<td width="59%" height="8"><font size="2" face="Arial, Helvetica, sans-serif">Nationmark</font></td>
			</tr>				
            <tr>
                <td colspan="2" height="18" align="center">
                    <asp:LinkButton runat="server" ID="btnLogin" Text="Confirm" causesvalidation="false" OnClientClick="return validate_form()" ></asp:LinkButton>&nbsp;&nbsp;
                    <a href="javascript:void(0)" onclick="document.getElementById('frmLogin').reset();">Clear</a>&nbsp;&nbsp;
                    <a href="ChangePassword.aspx">Change Password</a></td>
            </tr> 
                   
        </table>
		<br />
		<br />
		<center>
		<b>Provide by TBR Systems Limited.</b>
		</center>

    </form>
</body>
</html>
