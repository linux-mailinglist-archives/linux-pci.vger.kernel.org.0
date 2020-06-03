Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6621ECE32
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 13:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgFCLW4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 07:22:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgFCLW4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jun 2020 07:22:56 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10BBF20679;
        Wed,  3 Jun 2020 11:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591183375;
        bh=ehvrNQX6FKPSKoJdIOQhPL6tv5lcYmRRF/iDa8/fY3A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ynKH/9EW4Vbv+8Ojz1LiRoNZIcvkSWbouyA5BfTwx5gp5BZvof7dRxSb4HXOOlNKw
         VduNFjgv0zIv3AckfNAF6bZazPaphHDprV77c74Xydh3NWvwjCDWmuzjimG7eN5jba
         3nOmwuAei0WpdB6S+2yJHfhZBI/DKyYAPQ4iztPY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jgRTx-00HQWC-IY; Wed, 03 Jun 2020 12:22:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Jun 2020 12:22:53 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v3 2/6] PCI: uniphier: Add misc interrupt handler to
 invoke PME and AER
In-Reply-To: <1591174481-13975-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1591174481-13975-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1591174481-13975-3-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <78af3b11de9c513f9be2a1f42f273f27@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: hayashi.kunihiko@socionext.com, bhelgaas@google.com, lorenzo.pieralisi@arm.com, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com, robh+dt@kernel.org, yamada.masahiro@socionext.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-06-03 09:54, Kunihiko Hayashi wrote:
> The misc interrupts consisting of PME, AER, and Link event, is handled
> by INTx handler, however, these interrupts should be also handled by
> MSI handler.
> 
> This adds the function uniphier_pcie_misc_isr() that handles misc
> intterupts, which is called from both INTx and MSI handlers.

interrupts

> This function detects PME and AER interrupts with the status register,
> and invoke PME and AER drivers related to INTx or MSI.
> 
> And this sets the mask for misc interrupts from INTx if MSI is enabled
> and sets the mask for misc interrupts from MSI if MSI is disabled.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/controller/dwc/pcie-uniphier.c | 53 
> +++++++++++++++++++++++-------
>  1 file changed, 42 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c
> b/drivers/pci/controller/dwc/pcie-uniphier.c
> index a5401a0..a8dda39 100644
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
> @@ -167,7 +169,15 @@ static void uniphier_pcie_stop_link(struct dw_pcie 
> *pci)
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
> @@ -231,28 +241,48 @@ static const struct irq_domain_ops
> uniphier_intx_domain_ops = {
>  	.map = uniphier_pcie_intx_map,
>  };
> 
> -static void uniphier_pcie_irq_handler(struct irq_desc *desc)
> +static void uniphier_pcie_misc_isr(struct pcie_port *pp)
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
> +	if (pci_msi_enabled()) {

This checks whether the kernel supports MSIs. Not that they are
enabled in your controller. Is that really what you want to do?

> +		if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS) {
> +			dev_dbg(pci->dev, "Root Error Status\n");
> +			virq = irq_linear_revmap(pp->irq_domain, 0);
> +			generic_handle_irq(virq);
> +		}
> +
> +		if (val & PCL_CFG_PME_MSI_STATUS) {
> +			dev_dbg(pci->dev, "PME Interrupt\n");
> +			virq = irq_linear_revmap(pp->irq_domain, 0);
> +			generic_handle_irq(virq);
> +		}

These two cases do the exact same thing, calling the same interrupt.
What is the point of dealing with them independently?

> +	}
> 
>  	writel(val, priv->base + PCL_RCV_INT);
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
> +
> +	/* misc interrupt */
> +	uniphier_pcie_misc_isr(pp);

This is a chained handler called outside of a chained_irq_enter/exit
block. It isn't acceptable.

> 
>  	/* INTx */
>  	chained_irq_enter(chip, desc);
> @@ -330,6 +360,7 @@ static int uniphier_pcie_host_init(struct pcie_port 
> *pp)
> 
>  static const struct dw_pcie_host_ops uniphier_pcie_host_ops = {
>  	.host_init = uniphier_pcie_host_init,
> +	.msi_host_isr = uniphier_pcie_misc_isr,
>  };
> 
>  static int uniphier_add_pcie_port(struct uniphier_pcie_priv *priv,

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
