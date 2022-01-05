Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D9E485486
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 15:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240830AbiAEO3D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 09:29:03 -0500
Received: from mga06.intel.com ([134.134.136.31]:45841 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240705AbiAEO3C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jan 2022 09:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641392942; x=1672928942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hi1CUxQYFQ0/ZFDZ2lA363BDyHuRYgNCeTWBGpt3iyA=;
  b=feDcLEAhBFK8JoT/iuJqqPRXxTpV6GPCbnnLrcJZibjBwg91zdnV6s6P
   cB1p0AImHjzbkV8Mv/Aghi9gvNToMaW80GJBcHnO3YGI2hpUnHFLzf9XH
   PhSEmVzt4Erhqh1cfuY46HJRuSMhTNqINQs/XNzK9KFen6y5b4ov0NzUp
   ED4WFXg9xQ1+dUHvLVY9pcSU2+oKocjtzPKMPkjMFiHwLiqetgxMn4VUU
   ZkiqmbhdDPMJq48rXCDp0f2yzcqy0LL8iFrldGEptiClGo5II7yLcN0P+
   x0IUlNsbbtB4BwAf9IFFtKiTQPXyktq61XGipKJiIZAExc1G8sU3G4GZX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="303204299"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="303204299"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 06:16:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="668104128"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jan 2022 06:16:43 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n575m-000GiY-J0; Wed, 05 Jan 2022 14:16:42 +0000
Date:   Wed, 5 Jan 2022 22:16:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Roman Bacik <roman.bacik@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     kbuild-all@lists.01.org, bcm-kernel-feedback-list@broadcom.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: iproc: Set all 24 bits of PCI class code
Message-ID: <202201052225.XMsg2fG3-lkp@intel.com>
References: <20220105093552.27542-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105093552.27542-1-pali@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi "Pali,

I love your patch! Yet something to improve:

[auto build test ERROR on helgaas-pci/next]
[also build test ERROR on v5.16-rc8 next-20220105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Pali-Roh-r/PCI-iproc-Set-all-24-bits-of-PCI-class-code/20220105-173704
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: arm-randconfig-c002-20220105 (https://download.01.org/0day-ci/archive/20220105/202201052225.XMsg2fG3-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/8ef1acfb84c08a0331930f9a60884fdd6d7c5e88
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Pali-Roh-r/PCI-iproc-Set-all-24-bits-of-PCI-class-code/20220105-173704
        git checkout 8ef1acfb84c08a0331930f9a60884fdd6d7c5e88
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/pci/controller/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pci/controller/pcie-iproc.c: In function 'iproc_pcie_check_link':
>> drivers/pci/controller/pcie-iproc.c:798:18: error: 'PCI_CLASS_BRIDGE_PCI_NORMAL' undeclared (first use in this function); did you mean 'PCI_CLASS_BRIDGE_PCMCIA'?
     798 |         class |= PCI_CLASS_BRIDGE_PCI_NORMAL;
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                  PCI_CLASS_BRIDGE_PCMCIA
   drivers/pci/controller/pcie-iproc.c:798:18: note: each undeclared identifier is reported only once for each function it appears in


vim +798 drivers/pci/controller/pcie-iproc.c

   765	
   766	static int iproc_pcie_check_link(struct iproc_pcie *pcie)
   767	{
   768		struct device *dev = pcie->dev;
   769		u32 hdr_type, link_ctrl, link_status, class, val;
   770		bool link_is_active = false;
   771	
   772		/*
   773		 * PAXC connects to emulated endpoint devices directly and does not
   774		 * have a Serdes.  Therefore skip the link detection logic here.
   775		 */
   776		if (pcie->ep_is_internal)
   777			return 0;
   778	
   779		val = iproc_pcie_read_reg(pcie, IPROC_PCIE_LINK_STATUS);
   780		if (!(val & PCIE_PHYLINKUP) || !(val & PCIE_DL_ACTIVE)) {
   781			dev_err(dev, "PHY or data link is INACTIVE!\n");
   782			return -ENODEV;
   783		}
   784	
   785		/* make sure we are not in EP mode */
   786		iproc_pci_raw_config_read32(pcie, 0, PCI_HEADER_TYPE, 1, &hdr_type);
   787		if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE) {
   788			dev_err(dev, "in EP mode, hdr=%#02x\n", hdr_type);
   789			return -EFAULT;
   790		}
   791	
   792		/* force class to PCI_CLASS_BRIDGE_PCI_NORMAL (0x060400) */
   793	#define PCI_BRIDGE_CTRL_REG_OFFSET	0x43c
   794	#define PCI_BRIDGE_CTRL_REG_CLASS_MASK	0xffffff
   795		iproc_pci_raw_config_read32(pcie, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
   796					    4, &class);
   797		class &= ~PCI_BRIDGE_CTRL_REG_CLASS_MASK;
 > 798		class |= PCI_CLASS_BRIDGE_PCI_NORMAL;
   799		iproc_pci_raw_config_write32(pcie, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
   800					     4, class);
   801	
   802		/* check link status to see if link is active */
   803		iproc_pci_raw_config_read32(pcie, 0, IPROC_PCI_EXP_CAP + PCI_EXP_LNKSTA,
   804					    2, &link_status);
   805		if (link_status & PCI_EXP_LNKSTA_NLW)
   806			link_is_active = true;
   807	
   808		if (!link_is_active) {
   809			/* try GEN 1 link speed */
   810	#define PCI_TARGET_LINK_SPEED_MASK	0xf
   811	#define PCI_TARGET_LINK_SPEED_GEN2	0x2
   812	#define PCI_TARGET_LINK_SPEED_GEN1	0x1
   813			iproc_pci_raw_config_read32(pcie, 0,
   814						    IPROC_PCI_EXP_CAP + PCI_EXP_LNKCTL2,
   815						    4, &link_ctrl);
   816			if ((link_ctrl & PCI_TARGET_LINK_SPEED_MASK) ==
   817			    PCI_TARGET_LINK_SPEED_GEN2) {
   818				link_ctrl &= ~PCI_TARGET_LINK_SPEED_MASK;
   819				link_ctrl |= PCI_TARGET_LINK_SPEED_GEN1;
   820				iproc_pci_raw_config_write32(pcie, 0,
   821						IPROC_PCI_EXP_CAP + PCI_EXP_LNKCTL2,
   822						4, link_ctrl);
   823				msleep(100);
   824	
   825				iproc_pci_raw_config_read32(pcie, 0,
   826						IPROC_PCI_EXP_CAP + PCI_EXP_LNKSTA,
   827						2, &link_status);
   828				if (link_status & PCI_EXP_LNKSTA_NLW)
   829					link_is_active = true;
   830			}
   831		}
   832	
   833		dev_info(dev, "link: %s\n", link_is_active ? "UP" : "DOWN");
   834	
   835		return link_is_active ? 0 : -ENODEV;
   836	}
   837	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
