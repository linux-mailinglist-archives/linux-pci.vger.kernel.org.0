Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1076E36F556
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 07:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhD3FbW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 01:31:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:27972 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhD3FbW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Apr 2021 01:31:22 -0400
IronPort-SDR: 3LQYfJHliwuNvIl0TIBSTF5dvSph7YbRDLOOTcbd49X2K19AJ2j0hXrH4r6ZLVI5fBGQKfGsf2
 nz1Lu8DFg87A==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="197300691"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="gz'50?scan'50,208,50";a="197300691"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 22:30:33 -0700
IronPort-SDR: 7ntfv9pkY02lj1++CPlT0pOrC38KNh/ozHflKWw9tQfW9PY8KTFgoV9oVPSAfHGqzoEQYGGG6h
 VdhyCJaXxt0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="gz'50?scan'50,208,50";a="387246705"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Apr 2021 22:30:30 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lcLjR-0007zj-F9; Fri, 30 Apr 2021 05:30:29 +0000
Date:   Fri, 30 Apr 2021 13:29:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Simon Xue <xxm@rock-chips.com>, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Simon Xue <xxm@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v8 2/2] PCI: rockchip: Add Rockchip RK356X host
 controller driver
Message-ID: <202104301337.gEnMeGx7-lkp@intel.com>
References: <20210430012741.24811-1-xxm@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <20210430012741.24811-1-xxm@rock-chips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Simon,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on pci/next]
[also build test ERROR on v5.12 next-20210430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Simon-Xue/dt-bindings-rockchip-Add-DesignWare-based-PCIe-controller/20210430-092937
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: microblaze-randconfig-r032-20210430 (attached as .config)
compiler: microblaze-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d7f0227a3e8ea1c9594e9cec8fbd84715a987f2a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Simon-Xue/dt-bindings-rockchip-Add-DesignWare-based-PCIe-controller/20210430-092937
        git checkout d7f0227a3e8ea1c9594e9cec8fbd84715a987f2a
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=microblaze 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-designware-host.c:49:15: error: variable 'dw_pcie_msi_domain_info' has initializer but incomplete type
      49 | static struct msi_domain_info dw_pcie_msi_domain_info = {
         |               ^~~~~~~~~~~~~~~
>> drivers/pci/controller/dwc/pcie-designware-host.c:50:3: error: 'struct msi_domain_info' has no member named 'flags'
      50 |  .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
         |   ^~~~~
>> drivers/pci/controller/dwc/pcie-designware-host.c:50:12: error: 'MSI_FLAG_USE_DEF_DOM_OPS' undeclared here (not in a function)
      50 |  .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
         |            ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/dwc/pcie-designware-host.c:50:39: error: 'MSI_FLAG_USE_DEF_CHIP_OPS' undeclared here (not in a function)
      50 |  .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/dwc/pcie-designware-host.c:51:6: error: 'MSI_FLAG_PCI_MSIX' undeclared here (not in a function)
      51 |      MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
         |      ^~~~~~~~~~~~~~~~~
>> drivers/pci/controller/dwc/pcie-designware-host.c:51:26: error: 'MSI_FLAG_MULTI_PCI_MSI' undeclared here (not in a function)
      51 |      MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
         |                          ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/dwc/pcie-designware-host.c:50:11: warning: excess elements in struct initializer
      50 |  .flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
         |           ^
   drivers/pci/controller/dwc/pcie-designware-host.c:50:11: note: (near initialization for 'dw_pcie_msi_domain_info')
>> drivers/pci/controller/dwc/pcie-designware-host.c:52:3: error: 'struct msi_domain_info' has no member named 'chip'
      52 |  .chip = &dw_pcie_msi_irq_chip,
         |   ^~~~
   drivers/pci/controller/dwc/pcie-designware-host.c:52:10: warning: excess elements in struct initializer
      52 |  .chip = &dw_pcie_msi_irq_chip,
         |          ^
   drivers/pci/controller/dwc/pcie-designware-host.c:52:10: note: (near initialization for 'dw_pcie_msi_domain_info')
   drivers/pci/controller/dwc/pcie-designware-host.c: In function 'dw_pcie_allocate_domains':
>> drivers/pci/controller/dwc/pcie-designware-host.c:247:19: error: implicit declaration of function 'pci_msi_create_irq_domain'; did you mean 'pci_msi_get_device_domain'? [-Werror=implicit-function-declaration]
     247 |  pp->msi_domain = pci_msi_create_irq_domain(fwnode,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                   pci_msi_get_device_domain
>> drivers/pci/controller/dwc/pcie-designware-host.c:247:17: warning: assignment to 'struct irq_domain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     247 |  pp->msi_domain = pci_msi_create_irq_domain(fwnode,
         |                 ^
   drivers/pci/controller/dwc/pcie-designware-host.c: At top level:
>> drivers/pci/controller/dwc/pcie-designware-host.c:49:31: error: storage size of 'dw_pcie_msi_domain_info' isn't known
      49 | static struct msi_domain_info dw_pcie_msi_domain_info = {
         |                               ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PCIE_DW_HOST
   Depends on PCI && PCI_MSI_IRQ_DOMAIN
   Selected by
   - PCIE_ROCKCHIP_DW_HOST && PCI && (ARCH_ROCKCHIP || COMPILE_TEST && OF


vim +/dw_pcie_msi_domain_info +49 drivers/pci/controller/dwc/pcie-designware-host.c

7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06   48  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  @49  static struct msi_domain_info dw_pcie_msi_domain_info = {
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  @50  	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  @51  		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  @52  	.chip	= &dw_pcie_msi_irq_chip,
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15   53  };
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15   54  
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15   55  /* MSI int handler */
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15   56  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15   57  {
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15   58  	int i, pos, irq;
1137e61dcb99f7 drivers/pci/controller/dwc/pcie-designware-host.c Niklas Cassel          2019-09-04   59  	unsigned long val;
1137e61dcb99f7 drivers/pci/controller/dwc/pcie-designware-host.c Niklas Cassel          2019-09-04   60  	u32 status, num_ctrls;
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15   61  	irqreturn_t ret = IRQ_NONE;
f81c770df72e72 drivers/pci/controller/dwc/pcie-designware-host.c Rob Herring            2020-08-20   62  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15   63  
1f319cb0538a10 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06   64  	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
1f319cb0538a10 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06   65  
1f319cb0538a10 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06   66  	for (i = 0; i < num_ctrls; i++) {
f81c770df72e72 drivers/pci/controller/dwc/pcie-designware-host.c Rob Herring            2020-08-20   67  		status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
f81c770df72e72 drivers/pci/controller/dwc/pcie-designware-host.c Rob Herring            2020-08-20   68  					   (i * MSI_REG_CTRL_BLOCK_SIZE));
1137e61dcb99f7 drivers/pci/controller/dwc/pcie-designware-host.c Niklas Cassel          2019-09-04   69  		if (!status)
dbe4a09e8bbcf8 drivers/pci/dwc/pcie-designware-host.c            Bjorn Helgaas          2017-03-16   70  			continue;
dbe4a09e8bbcf8 drivers/pci/dwc/pcie-designware-host.c            Bjorn Helgaas          2017-03-16   71  
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15   72  		ret = IRQ_HANDLED;
1137e61dcb99f7 drivers/pci/controller/dwc/pcie-designware-host.c Niklas Cassel          2019-09-04   73  		val = status;
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15   74  		pos = 0;
1137e61dcb99f7 drivers/pci/controller/dwc/pcie-designware-host.c Niklas Cassel          2019-09-04   75  		while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
76cbf066b1ab75 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-05-14   76  					    pos)) != MAX_MSI_IRQS_PER_CTRL) {
76cbf066b1ab75 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-05-14   77  			irq = irq_find_mapping(pp->irq_domain,
76cbf066b1ab75 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-05-14   78  					       (i * MAX_MSI_IRQS_PER_CTRL) +
76cbf066b1ab75 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-05-14   79  					       pos);
8c934095fa2f33 drivers/pci/dwc/pcie-designware-host.c            Faiz Abbas             2017-08-10   80  			generic_handle_irq(irq);
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15   81  			pos++;
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15   82  		}
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15   83  	}
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15   84  
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15   85  	return ret;
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15   86  }
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15   87  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06   88  /* Chained MSI interrupt service routine */
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06   89  static void dw_chained_msi_isr(struct irq_desc *desc)
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15   90  {
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06   91  	struct irq_chip *chip = irq_desc_get_chip(desc);
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06   92  	struct pcie_port *pp;
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15   93  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06   94  	chained_irq_enter(chip, desc);
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15   95  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06   96  	pp = irq_desc_get_handler_data(desc);
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06   97  	dw_handle_msi_irq(pp);
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06   98  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06   99  	chained_irq_exit(chip, desc);
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  100  }
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  101  
59ea68b3f17294 drivers/pci/controller/dwc/pcie-designware-host.c Gustavo Pimentel       2019-01-31  102  static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  103  {
59ea68b3f17294 drivers/pci/controller/dwc/pcie-designware-host.c Gustavo Pimentel       2019-01-31  104  	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  105  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  106  	u64 msi_target;
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  107  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  108  	msi_target = (u64)pp->msi_data;
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  109  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  110  	msg->address_lo = lower_32_bits(msi_target);
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  111  	msg->address_hi = upper_32_bits(msi_target);
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  112  
59ea68b3f17294 drivers/pci/controller/dwc/pcie-designware-host.c Gustavo Pimentel       2019-01-31  113  	msg->data = d->hwirq;
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  114  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  115  	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
59ea68b3f17294 drivers/pci/controller/dwc/pcie-designware-host.c Gustavo Pimentel       2019-01-31  116  		(int)d->hwirq, msg->address_hi, msg->address_lo);
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  117  }
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  118  
fd5288a362ab55 drivers/pci/controller/dwc/pcie-designware-host.c Gustavo Pimentel       2019-01-31  119  static int dw_pci_msi_set_affinity(struct irq_data *d,
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  120  				   const struct cpumask *mask, bool force)
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  121  {
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  122  	return -EINVAL;
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  123  }
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  124  
40e9892ef94ce8 drivers/pci/controller/dwc/pcie-designware-host.c Gustavo Pimentel       2019-01-31  125  static void dw_pci_bottom_mask(struct irq_data *d)
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  126  {
40e9892ef94ce8 drivers/pci/controller/dwc/pcie-designware-host.c Gustavo Pimentel       2019-01-31  127  	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
f81c770df72e72 drivers/pci/controller/dwc/pcie-designware-host.c Rob Herring            2020-08-20  128  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  129  	unsigned int res, bit, ctrl;
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  130  	unsigned long flags;
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  131  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  132  	raw_spin_lock_irqsave(&pp->lock, flags);
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  133  
40e9892ef94ce8 drivers/pci/controller/dwc/pcie-designware-host.c Gustavo Pimentel       2019-01-31  134  	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
76cbf066b1ab75 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-05-14  135  	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
40e9892ef94ce8 drivers/pci/controller/dwc/pcie-designware-host.c Gustavo Pimentel       2019-01-31  136  	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  137  
657722570a555c drivers/pci/controller/dwc/pcie-designware-host.c Gustavo Pimentel       2019-01-31  138  	pp->irq_mask[ctrl] |= BIT(bit);
f81c770df72e72 drivers/pci/controller/dwc/pcie-designware-host.c Rob Herring            2020-08-20  139  	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res, pp->irq_mask[ctrl]);
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  140  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  141  	raw_spin_unlock_irqrestore(&pp->lock, flags);
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  142  }
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  143  
40e9892ef94ce8 drivers/pci/controller/dwc/pcie-designware-host.c Gustavo Pimentel       2019-01-31  144  static void dw_pci_bottom_unmask(struct irq_data *d)
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  145  {
40e9892ef94ce8 drivers/pci/controller/dwc/pcie-designware-host.c Gustavo Pimentel       2019-01-31  146  	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
f81c770df72e72 drivers/pci/controller/dwc/pcie-designware-host.c Rob Herring            2020-08-20  147  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  148  	unsigned int res, bit, ctrl;
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  149  	unsigned long flags;
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  150  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  151  	raw_spin_lock_irqsave(&pp->lock, flags);
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  152  
40e9892ef94ce8 drivers/pci/controller/dwc/pcie-designware-host.c Gustavo Pimentel       2019-01-31  153  	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
76cbf066b1ab75 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-05-14  154  	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
40e9892ef94ce8 drivers/pci/controller/dwc/pcie-designware-host.c Gustavo Pimentel       2019-01-31  155  	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  156  
657722570a555c drivers/pci/controller/dwc/pcie-designware-host.c Gustavo Pimentel       2019-01-31  157  	pp->irq_mask[ctrl] &= ~BIT(bit);
f81c770df72e72 drivers/pci/controller/dwc/pcie-designware-host.c Rob Herring            2020-08-20  158  	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res, pp->irq_mask[ctrl]);
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  159  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  160  	raw_spin_unlock_irqrestore(&pp->lock, flags);
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  161  }
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  162  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  163  static void dw_pci_bottom_ack(struct irq_data *d)
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  164  {
3f7bb2ec20ce07 drivers/pci/controller/dwc/pcie-designware-host.c Marc Zyngier           2018-11-13  165  	struct pcie_port *pp  = irq_data_get_irq_chip_data(d);
f81c770df72e72 drivers/pci/controller/dwc/pcie-designware-host.c Rob Herring            2020-08-20  166  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
3f7bb2ec20ce07 drivers/pci/controller/dwc/pcie-designware-host.c Marc Zyngier           2018-11-13  167  	unsigned int res, bit, ctrl;
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  168  
3f7bb2ec20ce07 drivers/pci/controller/dwc/pcie-designware-host.c Marc Zyngier           2018-11-13  169  	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
3f7bb2ec20ce07 drivers/pci/controller/dwc/pcie-designware-host.c Marc Zyngier           2018-11-13  170  	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
3f7bb2ec20ce07 drivers/pci/controller/dwc/pcie-designware-host.c Marc Zyngier           2018-11-13  171  	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  172  
f81c770df72e72 drivers/pci/controller/dwc/pcie-designware-host.c Rob Herring            2020-08-20  173  	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_STATUS + res, BIT(bit));
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  174  }
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  175  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  176  static struct irq_chip dw_pci_msi_bottom_irq_chip = {
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  177  	.name = "DWPCI-MSI",
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  178  	.irq_ack = dw_pci_bottom_ack,
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  179  	.irq_compose_msi_msg = dw_pci_setup_msi_msg,
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  180  	.irq_set_affinity = dw_pci_msi_set_affinity,
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  181  	.irq_mask = dw_pci_bottom_mask,
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  182  	.irq_unmask = dw_pci_bottom_unmask,
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  183  };
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  184  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  185  static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  186  				    unsigned int virq, unsigned int nr_irqs,
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  187  				    void *args)
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  188  {
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  189  	struct pcie_port *pp = domain->host_data;
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  190  	unsigned long flags;
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  191  	u32 i;
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  192  	int bit;
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  193  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  194  	raw_spin_lock_irqsave(&pp->lock, flags);
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  195  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  196  	bit = bitmap_find_free_region(pp->msi_irq_in_use, pp->num_vectors,
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  197  				      order_base_2(nr_irqs));
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  198  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  199  	raw_spin_unlock_irqrestore(&pp->lock, flags);
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  200  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  201  	if (bit < 0)
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  202  		return -ENOSPC;
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  203  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  204  	for (i = 0; i < nr_irqs; i++)
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  205  		irq_domain_set_info(domain, virq + i, bit + i,
9f67437b3a0858 drivers/pci/controller/dwc/pcie-designware-host.c Kishon Vijay Abraham I 2019-03-21  206  				    pp->msi_irq_chip,
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  207  				    pp, handle_edge_irq,
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  208  				    NULL, NULL);
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  209  
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  210  	return 0;
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  211  }
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  212  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  213  static void dw_pcie_irq_domain_free(struct irq_domain *domain,
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  214  				    unsigned int virq, unsigned int nr_irqs)
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  215  {
4cfae0f1f8ce16 drivers/pci/controller/dwc/pcie-designware-host.c Gustavo Pimentel       2019-01-31  216  	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
03f8c1b350d001 drivers/pci/controller/dwc/pcie-designware-host.c Kishon Vijay Abraham I 2019-12-20  217  	struct pcie_port *pp = domain->host_data;
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  218  	unsigned long flags;
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  219  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  220  	raw_spin_lock_irqsave(&pp->lock, flags);
b4a8a51caf7de4 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-05-14  221  
4cfae0f1f8ce16 drivers/pci/controller/dwc/pcie-designware-host.c Gustavo Pimentel       2019-01-31  222  	bitmap_release_region(pp->msi_irq_in_use, d->hwirq,
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  223  			      order_base_2(nr_irqs));
b4a8a51caf7de4 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-05-14  224  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  225  	raw_spin_unlock_irqrestore(&pp->lock, flags);
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  226  }
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  227  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  228  static const struct irq_domain_ops dw_pcie_msi_domain_ops = {
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  229  	.alloc	= dw_pcie_irq_domain_alloc,
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  230  	.free	= dw_pcie_irq_domain_free,
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  231  };
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  232  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  233  int dw_pcie_allocate_domains(struct pcie_port *pp)
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  234  {
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  235  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  236  	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  237  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  238  	pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  239  					       &dw_pcie_msi_domain_ops, pp);
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  240  	if (!pp->irq_domain) {
b4a8a51caf7de4 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-05-14  241  		dev_err(pci->dev, "Failed to create IRQ domain\n");
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  242  		return -ENOMEM;
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  243  	}
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  244  
0414b93e78d87e drivers/pci/controller/dwc/pcie-designware-host.c Marc Zyngier           2020-05-01  245  	irq_domain_update_bus_token(pp->irq_domain, DOMAIN_BUS_NEXUS);
0414b93e78d87e drivers/pci/controller/dwc/pcie-designware-host.c Marc Zyngier           2020-05-01  246  
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06 @247  	pp->msi_domain = pci_msi_create_irq_domain(fwnode,
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  248  						   &dw_pcie_msi_domain_info,
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  249  						   pp->irq_domain);
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  250  	if (!pp->msi_domain) {
b4a8a51caf7de4 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-05-14  251  		dev_err(pci->dev, "Failed to create MSI domain\n");
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  252  		irq_domain_remove(pp->irq_domain);
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  253  		return -ENOMEM;
7c5925afbc58c6 drivers/pci/dwc/pcie-designware-host.c            Gustavo Pimentel       2018-03-06  254  	}
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  255  
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  256  	return 0;
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  257  }
feb85d9b1c47ea drivers/pci/dwc/pcie-designware-host.c            Kishon Vijay Abraham I 2017-02-15  258  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--0OAP2g/MAC+5xKAE
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
S+MtzX+iuWf1w2oCAA==

--0OAP2g/MAC+5xKAE--
