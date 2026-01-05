Return-Path: <linux-pci+bounces-43979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B244CF212D
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 07:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8CE9300F598
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 06:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210CF326D4B;
	Mon,  5 Jan 2026 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEfPc4q3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD75E326927;
	Mon,  5 Jan 2026 06:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767594592; cv=none; b=Jo3kOXiB3xaldzAIajq+jZzXtMqZk6CuIoRpOQ0qIciekSRmweyJHzOaVk5PJ/r27n7Uwf818GN41+xkJCykVpm/9tZz/6+8S0NQpu2PhvKRP8yl3z5iTtiMVWEfnVlX84Xe6fkSkv0SIH3xPX7ms05Kz901R+6S+TDX4tV1Lbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767594592; c=relaxed/simple;
	bh=2gaDkqy2T86GObQGacewNI2r2Emjs+HEGyA+dr4/2dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpPQWZWy39+Rdl/HWCZm2xE8YqlsbF5nc/VS0uAqIvMl2HznYClBbrvHHUV6mxgNRApHtpS5Y5W1M9vyDpReIs8z+xU8W5LbbpYpK5Nfghl+H4X45HRIO1jxBktqdusO7vC9tPQ/ENqsW0Nslh5nRk7MBlOaZ/MVpk0q71oCLko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEfPc4q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F07C116D0;
	Mon,  5 Jan 2026 06:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767594591;
	bh=2gaDkqy2T86GObQGacewNI2r2Emjs+HEGyA+dr4/2dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jEfPc4q37oKwhywX+bx57fo48mCJOMuHHu5NyukOLVJtYzDv/nqUVurBs/Fm7MSt7
	 Dkt5XvssScu3gC5DXTjk98YhsbgwW2iHWKG0yPffCsPIOINWEnJPq9mgV3pbvlRBlS
	 1OxCGtKBPIiYiXLudPFLHzas7okGBJ7Ymw64A9jo1yCqoYXAUqcitTKqBxPkSXk8s5
	 3k/wB0itoQT4T7cQUZelU53Vdm0VXULiqLgy+Ca3PY8TSMxxQTTi5dN8gBCQ93/JXe
	 +nBN1WdSInF+pCj2g5ys3tULshMcM6ZyeWAz3inBMw1nXfICAL4gzJwDQH/1yeUwVV
	 GgJ8SMkhmlS2w==
Date: Mon, 5 Jan 2026 11:59:40 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	quic_vbadigan@quicinc.com, quic_shazhuss@quicinc.com, konrad.dybcio@oss.qualcomm.com, 
	Rama Krishna <quic_ramkri@quicinc.com>, Ayiluri Naga Rashmi <quic_nayiluri@quicinc.com>, 
	Nitesh Gupta <quic_nitegupt@quicinc.com>
Subject: Re: [PATCH v4 2/2] PCI: qcom-ep: Add support for firmware-managed
 PCIe Endpoint
Message-ID: <5hnd2wwkbairm36ml7l6sqj2gmm7aonyv7iadbtjm6ew266jd2@fp7f7usc7vmt>
References: <20251223-firmware_managed_ep-v4-0-7f7c1b83d679@oss.qualcomm.com>
 <20251223-firmware_managed_ep-v4-2-7f7c1b83d679@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251223-firmware_managed_ep-v4-2-7f7c1b83d679@oss.qualcomm.com>

On Tue, Dec 23, 2025 at 02:46:21PM +0530, Mrinmay Sarkar wrote:
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
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 82 +++++++++++++++++++++++--------
>  1 file changed, 62 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index f1bc0ac81a928b928ab3f8cc7bf82558fc430474..3c7c2dc49f928514930f304421197435f391d88b 100644
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
> @@ -377,10 +379,17 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
>  
>  static void qcom_pcie_disable_resources(struct qcom_pcie_ep *pcie_ep)
>  {
> -	icc_set_bw(pcie_ep->icc_mem, 0, 0);
> -	phy_power_off(pcie_ep->phy);
> -	phy_exit(pcie_ep->phy);
> -	clk_bulk_disable_unprepare(pcie_ep->num_clks, pcie_ep->clks);
> +	struct device *dev = pcie_ep->pci.dev;
> +	int ret;
> +
> +	pm_runtime_put(dev);
> +

I'd prefer to have the goto to skip the resource handling if 'firmware_managed'
flag is set:

	if (pcie_ep->cfg && pcie_ep->cfg->firmware_managed)
		return;

> +	if (!(pcie_ep->cfg && pcie_ep->cfg->firmware_managed)) {
> +		icc_set_bw(pcie_ep->icc_mem, 0, 0);
> +		phy_power_off(pcie_ep->phy);
> +		phy_exit(pcie_ep->phy);
> +		clk_bulk_disable_unprepare(pcie_ep->num_clks, pcie_ep->clks);
> +	}
>  }
>  
>  static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
> @@ -390,12 +399,22 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>  	u32 val, offset;
>  	int ret;
>  
> -	ret = qcom_pcie_enable_resources(pcie_ep);
> -	if (ret) {
> -		dev_err(dev, "Failed to enable resources: %d\n", ret);
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable endpoint device: %d\n", ret);
>  		return ret;
>  	}
>  
> +	/* Enable resources if Endpoint controller is not firmware-managed */

Same here:

	if (pcie_ep->cfg && pcie_ep->cfg->firmware_managed)
		goto skip_resources_enable;

> +	if (!(pcie_ep->cfg && pcie_ep->cfg->firmware_managed)) {
> +		ret = qcom_pcie_enable_resources(pcie_ep);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable resources: %d\n", ret);
> +			pm_runtime_put(dev);
> +			return ret;
> +		}
> +	}
> +

skip_resources_enable:

>  	/* Perform cleanup that requires refclk */
>  	pci_epc_deinit_notify(pci->ep.epc);
>  	dw_pcie_ep_cleanup(&pci->ep);
> @@ -630,16 +649,6 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
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
> @@ -652,9 +661,22 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
>  	if (IS_ERR(pcie_ep->phy))
>  		ret = PTR_ERR(pcie_ep->phy);

Though this is an optional resource, I'd prefer to wrap it under
'firmware_managed' so that it will be clear that PHY is not needed in firmware
managed solution.

>  
> -	pcie_ep->icc_mem = devm_of_icc_get(dev, "pcie-mem");
> -	if (IS_ERR(pcie_ep->icc_mem))
> -		ret = PTR_ERR(pcie_ep->icc_mem);
> +	/* Populate resources if Endpoint controller is not firmware-managed */

	if (pcie_ep->cfg && pcie_ep->cfg->firmware_managed)
		return 0;

- Mani

-- 
மணிவண்ணன் சதாசிவம்

