Return-Path: <linux-pci+bounces-42942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7A6CB5A04
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 12:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE1183007260
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 11:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFE229C351;
	Thu, 11 Dec 2025 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L3ESy5vJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA522D9EF4
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765451993; cv=none; b=Esg4ndmUYFAGGYEhLR+hScCnrSwmQVxte7tAwG67OPgE+skfXosJLggi0LCveU3O0GepK6TP+tTQLUp1v+qOmOlH5reiU0XLnB9ieJ9u1lhx16iMM3Mr+s3HgZeGQcX0TNMJpejaFTv8xGB0AbDl232kvsP5GY0yyF6RdHO4hak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765451993; c=relaxed/simple;
	bh=JISBvzDqOGJstjAL+cgAOezJ+8sLO8V05l49b0sJ678=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W24kLX0X4FPBRiO+Dw5O5B5qHN4qW+L1oy6JkecpGk60HogyP20tEUbc7Qs5qdPYpLwTZfbJZsJIEgOLIKzqOFiquX4Xuu8um4q88ney6xgUCGeZrYJWc2L1eKH9VayhGy0uOxJv7UNgrI4lJWFFhRNxSryoXf6PIG9jdh2n5lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=L3ESy5vJ; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765451988; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ecAkVjuCe9bGX9techowzEAb8Xjvjj2U4mfzWIwX6/A=;
	b=L3ESy5vJGxSLUGNF5lt7rRcU+QlA5MRITyNEZ4xqgHfvr+lRGUnXOX3GYivcj7Pc+shzTUXbv/CFqncWtxPeIJZsVyGe2wncMGgK0IHrbhka+AqMCRcY6r56mARvrny1epZAkeQtL5WjcZeIhCjwBzC8AtzF/vyDZOL+d/gF1Fc=
Received: from 30.178.203.102(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WuaG4L1_1765451986 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Dec 2025 19:19:47 +0800
Message-ID: <eb3f6f5a-fca4-4367-ae16-7dc42dc960f3@linux.alibaba.com>
Date: Thu, 11 Dec 2025 19:19:46 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v7 2/2] PCI: Check rom header and data structure addr
 before accessing
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, linux-pci@vger.kernel.org
References: <20251211033741.53072-1-kanie@linux.alibaba.com>
 <20251211033741.53072-3-kanie@linux.alibaba.com>
 <d53a3913-c08c-94e0-e2ad-f2c7bd198250@linux.intel.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <d53a3913-c08c-94e0-e2ad-f2c7bd198250@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/11 17:59, Ilpo Järvinen 写道:
