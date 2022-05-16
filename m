Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDE05292C0
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 23:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349188AbiEPVMy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 17:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349845AbiEPVLv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 17:11:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11211F62C;
        Mon, 16 May 2022 13:59:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DA1EB810D6;
        Mon, 16 May 2022 20:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E53DC385AA;
        Mon, 16 May 2022 20:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652734774;
        bh=btHaRh7nhG2ZbH6Hgvqssi1bUIvxt7+K6QklIUGoEZg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AE6pPRWxQMWCGVxxtPgPoH7/3dtCeE87EuMKI364rTl0KiDhiGm0sk08cEGSwnKq9
         +StpIlCmeUiO+Op6Ca+KHCl7zB4aLHHA2eqCET9UVESbm8qdGMyr5LCu3YP+ld+RMn
         pzLBd0e+s05r00WAOlZwCLekVChPJcu3cSogwNHizGq5KofKij/BAFWu7sEkbFoIJB
         PUTZEmSVYXqV1bHQq1niQe/soA0HnNASYXJ24jdKochAu4NQoLgxyuQcp5uC5kNLmn
         +KEq/NYfih4jnaVzlyt4eQOpTi2zxrqYvF5zffUl6WKM8lS86Xd8PjKxuAfIjFQCub
         M5wmzgfQaS9HQ==
Date:   Mon, 16 May 2022 15:59:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "PCI: aardvark: Rewrite IRQ code to chained IRQ
 handler"
Message-ID: <20220516205931.GA1050809@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220515125815.30157-1-pali@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 15, 2022 at 02:58:15PM +0200, Pali Rohár wrote:
> This reverts commit 1571d67dc190e50c6c56e8f88cdc39f7cc53166e.
> 
> This commit broke support for setting interrupt affinity. It looks like
> that it is related to the chained IRQ handler. Revert this commit until
> issue with setting interrupt affinity is fixed.
> 
> Fixes: 1571d67dc190 ("PCI: aardvark: Rewrite IRQ code to chained IRQ handler")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> ---
> This commit was introduced in v5.18-rc1 and hence it is regression for 5.18
> release. After reverting this commit, it is possible to move aardvark
> interrupt from CPU0 to CPU1 by "echo 2 > /proc/irq/XX/smp_affinity" where
> XX is the interrupt number which can be find in /proc/interrupts on line
> with advk-pcie.

Applied to for-linus for v5.18, thanks, Pali!

> ---
>  drivers/pci/controller/pci-aardvark.c | 48 ++++++++++++---------------
>  1 file changed, 22 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 54651a1808cc..22ac607343bd 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -274,7 +274,6 @@ struct advk_pcie {
>  		u32 actions;
>  	} wins[OB_WIN_COUNT];
>  	u8 wins_count;
> -	int irq;
>  	struct irq_domain *rp_irq_domain;
>  	struct irq_domain *irq_domain;
>  	struct irq_chip irq_chip;
> @@ -1664,26 +1663,21 @@ static void advk_pcie_handle_int(struct advk_pcie *pcie)
>  	}
>  }
>  
> -static void advk_pcie_irq_handler(struct irq_desc *desc)
> +static irqreturn_t advk_pcie_irq_handler(int irq, void *arg)
>  {
> -	struct advk_pcie *pcie = irq_desc_get_handler_data(desc);
> -	struct irq_chip *chip = irq_desc_get_chip(desc);
> -	u32 val, mask, status;
> +	struct advk_pcie *pcie = arg;
> +	u32 status;
>  
> -	chained_irq_enter(chip, desc);
> +	status = advk_readl(pcie, HOST_CTRL_INT_STATUS_REG);
> +	if (!(status & PCIE_IRQ_CORE_INT))
> +		return IRQ_NONE;
>  
> -	val = advk_readl(pcie, HOST_CTRL_INT_STATUS_REG);
> -	mask = advk_readl(pcie, HOST_CTRL_INT_MASK_REG);
> -	status = val & ((~mask) & PCIE_IRQ_ALL_MASK);
> +	advk_pcie_handle_int(pcie);
>  
> -	if (status & PCIE_IRQ_CORE_INT) {
> -		advk_pcie_handle_int(pcie);
> +	/* Clear interrupt */
> +	advk_writel(pcie, PCIE_IRQ_CORE_INT, HOST_CTRL_INT_STATUS_REG);
>  
> -		/* Clear interrupt */
> -		advk_writel(pcie, PCIE_IRQ_CORE_INT, HOST_CTRL_INT_STATUS_REG);
> -	}
> -
> -	chained_irq_exit(chip, desc);
> +	return IRQ_HANDLED;
>  }
>  
>  static int advk_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> @@ -1763,7 +1757,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  	struct advk_pcie *pcie;
>  	struct pci_host_bridge *bridge;
>  	struct resource_entry *entry;
> -	int ret;
> +	int ret, irq;
>  
>  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct advk_pcie));
>  	if (!bridge)
> @@ -1849,9 +1843,17 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(pcie->base))
>  		return PTR_ERR(pcie->base);
>  
> -	pcie->irq = platform_get_irq(pdev, 0);
> -	if (pcie->irq < 0)
> -		return pcie->irq;
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(dev, irq, advk_pcie_irq_handler,
> +			       IRQF_SHARED | IRQF_NO_THREAD, "advk-pcie",
> +			       pcie);
> +	if (ret) {
> +		dev_err(dev, "Failed to register interrupt\n");
> +		return ret;
> +	}
>  
>  	pcie->reset_gpio = devm_gpiod_get_from_of_node(dev, dev->of_node,
>  						       "reset-gpios", 0,
> @@ -1916,15 +1918,12 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	irq_set_chained_handler_and_data(pcie->irq, advk_pcie_irq_handler, pcie);
> -
>  	bridge->sysdata = pcie;
>  	bridge->ops = &advk_pcie_ops;
>  	bridge->map_irq = advk_pcie_map_irq;
>  
>  	ret = pci_host_probe(bridge);
>  	if (ret < 0) {
> -		irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
>  		advk_pcie_remove_rp_irq_domain(pcie);
>  		advk_pcie_remove_msi_irq_domain(pcie);
>  		advk_pcie_remove_irq_domain(pcie);
> @@ -1973,9 +1972,6 @@ static int advk_pcie_remove(struct platform_device *pdev)
>  	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_REG);
>  	advk_writel(pcie, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_STATUS_REG);
>  
> -	/* Remove IRQ handler */
> -	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
> -
>  	/* Remove IRQ domains */
>  	advk_pcie_remove_rp_irq_domain(pcie);
>  	advk_pcie_remove_msi_irq_domain(pcie);
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
