Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD0F911E2DD
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 12:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfLMLhB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 06:37:01 -0500
Received: from foss.arm.com ([217.140.110.172]:55886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfLMLhB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 06:37:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BADB51045;
        Fri, 13 Dec 2019 03:37:00 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 332B73F718;
        Fri, 13 Dec 2019 03:37:00 -0800 (PST)
Date:   Fri, 13 Dec 2019 11:36:58 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: uniphier: remove module code from built-in driver
Message-ID: <20191213113657.GM24359@e119886-lin.cambridge.arm.com>
References: <20191114122654.1490-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114122654.1490-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 14, 2019 at 09:26:54PM +0900, Masahiro Yamada wrote:
> builtin_platform_driver() and MODULE_* are always odd combination.
> 
> The MODULE_* tags are never populated since CONFIG_PCIE_UNIPHIER is
> a bool option.
> 
> You can see similar cleanups by:
>   git log --grep='explicitly non-modular'

Thanks for the justification, it's helpful - however this doesn't belong
on the commit message so please remove that.


> 
> Following those commits, remove all the MODULE_* tags and the driver
> detach code.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Please remove Reviewed-by tags that were not given on the public lists,
reviews should be performed on list (as per [1]).

[1] https://lore.kernel.org/linux-arm-kernel/20191015164303.GC25674@e121166-lin.cambridge.arm.com/

The patch looks OK to me - however can you update the commit message
to better describe this (take inspiration from the examples you gave)?
And there is no need to make any reference to similar commits in the
history.

Thanks,

Andrew Murray

> ---
> 
>  drivers/pci/controller/dwc/pcie-uniphier.c | 31 +---------------------
>  1 file changed, 1 insertion(+), 30 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> index 3f30ee4a00b3..8c92b660a0f6 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> @@ -9,11 +9,11 @@
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
> -#include <linux/module.h>
>  #include <linux/of_irq.h>
>  #include <linux/pci.h>
>  #include <linux/phy/phy.h>
> @@ -161,12 +161,6 @@ static void uniphier_pcie_irq_enable(struct uniphier_pcie_priv *priv)
>  	writel(PCL_RCV_INTX_ALL_ENABLE, priv->base + PCL_RCV_INTX);
>  }
>  
> -static void uniphier_pcie_irq_disable(struct uniphier_pcie_priv *priv)
> -{
> -	writel(0, priv->base + PCL_RCV_INT);
> -	writel(0, priv->base + PCL_RCV_INTX);
> -}
> -
>  static void uniphier_pcie_irq_ack(struct irq_data *d)
>  {
>  	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
> @@ -387,14 +381,6 @@ static int uniphier_pcie_host_enable(struct uniphier_pcie_priv *priv)
>  	return ret;
>  }
>  
> -static void uniphier_pcie_host_disable(struct uniphier_pcie_priv *priv)
> -{
> -	uniphier_pcie_irq_disable(priv);
> -	phy_exit(priv->phy);
> -	reset_control_assert(priv->rst);
> -	clk_disable_unprepare(priv->clk);
> -}
> -
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.start_link = uniphier_pcie_establish_link,
>  	.stop_link = uniphier_pcie_stop_link,
> @@ -446,31 +432,16 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
>  	return uniphier_add_pcie_port(priv, pdev);
>  }
>  
> -static int uniphier_pcie_remove(struct platform_device *pdev)
> -{
> -	struct uniphier_pcie_priv *priv = platform_get_drvdata(pdev);
> -
> -	uniphier_pcie_host_disable(priv);
> -
> -	return 0;
> -}
> -
>  static const struct of_device_id uniphier_pcie_match[] = {
>  	{ .compatible = "socionext,uniphier-pcie", },
>  	{ /* sentinel */ },
>  };
> -MODULE_DEVICE_TABLE(of, uniphier_pcie_match);
>  
>  static struct platform_driver uniphier_pcie_driver = {
>  	.probe  = uniphier_pcie_probe,
> -	.remove = uniphier_pcie_remove,
>  	.driver = {
>  		.name = "uniphier-pcie",
>  		.of_match_table = uniphier_pcie_match,
>  	},
>  };
>  builtin_platform_driver(uniphier_pcie_driver);
> -
> -MODULE_AUTHOR("Kunihiko Hayashi <hayashi.kunihiko@socionext.com>");
> -MODULE_DESCRIPTION("UniPhier PCIe host controller driver");
> -MODULE_LICENSE("GPL v2");
> -- 
> 2.17.1
> 
