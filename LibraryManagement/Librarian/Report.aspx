<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="LibraryManagement.Librarian.Report" %>

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
        <uc1:menu runat="server" ID="menu" />
        <uc1:header runat="server" ID="header" />

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2 col-sm-4 col-12">
                    <div class="list-group" id="list-tab" role="tablist">
                        <a class="list-group-item list-group-item-action active" id="studentReportList" data-toggle="list" href="#studentReport" role="tab">Student Report</a>
                        <a class="list-group-item list-group-item-action" id="bookReportList" data-toggle="list" href="#bookReport" role="tab">Book Report</a>
                        <a class="list-group-item list-group-item-action" id="issueBookList" data-toggle="list" href="#issueBook" role="tab">Issue Book</a>
                        <a class="list-group-item list-group-item-action" id="returnBookList" data-toggle="list" href="#returnBook" role="tab">Return Book</a>
                        <a class="list-group-item list-group-item-action" id="issueReportList" data-toggle="list" href="#issueReport" role="tab">Issue Report</a>
                    </div>
                </div>
                <div class="col-md-10 col-sm-8 col-12">
                    <div class="tab-content" id="nav-tabContent">

                        <!-- Student Report Start -->
                        <div class="tab-pane fade show active" id="studentReport" role="tabpanel">
                            <div class="row">
                                <div class="col-md-4 col-sm-3 col-12"></div>
                                <div class="col-md-4 col-sm-3 col-12"></div>
                                <div class="col-md-4 col-sm-6 col-12">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtSearchStdReport" runat="server" CssClass="form-control" placeholder="Search"></asp:TextBox>
                                        <span class="input-group-btn">
                                            <asp:Button ID="btnSearchStdReport" runat="server" CssClass="btn btn-primary mouseHover" Text="Search" />
                                        </span>
                                    </div>
                                </div>
                            </div><br />
                            <div class="row">
                                <div class="col-12 text-center text-primary">
                                    <h3>Student Report</h3>
                                    <asp:GridView ID="gvStdReport" runat="server"></asp:GridView>
                                </div>
                            </div>
                        </div>
                        <!-- Student Report End -->

                        <!-- Book Report Start -->
                        <div class="tab-pane fade" id="bookReport" role="tabpanel">
                            <div class="row">
                                <div class="col-md-4 col-sm-3 col-12"></div>
                                <div class="col-md-4 col-sm-3 col-12"></div>
                                <div class="col-md-4 col-sm-6 col-12">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtSearchBookReport" runat="server" CssClass="form-control" placeholder="Search"></asp:TextBox>
                                        <span class="input-group-btn">
                                            <asp:Button ID="btnSearchBookReport" runat="server" CssClass="btn btn-primary mouseHover" Text="Search" />
                                        </span>
                                    </div>
                                </div>
                            </div><br />
                            <div class="row">
                                <div class="col-12 text-center text-primary">
                                    <h3>Book Report</h3>
                                    <asp:GridView ID="gvBookReport" runat="server"></asp:GridView>
                                </div>
                            </div>
                        </div>
                        <!-- Book Report End -->

                        <!-- Issue Book Start -->
                        <div class="tab-pane fade" id="issueBook" role="tabpanel">
                            <div class="row">
                                <div class="col-md-4 col-sm-3 col-12"></div>
                                <div class="col-md-4 col-sm-3 col-12"></div>
                                <div class="col-md-4 col-sm-6 col-12">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtSearchIssueBook" runat="server" CssClass="form-control" placeholder="Search"></asp:TextBox>
                                        <span class="input-group-btn">
                                            <asp:Button ID="btnSearchIssueBook" runat="server" CssClass="btn btn-primary mouseHover" Text="Search" />
                                        </span>
                                    </div>
                                </div>
                            </div><br />
                            <div class="row">
                                <div class="col-12 text-center text-primary">
                                    <h3>Issue Book</h3>
                                    <asp:GridView ID="gvIssueBook" runat="server"></asp:GridView>
                                </div>
                            </div>
                        </div>
                        <!-- Issue Book End -->

                        <!-- Return Book Start -->
                        <div class="tab-pane fade" id="returnBook" role="tabpanel">
                            <div class="row">
                                <div class="col-md-4 col-sm-3 col-12"></div>
                                <div class="col-md-4 col-sm-3 col-12"></div>
                                <div class="col-md-4 col-sm-6 col-12">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtSearchReturnBook" runat="server" CssClass="form-control" placeholder="Search"></asp:TextBox>
                                        <span class="input-group-btn">
                                            <asp:Button ID="btnSearchReturnBook" runat="server" CssClass="btn btn-primary mouseHover" Text="Search" />
                                        </span>
                                    </div>
                                </div>
                            </div><br />
                            <div class="row">
                                <div class="col-12 text-center text-primary">
                                    <h3>Return Book</h3>
                                    <asp:GridView ID="gvReturnBook" runat="server"></asp:GridView>
                                </div>
                            </div>
                        </div>
                        <!-- Return Book End -->

                        <!-- Issue Report Start -->
                        <div class="tab-pane fade" id="issueReport" role="tabpanel">
                            <div class="row">
                                <div class="col-md-4 col-sm-3 col-12"></div>
                                <div class="col-md-4 col-sm-3 col-12"></div>
                                <div class="col-md-4 col-sm-6 col-12">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtSearchIssueReport" runat="server" CssClass="form-control" placeholder="Search"></asp:TextBox>
                                        <span class="input-group-btn">
                                            <asp:Button ID="btnSearchIssueReport" runat="server" CssClass="btn btn-primary mouseHover" Text="Search" />
                                        </span>
                                    </div>
                                </div>
                            </div><br />
                            <div class="row">
                                <div class="col-12 text-center text-primary">
                                    <h3>Issue Report</h3>
                                    <asp:GridView ID="gvIssueReport" runat="server"></asp:GridView>
                                </div>
                            </div>
                        </div>
                        <!-- Issue Report End -->

                    </div>
                </div>
            </div>

        </div>
    </form>
    <script src="../js/popper-1.11.0.min.js"></script>
    <script src="../js/jquery-3.2.1.js"></script>
    <script src="../js/bootstrap.js"></script>
</body>
</html>
