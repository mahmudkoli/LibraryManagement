using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls;

namespace LibraryManagement.code
{
    public class DuplicationCheck : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringName"].ToString());

        public bool DuplicateDataCheck(string tableName, string columnName, string value)
        {
            bool chk = false;

            try
            {
                sqlCon.Open();

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = sqlCon;
                cmd.CommandText = "spDynamicTableColumnName";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@tableName", tableName);
                cmd.Parameters.AddWithValue("@columnName", columnName);
                cmd.Parameters.AddWithValue("@value", value);

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                    chk = true;

                sqlCon.Close();

            }
            catch (Exception ex)
            {
                HttpContext.Current.Response.Write("<script>alert('" + ex.Message + "');</script>");
            }

            return chk;
        }
    }
}