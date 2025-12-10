Return-Path: <linux-pci+bounces-42881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3CFCB2C9A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 12:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D04A3046995
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 11:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862F6306D49;
	Wed, 10 Dec 2025 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFifrqev"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76CE22370A
	for <linux-pci@vger.kernel.org>; Wed, 10 Dec 2025 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765364954; cv=none; b=MvGnqSH5q7QbkaHHjRf9jJa98ElVRWOzFjXW9fBYYMpMQP/ZkMSBUpwmcMOXmoct8G87zBh5n9FVwUhWZydiZuKjv3ZBg4od5QTeDRG8auxraMeb352ZdekKhDASLdY8TYUd2TFmzXCaGkbEU6z4g49SZwHmCoWaUs4PQfXOHPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765364954; c=relaxed/simple;
	bh=SMxlR4VvmbHJJpRlRca9hB2Zue0coaz6Le3qayVs0uI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MXuMNubI2vFftTS7xXWJqDdXzXCF+5CB4d4x43/F7HzS/x+QMQnjN/ixcATWfwm9p2YnHgpvkmF8ELWpONPiwP5z3uogaTdOAb2osbBiJxP8p/cMmCTt3GC/sGGr70m1wX5DpcBkjOg34RDL293N8AFcsoPCGEeiCD00WJm7xQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFifrqev; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765364953; x=1796900953;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SMxlR4VvmbHJJpRlRca9hB2Zue0coaz6Le3qayVs0uI=;
  b=DFifrqevbQ34Ev7ey6OZ+KErB2caQXhi4mqumfPxU1cT901vkKJ1SSXi
   OYvdCxPgi67neAEaWdxshWLYh470EGFR9qWZ9FqPfnEsUie2kB6SEUJ+y
   0UDxtg6d1a35StiEluFj7TVtlICXT4sie6WG/xRHBPp/1X9mWowDenI6L
   bYwmNLnD0hUukLaRbcKymuvMc9ZxQGF4fcftyG2C9S9CwJmqnEVQV+fIE
   nMUv3Y7nmOVINpKSVLSrlGQ8BzZoVrf08Em7BJWeIwEyTQ11K1MiKMtGq
   rz7QCiHHjv8LUFFd0lm8m6iLyUJnB20XJLzl21Lt+biUazPltv86TRpc5
   w==;
X-CSE-ConnectionGUID: fBfSnZlWTbiBzjHxetlEjg==
X-CSE-MsgGUID: n0gY/L6dQjO8emc3WojJjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="54878914"
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="54878914"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 03:09:12 -0800
X-CSE-ConnectionGUID: qvqddm+2QhG3vFBpeoBxKA==
X-CSE-MsgGUID: Ce28sYTORv6DG+t83t1W4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="233889153"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 03:09:10 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 10 Dec 2025 13:09:05 +0200 (EET)
To: Guixin Liu <kanie@linux.alibaba.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Andy Shevchenko <andriy.shevchenko@intel.com>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    linux-pci@vger.kernel.org
Subject: Re: [PATCH v6] PCI: Check rom header and data structure addr before
 accessing
In-Reply-To: <20251210033551.107530-1-kanie@linux.alibaba.com>
Message-ID: <f97a1520-a21c-22a4-fd0f-f8a1b5852d6f@linux.intel.com>
References: <20251210033551.107530-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 10 Dec 2025, Guixin Liu wrote:

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
> And also, convert some magic number to named defines.
> 
> Fixes: 47b975d234ea ("PCI: Avoid iterating through memory outside the resource window")
> Suggested-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
> v5 -> v6:
> - Convert some magic number to named defines, suggested by
> Ilpo, thanks.
> 
> v4 -> v5:
> - Add Andy Shevchenko's rb tag, thanks.
> - Change u64 to unsigned long.
> - Change pci_rom_header_valid() to pci_rom_is_header_valid() and
> change pci_rom_data_struct_valid() to pci_rom_is_data_struct_valid().
> - Change rom_end from rom+size to rom+size-1 for more readble,
> and also change header_end >= rom_end to header_end > rom_end, same
> as data structure end.
> - Change if(!last_image) to if (last_image)..
> - Use U16_MAX instead of 0xffff.
> - Split check_add_overflow() from data_len checking.
> - Remove !!() when reading last_image, and Use BIT(7) instead of 0x80.
> 
> v3 -> v4:
> - Use "u64" instead of "uintptr_t".
> - Invert the if statement to avoid excessive indentation.
> - Add comment for alignment checking.
> - Change last_image's type from int to bool.
> 
> v2 -> v3:
> - Add pci_rom_header_valid() helper for checking image addr and signature.
> - Add pci_rom_data_struct_valid() helper for checking data struct add
> and signature.
> - Handle overflow issue when adding addr with size.
> - Handle alignment fault when running on arm64.
> 
> v1 -> v2:
> - Fix commit body problems, such as blank line in "Call Trace" both sides,
>   thanks, (Andy Shevchenko).
> - Remove every step checking, just check the addr is in header or data struct.
> - Add Suggested-by: Guanghui Feng <guanghuifeng@linux.alibaba.com> tag.
>  drivers/pci/rom.c | 123 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 101 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
> index e18d3a4383ba..9480589899fa 100644
> --- a/drivers/pci/rom.c
> +++ b/drivers/pci/rom.c
> @@ -12,6 +12,15 @@
>  
>  #include "pci.h"
>  
> +#define PCI_ROM_HEADER_SIZE 0x1A
> +#define PCI_ROM_POINTER_TO_DATA_STRUCT 0x18
> +#define PCI_ROM_LAST_IMAGE_INDICATOR 0x15
> +#define PCI_ROM_IMAGE_LEN 0x10
> +#define PCI_ROM_IMAGE_LEN_UNIT_BYTES 512

