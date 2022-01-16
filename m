Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0988B48FE7D
	for <lists+linux-pci@lfdr.de>; Sun, 16 Jan 2022 19:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiAPSmR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Jan 2022 13:42:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:42182 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231636AbiAPSmQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 16 Jan 2022 13:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642358536; x=1673894536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RoWDaQHVLToFqiErYL8/UDJpfJ/pR8L9AWSSU1RDlHg=;
  b=NezUK/LjjLDVa+wohQty6MFaN3IwolBVrzw563XU/yFdGVu9qhAhrZV3
   PmGw9QtzS4pMHUJWSZEAKuUgxNu2cY5JhC+Z0EMQYyIg7NTCjk0QI1n9M
   eC/Cwu8ExOGjjVWaOGw4G6o0MpI3DmhpBWfzD8LuakfZknEmKo9kUHr8W
   frChX6IKI4FYvw36syt68raM2sSNroOjlCJDdLpDy1f2WUoul+JjkZ4iE
   4Z+5iJe27oHMQFeBEKjI+iGl9Ou0sywpGGopHpJnUXP1pXlpWeo/mBUpL
   nP0TNcPSu23+Rdif7EkjcWH5C2ghXezgFe0qUgmlRAX8Rmm1ugXtS0JLV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="224488483"
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="224488483"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 10:42:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="476406933"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 16 Jan 2022 10:42:13 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9ATk-000Auj-I5; Sun, 16 Jan 2022 18:42:12 +0000
Date:   Mon, 17 Jan 2022 02:41:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     marek.vasut@gmail.com, linux-pci@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa-dev@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: rcar: Finish transition to L1 state in
 rcar_pcie_config_access()
Message-ID: <202201170208.glCZ5BJW-lkp@intel.com>
References: <20220116022549.456486-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116022549.456486-1-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I love your patch! Yet something to improve:

