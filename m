Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1953CC71A
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jul 2021 02:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhGRAyJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Jul 2021 20:54:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233018AbhGRAyJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 17 Jul 2021 20:54:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA59861156;
        Sun, 18 Jul 2021 00:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626569472;
        bh=MuCxwf5nRDsd0QaHY1ZUifovvZ7uBwHtHaCIAONUs+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R2U0UuF8QIdYLomePQ8s0y+rZcGbp1PWIdXF93vuDz/LNf9GGXU5RFUJJUQjx2p0e
         mLmNy6GIJhcTmLOCh3Tg6xAsmXdHUhkrI7QcDkydhMoOqourxiYw9ifQNRQ3ytl2/B
         rdLOqr2dDXtnRe5CuoV9neyqjphwsbFBvInN5VYs3DGTKjPALgobWCN9cBCxWcQ93v
         CWU5Dy2iYhrbmslGHN1hxxF6RCpN7C9jemlXp0NrSmN5tclevO/8aZLz1QvLDaG7VT
         yACNYC/bLGRNKfd2TydS7tCjakuPlDkmFXaLV3wYLpTtDJUPkTh9e2yp8crncSWhXJ
         bZ2AFLEEKcyvw==
Received: by pali.im (Postfix)
        id 5EDA795D; Sun, 18 Jul 2021 02:51:09 +0200 (CEST)
Date:   Sun, 18 Jul 2021 02:51:09 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 3/3] PCI: uniphier: Add misc interrupt handler to
 invoke PME and AER
Message-ID: <20210718005109.6xwe3z7gxhuop5xc@pali>
References: <1603848703-21099-4-git-send-email-hayashi.kunihiko@socionext.com>
 <20201124232037.GA595463@bjorn-Precision-5520>
 <20201125102328.GA31700@e121166-lin.cambridge.arm.com>
 <f49a236d-c5f8-c445-f74e-7aa4eea70c3a@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f49a236d-c5f8-c445-f74e-7aa4eea70c3a@socionext.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Kunihiko! Now I found also this older email...

On Friday 27 November 2020 21:02:05 Kunihiko Hayashi wrote:
> Hi Bjorn Lorenzo,
> 
> On 2020/11/25 19:23, Lorenzo Pieralisi wrote:
> > On Tue, Nov 24, 2020 at 05:20:37PM -0600, Bjorn Helgaas wrote:
> > > On Wed, Oct 28, 2020 at 10:31:43AM +0900, Kunihiko Hayashi wrote:
> > > > This patch adds misc interrupt handler to detect and invoke PME/AER event.
> > > > 
> > > > In UniPhier PCIe controller, PME/AER signals are assigned to the same
> > > > signal as MSI by the internal logic. These signals should be detected by
> > > > the internal register, however, DWC MSI handler can't handle these signals.
> > > 
> > > I don't know what "PME/AER signals are assigned to the same signal as
> > > MSI" means.
> > 
> > The host controller embeds an interrupt-controller whose IRQ wire output
> > is cascaded into the main interrupt controller.
> > 
> > The host-bridge embedded controller receives MSI writes from devices
> > and it turns them into an edge IRQ into the main interrupt controller.
> > 
> > To ack/mask the MSIs at host contoller interrupt controller level, there
> > is a control register in the host controller that needs handling upon
> > IRQ reception.
> 
> Thanks for explaining that.
> In my understanding, PME/AER signals are cascaded to MSI by embedded
> interrupt controller (not "assigned").
> 
> 
> > The *RP* (and AFAIU the RP *only*) signals the PME/AER MSI using the
> > same wire to the main interrupt controller but its ack/mask is handled
> > by a different bit in the host bridge control register above, therefore
> > the cascaded IRQ isr needs to know which virq it is actually handling
> > to ack/mask accordingly.
> 
> Sorry what is RP? Root complex or something?

RP = Root Port

In lspci output you can find it as "root" of the tree topology and
should have "PCI bridge" class/name.

> > IMO this should be modelled with a separate IRQ domain and chip for
> > the root port (yes this implies describing the root port in the dts
> > file with a separate msi-parent).
> > 
> > This series as it stands is a kludge.
> 
> I see. However I need some time to consider the way to separate IRQ domain.
> Is there any idea or example to handle PME/AER with IRQ domain?

Seems that you are dealing with very similar issues as me with aardvark
driver.

As an inspiration look at my aardvark patch which setup separate IRQ
domain for PME, AER and HP interrupts:
https://lore.kernel.org/linux-pci/20210506153153.30454-32-pali@kernel.org/

Thanks to custom driver map_irq function, it is not needed to describe
root port with separate msi-parent in DTS.

> > > I'm trying to figure out if this is talking about PME/AER MSI vector
> > > numbers (probably not)

Bjorn, see my email, based on my experience with aardvark controller I
think they are MSI vector numbers, but controller instead uses own
proprietary way how to signal PME and AER interrupts.
https://lore.kernel.org/linux-pci/20210718002614.3l74hlondwgthuby@pali/

