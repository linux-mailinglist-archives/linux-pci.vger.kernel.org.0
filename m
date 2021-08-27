Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624593F98FB
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 14:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhH0MaS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 08:30:18 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:58275 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231271AbhH0MaS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Aug 2021 08:30:18 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 12A6C320034E;
        Fri, 27 Aug 2021 08:29:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 27 Aug 2021 08:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=s
        8KRw1RcLA6Blq/dSPyMXm3iwWYLjnCw+Ig2LCOAF9Q=; b=YmKdrp7imxbxDcyua
        O0hIDvItzXjA6E14QnLHQKbSZw575MmBB66GjhV1ULus6fvcNT1Xs2vLPmNIX6zM
        c0fTXt3Dh+r0tdSS7ECrOyx3vz8ZXsj9PlCNWkjN2dBlALdrVs6L3oYlnVzrZsMw
        uHeR5fOPwWA1vMGtZLTrSpJFV0uw97roiVObszN8QxiTCLhvsMwMTSEwrA7kftdS
        Pq64Y9aesrPnddbyTVMfFRoSn+ot1wtrkolC+4RLCf6flZHis7080hEflqPNo6OZ
        Oo6RPY5DZ40vUg9OjAwSDrSdCS1HG4IFU1N2mQ9a6BrnnkK7d1w23DUhwEabuu3o
        Pj2ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=s8KRw1RcLA6Blq/dSPyMXm3iwWYLjnCw+Ig2LCOAF
        9Q=; b=eGw1cFyHsjzsT+wAUfZiIHTPaTVb+8EYGGjTVDhjdlfWk5kYetVFBVf5W
        y9JlZRApYSdlZyE074iFZ/T0uOsDHjkMqThZkHhhqDrPknZtZdoKw8zezWN/Bj5e
        yZ187hhp5pTn3Rx+sUJ+oLG1V0bvW01AHr/9jptsvDuyet5YuAFcZoviFL/l/Hjp
        ktUEubaChOeysuCnwSrM4cKUW6BpbGLj9D+oLZCaLHxKHCdaNJ5zkCgXsmVRTXq4
        m/OXK6FmOVRfUy+ufU+bnonrA9jWwFr/lEfJLlKTnN98cbZWTvBNb25Dw4T+c+x6
        QyEsJ2jAPUGEYZQll9ar7HH/E7dFw==
X-ME-Sender: <xms:p9ooYZ63AzQlUoMl6GQBmDj1nvGeyv_koNAKZqsSx2c5WQxTrlM8zg>
    <xme:p9ooYW4-Kw5h7SYKGQeqtH61SlDJi__YJ0BnwWp1g7rp2JO_-Fo6L3miDhP9bWW2L
    v76P4t7ZX9cwndm-3Q>
X-ME-Received: <xmr:p9ooYQfBSMtZRG39ai4ZBCpBGyXfC1lS0_ZBIEoGX7cUwvw-0e4gKXv0ivRzHqzaThE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddufedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdeftfenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeefleduiedtvdekffeggfeukeejgeeffeetlefghfekffeuteei
    jeeghefhueffvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:p9ooYSLmvTQbzZl6GGFkzpdL34ZMXXrIKW_c412J_cS-TyiDIS3WqQ>
    <xmx:p9ooYdJMOfHaHyQ_FXr87XM8sWWt-_urI6Y_VOJY1zbbZY2Rjr74vg>
    <xmx:p9ooYbz96J5Xy78Q7K6KDwiYkuO4wzN2JiFG7pIuAQoxBH0qgr7mHg>
    <xmx:qNooYd3edIfDVTtwB5PF7c30eqwHuL0dKWugsr7pHLuEDdGkVAQI-A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Aug 2021 08:29:25 -0400 (EDT)
Subject: Re: [PATCH V9 1/5] PCI: loongson: Use generic 8/16/32-bit config ops
 on LS2K/LS7A
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>
References: <20210827082031.2777623-1-chenhuacai@loongson.cn>
 <20210827082031.2777623-2-chenhuacai@loongson.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <c8c920f0-a83a-33af-122d-ac091341f5de@flygoat.com>
