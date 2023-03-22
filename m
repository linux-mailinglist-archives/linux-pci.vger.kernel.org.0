Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5874F6C5A33
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 00:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjCVXTS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Mar 2023 19:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCVXTR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2023 19:19:17 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A520206BD;
        Wed, 22 Mar 2023 16:19:16 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id k37so12550515lfv.0;
        Wed, 22 Mar 2023 16:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679527154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=APl+axmsRH50WQibYsax2iHB5pWAr984deNQGhRudfQ=;
        b=PSgk/Y2PGmdcK3sxX4qMafcpWu55JUJQcSn4tZYnTP6HPbG7JBtHNIL/LhoIH8B4pB
         2h/d8+u0JHBk4WSSElNe8v+4B7GKQIqUHeCDE/11Wm7ttmkGUlN5eNh9g26rJRwZZAEU
         z5TZ355LT2TM/Hjyf/Dps2kzyRA3EgeZX9Llv+N2Q7KGMboKspFdRZsn+b21xeeN6Uaq
         LaZgdy8Dp+2kiRTkCZfiGdTQ9nu12t4T6rs0aLXOR6BENqb5IP3x8rve+FKDreyXymv4
         OyClxW9LUcnusVXAPcsLs6CG0VTdZLMqVA04YTkv2qRVsncjTVZoq0ftvAY0sFodB+0d
         1hJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679527154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APl+axmsRH50WQibYsax2iHB5pWAr984deNQGhRudfQ=;
        b=y8wf9HQweS/DMrUiAG6nPYlZCDxI5fmNPjAYjp6E0CwcGDkV3P60W8+MGcnz8kj0Qc
         fE2dbaMoCgtEuK/bloZacXUJj0/2gntYk8XTwv5G9JDFsU8dH9PLmpOR5SkTcquQWLIS
         +XTB+oaAsptZ4b53jd/xLuVqe4UeNC4c2FIwfpzZgkFVC8q240a/n/v6Wc9+6tSOrnP5
         gCgOkk0N0zf371YYxA+bU97KXYcotlGM9ftL8/5YF0ruoKX8sVTd14Et0prcr+pyQVhg
         uq9knfjR1S91HFqOUXyxbZhqhhm6Sc/xRQrWYvPxIUdp7lxPRQUHDcJxQV/IDx138C0L
         Sv6A==
X-Gm-Message-State: AO0yUKWkbuCsTlwYBPa/GyG7ZjydYPK9ikKoQm8wTCCEo2IZLooU5ZU/
        pUvdNerXrjzxgTQDE29l2fg=
X-Google-Smtp-Source: AK7set+Z9LYEY+VcH6P1+mZsG+783Fb+6X0u1vDimsirUjqGB8QP00eW8fEaqqxEXvdoEFwQsRfvTA==
X-Received: by 2002:ac2:44d9:0:b0:4dd:ad88:ba5c with SMTP id d25-20020ac244d9000000b004ddad88ba5cmr2476291lfm.4.1679527154369;
        Wed, 22 Mar 2023 16:19:14 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id u4-20020ac251c4000000b004db1a7e6decsm2719937lfm.205.2023.03.22.16.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 16:19:13 -0700 (PDT)
Date:   Thu, 23 Mar 2023 02:19:11 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Elad Nachman <enachman@marvell.com>
Cc:     thomas.petazzoni@bootlin.com, bhelgaas@google.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Raz Adashi <raza@marvell.com>
Subject: Re: [PATCH v4 2/8] PCI: armada8k: Add AC5 SoC support
Message-ID: <20230322231911.dplgi5d3warhc245@mobilestation>
References: <20230313124016.17102-1-enachman@marvell.com>
 <20230313124016.17102-3-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313124016.17102-3-enachman@marvell.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 13, 2023 at 02:40:10PM +0200, Elad Nachman wrote:
> From: Raz Adashi <raza@marvell.com>
> 
> pcie-armada8k driver is utilized to serve also AC5.
> 
> Driver assumes interrupt mask registers are located
> in the same address inboth CPUs. This assumption is
> incorrect - fix it for AC5.
> 
> Co-developed-by: Yuval Shaia <yshaia@marvell.com>
> Signed-off-by: Yuval Shaia <yshaia@marvell.com>
> Signed-off-by: Raz Adashi <raza@marvell.com>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
> v2:
>    1) fix W1 warnings which caused by unused leftover code
> 
>    2) Use one xlate function to translate ac5 dbi access. Also add
>       mode description in comments about this translation.
> 
>    3) Use correct name of Raz
> 
>    4) Use matching data to pass the SoC specific params (type & ops)
> 
>  drivers/pci/controller/dwc/pcie-armada8k.c | 145 +++++++++++++++++----
>  1 file changed, 120 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index 5c999e15c357..b9fb1375dc58 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -16,6 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/pci.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> @@ -26,15 +27,26 @@
>  
>  #define ARMADA8K_PCIE_MAX_LANES PCIE_LNK_X4
>  
> +enum armada8k_pcie_type {
> +	ARMADA8K_PCIE_TYPE_A8K,
> +	ARMADA8K_PCIE_TYPE_AC5
> +};

