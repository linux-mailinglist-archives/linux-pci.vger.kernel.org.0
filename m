Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A433B2C3D92
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 11:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgKYKXh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 05:23:37 -0500
Received: from foss.arm.com ([217.140.110.172]:38276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgKYKXh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 05:23:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F25C2106F;
        Wed, 25 Nov 2020 02:23:35 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B4FC3F70D;
        Wed, 25 Nov 2020 02:23:34 -0800 (PST)
Date:   Wed, 25 Nov 2020 10:23:28 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <mhiramat@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 3/3] PCI: uniphier: Add misc interrupt handler to
 invoke PME and AER
Message-ID: <20201125102328.GA31700@e121166-lin.cambridge.arm.com>
References: <1603848703-21099-4-git-send-email-hayashi.kunihiko@socionext.com>
 <20201124232037.GA595463@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124232037.GA595463@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 24, 2020 at 05:20:37PM -0600, Bjorn Helgaas wrote:
> On Wed, Oct 28, 2020 at 10:31:43AM +0900, Kunihiko Hayashi wrote:
> > This patch adds misc interrupt handler to detect and invoke PME/AER event.
> > 
> > In UniPhier PCIe controller, PME/AER signals are assigned to the same
> > signal as MSI by the internal logic. These signals should be detected by
> > the internal register, however, DWC MSI handler can't handle these signals.
> 
> I don't know what "PME/AER signals are assigned to the same signal as
> MSI" means.  

The host controller embeds an interrupt-controller whose IRQ wire output
is cascaded into the main interrupt controller.

The host-bridge embedded controller receives MSI writes from devices
and it turns them into an edge IRQ into the main interrupt controller.

To ack/mask the MSIs at host contoller interrupt controller level, there
is a control register in the host controller that needs handling upon
IRQ reception.

The *RP* (and AFAIU the RP *only*) signals the PME/AER MSI using the
same wire to the main interrupt controller but its ack/mask is handled
by a different bit in the host bridge control register above, therefore
the cascaded IRQ isr needs to know which virq it is actually handling
to ack/mask accordingly.

IMO this should be modelled with a separate IRQ domain and chip for
the root port (yes this implies describing the root port in the dts
file with a separate msi-parent).

This series as it stands is a kludge.

Lorenzo

