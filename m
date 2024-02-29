Return-Path: <linux-pci+bounces-4274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 568EC86D26E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 19:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7811F2216F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 18:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE8612E5B;
	Thu, 29 Feb 2024 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5wjpMB6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB42179F1
	for <linux-pci@vger.kernel.org>; Thu, 29 Feb 2024 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231862; cv=none; b=Sc2rckJ7RpyYCDBIMmuTp+0/yuM8nj+TXicfW4PKxELFr6FvjLsRQHxG/Nu6Da7HsXy1fDCzkw1+dcqFBCvKpYIYR2urX4g8tJp461Jp9Soww4PQmHhfIWFsF7NQ35eXhrx4vNOegJCeQbTq+2VnKJ9IaffCmEPAMwAmN0Y9idU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231862; c=relaxed/simple;
	bh=709N7WXFE1W+nNuWVZ2C/+wi9cjUJ88hCJBHMkCKVbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCMJl+aMurxJO+TTcG/gLbjhUvjDhjNNUuzl+55G1fUgABm8pZJs+h61VO4MWNPxsbdMQt0NA+UPSmd842gUFuk3Ts5MNjbbMtLOaDYdgBlRX1O4PKj1ViWsrjbRqZa9IHxJYcAek9Rg6x3DzDihp89SaqqKVI+Z7b4P+CK73BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5wjpMB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8BDC43390;
	Thu, 29 Feb 2024 18:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709231862;
	bh=709N7WXFE1W+nNuWVZ2C/+wi9cjUJ88hCJBHMkCKVbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T5wjpMB6MRMfaMMkqfpYF3c5vhMsMRJ/Fb8Z/n+e9/qbq9RyZje7C97pfxJQrRbZw
	 7xW5G1Y+w0+zDZUtbTU2/BTVEil5SXrxfuyUQlh1IvchhzUv00VNOJ7ZaaED/KSUvw
	 r+tU2ytv4ugxNpVa2E9XabnL9UTJPAQv8Cn5Ri3OXI13GQEOYjqtviXHLB4JZSKdst
	 fic1jV3FjDyU9UMOEt90H7a9C4TXpUNHpIXAgFSruWuiW8Gw01xmwruyJVKLQ9X7/0
	 UcHmkMY2v5GO06FYtJnuyHv4AkxsZirFykMiINIp7KBE4lSUYDm5z6fV9FZ/UrryEe
	 U3Pyo0dpHVGow==
Date: Thu, 29 Feb 2024 19:37:37 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Shradha Todi <shradha.t@samsung.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: endpoint: Set prefetch when allocating memory
 for 64-bit BARs
Message-ID: <ZeDO8RakU49eqXAl@fedora>
References: <20240229104900.894695-1-cassel@kernel.org>
 <20240229104900.894695-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229104900.894695-3-cassel@kernel.org>

On Thu, Feb 29, 2024 at 11:48:59AM +0100, Niklas Cassel wrote:
> From the PCIe 6.0 base spec:
> "Generally only 64-bit BARs are good candidates, since only Legacy
> Endpoints are permitted to set the Prefetchable bit in 32-bit BARs,
> and most scalable platforms map all 32-bit Memory BARs into
> non-prefetchable Memory Space regardless of the Prefetchable bit value."
> 
> "For a PCI Express Endpoint, 64-bit addressing must be supported for all
> BARs that have the Prefetchable bit Set. 32-bit addressing is permitted
> for all BARs that do not have the Prefetchable bit Set."
> 
> "Any device that has a range that behaves like normal memory should mark
> the range as prefetchable. A linear frame buffer in a graphics device is
> an example of a range that should be marked prefetchable."
> 
> The PCIe spec tells us that we should have the prefetchable bit set for
> 64-bit BARs backed by "normal memory". The backing memory that we allocate
> for a 64-bit BAR using pci_epf_alloc_space() (which calls
> dma_alloc_coherent()) is obviously "normal memory".
> 
> Thus, set the prefetchable bit when allocating backing memory for a 64-bit
> BAR.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index e7dbbeb1f0de..10264d662abf 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -305,7 +305,8 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  	epf_bar[bar].size = size;
>  	epf_bar[bar].barno = bar;
>  	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
> -		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> +		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64 |
> +				      PCI_BASE_ADDRESS_MEM_PREFETCH;
>  	else
>  		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_32;

This should probably be:

if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
	epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
else
	epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_32;

if (epf_bar[bar].flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
	epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_PREFETCH;

so that we set PREFETCH even for a EPF driver that had PCI_BASE_ADDRESS_MEM_TYPE_64
set in flags even before calling pci_epf_alloc_space. Will fix in V2.




I also found a bug in the existing code.
If pci_epf_alloc_space() allocated a 64-bit BAR because of bits in size,
then the increment in pci_epf_test_alloc_space() was incorrect.
(I guess no one uses BARs > 4GB).

--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -865,6 +865,12 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
                        dev_err(dev, "Failed to allocate space for BAR%d\n",
                                bar);
                epf_test->reg[bar] = base;
+
+               /*
+                * pci_epf_alloc_space() might have given us a 64-bit BAR,
+                * even if we only requested a 32-bit BAR.
+                */
+               add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;

Will send a separate fix with the above.


Kind regards,
Niklas

