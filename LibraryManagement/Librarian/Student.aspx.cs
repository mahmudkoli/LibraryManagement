using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.IO;

namespace LibraryManagement.Librarian
{
    public partial class Student : System.Web.UI.Page
    {
        code.FileCheck FileCheckResult = new code.FileCheck();

        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringName"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FieldClear();
                AddDay();
                AddMonth();
                AddYear();
                AddBranch();
                BindGrid();
            }
        }
        public void BindGrid()
        {
            try
            {
                sqlCon.Open();
                SqlDataAdapter dAdapter = new SqlDataAdapter("select * from StudentTable order by Id desc", sqlCon);
                DataSet ds = new DataSet();
                dAdapter.Fill(ds);
                sqlCon.Close();

                gvStdReport.DataSource = ds.Tables[0];
                gvStdReport.DataBind();

                gvStdReport.UseAccessibleHeader = true;
                gvStdReport.HeaderRow.TableSection = TableRowSection.TableHeader;
                TableCellCollection cells = gvStdReport.HeaderRow.Cells;
                cells[0].Attributes.Add("data-hide", "phone");
                cells[1].Attributes.Add("data-hide", "tablet");
                cells[2].Attributes.Add("data-hide", "");
                cells[3].Attributes.Add("data-hide", "phone");
                cells[4].Attributes.Add("data-hide", "phone,tablet");
                cells[5].Attributes.Add("data-hide", "");
                cells[6].Attributes.Add("data-hide", "phone");
                cells[7].Attributes.Add("data-hide", "phone");

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('"+ ex.Message +"');</script>");
            }

        }

        protected void btnAddStdSave_Click(object sender, EventArgs e)
        {
            AddStudentData();
        }

        protected void btnUpStdSave_Click(object sender, EventArgs e)
        {
            UpdateStudentData(Convert.ToInt32(lblUpStdId.Text), txtUpStdName.Text, txtUpStdMobile.Text, Convert.ToInt32(ddlUpStdBranch.SelectedValue), txtUpStdAddress.Text, txtUpStdCity.Text, txtUpStdZipcode.Text);
        }

        protected void btnStdDeleteData_Click(object sender, EventArgs e)
        {
            try
            {
                sqlCon.Open();
                SqlDataAdapter imgDel = new SqlDataAdapter("select ImageLocation from StudentTable where Id = '" + hfStdDeleteId.Value + "'", sqlCon);
                DataTable dt = new DataTable();
                imgDel.Fill(dt);

                SqlCommand cmd = new SqlCommand("delete from StudentTable where Id = '" + hfStdDeleteId.Value + "'", sqlCon);
                cmd.ExecuteNonQuery();
                sqlCon.Close();

                string fileLoc = Server.MapPath(dt.Rows[0][0].ToString());
                if (File.Exists(fileLoc))
                    File.Delete(fileLoc);

                StringBuilder sb = new StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("alert('Data delete success');");
                sb.Append("$('#modalStdDelete').modal('hide');");
                sb.Append("window.location='Student.aspx';");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "modalStdDeleteScript", sb.ToString(), false);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }

            BindGrid();
        }

        protected void gvStdReport_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            int stdId = Convert.ToInt32(gvStdReport.DataKeys[index].Value);

            if (e.CommandName.Equals("detailsStd"))
            {
                StudentDetails(stdId);
                StringBuilder sb = new StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#modalStdDetails').modal('show');");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "modalStdDetailsScript", sb.ToString(), false);
            }
            else if (e.CommandName.Equals("editStd"))
            {
                StudentDataUpdateShow(stdId);
                StringBuilder sb = new StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#modalStdEdit').modal('show');");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "modalStdEditScript", sb.ToString(), false);
            }
            else if (e.CommandName.Equals("deleteStd"))
            {
                StudentDataDeleteInfo(stdId);
                StringBuilder sb = new StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#modalStdDelete').modal('show');");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "modalStdDeleteScript", sb.ToString(), false);
            }
        }

        protected void gvStdReport_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //try
            //{
            //    if (e.Row.RowType == DataControlRowType.DataRow)
            //    {
            //        int id = Convert.ToInt32(e.Row.Cells[1].Text);
            //        Image img = (Image)e.Row.FindControl("gvImgStd");

            //        sqlCon.Open();
            //        SqlDataAdapter sqlDA = new SqlDataAdapter("select ImageLocation from StudentTable where Id = '" + id + "'", sqlCon);
            //        DataTable dt = new DataTable();
            //        sqlDA.Fill(dt);
            //        sqlCon.Close();

            //        img.ImageUrl = dt.Rows[0][0].ToString();
            //    }
            //}
            //catch (Exception ex)
            //{
            //    Response.Write("<script>alert('" + ex.Message + "');</script>");
            //}
        }

        public void AddStudentData()
        {
            int stdBranch = 0, stdZipCode = 0;
            string stdName = "", stdEmail = "", stdMobile = "", stdPassword = "", stdAddress = "", stdCity = "", stdImageLocation = "";
            DateTime stdBirthdate;
            DateTime stdDate = DateTime.Now;

            string imgName, imgLoc;
            imgLoc = "~/images/student//";

            try
            {
                stdBranch = Convert.ToInt32(ddlAddStdBranch.SelectedValue);
                stdZipCode = Convert.ToInt32(txtAddStdZipCode.Text);
                stdName = txtAddStdName.Text;
                stdEmail = txtAddStdEmail.Text.Trim();
                stdMobile = txtAddStdMobile.Text;
                stdPassword = Convert.ToString(123456);
                stdAddress = txtAddStdAddress.Text;
                stdCity = txtAddStdCity.Text;
                stdBirthdate = Convert.ToDateTime(ddlAddStdBirthMonth.SelectedValue + "-" + ddlAddStdBirthDay.SelectedValue + "-" + ddlAddStdBirthYear.SelectedValue);

                imgName = stdEmail;

                if (DuplicateDataCheck() == true)
                {
                    Response.Write("<script>alert('Already created account by this Email');</script>");
                }
                else
                {
                    if ((stdImageLocation = FileCheckResult.ImageCheckWithSave(fileAddStdPhoto, imgLoc, imgName, 2)) == null)
                        return;

                    sqlCon.Open();
                    SqlCommand insCmd = new SqlCommand("insert into " +
                    "StudentTable(Name,Email,Mobile,Password,Branch,Birthdate,Address,City,ZipCode,ImageLocation,Date)" +
                    " values('" + stdName + "','" + stdEmail + "','" + stdMobile + "','" + stdPassword + "','" + stdBranch + "','" + stdBirthdate + "','" + stdAddress + "','" + stdCity + "','" + stdZipCode + "','" + stdImageLocation + "','" + stdDate + "')", sqlCon);
                    insCmd.ExecuteNonQuery();
                    sqlCon.Close();
                    FieldClear();

                    StringBuilder sb = new StringBuilder();
                    sb.Append(@"<script type='text/javascript'>");
                    sb.Append("alert('Data has been saved');");
                    sb.Append("$('#modalAddStd').modal('hide');");
                    sb.Append("window.location='Student.aspx';");
                    sb.Append(@"</script>");
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "modalAddStdScript", sb.ToString(), false);
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }

            BindGrid();
        }

        public void UpdateStudentData(int upId,string upName,string upMobile, int upBranch,string upAddress, string upCity, string upZipcode)
        {
            string imgName, imgLoc, imgLocation = "";
            imgName = lblUpStdEmail.Text;
            imgLoc = "~/images/student//";

            try
            {
                sqlCon.Open();
                SqlCommand cmd = new SqlCommand("update StudentTable set Name = '" + upName + "', Mobile = '" + upMobile + "', Branch = '" + upBranch + "', Address = '" + upAddress + "', City = '" + upCity + "', ZipCode = '" + upZipcode + "' where Id = '" + upId + "'", sqlCon);
                cmd.ExecuteNonQuery();
                sqlCon.Close();

                if (fileUpStdPhoto.HasFile)
                {
                    if ((imgLocation = FileCheckResult.ImageCheckWithSave(fileUpStdPhoto, imgLoc, imgName, 2)) != null)
                    {
                        sqlCon.Open();
                        SqlDataAdapter imgUpDA = new SqlDataAdapter("select ImageLocation from StudentTable where Id = '" + upId + "'", sqlCon);
                        DataTable dtImgUp = new DataTable();
                        imgUpDA.Fill(dtImgUp);

                        if (dtImgUp.Rows[0][0].ToString() != imgLocation)
                        {
                            if (File.Exists(Server.MapPath(dtImgUp.Rows[0][0].ToString())))
                                File.Delete(Server.MapPath(dtImgUp.Rows[0][0].ToString()));

                            SqlCommand imgUp = new SqlCommand("update StudentTable set ImageLocation = '" + imgLocation + "' where Id = '" + upId + "'", sqlCon);
                            imgUp.ExecuteNonQuery();
                        }
                        sqlCon.Close();
                    }
                    else
                        return;
                }

                StringBuilder sb = new StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("alert('Data Update success');");
                sb.Append("$('#modalStdEdit').modal('hide');");
                sb.Append("window.location='Student.aspx';");
                sb.Append(@"</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "modalStdEditScript", sb.ToString(), false);

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }

            BindGrid();
        }

        public void StudentDetails(int id)
        {
            try
            {
                sqlCon.Open();
                SqlDataAdapter sqlDA = new SqlDataAdapter("select s.Id as Id,s.Name as Name,s.ImageLocation as ImageLocation,s.Email as Email,s.Mobile as Mobile," +
                    "s.Password as Password,b.Name as Branch,s.Birthdate as Birthdate,s.Address as Address,s.City as City,s.ZipCode as ZipCode,s.Date as Date " +
                    "from StudentTable as s inner join BranchTable as b on s.Branch = b.Code where s.Id = '" + id + "'", sqlCon);
                DataTable dt = new DataTable();
                sqlDA.Fill(dt);
                sqlCon.Close();

                lblStdDetailsId.Text = dt.Rows[0]["Id"].ToString();
                lblStdDetailsName.Text = dt.Rows[0]["Name"].ToString();
                imgStdDetailsImage.ImageUrl = dt.Rows[0]["ImageLocation"].ToString();
                lblStdDetailsEmail.Text = dt.Rows[0]["Email"].ToString();
                lblStdDetailsMobile.Text = dt.Rows[0]["Mobile"].ToString();
                lblStdDetailsPassword.Text = dt.Rows[0]["Password"].ToString();
                lblStdDetailsBranch.Text = dt.Rows[0]["Branch"].ToString();
                lblStdDetailsBirthdate.Text = ((DateTime)dt.Rows[0]["Birthdate"]).ToString("dd MMMM, yyyy");
                lblStdDetailsAddress.Text = dt.Rows[0]["Address"].ToString();
                lblStdDetailsCity.Text = dt.Rows[0]["City"].ToString();
                lblStdDetailsZipCode.Text = dt.Rows[0]["ZipCode"].ToString();
                lblStdDetailsJoinDate.Text = ((DateTime)dt.Rows[0]["Date"]).ToString("dd MMMM, yyyy");
                
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        public void StudentDataDeleteInfo(int id)
        {
            try
            {
                sqlCon.Open();
                SqlDataAdapter sqlDA = new SqlDataAdapter("select * from StudentTable where Id = '" + id + "'", sqlCon);
                DataTable dt = new DataTable();
                sqlDA.Fill(dt);
                sqlCon.Close();

                lblStdDeleteName.Text = dt.Rows[0]["Name"].ToString();
                hfStdDeleteId.Value = dt.Rows[0]["Id"].ToString();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        public void StudentDataUpdateShow(int id)
        {
            try
            {
                sqlCon.Open();
                SqlDataAdapter sqlDA = new SqlDataAdapter("select * from StudentTable where Id = '"+ id +"'",sqlCon);
                DataTable dt = new DataTable();
                sqlDA.Fill(dt);
                
                SqlDataAdapter sqlDAB = new SqlDataAdapter("select * from BranchTable", sqlCon);
                DataTable dtB = new DataTable();
                sqlDAB.Fill(dtB);
                sqlCon.Close();

                lblUpStdId.Text = dt.Rows[0]["Id"].ToString();
                lblUpStdEmail.Text = dt.Rows[0]["Email"].ToString();
                txtUpStdName.Text = dt.Rows[0]["Name"].ToString();
                txtUpStdMobile.Text = dt.Rows[0]["Mobile"].ToString();
                txtUpStdAddress.Text = dt.Rows[0]["Address"].ToString();
                txtUpStdCity.Text = dt.Rows[0]["City"].ToString();
                txtUpStdZipcode.Text = dt.Rows[0]["ZipCode"].ToString();


                ddlUpStdBranch.DataSource = dtB;
                ddlUpStdBranch.DataTextField = "Name";
                ddlUpStdBranch.DataValueField = "Code";
                ddlUpStdBranch.DataBind();
                ddlUpStdBranch.SelectedValue = dt.Rows[0]["Branch"].ToString();

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
                
        }

        public void FieldClear()
        {
            txtAddStdAddress.Text = "";
            txtAddStdCity.Text = "";
            txtAddStdEmail.Text = "";
            txtAddStdMobile.Text = "";
            txtAddStdName.Text = "";
            txtAddStdZipCode.Text = "";
            txtSearchStudent.Text = "";
            ddlAddStdBirthDay.SelectedValue = "-1";
            ddlAddStdBirthMonth.SelectedValue = "-1";
            ddlAddStdBirthYear.SelectedValue = "-1";
            ddlAddStdBranch.SelectedValue = "-1";
            ddlAddStdGender.SelectedValue = "-1";
        }
        public bool DuplicateDataCheck()
        {
            bool chk = false;
            try
            {
                sqlCon.Open();
                SqlCommand slCmd = new SqlCommand("select * from StudentTable where Email = '"+ txtAddStdEmail.Text.Trim() +"'", sqlCon);
                SqlDataReader dr = slCmd.ExecuteReader();

                if (dr.HasRows)
                    chk = true;
                else
                    chk = false;

                sqlCon.Close();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
            
            return chk;
        }
        public void AddBranch()
        {
            ddlAddStdBranch.Items.Clear();
            ListItem liDefault = new ListItem("Select Branch","-1");
            ddlAddStdBranch.Items.Add(liDefault);
            liDefault.Selected = true;
            try
            {
                sqlCon.Open();
                SqlCommand slCmd = new SqlCommand("select * from BranchTable",sqlCon);
                SqlDataReader dr = slCmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        ListItem li = new ListItem(dr[0].ToString(), dr[1].ToString());
                        ddlAddStdBranch.Items.Add(li);
                    }
                }
                sqlCon.Close();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }
        public void AddDay()
        {
            for (int i = 1; i <= 31; i++)
            {
                ListItem li = new ListItem();
                li.Text = i.ToString();
                li.Value = i.ToString();
                ddlAddStdBirthDay.Items.Add(li);
            }
        }
        public void AddMonth()
        {
            for (int i = 1; i <= 12; i++)
            {
                ListItem li = new ListItem();
                li.Text = MonthName(i);
                li.Value = i.ToString();
                ddlAddStdBirthMonth.Items.Add(li);
            }
        }
        public void AddYear()
        {
            for (int i = 1990; i <= 2030; i++)
            {
                ListItem li = new ListItem();
                li.Text = i.ToString();
                li.Value = i.ToString();
                ddlAddStdBirthYear.Items.Add(li);
            }
        }
        public String MonthName(int i)
        {
            string Name = null;
            switch (i)
            {
                case 1:
                    Name = "Jan";
                    break;
                case 2:
                    Name = "Feb";
                    break;
                case 3:
                    Name = "Mar";
                    break;
                case 4:
                    Name = "Apr";
                    break;
                case 5:
                    Name = "May";
                    break;
                case 6:
                    Name = "Jun";
                    break;
                case 7:
                    Name = "Jul";
                    break;
                case 8:
                    Name = "Aug";
                    break;
                case 9:
                    Name = "Sep";
                    break;
                case 10:
                    Name = "Oct";
                    break;
                case 11:
                    Name = "Nov";
                    break;
                case 12:
                    Name = "Dec";
                    break;
                default:
                    Name = null;
                    break;
            }

            return Name;
        }

        protected void gvStdReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvStdReport.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void gvStdReport_Sorting(object sender, GridViewSortEventArgs e)
        {
            
        }

        protected void btnSearchStudent_Click(object sender, EventArgs e)
        {
            try
            {
                sqlCon.Open();
                SqlDataAdapter sqlDa = new SqlDataAdapter("select * from StudentTable where Id = '"+ Convert.ToInt32(txtSearchStudent.Text) +"'",sqlCon);
                DataTable dt = new DataTable();
                sqlDa.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    Response.Write("<script>alert('There is no data of this Id');window.location='Student.aspx';</script>");
                }
                else
                {
                    gvStdReport.DataSource = dt;
                    gvStdReport.DataBind();
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

    }
}