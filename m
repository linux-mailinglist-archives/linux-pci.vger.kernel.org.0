Return-Path: <linux-pci+bounces-42950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A3ACB5C67
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 13:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 372673002933
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 12:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B672D0C7E;
	Thu, 11 Dec 2025 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQIe56YK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599982C11CE
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765455470; cv=none; b=E5xersywYSWAMAkjMC90/sWPy5ZD4pMdd4kBvhkm8B71PYt01+90jwZBRfyvq7k6HseBAldtaYBveyFL6FlB0VdXMPAJnVrq1ly06aVhkBYCp3YTS//vzOuB3YhABzWaAHhPvEMxuL+6kp1ojIzDvlFs/ALDlqzZLHoQbhafUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765455470; c=relaxed/simple;
	bh=T9voSQJkPi2EtytpiXoas2UEfL9fibeQUniNcbPUzfA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lJtRnOmEPSqde1FlEIPk0/W9SvjZR2aQOWPw7jdvDIHPROhYEI94HseNSQJfH+aFplZulAJDba7tE7qOhJkHHCKQG5rTtbyOz2xXyPnRL+oMkYcsXfcj5WCO64Uexxulg+Uhzq/g5b+dQUiO2e3IcgGQm2hdZ/ywwx8gLMo1uug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQIe56YK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765455465; x=1796991465;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=T9voSQJkPi2EtytpiXoas2UEfL9fibeQUniNcbPUzfA=;
  b=gQIe56YKx2y9kFrml0aItDnTebasDoMPZttJOuqWHh9VH5nyk/7r/9WR
   iO7dxjP2bZpIVS2SLx9ZsFECS01f6p9W0u7rRjNX/SOT3Ua0xU7RFuPGQ
   sxRb8xgWDiP9gGTrnl/EiYwvpuVlGQP5zzS9ZzkZOMWB8PHdCIQd9QSsX
   kFMP/8dpjSGvHAx5RZp0+SruGqeC+8zzZ8BsOZ9tx30T2r5EyzdNIgWNn
   GjETXNayLXF4X+VLITToL8l5zpVE0DIG/rZst1e2rscvWKHxPIBDYZCoA
   g8BD2zldGVN8CrbNudz5W0npDv5i/bC0OwUjaUzAhTLpc8LZu12fwprcU
   w==;
X-CSE-ConnectionGUID: xTXpF2riRGukXn7zbYFE/g==
X-CSE-MsgGUID: ILTtJFgkTlmZxEi9IwG9hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67167623"
X-IronPort-AV: E=Sophos;i="6.21,265,1763452800"; 
   d="scan'208";a="67167623"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 04:17:45 -0800
X-CSE-ConnectionGUID: nd2SuqZSQqepjASeVs7YwA==
X-CSE-MsgGUID: 15o38D0jRpeCl1cp4luElg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,265,1763452800"; 
   d="scan'208";a="227436760"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.219])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 04:17:43 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Dec 2025 14:17:39 +0200 (EET)
To: Guixin Liu <kanie@linux.alibaba.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Andy Shevchenko <andriy.shevchenko@intel.com>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 2/2] PCI: Check rom header and data structure addr
 before accessing
In-Reply-To: <20251211120540.3362-3-kanie@linux.alibaba.com>
Message-ID: <53567985-e55f-0a0e-5dfb-54c387d771a4@linux.intel.com>
References: <20251211120540.3362-1-kanie@linux.alibaba.com> <20251211120540.3362-3-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 11 Dec 2025, Guixin Liu wrote:

