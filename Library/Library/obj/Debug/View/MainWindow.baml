   M S B A M L   `   `   `  ����B  >Library, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null!clr-namespace:LibraryLibrary  5   	       Library.MainWindow   5   	   W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   b ^MaterialDesignThemes.Wpf, Version=3.2.0.1979, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5   	   !localclr-namespace:Library  5   	     � WindowStartupLocation$  CenterScreen=�5   	    � Title$ Books��5
   	   $��602.912��6   $��1052.041��6(      BookViewModel � DataContext# [  5   	    � 
ResizeMode$ NoResize=�66   .��5      � $��0,0,3.333,1.333q�6   .+�5   
   (  "MaterialDesignThemes.Wpf.ColorZone     Mode$ Inverted=�6#   $��16q�63   $��58��6@   $��2��6L   .��5      ]� .+�5      ��  �� Orientation$ 
Horizontal=�6   $	��808��66   .+�5      �� $	��Top=�6!   $��
16,-9,0,-9q�69   $��36(�6M   $��Vivaldi)�6[   	Library5      5      5      5      �� 5   
   -   5         ��Name$ BookList��5      $
��Left=�6�   $	��516��6�   $	��499��6�   $	��Top=�6�   $��0,63,0,0q�6�   ��6%   �� *Books+ �� Mode$ OneWay=� �� SelectedItem 6P   �� *SelectedBook+$ OneWayToSource=�	 �� View	 5      �� 5      .P�5      �� $��Название��6&   
 �� DisplayMemberBinding
 68   �� *Title+�� 5      $��
Автор��6&   
 65   �� *Author+�� 5      $��Год издания��6&   
 6<   �� *Year+�� 5      $��Статус��6%   
 65   �� *Status+5       � 	Resources 5        �� 
TargetType �� Property �� Value��%V   '��       �� 5!      " ��6   .�5"      ��  � ��$ Center=�6A   5#      5$      5%      �� 5'   
   -   5        $��934,10,40,510q�5'      $
��Auto��6(   ��66   �� *LoginCommand+.��5(      '  !MaterialDesignThemes.Wpf.PackIcon     Kind$
 User=�6&   $��36��62   $��27��6>   5)      5*      �� 5,   
   $��20(�6   
�������$
��Left=�63   $��37��6N   $��
532,17,0,0q�6Z   $	��Top=�6o   $	��222��6�   4  .System.Windows.Automation.AutomationProperties   HelpText$5 /Введите параметр поиска...��6�   .��6�   ��5-      �� 5.       �� Path$ SearchB�6    �� UpdateSourceTrigger$ PropertyChanged=�6*    �� ValidatesOnDataErrors .  �� ValidationRules 5/      5  /System.Windows.Controls.ExceptionValidationRule  50      52      .��53      54      �� 55   
    " MaterialDesignRaisedDarkButton#��[ 63   $��780,24,148,510q�6k   $
��Auto��6�   ��6   �� *SearchCommand+.��6�   
Поиск57      �� 59   
   $
��Left=�6A   $��745,108,0,0q�6\   $
��Wrap=�6q   $	��Top=�6�   $	��230��6�   $	��285��6�   ��6   �� *GetDescription+$ OneWay=�6�   �� 5;   
   $��565,85,329,322q�69   ��6   �� *
GetImage+$ OneWay=�69   �� 5<   
   -   5         ��Name$	 Add��5<      $
��Left=�6>   $��973,401,0,0q�6Y   $	��Top=�6n   $��56��6�   $��46��6�   ��6   �� *
AddCommand+.��5=        $
 Plus=�6&   5>      �� 5?   
   -   5        $ Delete��5?      $
��Left=�6C   $��973,452,0,0q�6^   $	��Top=�6s   $��56��6�   $��46��6�   ��6!   �� *DeleteCommand+.��5@        $ Delete=�6&   5A      �� 5B   
   $��Обновить��6   $
��Left=�6F   $��602,524,0,0q�6a   $	��Top=�6v   $	��111��6�   ��6$   �� *UpdateCommand+6�   �� 5C   
   -   5        $ AddUser��5C       � ToolTip$< 6Добавить нового пользователя��6>   $
��Left=�6e   $��973,350,0,0q�6�   $	��Top=�6�   $��56��6�   $��46��6�   ��6"   �� *	AddUser+.��5D        $ UserAdd=�6&   $��36��65   $��24��6A   5E      �� 5F   
   -   5        $ Download��5F      $)��#Сохранить документ��6G   $
��Left=�6d   $��764,350,0,0q�6   $	��Top=�6�   $	��190��6�   ��6#   �� *DownloadCommand+6�   �� 5G   
   -   5         ��Name$ Count��5G      $
��Left=�6A   $��565,383,0,0q�6\   $
��Wrap=�6q   $	��Top=�6�   $��25��6�   $	��148��6�   ��6#   �� *GetDownloads+6�   �� 5H   
   -   5        $
 Edit��5H      $
��Left=�6@   $��973,504,0,0q�6[   $	��Top=�6p   $��56��6�   $��46��6�   ��6   �� *EditCommand+.��5I        $
 Edit=�6&   5J      �� 5K   
   -	   5        $ Export��5K      $��Экспорт��6C   $
��Left=�6U   $��768,408,0,0q�6p   $	��Top=�6�   $��98��6�   ��6!   �� *ExportCommand+6�   �� 5L   
   -
   5        $ Import��5L      $��Импорт��6D   $
��Left=�6U   $��768,452,0,0q�6p   $	��Top=�6�   $��98��6�   ��6!   �� *ImportCommand+6�   5M      5N      