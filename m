Return-Path: <linux-pci+bounces-34390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D9DB2E191
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 17:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397225C72FE
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 15:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148532E4242;
	Wed, 20 Aug 2025 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CchuuqlK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A832255E
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705160; cv=none; b=jiJkjLH9BFhilg/M1bEvv5QjwLhMuvm+84KPo7q/nubBDTpBoeXNk+UJ1uKQqcU5aovMO6qoqQ3HZ/23rJOPjOFuQx8wjrU4mk4H9whAcZNmXiV8ejtburBvqgqIvFb3VQGgSpYcqk231fxC7gM4FsExc7qbw+zGDo65jjgl41w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705160; c=relaxed/simple;
	bh=38tfGJHYgFod0jKxdkzzfouGpr4fBU2s70M7QnEbodk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=egwVxnt74yBQPu8YXUr+mlpLqrZdFcUFhOB6c4fus4mJFU9vCWBqzKIEtsTVtO3BcItUMWPXrhmLYhjF3B89zo0R2IlDIBCHra+5Mvz9Ce38y4RXJRlaYc5MbQOvL4NaXfJD2voi93IENzL+ooWTAKQUyxvXVcYXhCVwUipfRj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CchuuqlK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5FAC4CEEB;
	Wed, 20 Aug 2025 15:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755705159;
	bh=38tfGJHYgFod0jKxdkzzfouGpr4fBU2s70M7QnEbodk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CchuuqlKqwH2fi38ScKsJiSHCTDEoJ2lX72r848mnikOA0lNRA71HGy3lVHnFa1s8
	 jzmoVb+d/JlB+TlqREl71ZkFkDHGlz70vy+DJiD7ciqdpxMv59bCX2sBSOMVE7usPJ
	 fY0To/BgmUEbU3yfiPbhATtX+23HYojYzT6zH+y/Tk913juFYJpS5QKqX1BXfuQ91d
	 EZSdXpChm8KAt1kOuyeaNtYooGtVcqCQZGgyYgEDnNYajyUgQdo5Ja26LvvbA8Mj8a
	 eLBP73mmGTTzku3Iyl2SiCmxO1EL4kMBKT7yTBTaR3gr3OoD0naBrrxQWkAB9zbK1S
	 3BT/fiDk+U+OA==
Date: Wed, 20 Aug 2025 10:52:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randolph Lin <randolph@andestech.com>
Cc: linux-pci@vger.kernel.org, ben717@andestech.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com,
	randolph.sklin@gmail.com, tim609@andestech.com
Subject: Re: [PATCH 2/6] PCI: dwc: Add outbound ATU range check callback
Message-ID: <20250820155236.GA626208@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820111843.811481-3-randolph@andestech.com>

On Wed, Aug 20, 2025 at 07:18:39PM +0800, Randolph Lin wrote:
> Introduce a callback for outbound ATU range checking to support
> range validations specific to cases that deviate from the generic
> check.
> 
> Signed-off-by: Randolph Lin <randolph@andestech.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 18 +++++++++++++-----
>  drivers/pci/controller/dwc/pcie-designware.h |  3 +++
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 89aad5a08928..f410aefaeb5e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -535,12 +535,20 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  	u32 retries, val;
>  	u64 limit_addr;
>  
> -	limit_addr = parent_bus_addr + atu->size - 1;
> +	if (pci->ops && pci->ops->outbound_atu_check) {
> +		val = pci->ops->outbound_atu_check(pci, atu, &limit_addr);

The return is not a "val" and not a "u32".  It should be named "ret"
or similar.  Should be "int" since the callback and
dw_pcie_prog_outbound_atu() return "int".  But see below for possible
signature change.

Also not 100% convinced this is needed, see other patch where this is
implemented.

> +		if (val)
> +			return val;
> +	} else {
> +		limit_addr = parent_bus_addr + atu->size - 1;
>  
> -	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
> -	    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
> -	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
> -		return -EINVAL;
> +		if ((limit_addr & ~pci->region_limit) !=
> +		    (parent_bus_addr & ~pci->region_limit) ||
> +		    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
> +		    !IS_ALIGNED(atu->pci_addr, pci->region_align) ||
> +		    !atu->size) {
> +			return -EINVAL;
> +		}
>  	}
>  
>  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 00f52d472dcd..40dd2c83b1c7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -469,6 +469,9 @@ struct dw_pcie_ep {
>  
>  struct dw_pcie_ops {
>  	u64	(*cpu_addr_fixup)(struct dw_pcie *pcie, u64 cpu_addr);
> +	u32	(*outbound_atu_check)(struct dw_pcie *pcie,
> +				      const struct dw_pcie_ob_atu_cfg *atu,
> +				      u64 *limit_addr);

I have kind of an allergic reaction to things named "check" because
the name doesn't suggest anything about what the function does or what
it will return.  For bool functions, I prefer a name that's a
predicate that can be either true or false, e.g., "valid".

This isn't a bool, but possibly *could* be, e.g.,
"outbound_atu_addr_valid()".  Then the caller would be something like:

  if (!pci->ops->outbound_atu_addr_valid(...))
    return -EINVAL;

