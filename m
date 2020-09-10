Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B6526447C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 12:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbgIJKpn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 06:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgIJKoQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 06:44:16 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7085BC061756;
        Thu, 10 Sep 2020 03:44:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id s13so5143968wmh.4;
        Thu, 10 Sep 2020 03:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aOHr73dpDQf8/KvHagwjhuowv7yRQqFneFoh3PGbITM=;
        b=q6Q9EUfgUkDU+JAG1PhnrxhhQLvngbJ4J1HFd6Py38+r1qzQipjqBpiMaSh+yaS7Gs
         GYJUb7ocbvFg9BR7VWkRKupAOLCOiLsDJC6zR35YgUVfGVH8MXYsSpkRWs+ibXJHuIIO
         uz0SUOdv8J7Wt24LFIB8uq1RwkFCYunBIZg2+BDG4fGRkYfoFspsKkEaHViST77yQz8J
         GjIkXKXwbgdSOlElcBswKxsrO8uc5a5DKTEBWJpTn8aYgDToN8wyHcZObzHDgBWZaEKB
         sCzKremYu7MRyt3Mm60HStuOKlf6ZSLGuIOMBezuog9DNkxAoJFW7v3zEkSZYQSpmPgT
         iy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aOHr73dpDQf8/KvHagwjhuowv7yRQqFneFoh3PGbITM=;
        b=mZYOqsmw9dsDCVfqB+bvjGUgpDPVISsKh3+dqx5EFgW+YK0597KfBnaoJLIjl25CpT
         GtGpVLKUoEVwdpY8A/w/ToJCEADVrl4N4OjCHf/glCJY/IixUCrFC8uoIf4I1pQ6cd+3
         WhAqjxPR8RrjGmG5dW2hRP4JFii4/zoH6QUqYA1ZT3NJ/0UjAKE3aEyPtDFggnh5/A/j
         FV9ubgUGTZfJn/l4Ie8DBdXvW/IkZz6VHzv19c248m6goAa5Nzhiwp5Xf1WgsoN1umys
         FcflbjbeRe11mNuOAra3QjTPRSSlnWQuAc5INVFALlpQOLPWR3pe67JbyRcj6C/G5awb
         nA+Q==
X-Gm-Message-State: AOAM530vXpmKJr+fsddC3jaE1BRWxZoBlCCzmvnz/WRiQ0CgVDJA7VxJ
        HrbH2TdlG4h5GdQ2yz3v+JI=
X-Google-Smtp-Source: ABdhPJzstUYCSIAFw1zbcpfYKdoKEa8qqMY49ikOW8IZMKvNF7nI/+/ZPgIR2t4NGWLpd7xlcoQg6Q==
X-Received: by 2002:a05:600c:ce:: with SMTP id u14mr8261086wmm.137.1599734655104;
        Thu, 10 Sep 2020 03:44:15 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id f1sm8452466wrt.20.2020.09.10.03.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 03:44:14 -0700 (PDT)
Subject: Re: [PATCH v5 2/4] PCI: mediatek: Use regmap to get shared pcie-cfg
 base
To:     Chuanjia Liu <chuanjia.liu@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, yong.wu@mediatek.com
References: <20200910061115.909-1-chuanjia.liu@mediatek.com>
 <20200910061115.909-3-chuanjia.liu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <b627b938-2210-16d2-1682-3c25506e30f3@gmail.com>
Date:   Thu, 10 Sep 2020 12:44:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910061115.909-3-chuanjia.liu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/09/2020 08:11, Chuanjia Liu wrote:
> Use regmap to get shared pcie-cfg base and change
> the method to get pcie irq.
> 
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
> ---
>   drivers/pci/controller/pcie-mediatek.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index cf4c18f0c25a..987845d19982 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -14,6 +14,7 @@
>   #include <linux/irqchip/chained_irq.h>
>   #include <linux/irqdomain.h>
>   #include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
>   #include <linux/msi.h>
>   #include <linux/module.h>
>   #include <linux/of_address.h>
> @@ -23,6 +24,7 @@
>   #include <linux/phy/phy.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
>   #include <linux/reset.h>
>   
>   #include "../pci.h"
> @@ -205,6 +207,7 @@ struct mtk_pcie_port {
>    * struct mtk_pcie - PCIe host information
>    * @dev: pointer to PCIe device
>    * @base: IO mapped register base
> + * @cfg: IO mapped register map for PCIe config
>    * @free_ck: free-run reference clock
>    * @mem: non-prefetchable memory resource
>    * @ports: pointer to PCIe port information
> @@ -213,6 +216,7 @@ struct mtk_pcie_port {
>   struct mtk_pcie {
>   	struct device *dev;
>   	void __iomem *base;
> +	struct regmap *cfg;
>   	struct clk *free_ck;
>   
>   	struct list_head ports;
> @@ -648,7 +652,7 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
>   		return err;
>   	}
>   
> -	port->irq = platform_get_irq(pdev, port->slot);
> +	port->irq = platform_get_irq_byname(pdev, "pcie_irq");
>   	if (port->irq < 0)
>   		return port->irq;

You will need to make sure taht the driver keeps working with the old DTS 
format. This is not the case here.

Regards,
Matthias

>   
> @@ -674,12 +678,11 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>   	if (!mem)
>   		return -EINVAL;
>   
> -	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
> -	if (pcie->base) {
> -		val = readl(pcie->base + PCIE_SYS_CFG_V2);
> -		val |= PCIE_CSR_LTSSM_EN(port->slot) |
> -		       PCIE_CSR_ASPM_L1_EN(port->slot);
> -		writel(val, pcie->base + PCIE_SYS_CFG_V2);
> +	/* MT7622/MT7629 platforms need to enable LTSSM and ASPM. */
> +	if (pcie->cfg) {
> +		val = PCIE_CSR_LTSSM_EN(port->slot) |
> +		      PCIE_CSR_ASPM_L1_EN(port->slot);
> +		regmap_update_bits(pcie->cfg, PCIE_SYS_CFG_V2, val, val);
>   	}
>   
>   	/* Assert all reset signals */
> @@ -983,6 +986,7 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
>   	struct device *dev = pcie->dev;
>   	struct platform_device *pdev = to_platform_device(dev);
>   	struct resource *regs;
> +	struct device_node *cfg_node;
>   	int err;
>   
>   	/* get shared registers, which are optional */
> @@ -995,6 +999,13 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
>   		}
>   	}
>   
> +	cfg_node = of_parse_phandle(dev->of_node, "mediatek,pcie-cfg", 0);
> +	if (cfg_node) {
> +		pcie->cfg = syscon_node_to_regmap(cfg_node);
> +		if (IS_ERR(pcie->cfg))
> +			return PTR_ERR(pcie->cfg);
> +	}
> +
>   	pcie->free_ck = devm_clk_get(dev, "free_ck");
>   	if (IS_ERR(pcie->free_ck)) {
>   		if (PTR_ERR(pcie->free_ck) == -EPROBE_DEFER)
> 