> I'm trying to figure out if this is talking about PME/AER MSI vector
> numbers (probably not) or some internal wire that's not
> architecturally visible or what.
> 
> Probably also not related to the fact that PME, hotplug, and bandwidth
> notifications share the same MSI/MSI-X vector.
> 
> Is this something that's going to be applicable to all the DWC-based
> drivers?
> 
> > DWC MSI handler calls .msi_host_isr() callback function, that detects
> > PME/AER signals with the internal register and invokes the interrupt
> > with PME/AER vIRQ numbers.
> > 
> > These vIRQ numbers is obtained from portdrv in uniphier_add_pcie_port()
> > function.
> > 
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-uniphier.c | 77 +++++++++++++++++++++++++-----
> >  1 file changed, 66 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> > index 4817626..237537a 100644
> > --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> > +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/reset.h>
> >  
> >  #include "pcie-designware.h"
> > +#include "../../pcie/portdrv.h"
> >  
> >  #define PCL_PINCTRL0			0x002c
> >  #define PCL_PERST_PLDN_REGEN		BIT(12)
> > @@ -44,7 +45,9 @@
> >  #define PCL_SYS_AUX_PWR_DET		BIT(8)
> >  
> >  #define PCL_RCV_INT			0x8108
> > +#define PCL_RCV_INT_ALL_INT_MASK	GENMASK(28, 25)
> >  #define PCL_RCV_INT_ALL_ENABLE		GENMASK(20, 17)
> > +#define PCL_RCV_INT_ALL_MSI_MASK	GENMASK(12, 9)
> >  #define PCL_CFG_BW_MGT_STATUS		BIT(4)
> >  #define PCL_CFG_LINK_AUTO_BW_STATUS	BIT(3)
> >  #define PCL_CFG_AER_RC_ERR_MSI_STATUS	BIT(2)
> > @@ -68,6 +71,8 @@ struct uniphier_pcie_priv {
> >  	struct reset_control *rst;
> >  	struct phy *phy;
> >  	struct irq_domain *legacy_irq_domain;
> > +	int aer_irq;
> > +	int pme_irq;
> >  };
> >  
> >  #define to_uniphier_pcie(x)	dev_get_drvdata((x)->dev)
> > @@ -167,7 +172,15 @@ static void uniphier_pcie_stop_link(struct dw_pcie *pci)
> >  
> >  static void uniphier_pcie_irq_enable(struct uniphier_pcie_priv *priv)
> >  {
> > -	writel(PCL_RCV_INT_ALL_ENABLE, priv->base + PCL_RCV_INT);
> > +	u32 val;
> > +
> > +	val = PCL_RCV_INT_ALL_ENABLE;
> > +	if (pci_msi_enabled())
> > +		val |= PCL_RCV_INT_ALL_INT_MASK;
> > +	else
> > +		val |= PCL_RCV_INT_ALL_MSI_MASK;
> 
> I'm confused about how this works.  Root Ports can signal AER errors
> with either INTx or MSI.  This is controlled by the architected
> Interrupt Disable bit and the MSI/MSI-X enable bits (I'm looking at
> PCIe r5.0, sec 6.2.4.1.2).
> 
> The code here doesn't look related to those bits.  Does this code mean
> that if pci_msi_enabled(), the Root Port will always signal with MSI
> (if MSI Enable is set) and will *never* signal with INTx?
> 
> > +	writel(val, priv->base + PCL_RCV_INT);
> >  	writel(PCL_RCV_INTX_ALL_ENABLE, priv->base + PCL_RCV_INTX);
> >  }
> >  
> > @@ -231,28 +244,52 @@ static const struct irq_domain_ops uniphier_intx_domain_ops = {
> >  	.map = uniphier_pcie_intx_map,
> >  };
> >  
> > -static void uniphier_pcie_irq_handler(struct irq_desc *desc)
> > +static void uniphier_pcie_misc_isr(struct pcie_port *pp, bool is_msi)
> >  {
> > -	struct pcie_port *pp = irq_desc_get_handler_data(desc);
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >  	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> > -	struct irq_chip *chip = irq_desc_get_chip(desc);
> > -	unsigned long reg;
> > -	u32 val, bit, virq;
> > +	u32 val;
> >  
> > -	/* INT for debug */
> >  	val = readl(priv->base + PCL_RCV_INT);
> >  
> >  	if (val & PCL_CFG_BW_MGT_STATUS)
> >  		dev_dbg(pci->dev, "Link Bandwidth Management Event\n");
> > +
> 
> Looks like a spurious whitespace change?
> 
> >  	if (val & PCL_CFG_LINK_AUTO_BW_STATUS)
> >  		dev_dbg(pci->dev, "Link Autonomous Bandwidth Event\n");
> > -	if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
> > -		dev_dbg(pci->dev, "Root Error\n");
> > -	if (val & PCL_CFG_PME_MSI_STATUS)
> > -		dev_dbg(pci->dev, "PME Interrupt\n");
> > +
> > +	if (is_msi) {
> > +		if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS) {
> > +			dev_dbg(pci->dev, "Root Error Status\n");
> > +			if (priv->aer_irq)
> > +				generic_handle_irq(priv->aer_irq);
> > +		}
> > +
> > +		if (val & PCL_CFG_PME_MSI_STATUS) {
> > +			dev_dbg(pci->dev, "PME Interrupt\n");
> > +			if (priv->pme_irq)
> > +				generic_handle_irq(priv->pme_irq);
> > +		}
> > +	}
> >  
> >  	writel(val, priv->base + PCL_RCV_INT);
> > +}
> > +
> > +static void uniphier_pcie_msi_host_isr(struct pcie_port *pp)
> > +{
> > +	uniphier_pcie_misc_isr(pp, true);
> > +}
> > +
> > +static void uniphier_pcie_irq_handler(struct irq_desc *desc)
> > +{
> > +	struct pcie_port *pp = irq_desc_get_handler_data(desc);
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> > +	struct irq_chip *chip = irq_desc_get_chip(desc);
> > +	unsigned long reg;
> > +	u32 val, bit, virq;
> > +
> > +	uniphier_pcie_misc_isr(pp, false);
> >  
> >  	/* INTx */
> >  	chained_irq_enter(chip, desc);
> > @@ -329,6 +366,7 @@ static int uniphier_pcie_host_init(struct pcie_port *pp)
> >  
> >  static const struct dw_pcie_host_ops uniphier_pcie_host_ops = {
> >  	.host_init = uniphier_pcie_host_init,
> > +	.msi_host_isr = uniphier_pcie_msi_host_isr,
> >  };
> >  
> >  static int uniphier_add_pcie_port(struct uniphier_pcie_priv *priv,
> > @@ -337,6 +375,7 @@ static int uniphier_add_pcie_port(struct uniphier_pcie_priv *priv,
> >  	struct dw_pcie *pci = &priv->pci;
> >  	struct pcie_port *pp = &pci->pp;
> >  	struct device *dev = &pdev->dev;
> > +	struct pci_dev *pcidev;
> >  	int ret;
> >  
> >  	pp->ops = &uniphier_pcie_host_ops;
> > @@ -353,6 +392,22 @@ static int uniphier_add_pcie_port(struct uniphier_pcie_priv *priv,
> >  		return ret;
> >  	}
> >  
> > +	/* irq for PME */
> > +	list_for_each_entry(pcidev, &pp->bridge->bus->devices, bus_list) {
> > +		priv->pme_irq =
> > +			pcie_port_service_get_irq(pcidev, PCIE_PORT_SERVICE_PME);
> > +		if (priv->pme_irq)
> > +			break;
> 
> Does this mean that all Root Ports must use the same MSI vector?  I
> don't think that's a PCIe spec requirement, though of course DWC may
> have its own restrictions.
> 
> I don't think this depends on CONFIG_PCIEPORTBUS, so it looks like
> it's possible to have
> 
>   # CONFIG_PCIEPORTBUS is not set
>   PCIE_UNIPHIER=y
> 
> in which case I think you'll have a link error.
> 
> > +	}
> > +
> > +	/* irq for AER */
> > +	list_for_each_entry(pcidev, &pp->bridge->bus->devices, bus_list) {
> > +		priv->aer_irq =
> > +			pcie_port_service_get_irq(pcidev, PCIE_PORT_SERVICE_AER);
> > +		if (priv->aer_irq)
> > +			break;
> > +	}
> > +
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.7.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
