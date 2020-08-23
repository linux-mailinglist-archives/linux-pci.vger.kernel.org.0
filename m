Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE2C24EDF8
	for <lists+linux-pci@lfdr.de>; Sun, 23 Aug 2020 17:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgHWPoW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Aug 2020 11:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbgHWPoU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Aug 2020 11:44:20 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61DFE206B5;
        Sun, 23 Aug 2020 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598197459;
        bh=IGrUWo+ZZQob7RT3bigA5vJ0AAgTdXLODPPhOJ7jI8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uXGYiG6uoppBGRARNWru4yEaH6q/fvYNktocQGoDPuVk7r5S25Yvw7y0dtBvxduII
         I05PWSK+T0wliMbMP00PtBm9X94ZONJyU1Bf0wHqqwk72YB2A18z7lexWAhGLXHfOs
         KCHcGQ+XjW6oT6Fwwc8uKzoTdDYUIQCC+qntgXWo=
Date:   Sun, 23 Aug 2020 21:14:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, kishon@ti.com, svarbanov@mm-sol.com,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        mgautam@codeaurora.org, smuthayy@codeaurora.org,
        varada@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Subject: Re: [PATCH V2 4/7] phy: qcom-qmp: Add compatible for ipq8074 PCIe
 Gen3 qmp phy
Message-ID: <20200823154415.GT2639@vkoul-mobl>
References: <1596036607-11877-1-git-send-email-sivaprak@codeaurora.org>
 <1596036607-11877-5-git-send-email-sivaprak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596036607-11877-5-git-send-email-sivaprak@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sivaprakash,

On 29-07-20, 21:00, Sivaprakash Murugesan wrote:
> ipq8074 has two PCIe ports, One Gen2 and one Gen3 ports.
> Since support for Gen2 phy is already available, add support for
> PCIe Gen3 phy.
> 
> Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
> [V2]
>  * Addressed review comments from Vinod
>  drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h | 139 ++++++++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.c       | 171 +++++++++++++++++++++++++++++-
>  2 files changed, 308 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h b/drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h
> new file mode 100644
> index 0000000..812ee75
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h
> @@ -0,0 +1,139 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + */
> +
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef PHY_QCOM_PCIE_H

Kernel uses this convention..
#ifndef PHY_QCOM_PCIE_H
#define PHY_QCOM_PCIE_H

header contents

#endif

Please update

> +
> +/* QMP V2 PCIE PHY - Found in IPQ8074 gen3 port - QSERDES PLL registers */
> +#define QSERDES_PLL_BG_TIMER				0x00c
> +#define QSERDES_PLL_SSC_PER1				0x01c
> +#define QSERDES_PLL_SSC_PER2				0x020
> +#define QSERDES_PLL_SSC_STEP_SIZE1_MODE0		0x024
> +#define QSERDES_PLL_SSC_STEP_SIZE2_MODE0		0x028
> +#define QSERDES_PLL_SSC_STEP_SIZE1_MODE1		0x02c
> +#define QSERDES_PLL_SSC_STEP_SIZE2_MODE1		0x030
> +#define QSERDES_PLL_BIAS_EN_CLKBUFLR_EN			0x03c
> +#define QSERDES_PLL_CLK_ENABLE1				0x040
> +#define QSERDES_PLL_SYS_CLK_CTRL			0x044
> +#define QSERDES_PLL_SYSCLK_BUF_ENABLE			0x048
> +#define QSERDES_PLL_PLL_IVCO				0x050
> +#define QSERDES_PLL_LOCK_CMP1_MODE0			0x054
> +#define QSERDES_PLL_LOCK_CMP2_MODE0			0x058
> +#define QSERDES_PLL_LOCK_CMP1_MODE1			0x060
> +#define QSERDES_PLL_LOCK_CMP2_MODE1			0x064
> +#define QSERDES_PLL_BG_TRIM				0x074
> +#define QSERDES_PLL_CLK_EP_DIV_MODE0			0x078
> +#define QSERDES_PLL_CLK_EP_DIV_MODE1			0x07c
> +#define QSERDES_PLL_CP_CTRL_MODE0			0x080
> +#define QSERDES_PLL_CP_CTRL_MODE1			0x084
> +#define QSERDES_PLL_PLL_RCTRL_MODE0			0x088
> +#define	QSERDES_PLL_PLL_RCTRL_MODE1			0x08C

why tab here instead of single space in others?

>  static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
>  	.type = PHY_TYPE_PCIE,
>  	.nlanes = 1,
> @@ -3024,8 +3181,15 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
>  
>  	init.ops = &clk_fixed_rate_ops;
>  
> -	/* controllers using QMP phys use 125MHz pipe clock interface */
> -	fixed->fixed_rate = 125000000;
> +	/*
> +	 * controllers using QMP phys use 125MHz pipe clock interface unless
> +	 * other frequency is specified in dts
> +	 */
> +	ret = of_property_read_u32(np, "clock-output-rate",
> +				   (u32 *)&fixed->fixed_rate);

why this cast?

-- 
~Vinod
