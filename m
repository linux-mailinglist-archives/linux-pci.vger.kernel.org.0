Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945504F86EF
	for <lists+linux-pci@lfdr.de>; Thu,  7 Apr 2022 20:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346786AbiDGSMJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Apr 2022 14:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346789AbiDGSMH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2022 14:12:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97E4226A19
        for <linux-pci@vger.kernel.org>; Thu,  7 Apr 2022 11:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649355006; x=1680891006;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8ikGCgbfspjsB5U0T91jjgBWz2OOtj5sQs8vam2N/xg=;
  b=XH14LGJ+m3Qd0dx4/nrh1D3uVxB9G2mulXrB4qnNuIc6nnZeFw9jd4Tq
   mS2lZ3GiTL9/OwfIiRn7PdqDjpa5HtyV2wbHAyxWD8MZTGx9j4LFYzTKq
   oF6/b1YAv+Od9z6iyZEzM6ApE2LaLT9mXtSlY8fTXl5LDbU38iY4MSyO/
   mF7y6NhtS7antyqkvWMA6iA25SftDy7rdgs/HvwDkQ04rRhO/URCgW2Xz
   XsGhwH+qEA2pqIStpFJ9GsdxF+VczHFvBu16qEEXM4gs0foOLzDd9BAzQ
   zjkcyRFEYeY7h2EO+dUBx3Uetp5vmPu8bR30wbxAiKgdmhsDcrQMu7xCC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="347841369"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="347841369"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 11:10:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="652926212"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 07 Apr 2022 11:10:04 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncWa4-0005f3-5J;
        Thu, 07 Apr 2022 18:10:04 +0000
Date:   Fri, 8 Apr 2022 02:09:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [helgaas-pci:pci/pm 1/1] drivers/pci/pci-driver.c:1315:9: error:
 implicit declaration of function 'pci_pm_default_resume_early'; did you mean
 'pci_pm_default_resume'?
Message-ID: <202204080225.iXDZAkO2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/pm
head:   53b3488879cff3b3a238e3e9651c2e2879f422cf
commit: 53b3488879cff3b3a238e3e9651c2e2879f422cf [1/1] PCI/PM: Power up all devices during runtime resume
config: i386-randconfig-a014 (https://download.01.org/0day-ci/archive/20220408/202204080225.iXDZAkO2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=53b3488879cff3b3a238e3e9651c2e2879f422cf
        git remote add helgaas-pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
        git fetch --no-tags helgaas-pci pci/pm
        git checkout 53b3488879cff3b3a238e3e9651c2e2879f422cf
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pci/pci-driver.c: In function 'pci_pm_runtime_resume':
>> drivers/pci/pci-driver.c:1315:9: error: implicit declaration of function 'pci_pm_default_resume_early'; did you mean 'pci_pm_default_resume'? [-Werror=implicit-function-declaration]
    1315 |         pci_pm_default_resume_early(pci_dev);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         pci_pm_default_resume
   At top level:
   drivers/pci/pci-driver.c:533:12: warning: 'pci_restore_standard_config' defined but not used [-Wunused-function]
     533 | static int pci_restore_standard_config(struct pci_dev *pci_dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1315 drivers/pci/pci-driver.c

  1302	
  1303	static int pci_pm_runtime_resume(struct device *dev)
  1304	{
  1305		struct pci_dev *pci_dev = to_pci_dev(dev);
  1306		const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
  1307		pci_power_t prev_state = pci_dev->current_state;
  1308		int error = 0;
  1309	
  1310		/*
  1311		 * Restoring config space is necessary even if the device is not bound
  1312		 * to a driver because although we left it in D0, it may have gone to
  1313		 * D3cold when the bridge above it runtime suspended.
  1314		 */
> 1315		pci_pm_default_resume_early(pci_dev);
  1316	
  1317		if (!pci_dev->driver)
  1318			return 0;
  1319	
  1320		pci_fixup_device(pci_fixup_resume_early, pci_dev);
  1321		pci_pm_default_resume(pci_dev);
  1322	
  1323		if (prev_state == PCI_D3cold)
  1324			pci_bridge_wait_for_secondary_bus(pci_dev);
  1325	
  1326		if (pm && pm->runtime_resume)
  1327			error = pm->runtime_resume(dev);
  1328	
  1329		pci_dev->runtime_d3cold = false;
  1330	
  1331		return error;
  1332	}
  1333	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
