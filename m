Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CD67BAF79
	for <lists+linux-pci@lfdr.de>; Fri,  6 Oct 2023 02:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjJFAHL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 20:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJFAGl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 20:06:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2458A6
        for <linux-pci@vger.kernel.org>; Thu,  5 Oct 2023 17:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696550799; x=1728086799;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1s8xYikj0kJm8K/rGntYN5Yu17XURK+P4qBKwtvOPYQ=;
  b=jJdazkBEYT7dezo8tGaKsKGFPJKtJyW2juAXzlN3OXxDlJGVpR1qhQvQ
   2Hu1a4IlESSWK9357afVcE+d/doOyCU4r548+fDZaLPsie1/e3g+wjaEx
   dagdpzLap8LQ+4MPdg7dPaB2d+hFj1unj62JvOtJ55OiVC2Kk2ukhfjcA
   KoNtKCOY/gXZOkugUPZtEwmwefGUhtYH6xIZsGRYfi9BFdHm8E1ZGrxjK
   F55atApowKBd0jfDaa1S29gC/nJoYaLzP8VP64E4e2nyabW7l6BoSTGAE
   hn0m19pTHgvh4ueZPBAh9AcRO1EqdnRz1SzbwzfMzje5Fc0+MBJE9DI0p
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="363007015"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="363007015"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 17:06:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="822313920"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="822313920"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Oct 2023 17:06:12 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoYM4-000M2i-0h;
        Fri, 06 Oct 2023 00:06:09 +0000
Date:   Fri, 6 Oct 2023 08:05:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [pci:pm 2/2] arch/x86/pci/fixup.c:929:13: error:
 'pm_suspend_target_state' undeclared
Message-ID: <202310060800.WKT8C7A4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pm
head:   624306d2c241c274e498619cabc2ae1dc7112ad1
commit: 624306d2c241c274e498619cabc2ae1dc7112ad1 [2/2] x86/PCI: Avoid PME from D3hot/D3cold for AMD Rembrandt and Phoenix USB4
config: i386-buildonly-randconfig-004-20231006 (https://download.01.org/0day-ci/archive/20231006/202310060800.WKT8C7A4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231006/202310060800.WKT8C7A4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310060800.WKT8C7A4-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/pci/fixup.c: In function 'amd_rp_pme_suspend':
>> arch/x86/pci/fixup.c:929:13: error: 'pm_suspend_target_state' undeclared (first use in this function)
     929 |         if (pm_suspend_target_state == PM_SUSPEND_ON)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/pci/fixup.c:929:13: note: each undeclared identifier is reported only once for each function it appears in
>> arch/x86/pci/fixup.c:929:40: error: 'PM_SUSPEND_ON' undeclared (first use in this function); did you mean 'RPM_SUSPENDING'?
     929 |         if (pm_suspend_target_state == PM_SUSPEND_ON)
         |                                        ^~~~~~~~~~~~~
         |                                        RPM_SUSPENDING
   arch/x86/pci/fixup.c: In function 'amd_rp_pme_resume':
>> arch/x86/pci/fixup.c:951:27: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
     951 |         rp->pme_support = FIELD_GET(PCI_PM_CAP_PME_MASK, pmc);
         |                           ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +/pm_suspend_target_state +929 arch/x86/pci/fixup.c

   907	
   908	#ifdef CONFIG_SUSPEND
   909	/*
   910	 * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
   911	 * if the SoC is put into a hardware sleep state by the amd-pmc driver, the
   912	 * Root Ports don't generate wakeup interrupts for USB devices.
   913	 *
   914	 * When suspending, remove D3hot and D3cold from the PME_Support advertised
   915	 * by the Root Port so we don't use those states if we're expecting wakeup
   916	 * interrupts.  Restore the advertised PME_Support when resuming.
   917	 */
   918	static void amd_rp_pme_suspend(struct pci_dev *dev)
   919	{
   920		struct pci_dev *rp;
   921	
   922		/*
   923		 * PM_SUSPEND_ON means we're doing runtime suspend, which means
   924		 * amd-pmc will not be involved so PMEs during D3 work as advertised.
   925		 *
   926		 * The PMEs *do* work if amd-pmc doesn't put the SoC in the hardware
   927		 * sleep state, but we assume amd-pmc is always present.
   928		 */
 > 929		if (pm_suspend_target_state == PM_SUSPEND_ON)
   930			return;
   931	
   932		rp = pcie_find_root_port(dev);
   933		if (!rp->pm_cap)
   934			return;
   935	
   936		rp->pme_support &= ~((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) >>
   937					    PCI_PM_CAP_PME_SHIFT);
   938		dev_info_once(&rp->dev, "quirk: disabling D3cold for suspend\n");
   939	}
   940	
   941	static void amd_rp_pme_resume(struct pci_dev *dev)
   942	{
   943		struct pci_dev *rp;
   944		u16 pmc;
   945	
   946		rp = pcie_find_root_port(dev);
   947		if (!rp->pm_cap)
   948			return;
   949	
   950		pci_read_config_word(rp, rp->pm_cap + PCI_PM_PMC, &pmc);
 > 951		rp->pme_support = FIELD_GET(PCI_PM_CAP_PME_MASK, pmc);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
