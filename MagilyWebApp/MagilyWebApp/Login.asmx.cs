using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
namespace MagilyWebApp
{
    /// <summary>
    /// Summary description for Login
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class Login : System.Web.Services.WebService
    {

        [WebMethod]
        public void Authenticate()
        {
            string connection = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename='C:\\Users\\ADITI\\documents\\visual studio 2015\\Projects\\MagilyWebApp\\MagilyWebApp\\App_Data\\MagilyDB.mdf';Integrated Security=True";
            SqlConnection con = new SqlConnection();
        }
    }
}