> On Thu, 11 Dec 2025, Guixin Liu wrote:
>
>> We meet a crash when running stress-ng on x86_64 machine:
>>
>>    BUG: unable to handle page fault for address: ffa0000007f40000
>>    RIP: 0010:pci_get_rom_size+0x52/0x220
>>    Call Trace:
>>    <TASK>
>>      pci_map_rom+0x80/0x130
>>      pci_read_rom+0x4b/0xe0
>>      kernfs_file_read_iter+0x96/0x180
>>      vfs_read+0x1b1/0x300
>>
>> Our analysis reveals that the rom space's start address is
>> 0xffa0000007f30000, and size is 0x10000. Because of broken rom
>> space, before calling readl(pds), the pds's value is
>> 0xffa0000007f3ffff, which is already pointed to the rom space
>> end, invoking readl() would read 4 bytes therefore cause an
>> out-of-bounds access and trigger a crash.
>> Fix this by adding image header and data structure checking.
>>
>> We also found another crash on arm64 machine:
>>
>>    Unable to handle kernel paging request at virtual address
>> ffff8000dd1393ff
>>    Mem abort info:
>>    ESR = 0x0000000096000021
>>    EC = 0x25: DABT (current EL), IL = 32 bits
>>    SET = 0, FnV = 0
>>    EA = 0, S1PTW = 0
>>    FSC = 0x21: alignment fault
>>
>> The call trace is the same with x86_64, but the crash reason is
>> that the data structure addr is not aligned with 4, and arm64
>> machine report "alignment fault". Fix this by adding alignment
>> checking.
>>
>> Fixes: 47b975d234ea ("PCI: Avoid iterating through memory outside the resource window")
>> Suggested-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> ---
>>   drivers/pci/rom.c | 119 +++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 97 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
>> index 3e00611fa76b..8cbcc55946a4 100644
>> --- a/drivers/pci/rom.c
>> +++ b/drivers/pci/rom.c
>> @@ -10,6 +10,9 @@
>>   #include <linux/pci.h>
>>   #include <linux/slab.h>
>>   #include <linux/bits.h>
>> +#include <linux/align.h>
>> +#include <linux/overflow.h>
>> +#include <linux/io.h>
> Order.
Sure.
>>   #include "pci.h"
>>   
>> @@ -80,6 +83,87 @@ void pci_disable_rom(struct pci_dev *pdev)
>>   }
>>   EXPORT_SYMBOL_GPL(pci_disable_rom);
>>   
>> +static bool pci_rom_is_header_valid(struct pci_dev *pdev,
>> +				    void __iomem *image,
>> +				    void __iomem *rom,
>> +				    size_t size,
>> +				    bool last_image)
>> +{
>> +	unsigned long rom_end = (unsigned long)rom + size - 1;
>> +	unsigned long header_end;
>> +
>> +	/*
>> +	 * Some CPU architectures require IOMEM access addresses to
>> +	 * be aligned, for example arm64, so since we're about to
>> +	 * call readw(), we check here for 2-byte alignment.
>> +	 */
>> +	if (!IS_ALIGNED((unsigned long)image, 2))
>> +		return false;
>> +
>> +	if (check_add_overflow((unsigned long)image, PCI_ROM_HEADER_SIZE,
>> +				&header_end))
>> +		return false;
>> +
>> +	if (image < rom || header_end > rom_end)
>> +		return false;
>> +
>> +	/* Standard PCI ROMs start out with these bytes 55 AA */
>> +	if (readw(image) == PCI_ROM_IMAGE_SIGNATURE)
>> +		return true;
>> +
>> +	if (last_image) {
>> +		pci_info(pdev, "Invalid PCI ROM header signature: expecting %#06x, got %#06x\n",
>> +			 PCI_ROM_IMAGE_SIGNATURE, readw(image));
> You should store the readw() value above as you use it here too so you
> don't need to read it again.
Sure.
>> +	} else {
>> +		pci_info(pdev, "No more image in the PCI ROM\n");
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static bool pci_rom_is_data_struct_valid(struct pci_dev *pdev,
>> +					 void __iomem *pds,
>> +					 void __iomem *rom,
>> +					 size_t size)
>> +{
>> +	unsigned long rom_end = (unsigned long)rom + size - 1;
>> +	unsigned long end;
>> +	u16 data_len;
>> +
>> +	/*
>> +	 * Some CPU architectures require IOMEM access addresses to
>> +	 * be aligned, for example arm64, so since we're about to
>> +	 * call readl(), we check here for 4-byte alignment.
>> +	 */
>> +	if (!IS_ALIGNED((unsigned long)pds, 4))
>> +		return false;
>> +
>> +	/* Before reading length, check addr range. */
>> +	if (check_add_overflow((unsigned long)pds, PCI_ROM_DATA_STRUCT_LEN + 1,
>> +				&end))
>> +		return false;
>> +
>> +	if (pds < rom || end > rom_end)
>> +		return false;
>> +
>> +	data_len = readw(pds + PCI_ROM_DATA_STRUCT_LEN);
>> +	if (!data_len || data_len == U16_MAX)
>> +		return false;
>> +
>> +	if (check_add_overflow((unsigned long)pds, data_len, &end))
>> +		return false;
>> +
>> +	if (end > rom_end)
>> +		return false;
>> +
>> +	if (readl(pds) == PCI_ROM_DATA_STRUCT_SIGNATURE)
>> +		return true;
>> +
>> +	pci_info(pdev, "Invalid PCI ROM data signature: expecting %#010x, got %#010x\n",
>> +		 PCI_ROM_DATA_STRUCT_SIGNATURE, readl(pds));
> Ditto.
>
Sure.

I will  change all in next version, thanks.

Best Regards,
Guixin Liu
>> +	return false;
>> +}
>> +
>>   /**
>>    * pci_get_rom_size - obtain the actual size of the ROM image
>>    * @pdev: target PCI device
>> @@ -95,37 +179,28 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
>>   			       size_t size)
>>   {
>>   	void __iomem *image;
>> -	int last_image;
>> +	bool last_image;
>>   	unsigned int length;
>>   
>>   	image = rom;
>>   	do {
>>   		void __iomem *pds;
>> -		/* Standard PCI ROMs start out with these bytes 55 AA */
>> -		if (readw(image) != 0xAA55) {
>> -			pci_info(pdev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
>> -				 readw(image));
>> +
>> +		if (!pci_rom_is_header_valid(pdev, image, rom, size, true))
>>   			break;
>> -		}
>> +
>>   		/* get the PCI data structure and check its "PCIR" signature */
>> -		pds = image + readw(image + 24);
>> -		if (readl(pds) != 0x52494350) {
>> -			pci_info(pdev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
>> -				 readl(pds));
>> +		pds = image + readw(image + PCI_ROM_POINTER_TO_DATA_STRUCT);
>> +		if (!pci_rom_is_data_struct_valid(pdev, pds, rom, size))
>>   			break;
>> -		}
>> -		last_image = readb(pds + 21) & 0x80;
>> -		length = readw(pds + 16);
>> -		image += length * 512;
>> -		/* Avoid iterating through memory outside the resource window */
>> -		if (image >= rom + size)
>> +
>> +		last_image = readb(pds + PCI_ROM_LAST_IMAGE_INDICATOR) &
>> +				   PCI_ROM_LAST_IMAGE_INDICATOR_BIT;
>> +		length = readw(pds + PCI_ROM_IMAGE_LEN);
>> +		image += length * PCI_ROM_IMAGE_LEN_UNIT_SZ_512;
>> +
>> +		if (!pci_rom_is_header_valid(pdev, image, rom, size, last_image))
>>   			break;
>> -		if (!last_image) {
>> -			if (readw(image) != 0xAA55) {
>> -				pci_info(pdev, "No more image in the PCI ROM\n");
>> -				break;
>> -			}
>> -		}
>>   	} while (length && !last_image);
>>   
>>   	/* never return a size larger than the PCI resource window */
>>


