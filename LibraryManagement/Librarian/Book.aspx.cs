using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.IO;

namespace LibraryManagement.Librarian
{
    public partial class Book : System.Web.UI.Page
    {
        code.FileCheck FileCheckResult = new code.FileCheck();

        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringName"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                AddPublication();
                AddBranch();
                BindGrid();
            }

        }

        public void BindGrid()
        {
            try
            {
                sqlCon.Open();
                SqlDataAdapter sqlDA = new SqlDataAdapter("select bk.Id as Id,bk.Name as Name,bk.Author as Author,pb.Name as Publication," +
                    "bk.Quantity as Quantity from BookTable as bk inner join PublicationTable as pb on bk.Publication = pb.Code order by bk.Id desc", sqlCon);
                DataTable dt = new DataTable();
                sqlDA.Fill(dt);
                sqlCon.Close();

                gvBookReport.DataSource = dt;
                gvBookReport.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }

        }
        protected void gvBookReport_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            int bookId = Convert.ToInt32(gvBookReport.DataKeys[index].Value);

            if (e.CommandName.Equals("detailsBook"))
            {
                BookDetails(bookId);
                StringBuilder sb = new StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#modalBookDetails').modal('show');");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "modalBookDetailsScript", sb.ToString(), false);
            }
            else if (e.CommandName.Equals("editBook"))
            {
                BookDataUpdateShow(bookId);
                StringBuilder sb = new StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#modalBookEdit').modal('show');");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "modalBookEditScript", sb.ToString(), false);
            }
            else if (e.CommandName.Equals("deleteBook"))
            {
                BookDataDeleteInfo(bookId);
                StringBuilder sb = new StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#modalBookDelete').modal('show');");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "modalBookDeleteScript", sb.ToString(), false);
            }
        }

        public void BookDetails(int id)
        {
            try
            {
                sqlCon.Open();
                SqlDataAdapter sqlDA = new SqlDataAdapter("select bk.ImageLocation as ImageLocation,bk.Id as Id,bk.Name as Name,bk.Author as Author," +
                    "bk.Details as Details,br.Name as Branch,bk.Price as Price,bk.Quantity as Quantity,bk.EntryDate as EntryDate,pb.Name as Publication" +
                    " from BookTable as bk inner join BranchTable as br on bk.Branch = br.Code " +
                    "inner join PublicationTable as pb on bk.Publication = pb.Code where bk.Id = '" + id + "'", sqlCon);
                DataTable dt = new DataTable();
                sqlDA.Fill(dt);

                //SqlDataAdapter sqlDAP = new SqlDataAdapter("select * from PublicationTable where Code = '"+ Convert.ToInt32(dt.Rows[0]["Publication"]) +"'",sqlCon);
                //DataTable dtP = new DataTable();
                //sqlDAP.Fill(dtP);
                sqlCon.Close();

                imgBookDetailsImage.ImageUrl = dt.Rows[0]["ImageLocation"].ToString();
                lblBookDetailsId.Text = dt.Rows[0]["Id"].ToString();
                lblBookDetailsName.Text = dt.Rows[0]["Name"].ToString();
                lblBookDetailsAuthor.Text = dt.Rows[0]["Author"].ToString();
                //lblBookDetailsPublication.Text = dtP.Rows[0]["Name"].ToString();
                lblBookDetailsPublication.Text = dt.Rows[0]["Publication"].ToString();
                lblBookDetailsDetails.Text = dt.Rows[0]["Details"].ToString();
                lblBookDetailsBranch.Text = dt.Rows[0]["Branch"].ToString();
                lblBookDetailsPrice.Text = dt.Rows[0]["Price"].ToString();
                lblBookDetailsQuantity.Text = dt.Rows[0]["Quantity"].ToString();
                lblBookDetailsEntryDate.Text = ((DateTime)dt.Rows[0]["EntryDate"]).ToString("dd MMMM, yyyy");

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        public void BookDataUpdateShow(int id)
        {
            try
            {
                sqlCon.Open();
                SqlDataAdapter sqlDA = new SqlDataAdapter("select * from BookTable where Id = '" + id + "'", sqlCon);
                DataTable dt = new DataTable();
                sqlDA.Fill(dt);

                SqlDataAdapter sqlDAB = new SqlDataAdapter("select * from BranchTable", sqlCon);
                DataTable dtB = new DataTable();
                sqlDAB.Fill(dtB);

                SqlDataAdapter sqlDAP = new SqlDataAdapter("select * from PublicationTable", sqlCon);
                DataTable dtP = new DataTable();
                sqlDAP.Fill(dtP);
                sqlCon.Close();

                lblUpBookId.Text = dt.Rows[0]["Id"].ToString();
                lblUpBookEntryDate.Text = ((DateTime)dt.Rows[0]["EntryDate"]).ToString("dd MMMM, yyyy");
                txtUpBookName.Text = dt.Rows[0]["Name"].ToString();
                txtUpBookAuthor.Text = dt.Rows[0]["Author"].ToString();
                txtUpBookQuantity.Text = dt.Rows[0]["Quantity"].ToString();
                txtUpBookPrice.Text = dt.Rows[0]["Price"].ToString();
                txtUpBookDetails.Text = dt.Rows[0]["Details"].ToString();

                ddlUpBookBranch.DataSource = dtB;
                ddlUpBookBranch.DataTextField = "Name";
                ddlUpBookBranch.DataValueField = "Code";
                ddlUpBookBranch.DataBind();
                ddlUpBookBranch.SelectedValue = dt.Rows[0]["Branch"].ToString();

                ddlUpBookPublication.DataSource = dtP;
                ddlUpBookPublication.DataTextField = "Name";
                ddlUpBookPublication.DataValueField = "Code";
                ddlUpBookPublication.DataBind();
                ddlUpBookPublication.SelectedValue = dt.Rows[0]["Publication"].ToString();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        public void BookDataDeleteInfo(int id)
        {
            try
            {
                sqlCon.Open();
                SqlDataAdapter sqlDA = new SqlDataAdapter("select * from BookTable where Id = '" + id + "'", sqlCon);
                DataTable dt = new DataTable();
                sqlDA.Fill(dt);
                sqlCon.Close();

                lblBookDeleteName.Text = dt.Rows[0]["Name"].ToString();
                hfBookDeleteId.Value = dt.Rows[0]["Id"].ToString();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void btnAddPublicationSave_Click(object sender, EventArgs e)
        {
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand("select * from PublicationTable where Name = '" + txtAddPublicationName.Text.Trim() + "'", sqlCon);
                SqlDataReader dr = cmd.ExecuteReader();

                if (!dr.HasRows)
                {
                    SqlCommand insCmd = new SqlCommand("insert into PublicationTable values('" + txtAddPublicationName.Text.Trim().ToUpper() + "')", sqlCon);
                    insCmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Publication save success');</script>");
                }
                else
                {
                    Response.Write("<script>alert('This Name of Publication is already saved');</script>");
                }
                sqlCon.Close();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('"+ ex.Message +"');</script>");
            }
        }

        protected void btnAddBranchSave_Click(object sender, EventArgs e)
        {
            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand("select * from BranchTable where Name = '"+ txtAddBranchName.Text.Trim() +"'",sqlCon);
                SqlDataReader dr = cmd.ExecuteReader();

                if (!dr.HasRows)
                {
                    SqlCommand insCmd = new SqlCommand("insert into BranchTable values('" + txtAddBranchName.Text.Trim().ToUpper() + "')", sqlCon);
                    insCmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Branch save success');</script>");
                }
                else
                {
                    Response.Write("<script>alert('This Name of Branch is already saved');</script>");
                }

                sqlCon.Close();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void btnAddBookSave_Click(object sender, EventArgs e)
        {
            string bookName, bookDetails, bookAuthor, bookImgLocation = "";
            int bookBranch, bookQuantity, bookPublication;
            double bookPrice;
            DateTime dateToday = DateTime.Now;

            string bookImgLoc = "~/images/book//" ;

            try
            {

                bookName = txtAddBookName.Text.Trim();
                bookDetails = txtAddBookDetails.Text.Trim();
                bookAuthor = txtAddBookAuthor.Text.Trim();
                bookBranch = Convert.ToInt32(ddlAddBookBranch.SelectedValue);
                bookPublication = Convert.ToInt32(ddlAddBookPublication.SelectedValue);
                bookQuantity = Convert.ToInt32(txtAddBookQuantity.Text);
                bookPrice = Convert.ToDouble(txtAddBookPrice.Text);

                if (DuplicateDataCheck() == false)
                {
                    if (fileAddBookPhoto.HasFile)
                    {
                        if ((bookImgLocation = FileCheckResult.ImageCheckWithSave(fileAddBookPhoto, bookImgLoc, (bookName + bookPublication + bookAuthor), 2)) == null)
                            return;
                    }

                    sqlCon.Open();
                    SqlCommand cmd = new SqlCommand("insert into BookTable(Name,Details,Author,Publication,Branch,Price,Quantity,ImageLocation,EntryDate,UpdateDate) " +
                                                    "values('" + bookName + "','" + bookDetails + "','" + bookAuthor + "','" + bookPublication + "','" + bookBranch + "','" + bookPrice + "','" + bookQuantity + "','" + bookImgLocation + "','"+ dateToday + "','" + dateToday + "')", sqlCon);
                    cmd.ExecuteNonQuery();
                    sqlCon.Close();

                    FieldClear();
                    Response.Write("<script>alert('Data saved success');</script>");
                }
                else
                {
                    Response.Write("<script>alert('Already this data saved, Please check Name or Publication or Author');</script>");
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>"); 
            }

            BindGrid();
        }

        protected void btnUpBookSave_Click(object sender, EventArgs e)
        {
            string name, author, details,imgLoc,imgLocation = "", imgName;
            int publication, branch, quantity,id;
            double price;
            DateTime date = DateTime.Now;
            imgLoc = "~/images/book//";

            try
            {
                name = txtUpBookName.Text.Trim();
                author = txtUpBookAuthor.Text.Trim();
                details = txtUpBookDetails.Text.Trim();
                id = Convert.ToInt32(lblUpBookId.Text);
                publication = Convert.ToInt32(ddlUpBookPublication.SelectedValue);
                branch = Convert.ToInt32(ddlUpBookBranch.SelectedValue);
                quantity = Convert.ToInt32(txtUpBookQuantity.Text);
                price = Convert.ToDouble(txtUpBookPrice.Text);
                imgName = name + publication + author;

                sqlCon.Open();
                SqlCommand cmd = new SqlCommand("update BookTable set Name = '"+ name +"', Details = '" + details +"', Author = '" + author +"', Publication = '" + publication +"', Branch = '" + branch +"', Price = '" + price +"', Quantity = '" + quantity +"', UpdateDate = '" + date + "' where Id = '"+ id +"'", sqlCon);
                cmd.ExecuteNonQuery();
                sqlCon.Close();

                if (fileUpBookPhoto.HasFile)
                {
                    if ((imgLocation = FileCheckResult.ImageCheckWithSave(fileUpBookPhoto, imgLoc, imgName, 2)) != null)
                    {
                        sqlCon.Open();
                        SqlDataAdapter imgUpDA = new SqlDataAdapter("select ImageLocation from BookTable where Id = '" + id + "'", sqlCon);
                        DataTable dtImgUp = new DataTable();
                        imgUpDA.Fill(dtImgUp);

                        if (dtImgUp.Rows[0][0].ToString() != imgLocation)
                        {
                            if(File.Exists(Server.MapPath(dtImgUp.Rows[0][0].ToString())))
                                File.Delete(Server.MapPath(dtImgUp.Rows[0][0].ToString()));

                            SqlCommand imgUp = new SqlCommand("update BookTable set ImageLocation = '" + imgLocation + "' where Id = '" + id + "'", sqlCon);
                            imgUp.ExecuteNonQuery();
                        }
                        sqlCon.Close();
                    }
                    else
                        return;
                }

                Response.Write("<script>alert('Data update success');</script>");
                //StringBuilder sb = new StringBuilder();
                //sb.Append(@"<script type='text/javascript'>");
                //sb.Append("alert('Data Update success');");
                //sb.Append("$('#modalBookEdit').modal('hide');");
                ////sb.Append("window.location='Student.aspx';");
                //sb.Append(@"</script>");
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "modalBookEditScript", sb.ToString(), false);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }

            BindGrid();
        }
        
        protected void btnBookDeleteData_Click(object sender, EventArgs e)
        {
            try
            {
                sqlCon.Open();
                SqlDataAdapter imgDel = new SqlDataAdapter("select ImageLocation from BookTable where Id = '" + hfBookDeleteId.Value + "'", sqlCon);
                DataTable dt = new DataTable();
                imgDel.Fill(dt);

                SqlCommand cmd = new SqlCommand("delete from BookTable where Id = '" + hfBookDeleteId.Value + "'", sqlCon);
                cmd.ExecuteNonQuery();
                sqlCon.Close();

                string fileLoc = Server.MapPath(dt.Rows[0][0].ToString());
                if (File.Exists(fileLoc))
                    File.Delete(fileLoc);

                Response.Write("<script>alert('Data delete success');</script>");
                //StringBuilder sb = new StringBuilder();
                //sb.Append(@"<script type='text/javascript'>");
                //sb.Append("alert('Data delete success');");
                //sb.Append("$('#modalBookDelete').modal('hide');");
                //sb.Append("window.location='Student.aspx';");
                //sb.Append(@"</script>");
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "modalStdDeleteScript", sb.ToString(), false);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }

            BindGrid();
        }

        public bool DuplicateDataCheck()
        {
            bool chk = false;

            try
            {
                sqlCon.Open();
                SqlCommand cmd = new SqlCommand("select * from BookTable where Name = '"+ txtAddBookName.Text.Trim() +"' and Author = '"+ txtAddBookAuthor.Text.Trim() +"' and Publication = '"+ Convert.ToInt32(ddlAddBookPublication.SelectedValue) +"'",sqlCon);
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                    chk = true;

                sqlCon.Close();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }

            return chk;
        }
        public void FieldClear()
        {
            txtAddBookName.Text = "";
            txtAddBookDetails.Text = "";
            txtAddBookAuthor.Text = "";
            txtAddBookPrice.Text = "";
            txtAddBookQuantity.Text = "";
            txtAddPublicationName.Text = "";
            txtAddBranchName.Text = "";
            ddlAddBookPublication.SelectedValue = "-1";
            ddlAddBookBranch.SelectedValue = "-1";
        }
        public void AddPublication()
        {
            try
            {
                ddlAddBookPublication.Items.Clear();

                sqlCon.Open();
                SqlCommand cmd = new SqlCommand("select * from PublicationTable",sqlCon);

                ddlAddBookPublication.DataSource = cmd.ExecuteReader();
                ddlAddBookPublication.DataTextField = "Name";
                ddlAddBookPublication.DataValueField = "Code";
                ddlAddBookPublication.DataBind();

                ListItem li = new ListItem("Select Publication", "-1");
                ddlAddBookPublication.Items.Insert(0,li);

                sqlCon.Close();

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }
        public void AddBranch()
        {
            try
            {
                ddlAddBookBranch.Items.Clear();

                sqlCon.Open();
                SqlCommand cmd = new SqlCommand("select * from BranchTable", sqlCon);

                ddlAddBookBranch.DataSource = cmd.ExecuteReader();
                ddlAddBookBranch.DataTextField = "Name";
                ddlAddBookBranch.DataValueField = "Code";
                ddlAddBookBranch.DataBind();

                ListItem li = new ListItem("Select Branch", "-1");
                ddlAddBookBranch.Items.Insert(0, li);

                sqlCon.Close();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void btnSearchBook_Click(object sender, EventArgs e)
        {
            try
            {
                sqlCon.Open();
                SqlDataAdapter sqlDa = new SqlDataAdapter("select * from BookTable where Id = '" + Convert.ToInt32(txtSearchBook.Text) + "'", sqlCon);
                DataTable dt = new DataTable();
                sqlDa.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    Response.Write("<script>alert('There is no data of this Id');window.location='Book.aspx';</script>");
                    BindGrid();
                }
                else
                {
                    gvBookReport.DataSource = dt;
                    gvBookReport.DataBind();
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
                BindGrid();
            }
        }

        protected void gvBookReport_Sorting(object sender, GridViewSortEventArgs e)
        {

        }

        protected void gvBookReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            BindGrid();
            gvBookReport.PageIndex = e.NewPageIndex;
            gvBookReport.DataBind();
        }

    }
}