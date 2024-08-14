Return-Path: <linux-pci+bounces-11675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C02952021
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 18:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261E81C217E8
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 16:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BA61B3748;
	Wed, 14 Aug 2024 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/xMr0H5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3C1B86D1;
	Wed, 14 Aug 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653434; cv=none; b=dfG/dVXFewKZlgXfUndyNK1mucbHT7hCBy3ks3h4IQVDpRWoOWl5W6zRCYTZyf+3HojPAwqw0qAquZhgeSoU1saL3k3dxH6h2hUi1lcmBmw72zldHImkk64NYsppU0HeHPJeYuQPf+U2ss2cLUd61oV9a4Hf/1MMny7+Kw1PMsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653434; c=relaxed/simple;
	bh=6RJi14OWFncm4pr5rNS4VYJAxaixOf/qt2UvNYUHlGs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=imBJmMron4OiiUlDfQkMc9OeFFmcvrIQAzs1S8w+WxOoy5k0rtermgLf4+zOm3FBemsLv5lY8zqh6Xc2PjwDhYU9ZWVb1f0JF4OSHeuVs2U23172XMtGQIPm26E47FhY89hD7OSxuvsLXoTFm3z3DOtM7VbIMvr2LXnG2552YBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/xMr0H5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66712C116B1;
	Wed, 14 Aug 2024 16:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723653433;
	bh=6RJi14OWFncm4pr5rNS4VYJAxaixOf/qt2UvNYUHlGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=h/xMr0H5zKif+MNaGHUajjGxNuAubvRat9btd7tMkvLATRe/2ui4G16qWnZzYjfEb
	 4kpuHeHKjnJva71CApWlQVD/H/JzFWrOS21FSgW4MS2oLS+Xn7vU6qbjGoQHsrIPbA
	 jCyDz1h3r7h3nyAr8K/qOJOsjo0OIWagkkhFXRocNXhGsljX2vZwlLhtE+mnCEqJ1x
	 vFFBDyCiAdwjGVOwx9VAnLl6E7JDI+9umBueXOAMDwfsqg/h33Tkrm4Ua/shR1RIpP
	 9ecFpA0WM60CQ1hzgM7SqvIUvnKgLMK/Wlo9QIBNXbwo/8r6rTQS4JELFnEY2yn6zd
	 NpSAEniob9nhg==
Date: Wed, 14 Aug 2024 11:37:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: shankerwangmiao@gmail.com
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] ACPI: PCI: check if the root io space is page aligned
Message-ID: <20240814163711.GA351420@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814-check_pci_probe_res-v3-1-b6eaa6f99032@gmail.com>

[+cc linux-mm for vmap page alignment checking question]

On Wed, Aug 14, 2024 at 08:09:15PM +0800, Miao Wang via B4 Relay wrote:
> From: Miao Wang <shankerwangmiao@gmail.com>
> 
> When the IO resource given by _CRS method is not page aligned, especially
> when the page size is larger than 4KB, serious problems will happen
> because the misaligned address is passed down to pci_remap_iospace(),
> then to vmap_page_range(), and finally to vmap_pte_range(), where the
> length between addr and end is expected to be divisible by PAGE_SIZE, or
> the loop will overrun till the pfn_none check fails.

What does this problem look like to a user?  Panic, oops, hang,
warning backtrace?  I assume this is not a regression, but maybe
something you tripped over because of a BIOS defect?  Does this need
to be backported to stable kernels?

It seems sort of weird to me that all those vmap_*_range() functions
take the full page address (not a PFN) and depend on the addr/size
being page-aligned, but they don't validate the alignment.  But I'm
not a VM person and I suppose there's a reason for passing the full
address.

But it does mean that other users of vmap_page_range() are also
potentially susceptible to this issue, e.g., vmap(), vm_map_ram(),
ioremap_page_range(), etc., so I'm not sure that
acpi_pci_root_remap_iospace() is the best place to check the
alignment.

> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> ---
> Changes in v3:
> - Adjust code formatting.
> - Reword the commit message for further description of the possible reason
>   leading to misaligned IO resource addresses.
> - Link to v2: https://lore.kernel.org/r/20240814-check_pci_probe_res-v2-1-a03c8c9b498b@gmail.com
> 
> Changes in v2:
> - Sorry for posting out the draft version in V1, fixed a silly compiling issue.
> - Link to v1: https://lore.kernel.org/r/20240814-check_pci_probe_res-v1-1-122ee07821ab@gmail.com
> ---
>  drivers/acpi/pci_root.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index d0bfb3706801..a425e93024f2 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -858,7 +858,7 @@ static void acpi_pci_root_validate_resources(struct device *dev,
>  	}
>  }
>  
> -static void acpi_pci_root_remap_iospace(struct fwnode_handle *fwnode,
> +static void acpi_pci_root_remap_iospace(struct acpi_device *device,
>  			struct resource_entry *entry)
>  {
>  #ifdef PCI_IOBASE
> @@ -868,7 +868,15 @@ static void acpi_pci_root_remap_iospace(struct fwnode_handle *fwnode,
>  	resource_size_t length = resource_size(res);
>  	unsigned long port;
>  
> -	if (pci_register_io_range(fwnode, cpu_addr, length))
> +	if (!PAGE_ALIGNED(cpu_addr) || !PAGE_ALIGNED(length) ||
> +	    !PAGE_ALIGNED(pci_addr)) {
> +		dev_err(&device->dev,
> +			FW_BUG "I/O resource %pR or its offset %pa is not page aligned\n",
> +			res, &entry->offset);
> +		goto err;
> +	}
> +
> +	if (pci_register_io_range(&device->fwnode, cpu_addr, length))
>  		goto err;

This change verifies alignment for the ACPI case that leads to the
pci_remap_iospace() -> vmap_page_range() -> vmap_pte_range() path, but 
there are others even in drivers/pci/, e.g., pci_remap_iospace() is
also used in the DT path, where I suppose a defective DT could cause a
similar issue.

>  	port = pci_address_to_pio(cpu_addr);
> @@ -910,7 +918,7 @@ int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
>  	else {
>  		resource_list_for_each_entry_safe(entry, tmp, list) {
>  			if (entry->res->flags & IORESOURCE_IO)
> -				acpi_pci_root_remap_iospace(&device->fwnode,
> +				acpi_pci_root_remap_iospace(device,
>  						entry);
>  
>  			if (entry->res->flags & IORESOURCE_DISABLED)
> 
> ---
> base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
> change-id: 20240813-check_pci_probe_res-27e3e6df72b2
> 
> Best regards,
> -- 
> Miao Wang <shankerwangmiao@gmail.com>
> 
> 

