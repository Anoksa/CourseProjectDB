using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using Library.Model;
using System.Data.SqlClient;
using System.Windows;
using System.Text.RegularExpressions;

namespace Library.ViewModel
{
    class AddUserViewModel : ViewModelBase
    {
        private string login;
        private string password;
        private string userName;
        private bool status;

        public AddUserViewModel()
        {

        }

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

        public string UserName
        {
            get => userName;
            set
            {
                userName = value;
                OnPropertyChanged("UserName");
            }
        }

        public bool Admin
        {
            get => status;
            set
            {
                status = value;
                OnPropertyChanged("Admin");

            }
        }

        public ICommand AddUser => new RelayCommand(obj => CanSignUp());

        private async void CanSignUp()
        {
            //if ()
            //{
            //проверка существования пользователя
            //}

            if (CheckField())
            {
                DB.SqlConnection.Open();
                SqlTransaction transaction = DB.SqlConnection.BeginTransaction();
                SqlCommand commandB = DB.SqlConnection.CreateCommand();
                try
                {
                    if (Admin)
                    {
                        
                            SqlCommand commandA = DB.SqlConnection.CreateCommand();
                            commandA.CommandText = "Exec AddUser 'ad', '" + Login+ "','" + Password + "', null";
                            commandA.ExecuteNonQuery();
                            MessageBox.Show("Пользователь зарегистрирован");
                            DB.SqlConnection.Close();
                       
                    }
                    else
                    {
                       
                        commandB.Transaction = transaction;
                        commandB.CommandText = "Exec AddUser 'us', '" + Login + "', '" + Password + "', null";
                        commandB.ExecuteNonQuery();
                        commandB.CommandText = "exec AddReader '" + UserName + "', '"+Login+"'";
                        commandB.ExecuteNonQuery();

                        transaction.Commit();

                        commandB.CommandText = "Exec FindCard '" + Login + "'";
                        var temp = commandB.ExecuteScalar();
                        int CardId = (int)temp;
                        commandB.CommandText = "Exec ChangeCard "+CardId+", '"+Login+"'";
                        commandB.ExecuteNonQuery();

                        
                       
                        MessageBox.Show("Пользователь зарегистрирован");
                        DB.SqlConnection.Close();
                    }
                }
                catch (Exception e)
                {
                    MessageBox.Show(e.ToString());
                    transaction.Rollback();
                }
            }

        }

        private bool CheckField()
        {
            Regex regexLogin = new Regex(@"^[A-zА-я\d]+$");
            Regex regexPassword = new Regex(@"^[A-Za-z\d]+$");

            if (Login == null)
            {
                MessageBox.Show("Введите логин");
                return false;
            }
            if (Password == null)
            {
                MessageBox.Show("Введите пароль");
                return false;
            }


            if (!regexLogin.IsMatch(Login) || Login.Length < 4)
            {
                MessageBox.Show("Login is not validated");
                return false;
            }

            if (!regexPassword.IsMatch(Password) || Password.Length < 6)
            {
                MessageBox.Show("Password is not validated");
                return false;
            }

            return true;
        }
    }
}