Date:   Fri, 27 Aug 2021 20:29:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210827082031.2777623-2-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


ÔÚ 2021/8/27 16:20, Huacai Chen Ð´µÀ:
> LS2K/LS7A support 8/16/32-bits PCI config access operations via CFG1, so
> we can disable CFG0 for them and safely use pci_generic_config_read()/
> pci_generic_config_write() instead of pci_generic_config_read32()/pci_
> generic_config_write32().
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Tested on my Loongson-3A3000+7A system.

Thanks!

- Jiaxun

> ---
>   drivers/pci/controller/pci-loongson.c | 65 +++++++++++++++++++--------
>   1 file changed, 46 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index 48169b1e3817..433261c5f34c 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -25,11 +25,16 @@
>   #define FLAG_CFG1	BIT(1)
>   #define FLAG_DEV_FIX	BIT(2)
>   
> +struct pci_controller_data {
> +	u32 flags;
> +	struct pci_ops *ops;
> +};
> +
>   struct loongson_pci {
>   	void __iomem *cfg0_base;
>   	void __iomem *cfg1_base;
>   	struct platform_device *pdev;
> -	u32 flags;
> +	struct pci_controller_data *data;
>   };
>   
>   /* Fixup wrong class code in PCIe bridges */
> @@ -126,8 +131,8 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
>   	 * Do not read more than one device on the bus other than
>   	 * the host bus. For our hardware the root bus is always bus 0.
>   	 */
> -	if (priv->flags & FLAG_DEV_FIX && busnum != 0 &&
> -		PCI_SLOT(devfn) > 0)
> +	if (priv->data->flags & FLAG_DEV_FIX &&
> +			busnum != 0 && PCI_SLOT(devfn) > 0)
>   		return NULL;
>   
>   	/* CFG0 can only access standard space */
> @@ -159,20 +164,42 @@ static int loongson_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>   	return val;
>   }
>   
> -/* H/w only accept 32-bit PCI operations */
> +/* LS2K/LS7A accept 8/16/32-bit PCI config operations */
>   static struct pci_ops loongson_pci_ops = {
> +	.map_bus = pci_loongson_map_bus,
> +	.read	= pci_generic_config_read,
> +	.write	= pci_generic_config_write,
> +};
> +
> +/* RS780/SR5690 only accept 32-bit PCI config operations */
> +static struct pci_ops loongson_pci_ops32 = {
>   	.map_bus = pci_loongson_map_bus,
>   	.read	= pci_generic_config_read32,
>   	.write	= pci_generic_config_write32,
>   };
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
>   static const struct of_device_id loongson_pci_of_match[] = {
>   	{ .compatible = "loongson,ls2k-pci",
> -		.data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
> +		.data = (void *)&ls2k_pci_data, },
>   	{ .compatible = "loongson,ls7a-pci",
> -		.data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
> +		.data = (void *)&ls7a_pci_data, },
>   	{ .compatible = "loongson,rs780e-pci",
> -		.data = (void *)(FLAG_CFG0), },
> +		.data = (void *)&rs780e_pci_data, },
>   	{}
>   };
>   
> @@ -193,20 +220,20 @@ static int loongson_pci_probe(struct platform_device *pdev)
>   
>   	priv = pci_host_bridge_priv(bridge);
>   	priv->pdev = pdev;
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
>   	}
>   
> -	priv->cfg0_base = devm_pci_remap_cfg_resource(dev, regs);
> -	if (IS_ERR(priv->cfg0_base))
> -		return PTR_ERR(priv->cfg0_base);
> -
> -	/* CFG1 is optional */
> -	if (priv->flags & FLAG_CFG1) {
> +	if (priv->data->flags & FLAG_CFG1) {
>   		regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>   		if (!regs)
>   			dev_info(dev, "missing mem resource for cfg1\n");
> @@ -218,7 +245,7 @@ static int loongson_pci_probe(struct platform_device *pdev)
>   	}
>   
>   	bridge->sysdata = priv;
> -	bridge->ops = &loongson_pci_ops;
> +	bridge->ops = priv->data->ops;
>   	bridge->map_irq = loongson_map_irq;
>   
>   	return pci_host_probe(bridge);
