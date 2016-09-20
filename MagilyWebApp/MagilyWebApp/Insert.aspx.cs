using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Configuration;

namespace MagilyWebApp
{
    public partial class Insert : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod()]
        public void SubmitData(object sender, EventArgs e)
        {
            string myConnectionString = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(myConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = con;
                    cmd.CommandText = "INSERT INTO Registration (Name,Email,Phone,Username,Password) VALUES (@Name,@Email,@Phone,@Username,@Password)";
                    cmd.Parameters.AddWithValue("@Name", txtName.Text);
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@Phone", txtPhone.Text);
                    cmd.Parameters.AddWithValue("@Username", txtUname.Text);
                    cmd.Parameters.AddWithValue("@Password", txtPass.Text);
                    if (con.State != ConnectionState.Open)
                    {
                        con.Open();
                    }
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

        }
        [System.Web.Services.WebMethod()]
        public DataTable Get()
        {
            string myConnectionString = ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(myConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM Registration"))
                {

                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            dt.TableName = "Registration";
                            sda.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
        }
    }   
}