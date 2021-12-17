Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB59B4781F5
	for <lists+linux-pci@lfdr.de>; Fri, 17 Dec 2021 02:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhLQBKj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Dec 2021 20:10:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:24258 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231668AbhLQBKj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Dec 2021 20:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639703438; x=1671239438;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jKnTYvncOsinIOyQPEr4AMQJMkKxI3pFBvUzOvpDAjU=;
  b=nBI7NCnJn/CJ2hM6dZuZrPeBSBTjqO7QR4t8vtJ3j4rdQN8/v0A3CwE5
   5P5PCE+VnR26g1Z6nYOZfHeB10/jDTUyRwmWrhk4hl1Gj6NtJY69oqk2c
   mT+5lRxNiGaWKTICDyTSCvHF6iFLJlzZz09mfYicTo4GD0Vu8pd1U9adq
   N4M/i9GrBQIYPJLVuvnXf9rrqWUw/nvNxZcWkQVyM+EzNN7zgESbvhVDV
   VfLFA4TtdHgQp9pnzlLwm3ZzWeNiQ0o6WrAt5WzvAFCLO6CD0xRDCRPdM
   ikXvC7SO1yDqSI250EjBavJEpjgOWTTm0Tf0FyeKWMNSgtJ1GB28m66SY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="220331226"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="220331226"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 17:10:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="519531651"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Dec 2021 17:10:32 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1my1lX-00042Y-VY; Fri, 17 Dec 2021 01:10:31 +0000
Date:   Fri, 17 Dec 2021 09:09:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fan Fei <ffclaire1224@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [helgaas-pci:pci/driver-cleanup 14/27]
 drivers/pci/controller/pcie-mediatek-gen3.c:151: warning: expecting
 prototype for struct mtk_pcie_port. Prototype was for struct mtk_gen3_pcie
 instead
Message-ID: <202112170916.II7BBAEo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/driver-cleanup
head:   aa9d693603e587626f4e7835e5a5585defe7d52f
commit: 54980de2f55d759e2ee0ba80040f7aa4ccac643c [14/27] PCI: mediatek-gen3: Rename struct mtk_pcie_port to mtk_gen_pcie
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20211217/202112170916.II7BBAEo-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=54980de2f55d759e2ee0ba80040f7aa4ccac643c
        git remote add helgaas-pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
        git fetch --no-tags helgaas-pci pci/driver-cleanup
        git checkout 54980de2f55d759e2ee0ba80040f7aa4ccac643c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/pci/controller/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/pcie-mediatek-gen3.c:151: warning: expecting prototype for struct mtk_pcie_port. Prototype was for struct mtk_gen3_pcie instead


vim +151 drivers/pci/controller/pcie-mediatek-gen3.c

1bdafba538be70 Jianjun Wang 2021-04-20  111  
d3bf75b579b980 Jianjun Wang 2021-04-20  112  /**
d3bf75b579b980 Jianjun Wang 2021-04-20  113   * struct mtk_pcie_port - PCIe port information
d3bf75b579b980 Jianjun Wang 2021-04-20  114   * @dev: pointer to PCIe device
d3bf75b579b980 Jianjun Wang 2021-04-20  115   * @base: IO mapped register base
d3bf75b579b980 Jianjun Wang 2021-04-20  116   * @reg_base: physical register base
d3bf75b579b980 Jianjun Wang 2021-04-20  117   * @mac_reset: MAC reset control
d3bf75b579b980 Jianjun Wang 2021-04-20  118   * @phy_reset: PHY reset control
d3bf75b579b980 Jianjun Wang 2021-04-20  119   * @phy: PHY controller block
d3bf75b579b980 Jianjun Wang 2021-04-20  120   * @clks: PCIe clocks
d3bf75b579b980 Jianjun Wang 2021-04-20  121   * @num_clks: PCIe clocks count for this port
814cceebba9b7d Jianjun Wang 2021-04-20  122   * @irq: PCIe controller interrupt number
d537dc125f0756 Jianjun Wang 2021-04-20  123   * @saved_irq_state: IRQ enable state saved at suspend time
814cceebba9b7d Jianjun Wang 2021-04-20  124   * @irq_lock: lock protecting IRQ register access
814cceebba9b7d Jianjun Wang 2021-04-20  125   * @intx_domain: legacy INTx IRQ domain
1bdafba538be70 Jianjun Wang 2021-04-20  126   * @msi_domain: MSI IRQ domain
1bdafba538be70 Jianjun Wang 2021-04-20  127   * @msi_bottom_domain: MSI IRQ bottom domain
1bdafba538be70 Jianjun Wang 2021-04-20  128   * @msi_sets: MSI sets information
1bdafba538be70 Jianjun Wang 2021-04-20  129   * @lock: lock protecting IRQ bit map
1bdafba538be70 Jianjun Wang 2021-04-20  130   * @msi_irq_in_use: bit map for assigned MSI IRQ
d3bf75b579b980 Jianjun Wang 2021-04-20  131   */
54980de2f55d75 Fan Fei      2021-11-27  132  struct mtk_gen3_pcie {
d3bf75b579b980 Jianjun Wang 2021-04-20  133  	struct device *dev;
d3bf75b579b980 Jianjun Wang 2021-04-20  134  	void __iomem *base;
d3bf75b579b980 Jianjun Wang 2021-04-20  135  	phys_addr_t reg_base;
d3bf75b579b980 Jianjun Wang 2021-04-20  136  	struct reset_control *mac_reset;
d3bf75b579b980 Jianjun Wang 2021-04-20  137  	struct reset_control *phy_reset;
d3bf75b579b980 Jianjun Wang 2021-04-20  138  	struct phy *phy;
d3bf75b579b980 Jianjun Wang 2021-04-20  139  	struct clk_bulk_data *clks;
d3bf75b579b980 Jianjun Wang 2021-04-20  140  	int num_clks;
814cceebba9b7d Jianjun Wang 2021-04-20  141  
814cceebba9b7d Jianjun Wang 2021-04-20  142  	int irq;
d537dc125f0756 Jianjun Wang 2021-04-20  143  	u32 saved_irq_state;
814cceebba9b7d Jianjun Wang 2021-04-20  144  	raw_spinlock_t irq_lock;
814cceebba9b7d Jianjun Wang 2021-04-20  145  	struct irq_domain *intx_domain;
1bdafba538be70 Jianjun Wang 2021-04-20  146  	struct irq_domain *msi_domain;
1bdafba538be70 Jianjun Wang 2021-04-20  147  	struct irq_domain *msi_bottom_domain;
1bdafba538be70 Jianjun Wang 2021-04-20  148  	struct mtk_msi_set msi_sets[PCIE_MSI_SET_NUM];
1bdafba538be70 Jianjun Wang 2021-04-20  149  	struct mutex lock;
1bdafba538be70 Jianjun Wang 2021-04-20  150  	DECLARE_BITMAP(msi_irq_in_use, PCIE_MSI_IRQS_NUM);
d3bf75b579b980 Jianjun Wang 2021-04-20 @151  };
d3bf75b579b980 Jianjun Wang 2021-04-20  152  

:::::: The code at line 151 was first introduced by commit
:::::: d3bf75b579b980b9d83a76d3b4d8bfb9f55b24ca PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192

:::::: TO: Jianjun Wang <jianjun.wang@mediatek.com>
:::::: CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
