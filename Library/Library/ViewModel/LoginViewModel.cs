using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
using Library.Model;

namespace Library.ViewModel
{
    class LoginViewModel:ViewModelBase
    {
        private string login;
        private string password;

        public string Login
        {
            get => login;
            set
            {
                login = value;
                OnPropertyChanged("Login");
            }
        }

        public string Password
        {
            private get => password;
            set
            {
                password = value;
                OnPropertyChanged("Password");
            }
        }

        public ICommand LoginCommand => new RelayCommand(obj => CanLogin());
        
        private void CanLogin()
        {
            DB.getInstance();
            string query = "Exec FindUser '" + Login + "', '" + Password + "'";
            SqlDataAdapter adapter = new SqlDataAdapter(query, DB.SqlConnection);
            DataTable dtbl = new DataTable();
            adapter.Fill(dtbl);
            if (dtbl.Rows.Count >= 1)
            {
                DB.SqlConnection.Open();
                string Uquery = "Exec Usertype'" + Login +"'";
                SqlCommand cmd = new SqlCommand(Uquery, DB.SqlConnection);
                var temp = cmd.ExecuteScalar();
                string Query = "Exec FindUserCard '" + Login + "'";
                SqlCommand command = new SqlCommand(Query, DB.SqlConnection);
                var temp1 = command.ExecuteScalar();
                DB.SqlConnection.Close();
                User.user.Login = Login;
                User.user.Password = Password;
                User.user.Flag = temp.ToString();
                
                if (!DBNull.Value.Equals(temp1))
                    User.user.CardId = Convert.ToInt32(temp1.ToString());

                //открытие главного окна
                var main = new MainWindow();
                main.Show();
            }
            else
            {
                MessageBox.Show("Пользователь не найден");
            }
        }
    }
}
