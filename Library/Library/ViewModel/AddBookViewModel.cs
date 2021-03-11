using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using Library.Model;
using Microsoft.Win32;
using System.Drawing;
using System.IO;

namespace Library.ViewModel
{
    class AddBookViewModel : ViewModelBase
    {
        

        private string title;
        private string author;
        private int year;
        private string description;
        private bool status;
        private string fileName;
        private string bfileName;

        public string Title
        {
            get => title;
            set
            {
                title = value;
                OnPropertyChanged("Title");
            }
        }

        public string Author
        {
            get => author;
            set
            {
                author = value;
                OnPropertyChanged("Author");
            }
        }

        public int Year
        {
            get => year;
            set
            {
                year = value;
                OnPropertyChanged("Year");
            }
        }

        public string Description
        {
            get => description;
            set
            {
                description = value;
                OnPropertyChanged("Description");
            }
        }

        public bool Status
        {
            get => status;
            set
            {
                status = value;
                OnPropertyChanged("Status");
            }
        }

        public string FileName
        {
            get => fileName;
            set
            {
                fileName = value;
                OnPropertyChanged("FileName");
            }
        }

        public string BFileName
        {
            get => bfileName;
            set
            {
                bfileName = value;
                OnPropertyChanged("BFileName");
            }
        }


   

        public ICommand AddCommand => new RelayCommand(obj => AddBook());

        private void AddBook()
        {
            if (CheckField())
            {
                DB.SqlConnection.Close();
                DB.SqlConnection.Open();
                SqlCommand command = DB.SqlConnection.CreateCommand();
                SqlTransaction transaction = DB.SqlConnection.BeginTransaction();
                try
                {
                    byte[] imageData = System.IO.File.ReadAllBytes(FileName);
                    byte[] bookData = System.IO.File.ReadAllBytes(BFileName);

                    

                    command.Transaction = transaction;
                    if (status)
                    {
                        command.CommandText = "Exec AddBook '" + Title + "', '" + Author + "','" + Description + "'," + Year + ",'Рекомендуем', @Image";
                    }
                    else
                    {
                        command.CommandText = "Exec AddBook '" + Title + "', '" + Author + "','" + Description + "'," + Year + ",'Обычный', @Image";
                    }
                    
                    command.Parameters.AddWithValue("@Image", imageData);
                    
                    command.Connection = DB.SqlConnection;
                    int number = command.ExecuteNonQuery();

                    string shortFileName = BFileName.Substring(BFileName.LastIndexOf('\\') + 1);
                    command.CommandText = "Exec AddFile '" + shortFileName + "', @File";
                    command.Parameters.AddWithValue("@File", bookData);
                    command.ExecuteNonQuery();

                    command.CommandText = "Exec FindBId '" + Title + "'";
                    var temp = command.ExecuteScalar();
                    int bid = (int)temp;

                    command.CommandText = "Exec FindFId '" + shortFileName + "'";
                    temp = command.ExecuteScalar();
                    int fid = (int)temp;

                    command.CommandText = "Exec Connection " + bid + "," + fid;
                    command.ExecuteNonQuery();

                    transaction.Commit();
                    MessageBox.Show("Книга добавлена.");
                    DB.SqlConnection.Close();
                    Title = "";
                    Description = "";
                    Author = "";
                    Year = 0;

                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    MessageBox.Show(ex.ToString());
                    
                }
            }
        }

        private bool CheckField()
        {

            Regex rTitle = new Regex(@"[А-Яа-я]");
            Regex rAuthor = new Regex(@"[А-Яа-я]");
            Regex rYear = new Regex(@"^\d{4}$");
            Regex rDescription = new Regex(@"[А-Яа-я]");

            if (Title == null || Title.Length > 50)
            {
                MessageBox.Show("Проверьте название");
                return false;
            }
            if (Author == null || Author.Length > 50)
            {
                MessageBox.Show("Проверьте поле Автор");
            }
            


            if (!rTitle.IsMatch(Title))
            {
                MessageBox.Show("Название должно быть на русском\n");
                return false;
            }
            if (!rAuthor.IsMatch(Author) || Author.Length > 50 || Author.Length < 0)
            {
                MessageBox.Show("Проверьте поле Автор\n");
                return false;
            }
            if (!rYear.IsMatch(Year.ToString()))
            {
                MessageBox.Show("Неверно введён год\n");
                return false;
            }
            if (!rDescription.IsMatch(Description))
            {
                MessageBox.Show("Описание должно быть на русском языке");
                return false;
            }

            return true;

        }
    }
}
