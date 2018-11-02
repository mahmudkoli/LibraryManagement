<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student.aspx.cs" Inherits="LibraryManagement.Librarian.Student" %>

<%@ Register Src="~/controller/menu.ascx" TagPrefix="uc1" TagName="menu" %>
<%@ Register Src="~/controller/header.ascx" TagPrefix="uc1" TagName="header" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Library Management System</title>
    <link href="../css/bootstrap.css" rel="stylesheet" />
    <link href="../css/style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <uc1:menu runat="server" ID="menu" />
        <uc1:header runat="server" ID="header" />

        <div class="container">
            <div class="row">
                <div class="col-md-4 col-sm-4 col-12">
                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-primary mouseHover" data-toggle="modal" data-target="#modalAddStd">
                        Add New Student
                    </button>
                </div>
                <div class="col-md-4 col-sm-2 col-12">
                </div>
                <div class="col-md-4 col-sm-6 col-12">
                    <div class="input-group">
                        <asp:TextBox ID="txtSearchStudent" runat="server" CssClass="form-control" placeholder="Search"></asp:TextBox>
                        <span class="input-group-btn">
                            <asp:Button ID="btnSearchStudent" runat="server" CssClass="btn btn-primary mouseHover" Text="Search" OnClick="btnSearchStudent_Click" />
                        </span>
                    </div>
                </div>
            </div>
        </div><br />

        <%-- Student Report on Gridview Start --%>
        <asp:UpdatePanel ID="upGVStdReport" runat="server">
            <ContentTemplate>
                <div class="container">
                    <div class="row">
                        <div class="col-12 text-center text-info">
                            <h3>Student Report</h3>
                            <asp:GridView ID="gvStdReport" runat="server" CssClass="table table-striped table-inverse"
                                AutoGenerateColumns="false" AllowSorting="true" AllowPaging="true" OnSorting="gvStdReport_Sorting"
                                OnPageIndexChanging="gvStdReport_PageIndexChanging" EnableSortingAndPagingCallbacks="true" Visible="true"
                                DataKeyNames="Id" OnRowCommand="gvStdReport_RowCommand" OnRowDataBound="gvStdReport_RowDataBound"
                                HorizontalAlign="Center" HeaderStyle-ForeColor="#007ACC">
                                <Columns>
                                    <asp:TemplateField HeaderText="Image" HeaderStyle-CssClass="text-center">
                                        <ItemTemplate>
                                            <asp:Image ID="gvImgStd" CssClass="img-fluid" ImageUrl='<%# Eval("ImageLocation") %>' Width="50px" Height="50px" runat="server" />
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="text-center" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Id" HeaderText="ID" SortExpression="Id" HeaderStyle-CssClass="text-center" >
                                    <HeaderStyle CssClass="text-center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" HeaderStyle-CssClass="text-center" >
                                    <HeaderStyle CssClass="text-center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" HeaderStyle-CssClass="text-center" >
                                    <HeaderStyle CssClass="text-center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Mobile" HeaderText="Mobile" SortExpression="Mobile" HeaderStyle-CssClass="text-center" >
                                    <HeaderStyle CssClass="text-center" />
                                    </asp:BoundField>
                                    <asp:ButtonField CommandName="detailsStd" ControlStyle-CssClass="btn btn-info mouseHover" HeaderStyle-CssClass="text-center"
                                        ButtonType="Button" Text="Details" HeaderText="Detailed">
                                        <ControlStyle CssClass="btn btn-info mouseHover"></ControlStyle>
                                    <HeaderStyle CssClass="text-center" />
                                    </asp:ButtonField>
                                    <asp:ButtonField CommandName="editStd" ControlStyle-CssClass="btn btn-info mouseHover" HeaderStyle-CssClass="text-center"
                                        ButtonType="Button" Text="Edit" HeaderText="Edit">
                                        <ControlStyle CssClass="btn btn-info mouseHover"></ControlStyle>
                                    <HeaderStyle CssClass="text-center" />
                                    </asp:ButtonField>
                                    <asp:ButtonField CommandName="deleteStd" ControlStyle-CssClass="btn btn-danger mouseHover" HeaderStyle-CssClass="text-center"
                                        ButtonType="Button" Text="Delete" HeaderText="Delete">
                                        <ControlStyle CssClass="btn btn-danger mouseHover"></ControlStyle>
                                    <HeaderStyle CssClass="text-center" />
                                    </asp:ButtonField>
                                </Columns>
                                <HeaderStyle ForeColor="#007ACC" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
            </Triggers>
        </asp:UpdatePanel>
        <%-- Student Report on Gridview End --%>

        <%-- Add Student Start --%>
        <!-- Modal -->
        <asp:UpdatePanel ID="upPnlAddStd" runat="server">
            <ContentTemplate>
                <div class="modal fade" id="modalAddStd" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title font-weight-bold text-primary" id="modalAddStdTitle">Add New Student</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Name :<span class="text-danger font-weight-bold">*</span></div>
                                        <div class="col-8">
                                            <asp:TextBox ID="txtAddStdName" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="txtAddStdName" SetFocusOnError="True" ValidationGroup="AddStudent"
                                                Display="Dynamic"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Email :<span class="text-danger font-weight-bold">*</span></div>
                                        <div class="col-8">
                                            <asp:TextBox ID="txtAddStdEmail" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="txtAddStdEmail" SetFocusOnError="True" ValidationGroup="AddStudent"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="invalid email"
                                                ControlToValidate="txtAddStdEmail" SetFocusOnError="true" ValidationGroup="AddStudent" CssClass="text-danger" Display="Dynamic"
                                                ValidationExpression="\s*\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*\s*"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Mobile :<span class="text-danger font-weight-bold">*</span></div>
                                        <div class="col-8">
                                            <asp:TextBox ID="txtAddStdMobile" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="txtAddStdMobile" SetFocusOnError="True" ValidationGroup="AddStudent"
                                                Display="Dynamic"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Branch :<span class="text-danger font-weight-bold">*</span></div>
                                        <div class="col-8">
                                            <asp:DropDownList ID="ddlAddStdBranch" CssClass="form-control" runat="server">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="ddlAddStdBranch" SetFocusOnError="true" InitialValue="-1" ValidationGroup="AddStudent"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Gender :<span class="text-danger font-weight-bold">*</span></div>
                                        <div class="col-8">
                                            <asp:DropDownList ID="ddlAddStdGender" CssClass="form-control" runat="server">
                                                <asp:ListItem Value="-1" Selected="True">Select Gender</asp:ListItem>
                                                <asp:ListItem Value="male">Male</asp:ListItem>
                                                <asp:ListItem Value="female">Female</asp:ListItem>
                                                <asp:ListItem Value="others">Others</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="ddlAddStdGender" SetFocusOnError="true" InitialValue="-1" ValidationGroup="AddStudent"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Birth Date :<span class="text-danger font-weight-bold">*</span></div>
                                        <div class="col-8">
                                            <div class="form-inline">
                                                <asp:DropDownList ID="ddlAddStdBirthDay" CssClass="form-control" runat="server">
                                                    <asp:ListItem Value="-1" Selected="True">Day</asp:ListItem>
                                                </asp:DropDownList>&nbsp;
                                            <asp:DropDownList ID="ddlAddStdBirthMonth" CssClass="form-control" runat="server">
                                                <asp:ListItem Value="-1" Selected="True">Month</asp:ListItem>
                                            </asp:DropDownList>&nbsp;
                                            <asp:DropDownList ID="ddlAddStdBirthYear" CssClass="form-control" runat="server">
                                                <asp:ListItem Value="-1" Selected="True">Year</asp:ListItem>
                                            </asp:DropDownList>
                                            </div>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="ddlAddStdBirthDay" SetFocusOnError="True" ValidationGroup="AddStudent" InitialValue="-1"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="ddlAddStdBirthMonth" SetFocusOnError="True" ValidationGroup="AddStudent" InitialValue="-1"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="ddlAddStdBirthYear" SetFocusOnError="True" ValidationGroup="AddStudent" InitialValue="-1"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Address :<span class="text-danger font-weight-bold">*</span></div>
                                        <div class="col-8">
                                            <asp:TextBox ID="txtAddStdAddress" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="txtAddStdAddress" SetFocusOnError="True" ValidationGroup="AddStudent"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">City :</div>
                                        <div class="col-8">
                                            <asp:TextBox ID="txtAddStdCity" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Zip Code :<span class="text-danger  font-weight-bold">*</span></div>
                                        <div class="col-8">
                                            <asp:TextBox ID="txtAddStdZipCode" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="txtAddStdZipCode" SetFocusOnError="True" ValidationGroup="AddStudent"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="invalid" CssClass="text-danger"
                                                ControlToValidate="txtAddStdZipCode" SetFocusOnError="true" ValidationGroup="AddStudent"
                                                Display="Dynamic" Type="Integer" Operator="DataTypeCheck"></asp:CompareValidator>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Photo :<span class="text-danger font-weight-bold">*</span></div>
                                        <div class="col-8">
                                            <asp:FileUpload ID="fileAddStdPhoto" runat="server" />
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="fileAddStdPhoto" SetFocusOnError="True" ValidationGroup="AddStudent"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="invalid format"
                                                ControlToValidate="fileAddStdPhoto" SetFocusOnError="true" ValidationGroup="AddStudent" CssClass="text-danger"
                                                Display="Dynamic" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))+(.jpeg|.JPEG|.png|.PNG|.JPG|.jpg)$"></asp:RegularExpressionValidator>
                                            <br />
                                            <span class="text-info">Image size should be maximum 2 MB & Format .jpg | .jepg | .png</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <asp:Button ID="btnAddStdSave" runat="server" CssClass="btn btn-primary mouseHover" ValidationGroup="AddStudent" Text="Save" OnClick="btnAddStdSave_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnAddStdSave" />
            </Triggers>
        </asp:UpdatePanel>
        <%-- Add Student End --%>

        <%-- Student Details Start --%>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div class="modal fade" id="modalStdDetails" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title text-info" id="modalStdDetailsTitle">Student Details</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-md-5 col-sm-5 col-12">
                                            <asp:Image ID="imgStdDetailsImage" CssClass="img-thumbnail" Width="150px" Height="180px" AlternateText="Student Image" runat="server" />
                                        </div>
                                        <div class="col-md-7 col-sm-7 col-12">
                                            <h3>
                                                <asp:Label ID="lblStdDetailsName" runat="server" Text="" CssClass="text-primary"></asp:Label></h3>
                                        </div>
                                    </div>
                                    <hr style="border-color: #563D7C; border-width: 3px" />
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-5">
                                            <h6>ID :</h6>
                                        </div>
                                        <div class="col-7">
                                            <asp:Label ID="lblStdDetailsId" runat="server" Text="" CssClass=""></asp:Label>
                                        </div>
                                    </div>
                                    <hr />
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-5">
                                            <h6>Email :</h6>
                                        </div>
                                        <div class="col-7">
                                            <asp:Label ID="lblStdDetailsEmail" runat="server" Text="" CssClass=""></asp:Label>
                                        </div>
                                    </div>
                                    <hr />
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-5">
                                            <h6>Mobile :</h6>
                                        </div>
                                        <div class="col-7">
                                            <asp:Label ID="lblStdDetailsMobile" runat="server" Text="" CssClass=""></asp:Label>
                                        </div>
                                    </div>
                                    <hr />
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-5">
                                            <h6>Password :</h6>
                                        </div>
                                        <div class="col-7">
                                            <asp:Label ID="lblStdDetailsPassword" runat="server" Text="" CssClass=""></asp:Label>
                                        </div>
                                    </div>
                                    <hr />
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-5">
                                            <h6>Branch :</h6>
                                        </div>
                                        <div class="col-7">
                                            <asp:Label ID="lblStdDetailsBranch" runat="server" Text="" CssClass=""></asp:Label>
                                        </div>
                                    </div>
                                    <hr />
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-5">
                                            <h6>Birthdate :</h6>
                                        </div>
                                        <div class="col-7">
                                            <asp:Label ID="lblStdDetailsBirthdate" runat="server" Text="" CssClass=""></asp:Label>
                                        </div>
                                    </div>
                                    <hr />
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-5">
                                            <h6>Address :</h6>
                                        </div>
                                        <div class="col-7">
                                            <asp:Label ID="lblStdDetailsAddress" runat="server" Text="" CssClass=""></asp:Label>
                                        </div>
                                    </div>
                                    <hr />
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-5">
                                            <h6>City :</h6>
                                        </div>
                                        <div class="col-7">
                                            <asp:Label ID="lblStdDetailsCity" runat="server" Text="" CssClass=""></asp:Label>
                                        </div>
                                    </div>
                                    <hr />
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-5">
                                            <h6>Zip Code :</h6>
                                        </div>
                                        <div class="col-7">
                                            <asp:Label ID="lblStdDetailsZipCode" runat="server" Text="" CssClass=""></asp:Label>
                                        </div>
                                    </div>
                                    <hr />
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-5">
                                            <h6>Joining Date :</h6>
                                        </div>
                                        <div class="col-7">
                                            <asp:Label ID="lblStdDetailsJoinDate" runat="server" Text="" CssClass=""></asp:Label>
                                        </div>
                                    </div>
                                    <hr />
                                </div>

                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
            </Triggers>
        </asp:UpdatePanel>

        <%-- Student Details End --%>

        <%-- Student Edit Start --%>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <div class="modal fade" id="modalStdEdit" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title text-info" id="modalStdEditTitle">Edit Student Data</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">ID :</div>
                                        <div class="col-8">
                                            <asp:Label ID="lblUpStdId" runat="server" Text=""></asp:Label>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Email :</div>
                                        <div class="col-8">
                                            <asp:Label ID="lblUpStdEmail" runat="server" Text=""></asp:Label>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Name :<span class="text-danger font-weight-bold">*</span></div>
                                        <div class="col-8">
                                            <asp:TextBox ID="txtUpStdName" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="txtUpStdName" SetFocusOnError="True" ValidationGroup="UpStudent"
                                                Display="Dynamic"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Mobile :<span class="text-danger font-weight-bold">*</span></div>
                                        <div class="col-8">
                                            <asp:TextBox ID="txtUpStdMobile" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="txtUpStdMobile" SetFocusOnError="True" ValidationGroup="UpStudent"
                                                Display="Dynamic"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Branch :<span class="text-danger font-weight-bold">*</span></div>
                                        <div class="col-8">
                                            <asp:DropDownList ID="ddlUpStdBranch" CssClass="form-control" runat="server">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="ddlUpStdBranch" SetFocusOnError="true" InitialValue="-1" ValidationGroup="UpStudent"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Address :<span class="text-danger font-weight-bold">*</span></div>
                                        <div class="col-8">
                                            <asp:TextBox ID="txtUpStdAddress" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="txtUpStdAddress" SetFocusOnError="True" ValidationGroup="UpStudent"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">City :</div>
                                        <div class="col-8">
                                            <asp:TextBox ID="txtUpStdCity" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Zip Code :<span class="text-danger  font-weight-bold">*</span></div>
                                        <div class="col-8">
                                            <asp:TextBox ID="txtUpStdZipcode" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="txtUpStdZipcode" SetFocusOnError="True" ValidationGroup="UpStudent"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="CompareValidator2" runat="server" ErrorMessage="invalid" CssClass="text-danger"
                                                ControlToValidate="txtUpStdZipcode" SetFocusOnError="true" ValidationGroup="UpStudent"
                                                Display="Dynamic" Type="Integer" Operator="DataTypeCheck"></asp:CompareValidator>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Photo :</div>
                                        <div class="col-8">
                                            <asp:FileUpload ID="fileUpStdPhoto" runat="server" />
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="invalid format"
                                                ControlToValidate="fileUpStdPhoto" SetFocusOnError="true" ValidationGroup="UpStudent" CssClass="text-danger"
                                                Display="Dynamic" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))+(.jpeg|.JPEG|.png|.PNG|.JPG|.jpg)$"></asp:RegularExpressionValidator>
                                            <br />
                                            <span class="text-info">Image size should be maximum 2 MB & Format .jpg | .jepg | .png</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <asp:Button ID="btnUpStdSave" runat="server" CssClass="btn btn-primary mouseHover" ValidationGroup="UpStudent" Text="Update" OnClick="btnUpStdSave_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnUpStdSave" />
            </Triggers>
        </asp:UpdatePanel>
        <%-- Student Edit End --%>

        <%-- Student Delete Start --%>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <div class="modal fade" id="modalStdDelete" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title text-info" id="modalStdDeleteTitle">Delete Student Data</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <span>Are you sure you want to
                                    <asp:Label ID="lblStdDeleteName" runat="server" CssClass="text-danger" Text=""></asp:Label>'s data delete ?</span>
                                <asp:HiddenField ID="hfStdDeleteId" runat="server" />
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                <asp:Button ID="btnStdDeleteData" runat="server" Text="Confirm" CssClass="btn btn-danger mouseHover" OnClick="btnStdDeleteData_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
            </Triggers>
        </asp:UpdatePanel>
        <%-- Student Delete End --%>
    </form>
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>--%>
    <script src="../js/popper-1.11.0.min.js"></script>
    <script src="../js/jquery-3.2.1.js"></script>
    <script src="../js/footable.js"></script>
    <script type="text/javascript">
        $(function () {
            $('#<%=gvStdReport.ClientID %>').footable({
                breakpoints: {
                    phone: 300,
                    tablet: 640
                }
            });
        });
    </script>
    <script src="../js/bootstrap.js"></script>
</body>
</html>
