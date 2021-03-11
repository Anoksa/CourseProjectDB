using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using Library.ViewModel;
using Microsoft.Win32;

namespace Library.View
{
    /// <summary>
    /// Логика взаимодействия для AddBook.xaml
    /// </summary>
    public partial class AddBook : Window
    {
        public AddBook()
        {
            InitializeComponent();
            var addbook = new AddBookViewModel();
            DataContext = addbook;
        }

        private void LoadImage(object sender, RoutedEventArgs e)
        {
            System.Drawing.Image image;
            OpenFileDialog openDialog = new OpenFileDialog();
            openDialog.Filter = "Файлы изображений|*.bmp;*.png;*.jpg";
            openDialog.ShowDialog();

            try
            {
                //if (openDialog.FileName != null || openDialog.FileName != "")
                //    image = System.Drawing.Image.FromFile(openDialog.FileName);
                //else
                //    openDialog.FileName = "";
            }
            catch (OutOfMemoryException ex)
            {
                MessageBox.Show("Ошибка чтения картинки");

            }
            FileName.Text = openDialog.FileName;

        }
        private void LoadFile(object sender, RoutedEventArgs e)
        {
            byte[] File;
            OpenFileDialog openDialog = new OpenFileDialog();
            openDialog.Filter = "Текстовые файлы|*.docx;*.txt;*.fb2|Все файлы|*.*";
            openDialog.ShowDialog();

            try
            {

            }
            catch (OutOfMemoryException ex)
            {
                MessageBox.Show("Ошибка чтения файла");

            }
            BFileName.Text = openDialog.FileName;

        }

    }

        
}

