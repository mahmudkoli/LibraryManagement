using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LibraryManagement.Librarian
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if(Session["number"] == null)
                    Session["number"] = 1;
                TextBox1.Text = Session["number"].ToString();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int i = (int)Session["number"] + 1;
            Session["number"] = i;
            TextBox1.Text = Session["number"].ToString();
        }
    }
}