Return-Path: <linux-pci+bounces-5012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8D2887092
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 17:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC501C22A05
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA2C5C8F8;
	Fri, 22 Mar 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjFhw0fS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3098156B7A;
	Fri, 22 Mar 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123861; cv=none; b=p/e2DlA9BV5WBvqwrRXTMjP89VvKu1LjV2BkLHCIzLuGQ1AROLKRCZm50yA4OxqrdtDyOllIjO4unCnTExz1Cg0FYVAP1pgVVLTwJzi8nv3WQFZagZtHxqk7S4A7AGNPfXnGv5jeqdQkiggF+ZfetU1V3xDgC5ImE2FbUTlwaW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123861; c=relaxed/simple;
	bh=QRcrQlkZAs3NPao5jyfr8DCokGP7se6bSr58nZT3Utc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4qw3OMGN8JIEtlNfOCy1EZFMbTP4ofGb4W4O0vrpD6XLtwOBmCknbGQlmh2JqgUIUEvIIHVBzXBEn+oKeXYTElENUhNTnJPm/CKFMmVqF6AXjIRDDmiCLTren/z6NNVPoxhloDewsraDAwpssT7/YiVkbyblQ+/Mlk/VzH6Fug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjFhw0fS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AD1C433F1;
	Fri, 22 Mar 2024 16:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711123860;
	bh=QRcrQlkZAs3NPao5jyfr8DCokGP7se6bSr58nZT3Utc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UjFhw0fSGv9wULvDXFEu8DLQBTzypo88dcOAXe+PbYje80rBFl5FGkCPabPWSRySA
	 hszGFKx1LEGJOkMOxpJzUKCYRjq9s+ymm0LSZ1LsRwoiJYaWXb13dHm1qXvvhlFnRD
	 0z04hb7rSI7Obyoif00mkg306gCAjAsEg0sJoAY3qXD8Y5MaAQHG79CAjPiC+qAQKc
	 CRxA+3J+Vi66AhsWUVVVP3r62+3sL0eS8rJCVQ08uYM4TT13ifnNyG/l4IOYmX40Qz
	 VUyfIl3jAaS8inFeVOWb7wzl6ovpqe3Koh3Ae5qxm7+pkMfNCojnvy5QcXeCzUU7Fb
	 fsDI7TPbgrhHw==
Date: Fri, 22 Mar 2024 17:10:54 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 10/11] PCI: qcom-ep: Rework {start/stop}_link() callbacks
 implementation
Message-ID: <Zf2tjht4TR7Irewd@ryzen>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-10-6134e6c1d491@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-pci-epf-rework-v1-10-6134e6c1d491@linaro.org>

On Thu, Mar 14, 2024 at 08:53:49PM +0530, Manivannan Sadhasivam wrote:
> DWC specific start_link() and stop_link() callbacks are supposed to start
> and stop the link training of the PCIe bus. But the current implementation
> of this driver enables/disables the PERST# IRQ.
> 
> Even though this is not causing any issues, this creates inconsistency
> among the controller drivers. So for the sake of consistency, let's just
> start/stop the link training in these callbacks.
> 
> Also, PERST# IRQ is now enabled from the start itself, thus allowing the
> controller driver to initialize the registers when PERST# gets deasserted
> without waiting for the user intervention though configfs.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Nice change:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

If you dump LTSSM after a PERST assert + deassert,
using e.g. dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1);
to dump the debug registers (see dw_pcie_link_up())
do you see that PCIE_PORT_DEBUG1_LINK_IN_TRAINING is set?

I was thinking that perhaps there was a thought behind
this original design, that you had to explicitly set
LTSSM_EN after a fundamental core reset, because it
would get cleared?

(It it is implemented like signals and not registers,
then this change should be fine.)


Kind regards,
Niklas


>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 811f250e967a..653e4ace0a07 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -122,6 +122,9 @@
>  /* PARF_CFG_BITS register fields */
>  #define PARF_CFG_BITS_REQ_EXIT_L1SS_MSI_LTR_EN	BIT(1)
>  
> +/* PARF_LTSSM register fields */
> +#define LTSSM_EN				BIT(8)
> +
>  /* ELBI registers */
>  #define ELBI_SYS_STTS				0x08
>  #define ELBI_CS2_ENABLE				0xa4
> @@ -250,8 +253,12 @@ static int qcom_pcie_dw_link_up(struct dw_pcie *pci)
>  static int qcom_pcie_dw_start_link(struct dw_pcie *pci)
>  {
>  	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> +	u32 val;
>  
> -	enable_irq(pcie_ep->perst_irq);
> +	/* Enable LTSSM */
> +	val = readl_relaxed(pcie_ep->parf + PARF_LTSSM);
> +	val |= LTSSM_EN;
> +	writel_relaxed(val, pcie_ep->parf + PARF_LTSSM);
>  
>  	return 0;
>  }
> @@ -259,8 +266,12 @@ static int qcom_pcie_dw_start_link(struct dw_pcie *pci)
>  static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
>  {
>  	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> +	u32 val;
>  
> -	disable_irq(pcie_ep->perst_irq);
> +	/* Disable LTSSM */
> +	val = readl_relaxed(pcie_ep->parf + PARF_LTSSM);
> +	val &= ~LTSSM_EN;
> +	writel_relaxed(val, pcie_ep->parf + PARF_LTSSM);
>  }
>  
>  static void qcom_pcie_dw_write_dbi2(struct dw_pcie *pci, void __iomem *base,
> @@ -484,11 +495,6 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>  
>  	dw_pcie_ep_init_notify(&pcie_ep->pci.ep);
>  
> -	/* Enable LTSSM */
> -	val = readl_relaxed(pcie_ep->parf + PARF_LTSSM);
> -	val |= BIT(8);
> -	writel_relaxed(val, pcie_ep->parf + PARF_LTSSM);
> -
>  	return 0;
>  
>  err_disable_resources:
> @@ -707,7 +713,6 @@ static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
>  	}
>  
>  	pcie_ep->perst_irq = gpiod_to_irq(pcie_ep->reset);
> -	irq_set_status_flags(pcie_ep->perst_irq, IRQ_NOAUTOEN);
>  	ret = devm_request_threaded_irq(&pdev->dev, pcie_ep->perst_irq, NULL,
>  					qcom_pcie_ep_perst_irq_thread,
>  					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> 
> -- 
> 2.25.1
> 

