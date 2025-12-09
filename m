Return-Path: <linux-pci+bounces-42826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26613CAF1C6
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 08:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF872301E140
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 07:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBFB168BD;
	Tue,  9 Dec 2025 07:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHzYXiy2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E93DF76
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765264742; cv=none; b=d9eczf1EzQ822xzXTU48jAOxlEmJKYzZA2fhSKEYV/vi+dwSevxVkkkPqBZcgpZR5HFTdqEj3TXiIWaQPI4heS8+K+oda6iH2ne0MhfQciIszW4CIrCBW13m++Y7EZYFXJy2yjPInIIyQd3eEdc6Q/VCO3q/riKcPOfo+RnjwQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765264742; c=relaxed/simple;
	bh=aYiYXVhlxqkiQMwUlvNEq1Y3+dYQOwRuM5xyi/g7Olw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HZSFdFYYydpOOI4VoypVaO2fWjFKqe5LJ8FcjUuf2FSVF6J/fqJZF7IKoqYXotUD2qyzU1EUURgsvVqPTznV0RB8z4bWC410ZfSDkgB7Jf+HRqiNG9alCVZof+6dhixiPv31RHOucSrZgjJlqIQJwqCgFVBRxN2WxS2aVHH+0kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHzYXiy2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765264739; x=1796800739;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aYiYXVhlxqkiQMwUlvNEq1Y3+dYQOwRuM5xyi/g7Olw=;
  b=oHzYXiy2DZIA4w8jB5WNxf+pSSLPhhWM+/7pN5UE5aUbveZt/ttO9sqT
   o4LaG7ArtYYKcUCBZgvYixu+wQ25ZuJKjalakdOominV2wWMi+ZYxRcuO
   58M78mY5f8FBrxivrgOoEAxZBSylS0lrX/dBqXadJhHWEliEUljOHTVgT
   bgaASct2QlSF0uSAfBrSBnr28dnhPOFlirez5VcIUigjAiApf3gvRDWup
   r/hplpzbfZNNFQeOvOydl4PBw7akuy4FWkuP9ON0uOzqBdLAXGeIcv8HT
   lAZllTiRyWO+1MS2dH84J53vRSb/WeVOQopurtgSShwoyFcidpuIn6GnO
   g==;
X-CSE-ConnectionGUID: Lq0uFvnWQt220+UEabfsXQ==
X-CSE-MsgGUID: qH2yNxgcSKaQ944YLp+ZSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="66940160"
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; 
   d="scan'208";a="66940160"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 23:18:59 -0800
X-CSE-ConnectionGUID: PaDUKGCxQDqsbewC1g2EfQ==
X-CSE-MsgGUID: l4jCzTrHT6i0dLWPcQ+oWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; 
   d="scan'208";a="195230404"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.139])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 23:18:57 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 9 Dec 2025 09:18:53 +0200 (EET)
To: Guixin Liu <kanie@linux.alibaba.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Andy Shevchenko <andriy.shevchenko@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND v5] PCI: Check rom header and data structure addr
 before accessing
In-Reply-To: <20251209055114.66392-1-kanie@linux.alibaba.com>
Message-ID: <5c2fb339-80df-3cbd-4477-05b2773b45d3@linux.intel.com>
References: <20251209055114.66392-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 9 Dec 2025, Guixin Liu wrote:

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
>  drivers/pci/rom.c | 109 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 90 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
> index e18d3a4383ba..b0de38211f39 100644
> --- a/drivers/pci/rom.c
> +++ b/drivers/pci/rom.c
> @@ -69,6 +69,87 @@ void pci_disable_rom(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL_GPL(pci_disable_rom);
>  
> +#define PCI_ROM_HEADER_SIZE 0x1A
> +
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
> +		return false;
> +
> +	if (check_add_overflow((unsigned long)image, PCI_ROM_HEADER_SIZE,
> +	    &header_end))
> +		return false;
> +
> +	if (image < rom || header_end > rom_end)
> +		return false;
> +
> +	/* Standard PCI ROMs start out with these bytes 55 AA */
> +	if (readw(image) == 0xAA55)
> +		return true;
> +
> +	if (last_image)
> +		pci_info(pdev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
> +			 readw(image));
> +	else
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
> +	/* Before reading length, check range. */
> +	if (check_add_overflow((unsigned long)pds, 0x0B, &end))
> +		return false;
> +
> +	if (pds < rom || end > rom_end)
> +		return false;
> +
> +	data_len = readw(pds + 0x0A);
> +	if (!data_len || data_len == U16_MAX)
> +		return false;
> +
> +	if (check_add_overflow((unsigned long)pds, data_len, &end))
> +		return false;
> +
> +	if (end > rom_end)
> +		return false;
> +
> +	if (readl(pds) == 0x52494350)
> +		return true;
> +
> +	pci_info(pdev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
> +		 readl(pds));
> +	return false;
> +}
> +
>  /**
>   * pci_get_rom_size - obtain the actual size of the ROM image
>   * @pdev: target PCI device
> @@ -84,37 +165,27 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
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
>  		pds = image + readw(image + 24);
> -		if (readl(pds) != 0x52494350) {
> -			pci_info(pdev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
> -				 readl(pds));
> +		if (!pci_rom_is_data_struct_valid(pdev, pds, rom, size))
>  			break;
> -		}
> -		last_image = readb(pds + 21) & 0x80;
> +
> +		last_image = readb(pds + 21) & BIT(7);
>  		length = readw(pds + 16);
>  		image += length * 512;
> -		/* Avoid iterating through memory outside the resource window */
> -		if (image >= rom + size)
> +
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

As a general comment, there seems to be lots of literals in this code
which would be nice to convert to named defines.

-- 
 i.


