Return-Path: <linux-pci+bounces-9532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 616AB91E94D
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 22:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807F51C20F83
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 20:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681B216F908;
	Mon,  1 Jul 2024 20:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaR7RtnY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EF916E883;
	Mon,  1 Jul 2024 20:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864893; cv=none; b=A3kVfqza28ufor7ZB3KfriJsZ7O23AVGt43uXlPyfiTzgU2F8lAXLKJ2LD03XWRoTv7VGzrG1/yTKYAoSU7Ei56uQciVLiK/4vgrAyvAUi3ZK+pLL/kn8qiVgR4npGeJuqmybHOmg4Tfh87o2gH7sAbgreWIGZjya+QINtSnCnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864893; c=relaxed/simple;
	bh=SA4K3xgEu/88eKSu6OgY1PEIsOG6R3VH6M5aRLz6n+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=peyUnJvcz8c+rGhJWCYtepQ6NE3xGU5UrAIuTofE82D5IZf0E7hsdntFyoktw8fxuzn3CrHhbpZlmCYDCIef+/uvIvC0tBzPNFgaX3ZJuO16SEBoPFRGkeTmntGI+5ZFPPsN6I0cbnnv5G0QXgG0gzqIaqSO7Ut+9PxuECbQ2z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaR7RtnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B98C32781;
	Mon,  1 Jul 2024 20:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719864892;
	bh=SA4K3xgEu/88eKSu6OgY1PEIsOG6R3VH6M5aRLz6n+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KaR7RtnYNxNIGvsbbKRlsmYfNqjhEOb7oZVFybEYiVvYrBmFiAQj9EvwCdQg9AS6a
	 eEFmRF7gugg5eLz0EXgxe04Q7FQfFYPrb84A5M/PO+nkGHVJuCA8feFsaAAj2GF7E5
	 jzaEPfpYQVrZ0Xt4xtK7J0hc4vwv7b55BYW4z2n+GSGnbrDvT4VZmJutL1uNcGaOwO
	 Nqu7i2wMtMRkdd7N5N9m64D/WprmPYkwJr4ySfC1NhV/ogsu8JyqrlBw8MaztcQbDt
	 oExQi2ifVFQEAvi24OimvhnHsVwDHezpZr/xHJOgLUlUe1Qi7QomoDnARjLU/E4YqL
	 MbMDPHjRbMWKw==
Date: Mon, 1 Jul 2024 15:14:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 6/7] pci: qcom: Add support for start_link() &
 stop_link()
Message-ID: <20240701201450.GA14795@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626-qps615-v1-6-2ade7bd91e02@quicinc.com>

On Wed, Jun 26, 2024 at 06:07:54PM +0530, Krishna chaitanya chundru wrote:
> In the stop_link() if the PCIe link is not up, disable LTSSM enable
> bit to stop link training otherwise keep the link in D3cold.

s/disable LTSSM enable bit/clear LTSSM enable bit/ ?

D3cold is a device state that could apply to a component on the other
end of the link but doesn't apply directly to the link itself, AFAIK.
I assume this would be L2 or L3 for the link.

I think this would be easier to understand if you describe it as "if
the link is up, do something; otherwise disable LTSSM" (similar
comment in the code below).

It would be helpful to explain *why* you want to do this.  So far this
basically transcribes the C code but doesn't explain the benefit.

> And in the start_link() the enable LTSSM bit if the resources are
> turned on other wise do the all the initialization and then start
> the link.
> 
> Introduce ltssm_disable function op to stop the link training.
> 
> Use a flag 'pci_pwrctl_turned_off" to indicate the resources are
> turned off by the pci pwrctl framework.

