Return-Path: <linux-pci+bounces-5172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FB288C025
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 12:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C630B224F7
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 11:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF843838C;
	Tue, 26 Mar 2024 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plKB2hIh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596C633CFC;
	Tue, 26 Mar 2024 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451149; cv=none; b=diqcK17GSlKNM12Oj11POKXR/9Eory53rpBqJFP7/qGHmLrncA7p1kDV/fTixIkM87Q7j2lb4w3suyGNox0oDfTmTJWeW4Qa7TNd/MBqYqMeaB65FKM+lyYp0pPHpeO0GrbJp8NFeSnUhAsLmDfgY6732loDLpGmPdfezy0qhJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451149; c=relaxed/simple;
	bh=XvsRXWgO0Ym3Ts7FVT+ufI52BcgH2v55+ZYGE1iG9h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwA/GbKe3EnFEp9VmhvcV+wRahYLfokcyb9YcHTLYD303O6P4C7LiYHY6C3J0/Vezp8+RxOWPdCmONQNePxzFf+7dh9QjhuZpn3MilfkjiH8Ao0bpIBH77ItDJOt+fjUpWI8iWrW4dGlvYLYZsbe56emiwZLXF4i2xt+4Vv+ceU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plKB2hIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85715C433C7;
	Tue, 26 Mar 2024 11:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711451148;
	bh=XvsRXWgO0Ym3Ts7FVT+ufI52BcgH2v55+ZYGE1iG9h0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=plKB2hIhIQRqZvUcjXKFeuPzUZHCeAsGOAFw+gKgzU7SO7iNphQpzVA1w6QfLsomH
	 XOGyxSx/1QolIhecUu06CuICRBn83liCLuDkzqFzgPaHB/ET/T+o/mBb4DocChFTwH
	 Hzo7ihyu/3Pjpk0iJI5SJoXZKHEfFy977rGX3FM4w0rC53vSiLg1+C3Jk1eVK1RIjV
	 XVGB8DyNeOefvZu8BigXtpVktvDUUC6+eaOs6NNz5tO9sHYCda219oNXaJVVPwURWh
	 yyQ88Zb/ugmv34IYMeupVpcsPM1vfgqCD7vjIzVgCUym+y9Nx/e0E/wBOMkpwoiLZ9
	 I1w0k6hfnba3A==
Date: Tue, 26 Mar 2024 12:05:42 +0100
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
Message-ID: <ZgKsBoTvPWWhPO9e@ryzen>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-5-6134e6c1d491@linaro.org>
 <Zf2tXgKo-gc3qy1D@ryzen>
 <20240326082636.GG9565@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326082636.GG9565@thinkpad>

On Tue, Mar 26, 2024 at 01:56:36PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Mar 22, 2024 at 05:10:06PM +0100, Niklas Cassel wrote:
> > On Thu, Mar 14, 2024 at 08:53:44PM +0530, Manivannan Sadhasivam wrote:
> > > To maintain uniformity across EPF drivers, let's move the DMA
> > > initialization to EPC init callback. This will also allow us to deinit DMA
> > > during PERST# assert in the further commits.
> > > 
> > > For EPC drivers without PERST#, DMA deinit will only happen during driver
> > > unbind.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > 
> > Reviewed-by: Niklas Cassel <cassel@kernel.org>
> > 
> > 
> > For the record, I was debugging a problem related to EPF DMA recently
> > and was dumping the DMA mask for the struct device of the epf driver.
> > I was a bit confused to see it as 32-bits, even though the EPC driver
> > has it set to 64-bits.
> > 
> > The current code works, because e.g., pci_epf_test_write(), etc,
> > does:
> > struct device *dma_dev = epf->epc->dev.parent;
> > dma_map_single(dma_dev, ...);
> > 
> > but it also means that all EPF drivers will do this uglyness.
> > 
> 
> This ugliness is required as long as the dmaengine is associated only with the
> EPC.
> 
> > 
> > 
> > However, if a EPF driver does e.g.
> > dma_alloc_coherent(), and sends in the struct *device for the EPF,
> > which is the most logical thing to do IMO, it will use the wrong DMA
> > mask.
> > 
> > Perhaps EPF or EPC code should make sure that the struct *device
> > for the EPF will get the same DMA mask as epf->epc->dev.parent,
> > so that EPF driver developer can use the struct *epf when calling
> > e.g. dma_alloc_coherent().
> > 
> 
> Makes sense. I think it can be done during bind() in the EPC core. Feel free to
> submit a patch if you like, otherwise I'll keep it in my todo list.

So we still want to test:
-DMA API using the eDMA
-DMA API using the "dummy" memcpy dma-channel.

However, it seems like both pci-epf-mhi.c and pci-epf-test.c
do either:
-Use DMA API
or
-Use memcpy_fromio()/memcpy_toio() instead of DMA API


To me, it seems like we should always be able to use
DMA API (using either a eDMA or "dummy" memcpy).

I don't really see the need to have the path that does:
memcpy_fromio()/memcpy_toio().

I know that for DWC, when using memcpy (and this also
memcpy via DMA API), we need to map the address using
iATU first.

But that could probably be done using another flag,
perhaps rename that flag FLAG_USE_DMA to NEEDS_MAP or
something.
(Such that we can change these drivers to only have a
code path that uses DMA API.)
(...and making sure that inheriting the DMA mask does
not affect the DMA mask for DMA_MEMCPY.)

But perhaps I am missing something... and DMA_MEMCPY is
not always available?


Kind regards,
Niklas

