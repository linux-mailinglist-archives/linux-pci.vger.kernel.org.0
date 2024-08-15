Return-Path: <linux-pci+bounces-11711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A48E9539C3
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 20:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAFC1C22E39
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 18:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA83433DC;
	Thu, 15 Aug 2024 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2l9P9cP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2239633997;
	Thu, 15 Aug 2024 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723745760; cv=none; b=tTCK05wj9t9ZojbeYq2HyLtAnhUsanWkAYbaD2a0+9brJdF/oCpyVoeBpJ2fstOIvJ1FuhsO9pyB57y/lfbpbZv/gbc0Z0zr1qGEghC5CwlfcK56lB2cBGcGPqTwkklzhIqkhlO85LXX3ZCUWRxkp0swjw0exKIMR6ewMY4P8Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723745760; c=relaxed/simple;
	bh=2MNPIO7/BsrHVWhKfMTW5gZOAAi9d4M5QEiENXiylzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a1WJb0EPHZ2xX7OD2M5tilfeZ5USHL8FAO8efJa2Di2ipmDzRQaYw4I0209nyyELhTV4LZMS5t/QHpAwZDEnd5gkY4jokueNIQ0kHMMA307aW3w9n51zBi97kVNPb2MweJ2wXwGfLgAHVg42tT/YxXOb7HVMfpX4oAsvAuOxigk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2l9P9cP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530FCC4AF0D;
	Thu, 15 Aug 2024 18:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723745759;
	bh=2MNPIO7/BsrHVWhKfMTW5gZOAAi9d4M5QEiENXiylzQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=a2l9P9cPOhheXfOrpz3lnhvwdwSdC38r1A+g3//IDf5x3mmIPtaR9CdHkBu2Jv4bO
	 Mc5oLj5IyKLe1BFfAWZjjJFVmEEpWVdTL8IuCE3cDHj6xTsmeAKatyd+XxFSufnSQK
	 DbpTzT1IZsErIhlxy4S1qXW3+eKTBHchtu8ADg8VKlQecb968905ZkxXDaW/mJLxTn
	 mTJrJsJoN0erUI2UmWxgrl4TsEj7OPG3+uDcXI6GBtws6UNpaL5l0O2DHQzvmculq5
	 lmF0EpvtAn/dpj8do9U2rfB+6Lusq5C4wtSHtqm63HMx3IgUgrhLn+rfG0Y5nhtibZ
	 8at25ezfpoNLA==
Date: Thu, 15 Aug 2024 13:15:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Do not enable resources during probe()
Message-ID: <20240815181557.GA53448@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727090604.24646-1-manivannan.sadhasivam@linaro.org>

On Sat, Jul 27, 2024 at 02:36:04PM +0530, Manivannan Sadhasivam wrote:
> Starting from commit 869bc5253406 ("PCI: dwc: ep: Fix DBI access failure
> for drivers requiring refclk from host"), all the hardware register access
> (like DBI) were moved to dw_pcie_ep_init_registers() which gets called only
> in qcom_pcie_perst_deassert() i.e., only after the endpoint received refclk
> from host.
> 
> So there is no need to enable the endpoint resources (like clk, regulators,
> PHY) during probe(). Hence, remove the call to qcom_pcie_enable_resources()
> helper from probe(). This was added earlier because dw_pcie_ep_init() was
> doing DBI access, which is not done now.
> 
> While at it, let's also call dw_pcie_ep_deinit() in err path to deinit the
> EP controller in the case of failure.

Is this v6.11 material?  If so, we need a little more justification
than "no need to enable".

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 236229f66c80..2319ff2ae9f6 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -846,21 +846,15 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	ret = qcom_pcie_enable_resources(pcie_ep);
> -	if (ret) {
> -		dev_err(dev, "Failed to enable resources: %d\n", ret);
> -		return ret;
> -	}
> -
>  	ret = dw_pcie_ep_init(&pcie_ep->pci.ep);
>  	if (ret) {
>  		dev_err(dev, "Failed to initialize endpoint: %d\n", ret);
> -		goto err_disable_resources;
> +		return ret;
>  	}
>  
>  	ret = qcom_pcie_ep_enable_irq_resources(pdev, pcie_ep);
>  	if (ret)
> -		goto err_disable_resources;
> +		goto err_ep_deinit;
>  
>  	name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
>  	if (!name) {
> @@ -877,8 +871,8 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
>  	disable_irq(pcie_ep->global_irq);
>  	disable_irq(pcie_ep->perst_irq);
>  
> -err_disable_resources:
> -	qcom_pcie_disable_resources(pcie_ep);
> +err_ep_deinit:
> +	dw_pcie_ep_deinit(&pcie_ep->pci.ep);
>  
>  	return ret;
>  }
> -- 
> 2.25.1
> 

