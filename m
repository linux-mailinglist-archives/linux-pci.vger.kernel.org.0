Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815B14FE401
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 16:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347933AbiDLOnA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 10:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiDLOm6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 10:42:58 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F3411155
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 07:40:41 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id q189so19191005oia.9
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 07:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hEAbkH+fqKRUETCwi4mFn/Yo2FmpfQYB5VhKYBCoHH4=;
        b=pqSG3Yn80KjDq/1EJj4KkoXtRMbN7IqP5m/K3p0cNTo3S5Ioc9SRIoQ/nNoAMxW/US
         mPW2YsEybWGJc0YqCCnDPO0dH4w75fPR+JOB5XlXfvl3oKtLRf7+rlo5ArYdveQZZ04r
         hcfyJjCZx50HqG7j/FAYUlkhRbB08Ar228SX6J2ofXuGL6v8EovFjBLCz+3mYNdQWGER
         +Q5456JCneKl49mNyuj5d5hJ/LqOWR4E352zHKmm1Dl61ig6N8zcwyJ4/jHjErnv47R8
         T8WYBslfgqhju+/OstXDY4oz6v26cA29ms/kKkQLElNGbQkwEJLUbEddx9BXLM+4CdZy
         Lo1A==
X-Gm-Message-State: AOAM532if5DPjs9vI/lLHPqZ5GPqRcm2Z3ubz4h7pqGQtBW0tyTPFWkr
        3dvPhFMocdHemvVQsyRBp2+JrfmcAA==
X-Google-Smtp-Source: ABdhPJwNfeudp2tlaoWTCceKkddoAOttN8aXcLXxUa3imnwOScRncGt5IKdZpGuYyLdgSolAUUcs/Q==
X-Received: by 2002:a05:6808:208c:b0:2da:10e3:c70 with SMTP id s12-20020a056808208c00b002da10e30c70mr1924185oiw.42.1649774440426;
        Tue, 12 Apr 2022 07:40:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v17-20020a9d69d1000000b005b2319a08c4sm13399891oto.18.2022.04.12.07.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 07:40:40 -0700 (PDT)
Received: (nullmailer pid 60097 invoked by uid 1000);
        Tue, 12 Apr 2022 14:40:39 -0000
Date:   Tue, 12 Apr 2022 09:40:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V12 1/6] PCI: loongson: Use generic 8/16/32-bit config
 ops on LS2K/LS7A
Message-ID: <YlWPZ3J408ncOujh@robh.at.kernel.org>
References: <20220226104731.76776-1-chenhuacai@loongson.cn>
 <20220226104731.76776-2-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226104731.76776-2-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 26, 2022 at 06:47:26PM +0800, Huacai Chen wrote:
> LS2K/LS7A support 8/16/32-bits PCI config access operations via CFG1, so
> we can disable CFG0 for them and safely use pci_generic_config_read()/
> pci_generic_config_write() instead of pci_generic_config_read32()/pci_
> generic_config_write32().
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/pci/controller/pci-loongson.c | 65 +++++++++++++++++++--------
>  1 file changed, 46 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 48169b1e3817..433261c5f34c 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -25,11 +25,16 @@
>  #define FLAG_CFG1	BIT(1)
>  #define FLAG_DEV_FIX	BIT(2)
>  
> +struct pci_controller_data {

struct loongson_pci_data

> +	u32 flags;
> +	struct pci_ops *ops;

const struct

> +};
> +
>  struct loongson_pci {
>  	void __iomem *cfg0_base;
>  	void __iomem *cfg1_base;
>  	struct platform_device *pdev;
> -	u32 flags;
> +	struct pci_controller_data *data;
>  };
>  
>  /* Fixup wrong class code in PCIe bridges */
> @@ -126,8 +131,8 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
>  	 * Do not read more than one device on the bus other than
>  	 * the host bus. For our hardware the root bus is always bus 0.
>  	 */
> -	if (priv->flags & FLAG_DEV_FIX && busnum != 0 &&
> -		PCI_SLOT(devfn) > 0)
> +	if (priv->data->flags & FLAG_DEV_FIX &&
> +			busnum != 0 && PCI_SLOT(devfn) > 0)

Are you sure you need all this? The default for PCIe (not PCI) is to 
only scan device 0 on child buses.

In any case, use pci_is_root_bus() rather than checking bus number 
is/isn't 0.


>  		return NULL;
>  
>  	/* CFG0 can only access standard space */
> @@ -159,20 +164,42 @@ static int loongson_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  	return val;
>  }
>  
> -/* H/w only accept 32-bit PCI operations */
> +/* LS2K/LS7A accept 8/16/32-bit PCI config operations */
>  static struct pci_ops loongson_pci_ops = {
> +	.map_bus = pci_loongson_map_bus,
> +	.read	= pci_generic_config_read,
> +	.write	= pci_generic_config_write,
> +};
> +
> +/* RS780/SR5690 only accept 32-bit PCI config operations */
> +static struct pci_ops loongson_pci_ops32 = {
>  	.map_bus = pci_loongson_map_bus,
>  	.read	= pci_generic_config_read32,
>  	.write	= pci_generic_config_write32,
>  };
>  
> +static const struct pci_controller_data ls2k_pci_data = {
> +	.flags = FLAG_CFG1 | FLAG_DEV_FIX,
> +	.ops = &loongson_pci_ops,
> +};
> +
> +static const struct pci_controller_data ls7a_pci_data = {
> +	.flags = FLAG_CFG1 | FLAG_DEV_FIX,
> +	.ops = &loongson_pci_ops,
> +};
> +
> +static const struct pci_controller_data rs780e_pci_data = {
> +	.flags = FLAG_CFG0,
> +	.ops = &loongson_pci_ops32,
> +};
> +
>  static const struct of_device_id loongson_pci_of_match[] = {
>  	{ .compatible = "loongson,ls2k-pci",
> -		.data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
> +		.data = (void *)&ls2k_pci_data, },

Don't need the cast IIRC.

>  	{ .compatible = "loongson,ls7a-pci",
> -		.data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
> +		.data = (void *)&ls7a_pci_data, },
>  	{ .compatible = "loongson,rs780e-pci",
> -		.data = (void *)(FLAG_CFG0), },
> +		.data = (void *)&rs780e_pci_data, },
>  	{}
>  };
>  
> @@ -193,20 +220,20 @@ static int loongson_pci_probe(struct platform_device *pdev)
>  
>  	priv = pci_host_bridge_priv(bridge);
>  	priv->pdev = pdev;
> -	priv->flags = (unsigned long)of_device_get_match_data(dev);
> +	priv->data = (struct pci_controller_data *)of_device_get_match_data(dev);
>  
> -	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!regs) {
> -		dev_err(dev, "missing mem resources for cfg0\n");
> -		return -EINVAL;
> +	if (priv->data->flags & FLAG_CFG0) {
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
> -	if (priv->flags & FLAG_CFG1) {
> +	if (priv->data->flags & FLAG_CFG1) {
>  		regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  		if (!regs)
>  			dev_info(dev, "missing mem resource for cfg1\n");
> @@ -218,7 +245,7 @@ static int loongson_pci_probe(struct platform_device *pdev)
>  	}
>  
>  	bridge->sysdata = priv;
> -	bridge->ops = &loongson_pci_ops;
> +	bridge->ops = priv->data->ops;
>  	bridge->map_irq = loongson_map_irq;
>  
>  	return pci_host_probe(bridge);
> -- 
> 2.27.0
> 
