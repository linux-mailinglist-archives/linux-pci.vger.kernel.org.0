Return-Path: <linux-pci+bounces-32193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45625B06895
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 23:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823DA563284
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 21:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3F5270547;
	Tue, 15 Jul 2025 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i88HuL74"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C860F24DCEC
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752615183; cv=none; b=O7rnzeo73K4O5E1f8iDi2Z5Ik5tMwSsUIF/G9b9m1KvEucIC9VRT2sq6R9RoLs6+XYHFwTsiS9P/b+pLS6Im4VnKi9p+u9D+80EIQZ5SFBWvs7oTrvwM5hhsy9nRrp4iALfx/X+E0/9UT4BA6XPEI397tUgR60xNgOw8b9XmvsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752615183; c=relaxed/simple;
	bh=XZrRORvDj60Twtrc9Jl2lgSJfsP2Z5cHCPdsCtLNv6U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fWdk+ThV41p+VP3K8Puttt6HzVu/2sbG1neiCzhBrTxqCfiEoMdjyccOqpM3EHiO8yDRI7fEhg9ixVE4F1zB/qTnxD/WOcc4hm2rcDBVH7oKGQYw7duuCQV7+ydpcOoVtVuPFcq5LewrtqlFGUUobTAQG08+SjvbcRYmBaHj78s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i88HuL74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244F5C4CEE3;
	Tue, 15 Jul 2025 21:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752615183;
	bh=XZrRORvDj60Twtrc9Jl2lgSJfsP2Z5cHCPdsCtLNv6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=i88HuL74elNapRe3Bx+M+W6Ydtpab/Oren09cDUjG2/5FJ3MOY8RGTJV4cLsPdQGn
	 3TzigcAKkcblYGMKphPWqUek68eAZKUHeXOIsjUs62drfiPRpgv0dRebM1N/s6TRLn
	 2cNF54/hoW8QQZyQR/4A4amyaL+Y8bJBoXSDaLQKs5XmUrAYqfWtHX0fVVt7U45aaU
	 xWCldCYisTB+yyoZ8J+fLyjrvpM5BDb/hOxK/S2FaYN3MaxqsZaZ1lnmmCGFB2i1Tb
	 NuhsAc0ZlFZIhXEmTYg3ASsTkGYDe1DSlENbsV771tW7CG3NiEEPDdUmOnNCTIq4kz
	 Zvrp7kpnHO/lQ==
Date: Tue, 15 Jul 2025 16:33:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Wannes Bouwen (Nokia)" <wannes.bouwen@nokia.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
	Vidya Sagar <vidyas@nvidia.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [v4 PATCH 1/1] PCI: of: fix non-prefetchable region address
 range check.
Message-ID: <20250715213301.GA2500492@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR07MB883887374D2E7B59E33A0861FD7CA@PA4PR07MB8838.eurprd07.prod.outlook.com>

In subject, capitalize "Fix" and drop period at end.

On Fri, Jun 20, 2025 at 09:32:35AM +0000, Wannes Bouwen (Nokia) wrote:
>  
> [v4 PATCH 1/1] PCI: of: fix non-prefetchable region address range check.

Drop this.

> According to the PCIe spec (PCIe r6.3, sec 7.5.1.3.8), non-prefetchable
> memory supports only 32-bit host bridge windows (both base address as
> limit address).

7.5.1.3.8 is about PCI-to-PCI bridge windows, not host bridge windows.

I'm confused about what's going on here.  The word "prefetch" doesn't
even appear in PCIe r7.0, but historically, issue was that we have to
be careful about putting a non-prefetchable BAR in a prefetchable
window because a read (which might be a prefetch) in a
non-prefetchable BAR is allowed to have side effects.

But if we put a prefetchable BAR in a non-prefetchable window, nothing
bad happens other than performance might be bad.

Are we trying to warn about a potential performance problem?  Or is
there some functional problem here?

> In the kernel there is a check that prints a warning if a
> non-prefetchable resource's size exceeds the 32-bit limit.
> 
> The check currently checks the size of the resource, while actually the
> check should be done on the PCIe end address of the non-prefetchable
> window.
> 
> Move the check to devm_of_pci_get_host_bridge_resources() where the PCIe
> addresses are available and use the end address instead of the size of
> the window.

Are you seeing an issue here?  Can we include a dmesg snippet that
illustrates it?

> Fixes: fede8526cc48 (PCI: of: Warn if non-prefetchable memory aperture
> size is > 32-bit)
> Signed-off-by: Wannes Bouwen <wannes.bouwen@nokia.com>
> ---
> 
> v4:
>   - Update warning text
> 
> v3:
>   - Update subject and description + add changelog
> 
> v2:
>   - Use PCI address range instead of window size to check that window is
>     within a 32bit boundary.
> 
> ---
>  drivers/pci/of.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3579265f1198..16405985a53a 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -400,6 +400,13 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  			*io_base = range.cpu_addr;
>  		} else if (resource_type(res) == IORESOURCE_MEM) {
>  			res->flags &= ~IORESOURCE_MEM_64;
> +
> +			if (!(res->flags & IORESOURCE_PREFETCH))
> +				if (upper_32_bits(range.pci_addr + range.size - 1))
> +					dev_warn(dev,
> +						"host bridge non-prefetchable window: pci range end address exceeds 32 bit boundary %pR"
> +						" (pci address range [%#012llx-%#012llx])\n",
> +						res, range.pci_addr, range.pci_addr + range.size - 1);

I gave you bad advice because I hadn't looked earlier in this
function.  devm_of_pci_get_host_bridge_resources() printed this
earlier:

  MEM  %#012llx..%#012llx -> %#012llx

where the first part is basically the %pR information in a different
format and the last part is the bus address, and I think a warning
here should look similar, e.g.,

  dev_warn(dev, "Bus address %#012llx..%#012llx end is past 32-bit boundary\n",

>  		}
>  
>  		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
> @@ -622,10 +629,6 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>  		case IORESOURCE_MEM:
>  			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
>  
> -			if (!(res->flags & IORESOURCE_PREFETCH))
> -				if (upper_32_bits(resource_size(res)))
> -					dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");
> -
>  			break;
>  		}
>  	}
> -- 
> 2.43.5