SZ_512 + add include.

> +#define PCI_ROM_IMAGE_SIGNATURE 0xAA55
> +#define PCI_ROM_DATA_STRUCT_SIGNATURE 0x52494350
> +#define PCI_ROM_DATA_STRUCT_LEN 0x0A

Can you please align the values with tabs.

> +
>  /**
>   * pci_enable_rom - enable ROM decoding for a PCI device
>   * @pdev: PCI device to enable
> @@ -69,6 +78,86 @@ void pci_disable_rom(struct pci_dev *pdev)
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
> +
> +	/*
> +	 * Some CPU architectures require IOMEM access addresses to
> +	 * be aligned, for example arm64, so since we're about to
> +	 * call readw(), we check here for 2-byte alignment.
> +	 */
> +	if (!IS_ALIGNED((unsigned long)image, 2))

Add include for IS_ALIGNED().

> +		return false;
> +
> +	if (check_add_overflow((unsigned long)image, PCI_ROM_HEADER_SIZE,

Add include.

> +	    &header_end))

Aligned to a wrong (.

> +		return false;
> +
> +	if (image < rom || header_end > rom_end)
> +		return false;
> +
> +	/* Standard PCI ROMs start out with these bytes 55 AA */
> +	if (readw(image) == PCI_ROM_IMAGE_SIGNATURE)

Missing include for readw() (a pre-existing problem in this file).

> +		return true;
> +
> +	if (last_image)
> +		pci_info(pdev, "Invalid PCI ROM header signature: expecting %#06x, got %#06x\n",
> +			 PCI_ROM_IMAGE_SIGNATURE, readw(image));
> +	else

Add braces as the block is multiple lines.

> +		pci_info(pdev, "No more image in the PCI ROM\n");
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
> +	    &end))

Aligned to a wrong (.

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
> +	if (readl(pds) == PCI_ROM_DATA_STRUCT_SIGNATURE)
> +		return true;
> +
> +	pci_info(pdev, "Invalid PCI ROM data signature: expecting %#010x, got %#010x\n",
> +		 PCI_ROM_DATA_STRUCT_SIGNATURE, readl(pds));
> +	return false;
> +}
> +
>  /**
>   * pci_get_rom_size - obtain the actual size of the ROM image
>   * @pdev: target PCI device
> @@ -84,37 +173,27 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
>  			       size_t size)
>  {
>  	void __iomem *image;
> -	int last_image;
> +	bool last_image;
>  	unsigned int length;
>  
>  	image = rom;
>  	do {
>  		void __iomem *pds;
> -		/* Standard PCI ROMs start out with these bytes 55 AA */
> -		if (readw(image) != 0xAA55) {
> -			pci_info(pdev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
> -				 readw(image));
> +
> +		if (!pci_rom_is_header_valid(pdev, image, rom, size, true))
>  			break;
> -		}
> +
>  		/* get the PCI data structure and check its "PCIR" signature */
> -		pds = image + readw(image + 24);
> -		if (readl(pds) != 0x52494350) {
> -			pci_info(pdev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
> -				 readl(pds));
> +		pds = image + readw(image + PCI_ROM_POINTER_TO_DATA_STRUCT);
> +		if (!pci_rom_is_data_struct_valid(pdev, pds, rom, size))
>  			break;
> -		}
> -		last_image = readb(pds + 21) & 0x80;
> -		length = readw(pds + 16);
> -		image += length * 512;
> -		/* Avoid iterating through memory outside the resource window */
> -		if (image >= rom + size)
> +
> +		last_image = readb(pds + PCI_ROM_LAST_IMAGE_INDICATOR) & BIT(7);

You forgot to name this BIT(7).

> +		length = readw(pds + PCI_ROM_IMAGE_LEN);
> +		image += length * PCI_ROM_IMAGE_LEN_UNIT_BYTES;

I'd have put the define conversion to own patch to reduce extra line 
changes in the fix itself.

> +		if (!pci_rom_is_header_valid(pdev, image, rom, size, last_image))
>  			break;
> -		if (!last_image) {
> -			if (readw(image) != 0xAA55) {
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


