Return-Path: <linux-pci+bounces-5515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B887894AEF
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 07:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB031C22061
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 05:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB651803A;
	Tue,  2 Apr 2024 05:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKROSwI0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC8C323D;
	Tue,  2 Apr 2024 05:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712036747; cv=none; b=oxa4QvaEeJvxIfff0IXOKaeWinRxknLUnRpDbMqwbX1imC8nKjyZLFsdzpgU0Rt0d1Tuyl7ej8+psS927cQBCzQVB/mK9oClIydzKTB65Ub4sQy0J55WUUZc2H+CPXFtSPP72lpdsxGQyOCyjjN/YFOm/KnW9tiukcIrHABNJJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712036747; c=relaxed/simple;
	bh=adZ7sJPl/Yy9PlJ2BUlKHOYalm+hH3gkDLFFb7Fweps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ET4p6r0I7KGVGWkUvh7Xy4JUiEKKGsA0Qh0FT5GObyqTbyzqcQyOTsuOG5Fa0iSy0NMAi9Fjk1CIFh2mtou1TFCRMvRpkDNI/PcLthZTQWEZn6ycSZ9ZZXbDbbmaLNDukBR1UGjtq90VaDOZTq6irNbl3fJMvxn1N+B9ii+1E3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKROSwI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1971C433C7;
	Tue,  2 Apr 2024 05:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712036747;
	bh=adZ7sJPl/Yy9PlJ2BUlKHOYalm+hH3gkDLFFb7Fweps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKROSwI0Nc17lvfclyAxTW8vPcWoxxzdHOkvkxdcW7nQPxagM0ZU8YBdQZvkFl1TV
	 u0LPVkyif7CTVr/NsZenIUddtckeZ7fW7nW3HHpFdBZ/KAtsRVygghvryqu+au+xXY
	 wrhXtP/HEPCtN26Z6tyUJecE/FgHR/kpK3+m7fYHBQ0MrIDT6wuwAVJ1L8p3w3M7wn
	 rWtF8poAJvlqB3LryETSqKoNKNZfZbtftXoU7CghODF7DjVf4r2Vy1XNDtzH9TLJTQ
	 7RlRFH2/yORRSXT+rmoUoRxUB0MuwU3H70ilSQwApagssruJQ1MMuwO3rYXgzdwOhk
	 d12FH5CzUepvg==
Date: Tue, 2 Apr 2024 11:15:38 +0530
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
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] PCI: qcom: Add equalization settings for gen4
Message-ID: <20240402054538.GJ2933@thinkpad>
References: <20240320071527.13443-1-quic_schintav@quicinc.com>
 <20240320071527.13443-3-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320071527.13443-3-quic_schintav@quicinc.com>

On Wed, Mar 20, 2024 at 12:14:46AM -0700, Shashank Babu Chinta Venkata wrote:

Here, you are referring to 16 GT/s as the Gen4 datarate. So please mention that
explicitly.

> GEN3_RELATED_OFFSET is being used as shadow register for generation4 and

What is 'GEN3_RELATED_OFFSET' register? Where it is defined? More info on this
register would be helpful.

> generation5 data rates based on rate select mask settings on this register.

Please reword this sentence to make it more readable.

> Select relevant mask and equalization settings for generation4 operation.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.h | 15 ++++++++
>  drivers/pci/controller/dwc/pcie-qcom-cmn.c   | 36 ++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-cmn.h   |  5 +++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c    |  3 ++
>  drivers/pci/controller/dwc/pcie-qcom.c       |  3 ++
>  5 files changed, 62 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 26dae4837462..064744bfe35a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -122,6 +122,21 @@
>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
>  
> +#define GEN3_EQ_CONTROL_OFF			0x8a8
> +#define GEN3_EQ_CONTROL_OFF_FB_MODE_MASK        GENMASK(3, 0)
> +#define GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE   BIT(4)
> +#define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK	GENMASK(23, 8)
> +#define GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL	BIT(24)
> +
> +#define GEN3_EQ_FB_MODE_DIR_CHANGE_OFF          0x8ac
> +#define GEN3_EQ_FMDC_T_MIN_PHASE23_MASK         GENMASK(4, 0)
> +#define GEN3_EQ_FMDC_N_EVALS_MASK               GENMASK(9, 5)
> +#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_MASK  GENMASK(13, 10)
> +#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_MASK	GENMASK(17, 14)
> +#define GEN3_EQ_FMDC_N_EVALS_SHIFT			5
> +#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_SHIFT		10
> +#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_SHIFT	14
> +

