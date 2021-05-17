Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B524E383B01
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 19:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbhEQRRj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 13:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242415AbhEQRRd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 May 2021 13:17:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A78456128A;
        Mon, 17 May 2021 17:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621271777;
        bh=WoZvYJeK36Q8sVv74/EgYe934soWsHWOFNZwFqHcXNY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=H3s4aKLRCITYzOM/HNdGK+W+CBA+gvuk3P6hq456ZM/sPWVnAni3+7dLKsvdvBkrj
         xcD1yULEeICy6AUvaTevCxvYkY0ofL3qIxxwTNPkNMS7G6zaXGpOOS7cUb6AQynI32
         TLpTin4jRf8xTwfyZgAjziQIIPxj2GkjJOYe9RXUhF7OswI7M7tb0UqeeDVgvyTsKV
         OcoM/YnTDkK8fH6nicn8AjgCSYGURudTXckL28lkPkEg1JXx9DuRPrKzKOKP+w+WdT
         ITwcMi9JE04zu91WP/myV1/540oCOwCCemLa2y0nN5B12pzUD5DvgignB1xPktdZv3
         vQXe2BB6BG/eA==
Date:   Mon, 17 May 2021 12:16:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Toan Le <toan@os.amperecomputing.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Robert Richter <rric@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: drivers/pci/controller/pci-xgene.c:511:33: sparse: sparse:
 incorrect type in argument 2 (different address spaces)
Message-ID: <20210517171615.GA23513@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202105171809.Tay9fImZ-lkp@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Toan, linux-pci]

The patch I think we need is attached below.  I'll post it to the list
separately.

I didn't see any similar issues in the rest of
drivers/pci/controller/.

