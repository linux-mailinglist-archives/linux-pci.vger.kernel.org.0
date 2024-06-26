Return-Path: <linux-pci+bounces-9310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 331DF91844C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 16:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56BB31C23109
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 14:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2BD186E36;
	Wed, 26 Jun 2024 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRDCTMYN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6C3176FA5;
	Wed, 26 Jun 2024 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412372; cv=none; b=eSNuH46R1fkz2Whcn+hDheZoG1JIu5zFsDZOrAAK11cwFnrrH6AtLUZ9AQCTvnZJcPh2gkoHgQEYjHe53LZMVqXYMfhR3vsUi6YX5fAljRdacFO7/YHCWIYT2kzXG6GWJW7RAmg5Z9n/eeJnu17MKc8eu4pevvZIwIEDAnAVOp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412372; c=relaxed/simple;
	bh=3UAAGIdFQAKH63yiI3sjxjK8fwrSmEbZub1vx0sUm98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7qi9p/4UmjmAu/bYIlWO2zy4oJhu5REIZh80bEsg6jkVrqoqXobptu3a/l7GMJ4Uf3KZ5/nXpeDdB6iJ3Q3f1ftNM/2UqNQ4uFloOlsefIgwl0mUaZGPeHlT7GnkQ0l9MMIsQfJxIvyH5kdC4TSCUHlLdy7zj4bpYlYsnYC++A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRDCTMYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466CDC116B1;
	Wed, 26 Jun 2024 14:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719412372;
	bh=3UAAGIdFQAKH63yiI3sjxjK8fwrSmEbZub1vx0sUm98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oRDCTMYNgyDZgEHHPlz+iPqlM22zSaSIzJ9a5bZs3tK3NGkCyNKzSB4CfP1N4jygX
	 9y/rWt6QNj3/iPw1Fksd2hrhnbKpz7f8d6kU3VruLAjCqt99NCrGrCp6LK9ZkrmYgN
	 KDVxwHK/51CWoq2lJfbq3VNo/7d2bK8wMDL6MQGzNjPnpW+jB9kWcSPs+j5C9Y9sGc
	 K5L328oExf1BDyu5Ken4gj2dvQD/XadvT5pEcJoQdlKNnk4LtBqyIeJ1OscqwVP1Qg
	 WfJfVm2UoNTWEo+k43Z1PyjQxvF4He8zNTIQ9Fx311wCyq1HmLeH4nkOUVNV4zVajS
	 9tmY4mys+MOpQ==
Date: Wed, 26 Jun 2024 09:31:55 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Jingoo Han <jingoohan1@gmail.com>, quic_vbadigan@quicinc.com, quic_skananth@quicinc.com, 
	quic_nitegupt@quicinc.com, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 6/7] pci: qcom: Add support for start_link() &
 stop_link()
Message-ID: <wcxyba2xxpsfgffa5ds7ctgekt5fanp6udeivh3kf7x7pr6cw4@3i27f7etqqt3>
References: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
 <20240626-qps615-v1-6-2ade7bd91e02@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626-qps615-v1-6-2ade7bd91e02@quicinc.com>

On Wed, Jun 26, 2024 at 06:07:54PM GMT, Krishna chaitanya chundru wrote:

Please start your commit message with a description of the problem that
you're solving, then followed by the technical description of your
solution (which you have here).

Also, uppercase "PCI:" in your subject prefix.

> In the stop_link() if the PCIe link is not up, disable LTSSM enable
> bit to stop link training otherwise keep the link in D3cold.
> And in the start_link() the enable LTSSM bit if the resources are
> turned on other wise do the all the initialization and then start
> the link.
> 
> Introduce ltssm_disable function op to stop the link training.
> 
> Use a flag 'pci_pwrctl_turned_off" to indicate the resources are
> turned off by the pci pwrctl framework.
> 
> If the link is stopped using the stop_link() then just return with
> doing anything in suspend and resume.

And an empty line between commit message and the tags.

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
> +
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

If you inline qcom_pcie_turnon_link() here, you don't need to have two
different words for "start"/"turnon".

> +}
> +
> +static void qcom_pcie_stop_link(struct dw_pcie *pci)
> +{
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +
> +	if (!dw_pcie_link_up(pcie->pci))  {

Unless I'm reading it wrong, qcom_pcie_turnoff_link() has exactly the
same prologue, so you should be able to just inline
qcom_pcie_turnoff_link() in this function and avoid the "stop"/"turnoff"
naming.

> +		if (pcie->cfg->ops->ltssm_disable)
> +			pcie->cfg->ops->ltssm_disable(pcie);
> +	} else {
> +		qcom_pcie_turnoff_link(pci);
> +	}
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

This deserves a comment.

> +	if (pcie->pci_pwrctl_turned_off)
> +		return 0;
>  	/*
>  	 * Set minimum bandwidth required to keep data path functional during
>  	 * suspend.
> @@ -1642,6 +1725,9 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>  	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>  	int ret;
>  

Ditto.

> +	if (pcie->pci_pwrctl_turned_off)
> +		return 0;
> +

Regards,
Bjorn

>  	if (pcie->suspended) {
>  		ret = qcom_pcie_host_init(&pcie->pci->pp);
>  		if (ret)
> 
> -- 
> 2.42.0
> 