> We meet a crash when running stress-ng on x86_64 machine:
> 
>   BUG: unable to handle page fault for address: ffa0000007f40000
>   RIP: 0010:pci_get_rom_size+0x52/0x220
>   Call Trace:
>   <TASK>
>     pci_map_rom+0x80/0x130
>     pci_read_rom+0x4b/0xe0
>     kernfs_file_read_iter+0x96/0x180
>     vfs_read+0x1b1/0x300
> 
> Our analysis reveals that the rom space's start address is
> 0xffa0000007f30000, and size is 0x10000. Because of broken rom
> space, before calling readl(pds), the pds's value is
> 0xffa0000007f3ffff, which is already pointed to the rom space
> end, invoking readl() would read 4 bytes therefore cause an
> out-of-bounds access and trigger a crash.
> Fix this by adding image header and data structure checking.
> 
> We also found another crash on arm64 machine:
> 
>   Unable to handle kernel paging request at virtual address
> ffff8000dd1393ff
>   Mem abort info:
>   ESR = 0x0000000096000021
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x21: alignment fault
> 
> The call trace is the same with x86_64, but the crash reason is
> that the data structure addr is not aligned with 4, and arm64
> machine report "alignment fault". Fix this by adding alignment
> checking.
> 
> Fixes: 47b975d234ea ("PCI: Avoid iterating through memory outside the resource window")
> Suggested-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
>  drivers/pci/rom.c | 116 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 97 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
> index 3cb0e94f0e86..52a89e126271 100644
> --- a/drivers/pci/rom.c
> +++ b/drivers/pci/rom.c
> @@ -6,9 +6,12 @@
>   * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
>   */
>  
> +#include <linux/align.h>
>  #include <linux/bits.h>
> -#include <linux/kernel.h>
>  #include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/overflow.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  
> @@ -81,6 +84,91 @@ void pci_disable_rom(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL_GPL(pci_disable_rom);
>  
> +static bool pci_rom_is_header_valid(struct pci_dev *pdev,
> +				    void __iomem *image,
> +				    void __iomem *rom,
> +				    size_t size,
> +				    bool last_image)
> +{
> +	unsigned long rom_end = (unsigned long)rom + size - 1;
> +	unsigned long header_end;
> +	unsigned short signature;

Please use u16 (to match readw return type).

> +
> +	/*
> +	 * Some CPU architectures require IOMEM access addresses to
> +	 * be aligned, for example arm64, so since we're about to
> +	 * call readw(), we check here for 2-byte alignment.
> +	 */
> +	if (!IS_ALIGNED((unsigned long)image, 2))
> +		return false;
> +
> +	if (check_add_overflow((unsigned long)image, PCI_ROM_HEADER_SIZE,
> +				&header_end))
> +		return false;
> +
> +	if (image < rom || header_end > rom_end)
> +		return false;
> +
> +	/* Standard PCI ROMs start out with these bytes 55 AA */
> +	signature = readw(image);
> +	if (signature == PCI_ROM_IMAGE_SIGNATURE)
> +		return true;
> +
> +	if (last_image) {
> +		pci_info(pdev, "Invalid PCI ROM header signature: expecting %#06x, got %#06x\n",
> +			 PCI_ROM_IMAGE_SIGNATURE, signature);
> +	} else {
> +		pci_info(pdev, "No more image in the PCI ROM\n");
> +	}
> +
> +	return false;
> +}
> +
> +static bool pci_rom_is_data_struct_valid(struct pci_dev *pdev,
> +					 void __iomem *pds,
> +					 void __iomem *rom,
> +					 size_t size)
> +{
> +	unsigned long rom_end = (unsigned long)rom + size - 1;
> +	unsigned int signature;

u32.

> +	unsigned long end;
> +	u16 data_len;
> +
> +	/*
> +	 * Some CPU architectures require IOMEM access addresses to
> +	 * be aligned, for example arm64, so since we're about to
> +	 * call readl(), we check here for 4-byte alignment.
> +	 */
> +	if (!IS_ALIGNED((unsigned long)pds, 4))
> +		return false;
> +
> +	/* Before reading length, check addr range. */
> +	if (check_add_overflow((unsigned long)pds, PCI_ROM_DATA_STRUCT_LEN + 1,
> +				&end))
> +		return false;
> +
> +	if (pds < rom || end > rom_end)
> +		return false;
> +
> +	data_len = readw(pds + PCI_ROM_DATA_STRUCT_LEN);
> +	if (!data_len || data_len == U16_MAX)
> +		return false;
> +
> +	if (check_add_overflow((unsigned long)pds, data_len, &end))
> +		return false;
> +
> +	if (end > rom_end)
> +		return false;
> +
> +	signature = readl(pds);
> +	if (signature == PCI_ROM_DATA_STRUCT_SIGNATURE)
> +		return true;
> +
> +	pci_info(pdev, "Invalid PCI ROM data signature: expecting %#010x, got %#010x\n",
> +		 PCI_ROM_DATA_STRUCT_SIGNATURE, signature);
> +	return false;
> +}
> +
>  /**
>   * pci_get_rom_size - obtain the actual size of the ROM image
>   * @pdev: target PCI device
> @@ -96,38 +184,28 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
>  			       size_t size)
>  {
>  	void __iomem *image;
> -	int last_image;
>  	unsigned int length;
> +	bool last_image;
>  
>  	image = rom;
>  	do {
>  		void __iomem *pds;
> -		/* Standard PCI ROMs start out with these bytes 55 AA */
> -		if (readw(image) != PCI_ROM_IMAGE_SIGNATURE) {
> -			pci_info(pdev, "Invalid PCI ROM header signature: expecting %#06x, got %#06x\n",
> -				 PCI_ROM_IMAGE_SIGNATURE, readw(image));
> +
> +		if (!pci_rom_is_header_valid(pdev, image, rom, size, true))
>  			break;
> -		}
> +
>  		/* get the PCI data structure and check its "PCIR" signature */
>  		pds = image + readw(image + PCI_ROM_POINTER_TO_DATA_STRUCT);
> -		if (readl(pds) != PCI_ROM_DATA_STRUCT_SIGNATURE) {
> -			pci_info(pdev, "Invalid PCI ROM data signature: expecting %#010x, got %#010x\n",
> -				 PCI_ROM_DATA_STRUCT_SIGNATURE, readl(pds));
> +		if (!pci_rom_is_data_struct_valid(pdev, pds, rom, size))
>  			break;
> -		}
> +
>  		last_image = readb(pds + PCI_ROM_LAST_IMAGE_INDICATOR) &
>  				   PCI_ROM_LAST_IMAGE_INDICATOR_BIT;
>  		length = readw(pds + PCI_ROM_IMAGE_LEN);
>  		image += length * PCI_ROM_IMAGE_LEN_UNIT_SZ_512;
> -		/* Avoid iterating through memory outside the resource window */
> -		if (image >= rom + size)
> +
> +		if (!pci_rom_is_header_valid(pdev, image, rom, size, last_image))
>  			break;
> -		if (!last_image) {
> -			if (readw(image) != PCI_ROM_IMAGE_SIGNATURE) {
> -				pci_info(pdev, "No more image in the PCI ROM\n");
> -				break;
> -			}
> -		}
>  	} while (length && !last_image);
>  
>  	/* never return a size larger than the PCI resource window */
> 

-- 
 i.


