Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089F721F278
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 15:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgGNN1f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 09:27:35 -0400
Received: from foss.arm.com ([217.140.110.172]:55572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgGNN1f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 09:27:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81C1C1FB;
        Tue, 14 Jul 2020 06:27:34 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D57D83F68F;
        Tue, 14 Jul 2020 06:27:32 -0700 (PDT)
Date:   Tue, 14 Jul 2020 14:27:27 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v5 2/6] PCI: uniphier: Add misc interrupt handler to
 invoke PME and AER
Message-ID: <20200714132727.GA13061@e121166-lin.cambridge.arm.com>
References: <1592469493-1549-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1592469493-1549-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592469493-1549-3-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 18, 2020 at 05:38:09PM +0900, Kunihiko Hayashi wrote:
> The misc interrupts consisting of PME, AER, and Link event, is handled
> by INTx handler, however, these interrupts should be also handled by
> MSI handler.

Define what you mean please.

> This adds the function uniphier_pcie_misc_isr() that handles misc
> interrupts, which is called from both INTx and MSI handlers.
> This function detects PME and AER interrupts with the status register,
> and invoke PME and AER drivers related to MSI.
> 
> And this sets the mask for misc interrupts from INTx if MSI is enabled
> and sets the mask for misc interrupts from MSI if MSI is disabled.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/controller/dwc/pcie-uniphier.c | 57 ++++++++++++++++++++++++------
>  1 file changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> index a5401a0..5ce2479 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> @@ -44,7 +44,9 @@
>  #define PCL_SYS_AUX_PWR_DET		BIT(8)
>  
>  #define PCL_RCV_INT			0x8108
> +#define PCL_RCV_INT_ALL_INT_MASK	GENMASK(28, 25)
>  #define PCL_RCV_INT_ALL_ENABLE		GENMASK(20, 17)
> +#define PCL_RCV_INT_ALL_MSI_MASK	GENMASK(12, 9)
>  #define PCL_CFG_BW_MGT_STATUS		BIT(4)
>  #define PCL_CFG_LINK_AUTO_BW_STATUS	BIT(3)
>  #define PCL_CFG_AER_RC_ERR_MSI_STATUS	BIT(2)
> @@ -167,7 +169,15 @@ static void uniphier_pcie_stop_link(struct dw_pcie *pci)
>  
>  static void uniphier_pcie_irq_enable(struct uniphier_pcie_priv *priv)
>  {
> -	writel(PCL_RCV_INT_ALL_ENABLE, priv->base + PCL_RCV_INT);
> +	u32 val;
> +
> +	val = PCL_RCV_INT_ALL_ENABLE;
> +	if (pci_msi_enabled())
> +		val |= PCL_RCV_INT_ALL_INT_MASK;
> +	else
> +		val |= PCL_RCV_INT_ALL_MSI_MASK;
> +
> +	writel(val, priv->base + PCL_RCV_INT);
>  	writel(PCL_RCV_INTX_ALL_ENABLE, priv->base + PCL_RCV_INTX);
>  }
>  
> @@ -231,32 +241,56 @@ static const struct irq_domain_ops uniphier_intx_domain_ops = {
>  	.map = uniphier_pcie_intx_map,
>  };
>  
> -static void uniphier_pcie_irq_handler(struct irq_desc *desc)
> +static void uniphier_pcie_misc_isr(struct pcie_port *pp, bool is_msi)
>  {
> -	struct pcie_port *pp = irq_desc_get_handler_data(desc);
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> -	struct irq_chip *chip = irq_desc_get_chip(desc);
> -	unsigned long reg;
> -	u32 val, bit, virq;
> +	u32 val, virq;
>  
> -	/* INT for debug */
>  	val = readl(priv->base + PCL_RCV_INT);
>  
>  	if (val & PCL_CFG_BW_MGT_STATUS)
>  		dev_dbg(pci->dev, "Link Bandwidth Management Event\n");
> +
>  	if (val & PCL_CFG_LINK_AUTO_BW_STATUS)
>  		dev_dbg(pci->dev, "Link Autonomous Bandwidth Event\n");
> -	if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
> -		dev_dbg(pci->dev, "Root Error\n");
> -	if (val & PCL_CFG_PME_MSI_STATUS)
> -		dev_dbg(pci->dev, "PME Interrupt\n");
> +
> +	if (is_msi) {
> +		if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
> +			dev_dbg(pci->dev, "Root Error Status\n");
> +
> +		if (val & PCL_CFG_PME_MSI_STATUS)
> +			dev_dbg(pci->dev, "PME Interrupt\n");
> +
> +		if (val & (PCL_CFG_AER_RC_ERR_MSI_STATUS |
> +			   PCL_CFG_PME_MSI_STATUS)) {
> +			virq = irq_linear_revmap(pp->irq_domain, 0);

I think this is wrong. pp->irq_domain is the DWC MSI domain, how do
you know that hwirq 0 *is* the AER/PME interrupt ?

It just *works* in this case because the port driver probes and alloc
MSIs before any PCI device has a chance to do it and actually I think
this is just wrong also because hwirq 0 *is* usable by devices but
it can't be used because current code takes it for the PME/AER interrupt
(which AFAICS is an internal signal disconnected from the DWC MSI
interrupt controller).

I think this extra glue logic should be separate MSI domain
otherwise there is no way you can reliably look-up the virq
corresponding to AER/PME.

How does it work in HW ? Is the root port really sending a memory
write to raise an IRQ or it just signal the IRQ through internal
logic ? I think the root port MSI handling is different from the
DWC logic and should be treated separately.

Lorenzo

> +			generic_handle_irq(virq);
> +		}
> +	}
>  
>  	writel(val, priv->base + PCL_RCV_INT);
> +}
> +
> +static void uniphier_pcie_msi_host_isr(struct pcie_port *pp)
> +{
> +	uniphier_pcie_misc_isr(pp, true);
> +}
> +
> +static void uniphier_pcie_irq_handler(struct irq_desc *desc)
> +{
> +	struct pcie_port *pp = irq_desc_get_handler_data(desc);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned long reg;
> +	u32 val, bit, virq;
>  
>  	/* INTx */
>  	chained_irq_enter(chip, desc);
>  
> +	uniphier_pcie_misc_isr(pp, false);
> +
>  	val = readl(priv->base + PCL_RCV_INTX);
>  	reg = FIELD_GET(PCL_RCV_INTX_ALL_STATUS, val);
>  
> @@ -330,6 +364,7 @@ static int uniphier_pcie_host_init(struct pcie_port *pp)
>  
>  static const struct dw_pcie_host_ops uniphier_pcie_host_ops = {
>  	.host_init = uniphier_pcie_host_init,
> +	.msi_host_isr = uniphier_pcie_msi_host_isr,
>  };
>  
>  static int uniphier_add_pcie_port(struct uniphier_pcie_priv *priv,
> -- 
> 2.7.4
> 
