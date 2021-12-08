Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727E246C998
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 01:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbhLHAzx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 19:55:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:14399 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233074AbhLHAzx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Dec 2021 19:55:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="217750492"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="217750492"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 16:52:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="751677756"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 07 Dec 2021 16:52:19 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mulBy-000NAB-Og; Wed, 08 Dec 2021 00:52:18 +0000
Date:   Wed, 8 Dec 2021 08:51:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>,
        nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, kw@linux.com, bhelgaas@google.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [V2 1/2] PCI/ASPM: Add ASPM BIOS override function
Message-ID: <202112080830.ItjrEFOo-lkp@intel.com>
References: <20211207223050.872095-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207223050.872095-1-david.e.box@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi "David,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.16-rc4]
[also build test ERROR on next-20211207]
[cannot apply to helgaas-pci/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/David-E-Box/PCI-ASPM-Add-ASPM-BIOS-override-function/20211208-063240
base:    0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
config: nds32-defconfig (https://download.01.org/0day-ci/archive/20211208/202112080830.ItjrEFOo-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/efd5524bd4005ec84d4eb6681c54d1ba93fe9ca1
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review David-E-Box/PCI-ASPM-Add-ASPM-BIOS-override-function/20211208-063240
        git checkout efd5524bd4005ec84d4eb6681c54d1ba93fe9ca1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/pci/of.c:16:
   drivers/pci/pci.h: In function 'pcie_aspm_policy_override':
>> drivers/pci/pci.h:571:83: error: expected ';' before '}' token
     571 | static inline int pcie_aspm_policy_override(struct pci_dev *dev) { return -EINVAL }
         |                                                                                   ^


vim +571 drivers/pci/pci.h

   553	
   554	/* PCI error reporting and recovery */
   555	pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
   556			pci_channel_state_t state,
   557			pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev));
   558	
   559	bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
   560	#ifdef CONFIG_PCIEASPM
   561	void pcie_aspm_init_link_state(struct pci_dev *pdev);
   562	void pcie_aspm_exit_link_state(struct pci_dev *pdev);
   563	void pcie_aspm_pm_state_change(struct pci_dev *pdev);
   564	void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
   565	int pcie_aspm_policy_override(struct pci_dev *dev);
   566	#else
   567	static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
   568	static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
   569	static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
   570	static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
 > 571	static inline int pcie_aspm_policy_override(struct pci_dev *dev) { return -EINVAL }
   572	#endif
   573	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
