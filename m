Return-Path: <linux-pci+bounces-12728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C2296B74E
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 11:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05E4BB2D7AA
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 09:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9081CCEE4;
	Wed,  4 Sep 2024 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeBLCiIR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C5B1CCED5;
	Wed,  4 Sep 2024 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442733; cv=none; b=hb6TZvbYiaoz9eMwOReCg9aYBxcJLKWqekVvr/N+EBWQD/5TbPsUSCMkezQ5XkqUOR1VF9aYQBpGcj1+G9uX+vjMwuTFjM4lJSdKI7wwzuQIZCzDZXATY5mJY9JlrHFfjjztlHrIrPwPxyFa0jWD5HnmILFbYCL1uHmTcOZg7C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442733; c=relaxed/simple;
	bh=KmyA68nzsmKeQqVYQzVFeMOcA8YdDjGJMWH0cfv8O4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKLdn5jVmTz9JYeMJnxrw37w78ujsV7fBtwSPIJTHj/XUbM8E9TbQ/zHX5ufdeRi+Jy9iOpyIybIoifFM1fBtgXOxz313sYYvp+B4Shy/Izqg65Z/Kaf8upIHGll95GVLvwWW1LEQuoips5th33auA1LvpBG//aWQMXnLcg1MbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeBLCiIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C31C4CEC2;
	Wed,  4 Sep 2024 09:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725442733;
	bh=KmyA68nzsmKeQqVYQzVFeMOcA8YdDjGJMWH0cfv8O4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IeBLCiIRh8c4VREeW7bQWZzbnGPRve49Ue8NudWmF/yIRW7kCkUZjRO5lJTE1Q1uY
	 EZWFSZWwesMfu58MDUxRT73RsyShqjpSz5Q4xMeeU4uTnv8E6+It2IM7cKgJSsORbw
	 K2VYXsjxEB8rq9o1ltg1CzHBGfQXSsD0e+dtfNq83DNSvNxqZSl5N6kzQzYGoAAhMU
	 OEiZFNTwa63R0EzMogWoaKG/zDu82Rj4MpbYe9puFToZostf2fatOBDyxsDkFbtfzU
	 aokbdGriHqhn8Q2ds9hTIDfRkCYcyRStjSEpmDl2Oo1vHkbCSD1y+rE1WGnXA1Ty1E
	 O76ouKvPzex1A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1slmTl-0000000020w-0ZZs;
	Wed, 04 Sep 2024 11:39:09 +0200
Date: Wed, 4 Sep 2024 11:39:09 +0200
From: Johan Hovold <johan@kernel.org>
To: manivannan.sadhasivam@linaro.org
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	abel.vesa@linaro.org, johan+linaro@kernel.org,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Subject: Re: [PATCH v6 3/4] PCI: qcom: Add equalization settings for 16.0 GT/s
Message-ID: <ZtgqvXGgp2sWNg5O@hovoldconsulting.com>
References: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
 <20240904-pci-qcom-gen4-stability-v6-3-ec39f7ae3f62@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-pci-qcom-gen4-stability-v6-3-ec39f7ae3f62@linaro.org>

On Wed, Sep 04, 2024 at 12:41:59PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> 
> During high data transmission rates such as 16.0 GT/s, there is an
> increased risk of signal loss due to poor channel quality and interference.
> This can impact receiver's ability to capture signals accurately. Hence,
> signal compensation is achieved through appropriate lane equalization
> settings at both transmitter and receiver. This will result in increased
> PCIe signal strength.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> [mani: dropped the code refactoring and minor changes]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 
> +#define GEN3_EQ_CONTROL_OFF			0x8a8

Nit: uppercase hex since that's what is used for the other offsets

> +#define GEN3_EQ_CONTROL_OFF_FB_MODE		GENMASK(3, 0)
> +#define GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE	BIT(4)
> +#define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC	GENMASK(23, 8)
> +#define GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL	BIT(24)
> +
> +#define GEN3_EQ_FB_MODE_DIR_CHANGE_OFF          0x8ac

Nit: odd indentation uses spaces, uppercase

> +#define GEN3_EQ_FMDC_T_MIN_PHASE23		GENMASK(4, 0)
> +#define GEN3_EQ_FMDC_N_EVALS			GENMASK(9, 5)
> +#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA	GENMASK(13, 10)
> +#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA	GENMASK(17, 14)
> +
>  #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
>  #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
>  
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
> new file mode 100644
> index 000000000000..dc7d93db9dc5
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/pci.h>
> +
> +#include "pcie-designware.h"
> +#include "pcie-qcom-common.h"
> +
> +void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * GEN3_RELATED_OFF register is repurposed to apply equalization
> +	 * settings at various data transmission rates through registers namely
> +	 * GEN3_EQ_*. RATE_SHADOW_SEL bit field of GEN3_RELATED_OFF determines
> +	 * data rate for which this equalization settings are applied.

*The* RATE_SHADOW_SEL bit field

*the* data rate

s/this/these/

> +	 */
> +	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> +	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
> +	reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK, 0x1);

How does 0x1 map to gen4/16 GT?

> +	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
> +
> +	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
> +	reg &= ~(GEN3_EQ_FMDC_T_MIN_PHASE23 |
> +		GEN3_EQ_FMDC_N_EVALS |
> +		GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA |
> +		GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA);
> +	reg |= FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
> +		FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
> +		FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA, 0x5) |
> +		FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA, 0x5);
> +	dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
> +
> +	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> +	reg &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
> +		GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE |
> +		GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL |
> +		GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
> +	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_eq_settings);
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
> new file mode 100644
> index 000000000000..259e04b7bdf9
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include "pcie-designware.h"

You only need a forward declaration:

	struct dw_pcie;

> +
> +void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci);

Compile guard still missing.

Johan

