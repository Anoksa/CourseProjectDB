   M S B A M L   `   `   `  ����B  >Library, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null+clr-namespace:Library.ViewLibrary.View  5   	   5clr-namespace:Library.ViewModelLibrary.ViewModel  62       Library.View.AddBook   5   	   W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   ,localclr-namespace:Library.View     5   	   5	viewmodelclr-namespace:Library.ViewModel     62   $	��474��5   	   $	��638��6     � Title$  AddBook��5	   	   .��5      � .+�5   
   �� $��Сохранить��60   $
��Left=�6D   $��314,386,0,0q�6_   $	��Top=�6t   $	��106��6�   ��6   �� *
AddCommand+6�   �� 5   
   -   5         ��Name$ title��5      $
��Left=�6!   $��23��6<   $��
235,24,0,0q�6H    �� TextWrapping$
 Wrap=�6\   $	��Top=�6q   $	��160��6�   .��6�   ��5      �� 5       �� Path$ Title�6    �� UpdateSourceTrigger$ PropertyChanged=�6'    �� ValidatesOnDataErrors .  �� ValidationRules 5      5  /System.Windows.Controls.ExceptionValidationRule  5      5      .��5      5      �� 5   
   -   5        $ author��5      $
��Left=�6"   $��23��6=   $��
235,58,0,0q�6I   $
 Wrap=�6]   $	��Top=�6r   $	��160��6�   .��6�   ��5      �� 5      $ Author�6   $ PropertyChanged=�6(    .  5        5      5      .��5      5      �� 5   
   -   5        $
 year��5      $
��Left=�6    $��23��6;   $��235,100,0,0q�6G   $	��Top=�6^   $��97��6v   .��6�   ��5       �� 5!      $
 Year�6   $ PropertyChanged=�6&    .  5"        5#      5%      .��5&      5'      �� 5(   
   -   5        $ description��5(      $
��Left=�6'   $	��121��6B   $��235,158,0,0q�6O   $
 Wrap=�6d   $	��Top=�6y   $	��286��6�   .��6�   ��5)      �� 5*      $ Description�6   $ PropertyChanged=�6-    .  5+        5,      5.      .��5/      50      �� 51   
   $"��Название книги:��6   $
��Left=�6*   $��	88,23,0,0q�6E   $	��Top=�6X   �� 52   
   $��Год издания:��6   $
��Left=�6'   $��
88,106,0,0q�6B   $	��Top=�6V   �� 53   
   $��Автор:��6   $
��Left=�6!   $��	88,64,0,0q�6<   $	��Top=�6O   �� 54   
   $��Описание:��6   $
��Left=�6$   $��
88,158,0,0q�6?   $	��Top=�6S   �� 55   
   $��Статус книги:��6   $
��Left=�6(   $��
441,83,0,0q�6C   $	��Top=�6W   �� 58   
   -   5         ��Name$ ch��58   �   $��Рекомендуем��66   $
��Left=�6L   $��441,115,0,0q�6g   $	��Top=�6|    d� 	IsChecked 6   �� $ Status�6�   �� 5:   
   -   5        $)��#Загрузить картинку��5:      $
��Left=�6@   $��423,293,0,0q�6[   $	��Top=�6p   $	��168��6�   �� 5;   
   -   5        $ FileName��5;      $��16(�6$   $
��Left=�62   $��177,296,0,0q�6M   $
 Wrap=�6b   $	��Top=�6w   $��25��6�   $	��218��6�   .��6�   ��5<      �� 5=      $ FileName�6   $ PropertyChanged=�6*    . 5?      .��5@      5A      �� 5B   
   -   5        $!��Загрузить файл��5B      $
��Left=�6;   $��423,337,0,0q�6V   $	��Top=�6k   $	��168��6�   $��31��6�   �� 5C   
   -	   5        $ 	BFileName��5C      $��16(�6%   $
��Left=�63   $��177,337,0,0q�6N   $
 Wrap=�6c   $	��Top=�6x   $��25��6�   $	��218��6�   ��6�   �� *	BFileName+$ PropertyChanged=� . 5E      5F      