Return-Path: <linux-pci+bounces-14314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0317F99A3C1
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32AAA1C234ED
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D587B1F9415;
	Fri, 11 Oct 2024 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KY9dcYLx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BD5802
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649208; cv=none; b=Y25z3vikwNkkU79uZm6P0iQ6b1i50loL4ousyQbFYcgLyH9iOA4x5X1vE5x1Bd6mH7KKRoyXGRe0zD7DnNmdrZ52hLbMtas52UKLXJWeZMTu0dWPj81PzH6bYqubMZZ/KJaofragOj7Lrf6sFFwp2VjSVt5qrTBkx+6wxsm94Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649208; c=relaxed/simple;
	bh=ALjpbxQQnP94gb9UiC+7WVQgfT1MncotUi98ve16OUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gxv2DxPWvx/eh5nf5y6ZgcmSqUrHvjlmScRwAHDkydv3LOSithOuUYWDX3XR69j2Y49N9X96OnTBsZBWOdC1BGOw9tUYg+OfDf+3GnG/vvd4w9s0iuLhaFjLArsCyv4IqxEvsmZvBnmwiigO5I4VJLxVpcap/Vj94TQlBlI2sbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KY9dcYLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28FEC4CECF;
	Fri, 11 Oct 2024 12:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728649208;
	bh=ALjpbxQQnP94gb9UiC+7WVQgfT1MncotUi98ve16OUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KY9dcYLxpZqz0kSC3kBDSHoNrC4FbD49NB0jxKpOyhhKM2oVgSB8rV74BEJPFgCBk
	 bCFWTAm1QQkdoWFytbYCrDe99aR28uGC8oEnNmI0IedyH56nVYUQo9qKBqhS4a7lzP
	 U0oXoJjQuQ/ZfMvaYt7u5GukSt5b6HyYN9nC+Q9PRH/zAIyffEXZhd7QNDbF9QKjSg
	 l7CLK6CsLq3liYx9KC2bdiuqaqFjot8bhDEsfQmzfFa/GAT+evNBBgGElSkIg5niBS
	 ApSZ/aB9/e6GfT99PmPYeLConUkn+5bB4EV/SLHsdJgZspk7E5s7MCX+PxenMzybM9
	 9G90pGzO3Oteg==
Date: Fri, 11 Oct 2024 14:20:03 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v5 4/6] PCI: endpoint: Update documentation
Message-ID: <ZwkX81jTn2Ey-avM@ryzen.lan>
References: <20241011120115.89756-1-dlemoal@kernel.org>
 <20241011120115.89756-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011120115.89756-5-dlemoal@kernel.org>

On Fri, Oct 11, 2024 at 09:01:13PM +0900, Damien Le Moal wrote:
> Document the new functions pci_epc_mem_map() and pci_epc_mem_unmap().
> Also add the documentation for the functions pci_epc_map_addr() and
> pci_epc_unmap_addr() that were missing.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  Documentation/PCI/endpoint/pci-endpoint.rst | 29 +++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
> index 21507e3cc238..35f82f2d45f5 100644
> --- a/Documentation/PCI/endpoint/pci-endpoint.rst
> +++ b/Documentation/PCI/endpoint/pci-endpoint.rst
> @@ -117,6 +117,35 @@ by the PCI endpoint function driver.
>     The PCI endpoint function driver should use pci_epc_mem_free_addr() to
>     free the memory space allocated using pci_epc_mem_alloc_addr().
>  
> +* pci_epc_map_addr()
> +
> +  A PCI endpoint function driver should use pci_epc_map_addr() to map to a RC
> +  PCI address the CPU address of local memory obtained with
> +  pci_epc_mem_alloc_addr().
> +
> +* pci_epc_unmap_addr()
> +
> +  A PCI endpoint function driver should use pci_epc_unmap_addr() to unmap the
> +  CPU address of local memory mapped to a RC address with pci_epc_map_addr().
> +
> +* pci_epc_mem_map()
> +
> +  A PCI endpoint controller may impose constraints on the RC PCI addresses that
> +  can be mapped. The function pci_epc_mem_map() allows endpoint function
> +  drivers to allocate and map controller memory while handling such
> +  constraints. This function will determine the size of the memory that must be
> +  allocated with pci_epc_mem_alloc_addr() for successfully mapping a RC PCI
> +  address range. This function will also indicate the size of the PCI address
> +  range that was actually mapped, which can be less than the requested size, as
> +  well as the offset into the allocated memory to use for accessing the mapped
> +  RC PCI address range.
> +
> +* pci_epc_mem_unmap()
> +
> +  A PCI endpoint function driver can use pci_epc_mem_unmap() to unmap and free
> +  controller memory that was allocated and mapped using pci_epc_mem_map().
> +
> +
>  Other EPC APIs
>  ~~~~~~~~~~~~~~
>  
> -- 
> 2.47.0
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

