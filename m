Return-Path: <linux-pci+bounces-7585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FBC8C7DD4
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 22:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D905281F9D
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 20:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BFC157E6B;
	Thu, 16 May 2024 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmtTb6E7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E5A157E61
	for <linux-pci@vger.kernel.org>; Thu, 16 May 2024 20:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715892549; cv=none; b=G/kzev8W9BevClKz6bVYwo7/u2LHPiqF1xSVECiEAEXBhe/ntIYlrNYQ26kuor4cqbu89V9Bi8FTlfREXYkstz9KlJXaUW3iS5AE7kg90dbEpf4n8kLq0BlkPzAsMGYvrnarHeDZlo/y3uspXlHIyUz8F04CTbeOOCjfQRUxtnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715892549; c=relaxed/simple;
	bh=EQKCTFTlDIIojMPGYbYn7kDk1TJcuF5MF/1Vi6vEsEk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LbQ5eSZpcNQsxTdFs0YvDZM/Lv6ovy52ZbxqTNbki7oowPLQLOb7gX7abzTg/rDT4BPqZkAhrXsYKrP792jytw8YG6uLbwu0tEKGaOkcX82YgRMPnOSDb+RN+V4mZ1p2KLBuWsmeMiJ1427QzsPzBSaLFeSl5pL7kaCm4LbwXGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmtTb6E7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D50CC113CC;
	Thu, 16 May 2024 20:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715892549;
	bh=EQKCTFTlDIIojMPGYbYn7kDk1TJcuF5MF/1Vi6vEsEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JmtTb6E7PHrrTSWAwTNV1yWVS1R50TrtN9vBABRbLnO8e857Qi6tyUlNi4TuGggtU
	 MUhEq1jZ65L8qnKXq5MbtXRJBHbrUk7O2dcq3iyy4Ttbcg5KQ8l5B4lvV2YOCc2Gz8
	 v3WRF0KfHuRhmSunPybz4XP0vX6mXSgVaXLz8oZnsnzQH7qg6Pw+zBrpo5cNO4zzn/
	 j3fB7R9Hpa5voDiu6SmKHPm3RVMOdJZGNnJ60VwYokJJVt1goriwuWlR6/Vb5iNneA
	 RVwEziiDgOcSEaTwRBdy8zEGFzF2G00eYDiztr/WHFggLz9rwnJOgZ5NdGGlFzkgA1
	 ILiHisl966ufw==
Date: Thu, 16 May 2024 15:49:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 7/9] PCI: cadence: Set a 64-bit BAR if requested
Message-ID: <20240516204907.GA2253008@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312105152.3457899-8-cassel@kernel.org>

[+cc Shawn for Rockchip question]

On Tue, Mar 12, 2024 at 11:51:47AM +0100, Niklas Cassel wrote:
> Ever since commit f25b5fae29d4 ("PCI: endpoint: Setting a BAR size > 4 GB
> is invalid if 64-bit flag is not set") it has been impossible to get the
> .set_bar() callback with a BAR size > 4 GB, if the BAR was also not
> requested to be configured as a 64-bit BAR.
> 
> Thus, forcing setting the 64-bit flag for BARs larger than 4 GB in the
> lower level driver is dead code and can be removed.
> 
> It is however possible that an EPF driver configures a BAR as 64-bit,
> even if the requested size is < 4 GB.
> 
> Respect the requested BAR configuration, just like how it is already
> repected with regards to the prefetchable bit.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 2d0a8d78bffb..de10e5edd1b0 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -99,14 +99,11 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
>  		ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS;
>  	} else {
>  		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
> -		bool is_64bits = sz > SZ_2G;
> +		bool is_64bits = !!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
>  
>  		if (is_64bits && (bar & 1))
>  			return -EINVAL;

Not relevant to *this* patch, but it looks like this code assumes that
a 64-bit BAR must consist of an even-numbered DWORD followed by an
odd-numbered one, e.g., it could be BAR 0 and BAR 1, but not BAR 1 and
BAR 2.

I don't think the PCIe spec requires that.  Does the Cadence hardware
require this?

What about Rockchip, which has similar code in
rockchip_pcie_ep_set_bar()?

FWIW, dw_pcie_ep_set_bar() doesn't enforce this restriction.

> -		if (is_64bits && !(flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
> -			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> -
>  		if (is_64bits && is_prefetch)
>  			ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
>  		else if (is_prefetch)
> -- 
> 2.44.0
> 

