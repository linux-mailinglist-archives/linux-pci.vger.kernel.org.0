Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D7C7BB551
	for <lists+linux-pci@lfdr.de>; Fri,  6 Oct 2023 12:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjJFKdZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Oct 2023 06:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjJFKdY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Oct 2023 06:33:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7F09F
        for <linux-pci@vger.kernel.org>; Fri,  6 Oct 2023 03:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696588403; x=1728124403;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=if2DbiSbXczOLktQKNmjPWjll0iHKhW6IGipZHwsYkw=;
  b=SLjVlY+RtGY+xEgy5dZtLT6zXbtJI31TvxlB8kiWgsmtMXX5sWcl3Ink
   wML5q9OVKZTeZCZj7/ZZVYGwDP2ihUsI3qr3qLOXYTc7t8Mk8AV7AXcVl
   E2byTQ+0GpEHcsCwSeQkChKxi+Zoq+HiCSM8Cq97WCi0FDKRNF1eAL918
   MnxKoFrkxcTizQeQ1kA7H/dtSQFCSEM/TCR3Dl5dsTn9G6zWs2UmO5H23
   6pJprhku4Cg84kdJ9agdSiWHLE9ly7m55tdYspOufTWidWZn6NWIXQpkk
   GdivIm25d+EtQ6+OFRcKIKsKX+0LtEy9tnA3Q7vedpZRsVjR89EPpvQdj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2328240"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2328240"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 03:33:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="895836965"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="895836965"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 06 Oct 2023 03:31:49 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoi91-000MVi-0g;
        Fri, 06 Oct 2023 10:33:19 +0000
Date:   Fri, 6 Oct 2023 18:32:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [pci:pm 2/2] arch/x86/pci/fixup.c:929:6: error: use of undeclared
 identifier 'pm_suspend_target_state'
Message-ID: <202310061830.A7jaXxeG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pm
head:   624306d2c241c274e498619cabc2ae1dc7112ad1
commit: 624306d2c241c274e498619cabc2ae1dc7112ad1 [2/2] x86/PCI: Avoid PME from D3hot/D3cold for AMD Rembrandt and Phoenix USB4
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231006/202310061830.A7jaXxeG-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231006/202310061830.A7jaXxeG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310061830.A7jaXxeG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/pci/fixup.c:929:6: error: use of undeclared identifier 'pm_suspend_target_state'
           if (pm_suspend_target_state == PM_SUSPEND_ON)
               ^
>> arch/x86/pci/fixup.c:929:33: error: use of undeclared identifier 'PM_SUSPEND_ON'
           if (pm_suspend_target_state == PM_SUSPEND_ON)
                                          ^
>> arch/x86/pci/fixup.c:951:20: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           rp->pme_support = FIELD_GET(PCI_PM_CAP_PME_MASK, pmc);
                             ^
   3 errors generated.


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
