Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5371154302
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2020 12:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBFL13 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Feb 2020 06:27:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40444 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgBFL13 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Feb 2020 06:27:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so6601275wmi.5
        for <linux-pci@vger.kernel.org>; Thu, 06 Feb 2020 03:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DhWg+zpdSqsW8rxWEiaaZAwp7E2BBzkWJY6y23Nf9HU=;
        b=muKUaEKfnmdex2xux9VRn97Fyh2mmm6dgo7Z4NzuaTE++qIXJ3R+6ePGB7umg//9LW
         FKN8elSrBErbld5boWBqNcSUvl9pfVrv5mXp/pXO4BJttqmkjgY0cXSVs/+rjGvOSO9T
         BJWwgPlHrfLqo6Vqvheynora+vQInsIBdKAeqmdTynbzPpodGpNnscfk2ehufxwe6kWn
         wa3TVmsyD5xn0x14Po47+2nP1X5mI+WnG0ieORzop8RanyKcUjy/C9auh+w4baTf7HUH
         TKFxO+wROoPQ/kz2lX7bVEozXVIA+esLEtqH1slZtgJCwB2HnbE6kiJsAs7e5ut0+R8g
         ncjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DhWg+zpdSqsW8rxWEiaaZAwp7E2BBzkWJY6y23Nf9HU=;
        b=e5TrbH3ReujlLxEw49ChCX1kIxkWERFkhBJEnu0Bv+mC136wobnjg7WlJ42XxDdXau
         9daleNiITgt3Dl8IB2swtfzzZJ/KdnCCCJCQd10A88bDabMPRJCk2Sr34OvrRpSr6VWh
         6h+ZFVKJ3V7xkqjMDu5wi1QhjnA9h2N0jhvnp+2m5po/SxHYb8qXi/N3vZVWd4cQI36r
         Z6k60hsrDGaQ8+tKrpyNMjGPemwdEgdddBc9ryFFLCwQNHmKsNJwhlEpUe6177IOMv8T
         /VsViA3Fy+Tc23Z+yJci55g6q1Fk5XcGcn4js5BdBPjmY8FEdeIvfYXgFYrSik2OLnM7
         bgvA==
X-Gm-Message-State: APjAAAVHDlJy4s0rG25WxqAEkPeZFMp6Cb3YtZM79BT2zp4L5YM0Spdl
        3HtFUDBxyIzrvO3/JPmWpHPNnA==
X-Google-Smtp-Source: APXvYqwSsh7dUxDsfBDsS/7Q3iLOvZND5C4QfZ6rnRc8hHTEMsls6EvjrbZbVmJ14vQg12Ie6nC2vA==
X-Received: by 2002:a7b:cb49:: with SMTP id v9mr4221349wmj.160.1580988445988;
        Thu, 06 Feb 2020 03:27:25 -0800 (PST)
Received: from big-machine ([2a00:23c5:dd80:8400:94e8:de94:574e:efb1])
        by smtp.gmail.com with ESMTPSA id o4sm3721797wrx.25.2020.02.06.03.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 03:27:25 -0800 (PST)
Date:   Thu, 6 Feb 2020 11:27:23 +0000
From:   Andrew Murray <amurray@thegoodpenguin.co.uk>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv9 01/12] PCI: mobiveil: Re-abstract the private structure
Message-ID: <20200206112723.GA19388@big-machine>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <20191120034451.30102-2-Zhiqiang.Hou@nxp.com>
 <20200113100931.GG42593@e119886-lin.cambridge.arm.com>
 <DB8PR04MB67476FE40D1396B2F61F5683841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB8PR04MB67476FE40D1396B2F61F5683841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 06, 2020 at 11:04:29AM +0000, Z.q. Hou wrote:
