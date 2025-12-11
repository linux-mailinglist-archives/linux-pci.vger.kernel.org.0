Return-Path: <linux-pci+bounces-42949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6D1CB5C48
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 13:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78828301AF73
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 12:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43A33093AE;
	Thu, 11 Dec 2025 12:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SpPNneB0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A32126B08F
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765455274; cv=none; b=Emtmx9UloIcZr32oVCFVQjrry6w/gKipDvxYWnS/IuTqo2/YhAwYGp+42laocDWHld63MwkBSgsQSeAa5FXqN5GePfY5Aed2CUtzyg32qy6bkJCBcavAY6bLK29x29Okk01td5IEkCJQf3spWJI2gQy/ye4f5D8OnimpFf+sibw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765455274; c=relaxed/simple;
	bh=t5pJ6iWlLWS+x5aS2BN1b10Zo75FRY2FLI8zmi6Aygc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=s/QEzlxXk0pvOjiRqpsyNmcph4F2U1UdKbT/fZtj2CAZ32GIDURCswSK7DwdTAJz0/yEUfkJbPp+icy1ogZWKW8uglWhhlPVwLgJrfufasakgLI0cMC9v3iyb6AmIzxdLGIsJ2WbyFzr01VoxXCIllxzOKmSI8QKwosx6LAWZ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SpPNneB0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765455272; x=1796991272;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=t5pJ6iWlLWS+x5aS2BN1b10Zo75FRY2FLI8zmi6Aygc=;
  b=SpPNneB0ADUze+LRu1n/D5W/i5feUs6fVhfEwiXiEpAxe2tkEnHgSlEJ
   AXT3rPydixWtW2csKXTVOGuJPr1WnWabZ8CUA09P4kxDJJjH1VAWaczZZ
   5QbKSbQaSu9tT/TVCSBj0GUZUm5o9iVekiALYhQTYLLp4hrdRvgsmaMUR
   J3JU1c4ecYcLgr9sqbz0E2smYorVUgduk+CuCVK7koods53NG4U0fLCt5
   4aY8/TeZvVJG/CXYdxXw6dCdxmV0/L3+KD1ymRNiioYEsFxFoWH1wCfwS
   9i2cieXk1vUrLzGxeY6REv5XjPukziWyF8PNparSLPMb/ipVg0xIsewfu
   g==;
X-CSE-ConnectionGUID: DkmytAmHQKqiauGbZPY6PQ==
X-CSE-MsgGUID: DXYwKcDLQAm8n8WT9vmv0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="71058858"
X-IronPort-AV: E=Sophos;i="6.21,265,1763452800"; 
   d="scan'208";a="71058858"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 04:14:32 -0800
X-CSE-ConnectionGUID: ggkL7WwSTjWbe/fYv4ADBg==
X-CSE-MsgGUID: KXD1VC3WQsSXFQnS2EbnTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,265,1763452800"; 
   d="scan'208";a="234190482"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.219])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 04:14:30 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Dec 2025 14:14:27 +0200 (EET)
To: Guixin Liu <kanie@linux.alibaba.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Andy Shevchenko <andriy.shevchenko@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 1/2] PCI: Introduce named defines for pci rom
In-Reply-To: <20251211120540.3362-2-kanie@linux.alibaba.com>
Message-ID: <9002bfe1-0dc1-8f0c-3abf-9166c451cbdd@linux.intel.com>
References: <20251211120540.3362-1-kanie@linux.alibaba.com> <20251211120540.3362-2-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 11 Dec 2025, Guixin Liu wrote:

Please capitalize PCI and ROM in the subject.

> This is a preparation patch for the next fix patch.
> Convert some magic numbers to named defines.

This should be reasonable to read even without reading what's in the 
subject first, so it would be better to duplicate the information that 
this relates to PCI ROM header fields ("some" is extremely vague :-)).

> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  drivers/pci/rom.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
> index e18d3a4383ba..3cb0e94f0e86 100644
> --- a/drivers/pci/rom.c
> +++ b/drivers/pci/rom.c
> @@ -5,6 +5,8 @@
>   * (C) Copyright 2004 Jon Smirl <jonsmirl@yahoo.com>
>   * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
>   */
> +
> +#include <linux/bits.h>
>  #include <linux/kernel.h>
>  #include <linux/export.h>
>  #include <linux/pci.h>
> @@ -12,6 +14,16 @@
>  
>  #include "pci.h"
>  
> +#define PCI_ROM_HEADER_SIZE			0x1A
> +#define PCI_ROM_POINTER_TO_DATA_STRUCT		0x18
> +#define PCI_ROM_LAST_IMAGE_INDICATOR		0x15
> +#define PCI_ROM_LAST_IMAGE_INDICATOR_BIT	BIT(7)
> +#define PCI_ROM_IMAGE_LEN			0x10
> +#define PCI_ROM_IMAGE_LEN_UNIT_SZ_512		512

I'm sorry I didn't notice immediately, but this is what I meant:

#define PCI_ROM_IMAGE_LEN_UNIT_BYTES		SZ_512

+ you need linux/sizes.h for SZ_512.

> +#define PCI_ROM_IMAGE_SIGNATURE			0xAA55
> +#define PCI_ROM_DATA_STRUCT_SIGNATURE		0x52494350
> +#define PCI_ROM_DATA_STRUCT_LEN			0x0A
> +
>  /**
>   * pci_enable_rom - enable ROM decoding for a PCI device
>   * @pdev: PCI device to enable
> @@ -91,26 +103,27 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
>  	do {
>  		void __iomem *pds;
>  		/* Standard PCI ROMs start out with these bytes 55 AA */
> -		if (readw(image) != 0xAA55) {
> -			pci_info(pdev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
> -				 readw(image));
> +		if (readw(image) != PCI_ROM_IMAGE_SIGNATURE) {
> +			pci_info(pdev, "Invalid PCI ROM header signature: expecting %#06x, got %#06x\n",
> +				 PCI_ROM_IMAGE_SIGNATURE, readw(image));
>  			break;
>  		}
>  		/* get the PCI data structure and check its "PCIR" signature */
> -		pds = image + readw(image + 24);
> -		if (readl(pds) != 0x52494350) {
> -			pci_info(pdev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
> -				 readl(pds));
> +		pds = image + readw(image + PCI_ROM_POINTER_TO_DATA_STRUCT);
> +		if (readl(pds) != PCI_ROM_DATA_STRUCT_SIGNATURE) {
> +			pci_info(pdev, "Invalid PCI ROM data signature: expecting %#010x, got %#010x\n",
> +				 PCI_ROM_DATA_STRUCT_SIGNATURE, readl(pds));
>  			break;
>  		}
> -		last_image = readb(pds + 21) & 0x80;
> -		length = readw(pds + 16);
> -		image += length * 512;
> +		last_image = readb(pds + PCI_ROM_LAST_IMAGE_INDICATOR) &
> +				   PCI_ROM_LAST_IMAGE_INDICATOR_BIT;
> +		length = readw(pds + PCI_ROM_IMAGE_LEN);
> +		image += length * PCI_ROM_IMAGE_LEN_UNIT_SZ_512;
>  		/* Avoid iterating through memory outside the resource window */
>  		if (image >= rom + size)
>  			break;
>  		if (!last_image) {
> -			if (readw(image) != 0xAA55) {
> +			if (readw(image) != PCI_ROM_IMAGE_SIGNATURE) {
>  				pci_info(pdev, "No more image in the PCI ROM\n");
>  				break;
>  			}
> 

The code change looked fine otherwise.

-- 
 i.


