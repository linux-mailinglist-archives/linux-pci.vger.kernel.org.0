Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3165A3E42FD
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 11:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhHIJj1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 9 Aug 2021 05:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234468AbhHIJj1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Aug 2021 05:39:27 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 994FE60F35;
        Mon,  9 Aug 2021 09:39:06 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mD1kO-003mj9-6f; Mon, 09 Aug 2021 10:39:04 +0100
Date:   Mon, 09 Aug 2021 10:39:03 +0100
Message-ID: <87o8a7arew.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Tom Joseph <tjoseph@cadence.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v2 2/3] PCI: j721e: Add PCI legacy interrupt support for J721E
In-Reply-To: <c20be7ae-e4a7-c3ba-f1c9-e4ff2aae0a66@ti.com>
References: <20210804132912.30685-1-kishon@ti.com>
        <20210804132912.30685-3-kishon@ti.com>
        <87h7g5w8d8.wl-maz@kernel.org>
        <c20be7ae-e4a7-c3ba-f1c9-e4ff2aae0a66@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kishon@ti.com, bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com, tjoseph@cadence.com, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lokeshvutla@ti.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 09 Aug 2021 05:50:10 +0100,
Kishon Vijay Abraham I <kishon@ti.com> wrote:
> 
> Hi Marc,
> 
> On 04/08/21 8:43 pm, Marc Zyngier wrote:
> > On Wed, 04 Aug 2021 14:29:11 +0100,
> > Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>
> >> Add PCI legacy interrupt support for J721E. J721E has a single HW
> >> interrupt line for all the four legacy interrupts INTA/INTB/INTC/INTD.
> >> The HW interrupt line connected to GIC is a pulse interrupt whereas
> >> the legacy interrupts by definition is level interrupt. In order to
> >> provide level interrupt functionality to edge interrupt line, PCIe
> >> in J721E has provided IRQ_EOI register.
> >>
> >> However due to Errata ID #i2094 ([1]), EOI feature is not enabled in HW
> >> and only a single pulse interrupt will be generated for every
> >> ASSERT_INTx/DEASSERT_INTx.
> > 
> > So my earlier remark stands. If you get a single edge, how do you
> > handle a level that is still high after having handled the interrupt
> > on hardware that has this bug?
> 
> Right, this hardware (J721E) has a bug but was fixed in J7200 (Patch 3/3
> handles that).

But how do you make it work with J721E? Is it even worth supporting if
(as I expect) it is unreliable?

