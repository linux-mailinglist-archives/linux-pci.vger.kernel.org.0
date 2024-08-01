Return-Path: <linux-pci+bounces-11123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E476F945169
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 19:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8206BB22D5A
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 17:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643CC1B3736;
	Thu,  1 Aug 2024 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFbNtxYw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7F813D617;
	Thu,  1 Aug 2024 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722532991; cv=none; b=i3TaRh0ZK3A3se8l/q7KRc4VupP6XpB6Z99GS+K6pmwrF27Ff5Q7weeq0GpKaE4GzAVq84b6PEDvuW/fvAN9ytnhKBhnJ7fnSqEQLBY/Wxg7S9CwoUjx1yONwGtvWEfis0cRHrNripRQA9o/feg7KuPlBZS+NVRpSakCDS1eGhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722532991; c=relaxed/simple;
	bh=z+rHBSakfkAUUMkUP86CoxwQzOchgypmU/tHoTfiLwE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jOWgeZFohkzEfRcjMMCZS8D82UyKZoghWdVL7SUY8SqVCTp9DHvlDBJ4k1tNHLvavJQvGRLm04/EAWGQhUq5FIUCZqWtFNLvTj9y4TgjOyL1/JqFdz3RxVFjfPYXjlinSjg5HnVk5XnRwZ6KT0ZXo6iamaSQkWAipd2Sr4D4soA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFbNtxYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E97C32786;
	Thu,  1 Aug 2024 17:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722532990;
	bh=z+rHBSakfkAUUMkUP86CoxwQzOchgypmU/tHoTfiLwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MFbNtxYwrExkO/cIxrI1ZV9gjIqBOGjY6Q0ZhTO7c/NE/xYTexN4FulcETSsjCV/K
	 2XYD0Nf7Y36VMW7Hh9YcAYgAdUN9Jhs7ev1RujOs+PtTqZGck//IWV0VI17mYmhcMa
	 gNTC0TyF4wgQeFsNgBo1ciNm9uZ1JzGhDEeIPHt5mYCOUI2exL/IrC2SvR3fONYmyT
	 Rl8KkXMwQpq7FxTHK5obpgLPWXDRLCVBDlXgjXIC/OW/+J0X/CDJS1ouJA1jSuU57u
	 7uY97rYTuu2aSA2dGr6puYoK6/vvCNjX+3yLYP/iOkzK0p90VgmleIzCQX1NzMVPxX
	 RivHmDHuLoaaw==
Date: Thu, 1 Aug 2024 12:23:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@linaro.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v3 06/13] PCI: qcom-ep: Modify 'global_irq' and
 'perst_irq' IRQ device names
Message-ID: <20240801172308.GA109178@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-pci-qcom-hotplug-v3-6-a1426afdee3b@linaro.org>

On Wed, Jul 31, 2024 at 04:20:09PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Currently, the IRQ device name for both of these IRQs doesn't have Qcom
> specific prefix and PCIe domain number. This causes 2 issues:
> 
> 1. Pollutes the global IRQ namespace since 'global' is a common name.
> 2. When more than one EP controller instance is present in the SoC, naming
> conflict will occur.
> 
> Hence, add 'qcom_pcie_ep_' prefix and PCIe domain number suffix to the IRQ
> names to uniquely identify the IRQs and also to fix the above mentioned
> issues.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 0bb0a056dd8f..d0a27fa6fdc8 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -711,8 +711,15 @@ static irqreturn_t qcom_pcie_ep_perst_irq_thread(int irq, void *data)
>  static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
>  					     struct qcom_pcie_ep *pcie_ep)
>  {
> +	struct device *dev = pcie_ep->pci.dev;
> +	char *name;
>  	int ret;
>  
> +	name = devm_kasprintf(dev, GFP_KERNEL, "qcom_pcie_ep_global_irq%d",
> +			      pcie_ep->pci.ep.epc->domain_nr);
> +	if (!name)
> +		return -ENOMEM;

I assume this is what shows up in /proc/interrupts?  I always wonder
why it doesn't include dev_name().  A few drivers do that, but
apparently it's not universally desirable.  It's sort of annoying
that, e.g., we get a bunch of "aerdrv" interrupts with no clue which
device they relate to.

>  	pcie_ep->global_irq = platform_get_irq_byname(pdev, "global");
>  	if (pcie_ep->global_irq < 0)
>  		return pcie_ep->global_irq;
> @@ -720,18 +727,23 @@ static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
>  	ret = devm_request_threaded_irq(&pdev->dev, pcie_ep->global_irq, NULL,
>  					qcom_pcie_ep_global_irq_thread,
>  					IRQF_ONESHOT,
> -					"global_irq", pcie_ep);
> +					name, pcie_ep);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to request Global IRQ\n");
>  		return ret;
>  	}
>  
> +	name = devm_kasprintf(dev, GFP_KERNEL, "qcom_pcie_ep_perst_irq%d",
> +			      pcie_ep->pci.ep.epc->domain_nr);
> +	if (!name)
> +		return -ENOMEM;
> +
>  	pcie_ep->perst_irq = gpiod_to_irq(pcie_ep->reset);
>  	irq_set_status_flags(pcie_ep->perst_irq, IRQ_NOAUTOEN);
>  	ret = devm_request_threaded_irq(&pdev->dev, pcie_ep->perst_irq, NULL,
>  					qcom_pcie_ep_perst_irq_thread,
>  					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> -					"perst_irq", pcie_ep);
> +					name, pcie_ep);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to request PERST IRQ\n");
>  		disable_irq(pcie_ep->global_irq);
> 
> -- 
> 2.25.1
> 
> 