On Mon, May 17, 2021 at 06:35:17PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d07f6ca923ea0927a1024dfccafc5b53b61cfecc
> commit: 6e5a1fff9096ecd259dedcbbdc812aa90986a40e PCI: Avoid building empty drivers
> date:   10 weeks ago
> config: mips-randconfig-s032-20210517 (attached as .config)
> compiler: mipsel-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-341-g8af24329-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e5a1fff9096ecd259dedcbbdc812aa90986a40e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 6e5a1fff9096ecd259dedcbbdc812aa90986a40e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
>    command-line: note: in included file:
>    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
>    builtin:0:0: sparse: this was the original definition
>    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
>    builtin:0:0: sparse: this was the original definition
>    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
>    builtin:0:0: sparse: this was the original definition
>    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
>    builtin:0:0: sparse: this was the original definition
>    drivers/pci/controller/pci-xgene.c:510:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *bar_addr @@     got void [noderef] __iomem * @@
>    drivers/pci/controller/pci-xgene.c:510:26: sparse:     expected void *bar_addr
>    drivers/pci/controller/pci-xgene.c:510:26: sparse:     got void [noderef] __iomem *
> >> drivers/pci/controller/pci-xgene.c:511:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *bar_addr @@
>    drivers/pci/controller/pci-xgene.c:511:33: sparse:     expected void volatile [noderef] __iomem *mem
>    drivers/pci/controller/pci-xgene.c:511:33: sparse:     got void *bar_addr
> >> drivers/pci/controller/pci-xgene.c:512:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
>    drivers/pci/controller/pci-xgene.c:512:58: sparse:     expected void volatile [noderef] __iomem *mem
>    drivers/pci/controller/pci-xgene.c:512:58: sparse:     got void *
> 
> vim +511 drivers/pci/controller/pci-xgene.c
> 
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  480  
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  481  static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
> 6dce5aa59e0bf2 drivers/pci/controller/pci-xgene.c Rob Herring    2019-10-28  482  				    struct resource_entry *entry,
> 6dce5aa59e0bf2 drivers/pci/controller/pci-xgene.c Rob Herring    2019-10-28  483  				    u8 *ib_reg_mask)
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  484  {
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  485  	void __iomem *cfg_base = port->cfg_base;
> d963ab22ad32da drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  486  	struct device *dev = port->dev;
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  487  	void *bar_addr;
> 4ecf6b0f83523f drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  488  	u32 pim_reg;
> 6dce5aa59e0bf2 drivers/pci/controller/pci-xgene.c Rob Herring    2019-10-28  489  	u64 cpu_addr = entry->res->start;
> 6dce5aa59e0bf2 drivers/pci/controller/pci-xgene.c Rob Herring    2019-10-28  490  	u64 pci_addr = cpu_addr - entry->offset;
> 6dce5aa59e0bf2 drivers/pci/controller/pci-xgene.c Rob Herring    2019-10-28  491  	u64 size = resource_size(entry->res);
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  492  	u64 mask = ~(size - 1) | EN_REG;
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  493  	u32 flags = PCI_BASE_ADDRESS_MEM_TYPE_64;
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  494  	u32 bar_low;
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  495  	int region;
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  496  
> 6dce5aa59e0bf2 drivers/pci/controller/pci-xgene.c Rob Herring    2019-10-28  497  	region = xgene_pcie_select_ib_reg(ib_reg_mask, size);
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  498  	if (region < 0) {
> d963ab22ad32da drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  499  		dev_warn(dev, "invalid pcie dma-range config\n");
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  500  		return;
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  501  	}
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  502  
> 6dce5aa59e0bf2 drivers/pci/controller/pci-xgene.c Rob Herring    2019-10-28  503  	if (entry->res->flags & IORESOURCE_PREFETCH)
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  504  		flags |= PCI_BASE_ADDRESS_MEM_PREFETCH;
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  505  
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  506  	bar_low = pcie_bar_low_val((u32)cpu_addr, flags);
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  507  	switch (region) {
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  508  	case 0:
> 4ecf6b0f83523f drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  509  		xgene_pcie_set_ib_mask(port, BRIDGE_CFG_4, flags, size);
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  510  		bar_addr = cfg_base + PCI_BASE_ADDRESS_0;
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01 @511  		writel(bar_low, bar_addr);
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01 @512  		writel(upper_32_bits(cpu_addr), bar_addr + 0x4);
> 4ecf6b0f83523f drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  513  		pim_reg = PIM1_1L;
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  514  		break;
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  515  	case 1:
> 8e93c5132ca2e5 drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  516  		xgene_pcie_writel(port, IBAR2, bar_low);
> 8e93c5132ca2e5 drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  517  		xgene_pcie_writel(port, IR2MSK, lower_32_bits(mask));
> 4ecf6b0f83523f drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  518  		pim_reg = PIM2_1L;
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  519  		break;
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  520  	case 2:
> 8e93c5132ca2e5 drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  521  		xgene_pcie_writel(port, IBAR3L, bar_low);
> 8e93c5132ca2e5 drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  522  		xgene_pcie_writel(port, IBAR3L + 0x4, upper_32_bits(cpu_addr));
> 8e93c5132ca2e5 drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  523  		xgene_pcie_writel(port, IR3MSKL, lower_32_bits(mask));
> 8e93c5132ca2e5 drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  524  		xgene_pcie_writel(port, IR3MSKL + 0x4, upper_32_bits(mask));
> 4ecf6b0f83523f drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  525  		pim_reg = PIM3_1L;
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  526  		break;
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  527  	}
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  528  
> 4ecf6b0f83523f drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  529  	xgene_pcie_setup_pims(port, pim_reg, pci_addr, ~(size - 1));
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  530  }
> 5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  531  
> 
> :::::: The code at line 511 was first introduced by commit
> :::::: 5f6b6ccdbe1cdfa5aa4347ec5412509b8995db27 PCI: xgene: Add APM X-Gene PCIe driver
> 
> :::::: TO: Tanmay Inamdar <tinamdar@apm.com>
> :::::: CC: Bjorn Helgaas <bhelgaas@google.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


commit c89e93028d61 ("PCI: xgene: Annotate __iomem pointer")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon May 17 12:07:00 2021 -0500

    PCI: xgene: Annotate __iomem pointer
    
    "bar_addr" is passed as the argument to writel(), which expects a
    "void __iomem *".  Annotate "bar_addr" correctly.  Resolves an sparse
    "incorrect type in argument 2 (different address spaces)" warning.
    
    Link: https://lore.kernel.org/r/202105171809.Tay9fImZ-lkp@intel.com
    Reported-by: kernel test robot <lkp@intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 7f503dd4ff81..1a412f5377fb 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -485,7 +485,7 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
 {
 	void __iomem *cfg_base = port->cfg_base;
 	struct device *dev = port->dev;
-	void *bar_addr;
+	void __iomem *bar_addr;
 	u32 pim_reg;
 	u64 cpu_addr = entry->res->start;
 	u64 pci_addr = cpu_addr - entry->offset;
