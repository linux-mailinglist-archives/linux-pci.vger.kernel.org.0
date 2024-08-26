Return-Path: <linux-pci+bounces-12188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8B095EB3C
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 10:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438381C2287C
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 08:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A31B13AA2B;
	Mon, 26 Aug 2024 07:55:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DD42D052;
	Mon, 26 Aug 2024 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724658914; cv=none; b=C8RB2WqBgvtGzw9cajE4ObpkChubjypLLvg4sg/lCDG0fM8elENxk74x9q0zVDJumh6HH90HbbdIJwgH/Wm8k0fsjCbQpFEFhck97ARybm8t3SepQcPDMz2Dt2YF8KkxVZIf+oTZS6dP0eB7AtXl+lS93Su3WczSf6qoL7LCcsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724658914; c=relaxed/simple;
	bh=jJiYC1g7DDJ2SI7n4ZqSQeOupm9HEWP+pCn4FZGr1Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErCntOiqEDbJBMQqsFdRvevLdtLUZIUn7FEItOXB5+J3hBcRGcZj+WfTpX784R4JeAGXiGBWaPULiSZGXsOT4iV3x2jgo9zCk86Q6gVdcTUoI6kyLVCi5kfnNW10jBo6cRVg1npCFYO8W/qxAkf4jTw2QbeYxRq2mOHmXqC1+uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4CFC8CDD4;
	Mon, 26 Aug 2024 07:55:08 +0000 (UTC)
Date: Mon, 26 Aug 2024 13:25:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mani@kernel.org, quic_msarkar@quicinc.com,
	quic_kraravin@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 2/3] PCI: qcom: Add equalization settings for 16 GT/s
Message-ID: <20240826075505.zg3tr7abs5rotkjo@thinkpad>
References: <20240821170917.21018-1-quic_schintav@quicinc.com>
 <20240821170917.21018-3-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240821170917.21018-3-quic_schintav@quicinc.com>

On Wed, Aug 21, 2024 at 10:08:43AM -0700, Shashank Babu Chinta Venkata wrote:
> During high data transmission rates such as 16 GT/s , there is an
> increased risk of signal loss due to poor channel quality and
> interference. This can impact receiver's ability to capture signals
> accurately. Hence, signal compensation is achieved through appropriate
> lane equalization settings at both transmitter and receiver. This will
> result in increased PCIe signal strength.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.h  | 12 ++++++
>  drivers/pci/controller/dwc/pcie-qcom-common.c | 37 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-common.h |  1 +
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  3 ++
>  drivers/pci/controller/dwc/pcie-qcom.c        |  3 ++
>  5 files changed, 56 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 53c4c8f399c8..50265a2fbb9f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -126,6 +126,18 @@
>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
>  
> +#define GEN3_EQ_CONTROL_OFF			0x8a8
> +#define GEN3_EQ_CONTROL_OFF_FB_MODE		GENMASK(3, 0)
> +#define GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE	BIT(4)
> +#define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC	GENMASK(23, 8)
> +#define GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL	BIT(24)
> +
> +#define GEN3_EQ_FB_MODE_DIR_CHANGE_OFF          0x8ac
> +#define GEN3_EQ_FMDC_T_MIN_PHASE23		GENMASK(4, 0)
> +#define GEN3_EQ_FMDC_N_EVALS			GENMASK(9, 5)
> +#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA	GENMASK(13, 10)
> +#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA	GENMASK(17, 14)
> +
>  #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
>  #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
>  
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
> index 1d8992147bba..e085075557cd 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-common.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
> @@ -15,6 +15,43 @@
>  #include "pcie-designware.h"
>  #include "pcie-qcom-common.h"
>  
> +void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * GEN3_RELATED_OFF register is repurposed to apply equalization
> +	 * settings at various data transmission rates through registers
> +	 * namely GEN3_EQ_*. RATE_SHADOW_SEL bit field of GEN3_RELATED_OFF
> +	 * determines data rate for which this equalization settings are
> +	 * applied.
> +	 */
> +	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> +	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
> +	reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK, 0x1);
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
> +
>  struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const char *path)
>  {
>  	struct icc_path *icc_p;
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
> index 897fa18e618a..c281582de12c 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-common.h
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
> @@ -13,3 +13,4 @@
>  struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const char *path);
>  int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem, u32 bandwidth);
>  void qcom_pcie_common_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem);
> +void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci);
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index e1860026e134..823e33a4d745 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -455,6 +455,9 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>  		goto err_disable_resources;
>  	}
>  
> +	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)

Abel reported that 'pci->link_gen' is not updated unless the 'max-link-speed'
property is set in DT on his platform. I fixed that issue locally and this
series will depend on those patches.

Provided that you are having issues with your build environment as discussed
offline, I'd like to take over the series to combine my patches and address the
review comments. Let me know if you are OK with this or not.

- Mani

> +		qcom_pcie_common_set_16gt_eq_settings(pci);
> +
>  	/*
>  	 * The physical address of the MMIO region which is exposed as the BAR
>  	 * should be written to MHI BASE registers.
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ee32590f1506..829b34391af1 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -280,6 +280,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>  {
>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>  
> +	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)
> +		qcom_pcie_common_set_16gt_eq_settings(pci);
> +
>  	/* Enable Link Training state machine */
>  	if (pcie->cfg->ops->ltssm_enable)
>  		pcie->cfg->ops->ltssm_enable(pcie);
> -- 
> 2.46.0
> 

-- 
மணிவண்ணன் சதாசிவம்

