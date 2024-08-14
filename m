Return-Path: <linux-pci+bounces-11666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F161C9519E4
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 13:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A57E1F23AEC
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 11:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC99A143C6C;
	Wed, 14 Aug 2024 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9ntpnv3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D9A1AED49;
	Wed, 14 Aug 2024 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635047; cv=none; b=H2cfH9RTAabYGK+spfF87gSDnTBR5QfGX3M+suTgioupBiBJc+qWcIgaNF8apAyBn4V88NuM6yksT9tw6nwKECwGptoVTEmyK/mo7KQPSQdzIDxfpaA7d9iHeOIWPwM5LJiRMPSNLFyP8c9SfBuS6z7s66IxvwzXe7jam+P++Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635047; c=relaxed/simple;
	bh=v4i7+M7R3l/2J66lFFjUQniUMJfveYXx1+GeKcjXc8Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fKfYRFBAOd2UedtzKv80uCKan2cgNzf484PkVyq6eOjj0P6psriiPf4cozwuXBMIAbpgkrMZlAbWxiAWzisXb0gVet9ysykBn/Chixoq5oYYf9Ptj5vqQ2W8ctuGy23aFUvQiYCYUF4LfhBlhEeabBQscAczK8XZ/4ceJ24VcqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9ntpnv3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723635046; x=1755171046;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=v4i7+M7R3l/2J66lFFjUQniUMJfveYXx1+GeKcjXc8Y=;
  b=H9ntpnv3zJTApu/Vs//UZ7mwxehruPQM1UYGVSTb+V2vcGROsqhqB3Kc
   FZ80R7B6BxeSLDB3cJabZaKPrXD16a1WlArz+p3d/at6fdAmWc49k2xQq
   4+GdnQb57Bjtpy+s61R7NXNiaG3LZG3kNt9Uh1I8zrHr317Cmh4RlDa/l
   aEDeruEK0lAOGgucEoZJ4lp1Y6MgImBsUGQQULLImrSO8SI7e/WQa/q6B
   eNR/7KbTFgnfhHt2Ga0Mw2MuEOzHMKGe/MqAfFraIgdV+H16+Fh8V37i5
   Mnit8izcWuHtj6NPzNxqi/dt24OlTdLvPQpfWVUjPtjwkhX2frZN96Tme
   w==;
X-CSE-ConnectionGUID: iJ5K0KdzT0C4nelYu9Vr8g==
X-CSE-MsgGUID: 8ytjYKkkQIqem7d7Cxl8lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21995393"
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; 
   d="scan'208";a="21995393"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 04:30:45 -0700
X-CSE-ConnectionGUID: sn6jr7IPSISvp3n+/QqpSA==
X-CSE-MsgGUID: KzS3VPP9TOGxPQm+oMkQQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; 
   d="scan'208";a="59556046"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 04:30:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 14 Aug 2024 14:30:39 +0300 (EEST)
To: Miao Wang <shankerwangmiao@gmail.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: PCI: check if the io space is page aligned
In-Reply-To: <20240814-check_pci_probe_res-v2-1-a03c8c9b498b@gmail.com>
Message-ID: <4c34b0b0-c6c9-6c5e-2dbe-8b34b38b040b@linux.intel.com>
References: <20240814-check_pci_probe_res-v2-1-a03c8c9b498b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 14 Aug 2024, Miao Wang via B4 Relay wrote:

> From: Miao Wang <shankerwangmiao@gmail.com>
> 
> When the IO resource given by _CRS method is not page aligned, serious

Is this seen on some system? Could that be documented for future 
reference.

Also, I suggest you add "root" into the shortlog and desciption to 
explain the limited scope of this change because IIRC, somebody wanted to 
allow <4k aligned IO resources under certain conditions.

> problems will happen because the mis-aligend address is passed down to

aligned

> pci_remap_iospace, then to vmap_page_range, and finally to

Add () to any function names.

> vmap_pte_range, where the length bewteen addr and end is expected to be

between

> divisible by PAGE_SIZE, or the loop will overrun till the pfn_none check
> fails.
> 
> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> ---
> Changes in v2:
> - Sorry for posting out the draft version in V1, fixed a silly compiling issue.
> - Link to v1: https://lore.kernel.org/r/20240814-check_pci_probe_res-v1-1-122ee07821ab@gmail.com
> ---
>  drivers/acpi/pci_root.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index d0bfb3706801..706449e5f29b 100644
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
> +		!PAGE_ALIGNED(pci_addr)) {

Align this line so that ! are under each other. As is, it 
misleadingly looks on a quick glance to belong into the code block.

> +		dev_err(&device->dev,
> +			FW_BUG "I/O resource %pR or its offset %pa is not page aligned\n",
> +			res, &entry->offset);
> +		goto err;
> +	}
> +
> +	if (pci_register_io_range(&device->fwnode, cpu_addr, length))
>  		goto err;
>  
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


-- 
 i.


