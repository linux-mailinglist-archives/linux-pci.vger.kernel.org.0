Return-Path: <linux-pci+bounces-30089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 641B0ADF238
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1197817FAD6
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 16:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421B22EA726;
	Wed, 18 Jun 2025 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXg15e9j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C36D2EB5C5
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263236; cv=none; b=HT7ODNQlCiljvgr6u1tWGNi8+umwLWD+KXwWM4SKGP6KJdhB4dAPPFdmdc/6+NDANz8px01Md1/GSntoOXeowPqOrxZVX7OzHWEaglO7i00CoL1wHSA94MYEbpiueUDLdmYbgbindM69eOv2R++L+g4b4ZUtecgsZJQiaBIDqKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263236; c=relaxed/simple;
	bh=fbuM+mm3CzXhR4Vx6fz24E6YgGaASNAJe7RFsbZoZr8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p2JwUsJU98uimIniZolyD6DmOvt0+Sq1bZ49Xz8MsEsHMixf7uSbb6qhZ+ADU7cGrsXmsGDSUTbCj4iZu//mR1YKYdYqlWxi6TMcM+4Hx+9YIDybvQZVEkbWDq/xlXeASrVtEyknhNg0JDM21vtcbVcuIVK1XczR8qdrNAIPvnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXg15e9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC4EC4CEE7;
	Wed, 18 Jun 2025 16:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750263235;
	bh=fbuM+mm3CzXhR4Vx6fz24E6YgGaASNAJe7RFsbZoZr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YXg15e9jO7zj7yxrJrcm+72b1bgthGqbSMWNRxAMOuKHOFEYB5likqlVZpCTU/SSZ
	 Zab3hI4KaLIQfr8bGB5sSvDk9zQ4IDpg3jX62Y7JqdrsVMhqZhOW/4q3QTMuatchJm
	 23dKiflKQ/QbUvuviZENBPT5hoPfZu2VVaCglnELXyLUfBycd97iBoQOWZWpyrHrtp
	 hNJtP61SlXkEiKtK23WTBmc2bxaRvl0rGIYbZaBSkb8ml36y/CAytlpxFJraaFQ6vy
	 SgA6eOEhZP8eRXl0RXVlYrTEZMs9SGe99osj9PeFwj3k4uTU2LETSQ5frXgGUHyAKK
	 NsjNvf/3O10uQ==
Date: Wed, 18 Jun 2025 11:13:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Wannes Bouwen (Nokia)" <wannes.bouwen@nokia.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
	Vidya Sagar <vidyas@nvidia.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [v3 PATCH 1/1] PCI: of: fix non-prefetchable region address
 range check.
Message-ID: <20250618161353.GA1203949@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR07MB88380E01F75CBC2209C23CA0FD72A@PA4PR07MB8838.eurprd07.prod.outlook.com>

On Wed, Jun 18, 2025 at 01:56:17PM +0000, Wannes Bouwen (Nokia) wrote:
> [v3 PATCH 1/1] PCI: of: fix non-prefetchable region address range check.
> 
> According to the PCIe spec (PCIe r6.3, sec 7.5.1.3.8), non-prefetchable
> memory supports only 32-bit host bridge windows (both base address as
> limit address).
>
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
> 
> Fixes: fede8526cc48 (PCI: of: Warn if non-prefetchable memory aperture
> size is > 32-bit)
> Signed-off-by: Wannes Bouwen <wannes.bouwen@nokia.com>
> ---
> 
> v3:
>   - Update subject and description + add changelog
> 
> v2:
>   - Use PCI address range instead of window size to check that window is
>     within a 32bit boundary.
> 
> ---
>  drivers/pci/of.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3579265f1198..4fffa32c7c3d 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -400,6 +400,10 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  			*io_base = range.cpu_addr;
>  		} else if (resource_type(res) == IORESOURCE_MEM) {
>  			res->flags &= ~IORESOURCE_MEM_64;
> +
> +			if (!(res->flags & IORESOURCE_PREFETCH))
> +				if (upper_32_bits(range.pci_addr + range.size - 1))
> +					dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");

Seems mostly right to me.  I think we should update the message to
talk about the *address* instead of the size, since that's the real
problem.  Also would be nice to include the resource (%pR) and the
corresponding bus addresses as we do in pci_register_host_bridge().

>  		}
>  
>  		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
> @@ -622,10 +626,6 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
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
> 

