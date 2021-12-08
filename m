Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A9646D176
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 11:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhLHLCR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 06:02:17 -0500
Received: from mga06.intel.com ([134.134.136.31]:64146 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhLHLCQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Dec 2021 06:02:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="298601199"
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="298601199"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 02:58:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="679850490"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Dec 2021 02:58:40 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muuem-0000Rf-55; Wed, 08 Dec 2021 10:58:40 +0000
Date:   Wed, 8 Dec 2021 18:58:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>,
        nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, kw@linux.com, bhelgaas@google.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] PCI/ASPM: Add ASPM BIOS override function
Message-ID: <202112081821.vVNb7kbL-lkp@intel.com>
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
[also build test ERROR on next-20211207]
[cannot apply to helgaas-pci/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/David-E-Box/PCI-ASPM-Add-ASPM-BIOS-override-function/20211208-082303
base:    0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
config: arm64-randconfig-r022-20211207 (https://download.01.org/0day-ci/archive/20211208/202112081821.vVNb7kbL-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/78c85417651fe465aafee7ef1841ab75619b165b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review David-E-Box/PCI-ASPM-Add-ASPM-BIOS-override-function/20211208-082303
        git checkout 78c85417651fe465aafee7ef1841ab75619b165b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash ./ drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/pci/controller/pci-aardvark.c:28:
>> drivers/pci/controller/../pci.h:571:82: error: expected ';' after return statement
   static inline int pcie_aspm_policy_override(struct pci_dev *dev) { return -EINVAL }
                                                                                    ^
                                                                                    ;
   1 error generated.
--
   In file included from drivers/pci/controller/dwc/pci-dra7xx.c:32:
>> drivers/pci/controller/dwc/../../pci.h:571:82: error: expected ';' after return statement
   static inline int pcie_aspm_policy_override(struct pci_dev *dev) { return -EINVAL }
                                                                                    ^
                                                                                    ;
   1 error generated.
--
   In file included from drivers/pci/pcie/portdrv_core.c:19:
>> drivers/pci/pcie/../pci.h:571:82: error: expected ';' after return statement
   static inline int pcie_aspm_policy_override(struct pci_dev *dev) { return -EINVAL }
                                                                                    ^
                                                                                    ;
   1 error generated.
--
   In file included from drivers/pci/hotplug/pci_hotplug_core.c:32:
>> drivers/pci/hotplug/../pci.h:571:82: error: expected ';' after return statement
   static inline int pcie_aspm_policy_override(struct pci_dev *dev) { return -EINVAL }
                                                                                    ^
                                                                                    ;
   1 error generated.
--
   In file included from drivers/xen/pci.c:18:
>> drivers/xen/../pci/pci.h:571:82: error: expected ';' after return statement
   static inline int pcie_aspm_policy_override(struct pci_dev *dev) { return -EINVAL }
                                                                                    ^
                                                                                    ;
   1 error generated.
--
   In file included from drivers/pci/controller/mobiveil/pcie-mobiveil.c:18:
   In file included from drivers/pci/controller/mobiveil/pcie-mobiveil.h:18:
>> drivers/pci/controller/mobiveil/../../pci.h:571:82: error: expected ';' after return statement
   static inline int pcie_aspm_policy_override(struct pci_dev *dev) { return -EINVAL }
                                                                                    ^
                                                                                    ;
   1 error generated.


vim +571 drivers/pci/controller/../pci.h

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
