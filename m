Return-Path: <linux-pci+bounces-42939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FE9CB56E9
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 10:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05B8C30012E9
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 09:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E910A2FB983;
	Thu, 11 Dec 2025 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WLXFM4HX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8572F6597
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765447159; cv=none; b=la6NH2Q8Lmo/xDQgBd+Bi46yd5Z/lDp/3As/EoARf62de9SHWv/QSALEkAtl9CTlNJW3TV6bjeQ9HHU3pw3mfFhts23tm6Xmp2juu/PYcMzwcYvJ7yQYBpTr6H454m3Wc4b0WqubgNB68Ut/5P/g4uB94mq6kE4imkl8vwD4dio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765447159; c=relaxed/simple;
	bh=1ybmuEqHv4SmveX8DlAEiiObxl6CYQY3qxrdZzcORUM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ffAYv7MV1dKTWcojHqArscYova7zpSGEwpqdDC8KlyiisjeF78ASgiLyFGGY5ZbnzbUo1DjLg5GotQ8ChAo5q+gyOC9BYQ2FpxL1xIBeMn1BHBDB0EzE/ovUHijvHJfFKfzigIUAFEEGb0OzYMYL/N71veep9o8IPqSIZ1RBPhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WLXFM4HX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765447157; x=1796983157;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1ybmuEqHv4SmveX8DlAEiiObxl6CYQY3qxrdZzcORUM=;
  b=WLXFM4HXj4kHL6MFZpuRuYU+KklUpPMZY7uWoc/ybABjYuw0iQYqIB2E
   ymExdrRhJXGZuMR6iv441j4Rsac/niyFwMcFEGvE1O4zgaDc0v7nXDegY
   iZ/sfIMfUstIWqU0ZjvJV3VCedoM3t5/UFQps3PL7Rvf2MhTP6xJG8YlT
   +7G4BCg4VtK/TzdJsjOh0mjxr8zamBc1PuvifjfQrgffbGreAQ9yHuHQj
   Lx86W3DzGUMrQcyA20j1EuOoQtt18EfUyeMD2c5iwI0xe+AyaaAZF8emb
   bDr7H+0LlDzKBtY0llwMyrsbS0HNWa3aD/yCxlfr3PdXI4lhn9Plyfikg
   Q==;
X-CSE-ConnectionGUID: PicLuFWNQKaequpDPMByBA==
X-CSE-MsgGUID: PHPk/Zl7Q9yh3TS9R7nA/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67597831"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="67597831"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 01:59:17 -0800
X-CSE-ConnectionGUID: qFPC8/V8QaKUgdjKtMebGA==
X-CSE-MsgGUID: nHGxjuQKQ5+/SaLRbhtD1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="234164157"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.219])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 01:59:15 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Dec 2025 11:59:11 +0200 (EET)
To: Guixin Liu <kanie@linux.alibaba.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Andy Shevchenko <andriy.shevchenko@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 2/2] PCI: Check rom header and data structure addr
 before accessing
In-Reply-To: <20251211033741.53072-3-kanie@linux.alibaba.com>
Message-ID: <d53a3913-c08c-94e0-e2ad-f2c7bd198250@linux.intel.com>
References: <20251211033741.53072-1-kanie@linux.alibaba.com> <20251211033741.53072-3-kanie@linux.alibaba.com>
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
>  drivers/pci/rom.c | 119 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 97 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
> index 3e00611fa76b..8cbcc55946a4 100644
> --- a/drivers/pci/rom.c
> +++ b/drivers/pci/rom.c
> @@ -10,6 +10,9 @@
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/bits.h>
> +#include <linux/align.h>
> +#include <linux/overflow.h>
> +#include <linux/io.h>

Order.

>  #include "pci.h"
>  
> @@ -80,6 +83,87 @@ void pci_disable_rom(struct pci_dev *pdev)
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
> +	if (readw(image) == PCI_ROM_IMAGE_SIGNATURE)
> +		return true;
> +
> +	if (last_image) {
> +		pci_info(pdev, "Invalid PCI ROM header signature: expecting %#06x, got %#06x\n",
> +			 PCI_ROM_IMAGE_SIGNATURE, readw(image));

You should store the readw() value above as you use it here too so you 
don't need to read it again.

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
> +	if (readl(pds) == PCI_ROM_DATA_STRUCT_SIGNATURE)
> +		return true;
> +
> +	pci_info(pdev, "Invalid PCI ROM data signature: expecting %#010x, got %#010x\n",
> +		 PCI_ROM_DATA_STRUCT_SIGNATURE, readl(pds));

Ditto.

> +	return false;
> +}
> +
>  /**
>   * pci_get_rom_size - obtain the actual size of the ROM image
>   * @pdev: target PCI device
> @@ -95,37 +179,28 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
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
> +		last_image = readb(pds + PCI_ROM_LAST_IMAGE_INDICATOR) &
> +				   PCI_ROM_LAST_IMAGE_INDICATOR_BIT;
> +		length = readw(pds + PCI_ROM_IMAGE_LEN);
> +		image += length * PCI_ROM_IMAGE_LEN_UNIT_SZ_512;
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

-- 
 i.


