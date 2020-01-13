Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8F10139693
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 17:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgAMQnR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 11:43:17 -0500
Received: from foss.arm.com ([217.140.110.172]:41634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgAMQnQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 11:43:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D85CE11B3;
        Mon, 13 Jan 2020 08:43:15 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE16C3F85E;
        Mon, 13 Jan 2020 08:43:14 -0800 (PST)
Date:   Mon, 13 Jan 2020 16:43:07 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Andrew Murray <andrew.murray@arm.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: uniphier: remove module code from built-in driver
Message-ID: <20200113164307.GA24639@e121166-lin.cambridge.arm.com>
References: <20191215223937.19619-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191215223937.19619-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 16, 2019 at 07:39:37AM +0900, Masahiro Yamada wrote:
> builtin_platform_driver() and MODULE_* are always odd combination.
> 
> This file is not compiled as a module by anyone because
> CONFIG_PCIE_UNIPHIER is a bool option.
> 
> Let's remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, and it allows us to drop the ".remove" code.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - update commit description
>   - remove Reviewed-by
> 
>  drivers/pci/controller/dwc/pcie-uniphier.c | 31 +---------------------
>  1 file changed, 1 insertion(+), 30 deletions(-)

Applied to pci/uniphier, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> index 8fd7badd59c2..a5401a0b1e58 100644
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
> @@ -171,12 +171,6 @@ static void uniphier_pcie_irq_enable(struct uniphier_pcie_priv *priv)
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
> @@ -397,14 +391,6 @@ static int uniphier_pcie_host_enable(struct uniphier_pcie_priv *priv)
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
> @@ -456,31 +442,16 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
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