[auto build test ERROR on helgaas-pci/next]
[also build test ERROR on next-20220116]
[cannot apply to v5.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/marek-vasut-gmail-com/PCI-rcar-Finish-transition-to-L1-state-in-rcar_pcie_config_access/20220116-102631
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: powerpc-randconfig-r004-20220116 (https://download.01.org/0day-ci/archive/20220117/202201170208.glCZ5BJW-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/dff324f279a78c9ca7f04c3fcf603b40d5a893fa
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review marek-vasut-gmail-com/PCI-rcar-Finish-transition-to-L1-state-in-rcar_pcie_config_access/20220116-102631
        git checkout dff324f279a78c9ca7f04c3fcf603b40d5a893fa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/pci/controller/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/rwsem.h:15,
                    from include/linux/notifier.h:15,
                    from include/linux/clk.h:14,
                    from drivers/pci/controller/pcie-rcar-host.c:15:
   drivers/pci/controller/pcie-rcar-host.c: In function 'rcar_pcie_config_access':
>> drivers/pci/controller/pcie-rcar-host.c:120:28: error: 'pmsr_lock' undeclared (first use in this function); did you mean 'pmd_lock'?
     120 |         spin_lock_irqsave(&pmsr_lock, flags);
         |                            ^~~~~~~~~
   include/linux/spinlock.h:242:48: note: in definition of macro 'raw_spin_lock_irqsave'
     242 |                 flags = _raw_spin_lock_irqsave(lock);   \
         |                                                ^~~~
   drivers/pci/controller/pcie-rcar-host.c:120:9: note: in expansion of macro 'spin_lock_irqsave'
     120 |         spin_lock_irqsave(&pmsr_lock, flags);
         |         ^~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-rcar-host.c:120:28: note: each undeclared identifier is reported only once for each function it appears in
     120 |         spin_lock_irqsave(&pmsr_lock, flags);
         |                            ^~~~~~~~~
   include/linux/spinlock.h:242:48: note: in definition of macro 'raw_spin_lock_irqsave'
     242 |                 flags = _raw_spin_lock_irqsave(lock);   \
         |                                                ^~~~
   drivers/pci/controller/pcie-rcar-host.c:120:9: note: in expansion of macro 'spin_lock_irqsave'
     120 |         spin_lock_irqsave(&pmsr_lock, flags);
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pci/controller/pcie-rcar-host.c:121:15: error: implicit declaration of function 'rcar_pcie_wakeup' [-Werror=implicit-function-declaration]
     121 |         ret = rcar_pcie_wakeup(pcie->dev, pcie->base);
         |               ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +120 drivers/pci/controller/pcie-rcar-host.c

  > 15	#include <linux/clk.h>
    16	#include <linux/clk-provider.h>
    17	#include <linux/delay.h>
    18	#include <linux/interrupt.h>
    19	#include <linux/irq.h>
    20	#include <linux/irqdomain.h>
    21	#include <linux/kernel.h>
    22	#include <linux/init.h>
    23	#include <linux/iopoll.h>
    24	#include <linux/msi.h>
    25	#include <linux/of_address.h>
    26	#include <linux/of_irq.h>
    27	#include <linux/of_platform.h>
    28	#include <linux/pci.h>
    29	#include <linux/phy/phy.h>
    30	#include <linux/platform_device.h>
    31	#include <linux/pm_runtime.h>
    32	
    33	#include "pcie-rcar.h"
    34	
    35	struct rcar_msi {
    36		DECLARE_BITMAP(used, INT_PCI_MSI_NR);
    37		struct irq_domain *domain;
    38		struct mutex map_lock;
    39		spinlock_t mask_lock;
    40		int irq1;
    41		int irq2;
    42	};
    43	
    44	#ifdef CONFIG_ARM
    45	/*
    46	 * Here we keep a static copy of the remapped PCIe controller address.
    47	 * This is only used on aarch32 systems, all of which have one single
    48	 * PCIe controller, to provide quick access to the PCIe controller in
    49	 * the L1 link state fixup function, called from the ARM fault handler.
    50	 */
    51	static void __iomem *pcie_base;
    52	/*
    53	 * Static copy of PCIe device pointer, so we can check whether the
    54	 * device is runtime suspended or not.
    55	 */
    56	static struct device *pcie_dev;
    57	
    58	static DEFINE_SPINLOCK(pmsr_lock);
    59	static int rcar_pcie_wakeup(struct device *pcie_dev, void __iomem *pcie_base)
    60	{
    61		u32 pmsr, val;
    62		int ret = 0;
    63	
    64		if (!pcie_base || pm_runtime_suspended(pcie_dev))
    65			return 1;
    66	
    67		pmsr = readl(pcie_base + PMSR);
    68	
    69		/*
    70		 * Test if the PCIe controller received PM_ENTER_L1 DLLP and
    71		 * the PCIe controller is not in L1 link state. If true, apply
    72		 * fix, which will put the controller into L1 link state, from
    73		 * which it can return to L0s/L0 on its own.
    74		 */
    75		if ((pmsr & PMEL1RX) && ((pmsr & PMSTATE) != PMSTATE_L1)) {
    76			writel(L1IATN, pcie_base + PMCTLR);
    77			ret = readl_poll_timeout_atomic(pcie_base + PMSR, val,
    78							val & L1FAEG, 10, 1000);
    79			WARN(ret, "Timeout waiting for L1 link state, ret=%d\n", ret);
    80			writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
    81		}
    82	
    83		return ret;
    84	}
    85	#endif
    86	
    87	/* Structure representing the PCIe interface */
    88	struct rcar_pcie_host {
    89		struct rcar_pcie	pcie;
    90		struct phy		*phy;
    91		struct clk		*bus_clk;
    92		struct			rcar_msi msi;
    93		int			(*phy_init_fn)(struct rcar_pcie_host *host);
    94	};
    95	
    96	static struct rcar_pcie_host *msi_to_host(struct rcar_msi *msi)
    97	{
    98		return container_of(msi, struct rcar_pcie_host, msi);
    99	}
   100	
   101	static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
   102	{
   103		unsigned int shift = BITS_PER_BYTE * (where & 3);
   104		u32 val = rcar_pci_read_reg(pcie, where & ~3);
   105	
   106		return val >> shift;
   107	}
   108	
   109	/* Serialization is provided by 'pci_lock' in drivers/pci/access.c */
   110	static int rcar_pcie_config_access(struct rcar_pcie_host *host,
   111			unsigned char access_type, struct pci_bus *bus,
   112			unsigned int devfn, int where, u32 *data)
   113	{
   114		struct rcar_pcie *pcie = &host->pcie;
   115		unsigned int dev, func, reg, index;
   116		unsigned long flags;
   117		int ret;
   118	
   119		/* Wake the bus up in case it is in L1 state. */
 > 120		spin_lock_irqsave(&pmsr_lock, flags);
 > 121		ret = rcar_pcie_wakeup(pcie->dev, pcie->base);
   122		spin_unlock_irqrestore(&pmsr_lock, flags);
   123		if (ret)
   124			return ret;
   125	
   126		dev = PCI_SLOT(devfn);
   127		func = PCI_FUNC(devfn);
   128		reg = where & ~3;
   129		index = reg / 4;
   130	
   131		/*
   132		 * While each channel has its own memory-mapped extended config
   133		 * space, it's generally only accessible when in endpoint mode.
   134		 * When in root complex mode, the controller is unable to target
   135		 * itself with either type 0 or type 1 accesses, and indeed, any
   136		 * controller initiated target transfer to its own config space
   137		 * result in a completer abort.
   138		 *
   139		 * Each channel effectively only supports a single device, but as
   140		 * the same channel <-> device access works for any PCI_SLOT()
   141		 * value, we cheat a bit here and bind the controller's config
   142		 * space to devfn 0 in order to enable self-enumeration. In this
   143		 * case the regular ECAR/ECDR path is sidelined and the mangled
   144		 * config access itself is initiated as an internal bus transaction.
   145		 */
   146		if (pci_is_root_bus(bus)) {
   147			if (dev != 0)
   148				return PCIBIOS_DEVICE_NOT_FOUND;
   149	
   150			if (access_type == RCAR_PCI_ACCESS_READ)
   151				*data = rcar_pci_read_reg(pcie, PCICONF(index));
   152			else
   153				rcar_pci_write_reg(pcie, *data, PCICONF(index));
   154	
   155			return PCIBIOS_SUCCESSFUL;
   156		}
   157	
   158		/* Clear errors */
   159		rcar_pci_write_reg(pcie, rcar_pci_read_reg(pcie, PCIEERRFR), PCIEERRFR);
   160	
   161		/* Set the PIO address */
   162		rcar_pci_write_reg(pcie, PCIE_CONF_BUS(bus->number) |
   163			PCIE_CONF_DEV(dev) | PCIE_CONF_FUNC(func) | reg, PCIECAR);
   164	
   165		/* Enable the configuration access */
   166		if (pci_is_root_bus(bus->parent))
   167			rcar_pci_write_reg(pcie, CONFIG_SEND_ENABLE | TYPE0, PCIECCTLR);
   168		else
   169			rcar_pci_write_reg(pcie, CONFIG_SEND_ENABLE | TYPE1, PCIECCTLR);
   170	
   171		/* Check for errors */
   172		if (rcar_pci_read_reg(pcie, PCIEERRFR) & UNSUPPORTED_REQUEST)
   173			return PCIBIOS_DEVICE_NOT_FOUND;
   174	
   175		/* Check for master and target aborts */
   176		if (rcar_read_conf(pcie, RCONF(PCI_STATUS)) &
   177			(PCI_STATUS_REC_MASTER_ABORT | PCI_STATUS_REC_TARGET_ABORT))
   178			return PCIBIOS_DEVICE_NOT_FOUND;
   179	
   180		if (access_type == RCAR_PCI_ACCESS_READ)
   181			*data = rcar_pci_read_reg(pcie, PCIECDR);
   182		else
   183			rcar_pci_write_reg(pcie, *data, PCIECDR);
   184	
   185		/* Disable the configuration access */
   186		rcar_pci_write_reg(pcie, 0, PCIECCTLR);
   187	
   188		return PCIBIOS_SUCCESSFUL;
   189	}
   190	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
