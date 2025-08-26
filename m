Return-Path: <linux-pci+bounces-34767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F57BB3702F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 18:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32977175FA2
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 16:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D732D193F;
	Tue, 26 Aug 2025 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIQ+0JeX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF431A549;
	Tue, 26 Aug 2025 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225547; cv=none; b=REFoLBel9A/QaA/httfatTkqntplv0A3q8iku3DkPcuUMiO4x4fNNJ1UBtSrfsIG5/7aLndQJX6N9exuOnEZqYII1WvIbTGTW3u2m0yFunQzOdwMQciEe8b3bLDN0a3HmAAz5vIG2iGGrzq7VIf+lEMXFhUDjb2WHgdtpvTlDME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225547; c=relaxed/simple;
	bh=6p4cz0ix5dRIu3nFwc9VukD3osiS+0ZpM0zne6Vik3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LRAIQirLPqRumlDwXndPEcCWpnG52MRLl/e0kstnUVqgNSyDU4ZPlvh0mExWjInTVytbdv+EAZQ0NlWIWYtLylzmQDV7WvyFVp9Oy5yIIlPRU0i0JGtGCiDndovLGyuunWDfDhN4CM1El4oUyYtRZN16akMdDVAZIrhX8tERH8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIQ+0JeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D2FC4CEF1;
	Tue, 26 Aug 2025 16:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756225547;
	bh=6p4cz0ix5dRIu3nFwc9VukD3osiS+0ZpM0zne6Vik3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rIQ+0JeXNt40S46UVDEq+IB8tp28HGbTf8X1NA3/Vt0EY3KC7DW8VOEhzGSflMr1q
	 83bgvH9S877VPeEt3+N+iSqY5oD2XlpQ5scHj02UVPmhWxX8q/b2fNQ41c2WDUIDDE
	 0WwHSsaE/boFVCjgF32bScY8WXjrE6a6HGKd4UJlJV/McTj8wQ5Rzf46qKDn6vbeP4
	 I7whLpuRkCHOTuG6su2WvrsuXteX7COWaDQZBpdq9jRCK+YkVTv2LmbgF10oiUrp7P
	 FEkyjKlzjCXHU01QKk8DdW0wNLi/Rv6RoDt4TLBLCl300rOXv8VFI3M67Rb3+yuC5+
	 kr/ceQjBSmaFw==
Date: Tue, 26 Aug 2025 11:25:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"open list:PCIE DRIVER FOR HISILICON STB" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] PCI: dwc: histb: Simplify reset control handling
 by using reset_control_bulk*() function
Message-ID: <20250826162545.GA838376@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826114245.112472-3-linux.amoon@gmail.com>

In subject, remove "dwc: " to follow historical convention.

On Tue, Aug 26, 2025 at 05:12:41PM +0530, Anand Moon wrote:
> Currently, the driver acquires and asserts/deasserts the resets
> individually thereby making the driver complex to read.
> 
> This can be simplified by using the reset_control_bulk() APIs.
> 
> Use devm_reset_control_bulk_get_exclusive() API to acquire all the resets
> and use reset_control_bulk_{assert/deassert}() APIs to assert/deassert them
> in bulk.

Please include a note that this changes the order of reset assert and
deassert and explain why this is safe.

> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-histb.c | 57 ++++++++++++-------------
>  1 file changed, 28 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
> index 4022349e85d2..4ba5c9af63a0 100644
> --- a/drivers/pci/controller/dwc/pcie-histb.c
> +++ b/drivers/pci/controller/dwc/pcie-histb.c
> @@ -49,14 +49,20 @@
>  #define PCIE_LTSSM_STATE_MASK		GENMASK(5, 0)
>  #define PCIE_LTSSM_STATE_ACTIVE		0x11
>  
> +#define PCIE_HISTB_NUM_RESETS   ARRAY_SIZE(histb_pci_rsts)
> +
> +static const char * const histb_pci_rsts[] = {
> +	"soft",
> +	"sys",
> +	"bus",
> +};
> +
>  struct histb_pcie {
>  	struct dw_pcie *pci;
>  	struct  clk_bulk_data *clks;
>  	int     num_clks;
>  	struct phy *phy;
> -	struct reset_control *soft_reset;
> -	struct reset_control *sys_reset;
> -	struct reset_control *bus_reset;
> +	struct  reset_control_bulk_data reset[PCIE_HISTB_NUM_RESETS];
>  	void __iomem *ctrl;
>  	struct gpio_desc *reset_gpio;
>  	struct regulator *vpcie;
> @@ -198,9 +204,8 @@ static const struct dw_pcie_host_ops histb_pcie_host_ops = {
>  
>  static void histb_pcie_host_disable(struct histb_pcie *hipcie)
>  {
> -	reset_control_assert(hipcie->soft_reset);
> -	reset_control_assert(hipcie->sys_reset);
> -	reset_control_assert(hipcie->bus_reset);
> +	reset_control_bulk_assert(PCIE_HISTB_NUM_RESETS,
> +				  hipcie->reset);
>  
>  	clk_bulk_disable_unprepare(hipcie->num_clks, hipcie->clks);
>  
> @@ -236,14 +241,19 @@ static int histb_pcie_host_enable(struct dw_pcie_rp *pp)
>  		goto reg_dis;
>  	}
>  
> -	reset_control_assert(hipcie->soft_reset);
> -	reset_control_deassert(hipcie->soft_reset);
> -
> -	reset_control_assert(hipcie->sys_reset);
> -	reset_control_deassert(hipcie->sys_reset);
> +	ret = reset_control_bulk_assert(PCIE_HISTB_NUM_RESETS,
> +					hipcie->reset);
> +	if (ret) {
> +		dev_err(dev, "Couldn't assert reset %d\n", ret);
> +		goto reg_dis;
> +	}
>  
> -	reset_control_assert(hipcie->bus_reset);
> -	reset_control_deassert(hipcie->bus_reset);
> +	ret = reset_control_bulk_deassert(PCIE_HISTB_NUM_RESETS,
> +					  hipcie->reset);
> +	if (ret) {
> +		dev_err(dev, "Couldn't dessert reset %d\n", ret);

s/dessert/deassert/

> +		goto reg_dis;
> +	}
>  
>  	return 0;
>  
> @@ -321,23 +331,12 @@ static int histb_pcie_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, hipcie->num_clks,
>  				     "failed to get clocks\n");
>  
> -	hipcie->soft_reset = devm_reset_control_get(dev, "soft");
> -	if (IS_ERR(hipcie->soft_reset)) {
> -		dev_err(dev, "couldn't get soft reset\n");
> -		return PTR_ERR(hipcie->soft_reset);
> -	}
> +	ret = devm_reset_control_bulk_get_exclusive(dev,
> +						    PCIE_HISTB_NUM_RESETS,
> +						    hipcie->reset);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Cannot get the Core resets\n");
>  
> -	hipcie->sys_reset = devm_reset_control_get(dev, "sys");
> -	if (IS_ERR(hipcie->sys_reset)) {
> -		dev_err(dev, "couldn't get sys reset\n");
> -		return PTR_ERR(hipcie->sys_reset);
> -	}
> -
> -	hipcie->bus_reset = devm_reset_control_get(dev, "bus");
> -	if (IS_ERR(hipcie->bus_reset)) {
> -		dev_err(dev, "couldn't get bus reset\n");
> -		return PTR_ERR(hipcie->bus_reset);
> -	}
>  
>  	hipcie->phy = devm_phy_get(dev, "phy");
>  	if (IS_ERR(hipcie->phy)) {
> -- 
> 2.50.1
> 