Match quote style (' vs ").

> If the link is stopped using the stop_link() then just return with
> doing anything in suspend and resume.

Add blank line before signed-off-by.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 108 +++++++++++++++++++++++++++++----
>  1 file changed, 97 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 14772edcf0d3..1ab3ffdb3914 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -37,6 +37,7 @@
>  /* PARF registers */
>  #define PARF_SYS_CTRL				0x00
>  #define PARF_PM_CTRL				0x20
> +#define PARF_PM_STTS				0x24
>  #define PARF_PCS_DEEMPH				0x34
>  #define PARF_PCS_SWING				0x38
>  #define PARF_PHY_CTRL				0x40
> @@ -83,6 +84,9 @@
>  /* PARF_PM_CTRL register fields */
>  #define REQ_NOT_ENTR_L1				BIT(5)
>  
> +/* PARF_PM_STTS register fields */
> +#define PM_ENTER_L23				BIT(5)
> +
>  /* PARF_PCS_DEEMPH register fields */
>  #define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		FIELD_PREP(GENMASK(21, 16), x)
>  #define PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(x)	FIELD_PREP(GENMASK(13, 8), x)
> @@ -126,6 +130,7 @@
>  
>  /* ELBI_SYS_CTRL register fields */
>  #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
> +#define ELBI_SYS_CTRL_PME_TURNOFF_MSG		BIT(4)
>  
>  /* AXI_MSTR_RESP_COMP_CTRL0 register fields */
>  #define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K	0x4
> @@ -228,6 +233,7 @@ struct qcom_pcie_ops {
>  	void (*host_post_init)(struct qcom_pcie *pcie);
>  	void (*deinit)(struct qcom_pcie *pcie);
>  	void (*ltssm_enable)(struct qcom_pcie *pcie);
> +	void (*ltssm_disable)(struct qcom_pcie *pcie);
>  	int (*config_sid)(struct qcom_pcie *pcie);
>  };
>  
> @@ -248,10 +254,13 @@ struct qcom_pcie {
>  	const struct qcom_pcie_cfg *cfg;
>  	struct dentry *debugfs;
>  	bool suspended;
> +	bool pci_pwrctl_turned_off;
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
>  
> +static void qcom_pcie_icc_update(struct qcom_pcie *pcie);
> +
>  static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
>  {
>  	gpiod_set_value_cansleep(pcie->reset, 1);
> @@ -266,17 +275,6 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
>  	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
>  }
>  
> -static int qcom_pcie_start_link(struct dw_pcie *pci)
> -{
> -	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> -
> -	/* Enable Link Training state machine */
> -	if (pcie->cfg->ops->ltssm_enable)
> -		pcie->cfg->ops->ltssm_enable(pcie);
> -
> -	return 0;
> -}
> -
>  static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
>  {
>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> @@ -556,6 +554,15 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> +static void qcom_pcie_2_3_2_ltssm_disable(struct qcom_pcie *pcie)
> +{
> +	u32 val;
> +
> +	val = readl(pcie->parf + PARF_LTSSM);
> +	val &= ~LTSSM_EN;
> +	writel(val, pcie->parf + PARF_LTSSM);
> +}
> +
>  static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
>  {
>  	u32 val;
> @@ -1336,6 +1343,7 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
>  	.post_init = qcom_pcie_post_init_2_7_0,
>  	.deinit = qcom_pcie_deinit_2_7_0,
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> +	.ltssm_disable = qcom_pcie_2_3_2_ltssm_disable,
>  };
>  
>  /* Qcom IP rev.: 1.9.0 */
> @@ -1346,6 +1354,7 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>  	.host_post_init = qcom_pcie_host_post_init_2_7_0,
>  	.deinit = qcom_pcie_deinit_2_7_0,
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> +	.ltssm_disable = qcom_pcie_2_3_2_ltssm_disable,
>  	.config_sid = qcom_pcie_config_sid_1_9_0,
>  };
>  
> @@ -1395,9 +1404,81 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
>  	.no_l0s = true,
>  };
>  
> +static int qcom_pcie_turnoff_link(struct dw_pcie *pci)
> +{
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +	u32 ret_l23, val, ret;
> +
> +	if (!dw_pcie_link_up(pcie->pci)) {
> +		if (pcie->cfg->ops->ltssm_disable)
> +			pcie->cfg->ops->ltssm_disable(pcie);
> +	} else {
> +		writel(ELBI_SYS_CTRL_PME_TURNOFF_MSG, pcie->elbi + ELBI_SYS_CTRL);
> +
> +		ret_l23 = readl_poll_timeout(pcie->parf + PARF_PM_STTS, val,
> +					     val & PM_ENTER_L23, 10000, 100000);
> +		if (ret_l23) {
> +			dev_err(pci->dev, "Failed to enter L2/L3\n");
> +			return -ETIMEDOUT;
> +		}
> +
> +		qcom_pcie_host_deinit(&pcie->pci->pp);
> +
> +		ret = icc_disable(pcie->icc_mem);
> +		if (ret)
> +			dev_err(pci->dev, "Failed to disable PCIe-MEM interconnect path: %d\n",
> +				ret);
> +
> +		pcie->pci_pwrctl_turned_off = true;
> +	}

Can you invert the condition?  It's always a pain to read a negated
condition:
  
  if (dw_pcie_link_up(pcie->pci)) {
    ...
  } else {
    if (pcie->cfg->ops->ltssm_disable)
      pcie->cfg->ops->ltssm_disable(pcie);
  }

Is there any race here between checking for link up and performing the
action?  Does anything bad happen if the link goes down after you do
the check but before you do the deinit?

> +	return 0;
> +}
> +
> +static int qcom_pcie_turnon_link(struct dw_pcie *pci)
> +{
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +
> +	if (pcie->pci_pwrctl_turned_off) {
> +		qcom_pcie_host_init(&pcie->pci->pp);
> +
> +		dw_pcie_setup_rc(&pcie->pci->pp);
> +	}
> +
> +	if (pcie->cfg->ops->ltssm_enable)
> +		pcie->cfg->ops->ltssm_enable(pcie);
> +
> +	/* Ignore the retval, the devices may come up later. */
> +	dw_pcie_wait_for_link(pcie->pci);
> +
> +	qcom_pcie_icc_update(pcie);
> +
> +	pcie->pci_pwrctl_turned_off = false;
> +
> +	return 0;
> +}
> +
> +static int qcom_pcie_start_link(struct dw_pcie *pci)
> +{
> +	return qcom_pcie_turnon_link(pci);
> +}
> +
> +static void qcom_pcie_stop_link(struct dw_pcie *pci)
> +{
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +
> +	if (!dw_pcie_link_up(pcie->pci))  {
> +		if (pcie->cfg->ops->ltssm_disable)
> +			pcie->cfg->ops->ltssm_disable(pcie);
> +	} else {
> +		qcom_pcie_turnoff_link(pci);
> +	}

I think this would be easier to read as:

  if (dw_pcie_link_up(pcie->pci)) {
    qcom_pcie_turnoff_link(pci);
  } else {
    if (pcie->cfg->ops->ltssm_disable)
      pcie->cfg->ops->ltssm_disable(pcie);
  }

> +}
> +
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = qcom_pcie_link_up,
>  	.start_link = qcom_pcie_start_link,
> +	.stop_link = qcom_pcie_stop_link,
>  };
>  
>  static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
> @@ -1604,6 +1685,8 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>  	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>  	int ret;
>  
> +	if (pcie->pci_pwrctl_turned_off)
> +		return 0;
>  	/*
>  	 * Set minimum bandwidth required to keep data path functional during
>  	 * suspend.
> @@ -1642,6 +1725,9 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>  	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>  	int ret;
>  
> +	if (pcie->pci_pwrctl_turned_off)
> +		return 0;
> +
>  	if (pcie->suspended) {
>  		ret = qcom_pcie_host_init(&pcie->pci->pp);
>  		if (ret)
> 
> -- 
> 2.42.0
> 

