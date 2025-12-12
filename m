Return-Path: <linux-pci+bounces-43003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62336CB9167
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 16:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E123730840D2
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 15:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AEC1FBC8C;
	Fri, 12 Dec 2025 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZbCJ0lQi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF43800
	for <linux-pci@vger.kernel.org>; Fri, 12 Dec 2025 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765552650; cv=none; b=HAIGu+A8blTQ2/VXPvCi2cuM/EqDf9cgzzTLQpf/2qLI42Bloqj6DBMHVrAhziJRpmGTGJKFCLfyK6GBc9a6NckOBODAQ6mNRefylOtlFdj2wc4dN5U+0eZizQWvJbz07oVTIJT7zJui5s1jJjCLDXJ3wWFFddtJBWGihHkiCAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765552650; c=relaxed/simple;
	bh=caC1MqA5qXge211eNNz8SUw7Glf57Kgq0Edhp09Oz0g=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lUvai/pyhdt6DpK/wcqE1E1Z7c/Iweb0cSk6Jlg08F1hqU6VQUF8TTCvGlIOgmKtTJcc4ZnTXm5ygk7QDWaodiL1ldZUd0tzBEp9PyrErGM0SQHdVac6ucRgYk5DQck6L7fdS29Ou740P7oQSaNicv1/99OpxZuE9ktWQPkX4Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZbCJ0lQi; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765552649; x=1797088649;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=caC1MqA5qXge211eNNz8SUw7Glf57Kgq0Edhp09Oz0g=;
  b=ZbCJ0lQilpvsEixLKwFLORe0YdK2Fut5Y9tygkSJASjJ9k8fPvNGZfjx
   uQ7ooRZueYhF5kBZijVCOwLjXAX8cHTuvoMnITgUNNQu6+G5czIc3CNb4
   yGOxbM2ixIam+PQVICLLCnC4MeGdrVP5oKOIQdGnVK0KaqptRF+KcG5R2
   BnDg11AgNr/+BFwuBptPxXnYNRYS+40eXKI6FWPFZw9zjQ7d2E+kJSsDk
   ea+q4bl6YZtGw0rxjr1wQeqTO/r4+A4zemzl5KxHx3oylwzkdPooBXFg0
   aoys1uoqok7cpgMvtmNHjZHEoK+nexlWhU9zPrRZLbjLuuSsabAtxFsxt
   g==;
X-CSE-ConnectionGUID: ZLP49F8aS52BA56pdgJrog==
X-CSE-MsgGUID: lczFVSrMS8GDgNdHJNzrjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="90207090"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="90207090"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 07:17:28 -0800
X-CSE-ConnectionGUID: TDB0UU/DQrmqmevU0acUIw==
X-CSE-MsgGUID: M1Y+E2EQSLaglnzcoVl4cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="201589472"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 07:17:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Dec 2025 17:17:23 +0200 (EET)
To: Guixin Liu <kanie@linux.alibaba.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Andy Shevchenko <andriy.shevchenko@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v10 1/2] PCI: Introduce named defines for pci rom
In-Reply-To: <20251212093711.36407-2-kanie@linux.alibaba.com>
Message-ID: <a3fd2c30-91da-6202-f46d-23aa66f947f2@linux.intel.com>
References: <20251212093711.36407-1-kanie@linux.alibaba.com> <20251212093711.36407-2-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 12 Dec 2025, Guixin Liu wrote:

The subject still seems to have lowercase "pci rom" :-(.

-- 
 i.

> Convert the magic numbers associated with PCI ROM into named
> definitions. Some of these definitions will be used in the second
> fix patch.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  drivers/pci/rom.c | 38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
> index e18d3a4383ba..4f7641b93b4b 100644
> --- a/drivers/pci/rom.c
> +++ b/drivers/pci/rom.c
> @@ -5,13 +5,28 @@
>   * (C) Copyright 2004 Jon Smirl <jonsmirl@yahoo.com>
>   * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
>   */
> +
> +#include <linux/bits.h>
>  #include <linux/kernel.h>
>  #include <linux/export.h>
>  #include <linux/pci.h>
> +#include <linux/sizes.h>
>  #include <linux/slab.h>
>  
>  #include "pci.h"
>  
> +#define PCI_ROM_HEADER_SIZE			0x1A
> +#define PCI_ROM_POINTER_TO_DATA_STRUCT		0x18
> +#define PCI_ROM_LAST_IMAGE_INDICATOR		0x15
> +#define PCI_ROM_LAST_IMAGE_INDICATOR_BIT	BIT(7)
> +#define PCI_ROM_IMAGE_LEN			0x10
> +#define PCI_ROM_IMAGE_SECTOR_SIZE		SZ_512
> +#define PCI_ROM_IMAGE_SIGNATURE			0xAA55
> +
> +/* Data structure signature is "PCIR" in ASCII representation */
> +#define PCI_ROM_DATA_STRUCT_SIGNATURE		0x52494350
> +#define PCI_ROM_DATA_STRUCT_LEN			0x0A
> +
>  /**
>   * pci_enable_rom - enable ROM decoding for a PCI device
>   * @pdev: PCI device to enable
> @@ -91,26 +106,27 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
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
> +		image += length * PCI_ROM_IMAGE_SECTOR_SIZE;
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

