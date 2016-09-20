using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;

namespace MagilyWebApp
{
    /// <summary>
    /// Summary description for WebServiceForm1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class WebServiceForm1 : System.Web.Services.WebService
    {

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(UseHttpGet = true, ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public void Insert(string Name, string Email, string Phone, string Username, string Password)
        {
            string str;
            string myConnectionString = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(myConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = con;
                    cmd.CommandText = "INSERT INTO RegForm (Name,Email,Phone,Username,Password) values(@Name,@Email,@Phone,@Username,@Password)";
                    cmd.Parameters.AddWithValue("@Name", Name);
                    cmd.Parameters.AddWithValue("@Email", Email);
                    cmd.Parameters.AddWithValue("@Phone", Phone);
                    cmd.Parameters.AddWithValue("@Username", Username);
                    cmd.Parameters.AddWithValue("@Password", Password);
                    con.Open();
                    int n = cmd.ExecuteNonQuery();
                    con.Close();
                    if (n == 0)
                    {
                        str = "failed";
                    }
                    else
                    {
                        str = "success";
                    }
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(str);
        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(UseHttpGet = true, ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public void GetList()
        {
            string myConnectionString = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(myConnectionString);
            SqlCommand cmd = new SqlCommand("SELECT * FROM RegForm", con);
            con.Open();
            List<Register> reg = new List<Register>();
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                Register rg = new Register();
                rg.RegistrationID = Convert.ToInt32(dr["RegistrationID"]);
                rg.Name = dr["Name"].ToString();
                rg.Email = dr["Email"].ToString();
                rg.Phone = dr["Phone"].ToString();
                rg.Username = dr["Username"].ToString();
                rg.Password = dr["Password"].ToString();
                reg.Add(rg);
            }


            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(reg));
        }

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(UseHttpGet = true, ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public void Edit(int RegistrationID, string Name, string Email, string Phone, string Username, string Password)

        {
            string str;
            string myConnectionString = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(myConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = con;
                    cmd.CommandText = "UPDATE RegForm SET Name=@Name,Email=@Email,Phone=@Phone,Username=@Username,Password=@Password where RegistrationID=@RegistrationID";
                    cmd.Parameters.AddWithValue("@RegistrationID", RegistrationID);
                    cmd.Parameters.AddWithValue("@Name", Name);
                    cmd.Parameters.AddWithValue("@Email", Email);
                    cmd.Parameters.AddWithValue("@Phone", Phone);
                    cmd.Parameters.AddWithValue("@Username", Username);
                    cmd.Parameters.AddWithValue("@Password", Password);
                    con.Open();
                    int n = cmd.ExecuteNonQuery();
                    con.Close();
                    Context.Response.Redirect("~/RegistrationForm.aspx");
                    if (n == 0)
                    {
                        str = "failed";
                    }
                    else
                    {
                        str = "success";
                        Context.Response.Redirect("~/RegistrationForm.aspx");
                    }

                }
                JavaScriptSerializer js = new JavaScriptSerializer();
                Context.Response.Write(str);
                //Context.Response.Redirect("~/RegistrationForm.aspx");
            }
        }

        [WebMethod]
        [System.Web.Script.Services.ScriptMethod(UseHttpGet = true, ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
        public void Delete(int RegistrationID)
        {
            string str;
            string myConnectionString = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(myConnectionString);
            using (SqlCommand cmd = new SqlCommand())
            {
                
                cmd.CommandText = "DELETE FROM RegForm WHERE RegistrationID=@RegistrationID";
                cmd.Parameters.AddWithValue("@RegistrationID", RegistrationID);
                con.Open();
                int n=cmd.ExecuteNonQuery();
                con.Close();
                if (n == 0)
                {
                    str = "failed";
                }
                else
                {
                    str = "success";
                    Context.Response.Redirect("~/RegistrationForm.aspx");
                }
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(str);
        }
    }
}



