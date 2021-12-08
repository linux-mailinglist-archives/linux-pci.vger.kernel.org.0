Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E9146D17E
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 11:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbhLHLDQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 06:03:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:10195 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229496AbhLHLDP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Dec 2021 06:03:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="237748789"
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="237748789"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 02:59:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="462724172"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 08 Dec 2021 02:59:40 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muufk-0000SZ-6p; Wed, 08 Dec 2021 10:59:40 +0000
Date:   Wed, 8 Dec 2021 18:58:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>,
        nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, kw@linux.com, bhelgaas@google.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] PCI/ASPM: Add ASPM BIOS override function
Message-ID: <202112081833.kaiKplAi-lkp@intel.com>
References: <20211208002043.882200-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208002043.882200-1-david.e.box@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi "David,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.16-rc4]
[also build test ERROR on next-20211208]
[cannot apply to helgaas-pci/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/David-E-Box/PCI-ASPM-Add-ASPM-BIOS-override-function/20211208-082303
base:    0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
config: i386-randconfig-r024-20211207 (https://download.01.org/0day-ci/archive/20211208/202112081833.kaiKplAi-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/78c85417651fe465aafee7ef1841ab75619b165b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review David-E-Box/PCI-ASPM-Add-ASPM-BIOS-override-function/20211208-082303
        git checkout 78c85417651fe465aafee7ef1841ab75619b165b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/pci/controller/cadence/pci-j721e.c:23:
>> drivers/pci/controller/cadence/../../pci.h:571:82: error: expected ';' after return statement
   static inline int pcie_aspm_policy_override(struct pci_dev *dev) { return -EINVAL }
                                                                                    ^
                                                                                    ;
   1 error generated.


vim +571 drivers/pci/controller/cadence/../../pci.h

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
