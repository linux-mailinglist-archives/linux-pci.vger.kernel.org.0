Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5576E27EC61
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 17:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbgI3PX0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 11:23:26 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37871 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730618AbgI3PXY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 11:23:24 -0400
Received: by mail-oi1-f194.google.com with SMTP id a3so2113223oib.4;
        Wed, 30 Sep 2020 08:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ykcgim5K3yxkyGZO+LFirZIQ94KQkHoRY4NcDJYbP5U=;
        b=olJzKY0JMFi50cUdEbwwSRmX8AIBP1pVlvkPHUY7wKEpnTrXcS3LgAy3K4uWI4RJ8C
         gmSgEzsHufBG9scEfTCbdgLvqo1UhDmKkzl6VhL9PqHDqCxS7iLk6fwA1+PXHq5VCYx0
         gJiELGlnJgBWETQVt+0cOYPnWhueLHa0YWbXUIM6fOnAa7xjQb1p+p5rgzhKcXWkgyZk
         iHEyV+Nfw0MKmka3ke0DkRLNFrZ4xeokb5oOf5j3SUuxQbpLKhJLtvCxxRmjxhCPiv/e
         HzWR2xeokNuHgEtVIqhyWnoqUPcgd6WWz5uaBmFu55ws03tv4FtjwmdpYyypCiOAQGS1
         j+1g==
X-Gm-Message-State: AOAM532YaYeflD9ZIQGR5+S32/CqVn+CIx30uPIGAeVcF6OZcSCCvtTr
        KLIlm+4XgXnLbTn9sp4Emg==
X-Google-Smtp-Source: ABdhPJx2Kh0SA0nXsYZrDsVri141YxNAgtmSKCCv7TmY1YpebIiRUUbf9RMEVbQCUe8Maqd2sU6OnQ==
X-Received: by 2002:aca:bd8a:: with SMTP id n132mr1671249oif.100.1601479403526;
        Wed, 30 Sep 2020 08:23:23 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s124sm382882oig.6.2020.09.30.08.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:23:22 -0700 (PDT)
Received: (nullmailer pid 2896316 invoked by uid 1000);
        Wed, 30 Sep 2020 15:23:17 -0000
Date:   Wed, 30 Sep 2020 10:23:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chuanjia Liu <chuanjia.liu@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        yong.wu@mediatek.com, Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v6 2/4] PCI: mediatek: Add new method to get shared
 pcie-cfg base and irq
Message-ID: <20200930152317.GA2891120@bogus>
References: <20200914112659.7091-1-chuanjia.liu@mediatek.com>
 <20200914112659.7091-3-chuanjia.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914112659.7091-3-chuanjia.liu@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 14, 2020 at 07:26:57PM +0800, Chuanjia Liu wrote:
> Add new method to get shared pcie-cfg base and pcie irq for
> new dts format.
> 
> Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index cf4c18f0c25a..5b915eb0cf1e 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -14,6 +14,7 @@
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/msi.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> @@ -23,6 +24,7 @@
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
>  #include <linux/reset.h>
>  
>  #include "../pci.h"
> @@ -205,6 +207,7 @@ struct mtk_pcie_port {
>   * struct mtk_pcie - PCIe host information
>   * @dev: pointer to PCIe device
>   * @base: IO mapped register base
> + * @cfg: IO mapped register map for PCIe config
>   * @free_ck: free-run reference clock
>   * @mem: non-prefetchable memory resource
>   * @ports: pointer to PCIe port information
> @@ -213,6 +216,7 @@ struct mtk_pcie_port {
>  struct mtk_pcie {
>  	struct device *dev;
>  	void __iomem *base;
> +	struct regmap *cfg;
>  	struct clk *free_ck;
>  
>  	struct list_head ports;
> @@ -648,7 +652,11 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
>  		return err;
>  	}
>  
> -	port->irq = platform_get_irq(pdev, port->slot);
> +	if (of_find_property(dev->of_node, "interrupt-names", NULL))
> +		port->irq = platform_get_irq_byname(pdev, "pcie_irq");

Not really any point in having a name with a single interrupt.

> +	else
> +		port->irq = platform_get_irq(pdev, port->slot);

With the new binding, slot is always 0, right? Then you don't need any 
change here.

> +
>  	if (port->irq < 0)
>  		return port->irq;
>  
> @@ -680,6 +688,10 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  		val |= PCIE_CSR_LTSSM_EN(port->slot) |
>  		       PCIE_CSR_ASPM_L1_EN(port->slot);
>  		writel(val, pcie->base + PCIE_SYS_CFG_V2);
> +	} else if (pcie->cfg) {
> +		val = PCIE_CSR_LTSSM_EN(port->slot) |
> +		      PCIE_CSR_ASPM_L1_EN(port->slot);
> +		regmap_update_bits(pcie->cfg, PCIE_SYS_CFG_V2, val, val);
>  	}
>  
>  	/* Assert all reset signals */
> @@ -983,6 +995,7 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
>  	struct device *dev = pcie->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct resource *regs;
> +	struct device_node *cfg_node;
>  	int err;
>  
>  	/* get shared registers, which are optional */
> @@ -995,6 +1008,14 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
>  		}
>  	}
>  
> +	cfg_node = of_find_compatible_node(NULL, NULL,
> +					   "mediatek,generic-pciecfg");
> +	if (cfg_node) {
> +		pcie->cfg = syscon_node_to_regmap(cfg_node);
> +		if (IS_ERR(pcie->cfg))
> +			return PTR_ERR(pcie->cfg);
> +	}
> +
>  	pcie->free_ck = devm_clk_get(dev, "free_ck");
>  	if (IS_ERR(pcie->free_ck)) {
>  		if (PTR_ERR(pcie->free_ck) == -EPROBE_DEFER)
> -- 
> 2.18.0
