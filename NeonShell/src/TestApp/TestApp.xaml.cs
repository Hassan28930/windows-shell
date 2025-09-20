using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using Microsoft.UI.Xaml.Controls.Primitives;
using Microsoft.UI.Xaml.Data;
using Microsoft.UI.Xaml.Input;
using Microsoft.UI.Xaml.Media;
using Microsoft.UI.Xaml.Navigation;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using Windows.Foundation;
using Windows.Foundation.Collections;

namespace TestApp
{
    public sealed partial class TestApp : Window
    {
        public TestApp()
        {
            this.InitializeComponent();
            LogText.Text = $"Launched at: {DateTime.Now}\n";
            LogText.Text += "Configuration loaded successfully.";
        }

        private void ShowNotification_Click(object sender, RoutedEventArgs e)
        {
            LogText.Text += $"\n[{DateTime.Now:HH:mm:ss}] Notification shown!";
        }
    }
}
