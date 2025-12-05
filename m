Return-Path: <linux-pci+bounces-42705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE63CA9514
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 21:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C0AD301DACE
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 20:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A892DECCC;
	Fri,  5 Dec 2025 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bP3edzYU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9B1227B8E;
	Fri,  5 Dec 2025 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764968256; cv=none; b=bvGqj393ZW7+qMYKns2xx1ZTxyoV70qQDa9ytLtq6onulKnoBtKin2Sb9ql/GEPG/fVFjJRvWC/7Jdzgr8hJKmVTc15eE7+Hq1LaPRnx3MIj9VaMzoBryfisjjNvDVuaTHPVP80w0F2qMc6RLAp1tUMgZv7DuQsELJ8Eqiycdmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764968256; c=relaxed/simple;
	bh=bx2JTShoFLV64IMikUYvle59aqV9I4K4iIXUVq0wCiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvbHiqCEhDEICuPdiLRMeSnL22kRHZVfWNwRDunN3qI2EYWaSXchW2G2NhasjbXipchjo6QfItu+STaWAVzMPFG8jmHxdfHCjbXDgl4pJdbBfLd0UgdI+6ttdHh+FVJVwbfaBxYMxSXzUMMo8xCKgThdrCleWQfnJ+O2GvIrnPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bP3edzYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2F6C4CEF1;
	Fri,  5 Dec 2025 20:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764968256;
	bh=bx2JTShoFLV64IMikUYvle59aqV9I4K4iIXUVq0wCiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bP3edzYUtah8OuV+Bp4GunSNWLr+MfM/ERdCwXFyftgxW7TNRwtDsXAmPtVF91Jv8
	 ixT0ottkt7E1wIlMAsj6rOz2BYx+uyofbY9L4v71fBGKeKNnssomzzjzCz1nhga2V5
	 ok12wOweu0ewB5Gy4QPxETeNiC3W95Zau08NvJ1ENdZ27WhhSbnv5XAmr/A9qNR73U
	 qtY4wpoQiW3L3Dn7uHaAdNtAn7zK/bhaWq0SQMQHZEELOt2HB00+Nq/9Y4RV818NOM
	 jK0L/KDYmCzQe6KL0eAKLkmvnv4JclgssYEXRXuqG1kgagmISqltrUeNP6s7pMmdu2
	 Sb40VZpNg7lQA==
Date: Fri, 5 Dec 2025 15:03:53 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	quic_vbadigan@quicinc.com, quic_shazhuss@quicinc.com, konrad.dybcio@oss.qualcomm.com, 
	Rama Krishna <quic_ramkri@quicinc.com>, Ayiluri Naga Rashmi <quic_nayiluri@quicinc.com>, 
	Nitesh Gupta <quic_nitegupt@quicinc.com>
Subject: Re: [PATCH 2/2] PCI: qcom-ep: Add support for firmware-managed PCIe
 Endpoint
Message-ID: <gpheliezabdbqpip2d4opfsu7zdfvltifrovtf3dz5bri4vefu@cuklytg4t6if>
References: <20251203-firmware_managed_ep-v1-0-295977600fa5@oss.qualcomm.com>
 <20251203-firmware_managed_ep-v1-2-295977600fa5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203-firmware_managed_ep-v1-2-295977600fa5@oss.qualcomm.com>