You are adding the definitions in designware header, but funtion definitions in
Qcom driver. Does this mean, this configuration is specific to Qcom and not
applicable to other DWC drivers?

>  #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
>  #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
>  
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-cmn.c b/drivers/pci/controller/dwc/pcie-qcom-cmn.c
> index 64fa412ec293..208a55e8e9a1 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-cmn.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.c
> @@ -17,6 +17,42 @@
>  #define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
>  		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
>  
> +void qcom_pcie_cmn_set_16gt_eq_settings(struct dw_pcie *pci)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * GEN3_RELATED_OFF is repurposed to be used with GEN4(16GT/s) rate
> +	 * as well based on RATE_SHADOW_SEL_MASK settings on this register.
> +	 */
> +	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> +	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
> +	reg |= (0x1 << GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT);

Please use FIELD_* macros where applicable.

> +	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
> +
> +	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
> +	reg &= ~GEN3_EQ_FMDC_T_MIN_PHASE23_MASK;
> +	reg &= ~GEN3_EQ_FMDC_N_EVALS_MASK;
> +	reg |= (GEN3_EQ_FMDC_N_EVALS_16GT_VAL <<
> +		GEN3_EQ_FMDC_N_EVALS_SHIFT);
> +	reg &= ~GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_MASK;
> +	reg |= (GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_16GT_VAL <<
> +		GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_SHIFT);
> +	reg &= ~GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_MASK;
> +	reg |= (GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_16GT_VAL <<
> +		GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_SHIFT);
> +	dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
> +
> +	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> +	reg &= ~GEN3_EQ_CONTROL_OFF_FB_MODE_MASK;
> +	reg &= ~GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE;
> +	reg &= ~GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL;
> +	reg &= ~GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK;
> +	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pcie_cmn_set_16gt_eq_settings);
> +
>  int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem)
>  {
>  	if (IS_ERR(pci))
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-cmn.h b/drivers/pci/controller/dwc/pcie-qcom-cmn.h
> index 845eda23ae59..97302e8fafa8 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-cmn.h
> +++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.h
> @@ -9,6 +9,11 @@
>  #include "../../pci.h"
>  #include "pcie-designware.h"
>  
> +#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_16GT_VAL   0x5
> +#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_16GT_VAL  0x5
> +#define GEN3_EQ_FMDC_N_EVALS_16GT_VAL          0xD
> +

So these settings are Qcom specific? I'd expect this to be documented in commit
message.

>  int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem);
>  int qcom_pcie_cmn_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem);
>  void qcom_pcie_cmn_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem);
> +void qcom_pcie_cmn_set_16gt_eq_settings(struct dw_pcie *pci);
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index ce6343426de8..b6bcab21bb9f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -438,6 +438,9 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>  		goto err_disable_resources;
>  	}
>  
> +	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)
> +		qcom_pcie_cmn_set_16gt_eq_settings(pci);

So this relies on the optional 'max-link-speed' DT property, but not mentioned
in the commit message :/

- Mani

> +
>  	/*
>  	 * The physical address of the MMIO region which is exposed as the BAR
>  	 * should be written to MHI BASE registers.
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 57a08294c561..b0a22a000fa3 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -263,6 +263,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>  {
>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>  
> +	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)
> +		qcom_pcie_cmn_set_16gt_eq_settings(pci);
> +
>  	/* Enable Link Training state machine */
>  	if (pcie->cfg->ops->ltssm_enable)
>  		pcie->cfg->ops->ltssm_enable(pcie);
> -- 
> 2.43.2
> 

-- 
மணிவண்ணன் சதாசிவம்