AFAICS instead of if-else-based pattern you can just split up the
implementation into the dedicated functions.

> +
>  struct armada8k_pcie {
>  	struct dw_pcie *pci;
>  	struct clk *clk;
>  	struct clk *clk_reg;
>  	struct phy *phy[ARMADA8K_PCIE_MAX_LANES];
>  	unsigned int phy_count;
> +	enum armada8k_pcie_type pcie_type;
>  };
>  
> -#define PCIE_VENDOR_REGS_OFFSET		0x8000
> +struct armada8k_pcie_of_data {
> +	enum armada8k_pcie_type pcie_type;
> +	const struct dw_pcie_ops *pcie_ops;
> +};
> +
> +#define PCIE_VENDOR_REGS_OFFSET		0x8000	/* in ac5 is 0x10000 */
>  
>  #define PCIE_GLOBAL_CONTROL_REG		(PCIE_VENDOR_REGS_OFFSET + 0x0)
>  #define PCIE_APP_LTSSM_EN		BIT(2)
> @@ -48,10 +60,17 @@ struct armada8k_pcie {
>  
>  #define PCIE_GLOBAL_INT_CAUSE1_REG	(PCIE_VENDOR_REGS_OFFSET + 0x1C)
>  #define PCIE_GLOBAL_INT_MASK1_REG	(PCIE_VENDOR_REGS_OFFSET + 0x20)
> +#define PCIE_GLOBAL_INT_MASK2_REG	(PCIE_VENDOR_REGS_OFFSET + 0x28)
>  #define PCIE_INT_A_ASSERT_MASK		BIT(9)
>  #define PCIE_INT_B_ASSERT_MASK		BIT(10)
>  #define PCIE_INT_C_ASSERT_MASK		BIT(11)
>  #define PCIE_INT_D_ASSERT_MASK		BIT(12)
> +#define PCIE_INT_A_ASSERT_MASK_AC5	BIT(12)
> +#define PCIE_INT_B_ASSERT_MASK_AC5	BIT(13)
> +#define PCIE_INT_C_ASSERT_MASK_AC5	BIT(14)
> +#define PCIE_INT_D_ASSERT_MASK_AC5	BIT(15)
> +
> +#define PCIE_ATU_ACCESS_MASK_AC5	GENMASK(21, 20)
>  
>  #define PCIE_ARCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x50)
>  #define PCIE_AWCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x54)
> @@ -169,6 +188,7 @@ static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	u32 reg;
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct armada8k_pcie *pcie = to_armada8k_pcie(pci);
>  
>  	if (!dw_pcie_link_up(pci)) {
>  		/* Disable LTSSM state machine to enable configuration */
> @@ -177,32 +197,41 @@ static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
>  		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
>  	}
>  
> -	/* Set the device to root complex mode */
> -	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
> -	reg &= ~(PCIE_DEVICE_TYPE_MASK << PCIE_DEVICE_TYPE_SHIFT);
> -	reg |= PCIE_DEVICE_TYPE_RC << PCIE_DEVICE_TYPE_SHIFT;
> -	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
> +	if (pcie->pcie_type == ARMADA8K_PCIE_TYPE_A8K) {
> +		/* Set the device to root complex mode */
> +		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
> +		reg &= ~(PCIE_DEVICE_TYPE_MASK << PCIE_DEVICE_TYPE_SHIFT);
> +		reg |= PCIE_DEVICE_TYPE_RC << PCIE_DEVICE_TYPE_SHIFT;
> +		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
>  
> -	/* Set the PCIe master AxCache attributes */
> -	dw_pcie_writel_dbi(pci, PCIE_ARCACHE_TRC_REG, ARCACHE_DEFAULT_VALUE);
> -	dw_pcie_writel_dbi(pci, PCIE_AWCACHE_TRC_REG, AWCACHE_DEFAULT_VALUE);
> +		/* Set the PCIe master AxCache attributes */
> +		dw_pcie_writel_dbi(pci, PCIE_ARCACHE_TRC_REG, ARCACHE_DEFAULT_VALUE);
> +		dw_pcie_writel_dbi(pci, PCIE_AWCACHE_TRC_REG, AWCACHE_DEFAULT_VALUE);
>  
> -	/* Set the PCIe master AxDomain attributes */
> -	reg = dw_pcie_readl_dbi(pci, PCIE_ARUSER_REG);
> -	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
> -	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
> -	dw_pcie_writel_dbi(pci, PCIE_ARUSER_REG, reg);
> +		/* Set the PCIe master AxDomain attributes */
> +		reg = dw_pcie_readl_dbi(pci, PCIE_ARUSER_REG);
> +		reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
> +		reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
> +		dw_pcie_writel_dbi(pci, PCIE_ARUSER_REG, reg);
>  
> -	reg = dw_pcie_readl_dbi(pci, PCIE_AWUSER_REG);
> -	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
> -	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
> -	dw_pcie_writel_dbi(pci, PCIE_AWUSER_REG, reg);
> +		reg = dw_pcie_readl_dbi(pci, PCIE_AWUSER_REG);
> +		reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
> +		reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
> +		dw_pcie_writel_dbi(pci, PCIE_AWUSER_REG, reg);
> +	}
>  
>  	/* Enable INT A-D interrupts */
> -	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG);
> -	reg |= PCIE_INT_A_ASSERT_MASK | PCIE_INT_B_ASSERT_MASK |
> -	       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
> -	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, reg);
> +	if (pcie->pcie_type == ARMADA8K_PCIE_TYPE_AC5) {
> +		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG);
> +		reg |= PCIE_INT_A_ASSERT_MASK_AC5 | PCIE_INT_B_ASSERT_MASK_AC5 |
> +		       PCIE_INT_C_ASSERT_MASK_AC5 | PCIE_INT_D_ASSERT_MASK_AC5;
> +		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG, reg);
> +	} else {
> +		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG);
> +		reg |= PCIE_INT_A_ASSERT_MASK | PCIE_INT_B_ASSERT_MASK |
> +		       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
> +		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, reg);
> +	}
>  
>  	return 0;
>  }
> @@ -258,9 +287,61 @@ static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
>  	return 0;
>  }
>  
> -static const struct dw_pcie_ops dw_pcie_ops = {
> +static u32 ac5_xlate_dbi_reg(u32 reg)
> +{
> +	/* Handle AC5 ATU access */
> +	if ((reg & ~0xfffff) == PCIE_ATU_ACCESS_MASK_AC5) {
> +		reg &= 0xfffff;
> +		/* ATU registers offset is 0xC00 + 0x200 * n,
> +		 * from RFU registers.
> +		 */
> +		reg = 0xc000 | (0x200 * (reg >> 9)) | (reg & 0xff);

A custom ATU-base address can be specified instead of this
brain-cracking hack.

> +	} else if ((reg & 0xfffff000) == PCIE_VENDOR_REGS_OFFSET) {
> +		/* PCIe RFU registers in A8K are at offset 0x8000 from base
> +		 * (0xf2600000) while in AC5 offset is 0x10000 from base
> +		 * (0x800a0000) therefore need the addition of 0x8000.
> +		 */
> +		reg += PCIE_VENDOR_REGS_OFFSET;
> +	}

app/ulbi reg-space could be defined instead.

-Serge(y)

> +
> +	return reg;
> +}
> +
> +static u32 ac5_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
> +			     u32 reg, size_t size)
> +{
> +	u32 val;
> +
> +	dw_pcie_read(base + ac5_xlate_dbi_reg(reg), size, &val);
> +	return val;
> +}
> +
> +static void ac5_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
> +			       u32 reg, size_t size, u32 val)
> +{
> +	dw_pcie_write(base + ac5_xlate_dbi_reg(reg), size, val);
> +}
> +
> +static const struct dw_pcie_ops armada8k_dw_pcie_ops = {
> +	.link_up = armada8k_pcie_link_up,
> +	.start_link = armada8k_pcie_start_link,
> +};
> +
> +static const struct dw_pcie_ops ac5_dw_pcie_ops = {
>  	.link_up = armada8k_pcie_link_up,
>  	.start_link = armada8k_pcie_start_link,
> +	.read_dbi = ac5_pcie_read_dbi,
> +	.write_dbi = ac5_pcie_write_dbi,
> +};
> +
> +static const struct armada8k_pcie_of_data a8k_pcie_of_data = {
> +	.pcie_type = ARMADA8K_PCIE_TYPE_A8K,
> +	.pcie_ops = &armada8k_dw_pcie_ops,
> +};
> +
> +static const struct armada8k_pcie_of_data ac5_pcie_of_data = {
> +	.pcie_type = ARMADA8K_PCIE_TYPE_AC5,
> +	.pcie_ops = &ac5_dw_pcie_ops,
>  };
>  
>  static int armada8k_pcie_probe(struct platform_device *pdev)
> @@ -268,9 +349,15 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  	struct dw_pcie *pci;
>  	struct armada8k_pcie *pcie;
>  	struct device *dev = &pdev->dev;
> +	const struct armada8k_pcie_of_data *data;
>  	struct resource *base;
>  	int ret;
>  
> +	data = of_device_get_match_data(dev);
> +	if (!data)
> +		return -EINVAL;
> +
> +
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>  	if (!pcie)
>  		return -ENOMEM;
> @@ -279,9 +366,10 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  	if (!pci)
>  		return -ENOMEM;
>  
> +	pci->ops = data->pcie_ops;
>  	pci->dev = dev;
> -	pci->ops = &dw_pcie_ops;
>  
> +	pcie->pcie_type = data->pcie_type;
>  	pcie->pci = pci;
>  
>  	pcie->clk = devm_clk_get(dev, NULL);
> @@ -334,7 +422,14 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id armada8k_pcie_of_match[] = {
> -	{ .compatible = "marvell,armada8k-pcie", },
> +	{
> +		.compatible = "marvell,armada8k-pcie",
> +		.data = &a8k_pcie_of_data,
> +	},
> +	{
> +		.compatible = "marvell,ac5-pcie",
> +		.data = &ac5_pcie_of_data,
> +	},
>  	{},
>  };
>  
> -- 
> 2.17.1
> 
> 