> Hi Andrew,
> 
> Thanks a lot for your comments!
> Sorry for my delay respond!
> 
> > -----Original Message-----
> > From: Andrew Murray <andrew.murray@arm.com>
> > Sent: 2020年1月13日 18:10
> > To: Z.q. Hou <zhiqiang.hou@nxp.com>
> > Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > bhelgaas@google.com; robh+dt@kernel.org; arnd@arndb.de;
> > mark.rutland@arm.com; l.subrahmanya@mobiveil.co.in;
> > shawnguo@kernel.org; m.karthikeyan@mobiveil.co.in; Leo Li
> > <leoyang.li@nxp.com>; lorenzo.pieralisi@arm.com;
> > catalin.marinas@arm.com; will.deacon@arm.com; Mingkai Hu
> > <mingkai.hu@nxp.com>; M.h. Lian <minghuan.lian@nxp.com>; Xiaowei Bao
> > <xiaowei.bao@nxp.com>
> > Subject: Re: [PATCHv9 01/12] PCI: mobiveil: Re-abstract the private structure
> > 
> > On Wed, Nov 20, 2019 at 03:45:23AM +0000, Z.q. Hou wrote:
> > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >
> > > The Mobiveil PCIe controller can work in either Root Complex mode or
> > > Endpoint mode. So introduce a new structure root_port, and abstract
> > > the RC related members into it.
> > 
> > The first sentence explains the trigger for this work, the second explains what
> > you are changing, it would be helpful to also describe why you need to make
> > this change. You could do this by extending the last sentence, e.g.
> > 
> > "So introduce a new structure root_port, and abstract the RC  related
> > members into it such that it can be used by both ..."
> > 
> > As this series doesn't actually add a EP driver, this abstraction isn't needed
> > now - but it is nice to have - it may be helpful to explain this.
> > 
> > The email subject could also more precisely explain what this patch does.
> 
> Thanks for the good suggestions! Will change in v10.
> 
> > 
> > 
> > >
> > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > ---
> > > V9:
> > >  - New patch splited from the #1 of V8 patches to make it easy to review.
> > 
> > Indeed, it's much nicer to review - thanks.
> > 
> > 
> > >
> > >  drivers/pci/controller/pcie-mobiveil.c | 99
> > > ++++++++++++++++----------
> > >  1 file changed, 60 insertions(+), 39 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-mobiveil.c
> > > b/drivers/pci/controller/pcie-mobiveil.c
> > > index 3a696ca45bfa..5fd26e376af2 100644
> > > --- a/drivers/pci/controller/pcie-mobiveil.c
> > > +++ b/drivers/pci/controller/pcie-mobiveil.c
> > > @@ -3,7 +3,10 @@
> > >   * PCIe host controller driver for Mobiveil PCIe Host controller
> > >   *
> > >   * Copyright (c) 2018 Mobiveil Inc.
> > > + * Copyright 2019 NXP
> > > + *
> > >   * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> > > + * Recode: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > 
> > As per my previous feedback, I'm not sure the value of using the term refactor
> > or a synonym of it. And I certaintly don't want to encourage anyone that
> > modifies this file to add a similar tag when the information is easily visible via
> > GIT and the get_maintainers script.
> 
> Will remove the recode tag in v10.
> 
> > 
> > >   */
> > >
> > >  #include <linux/delay.h>
> > > @@ -138,22 +141,27 @@ struct mobiveil_msi {			/* MSI
> > information */
> > >  	DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);  };
> > >
> > > +struct root_port {
> > > +	char root_bus_nr;
> > > +	void __iomem *config_axi_slave_base;	/* endpoint config base */
> > > +	struct resource *ob_io_res;
> > > +	int irq;
> > > +	raw_spinlock_t intx_mask_lock;
> > > +	struct irq_domain *intx_domain;
> > > +	struct mobiveil_msi msi;
> > > +	struct pci_host_bridge *bridge;
> > > +};
> > 
> > Please prefix with mobiveil given we have mobiveil related structures inside it.
> 
> Do you mean s/root_port/mobiveil_root_port/ ?

Yes!

Thanks,

Andrew Murray

