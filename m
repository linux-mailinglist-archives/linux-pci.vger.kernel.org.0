Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA123F7B95
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 19:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhHYRc5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 13:32:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232053AbhHYRc5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Aug 2021 13:32:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 274586103E;
        Wed, 25 Aug 2021 17:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629912731;
        bh=HaLu/S43XYiemHf6J5subhxzR2o2Ht+qoQXYJ3cD6J8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Q+3d8vEn6ZQ7cOg6uvyjfisHU1EJs3hnFvHkgY5pYK67mMd1ytB8nylwFiL5WHKX8
         sp9lGKxtCRusY7E/oy+c4VwSLmYLRHBPaZk/VigEIAz9NUWxY1ls3T3UCbEhCd+eNY
         xXIsNPxzpXg+ZQU14cr18pO8ZA/nJQ4HQxd5bu6pj7LSX/h5n9neXQQyma4fCyc99W
         6UjznzBDIeRDiBPnGiGxfmp/bHvk7hWrAJm7ux6PbhgpyG0bRKOUHznDNbSHhKQmCV
         TPAICt7aGnFytYnAVH0skgNUg9joqynB623JPc7OWF3amUcLQ64RigoE/aygOr0b/R
         cBFFuZAi/9Tjw==
Date:   Wed, 25 Aug 2021 12:32:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V8 1/5] PCI: loongson: Use correct pci config access
 operations
Message-ID: <20210825173209.GA3585627@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825060724.3385929-2-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Things like "Use correct ..." in subject lines are useless.  *Every*
patch should do the "proper" or "correct" thing, so it should go
without saying.  Repeating it doesn't make it more true.

This doesn't apply to *all* loongson devices, so it would be useful to
hint at the devices it *does* apply to.

Maybe something like:

  PCI: loongson: Use generic 8/16/32-bit config ops on LS2K/LS7A

On Wed, Aug 25, 2021 at 02:07:20PM +0800, Huacai Chen wrote:
> LS2K/LS7A support 8/16/32-bits pci config access operations via CFG1, so
> we can disable CFG0 for them and safely use pci_generic_config_read()/
> pci_generic_config_write() instead of pci_generic_config_read32()/pci_
> generic_config_write32().

s/pci/PCI/

> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/pci/controller/pci-loongson.c | 36 +++++++++++++++++----------
>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 48169b1e3817..b2c81c762599 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -159,8 +159,15 @@ static int loongson_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  	return val;
>  }
>  
> -/* H/w only accept 32-bit PCI operations */
> +/* LS2K/LS7A accept 8/16/32-bit PCI operations */

*config* operations

>  static struct pci_ops loongson_pci_ops = {
> +	.map_bus = pci_loongson_map_bus,
> +	.read	= pci_generic_config_read,
> +	.write	= pci_generic_config_write,
> +};
> +
> +/* RS780/SR5690 only accept 32-bit PCI operations */
> +static struct pci_ops loongson_pci_ops32 = {
>  	.map_bus = pci_loongson_map_bus,
>  	.read	= pci_generic_config_read32,
>  	.write	= pci_generic_config_write32,
> @@ -168,9 +175,9 @@ static struct pci_ops loongson_pci_ops = {
>  
>  static const struct of_device_id loongson_pci_of_match[] = {
>  	{ .compatible = "loongson,ls2k-pci",
> -		.data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
> +		.data = (void *)(FLAG_CFG1 | FLAG_DEV_FIX), },
>  	{ .compatible = "loongson,ls7a-pci",
> -		.data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
> +		.data = (void *)(FLAG_CFG1 | FLAG_DEV_FIX), },
>  	{ .compatible = "loongson,rs780e-pci",
>  		.data = (void *)(FLAG_CFG0), },

It'd be nice if you used the same strategy as most other drivers,
e.g., ".data = &loongson_ls2k_data" or similar.

>  	{}
> @@ -195,17 +202,17 @@ static int loongson_pci_probe(struct platform_device *pdev)
>  	priv->pdev = pdev;
>  	priv->flags = (unsigned long)of_device_get_match_data(dev);
>  
> -	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!regs) {
> -		dev_err(dev, "missing mem resources for cfg0\n");
> -		return -EINVAL;
> +	if (priv->flags & FLAG_CFG0) {
> +		regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		if (!regs)
> +			dev_err(dev, "missing mem resources for cfg0\n");
> +		else {
> +			priv->cfg0_base = devm_pci_remap_cfg_resource(dev, regs);
> +			if (IS_ERR(priv->cfg0_base))
> +				return PTR_ERR(priv->cfg0_base);
> +		}
>  	}
>  
> -	priv->cfg0_base = devm_pci_remap_cfg_resource(dev, regs);
> -	if (IS_ERR(priv->cfg0_base))
> -		return PTR_ERR(priv->cfg0_base);
> -
> -	/* CFG1 is optional */
>  	if (priv->flags & FLAG_CFG1) {
>  		regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  		if (!regs)
> @@ -218,8 +225,11 @@ static int loongson_pci_probe(struct platform_device *pdev)
>  	}
>  
>  	bridge->sysdata = priv;
> -	bridge->ops = &loongson_pci_ops;
>  	bridge->map_irq = loongson_map_irq;
> +	if (!of_device_is_compatible(node, "loongson,rs780e-pci"))

You already called of_device_get_match_data() above, which does
essentially the same work as of_device_is_compatible().

> +		bridge->ops = &loongson_pci_ops;
> +	else
> +		bridge->ops = &loongson_pci_ops32;
>  
>  	return pci_host_probe(bridge);
>  }
> -- 
> 2.27.0
> 
