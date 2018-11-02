<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Book.aspx.cs" Inherits="LibraryManagement.Librarian.Book" %>

<%@ Register Src="~/controller/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/controller/menu.ascx" TagPrefix="uc1" TagName="menu" %>



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
                <div class="col-md-8 col-12">
                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-primary mouseHover" data-toggle="modal" data-target="#modalAddBook">
                      Add Book
                    </button>
                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-primary mouseHover" data-toggle="modal" data-target="#modalAddPublication">
                      Add Publication
                    </button>
                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-primary mouseHover" data-toggle="modal" data-target="#modalAddBranch">
                      Add Branch
                    </button>
                </div>
                <div class="col-md-4 col-12">
                    <div class="input-group">
                        <asp:TextBox ID="txtSearchBook" runat="server" CssClass="form-control" placeholder="Search"></asp:TextBox>
                        <span class="input-group-btn">
                            <asp:Button ID="btnSearchBook" runat="server" CssClass="btn btn-primary mouseHover" Text="Search" OnClick="btnSearchBook_Click" />
                        </span>
                    </div>
                </div>
            </div>
        </div><br />

        <!-- GridView Start -->
        <asp:UpdatePanel ID="upGVBookReport" runat="server">
            <ContentTemplate>
                <div class="container">
            <div class="row">
                <div class="col-12 text-center text-info">
                    <h3>Book Report</h3>
                    <asp:GridView ID="gvBookReport" runat="server" AutoGenerateColumns="false" CssClass="table table-responsive table-sm table-striped table-hover table-inverse"
                        DataKeyNames="Id" OnRowCommand="gvBookReport_RowCommand" HeaderStyle-ForeColor="#007ACC" AllowSorting="true" AllowPaging="true"
                        OnSorting="gvBookReport_Sorting" OnPageIndexChanging="gvBookReport_PageIndexChanging" EnableSortingAndPagingCallbacks="true" Visible="true">
                        <Columns>
                            <asp:BoundField DataField="Id" HeaderText="ID" HeaderStyle-CssClass="text-center" />
                            <asp:BoundField DataField="Name" HeaderText="Name" HeaderStyle-CssClass="text-center" />
                            <asp:BoundField DataField="Author" HeaderText="Author" HeaderStyle-CssClass="text-center" />
                            <asp:BoundField DataField="Publication" HeaderText="Publication" HeaderStyle-CssClass="text-center" />
                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" HeaderStyle-CssClass="text-center" />
                            
                            <asp:ButtonField CommandName="detailsBook" ControlStyle-CssClass="btn btn-sm btn-info mouseHover" HeaderStyle-CssClass="text-center"
                                ButtonType="Button" Text="Details" HeaderText="Detailed">
                            </asp:ButtonField>
                            <asp:ButtonField CommandName="editBook" ControlStyle-CssClass="btn btn-sm btn-info mouseHover" HeaderStyle-CssClass="text-center"
                                ButtonType="Button" Text="Edit" HeaderText="Edit">
                            </asp:ButtonField>
                            <asp:ButtonField CommandName="deleteBook" ControlStyle-CssClass="btn btn-sm btn-danger mouseHover" HeaderStyle-CssClass="text-center"
                                ButtonType="Button" Text="Delete" HeaderText="Delete">
                            </asp:ButtonField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
            </ContentTemplate>
            <Triggers></Triggers>
        </asp:UpdatePanel>
        <!-- GridView Start -->

        <!-- Add Book Start -->
        <!-- Modal -->
        <div class="modal fade" id="modalAddBook" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title font-weight-bold text-primary">Add New Book</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                <div class="container">
                    <div class="row">
                        <div class="col-5">Book Name :<span class="text-danger font-weight-bold">*</span></div>
                        <div class="col-7">
                            <asp:TextBox ID="txtAddBookName" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="required" CssClass="text-danger"
                                ControlToValidate="txtAddBookName" SetFocusOnError="True" ValidationGroup="AddBook"
                                Display="Dynamic"></asp:RequiredFieldValidator>

                        </div>
                    </div>
                </div>
                <br />
                <div class="container">
                    <div class="row">
                        <div class="col-5">Details :</div>
                        <div class="col-7">
                            <asp:TextBox ID="txtAddBookDetails" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>

                        </div>
                    </div>
                </div>
                <br />
                <div class="container">
                    <div class="row">
                        <div class="col-5">Author :<span class="text-danger font-weight-bold">*</span></div>
                        <div class="col-7">
                            <asp:TextBox ID="txtAddBookAuthor" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="required" CssClass="text-danger"
                                ControlToValidate="txtAddBookAuthor" SetFocusOnError="True" ValidationGroup="AddBook"
                                Display="Dynamic"></asp:RequiredFieldValidator>

                        </div>
                    </div>
                </div>
                <br />
                <div class="container">
                    <div class="row">
                        <div class="col-5">Publication :<span class="text-danger font-weight-bold">*</span></div>
                        <div class="col-7">
                            <asp:DropDownList ID="ddlAddBookPublication" CssClass="form-control" runat="server">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="required" CssClass="text-danger"
                                ControlToValidate="ddlAddBookPublication" SetFocusOnError="true" InitialValue="-1" ValidationGroup="AddBook"
                                Display="Dynamic"></asp:RequiredFieldValidator>

                        </div>
                    </div>
                </div>
                <br />
                <div class="container">
                    <div class="row">
                        <div class="col-5">Branch :<span class="text-danger font-weight-bold">*</span></div>
                        <div class="col-7">
                            <asp:DropDownList ID="ddlAddBookBranch" CssClass="form-control" runat="server">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="required" CssClass="text-danger"
                                ControlToValidate="ddlAddBookBranch" SetFocusOnError="true" InitialValue="-1" ValidationGroup="AddBook"
                                Display="Dynamic"></asp:RequiredFieldValidator>

                        </div>
                    </div>
                </div>
                <br />
                <div class="container">
                    <div class="row">
                        <div class="col-5">Price :<span class="text-danger font-weight-bold">*</span></div>
                        <div class="col-7">
                            <asp:TextBox ID="txtAddBookPrice" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="required" CssClass="text-danger"
                                ControlToValidate="txtAddBookPrice" SetFocusOnError="True" ValidationGroup="AddBook"
                                Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator2" runat="server" ErrorMessage="invalid" CssClass="text-danger"
                                ControlToValidate="txtAddBookPrice" SetFocusOnError="true" ValidationGroup="AddBook"
                                Display="Dynamic" Type="Double" Operator="DataTypeCheck"></asp:CompareValidator>

                        </div>
                    </div>
                </div>
                <br />
                <div class="container">
                    <div class="row">
                        <div class="col-5">Quantity :<span class="text-danger font-weight-bold">*</span></div>
                        <div class="col-7">
                            <asp:TextBox ID="txtAddBookQuantity" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="required" CssClass="text-danger"
                                ControlToValidate="txtAddBookQuantity" SetFocusOnError="True" ValidationGroup="AddBook"
                                Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="invalid" CssClass="text-danger"
                                ControlToValidate="txtAddBookQuantity" SetFocusOnError="true" ValidationGroup="AddBook"
                                Display="Dynamic" Type="Integer" Operator="DataTypeCheck"></asp:CompareValidator>

                        </div>
                    </div>
                </div>
                <br />
                <div class="container">
                    <div class="row">
                        <div class="col-5">Book Photo :</div>
                        <div class="col-7">
                            <asp:FileUpload ID="fileAddBookPhoto" runat="server" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="invalid format"
                                ControlToValidate="fileAddBookPhoto" SetFocusOnError="true" ValidationGroup="AddBook" CssClass="text-danger"
                                Display="Dynamic" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))+(.jpeg|.JPEG|.png|.PNG|.JPG|.jpg)$"></asp:RegularExpressionValidator>
                            <br />
                            <span class="text-info">Image size should be maximum 2 MB & Format .jpg | .jepg | .png</span>
                        </div>
                    </div>
                </div>

              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <asp:Button ID="btnAddBookSave" runat="server" CssClass="btn btn-primary mouseHover" ValidationGroup="AddBook" Text="Save" OnClick="btnAddBookSave_Click" />
              </div>
            </div>
          </div>
        </div>
        <!-- Add Book End -->

        <!-- Add Publication Start -->
        <!-- Modal -->
        <div class="modal fade" id="modalAddPublication" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title font-weight-bold text-primary">Add New Publication</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                <div class="container">
                    <div class="row">
                        <div class="col-6">Publication Name :<span class="text-danger font-weight-bold">*</span></div>
                        <div class="col-6">
                            <asp:TextBox ID="txtAddPublicationName" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="required" CssClass="text-danger"
                                ControlToValidate="txtAddPublicationName" SetFocusOnError="True" ValidationGroup="AddPublication"
                                Display="Dynamic"></asp:RequiredFieldValidator>

                        </div>
                    </div>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <asp:Button ID="btnAddPublicationSave" runat="server" CssClass="btn btn-primary mouseHover" ValidationGroup="AddPublication" Text="Save" OnClick="btnAddPublicationSave_Click" />
              </div>
            </div>
          </div>
        </div>
        <!-- Add Publication End -->

        <!-- Add Branch Start -->
        <!-- Modal -->
        <div class="modal fade" id="modalAddBranch" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title font-weight-bold text-primary">Add New Branch</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                <div class="container">
                    <div class="row">
                        <div class="col-5">Branch Name :<span class="text-danger font-weight-bold">*</span></div>
                        <div class="col-7">
                            <asp:TextBox ID="txtAddBranchName" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="required" CssClass="text-danger"
                                ControlToValidate="txtAddBranchName" SetFocusOnError="True" ValidationGroup="AddBranch"
                                Display="Dynamic"></asp:RequiredFieldValidator>

                        </div>
                    </div>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <asp:Button ID="btnAddBranchSave" runat="server" CssClass="btn btn-primary mouseHover" ValidationGroup="AddBranch" Text="Save" OnClick="btnAddBranchSave_Click" />
              </div>
            </div>
          </div>
        </div>
        <!-- Add Branch End -->

        <%-- Book Details Start --%>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div class="modal fade" id="modalBookDetails" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title text-info" id="modalBookDetailsTitle">Book Details</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-md-5 col-sm-5 col-12">
                                            <asp:Image ID="imgBookDetailsImage" CssClass="img-thumbnail" Width="150px" Height="180px" AlternateText="Book Image" runat="server" />
                                        </div>
                                        <div class="col-md-7 col-sm-7 col-12">
                                            <h3>
                                                <asp:Label ID="lblBookDetailsName" runat="server" Text="" CssClass="text-primary"></asp:Label></h3>
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
                                            <asp:Label ID="lblBookDetailsId" runat="server" Text="" CssClass=""></asp:Label>
                                        </div>
                                    </div>
                                    <hr />
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-5">
                                            <h6>Author :</h6>
                                        </div>
                                        <div class="col-7">
                                            <asp:Label ID="lblBookDetailsAuthor" runat="server" Text="" CssClass=""></asp:Label>
                                        </div>
                                    </div>
                                    <hr />
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-5">
                                            <h6>Publication :</h6>
                                        </div>
                                        <div class="col-7">
                                            <asp:Label ID="lblBookDetailsPublication" runat="server" Text="" CssClass=""></asp:Label>
                                        </div>
                                    </div>
                                    <hr />
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-5">
                                            <h6>Details :</h6>
                                        </div>
                                        <div class="col-7">
                                            <asp:Label ID="lblBookDetailsDetails" runat="server" Text="" CssClass=""></asp:Label>
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
                                            <asp:Label ID="lblBookDetailsBranch" runat="server" Text="" CssClass=""></asp:Label>
                                        </div>
                                    </div>
                                    <hr />
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-5">
                                            <h6>Price :</h6>
                                        </div>
                                        <div class="col-7">
                                            <asp:Label ID="lblBookDetailsPrice" runat="server" Text="" CssClass=""></asp:Label>
                                        </div>
                                    </div>
                                    <hr />
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-5">
                                            <h6>Total Quantity :</h6>
                                        </div>
                                        <div class="col-7">
                                            <asp:Label ID="lblBookDetailsQuantity" runat="server" Text="" CssClass=""></asp:Label>
                                        </div>
                                    </div>
                                    <hr />
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="col-5">
                                            <h6>Entry Date :</h6>
                                        </div>
                                        <div class="col-7">
                                            <asp:Label ID="lblBookDetailsEntryDate" runat="server" Text="" CssClass=""></asp:Label>
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
        <%-- Book Details End --%>

        <%-- Book Edit Start --%>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
        <div class="modal fade" id="modalBookEdit" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title text-info" id="modalBookEditTitle">Edit Book Data</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">ID :</div>
                                        <div class="col-8">
                                            <asp:Label ID="lblUpBookId" runat="server" Text=""></asp:Label>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Entry Date :</div>
                                        <div class="col-8">
                                            <asp:Label ID="lblUpBookEntryDate" runat="server" Text=""></asp:Label>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Name :<span class="text-danger font-weight-bold">*</span></div>
                                        <div class="col-8">
                                            <asp:TextBox ID="txtUpBookName" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="txtUpBookName" SetFocusOnError="True" ValidationGroup="UpBook"
                                                Display="Dynamic"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Author :<span class="text-danger font-weight-bold">*</span></div>
                                        <div class="col-8">
                                            <asp:TextBox ID="txtUpBookAuthor" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="txtUpBookAuthor" SetFocusOnError="True" ValidationGroup="UpBook"
                                                Display="Dynamic"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Publication :<span class="text-danger font-weight-bold">*</span></div>
                                        <div class="col-8">
                                            <asp:DropDownList ID="ddlUpBookPublication" CssClass="form-control" runat="server">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="ddlUpBookPublication" SetFocusOnError="true" InitialValue="-1" ValidationGroup="UpBook"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Details :</div>
                                        <div class="col-8">
                                            <asp:TextBox ID="txtUpBookDetails" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Branch :<span class="text-danger font-weight-bold">*</span></div>
                                        <div class="col-8">
                                            <asp:DropDownList ID="ddlUpBookBranch" CssClass="form-control" runat="server">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="ddlUpBookBranch" SetFocusOnError="true" InitialValue="-1" ValidationGroup="UpBook"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Price :<span class="text-danger font-weight-bold">*</span></div>
                                        <div class="col-8">
                                            <asp:TextBox ID="txtUpBookPrice" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="txtUpBookPrice" SetFocusOnError="True" ValidationGroup="UpBook"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Quantity :<span class="text-danger font-weight-bold">*</span></div>
                                        <div class="col-8">
                                            <asp:TextBox ID="txtUpBookQuantity" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="required" CssClass="text-danger"
                                                ControlToValidate="txtUpBookQuantity" SetFocusOnError="True" ValidationGroup="UpBook"
                                                Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="container">
                                    <div class="row">
                                        <div class="col-4">Photo :</div>
                                        <div class="col-8">
                                            <asp:FileUpload ID="fileUpBookPhoto" runat="server" />
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="invalid format"
                                                ControlToValidate="fileUpBookPhoto" SetFocusOnError="true" ValidationGroup="UpStudent" CssClass="text-danger"
                                                Display="Dynamic" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))+(.jpeg|.JPEG|.png|.PNG|.JPG|.jpg)$"></asp:RegularExpressionValidator>
                                            <br />
                                            <span class="text-info">Image size should be maximum 2 MB & Format .jpg | .jepg | .png</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <asp:Button ID="btnUpBookSave" runat="server" CssClass="btn btn-primary mouseHover" ValidationGroup="UpBook" Text="Update" OnClick="btnUpBookSave_Click" />
                            </div>
                        </div>
                    </div>
                </div>

            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnUpBookSave" />
            </Triggers>
        </asp:UpdatePanel>
        <%-- Book Edit End --%>

        <%-- Book Delete Start --%>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
        <div class="modal fade" id="modalBookDelete" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title text-info" id="modalBookDeleteTitle">Delete Book Data</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <span>Are you sure you want to
                                    <asp:Label ID="lblBookDeleteName" runat="server" CssClass="text-danger" Text=""></asp:Label>'s data delete ?</span>
                                <asp:HiddenField ID="hfBookDeleteId" runat="server" />
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                <asp:Button ID="btnBookDeleteData" runat="server" Text="Confirm" CssClass="btn btn-danger mouseHover" OnClick="btnBookDeleteData_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnBookDeleteData" />
            </Triggers>
        </asp:UpdatePanel>
        <%-- Book Delete End --%>

    </form>
    <script src="../js/popper-1.11.0.min.js"></script>
    <script src="../js/jquery-3.2.1.js"></script>
    <script src="../js/bootstrap.js"></script>
</body>
</html>
