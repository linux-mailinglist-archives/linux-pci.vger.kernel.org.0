Return-Path: <linux-pci+bounces-8077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA838D4DFF
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 16:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFDB1F2431E
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 14:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A5A17623E;
	Thu, 30 May 2024 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oM7fO1Vz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C001E4AD;
	Thu, 30 May 2024 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079499; cv=none; b=WWylGxTafJrvxT2P2vLC0B4gtxSOexvlvH1iSv5CTjlgcMj8W14E6dxZusDNs5W8BdcgrS071nNUr1BZ0UZRGA9Mjgg1kYWHYDddDupUEKQMg3WZqtJGINKDTKp7/kAqclc2Ct9/Nzb7bmdM6jiWXS70+p8cPz0CskIVcjlE3xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079499; c=relaxed/simple;
	bh=GcW1Wou8chddpSPPB7laOmJQynwoluv3+QUtupPMgl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idbEpYn/vLsB053PpMTJy/s8rWGgBB4acFoXub/Zv/GhwDDhEhh33/jfFjXbZftoOuwYipQSHDBRJDdkX1y7YzqELrdQuCqeTtRqydmBX1t7U1QxsgEDsXSSlzJtELfmre/90dZDgBWlDv6mY7gkSjxa2nuz/7gnm76gMruIqvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oM7fO1Vz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8111AC2BBFC;
	Thu, 30 May 2024 14:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717079498;
	bh=GcW1Wou8chddpSPPB7laOmJQynwoluv3+QUtupPMgl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oM7fO1VzaJ1iQx3EmGL5UbYN21uGLnEiz7+/flSYhMWWrvm3fhlJiwyYOJeAHnV5p
	 /f1mqWMVWFnfg0DSM2G5YiFD7D9iY8FrSc3jDqeM3W+yDdTDXJn+ueYmrqTNzU7Ebr
	 zWsPNlcYZUuLh8ursVFPKkarUbV0LUCeT6c758apkBGGo9JhpciUM1zDWpvk/HeCnx
	 tZWNfaZOlwE0V/imUExNps07/Qh4ux88qqcuCEmQmfnZaH5laYOMIBf7hUUk8801P2
	 I92QdQQX5OiimqoENmrsUOkCDeSQf9iBn6SwsZ3CWfiMxXDGA80d2qsQ692W8c/daN
	 13onil92J1b3g==
Date: Thu, 30 May 2024 20:01:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	manivannan.sadhasivam@linaro.org, andersson@kernel.org,
	agross@kernel.org, konrad.dybcio@linaro.org,
	quic_msarkar@quicinc.com, quic_kraravin@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 2/3] PCI: qcom: Add equalization settings for 16 GT/s
Message-ID: <20240530143129.GC2770@thinkpad>
References: <20240501163610.8900-1-quic_schintav@quicinc.com>
 <20240501163610.8900-3-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240501163610.8900-3-quic_schintav@quicinc.com>

On Wed, May 01, 2024 at 09:35:33AM -0700, Shashank Babu Chinta Venkata wrote:
> During high data transmission rates such as 16 GT/s , there is an
> increased risk of signal loss due to poor channel quality and
> interference. This can impact receiver's ability to capture signals
> accurately. Hence, signal compensation is achieved through appropriate
> lane equilization settings at both transmitter and receiver. This will
> result in increasing PCIe signal strength.

s/increasing/increased

> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware.h  | 12 ++++++
>  drivers/pci/controller/dwc/pcie-qcom-common.c | 37 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-common.h |  1 +
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  3 ++
>  drivers/pci/controller/dwc/pcie-qcom.c        |  3 ++
>  5 files changed, 56 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 26dae4837462..ed0045043847 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -122,6 +122,18 @@
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
> index 228d9eec0222..16c277b2e9d4 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-common.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
> @@ -16,6 +16,43 @@
>  #define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
>  		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
>  
> +void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * GEN3_RELATED_OFF register is repurposed to apply equilaztion
> +	 * settings at various data transmission rates through registers
> +	 * namely GEN3_EQ_*. RATE_SHADOW_SEL bit field of GEN3_RELATED_OFF
> +	 * determines data rate for which this equilization settings are
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
>  	struct icc_path *icc_mem_p;
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
> index da1760c7e164..5c01f6c18b3b 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-common.h
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
> @@ -10,3 +10,4 @@
>  struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const char *path);
>  int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem);
>  void qcom_pcie_common_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem);
> +void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci);
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index f0c61d847643..7940222d35f6 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -438,6 +438,9 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>  		goto err_disable_resources;
>  	}
>  
> +	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)
> +		qcom_pcie_common_set_16gt_eq_settings(pci);
> +
>  	/*
>  	 * The physical address of the MMIO region which is exposed as the BAR
>  	 * should be written to MHI BASE registers.
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0095c42aeee0..525942f2cf98 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -263,6 +263,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
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
> 2.43.2
> 

-- 
மணிவண்ணன் சதாசிவம்

