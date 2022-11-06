Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEFF61E78D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 00:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiKFXZl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Nov 2022 18:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKFXZj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Nov 2022 18:25:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B226664C0;
        Sun,  6 Nov 2022 15:25:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45A4C60DD7;
        Sun,  6 Nov 2022 23:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEE6C433D6;
        Sun,  6 Nov 2022 23:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667777137;
        bh=8QTjaoznKmYvPhqQLhP3/+GZ18ZGgT5Ym5i6QFRuXrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BOAH4PEV6QSz+GT34lJH3ok4phfLX9JGn1t4PZqmRGgVdneH64+IgQttyVwCgc5+B
         uEPG4Y1k3KFijlYrIQI3Omt31Q0hVmDXDGHIwoz5GDfqR73Sj+lOGmurQPg7Mrk2kF
         mUj/yLxwGS0j5FyH7oCB6KzRh91KqtxZ8/2Zuld9NrRJmnsbikOSyh8nspVivtAl/C
         PzOw191RQH+Na/pTiuKT7D5kywZMPs00VYdReaSKvjsMP5VcFs/fUAge0eKHHEI7uz
         P0EjAsIwLiV70HvJvMluA6/NwxowyEHKZOhl08yfj3MgFOzVLYdy6l3AO/jKn4RKf6
         slIAXb+pjpqrA==
Received: by pali.im (Postfix)
        id 5C3AC858; Mon,  7 Nov 2022 00:25:34 +0100 (CET)
Date:   Mon, 7 Nov 2022 00:25:34 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Use devm_request_irq() for registering
 interrupt handler
Message-ID: <20221106232534.iqzjehhumxzocwru@pali>
References: <20220524122817.7199-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220524122817.7199-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 24 May 2022 14:28:17 Pali Rohár wrote:
> Same as in commit a3b69dd0ad62 ("Revert "PCI: aardvark: Rewrite IRQ code to
> chained IRQ handler"") for pci-aardvark driver, use devm_request_irq()
> instead of chained IRQ handler in pci-mvebu.c driver.
> 
> This change fixes affinity support and allows to pin interrupts from
> different PCIe controllers to different CPU cores.
> 
> Fixes: ec075262648f ("PCI: mvebu: Implement support for legacy INTx interrupts")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
> Hello Bjorn! This is basically same issue as for pci-aardvark.c:
> https://lore.kernel.org/linux-pci/20220515125815.30157-1-pali@kernel.org/#t

Hello! Half year passed since introduced commit in Fixes line, issue is
still there and for pci-mvebu.c was not fixed yet. For pci-aardvark.c
was fixed.

I do not see any progress in alternative solution for this issue and
therefore this patch is still relevant.

Moreover requirement to use devm_request_irq() is needed also for other
pci-mvebu.c patches which are waiting on the list, due to nature of
shared interrupt line. For example:
https://lore.kernel.org/linux-pci/20220830123639.4zpvvvlrsaqs2rls@pali/

> I tested this patch with pci=nomsi in cmdline (to force kernel to use
> legacy intx instead of MSI) on A385 and checked that I can set affinity
> via /proc/irq/XX/smp_affinity file for every mvebu pcie controller to
> different CPU and legacy interrupts from different cards/controllers
> were handled by different CPUs.
> 
> I think that this is important on Armada XP platforms which have many
> independent PCIe controllers (IIRC up to 10) and many cores (up to 4).
> ---
>  drivers/pci/controller/pci-mvebu.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 8f76d4bda356..de67ea39fea5 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -1017,16 +1017,13 @@ static int mvebu_pcie_init_irq_domain(struct mvebu_pcie_port *port)
>  	return 0;
>  }
>  
> -static void mvebu_pcie_irq_handler(struct irq_desc *desc)
> +static irqreturn_t mvebu_pcie_irq_handler(int irq, void *arg)
>  {
> -	struct mvebu_pcie_port *port = irq_desc_get_handler_data(desc);
> -	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct mvebu_pcie_port *port = arg;
>  	struct device *dev = &port->pcie->pdev->dev;
>  	u32 cause, unmask, status;
>  	int i;
>  
> -	chained_irq_enter(chip, desc);
> -
>  	cause = mvebu_readl(port, PCIE_INT_CAUSE_OFF);
>  	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
>  	status = cause & unmask;
> @@ -1040,7 +1037,7 @@ static void mvebu_pcie_irq_handler(struct irq_desc *desc)
>  			dev_err_ratelimited(dev, "unexpected INT%c IRQ\n", (char)i+'A');
>  	}
>  
> -	chained_irq_exit(chip, desc);
> +	return status ? IRQ_HANDLED : IRQ_NONE;
>  }
>  
>  static int mvebu_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> @@ -1490,9 +1487,20 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>  				mvebu_pcie_powerdown(port);
>  				continue;
>  			}
> -			irq_set_chained_handler_and_data(irq,
> -							 mvebu_pcie_irq_handler,
> -							 port);
> +
> +			ret = devm_request_irq(dev, irq, mvebu_pcie_irq_handler,
> +					       IRQF_SHARED | IRQF_NO_THREAD,
> +					       port->name, port);
> +			if (ret) {
> +				dev_err(dev, "%s: cannot register interrupt handler: %d\n",
> +					port->name, ret);
> +				irq_domain_remove(port->intx_irq_domain);
> +				pci_bridge_emul_cleanup(&port->bridge);
> +				devm_iounmap(dev, port->base);
> +				port->base = NULL;
> +				mvebu_pcie_powerdown(port);
> +				continue;
> +			}
>  		}
>  
>  		/*
> @@ -1599,7 +1607,6 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
>  
>  	for (i = 0; i < pcie->nports; i++) {
>  		struct mvebu_pcie_port *port = &pcie->ports[i];
> -		int irq = port->intx_irq;
>  
>  		if (!port->base)
>  			continue;
> @@ -1615,9 +1622,6 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
>  		/* Clear all interrupt causes. */
>  		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
>  
> -		if (irq > 0)
> -			irq_set_chained_handler_and_data(irq, NULL, NULL);
> -
>  		/* Remove IRQ domains. */
>  		if (port->intx_irq_domain)
>  			irq_domain_remove(port->intx_irq_domain);
> -- 
> 2.20.1
> 
