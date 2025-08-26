Return-Path: <linux-pci+bounces-34766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 887F6B3702B
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 18:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47CF516D4FA
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 16:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF812F6597;
	Tue, 26 Aug 2025 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM7d+4rl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC82C3278;
	Tue, 26 Aug 2025 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225524; cv=none; b=m9Zffixz1V2XY0/sJ+3kUtayjRiv+FSOiJ5s3NIUuhXdOqwvLE4enJaxGJr720zfSNBxBTVcnw24ekuGKcIClIGf54pUpZNgaJLCvSzbYNpaAJ0KiapSm9n49MJAY12X7FKFPPJMaTdUFjASI4POMFeyVOzIqn7plmyIqTK724U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225524; c=relaxed/simple;
	bh=Q6IHYAMgei2pEyNfmCbLP4K8NmP9Ho6aNvuLdeoEVXU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EQsjynN4CCKMke8ZsMzOu0LMhsrwpHlOyzRecRdDBv288I24+VVvcX9EHvT3dInYSamxAE4xubAZ+nu6BXbEGogVvyE066ElCdptNY1lkfQQgByqTPAl22gTRmtp6o6rwjsgBu3FzOKMYfdusSrFh1vWSvNezaCUM1cQIGVHYZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM7d+4rl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2D4C4CEF1;
	Tue, 26 Aug 2025 16:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756225523;
	bh=Q6IHYAMgei2pEyNfmCbLP4K8NmP9Ho6aNvuLdeoEVXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aM7d+4rl6vYiELbgEEZ4eolEksgc7jUn+xSN6tqdc7+YRA3jIhHLy9jv7uGh9cnOw
	 zE5+2Y+ZesxPlMXjDitNAGXEQeuLFw8T3h5ExNngBmQizdaUXJAUJ0i+MrhoWxUNhm
	 xeHbCXD4UkzGtV6HMQWXVxxXUXSyErPLfRP8qU0CwSGx4g3V0sjrgU4vxDUp/t6eYz
	 PIeKwox6onrZjenLCdAQy/fZNMgLOteWlbu3DWvBQHgTX/gFJN9shyzojUAwrFTJAo
	 UGdpe9W6DSvFbExHjaEw/W0AXI/zAKbdI/KZ22SPNrkLz02E17AWYL6ncnqo7qNFeL
	 WOfrNo8OhzDPA==
Date: Tue, 26 Aug 2025 11:25:22 -0500
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
Subject: Re: [PATCH v1 1/2] PCI: dwc: histb: Simplify clock handling by using
 clk_bulk*() functions
Message-ID: <20250826162522.GA838733@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826114245.112472-2-linux.amoon@gmail.com>

In subject, remove "dwc: " to follow historical convention.  (See
"git log --oneline")

On Tue, Aug 26, 2025 at 05:12:40PM +0530, Anand Moon wrote:
> Currently, the driver acquires clocks and prepare/enable/disable/unprepare
> the clocks individually thereby making the driver complex to read.
> 
> The driver can be simplified by using the clk_bulk*() APIs.
> 
> Use:
>   - devm_clk_bulk_get_all() API to acquire all the clocks
>   - clk_bulk_prepare_enable() to prepare/enable clocks
>   - clk_bulk_disable_unprepare() APIs to disable/unprepare them in bulk

I assume this means the order in which we prepare/enable and
disable/unprepare will now depend on the order the clocks appear in
the device tree instead of the order in the code?  If so, please
mention that here and verify that all upstream device trees have the
correct order.

> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-histb.c | 70 ++++---------------------
>  1 file changed, 11 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
> index a52071589377..4022349e85d2 100644
> --- a/drivers/pci/controller/dwc/pcie-histb.c
> +++ b/drivers/pci/controller/dwc/pcie-histb.c
> @@ -51,10 +51,8 @@
>  
>  struct histb_pcie {
>  	struct dw_pcie *pci;
> -	struct clk *aux_clk;
> -	struct clk *pipe_clk;
> -	struct clk *sys_clk;
> -	struct clk *bus_clk;
> +	struct  clk_bulk_data *clks;
> +	int     num_clks;
>  	struct phy *phy;
>  	struct reset_control *soft_reset;
>  	struct reset_control *sys_reset;
> @@ -204,10 +202,7 @@ static void histb_pcie_host_disable(struct histb_pcie *hipcie)
>  	reset_control_assert(hipcie->sys_reset);
>  	reset_control_assert(hipcie->bus_reset);
>  
> -	clk_disable_unprepare(hipcie->aux_clk);
> -	clk_disable_unprepare(hipcie->pipe_clk);
> -	clk_disable_unprepare(hipcie->sys_clk);
> -	clk_disable_unprepare(hipcie->bus_clk);
> +	clk_bulk_disable_unprepare(hipcie->num_clks, hipcie->clks);
>  
>  	if (hipcie->reset_gpio)
>  		gpiod_set_value_cansleep(hipcie->reset_gpio, 1);
> @@ -235,28 +230,10 @@ static int histb_pcie_host_enable(struct dw_pcie_rp *pp)
>  	if (hipcie->reset_gpio)
>  		gpiod_set_value_cansleep(hipcie->reset_gpio, 0);
>  
> -	ret = clk_prepare_enable(hipcie->bus_clk);
> +	ret = clk_bulk_prepare_enable(hipcie->num_clks, hipcie->clks);
>  	if (ret) {
> -		dev_err(dev, "cannot prepare/enable bus clk\n");
> -		goto err_bus_clk;
> -	}
> -
> -	ret = clk_prepare_enable(hipcie->sys_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable sys clk\n");
> -		goto err_sys_clk;
> -	}
> -
> -	ret = clk_prepare_enable(hipcie->pipe_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable pipe clk\n");
> -		goto err_pipe_clk;
> -	}
> -
> -	ret = clk_prepare_enable(hipcie->aux_clk);
> -	if (ret) {
> -		dev_err(dev, "cannot prepare/enable aux clk\n");
> -		goto err_aux_clk;
> +		ret = dev_err_probe(dev, ret, "failed to enable clocks\n");
> +		goto reg_dis;
>  	}
>  
>  	reset_control_assert(hipcie->soft_reset);
> @@ -270,13 +247,7 @@ static int histb_pcie_host_enable(struct dw_pcie_rp *pp)
>  
>  	return 0;
>  
> -err_aux_clk:
> -	clk_disable_unprepare(hipcie->pipe_clk);
> -err_pipe_clk:
> -	clk_disable_unprepare(hipcie->sys_clk);
> -err_sys_clk:
> -	clk_disable_unprepare(hipcie->bus_clk);
> -err_bus_clk:
> +reg_dis:
>  	if (hipcie->vpcie)
>  		regulator_disable(hipcie->vpcie);
>  
> @@ -345,29 +316,10 @@ static int histb_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	hipcie->aux_clk = devm_clk_get(dev, "aux");
> -	if (IS_ERR(hipcie->aux_clk)) {
> -		dev_err(dev, "Failed to get PCIe aux clk\n");
> -		return PTR_ERR(hipcie->aux_clk);
> -	}
> -
> -	hipcie->pipe_clk = devm_clk_get(dev, "pipe");
> -	if (IS_ERR(hipcie->pipe_clk)) {
> -		dev_err(dev, "Failed to get PCIe pipe clk\n");
> -		return PTR_ERR(hipcie->pipe_clk);
> -	}
> -
> -	hipcie->sys_clk = devm_clk_get(dev, "sys");
> -	if (IS_ERR(hipcie->sys_clk)) {
> -		dev_err(dev, "Failed to get PCIEe sys clk\n");
> -		return PTR_ERR(hipcie->sys_clk);
> -	}
> -
> -	hipcie->bus_clk = devm_clk_get(dev, "bus");
> -	if (IS_ERR(hipcie->bus_clk)) {
> -		dev_err(dev, "Failed to get PCIe bus clk\n");
> -		return PTR_ERR(hipcie->bus_clk);
> -	}
> +	hipcie->num_clks = devm_clk_bulk_get_all(dev, &hipcie->clks);
> +	if (hipcie->num_clks < 0)
> +		return dev_err_probe(dev, hipcie->num_clks,
> +				     "failed to get clocks\n");
>  
>  	hipcie->soft_reset = devm_reset_control_get(dev, "soft");
>  	if (IS_ERR(hipcie->soft_reset)) {
> -- 
> 2.50.1
> 

