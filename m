Return-Path: <linux-pci+bounces-35649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2194CB48763
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 10:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB173177B18
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 08:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80351531C8;
	Mon,  8 Sep 2025 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6FbpN9H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F0338DEC
	for <linux-pci@vger.kernel.org>; Mon,  8 Sep 2025 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320942; cv=none; b=UyMC06v/CNERpmbZhTOKu0dsaiPWbJ7T8i2QeZd0wq9TQpa5YoxY5m1F04nmr3J5M+Gpos4oOYVk+K3v6IcK+Kid+nPGeQBQdwmEgZQt8U3KLOXy7SdXAvYtWn4pLxtVGCQ3VB4R24pSU1NTJtbhCpCTlDVLA0TCHohs1CMVHXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320942; c=relaxed/simple;
	bh=WMJP1XM2qhiEGd26EmUfzXpFIgZEvLiVPEaGbyFoBFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwvQZgjtGOEajL8inu28tzgoYuI0PSX61S9JVjN0y89r/oE3x1xDt0A6T4diJ9mywD9Ll+jmNbLIrDYvU7dMh6G3MRv5bStS5zB57ns6Kn9DW8jZMlHbiw6wNi8LYSJHMcW1pLKTCOxZaMDlYzaWC4CkqDiii6tQ8iE1y5K0fs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6FbpN9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACBBC4CEF5;
	Mon,  8 Sep 2025 08:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757320942;
	bh=WMJP1XM2qhiEGd26EmUfzXpFIgZEvLiVPEaGbyFoBFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6FbpN9HOSDJwPe549IuV0l6cPiyrIGIq5qFZr5N2CFRiWQcfkmBpDt5up53UB7+k
	 xYIeTv+ip30pfLpHEteGe2NijEcmJsgGPBtuz07k6+iE2pFrNoUWL7RruRJsN+D9L4
	 XjnEhUcXIzhAsJwk4fb8FyVqIwcoCIanrquz8cNb44vxNZ2cpyJDWziowP481nfXUc
	 lBx9lQKhHGFXyIhp0M5JXBasBt90A563y/OSC6nJQMImHM8iChHYi3Ze6uL+lGyBgs
	 nHyNbtmCqr7qmMlMbQoU7LkG2j1BsKBDcyjEGHcX/1LJDxw4RNFw9vRcJqrSRBdKTD
	 u0a7b9DhYXQ7w==
Date: Mon, 8 Sep 2025 14:12:17 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: DWC PCIe eDMA irqs
Message-ID: <tnowvmxxoj5mfkrvk4k3d7gk624266ua2vin4rybmxeki2yb6u@n46qsc53av4l>
References: <aLmKsp7VWBdMcM5p@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLmKsp7VWBdMcM5p@ryzen>

On Thu, Sep 04, 2025 at 02:48:50PM GMT, Niklas Cassel wrote:
> Hello Mani,
> 
> 
> Looking at dw_pcie_edma_irq_verify()
> https://github.com/torvalds/linux/blob/v6.17-rc4/drivers/pci/controller/dwc/pcie-designware.c#L1048-L1049
> 
> We can see that it does an early return if "pci->edma.nr_irqs == 1".
> 
> I.e. if the glue driver has set "pci->edma.nr_irqs == 1", we never even
> bother to fetch "dma"/"dmaX" from device tree.
> 
> This suggests that we support a single IRQ for all eDMA channels,
> and since we don't even parse anything for DT, it suggests that this
> IRQ could be the same IRQ as the "sys IRQ" for the PCI controller.
> (E.g. tegra has a single IRQ for the PCI controller and the eDMA.)
> 
> 
> 
> However, looking at dw_pcie_edma_irq_vector(), which will be called by
> dw_edma_probe():
> https://github.com/torvalds/linux/blob/v6.17-rc4/drivers/pci/controller/dwc/pcie-designware.c#L945-L947
> 
> We can see that we need either "dma" or "dmaX" in DT.
> 
> Which suggests that the code currently only supports either a
> separate IRQ for each eDMA per channel, or a combined IRQ for
> each eDMA channel, but the combined IRQ cannot be the same as
> the "sys IRQ".
> 
> 
> This seems inconsistent to me.
> 

Agree.

> Since dw_pcie_edma_irq_vector() requires either "dma" or "dmaX" in DT,
> I don't see why we shouldn't have the same requirement for
> dw_pcie_edma_irq_verify()
> 

I think we could also get rid of dw_pcie_edma_irq_verify(), since kernel is not
a devicetree validator and it should just trust DT (atleast for these kind of
resources). The binding should make sure that the DTBs are correct.

Moreover, dw_edma_irq_request() will look for only 2 combinations:

1. Single IRQ for all channels
2. Separate IRQ per channel

So if the platform doesn't supply enough IRQs for each channel,
dw_edma_irq_request() will fail anyway. Precisely, the irq_vector() callback.

But for removing dw_pcie_edma_irq_verify() and dw_edma_chip::nr_irqs, we also
need corresponding change in dw_edma_irq_request(). So I'm not asking you to
implement it. It is more of a note to myself or someone interested :)

> Looking at pcie-ep@1c08000 in arch/arm64/boot/dts/qcom/sm8450.dtsi,
> it does also specify "dma" IRQ in DT.
> 
> 
> So, should I submit a patch that does:
> 
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 89aad5a08928..c7a2cf5e886f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1045,9 +1045,7 @@ static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
>  	char name[15];
>  	int ret;
>  
> -	if (pci->edma.nr_irqs == 1)
> -		return 0;
> -	else if (pci->edma.nr_irqs > 1)
> +	if (pci->edma.nr_irqs > 1)
>  		return pci->edma.nr_irqs != ch_cnt ? -EINVAL : 0;
>  
>  	ret = platform_get_irq_byname_optional(pdev, "dma");
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index bf7c6ac0f3e3..ad98598bb522 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -874,7 +874,6 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
>  	pcie_ep->pci.dev = dev;
>  	pcie_ep->pci.ops = &pci_ops;
>  	pcie_ep->pci.ep.ops = &pci_ep_ops;
> -	pcie_ep->pci.edma.nr_irqs = 1;
>  
>  	pcie_ep->cfg = of_device_get_match_data(dev);
>  	if (pcie_ep->cfg && pcie_ep->cfg->hdma_support) {
> 
> 
> Because, since sm8450 (and all other platforms) currently must have
> either "dma" or "dmaX" in DT, all currently supported platform should
> still work.
> 
> 
> If sm8450 case, this code:
> https://github.com/torvalds/linux/blob/v6.17-rc4/drivers/pci/controller/dwc/pcie-designware.c#L1053-L1057
> 
> should set pcie_ep->pci.edma.nr_irqs = 1, because sdm8450 has "dma" in DT.
> 

Ack, for both changes.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

