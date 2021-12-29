Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359744812BB
	for <lists+linux-pci@lfdr.de>; Wed, 29 Dec 2021 13:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238092AbhL2MkA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Dec 2021 07:40:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37088 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbhL2MkA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Dec 2021 07:40:00 -0500
Message-ID: <7320d3fb-4338-86b8-5a49-b56f06f1cd11@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640781598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VK8JjCAILC4Pks4UyV4d6jV2jFdL5FC8a0J3vQoAPIM=;
        b=hmvTN58MVIE0bw5z8QpAZtWvHRz6yjKKfBRNxUqSTL2/eKVE7PHmXg3ttiGU0h9JHZpszV
        qQss/6j5LZl6YvEVUPXS5ULU2GBe14UOKEkAsunKwzjjTJ/5neaE25CbYuboVoh9OqgFhW
        RZe7i68slcAOVhIGcsqzLS86FkSLUSTjFHGTqhDvWMSMbnsnlm+0R2SX2msT+wb/xc2wHm
        9GI0xowBQGJaMvzQAlOognQAjjeksGIDLvBIDutCL97EMTTGrFtLoJYeIhZr3OemXDqE9j
        W1sn88asG+iiS7BQ268LeeQh73RbE0gqjh3wB5yn98Nm6z4vt7VKa01fC2E1kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640781598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VK8JjCAILC4Pks4UyV4d6jV2jFdL5FC8a0J3vQoAPIM=;
        b=19N9LN2Plsnl5mgKiuuZfw79rauawTIw2lPlms19UUMXWgnr2dOJWzGh0otku1H3XJovwd
        oHqNIcIS+gprHMAA==
Date:   Wed, 29 Dec 2021 13:39:57 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v7 5/8] phy: freescale: pcie: Initialize the imx8 pcie
 standalone phy driver
Content-Language: en-US
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, tharvey@gateworks.com,
        marcel.ziswiler@toradex.com, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, galak@kernel.crashing.org, shawnguo@kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
References: <1638432158-4119-1-git-send-email-hongxing.zhu@nxp.com>
 <1638432158-4119-6-git-send-email-hongxing.zhu@nxp.com>
From:   Philip Molloy <philip@linutronix.de>
In-Reply-To: <1638432158-4119-6-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Richard,

I've run into an issue that appears to indicate a functional difference
between the existing integrated pci-imx6.c implementation and this new
implementation with the separate phy driver.

I'm working with a SOM and baseboard from Phytec that is based on the
IMX8MM. The board does not have an external PCIe clock and has a
ethernet controller hanging off the PCIe bus.

When booting from a 5.4 NXP-based kernel from Phytec the ethernet
controller is probed and functions as expected.

A co-worker backported a slightly earlier version of this patchset to
5.10.[1] With our kernel both the controller driver and new PHY driver
are probed, but a timeout occurs in dw_pcie_wait_for_link() which
indicates that the "Phy link never came up".

After reproducing this issue I configured pcie_phy with
IMX8_PCIE_REFCLK_PAD_OUTPUT. With that configured, phy register
CMN_REG062/0x188 matches the 5.4 NXP/Phytec kernel. I then compared the
controller and PHY registers between the two kernels and noticed that
CMN_REG063/0x18c is set to AUX_IN/0x0 in the 5.4 NXP/Phytec kernel, but
the new PHY driver writes I_PLL_REFCLK_FROM_SYSPLL/0xc0 to that register.

If I modify the phy driver to not write I_PLL_REFCLK_FROM_SYSPLL/0xc0
then the system behaves as expected.

Best,
Philip

[1]: I plan on rebasing our branch with the latest patches that have
been applied upstream. Note that I did not see any difference in the
following code with what we have applied.

On 12/2/21 09:02, Richard Zhu wrote:
> +#define IMX8MM_PCIE_PHY_CMN_REG061	0x184
> +#define  ANA_PLL_CLK_OUT_TO_EXT_IO_EN	BIT(0)
> +#define IMX8MM_PCIE_PHY_CMN_REG062	0x188
> +#define  ANA_PLL_CLK_OUT_TO_EXT_IO_SEL	BIT(3)
> +#define IMX8MM_PCIE_PHY_CMN_REG063	0x18C
> +#define  AUX_PLL_REFCLK_SEL_SYS_PLL	GENMASK(7, 6)
> +#define IMX8MM_PCIE_PHY_CMN_REG064	0x190
> +#define  ANA_AUX_RX_TX_SEL_TX		BIT(7)
> +#define  ANA_AUX_RX_TERM_GND_EN		BIT(3)
> +#define  ANA_AUX_TX_TERM		BIT(2)
> +#define IMX8MM_PCIE_PHY_CMN_REG065	0x194
> +#define  ANA_AUX_RX_TERM		(BIT(7) | BIT(4))
> +#define  ANA_AUX_TX_LVL			GENMASK(3, 0)
...
> +	if (pad_mode == IMX8_PCIE_REFCLK_PAD_INPUT) {
> +		/* Configure the pad as input */
> +		val = readl(imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG061);
> +		writel(val & ~ANA_PLL_CLK_OUT_TO_EXT_IO_EN,
> +		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG061);
> +	} else if (pad_mode == IMX8_PCIE_REFCLK_PAD_OUTPUT) {
> +		/* Configure the PHY to output the refclock via pad */
> +		writel(ANA_PLL_CLK_OUT_TO_EXT_IO_EN,
> +		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG061);
> +		writel(ANA_PLL_CLK_OUT_TO_EXT_IO_SEL,
> +		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG062);
> +		writel(AUX_PLL_REFCLK_SEL_SYS_PLL,
> +		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG063);

If I comment out this writel() then the register defaults to 0x0/AUX_IN
and then the system behaves as expected.

> +		val = ANA_AUX_RX_TX_SEL_TX | ANA_AUX_TX_TERM;
> +		writel(val | ANA_AUX_RX_TERM_GND_EN,
> +		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG064);
> +		writel(ANA_AUX_RX_TERM | ANA_AUX_TX_LVL,
> +		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG065);
> +	}

