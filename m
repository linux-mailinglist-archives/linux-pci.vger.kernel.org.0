Return-Path: <linux-pci+bounces-6522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 865448AD06D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 17:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1001F2182B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 15:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F76715251B;
	Mon, 22 Apr 2024 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DddYxD9Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F8913E8B2;
	Mon, 22 Apr 2024 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799009; cv=none; b=MbWLap5TVNrcImOYkW0H9YaFL5ivQwLKR06HG7L2K4bPzSQEerl4S4Dv7IppWHyoOdeoaLIbUclASU58ArLeGhP79qSmzjkRX856W0i7D1/6w01yQM+3ZeIIfMqygScTFlBn637PAtH/7a5MHQiyqzmfnLnnTtdzY2BqI7saj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799009; c=relaxed/simple;
	bh=xdss4el+V60V2ws+xgbpajq8iInRegrkoN8TP9o57z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PW60hQyYDN30s72eA6xcvVEyhwz8hSFddXbP73h0Wl3EDc+Gg/tJucDAzWsdATNpvLyCaJvHj/VM54oPPmcH0JZAZJoRyhN0JdlyhSshzxZzXtPm9HSfvBPUAx59AqvC8m6W9GhYhg5W8kvOczJZ6PW1jxwsMRPA8HvPp9me6DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DddYxD9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB90C113CC;
	Mon, 22 Apr 2024 15:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713799009;
	bh=xdss4el+V60V2ws+xgbpajq8iInRegrkoN8TP9o57z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DddYxD9YcuuEidSLLrYzsRR3+SBt+y8BsJI9lzFM7Oh2dDlY4SIjUYUdFZXrjUwjg
	 DvPq5dxVbuSrfeWu/L2fBW+txJx9AS5lKr/EBr0qaSErcEJnEA/Uyz9nT3L/92mTut
	 o4dTFf4CJF/PezRBGIdcAs0tFvnlm46Lgl13kEeLFbvfwar4gLgyVCLc0JsR3Yj72H
	 YdXfREIcykUKw6GlqJSMj3bWZyTMkJRB91aNXiagWco5GJ+Gwv91f+F8876d94qrJv
	 qLC1BizS13XrI9+LTmn7L9mUPGHvfxVaIHmDqjBChimXf1+CNtM2C5oTR04gd/rFlN
	 iOwKaftYRw7yg==
Date: Mon, 22 Apr 2024 20:46:25 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	quic_msarkar@quicinc.com, quic_kraravin@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] PCI: qcom: Add equalization settings for 16GT/s
Message-ID: <20240422151625.GG9775@thinkpad>
References: <20240419001013.28788-1-quic_schintav@quicinc.com>
 <20240419001013.28788-3-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240419001013.28788-3-quic_schintav@quicinc.com>

On Thu, Apr 18, 2024 at 05:09:35PM -0700, Shashank Babu Chinta Venkata wrote:

PCI: qcom: Add PCIe link equalization settings for 16 GT/s

> GEN3_RELATED_OFFSET is being used to determine data rate of shadow
> registers. Select data rate as 16GT/s and set appropriate equilization
> settings to improve link stability for 16GT/s data rate.
> 

How about:

'To improve the PCIe link stability while running at the rate of 16 GT/s, set
the appropriate link equalization settings for both RC and EP controllers.'

However, I don't understand the statement about 'GEN3_RELATED_OFFSET' and
'shadow registers'. Please reword it to make it understandable.

> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.h  | 12 ++++++++
>  drivers/pci/controller/dwc/pcie-qcom-common.c | 30 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-common.h |  1 +
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  3 ++
>  drivers/pci/controller/dwc/pcie-qcom.c        |  3 ++
>  5 files changed, 49 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 26dae4837462..ad771bb52d29 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -122,6 +122,18 @@
>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
>  
> +#define GEN3_EQ_CONTROL_OFF			0x8a8
> +#define GEN3_EQ_CONTROL_OFF_FB_MODE(n)		FIELD_PREP(GENMASK(3, 0), n)
> +#define GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE(n)	FIELD_PREP(BIT(4), n)
> +#define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC(n)	FIELD_PREP(GENMASK(23, 8), n)
> +#define GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL(n)	FIELD_PREP(BIT(24), n)
> +
> +#define GEN3_EQ_FB_MODE_DIR_CHANGE_OFF          0x8ac
> +#define GEN3_EQ_FMDC_T_MIN_PHASE23(n)	FIELD_PREP(GENMASK(4, 0), n)
> +#define GEN3_EQ_FMDC_N_EVALS(n)		FIELD_PREP(GENMASK(9, 5), n)
> +#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA(n)	FIELD_PREP(GENMASK(13, 10), n)
> +#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA(n)	FIELD_PREP(GENMASK(17, 14), n)
> +
>  #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
>  #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
>  
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
> index dc2120ec5fef..a6f3eb4c3ee6 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-common.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
> @@ -16,6 +16,36 @@
>  #define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
>  		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
>  
> +void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * GEN3_RELATED_OFF is repurposed to be used with GEN4(16GT/s) rate
> +	 * as well based on RATE_SHADOW_SEL_MASK settings on this register.

Same comment as above.

> +	 */
> +	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> +	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
> +	reg |= (0x1 << GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT);

Use FIELD_PREP()

> +	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
> +
> +	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
> +	reg = GEN3_EQ_FMDC_T_MIN_PHASE23(0) |

You are reading 'reg' above and then overwriting immediately.

> +		GEN3_EQ_FMDC_N_EVALS(0xD) |

'0xd'

> +		GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA(0x5) |
> +		GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA(0x5);
> +	dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
> +
> +	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> +	reg = GEN3_EQ_CONTROL_OFF_FB_MODE(0) |

Same as above.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

