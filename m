Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CD05ABCB9
	for <lists+linux-pci@lfdr.de>; Sat,  3 Sep 2022 06:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiICEHw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Sep 2022 00:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiICEHv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Sep 2022 00:07:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1EA82F9D;
        Fri,  2 Sep 2022 21:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662178070; x=1693714070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T+fPZphr6c6IlXiy2pembOOg+9Rn7WUe3VZoUGJMCJI=;
  b=bNKesWMkEjinlSV2RrgbEFWBNJV7uAtIopoeNqlNN/7xaIBSABfFzmHe
   ywmRHoCPNGT/rxibaTsE3gsC4cuTDh6UmipwEvojrAWbXd1Yfp4bkmBBV
   Q9tAZTO6PNA5GvF/D3pMDh+EjcOICEJrcaQgMxjlswYV7fZm+C98QxqB0
   jlAocylcmBbwxmDTaNB5j9uK6n1zvcZChtQ2sYtf86nq1nRKjgDVsWLQO
   laSRchBMNWU3idkE5dUf5wXTK7hAWILQGmiEIOW8Np7garOLBrR2GLEwN
   GiCXXUUcrOxTPFNCeLrBjQRvgPY1s7HxBdM/3CRDZuOjjzUVP041CjPLG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="276527341"
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="276527341"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 21:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="590305618"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 02 Sep 2022 21:07:47 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUKRe-000123-1b;
        Sat, 03 Sep 2022 04:07:46 +0000
Date:   Sat, 3 Sep 2022 12:07:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 3/3] PCI/PM: Always disable PTM for all devices during
 suspend
Message-ID: <202209031120.PkNnRSt8-lkp@intel.com>
References: <20220902233543.390890-4-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902233543.390890-4-helgaas@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

I love your patch! Yet something to improve:

[auto build test ERROR on helgaas-pci/next]
[also build test ERROR on linus/master v6.0-rc3 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bjorn-Helgaas/PCI-PM-Always-disable-PTM-for-all-devices-during-suspend/20220903-073808
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: riscv-randconfig-r042-20220901 (https://download.01.org/0day-ci/archive/20220903/202209031120.PkNnRSt8-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/809e1c954b459ee37193c4ab9fa843243fbd7fa9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bjorn-Helgaas/PCI-PM-Always-disable-PTM-for-all-devices-during-suspend/20220903-073808
        git checkout 809e1c954b459ee37193c4ab9fa843243fbd7fa9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/pci/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/pci/pci-driver.c:1350:15: error: no member named 'ptm_enabled' in 'struct pci_dev'
           if (pci_dev->ptm_enabled)
               ~~~~~~~  ^
   1 error generated.


vim +1350 drivers/pci/pci-driver.c

  1335	
  1336	static int pci_pm_runtime_resume(struct device *dev)
  1337	{
  1338		struct pci_dev *pci_dev = to_pci_dev(dev);
  1339		const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
  1340		pci_power_t prev_state = pci_dev->current_state;
  1341		int error = 0;
  1342	
  1343		/*
  1344		 * Restoring config space is necessary even if the device is not bound
  1345		 * to a driver because although we left it in D0, it may have gone to
  1346		 * D3cold when the bridge above it runtime suspended.
  1347		 */
  1348		pci_pm_default_resume_early(pci_dev);
  1349	
> 1350		if (pci_dev->ptm_enabled)
  1351			pci_enable_ptm(pci_dev, NULL);
  1352	
  1353		if (!pci_dev->driver)
  1354			return 0;
  1355	
  1356		pci_fixup_device(pci_fixup_resume_early, pci_dev);
  1357		pci_pm_default_resume(pci_dev);
  1358	
  1359		if (prev_state == PCI_D3cold)
  1360			pci_pm_bridge_power_up_actions(pci_dev);
  1361	
  1362		if (pm && pm->runtime_resume)
  1363			error = pm->runtime_resume(dev);
  1364	
  1365		return error;
  1366	}
  1367	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
