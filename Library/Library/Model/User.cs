using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;

namespace Library.Model
{
    class User
    {
        public string Flag;
        public string Login;
        public string Password;
        public int CardId;

        public User() { }

        public User(string flag, string login, string password, int cardId)
        {
            this.Flag = flag;
            this.Login = login;
            this.Password = password;
            this.CardId = cardId;
            
        }

        public static User user = new User();

       
    }
}
