Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C82279E4B2
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 12:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbjIMKSe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 06:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239654AbjIMKSc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 06:18:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5EF19B0;
        Wed, 13 Sep 2023 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694600308; x=1726136308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jvJr9OQ5XaplZ2MlNIADa5rR127QA75ZhurnRWf+Y9g=;
  b=H46bAszrVuPu8HsZl57yGGmRRr8pfemT8lSQfrjlGd9cw+q80JrdFITK
   Y5OUWkrQDbfWBaaKQio+7Qs1lvHKkJbpLGX1TWg0W1p9vixBkMud3soPL
   YSOTHLK6wZeam3O/RD3vKR5EdKAHpsiQj0CLARYYMcmlq4RLPy2D/MO7I
   GyvIOF3Y9Wwkoh02Jh6JXRIaMjW7wNPQ4HO7C3adLZi3oliRuBZNb/Me5
   ZVzOmAYftIjm7lSQzpWMvnyemsodsHT10O9CSG49w0Ov1bFUHkYy4VzwS
   Ru/g2Z15d/8MTH9kqp+XGuFgs2a9nDBhcKRgLibM8Qg3XvCtmukLPgbg2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="445058235"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="445058235"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:18:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="814171606"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="814171606"
Received: from lkp-server02.sh.intel.com (HELO cf13c67269a2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Sep 2023 03:18:23 -0700
Received: from kbuild by cf13c67269a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgMwt-0000OF-1K;
        Wed, 13 Sep 2023 10:18:19 +0000
Date:   Wed, 13 Sep 2023 18:17:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        iain@orangesquash.org.uk,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v18 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
Message-ID: <202309131834.q68yWKdZ-lkp@intel.com>
References: <20230913040832.114610-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913040832.114610-3-mario.limonciello@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0bb80ecc33a8fb5a682236443c1e740d5c917d1d]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/PCI-Move-the-PCI_CLASS_SERIAL_USB_USB4-definition-to-common-header/20230913-121559
base:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
patch link:    https://lore.kernel.org/r/20230913040832.114610-3-mario.limonciello%40amd.com
patch subject: [PATCH v18 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4 controllers
config: i386-randconfig-r023-20230913 (https://download.01.org/0day-ci/archive/20230913/202309131834.q68yWKdZ-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309131834.q68yWKdZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309131834.q68yWKdZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/quirks.c:3890:15: warning: using the result of an assignment as a condition without parentheses [-Wparentheses]
           while (child = pci_get_class(PCI_CLASS_SERIAL_USB_USB4, child)) {
                  ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/quirks.c:3890:15: note: place parentheses around the assignment to silence this warning
           while (child = pci_get_class(PCI_CLASS_SERIAL_USB_USB4, child)) {
                        ^
                  (                                                      )
   drivers/pci/quirks.c:3890:15: note: use '==' to turn this assignment into an equality comparison
           while (child = pci_get_class(PCI_CLASS_SERIAL_USB_USB4, child)) {
                        ^
                        ==
   1 warning generated.


vim +3890 drivers/pci/quirks.c

  3775	
  3776	/*
  3777	 * Some AMD/ATI GPUS (HD8570 - Oland) report that a D3hot->D0 transition
  3778	 * causes a reset (i.e., they advertise NoSoftRst-).  This transition seems
  3779	 * to have no effect on the device: it retains the framebuffer contents and
  3780	 * monitor sync.  Advertising this support makes other layers, like VFIO,
  3781	 * assume pci_reset_function() is viable for this device.  Mark it as
  3782	 * unavailable to skip it when testing reset methods.
  3783	 */
  3784	DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
  3785				       PCI_CLASS_DISPLAY_VGA, 8, quirk_no_pm_reset);
  3786	
  3787	/*
  3788	 * Thunderbolt controllers with broken MSI hotplug signaling:
  3789	 * Entire 1st generation (Light Ridge, Eagle Ridge, Light Peak) and part
  3790	 * of the 2nd generation (Cactus Ridge 4C up to revision 1, Port Ridge).
  3791	 */
  3792	static void quirk_thunderbolt_hotplug_msi(struct pci_dev *pdev)
  3793	{
  3794		if (pdev->is_hotplug_bridge &&
  3795		    (pdev->device != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C ||
  3796		     pdev->revision <= 1))
  3797			pdev->no_msi = 1;
  3798	}
  3799	DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LIGHT_RIDGE,
  3800				quirk_thunderbolt_hotplug_msi);
  3801	DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EAGLE_RIDGE,
  3802				quirk_thunderbolt_hotplug_msi);
  3803	DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LIGHT_PEAK,
  3804				quirk_thunderbolt_hotplug_msi);
  3805	DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
  3806				quirk_thunderbolt_hotplug_msi);
  3807	DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PORT_RIDGE,
  3808				quirk_thunderbolt_hotplug_msi);
  3809	
  3810	#ifdef CONFIG_ACPI
  3811	/*
  3812	 * Apple: Shutdown Cactus Ridge Thunderbolt controller.
  3813	 *
  3814	 * On Apple hardware the Cactus Ridge Thunderbolt controller needs to be
  3815	 * shutdown before suspend. Otherwise the native host interface (NHI) will not
  3816	 * be present after resume if a device was plugged in before suspend.
  3817	 *
  3818	 * The Thunderbolt controller consists of a PCIe switch with downstream
  3819	 * bridges leading to the NHI and to the tunnel PCI bridges.
  3820	 *
  3821	 * This quirk cuts power to the whole chip. Therefore we have to apply it
  3822	 * during suspend_noirq of the upstream bridge.
  3823	 *
  3824	 * Power is automagically restored before resume. No action is needed.
  3825	 */
  3826	static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
  3827	{
  3828		acpi_handle bridge, SXIO, SXFP, SXLV;
  3829	
  3830		if (!x86_apple_machine)
  3831			return;
  3832		if (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM)
  3833			return;
  3834	
  3835		/*
  3836		 * SXIO/SXFP/SXLF turns off power to the Thunderbolt controller.
  3837		 * We don't know how to turn it back on again, but firmware does,
  3838		 * so we can only use SXIO/SXFP/SXLF if we're suspending via
  3839		 * firmware.
  3840		 */
  3841		if (!pm_suspend_via_firmware())
  3842			return;
  3843	
  3844		bridge = ACPI_HANDLE(&dev->dev);
  3845		if (!bridge)
  3846			return;
  3847	
  3848		/*
  3849		 * SXIO and SXLV are present only on machines requiring this quirk.
  3850		 * Thunderbolt bridges in external devices might have the same
  3851		 * device ID as those on the host, but they will not have the
  3852		 * associated ACPI methods. This implicitly checks that we are at
  3853		 * the right bridge.
  3854		 */
  3855		if (ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXIO", &SXIO))
  3856		    || ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXFP", &SXFP))
  3857		    || ACPI_FAILURE(acpi_get_handle(bridge, "DSB0.NHI0.SXLV", &SXLV)))
  3858			return;
  3859		pci_info(dev, "quirk: cutting power to Thunderbolt controller...\n");
  3860	
  3861		/* magic sequence */
  3862		acpi_execute_simple_method(SXIO, NULL, 1);
  3863		acpi_execute_simple_method(SXFP, NULL, 0);
  3864		msleep(300);
  3865		acpi_execute_simple_method(SXLV, NULL, 0);
  3866		acpi_execute_simple_method(SXIO, NULL, 0);
  3867		acpi_execute_simple_method(SXLV, NULL, 0);
  3868	}
  3869	DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
  3870				       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
  3871				       quirk_apple_poweroff_thunderbolt);
  3872	
  3873	
  3874	/*
  3875	 * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into D3 power
  3876	 * states may cause problems when the system attempts wake up from s2idle.
  3877	 *
  3878	 * This manifests as a missing wakeup interrupt on the following systems:
  3879	 * Family 19h model 44h (PCI 0x14b9)
  3880	 * Family 19h model 74h (PCI 0x14eb)
  3881	 * Family 19h model 78h (PCI 0x14eb)
  3882	 *
  3883	 * Add a quirk to the root port if a USB4 controller is connected to it
  3884	 * to avoid D3 power states.
  3885	 */
  3886	static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
  3887	{
  3888		struct pci_dev *child = NULL;
  3889	
> 3890		while (child = pci_get_class(PCI_CLASS_SERIAL_USB_USB4, child)) {
  3891			if (pci_upstream_bridge(child) != pdev)
  3892				continue;
  3893			pdev->dev_flags |= PCI_DEV_FLAGS_NO_WAKE_D3;
  3894			pci_info(pdev, "quirk: disabling D3 for wakeup\n");
  3895			break;
  3896		}
  3897	}
  3898	DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14b9, quirk_ryzen_rp_d3);
  3899	DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14eb, quirk_ryzen_rp_d3);
  3900	#endif
  3901	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