> > 
> >>
> >> [1] -> J721E DRA829/TDA4VM Processors Silicon Revision 1.1/1.0 SPRZ455A –
> >>        DECEMBER 2020 – REVISED AUGUST 2021
> >>        (https://www.ti.com/lit/er/sprz455a/sprz455a.pdf)
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  drivers/pci/controller/cadence/pci-j721e.c | 85 ++++++++++++++++++++++
> >>  1 file changed, 85 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> >> index 2ec037c43bd5..c2e7a78dc31f 100644
> >> --- a/drivers/pci/controller/cadence/pci-j721e.c
> >> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> >> @@ -29,6 +29,13 @@
> >>  #define LINK_DOWN		BIT(1)
> >>  #define J7200_LINK_DOWN		BIT(10)
> >>  
> >> +#define EOI_REG			0x10
> >> +
> >> +#define ENABLE_REG_SYS_0	0x100
> >> +#define STATUS_REG_SYS_0	0x500
> >> +#define STATUS_CLR_REG_SYS_0	0x700
> >> +#define INTx_EN(num)		(1 << (num))
> >> +
> >>  #define J721E_PCIE_USER_CMD_STATUS	0x4
> >>  #define LINK_TRAINING_ENABLE		BIT(0)
> >>  
> >> @@ -59,6 +66,7 @@ struct j721e_pcie {
> >>  	void __iomem		*user_cfg_base;
> >>  	void __iomem		*intd_cfg_base;
> >>  	u32			linkdown_irq_regfield;
> >> +	struct irq_domain	*legacy_irq_domain;
> >>  };
> >>  
> >>  enum j721e_pcie_mode {
> >> @@ -121,6 +129,79 @@ static void j721e_pcie_config_link_irq(struct j721e_pcie *pcie)
> >>  	j721e_pcie_intd_writel(pcie, ENABLE_REG_SYS_2, reg);
> >>  }
> >>  
> >> +static void j721e_pcie_v1_legacy_irq_handler(struct irq_desc *desc)
> >> +{
> >> +	struct j721e_pcie *pcie = irq_desc_get_handler_data(desc);
> >> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> >> +	int i, virq;
> >> +	u32 reg;
> >> +
> >> +	chained_irq_enter(chip, desc);
> >> +
> >> +	for (i = 0; i < PCI_NUM_INTX; i++) {
> >> +		reg = j721e_pcie_intd_readl(pcie, STATUS_REG_SYS_0);
> >> +		if (!(reg & INTx_EN(i)))
> >> +			continue;
> > 
> > Why do you need to perform multiple reads? Surely reg contains all the
> > bits you need, doesn't it?
> 
> Right, will fix it up.
> > 
> >> +
> >> +		virq = irq_find_mapping(pcie->legacy_irq_domain, 3 - i);
> >> +		generic_handle_irq(virq);
> > 
> > Please combine both lines into a single generic_handle_domain_irq()
> > call.
> 
> Okay.
> > 
> >> +		j721e_pcie_intd_writel(pcie, STATUS_CLR_REG_SYS_0, INTx_EN(i));
> > 
> > What is the purpose of this write? It feels like this should be a
> > irq_eoi callback.
> 
> It's an IRQ ACK, since in this platform the level to edge is not
> implemented properly in HW.

An Ack for an edge interrupt would need to happen before you handle
the interrupt, or you'd wrongly acknowledge edges that fire between
the handling of the interrupt and the Ack, and that would never be
handled.

If it really is an Ack, it needs to be moved *before* the handling,
preferably in an irq_ack callback. Otherwise, it is an EOI, and it
belongs to irq_eoi.

> > 
> >> +	}
> >> +
> >> +	chained_irq_exit(chip, desc);
> >> +}
> >> +
> >> +static int j721e_pcie_intx_map(struct irq_domain *domain, unsigned int irq, irq_hw_number_t hwirq)
> >> +{
> >> +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> > 
> > An INTx interrupt is a level interrupt. Please use the corresponding flow.
> 
> Okay.
> > 
> >> +	irq_set_chip_data(irq, domain->host_data);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct irq_domain_ops j721e_pcie_intx_domain_ops = {
> >> +	.map = j721e_pcie_intx_map,
> >> +};
> >> +
> >> +static int j721e_pcie_config_legacy_irq(struct j721e_pcie *pcie)
> >> +{
> >> +	struct irq_domain *legacy_irq_domain;
> >> +	struct device *dev = pcie->dev;
> >> +	struct device_node *node = dev->of_node;
> >> +	struct device_node *intc_node;
> >> +	int irq, i;
> >> +	u32 reg;
> >> +
> >> +	intc_node = of_get_child_by_name(node, "interrupt-controller");
> >> +	if (!intc_node) {
> >> +		dev_dbg(dev, "interrupt-controller node is absent. Legacy INTR not supported\n");
> >> +		return 0;
> >> +	}
> >> +
> >> +	irq = irq_of_parse_and_map(intc_node, 0);
> >> +	if (!irq) {
> >> +		dev_err(dev, "Failed to parse and map legacy irq\n");
> >> +		return -EINVAL;
> >> +	}
> >> +	irq_set_chained_handler_and_data(irq, j721e_pcie_v1_legacy_irq_handler, pcie);
> >> +
> >> +	legacy_irq_domain = irq_domain_add_linear(intc_node, PCI_NUM_INTX,
> >> +						  &j721e_pcie_intx_domain_ops, pcie);
> >> +	if (!legacy_irq_domain) {
> >> +		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
> >> +		return -EINVAL;
> >> +	}
> >> +	pcie->legacy_irq_domain = legacy_irq_domain;
> >> +
> >> +	for (i = 0; i < PCI_NUM_INTX; i++) {
> >> +		reg = j721e_pcie_intd_readl(pcie, ENABLE_REG_SYS_0);
> >> +		reg |= INTx_EN(i);
> >> +		j721e_pcie_intd_writel(pcie, ENABLE_REG_SYS_0, reg);
> >> +	}
> > 
> > This should be moved to the irq_unmask() callback.
> 
> Should we also have a corresponding irq_mask()? Then would require us
> implement reference counting since legacy interrupts are shared.

The core code should already deal with this, I expect. It isn't like
shared interrupts are something new. And yes, you should have both
mask and unmask.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