> > > or some internal wire that's not
> > > architecturally visible or what.
> > > 
> > > Probably also not related to the fact that PME, hotplug, and bandwidth
> > > notifications share the same MSI/MSI-X vector.
> > > 
> > > Is this something that's going to be applicable to all the DWC-based
> > > drivers?
> 
> I think that this feature depends on the vendor specification.
> At least, the registers to control or check these signals are implemented
> in the vendor's logic.
> 
> 
> > > > DWC MSI handler calls .msi_host_isr() callback function, that detects
> > > > PME/AER signals with the internal register and invokes the interrupt
> > > > with PME/AER vIRQ numbers.
> > > > 
> > > > These vIRQ numbers is obtained from portdrv in uniphier_add_pcie_port()
> > > > function.
> > > > 
> > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > > Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >   drivers/pci/controller/dwc/pcie-uniphier.c | 77 +++++++++++++++++++++++++-----
> > > >   1 file changed, 66 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> > > > index 4817626..237537a 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> > > > @@ -21,6 +21,7 @@
> > > >   #include <linux/reset.h>
> > > >   #include "pcie-designware.h"
> > > > +#include "../../pcie/portdrv.h"
> > > >   #define PCL_PINCTRL0			0x002c
> > > >   #define PCL_PERST_PLDN_REGEN		BIT(12)
> > > > @@ -44,7 +45,9 @@
> > > >   #define PCL_SYS_AUX_PWR_DET		BIT(8)
> > > >   #define PCL_RCV_INT			0x8108
> > > > +#define PCL_RCV_INT_ALL_INT_MASK	GENMASK(28, 25)
> > > >   #define PCL_RCV_INT_ALL_ENABLE		GENMASK(20, 17)
> > > > +#define PCL_RCV_INT_ALL_MSI_MASK	GENMASK(12, 9)
> > > >   #define PCL_CFG_BW_MGT_STATUS		BIT(4)
> > > >   #define PCL_CFG_LINK_AUTO_BW_STATUS	BIT(3)
> > > >   #define PCL_CFG_AER_RC_ERR_MSI_STATUS	BIT(2)
> > > > @@ -68,6 +71,8 @@ struct uniphier_pcie_priv {
> > > >   	struct reset_control *rst;
> > > >   	struct phy *phy;
> > > >   	struct irq_domain *legacy_irq_domain;
> > > > +	int aer_irq;
> > > > +	int pme_irq;
> > > >   };
> > > >   #define to_uniphier_pcie(x)	dev_get_drvdata((x)->dev)
> > > > @@ -167,7 +172,15 @@ static void uniphier_pcie_stop_link(struct dw_pcie *pci)
> > > >   static void uniphier_pcie_irq_enable(struct uniphier_pcie_priv *priv)
> > > >   {
> > > > -	writel(PCL_RCV_INT_ALL_ENABLE, priv->base + PCL_RCV_INT);
> > > > +	u32 val;
> > > > +
> > > > +	val = PCL_RCV_INT_ALL_ENABLE;
> > > > +	if (pci_msi_enabled())
> > > > +		val |= PCL_RCV_INT_ALL_INT_MASK;
> > > > +	else
> > > > +		val |= PCL_RCV_INT_ALL_MSI_MASK;
> > > 
> > > I'm confused about how this works.  Root Ports can signal AER errors
> > > with either INTx or MSI.  This is controlled by the architected
> > > Interrupt Disable bit and the MSI/MSI-X enable bits (I'm looking at
> > > PCIe r5.0, sec 6.2.4.1.2).
> > > 
> > > The code here doesn't look related to those bits.  Does this code mean
> > > that if pci_msi_enabled(), the Root Port will always signal with MSI
> > > (if MSI Enable is set) and will *never* signal with INTx?
> 
> According to the spec sheet, we need to set interrupt enable bit for either
> INTx or MSI, the other bit should be reset. These bits are in config space
> and handled by the framework.

Is spec sheet available publicly?

> The controller signals AER errors with the interrupt that is either INTx
> or MSI enabled. I think that the only way to know if MSI is enabled
> (and INTX is disabled) is to use pci_msi_enabled().
> 
> 
> > > > +	writel(val, priv->base + PCL_RCV_INT);
> > > >   	writel(PCL_RCV_INTX_ALL_ENABLE, priv->base + PCL_RCV_INTX);
> > > >   }
> > > > @@ -231,28 +244,52 @@ static const struct irq_domain_ops uniphier_intx_domain_ops = {
> > > >   	.map = uniphier_pcie_intx_map,
> > > >   };
> > > > -static void uniphier_pcie_irq_handler(struct irq_desc *desc)
> > > > +static void uniphier_pcie_misc_isr(struct pcie_port *pp, bool is_msi)
> > > >   {
> > > > -	struct pcie_port *pp = irq_desc_get_handler_data(desc);
> > > >   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > >   	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> > > > -	struct irq_chip *chip = irq_desc_get_chip(desc);
> > > > -	unsigned long reg;
> > > > -	u32 val, bit, virq;
> > > > +	u32 val;
> > > > -	/* INT for debug */
> > > >   	val = readl(priv->base + PCL_RCV_INT);
> > > >   	if (val & PCL_CFG_BW_MGT_STATUS)
> > > >   		dev_dbg(pci->dev, "Link Bandwidth Management Event\n");
> > > > +
> > > 
> > > Looks like a spurious whitespace change?
> 
> Oops, I'll remove it.
> 
> 
> > > >   	if (val & PCL_CFG_LINK_AUTO_BW_STATUS)
> > > >   		dev_dbg(pci->dev, "Link Autonomous Bandwidth Event\n");
> > > > -	if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
> > > > -		dev_dbg(pci->dev, "Root Error\n");
> > > > -	if (val & PCL_CFG_PME_MSI_STATUS)
> > > > -		dev_dbg(pci->dev, "PME Interrupt\n");
> > > > +
> > > > +	if (is_msi) {
> > > > +		if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS) {
> > > > +			dev_dbg(pci->dev, "Root Error Status\n");
> > > > +			if (priv->aer_irq)
> > > > +				generic_handle_irq(priv->aer_irq);
> > > > +		}
> > > > +
> > > > +		if (val & PCL_CFG_PME_MSI_STATUS) {
> > > > +			dev_dbg(pci->dev, "PME Interrupt\n");
> > > > +			if (priv->pme_irq)
> > > > +				generic_handle_irq(priv->pme_irq);
> > > > +		}
> > > > +	}
> > > >   	writel(val, priv->base + PCL_RCV_INT);
> > > > +}
> > > > +
> > > > +static void uniphier_pcie_msi_host_isr(struct pcie_port *pp)
> > > > +{
> > > > +	uniphier_pcie_misc_isr(pp, true);
> > > > +}
> > > > +
> > > > +static void uniphier_pcie_irq_handler(struct irq_desc *desc)
> > > > +{
> > > > +	struct pcie_port *pp = irq_desc_get_handler_data(desc);
> > > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> > > > +	struct irq_chip *chip = irq_desc_get_chip(desc);
> > > > +	unsigned long reg;
> > > > +	u32 val, bit, virq;
> > > > +
> > > > +	uniphier_pcie_misc_isr(pp, false);
> > > >   	/* INTx */
> > > >   	chained_irq_enter(chip, desc);
> > > > @@ -329,6 +366,7 @@ static int uniphier_pcie_host_init(struct pcie_port *pp)
> > > >   static const struct dw_pcie_host_ops uniphier_pcie_host_ops = {
> > > >   	.host_init = uniphier_pcie_host_init,
> > > > +	.msi_host_isr = uniphier_pcie_msi_host_isr,
> > > >   };
> > > >   static int uniphier_add_pcie_port(struct uniphier_pcie_priv *priv,
> > > > @@ -337,6 +375,7 @@ static int uniphier_add_pcie_port(struct uniphier_pcie_priv *priv,
> > > >   	struct dw_pcie *pci = &priv->pci;
> > > >   	struct pcie_port *pp = &pci->pp;
> > > >   	struct device *dev = &pdev->dev;
> > > > +	struct pci_dev *pcidev;
> > > >   	int ret;
> > > >   	pp->ops = &uniphier_pcie_host_ops;
> > > > @@ -353,6 +392,22 @@ static int uniphier_add_pcie_port(struct uniphier_pcie_priv *priv,
> > > >   		return ret;
> > > >   	}
> > > > +	/* irq for PME */
> > > > +	list_for_each_entry(pcidev, &pp->bridge->bus->devices, bus_list) {
> > > > +		priv->pme_irq =
> > > > +			pcie_port_service_get_irq(pcidev, PCIE_PORT_SERVICE_PME);
> > > > +		if (priv->pme_irq)
> > > > +			break;
> > > 
> > > Does this mean that all Root Ports must use the same MSI vector?  I
> > > don't think that's a PCIe spec requirement, though of course DWC may
> > > have its own restrictions.
> > > 
> 
> This controller has one port implementation only,
> so this assumes that there is one root port.
> 
> 
> > > I don't think this depends on CONFIG_PCIEPORTBUS, so it looks like
> > > it's possible to have
> > > 
> > >    # CONFIG_PCIEPORTBUS is not set
> > >    PCIE_UNIPHIER=y
> > > 
> > > in which case I think you'll have a link error.
> 
> Indeed. To use port functions needs to define PCIEPORTBUS.
> I'll update PCIE_UNIPHIER in Kconfig.
> 
> 
> Thank you,
> 
> ---
> Best Regards
> Kunihiko Hayashi
