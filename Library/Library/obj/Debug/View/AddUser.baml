   M S B A M L   `   `   `  ����B  >Library, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null+clr-namespace:Library.ViewLibrary.View  5   	       Library.View.AddUser   5   	   W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   ,localclr-namespace:Library.View     5   	     � Title$  Registration��5   	   $��416.338��6   $	��360��6/   $	��360��5	   
   $	��480��6   $	��360��6)   $	��480��68    � WindowStartupLocation$ CenterScreen=�6H   .��5
      �  � ColumnDefinitions 5   
   �� 5      $
��100* �6   �� 5      $
��191* �6   �� 5      $	��62* �6    � RowDefinitions 5   
   �� 5      $
��124* �6   �� 5      $
��327* �6   .+�5   
   �� -   5         ��Name$ 	txt_login��5   �   $��1��6   $
��Left=�6"   $��23��6=   $��	10,14,0,0q�6I   $��1��6\    �� TextWrapping$
 Wrap=�6i   $	��Top=�6~   $	��171��6�   .��6�   .��5      ��  �� Path$ Login�6    �� UpdateSourceTrigger$ PropertyChanged=�6#    �� ValidatesOnDataErrors . 	 �� ValidationRules	 5      5  /System.Windows.Controls.ExceptionValidationRule  5      5      5      G� 5   
   -   5        
 G�Name$
 txt_password��5   �   $��1��6A   $
��Left=�6Q   $��	10,47,0,0q�6l   $��1��6   $	��Top=�6�   $	��171��6�   $��24��6�   6�   �� 5    
   -   5        $ txt_UserName��5    �   $��1��6   $
��Left=�6"   $��23��6=   $��	10,83,0,0q�6I   $��1��6\   $
 Wrap=�6i   $	��Top=�6~   $	��171��6�   .��6�   .��5!      �� $ UserName�6   $ PropertyChanged=�6&    . 	 5"        5#      5%      5&      �� 5'   
   $��Логин:��6   $
��Left=�6!   $��	36,16,0,0q�6<   $��1��6O   $	��Top=�6\   $��24��6t   $��44��6�    � ToolTip 5(      _� 5)      .��6   RPЛогин должен содержать не меньше 4 символов.6H   5+      �� 5,   
   $��Пароль:��6   $
��Left=�6"   $��	36,49,0,0q�6=   $��1��6P   $	��Top=�6]   $��24��6u   $��52��6�   �� 5-   
   $��Имя:��6   $
��Left=�6   $��	36,84,0,0q�6:   $��1��6M   $	��Top=�6Z   $��24��6r   $��34��6~   �� 50   
   $��34,168,29.333,132.667q�6/   $��1��6N   $
��Auto��6[   $��1��6i   ��6   �� *	AddUser+.��6y   Подтвердить52      �� 54   
   $ ��Администратор��6/   $��1��6G   $
��Left=�6W   $��
45,131,0,0q�6r   $��1��6�   $	��Top=�6�    d� 	IsChecked 6   �� *Admin+6�   55      56      