> 
> Thanks,
> Zhiqiang
> 
> > 
> > (Also on your respin, please rebase as per Olof's feedback).
> > 
> > Thanks,
> > 
> > Andrew Murray
> > 
> > > +
> > >  struct mobiveil_pcie {
> > >  	struct platform_device *pdev;
> > > -	void __iomem *config_axi_slave_base;	/* endpoint config base */
> > >  	void __iomem *csr_axi_slave_base;	/* root port config base */
> > >  	void __iomem *apb_csr_base;	/* MSI register base */
> > >  	phys_addr_t pcie_reg_base;	/* Physical PCIe Controller Base */
> > > -	struct irq_domain *intx_domain;
> > > -	raw_spinlock_t intx_mask_lock;
> > > -	int irq;
> > >  	int apio_wins;
> > >  	int ppio_wins;
> > >  	int ob_wins_configured;		/* configured outbound windows */
> > >  	int ib_wins_configured;		/* configured inbound windows */
> > > -	struct resource *ob_io_res;
> > > -	char root_bus_nr;
> > > -	struct mobiveil_msi msi;
> > > +	struct root_port rp;
> > >  };
> > >
> > >  /*
> > > @@ -281,16 +289,17 @@ static bool mobiveil_pcie_link_up(struct
> > > mobiveil_pcie *pcie)  static bool mobiveil_pcie_valid_device(struct
> > > pci_bus *bus, unsigned int devfn)  {
> > >  	struct mobiveil_pcie *pcie = bus->sysdata;
> > > +	struct root_port *rp = &pcie->rp;
> > >
> > >  	/* Only one device down on each root port */
> > > -	if ((bus->number == pcie->root_bus_nr) && (devfn > 0))
> > > +	if ((bus->number == rp->root_bus_nr) && (devfn > 0))
> > >  		return false;
> > >
> > >  	/*
> > >  	 * Do not read more than one device on the bus directly
> > >  	 * attached to RC
> > >  	 */
> > > -	if ((bus->primary == pcie->root_bus_nr) && (PCI_SLOT(devfn) > 0))
> > > +	if ((bus->primary == rp->root_bus_nr) && (PCI_SLOT(devfn) > 0))
> > >  		return false;
> > >
> > >  	return true;
> > > @@ -304,13 +313,14 @@ static void __iomem
> > *mobiveil_pcie_map_bus(struct pci_bus *bus,
> > >  					   unsigned int devfn, int where)  {
> > >  	struct mobiveil_pcie *pcie = bus->sysdata;
> > > +	struct root_port *rp = &pcie->rp;
> > >  	u32 value;
> > >
> > >  	if (!mobiveil_pcie_valid_device(bus, devfn))
> > >  		return NULL;
> > >
> > >  	/* RC config access */
> > > -	if (bus->number == pcie->root_bus_nr)
> > > +	if (bus->number == rp->root_bus_nr)
> > >  		return pcie->csr_axi_slave_base + where;
> > >
> > >  	/*
> > > @@ -325,7 +335,7 @@ static void __iomem
> > *mobiveil_pcie_map_bus(struct
> > > pci_bus *bus,
> > >
> > >  	mobiveil_csr_writel(pcie, value,
> > PAB_AXI_AMAP_PEX_WIN_L(WIN_NUM_0));
> > >
> > > -	return pcie->config_axi_slave_base + where;
> > > +	return rp->config_axi_slave_base + where;
> > >  }
> > >
> > >  static struct pci_ops mobiveil_pcie_ops = { @@ -339,7 +349,8 @@
> > > static void mobiveil_pcie_isr(struct irq_desc *desc)
> > >  	struct irq_chip *chip = irq_desc_get_chip(desc);
> > >  	struct mobiveil_pcie *pcie = irq_desc_get_handler_data(desc);
> > >  	struct device *dev = &pcie->pdev->dev;
> > > -	struct mobiveil_msi *msi = &pcie->msi;
> > > +	struct root_port *rp = &pcie->rp;
> > > +	struct mobiveil_msi *msi = &rp->msi;
> > >  	u32 msi_data, msi_addr_lo, msi_addr_hi;
> > >  	u32 intr_status, msi_status;
> > >  	unsigned long shifted_status;
> > > @@ -365,7 +376,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
> > >  		shifted_status >>= PAB_INTX_START;
> > >  		do {
> > >  			for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
> > > -				virq = irq_find_mapping(pcie->intx_domain,
> > > +				virq = irq_find_mapping(rp->intx_domain,
> > >  							bit + 1);
> > >  				if (virq)
> > >  					generic_handle_irq(virq);
> > > @@ -424,15 +435,16 @@ static int mobiveil_pcie_parse_dt(struct
> > mobiveil_pcie *pcie)
> > >  	struct device *dev = &pcie->pdev->dev;
> > >  	struct platform_device *pdev = pcie->pdev;
> > >  	struct device_node *node = dev->of_node;
> > > +	struct root_port *rp = &pcie->rp;
> > >  	struct resource *res;
> > >
> > >  	/* map config resource */
> > >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > >  					   "config_axi_slave");
> > > -	pcie->config_axi_slave_base = devm_pci_remap_cfg_resource(dev, res);
> > > -	if (IS_ERR(pcie->config_axi_slave_base))
> > > -		return PTR_ERR(pcie->config_axi_slave_base);
> > > -	pcie->ob_io_res = res;
> > > +	rp->config_axi_slave_base = devm_pci_remap_cfg_resource(dev, res);
> > > +	if (IS_ERR(rp->config_axi_slave_base))
> > > +		return PTR_ERR(rp->config_axi_slave_base);
> > > +	rp->ob_io_res = res;
> > >
> > >  	/* map csr resource */
> > >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, @@
> > -455,9
> > > +467,9 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
> > >  	if (of_property_read_u32(node, "ppio-wins", &pcie->ppio_wins))
> > >  		pcie->ppio_wins = MAX_PIO_WINDOWS;
> > >
> > > -	pcie->irq = platform_get_irq(pdev, 0);
> > > -	if (pcie->irq <= 0) {
> > > -		dev_err(dev, "failed to map IRQ: %d\n", pcie->irq);
> > > +	rp->irq = platform_get_irq(pdev, 0);
> > > +	if (rp->irq <= 0) {
> > > +		dev_err(dev, "failed to map IRQ: %d\n", rp->irq);
> > >  		return -ENODEV;
> > >  	}
> > >
> > > @@ -564,9 +576,9 @@ static int mobiveil_bringup_link(struct
> > > mobiveil_pcie *pcie)  static void mobiveil_pcie_enable_msi(struct
> > > mobiveil_pcie *pcie)  {
> > >  	phys_addr_t msg_addr = pcie->pcie_reg_base;
> > > -	struct mobiveil_msi *msi = &pcie->msi;
> > > +	struct mobiveil_msi *msi = &pcie->rp.msi;
> > >
> > > -	pcie->msi.num_of_vectors = PCI_NUM_MSI;
> > > +	msi->num_of_vectors = PCI_NUM_MSI;
> > >  	msi->msi_pages_phys = (phys_addr_t)msg_addr;
> > >
> > >  	writel_relaxed(lower_32_bits(msg_addr),
> > > @@ -579,7 +591,8 @@ static void mobiveil_pcie_enable_msi(struct
> > > mobiveil_pcie *pcie)
> > >
> > >  static int mobiveil_host_init(struct mobiveil_pcie *pcie)  {
> > > -	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> > > +	struct root_port *rp = &pcie->rp;
> > > +	struct pci_host_bridge *bridge = rp->bridge;
> > >  	u32 value, pab_ctrl, type;
> > >  	struct resource_entry *win;
> > >
> > > @@ -629,8 +642,8 @@ static int mobiveil_host_init(struct mobiveil_pcie
> > *pcie)
> > >  	 */
> > >
> > >  	/* config outbound translation window */
> > > -	program_ob_windows(pcie, WIN_NUM_0, pcie->ob_io_res->start, 0,
> > > -			   CFG_WINDOW_TYPE, resource_size(pcie->ob_io_res));
> > > +	program_ob_windows(pcie, WIN_NUM_0, rp->ob_io_res->start, 0,
> > > +			   CFG_WINDOW_TYPE, resource_size(rp->ob_io_res));
> > >
> > >  	/* memory inbound translation window */
> > >  	program_ib_windows(pcie, WIN_NUM_0, 0, 0, MEM_WINDOW_TYPE,
> > > IB_WIN_SIZE); @@ -667,32 +680,36 @@ static void
> > > mobiveil_mask_intx_irq(struct irq_data *data)  {
> > >  	struct irq_desc *desc = irq_to_desc(data->irq);
> > >  	struct mobiveil_pcie *pcie;
> > > +	struct root_port *rp;
> > >  	unsigned long flags;
> > >  	u32 mask, shifted_val;
> > >
> > >  	pcie = irq_desc_get_chip_data(desc);
> > > +	rp = &pcie->rp;
> > >  	mask = 1 << ((data->hwirq + PAB_INTX_START) - 1);
> > > -	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
> > > +	raw_spin_lock_irqsave(&rp->intx_mask_lock, flags);
> > >  	shifted_val = mobiveil_csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
> > >  	shifted_val &= ~mask;
> > >  	mobiveil_csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
> > > -	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
> > > +	raw_spin_unlock_irqrestore(&rp->intx_mask_lock, flags);
> > >  }
> > >
> > >  static void mobiveil_unmask_intx_irq(struct irq_data *data)  {
> > >  	struct irq_desc *desc = irq_to_desc(data->irq);
> > >  	struct mobiveil_pcie *pcie;
> > > +	struct root_port *rp;
> > >  	unsigned long flags;
> > >  	u32 shifted_val, mask;
> > >
> > >  	pcie = irq_desc_get_chip_data(desc);
> > > +	rp = &pcie->rp;
> > >  	mask = 1 << ((data->hwirq + PAB_INTX_START) - 1);
> > > -	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
> > > +	raw_spin_lock_irqsave(&rp->intx_mask_lock, flags);
> > >  	shifted_val = mobiveil_csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
> > >  	shifted_val |= mask;
> > >  	mobiveil_csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
> > > -	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
> > > +	raw_spin_unlock_irqrestore(&rp->intx_mask_lock, flags);
> > >  }
> > >
> > >  static struct irq_chip intx_irq_chip = { @@ -760,7 +777,7 @@ static
> > > int mobiveil_irq_msi_domain_alloc(struct irq_domain *domain,
> > >  					 unsigned int nr_irqs, void *args)  {
> > >  	struct mobiveil_pcie *pcie = domain->host_data;
> > > -	struct mobiveil_msi *msi = &pcie->msi;
> > > +	struct mobiveil_msi *msi = &pcie->rp.msi;
> > >  	unsigned long bit;
> > >
> > >  	WARN_ON(nr_irqs != 1);
> > > @@ -787,7 +804,7 @@ static void mobiveil_irq_msi_domain_free(struct
> > > irq_domain *domain,  {
> > >  	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> > >  	struct mobiveil_pcie *pcie = irq_data_get_irq_chip_data(d);
> > > -	struct mobiveil_msi *msi = &pcie->msi;
> > > +	struct mobiveil_msi *msi = &pcie->rp.msi;
> > >
> > >  	mutex_lock(&msi->lock);
> > >
> > > @@ -808,9 +825,9 @@ static int mobiveil_allocate_msi_domains(struct
> > > mobiveil_pcie *pcie)  {
> > >  	struct device *dev = &pcie->pdev->dev;
> > >  	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> > > -	struct mobiveil_msi *msi = &pcie->msi;
> > > +	struct mobiveil_msi *msi = &pcie->rp.msi;
> > >
> > > -	mutex_init(&pcie->msi.lock);
> > > +	mutex_init(&msi->lock);
> > >  	msi->dev_domain = irq_domain_add_linear(NULL,
> > msi->num_of_vectors,
> > >  						&msi_domain_ops, pcie);
> > >  	if (!msi->dev_domain) {
> > > @@ -834,18 +851,19 @@ static int mobiveil_pcie_init_irq_domain(struct
> > > mobiveil_pcie *pcie)  {
> > >  	struct device *dev = &pcie->pdev->dev;
> > >  	struct device_node *node = dev->of_node;
> > > +	struct root_port *rp = &pcie->rp;
> > >  	int ret;
> > >
> > >  	/* setup INTx */
> > > -	pcie->intx_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
> > > -						  &intx_domain_ops, pcie);
> > > +	rp->intx_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
> > > +						&intx_domain_ops, pcie);
> > >
> > > -	if (!pcie->intx_domain) {
> > > +	if (!rp->intx_domain) {
> > >  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> > >  		return -ENOMEM;
> > >  	}
> > >
> > > -	raw_spin_lock_init(&pcie->intx_mask_lock);
> > > +	raw_spin_lock_init(&rp->intx_mask_lock);
> > >
> > >  	/* setup MSI */
> > >  	ret = mobiveil_allocate_msi_domains(pcie);
> > > @@ -862,6 +880,7 @@ static int mobiveil_pcie_probe(struct
> > platform_device *pdev)
> > >  	struct pci_bus *child;
> > >  	struct pci_host_bridge *bridge;
> > >  	struct device *dev = &pdev->dev;
> > > +	struct root_port *rp;
> > >  	int ret;
> > >
> > >  	/* allocate the PCIe port */
> > > @@ -870,6 +889,8 @@ static int mobiveil_pcie_probe(struct
> > platform_device *pdev)
> > >  		return -ENOMEM;
> > >
> > >  	pcie = pci_host_bridge_priv(bridge);
> > > +	rp = &pcie->rp;
> > > +	rp->bridge = bridge;
> > >
> > >  	pcie->pdev = pdev;
> > >
> > > @@ -904,12 +925,12 @@ static int mobiveil_pcie_probe(struct
> > platform_device *pdev)
> > >  		return ret;
> > >  	}
> > >
> > > -	irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
> > > +	irq_set_chained_handler_and_data(rp->irq, mobiveil_pcie_isr, pcie);
> > >
> > >  	/* Initialize bridge */
> > >  	bridge->dev.parent = dev;
> > >  	bridge->sysdata = pcie;
> > > -	bridge->busnr = pcie->root_bus_nr;
> > > +	bridge->busnr = rp->root_bus_nr;
> > >  	bridge->ops = &mobiveil_pcie_ops;
> > >  	bridge->map_irq = of_irq_parse_and_map_pci;
> > >  	bridge->swizzle_irq = pci_common_swizzle;
> > > --
> > > 2.17.1
> > >
