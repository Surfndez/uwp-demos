#region Copyright Syncfusion Inc. 2001 - 2019
// Copyright Syncfusion Inc. 2001 - 2019. All rights reserved.
// Use of this code is subject to the terms of our license.
// A copy of the current license can be obtained at any time by e-mailing
// licensing@syncfusion.com. Any infringement will be prosecuted under
// applicable laws. 
#endregion

namespace BI.PivotGrid
{
    using Common;
    using ViewModel = Tutorials.PivotGridSamples.ViewModel;
    using Windows.Globalization;

    public sealed partial class UIThreading : SampleLayout
    {
        #region Private members

        ViewModel.ViewModel vm = new ViewModel.ViewModel();

        #endregion

        #region Constructor

        /// <summary>
        /// Initializes the new instance of <see cref="UIThreading">UIThreading.</see>/>
        /// </summary>
        public UIThreading()
        {
            ApplicationLanguages.PrimaryLanguageOverride = "en-US";
            InitializeComponent();
            DataContext = vm;
        }

        #endregion

        #region Dispose

        /// <summary>
        /// Method is used to freeing the memory with clearing instances, events and objects.
        /// </summary>
        public sealed override void Dispose()
        {
            if (pivotGrid != null)
                pivotGrid.Dispose();
            pivotGrid = null;
            if (vm != null)
                vm.Dispose();
            vm = null;
            DataContext = null;
        }

        #endregion
    }
}
