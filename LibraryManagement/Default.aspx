<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LibraryManagement.Default" %>

<%@ Register Src="~/controller/header.ascx" TagPrefix="uc1" TagName="header" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Library Management System</title>
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="../css/style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <uc1:header runat="server" id="header" />
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-4 col-sm-3 col-12">
                </div>
                <div class="col-md-4 col-sm-6 col-12 LoginBackground">
                        <div class="form-group text-center text-dark">
                            <h3>Login</h3>
                        </div>
                        <div class="form-group">
                            <h5><label for="exampleInputEmail1">Email</label></h5>
                            <asp:TextBox ID="txtUserEmail" runat="server" CssClass="form-control" placeholder="Enter email"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <h5><label for="exampleInputPassword1">Password</label></h5>
                            <asp:TextBox ID="txtUserPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter password"></asp:TextBox>
                        </div>
                        <div class="form-check form-check-inline">
                            <label class="form-check-label">
                                <asp:RadioButton ID="rdLibrarian" runat="server" CssClass="form-check-input" Text="" GroupName="UserIdentity" />&nbsp;Librarian
                            </label>&nbsp;&nbsp;
                            <label class="form-check-label">
                                <asp:RadioButton ID="rdStudent" runat="server" CssClass="form-check-input" Text="" GroupName="UserIdentity" />&nbsp;Student
                            </label>
                          </div>
                          <div class="form-check">
                            <label class="form-check-label">
                                <asp:CheckBox ID="ckRemember" runat="server" CssClass="form-check-input" />&nbsp;Remember me
                            </label>
                          </div>
                        <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary mouseHover" Text="Login" OnClick="btnLogin_Click" />
                </div>
                <div class="col-md-4 col-sm-3 col-12">
                </div>
            </div>
        </div>
    </form>
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>
