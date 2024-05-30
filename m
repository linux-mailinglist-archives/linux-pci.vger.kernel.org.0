Return-Path: <linux-pci+bounces-8087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C138D5064
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 19:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2644D1C22581
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 17:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E06E3BB32;
	Thu, 30 May 2024 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELRmdWVc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC5E4437F;
	Thu, 30 May 2024 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088531; cv=none; b=A+79mXaA5IE/aCmKW2cGlCaBjia1YLZwAs2zmH+WhjHXuccUL91kN04BUWsg36ig+vyA4J5qxNWQB899i0DXXENdgHn51T9ilh9qOHz/lG8CuAtXErJ1MRWzhF7aNDVKeZyb5rsHPGjncn5ReBOxP6AODP077+4UYGLLd8VWTaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088531; c=relaxed/simple;
	bh=Y+dNeNwHLWJuDYTR22EuD82dxXfuR5X20/eIghxEJvI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OixitlUfCntUrVk2dBn9Eh4+wdFcNqS73s3fyLcVNXQYYGGjnqTtPdEQBKwZG9g/+v7osadOcXqe+t6qCqQbsQfc2Hu4ALn2ppdbAMurCGUOOrNQ3lUOILA1ogocCeVtP0Wln6u/pjYw0t38USmCiJWg5qg7wlxYxg5YECIWKF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELRmdWVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE11C2BBFC;
	Thu, 30 May 2024 17:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717088531;
	bh=Y+dNeNwHLWJuDYTR22EuD82dxXfuR5X20/eIghxEJvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ELRmdWVcVht3hQRkSSBZBhP0GKj+v0E66aLlM0y8OWMOD3qkHfD1/y3cvV6Uq2J6d
	 A4YwA5h+cSfd5x4pPrDcLyXV5DG4E0VJkNYEaKxaF3cSqkfzYYEi+EpOGUACXp02fW
	 SUTt+Yp8icr4XQlw9mHVWwnMdODAQZJCJOw2nz5R5ljxNR46Jf7qOYcsqDzlA9+7K3
	 8qcbGdvXaL7Hcd3cMR+Ph/jR0ASo7Boc5/FvTi+xkSaAwhqkqjpsUOQg6U6m+u6fof
	 1KrSOt7k/jIMncy+/kbGP72BFGdMqOTqsTWSvd8PmEP7EfGUGLwiiU36Tin/Z5OBWO
	 MN5BRP59C/gFQ==
Date: Thu, 30 May 2024 12:02:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	manivannan.sadhasivam@linaro.org, andersson@kernel.org,
	agross@kernel.org, konrad.dybcio@linaro.org, mani@kernel.org,
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
Message-ID: <20240530170208.GA550711@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501163610.8900-3-quic_schintav@quicinc.com>

On Wed, May 01, 2024 at 09:35:33AM -0700, Shashank Babu Chinta Venkata wrote:
> During high data transmission rates such as 16 GT/s , there is an

s|GT/s ,|GT/s,|

> increased risk of signal loss due to poor channel quality and
> interference. This can impact receiver's ability to capture signals
> accurately. Hence, signal compensation is achieved through appropriate
> lane equilization settings at both transmitter and receiver. This will

s/equilization/equalization/

How do you get these settings at both transmitter and receiver?  Or
maybe you mean this patch sets the equalization settings in the qcom
device, whether the device is a Root Port or an Endpoint?

I don't see this patch updating "dev" and "pci_upstream_bridge(dev)",
so if you have a qcom Root Port leading to some non-qcom Endpoint,
AFAICS only the Root Port would be updated.  If that's all that's
necessary, that's perfectly fine.  It's just that the commit log
suggests that we update both ends of a link, and the patch only
appears to update one end (unless you have a qcom Root Port leading to
a qcom Endpoint, and the Endpoint is operated by an embedded Linux
running the qcom-ep driver, of course).

> result in increasing PCIe signal strength.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
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

s/0x8a8/0x8A8/ to follow existing style of file.

> +#define GEN3_EQ_CONTROL_OFF_FB_MODE		GENMASK(3, 0)
> +#define GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE	BIT(4)
> +#define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC	GENMASK(23, 8)
> +#define GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL	BIT(24)
> +
> +#define GEN3_EQ_FB_MODE_DIR_CHANGE_OFF          0x8ac

s/0x8ac/0x8AC/ to follow existing style of file.

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

s/equilaztion/equalization/

> +	 * settings at various data transmission rates through registers
> +	 * namely GEN3_EQ_*. RATE_SHADOW_SEL bit field of GEN3_RELATED_OFF
> +	 * determines data rate for which this equilization settings are

s/this/these/
s/equilization/equalization/

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