On Wed, Dec 03, 2025 at 06:56:48PM +0530, Mrinmay Sarkar wrote:
> Some Qualcomm platforms use firmware to manage PCIe resources such as
> clocks, resets, and PHY through the SCMI interface. In these cases,
> the Linux driver should not perform resource enable or disable
> operations directly. Additionally, runtime PM support has been enabled
> to ensure proper power state transitions.
> 
> This commit introduces a `firmware_managed` flag in the Endpoint
> configuration structure. When set, the driver skips resource handling
> and uses generic runtime PM calls to let firmware do resource management.
> 
> A new compatible string is added for SA8255P platforms where firmware
> manages resources.
> 
> Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 80 ++++++++++++++++++++++++-------
>  1 file changed, 64 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index f1bc0ac81a928b928ab3f8cc7bf82558fc430474..38358c9fa7ab32fd36efcea0a42c52f1f86a523a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -168,11 +168,13 @@ enum qcom_pcie_ep_link_status {
>   * @hdma_support: HDMA support on this SoC
>   * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache snooping
>   * @disable_mhi_ram_parity_check: Disable MHI RAM data parity error check
> + * @firmware_managed: Set if the Endpoint controller is firmware managed
>   */
>  struct qcom_pcie_ep_cfg {
>  	bool hdma_support;
>  	bool override_no_snoop;
>  	bool disable_mhi_ram_parity_check;
> +	bool firmware_managed;
>  };
>  
>  /**
> @@ -377,6 +379,15 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
>  
>  static void qcom_pcie_disable_resources(struct qcom_pcie_ep *pcie_ep)
>  {
> +	struct device *dev = pcie_ep->pci.dev;
> +	int ret;
> +
> +	ret = pm_runtime_put_sync(dev);

What's the benefit of waiting for the put to finish? (i.e. why _sync)

> +	if (ret < 0) {
> +		dev_err(dev, "Failed to disable endpoint device: %d\n", ret);
> +		return;

For some reason the pm_runtime_put_sync() failed, so the device's state
is going to remain active. But you prevented the resources below from
being disabled - without returning an error, so nobody knows.

So now the phy refcount etc will be wrong.

> +	}
> +
>  	icc_set_bw(pcie_ep->icc_mem, 0, 0);
>  	phy_power_off(pcie_ep->phy);
>  	phy_exit(pcie_ep->phy);
> @@ -390,12 +401,22 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>  	u32 val, offset;
>  	int ret;
>  
> -	ret = qcom_pcie_enable_resources(pcie_ep);
> -	if (ret) {
> -		dev_err(dev, "Failed to enable resources: %d\n", ret);
> +	ret = pm_runtime_get_sync(dev);

You're missing necessary error handling for pm_runtime_get_sync(), use
pm_runtime_resume_and_get() instead.

> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable endpoint device: %d\n", ret);
>  		return ret;
>  	}
>  
> +	/* Enable resources if Endpoint controller is not firmware-managed */
> +	if (!(pcie_ep->cfg && pcie_ep->cfg->firmware_managed)) {
> +		ret = qcom_pcie_enable_resources(pcie_ep);

Now that you're moving the driver to adequately get and put the RPM
state, can't you move the explicit resource management to pm_ops as
well?

> +		if (ret) {
> +			dev_err(dev, "Failed to enable resources: %d\n", ret);
> +			pm_runtime_put_sync(dev);
> +			return ret;
> +		}
> +	}
> +
>  	/* Perform cleanup that requires refclk */
>  	pci_epc_deinit_notify(pci->ep.epc);
>  	dw_pcie_ep_cleanup(&pci->ep);
> @@ -630,16 +651,6 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
>  		return ret;
>  	}
>  
> -	pcie_ep->num_clks = devm_clk_bulk_get_all(dev, &pcie_ep->clks);
> -	if (pcie_ep->num_clks < 0) {
> -		dev_err(dev, "Failed to get clocks\n");
> -		return pcie_ep->num_clks;
> -	}
> -
> -	pcie_ep->core_reset = devm_reset_control_get_exclusive(dev, "core");
> -	if (IS_ERR(pcie_ep->core_reset))
> -		return PTR_ERR(pcie_ep->core_reset);
> -
>  	pcie_ep->reset = devm_gpiod_get(dev, "reset", GPIOD_IN);
>  	if (IS_ERR(pcie_ep->reset))
>  		return PTR_ERR(pcie_ep->reset);
> @@ -652,9 +663,22 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
>  	if (IS_ERR(pcie_ep->phy))
>  		ret = PTR_ERR(pcie_ep->phy);
>  
> -	pcie_ep->icc_mem = devm_of_icc_get(dev, "pcie-mem");
> -	if (IS_ERR(pcie_ep->icc_mem))
> -		ret = PTR_ERR(pcie_ep->icc_mem);
> +	/* Populate resources if Endpoint controller is not firmware-managed */
> +	if (!(pcie_ep->cfg && pcie_ep->cfg->firmware_managed)) {
> +		pcie_ep->num_clks = devm_clk_bulk_get_all(dev, &pcie_ep->clks);
> +		if (pcie_ep->num_clks < 0) {
> +			dev_err(dev, "Failed to get clocks\n");
> +			return pcie_ep->num_clks;
> +		}
> +
> +		pcie_ep->core_reset = devm_reset_control_get_exclusive(dev, "core");
> +		if (IS_ERR(pcie_ep->core_reset))
> +			return PTR_ERR(pcie_ep->core_reset);
> +
> +		pcie_ep->icc_mem = devm_of_icc_get(dev, "pcie-mem");
> +		if (IS_ERR(pcie_ep->icc_mem))
> +			ret = PTR_ERR(pcie_ep->icc_mem);
> +	}
>  
>  	return ret;
>  }
> @@ -874,6 +898,16 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pcie_ep);
>  
> +	pm_runtime_set_active(dev);
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;
> +	ret = pm_runtime_get_sync(dev);

As the device is already active, this will just bump the reference count
and return. I think the correct way to write this is:

pm_runtime_get_noresume(dev);
pm_runtime_set_active(dev);
pm_runtime_enable(dev);


But to handle the non-fw-managed case, you probably want to just remove
the pm_runtime_set_active() and keep the get_sync(), to allow the
resources to be turned on, thus would though have to happen after you
acquire the resources below.

> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable endpoint device: %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret = qcom_pcie_ep_get_resources(pdev, pcie_ep);
>  	if (ret)
>  		return ret;
> @@ -897,6 +931,12 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
>  	pcie_ep->debugfs = debugfs_create_dir(name, NULL);
>  	qcom_pcie_ep_init_debugfs(pcie_ep);

This was last, because we don't care about failures. But now that you're
adding a source of errors below, you need to remove these entries again
if below fails (or keep the debugfs creation last).

>  
> +	ret = pm_runtime_put_sync(dev);
> +	if (ret < 0) {

I don't think this is adequately error handled.

Regards,
Bjorn

> +		dev_err(dev, "Failed to disable endpoint device: %d\n", ret);
> +		goto err_disable_irqs;
> +	}
> +
>  	return 0;
>  
>  err_disable_irqs:
> @@ -930,7 +970,15 @@ static const struct qcom_pcie_ep_cfg cfg_1_34_0 = {
>  	.disable_mhi_ram_parity_check = true,
>  };
>  
> +static const struct qcom_pcie_ep_cfg cfg_1_34_0_fw_managed = {
> +	.hdma_support = true,
> +	.override_no_snoop = true,
> +	.disable_mhi_ram_parity_check = true,
> +	.firmware_managed = true,
> +};
> +
>  static const struct of_device_id qcom_pcie_ep_match[] = {
> +	{ .compatible = "qcom,sa8255p-pcie-ep", .data = &cfg_1_34_0_fw_managed},
>  	{ .compatible = "qcom,sa8775p-pcie-ep", .data = &cfg_1_34_0},
>  	{ .compatible = "qcom,sdx55-pcie-ep", },
>  	{ .compatible = "qcom,sm8450-pcie-ep", },
> 
> -- 
> 2.25.1
> 
> 

