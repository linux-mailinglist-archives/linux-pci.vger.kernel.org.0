Return-Path: <linux-pci+bounces-5008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F20F988707E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 17:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDC5284BCC
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6445A0EE;
	Fri, 22 Mar 2024 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv4NMX+s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2D359B56;
	Fri, 22 Mar 2024 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123812; cv=none; b=PZl1X34APawZHGJyLZavMfdjTWZsYzmZ2OwOrBsLfT7NofoDX+JHSHW1K6vpo9Wq/Z2RtLGit+aSwAP/sTLQVQ8nDcQTjZTVGi0oWC9PMAfOx/75r0vHR6/XP2L7NlzeaoGvl3EkeKQSjKihJhwLlpt0hZLD42VR4OzPnM0EFok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123812; c=relaxed/simple;
	bh=ZykpEH6/3il0JVUrcIN6n7VW8Xp7HVRqAuW1Y9G4IwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dsd6g6HSfBE5c/0L/RUizqHk+M5hoSrV33xK0YwItXtjinxYKkPMoOxdvFU52/GtPM+Wsb/miOZ04mWt9GvWvqjlbwGUKtOKilrhoMWyRDJFB446nb42XQL3c6hJW7xmcHwwkGuxlanEdEd5kgb/Hr8hHo+kyENKxIo+rgiGUis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv4NMX+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15DDC43390;
	Fri, 22 Mar 2024 16:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711123812;
	bh=ZykpEH6/3il0JVUrcIN6n7VW8Xp7HVRqAuW1Y9G4IwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fv4NMX+sgC+mQPWkGfBrrzy2n/vnEphOycFPs3DCe8wc7cmDHUKT+wb/znKPBhLQZ
	 CTpkqSkgjF6NUw9PFYPMD+PQIVXPcmnBq44/t0fOMFwC3jJxrLjhmmIb/vNbGIQqD8
	 a+i/iBM0svSzaMFWHoC/2y7YnRVd/OqVeEQukRGhz8Du3S31DsjxxN20G1EFDAw65l
	 s2nXVMWwnillwbmi1BNnfZY/SetAeVN38COJ6YvqQ7V3qo83WbpQ8JKH5MNKIoZS2X
	 FeRk/afy7HnGUDLUuUsXk4PK+7kh1ysXIqQmR7PivYKyu+CBu7G0gMj2UTo4PpxN4S
	 10y0jvjn3rTog==
Date: Fri, 22 Mar 2024 17:10:06 +0100
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
Subject: Re: [PATCH 05/11] PCI: epf-{mhi/test}: Move DMA initialization to
 EPC init callback
Message-ID: <Zf2tXgKo-gc3qy1D@ryzen>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-5-6134e6c1d491@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-pci-epf-rework-v1-5-6134e6c1d491@linaro.org>

On Thu, Mar 14, 2024 at 08:53:44PM +0530, Manivannan Sadhasivam wrote:
> To maintain uniformity across EPF drivers, let's move the DMA
> initialization to EPC init callback. This will also allow us to deinit DMA
> during PERST# assert in the further commits.
> 
> For EPC drivers without PERST#, DMA deinit will only happen during driver
> unbind.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>


For the record, I was debugging a problem related to EPF DMA recently
and was dumping the DMA mask for the struct device of the epf driver.
I was a bit confused to see it as 32-bits, even though the EPC driver
has it set to 64-bits.

The current code works, because e.g., pci_epf_test_write(), etc,
does:
struct device *dma_dev = epf->epc->dev.parent;
dma_map_single(dma_dev, ...);

but it also means that all EPF drivers will do this uglyness.



However, if a EPF driver does e.g.
dma_alloc_coherent(), and sends in the struct *device for the EPF,
which is the most logical thing to do IMO, it will use the wrong DMA
mask.

Perhaps EPF or EPC code should make sure that the struct *device
for the EPF will get the same DMA mask as epf->epc->dev.parent,
so that EPF driver developer can use the struct *epf when calling
e.g. dma_alloc_coherent().

(This is however not strictly related to this patch, but I thought
that I should mention it.)


Kind regards,
Niklas

>  drivers/pci/endpoint/functions/pci-epf-mhi.c  | 16 ++++++++--------
>  drivers/pci/endpoint/functions/pci-epf-test.c | 12 ++++++------
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index da894a9a447e..4e4300efd9d7 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -737,6 +737,14 @@ static int pci_epf_mhi_epc_init(struct pci_epf *epf)
>  	if (!epf_mhi->epc_features)
>  		return -ENODATA;
>  
> +	if (info->flags & MHI_EPF_USE_DMA) {
> +		ret = pci_epf_mhi_dma_init(epf_mhi);
> +		if (ret) {
> +			dev_err(dev, "Failed to initialize DMA: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -749,14 +757,6 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
>  	struct device *dev = &epf->dev;
>  	int ret;
>  
> -	if (info->flags & MHI_EPF_USE_DMA) {
> -		ret = pci_epf_mhi_dma_init(epf_mhi);
> -		if (ret) {
> -			dev_err(dev, "Failed to initialize DMA: %d\n", ret);
> -			return ret;
> -		}
> -	}
> -
>  	mhi_cntrl->mmio = epf_mhi->mmio;
>  	mhi_cntrl->irq = epf_mhi->irq;
>  	mhi_cntrl->mru = info->mru;
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 2fac36553633..8f1e0cb08814 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -753,6 +753,12 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
>  	bool msi_capable = true;
>  	int ret;
>  
> +	epf_test->dma_supported = true;
> +
> +	ret = pci_epf_test_init_dma_chan(epf_test);
> +	if (ret)
> +		epf_test->dma_supported = false;
> +
>  	epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
>  	if (epc_features) {
>  		msix_capable = epc_features->msix_capable;
> @@ -942,12 +948,6 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	if (ret)
>  		return ret;
>  
> -	epf_test->dma_supported = true;
> -
> -	ret = pci_epf_test_init_dma_chan(epf_test);
> -	if (ret)
> -		epf_test->dma_supported = false;
> -
>  	return 0;
>  }
>  
> 
> -- 
> 2.25.1
> 

