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

namespace LibraryManagement.code
{
    public class FileCheck : System.Web.UI.Page
    {
        public string ImageCheckWithSave(FileUpload fileControl, string imgSaveLocation, string imgName, int imgMaxSize)
        {
            string imgDirectory = null;

            try
            {
                if (fileControl.HasFile)
                {
                    string imgExt = Path.GetExtension(fileControl.FileName);
                    if (imgExt.ToLower() == ".jpg" || imgExt.ToLower() == ".jpeg" || imgExt.ToLower() == ".png")
                    {
                        int imgSize = fileControl.PostedFile.ContentLength;
                        if (imgSize <= (imgMaxSize * 1024 * 1024))
                        {
                            fileControl.SaveAs(Server.MapPath((imgSaveLocation + imgName + imgExt)));
                            imgDirectory = (imgSaveLocation + imgName + imgExt);
                        }
                        else
                        {
                            HttpContext.Current.Response.Write("<script>alert('Image size should be maximum ' + '" + imgMaxSize + "' + ' MB');</script>");
                        }
                    }
                    else
                    {
                        HttpContext.Current.Response.Write("<script>alert('Image Format should be .JPG | .JPEG | .PNG');</script>");
                    }
                }
                else
                {
                    HttpContext.Current.Response.Write("<script>alert('Please select the image');</script>");
                }
            }
            catch (Exception ex)
            {
                HttpContext.Current.Response.Write("<script>alert('"+ ex.Message +"');</script>");
            }

            return imgDirectory;
        }
    }
}