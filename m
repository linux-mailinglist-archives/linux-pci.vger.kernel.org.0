Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E3B3CC706
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jul 2021 02:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhGRA3P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Jul 2021 20:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230259AbhGRA3P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 17 Jul 2021 20:29:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB6FD61153;
        Sun, 18 Jul 2021 00:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626567978;
        bh=URoambk1xvFO2WPF6LufgHf8T3Y30E5lldB6rMC0Gxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MRhAQ4RYE9+YNKwm6uB4bxR+Ioh6atTI8BXom7t3jQeFqq6T30INZAuU4tF/c6JAS
         SohO3UvdZqD0aPeKpeben0kxtxuaKzLcaG4GTf6lh+EYLngTIYkswC8nOFSRanurBy
         aLbash0ENbyn0ELvB2I1TRMLYUwXYzgLN/8MDiiCbYwkSntmXvXrvWbCp8k8l5bisa
         2VBmiM1FKa7+osCHDRY5uFY9R63d5Xhtrj7dygthh27uVeURklHVrueiPlWQP2TWlK
         KhwDddmNwdR+9v9Rqy1QTXyQe2AABGrUCYuGsX9dCFTEPFnqyfoUnwU1+wczjf/Pfg
         814jiwHDBAy9Q==
Received: by pali.im (Postfix)
        id 0772795D; Sun, 18 Jul 2021 02:26:14 +0200 (CEST)
Date:   Sun, 18 Jul 2021 02:26:14 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH v11 3/3] PCI: uniphier: Add misc interrupt handler to
 invoke PME and AER
Message-ID: <20210718002614.3l74hlondwgthuby@pali>
References: <1619111097-10232-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1619111097-10232-4-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619111097-10232-4-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Kunihiko!

On Friday 23 April 2021 02:04:57 Kunihiko Hayashi wrote:
> This patch adds misc interrupt handler to detect and invoke PME/AER event.
> 
> In UniPhier PCIe controller, PME/AER signals are assigned to the same
> signal as MSI by the internal logic. These signals should be detected by
> the internal register, however, DWC MSI handler can't handle these signals.
> 
> DWC MSI handler calls .msi_host_isr() callback function, that detects
> PME/AER signals using the internal register and invokes the interrupt
> with PME/AER IRQ numbers.
> 
> These IRQ numbers is obtained by uniphier_pcie_port_get_irq() function,
> that finds the device that matches PME/AER from the devices associated
> with Root Port, and returns its IRQ number.

If I understood this issue correctly, it means that your PCIe controller
does not issue regular MSI interrupt for PME and AER events, but rather
it issue controller specific interrupt and you need to figure out what
kind of controller-specific event happened (e.g. PME or AER or something
else).

But if your controller supports PME or AER then it expose in its PCIe
Root Port capabilities register MSI number for these PME and AER events.
Kernel PCIe PME and AER drivers read from capabilities register these
numbers and register irq functions to be called when interrupt happens.

So it means that you do not need to implement uniphier_pcie_port_get_irq
function via this "ugly" foreach and call pcie_port_service_get_irq. But
you can read this MSI interrupt number directly from your controller in
this pcie-uniphier.c driver and then use irq_find_mapping() to convert
hw MSI number to kernel's virq (used in generic_handle_irq()).

Because currently you use in pcie-uniphier.c call to function
pcie_port_service_get_irq() which returns cached interrupt number value
which was read from PCIe Root Port capability register by PCI subsystem
callbacked back to the pcie-uniphier.c driver.

For me this looks like "ugly" if you need to do something in
"complicated" way and add dependency e.g. on compile options like
"if (!IS_ENABLED(CONFIG_PCIEAER) && !IS_ENABLED(CONFIG_PCIE_PME))" if it
can be easily avoided.

I'm writing this because I was solving exactly same problem for aardvark
PCIe controller with PME, AER and HP interrupts (patches are on ML). So
I think that this pcie-uniphier.c implementation can be simplified
without need to use checks for CONFIG_* options and calling
pcie_port_service_get_irq() in list_for_each_entry loop.


Could you please post output of 'lspci -nn -vv'? In my opinion MSI
numbers for AER and PME in Root Port could be constant so it may
simplify implementation even more. (Just to note that in my case
aardvark returns zero as MSI number and it is also documented in spec).

> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-uniphier.c | 105 +++++++++++++++++++++++++----
>  1 file changed, 91 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> index 7e8bad3..dcd8fa8 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> @@ -21,6 +21,7 @@
>  #include <linux/reset.h>
>  
>  #include "pcie-designware.h"
> +#include "../../pcie/portdrv.h"
>  
>  #define PCL_PINCTRL0			0x002c
>  #define PCL_PERST_PLDN_REGEN		BIT(12)
> @@ -44,7 +45,9 @@
>  #define PCL_SYS_AUX_PWR_DET		BIT(8)
>  
>  #define PCL_RCV_INT			0x8108
> +#define PCL_RCV_INT_ALL_INT_MASK	GENMASK(28, 25)
>  #define PCL_RCV_INT_ALL_ENABLE		GENMASK(20, 17)
> +#define PCL_RCV_INT_ALL_MSI_MASK	GENMASK(12, 9)
>  #define PCL_CFG_BW_MGT_STATUS		BIT(4)
>  #define PCL_CFG_LINK_AUTO_BW_STATUS	BIT(3)
>  #define PCL_CFG_AER_RC_ERR_MSI_STATUS	BIT(2)
> @@ -68,6 +71,8 @@ struct uniphier_pcie_priv {
>  	struct reset_control *rst;
>  	struct phy *phy;
>  	struct irq_domain *legacy_irq_domain;
> +	int aer_irq;
> +	int pme_irq;
>  };
>  
>  #define to_uniphier_pcie(x)	dev_get_drvdata((x)->dev)
> @@ -164,7 +169,15 @@ static void uniphier_pcie_stop_link(struct dw_pcie *pci)
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
> @@ -228,28 +241,51 @@ static const struct irq_domain_ops uniphier_intx_domain_ops = {
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
> +	u32 val;
>  
> -	/* INT for debug */
>  	val = readl(priv->base + PCL_RCV_INT);
>  
>  	if (val & PCL_CFG_BW_MGT_STATUS)
>  		dev_dbg(pci->dev, "Link Bandwidth Management Event\n");
>  	if (val & PCL_CFG_LINK_AUTO_BW_STATUS)
>  		dev_dbg(pci->dev, "Link Autonomous Bandwidth Event\n");
> -	if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
> -		dev_dbg(pci->dev, "Root Error\n");
> -	if (val & PCL_CFG_PME_MSI_STATUS)
> -		dev_dbg(pci->dev, "PME Interrupt\n");
> +
> +	if (is_msi) {
> +		if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS) {
> +			dev_dbg(pci->dev, "Root Error Status\n");
> +			if (priv->aer_irq)
> +				generic_handle_irq(priv->aer_irq);
> +		}
> +
> +		if (val & PCL_CFG_PME_MSI_STATUS) {
> +			dev_dbg(pci->dev, "PME Interrupt\n");
> +			if (priv->pme_irq)
> +				generic_handle_irq(priv->pme_irq);
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
> +	u32 val, bit, irq;
> +
> +	uniphier_pcie_misc_isr(pp, false);
>  
>  	/* INTx */
>  	chained_irq_enter(chip, desc);
> @@ -258,8 +294,8 @@ static void uniphier_pcie_irq_handler(struct irq_desc *desc)
>  	reg = FIELD_GET(PCL_RCV_INTX_ALL_STATUS, val);
>  
>  	for_each_set_bit(bit, &reg, PCI_NUM_INTX) {
> -		virq = irq_linear_revmap(priv->legacy_irq_domain, bit);
> -		generic_handle_irq(virq);
> +		irq = irq_linear_revmap(priv->legacy_irq_domain, bit);
> +		generic_handle_irq(irq);
>  	}
>  
>  	chained_irq_exit(chip, desc);
> @@ -317,8 +353,45 @@ static int uniphier_pcie_host_init(struct pcie_port *pp)
>  	return 0;
>  }
>  
> +static int uniphier_pcie_port_get_irq(struct pcie_port *pp, u32 service)
> +{
> +	struct pci_dev *pcidev;
> +	int irq = 0;
> +
> +	if (!IS_ENABLED(CONFIG_PCIEAER) && !IS_ENABLED(CONFIG_PCIE_PME))
> +		return 0;
> +
> +	/*
> +	 * Finds the device that matches 'service' from the devices
> +	 * associated with Root Port, and returns its IRQ number.
> +	 */
> +	list_for_each_entry(pcidev, &pp->bridge->bus->devices, bus_list) {
> +		irq = pcie_port_service_get_irq(pcidev, service);
> +		if (irq)
> +			break;
> +	}
> +
> +	return irq;
> +}
> +
> +static int uniphier_pcie_host_init_complete(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> +
> +	if (IS_ENABLED(CONFIG_PCIE_PME))
> +		priv->pme_irq =
> +			uniphier_pcie_port_get_irq(pp, PCIE_PORT_SERVICE_PME);
> +	if (IS_ENABLED(CONFIG_PCIEAER))
> +		priv->aer_irq =
> +			uniphier_pcie_port_get_irq(pp, PCIE_PORT_SERVICE_AER);
> +
> +	return 0;
> +}
> +
>  static const struct dw_pcie_host_ops uniphier_pcie_host_ops = {
>  	.host_init = uniphier_pcie_host_init,
> +	.msi_host_isr = uniphier_pcie_msi_host_isr,
>  };
>  
>  static int uniphier_pcie_host_enable(struct uniphier_pcie_priv *priv)
> @@ -398,7 +471,11 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
>  
>  	priv->pci.pp.ops = &uniphier_pcie_host_ops;
>  
> -	return dw_pcie_host_init(&priv->pci.pp);
> +	ret = dw_pcie_host_init(&priv->pci.pp);
> +	if (ret)
> +		return ret;
> +
> +	return uniphier_pcie_host_init_complete(&priv->pci.pp);
>  }
>  
>  static const struct of_device_id uniphier_pcie_match[] = {
> -- 
> 2.7.4
> 
