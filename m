Return-Path: <linux-pci+bounces-42924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9FDCB4963
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 04:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0482730010D2
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 03:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C268913A3F7;
	Thu, 11 Dec 2025 03:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="udU2Qls7"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5B828F5
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 03:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765422098; cv=none; b=DaYNi+CamB6qFj9xpiIZlXhEaCHThUzzQUIjb8DP4m1p8JwReGG56lJB10xVr08lDlm59awEzhb9EjLKVEW28IvfL6w+zTwBsELMCML4/bUlWUELpyJRneWexOFkgbNLKX6om6oaki9qCKqhgUx7cJO5n4Jr1xr+BDJMXFAb4Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765422098; c=relaxed/simple;
	bh=XDbfySYBWcWjDYaSybZu3kpjhWPfLyPhJ+q+UCuX5W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZH8rWjQumnNdPHz1gSRYnMnUJqemdH+1GRHZ9lGg7/ZTGB29d3zVHLWK4D2dYxjRMETAqJ5uaLT7Uz7s5t46rJhl8cVog5LieQpVR6ka7rTQrZM44gtP/a+FiCFrsVdU9IDh6lc9JSvfp56Umz/YhH6/PHZBwxeTiSJwADoS9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=udU2Qls7; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765422092; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DRtGQZxfOegWLIUDC0yayR4b7tssK1SXlDdmgxnZR0U=;
	b=udU2Qls7vEKb098hMLIgER26vzkb4OgiyGZ4wnryEM+joteM6+aatwEpCCXyUBjhO//qTJSs7OR8XylWRy2gOl4OIuIEw9lmhLwch5Vx0DmHhggd1ajFCXz2hzmqmpWgfGo+DeEz1tO/mpRcA4QgU0r7Zx5AnUcissOZXv4GmlQ=
Received: from 30.178.82.227(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WuYkbvM_1765422091 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Dec 2025 11:01:32 +0800
Message-ID: <548e3aab-6a7a-4729-965a-78ad8e527028@linux.alibaba.com>
Date: Thu, 11 Dec 2025 11:01:30 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v6] PCI: Check rom header and data structure addr before
 accessing
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, linux-pci@vger.kernel.org
References: <20251210033551.107530-1-kanie@linux.alibaba.com>
 <f97a1520-a21c-22a4-fd0f-f8a1b5852d6f@linux.intel.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <f97a1520-a21c-22a4-fd0f-f8a1b5852d6f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/10 19:09, Ilpo Järvinen 写道:
> On Wed, 10 Dec 2025, Guixin Liu wrote:
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
>> And also, convert some magic number to named defines.
>>
>> Fixes: 47b975d234ea ("PCI: Avoid iterating through memory outside the resource window")
>> Suggested-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> ---
>> v5 -> v6:
>> - Convert some magic number to named defines, suggested by
>> Ilpo, thanks.
>>
>> v4 -> v5:
>> - Add Andy Shevchenko's rb tag, thanks.
>> - Change u64 to unsigned long.
>> - Change pci_rom_header_valid() to pci_rom_is_header_valid() and
>> change pci_rom_data_struct_valid() to pci_rom_is_data_struct_valid().
>> - Change rom_end from rom+size to rom+size-1 for more readble,
>> and also change header_end >= rom_end to header_end > rom_end, same
>> as data structure end.
>> - Change if(!last_image) to if (last_image)..
>> - Use U16_MAX instead of 0xffff.
>> - Split check_add_overflow() from data_len checking.
>> - Remove !!() when reading last_image, and Use BIT(7) instead of 0x80.
>>
>> v3 -> v4:
>> - Use "u64" instead of "uintptr_t".
>> - Invert the if statement to avoid excessive indentation.
>> - Add comment for alignment checking.
>> - Change last_image's type from int to bool.
>>
>> v2 -> v3:
>> - Add pci_rom_header_valid() helper for checking image addr and signature.
>> - Add pci_rom_data_struct_valid() helper for checking data struct add
>> and signature.
>> - Handle overflow issue when adding addr with size.
>> - Handle alignment fault when running on arm64.
>>
>> v1 -> v2:
>> - Fix commit body problems, such as blank line in "Call Trace" both sides,
>>    thanks, (Andy Shevchenko).
>> - Remove every step checking, just check the addr is in header or data struct.
>> - Add Suggested-by: Guanghui Feng <guanghuifeng@linux.alibaba.com> tag.
>>   drivers/pci/rom.c | 123 +++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 101 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
>> index e18d3a4383ba..9480589899fa 100644
>> --- a/drivers/pci/rom.c
>> +++ b/drivers/pci/rom.c
>> @@ -12,6 +12,15 @@
>>   
>>   #include "pci.h"
>>   
>> +#define PCI_ROM_HEADER_SIZE 0x1A
>> +#define PCI_ROM_POINTER_TO_DATA_STRUCT 0x18
>> +#define PCI_ROM_LAST_IMAGE_INDICATOR 0x15
>> +#define PCI_ROM_IMAGE_LEN 0x10
>> +#define PCI_ROM_IMAGE_LEN_UNIT_BYTES 512
> SZ_512 + add include.
Changed in v7.
>> +#define PCI_ROM_IMAGE_SIGNATURE 0xAA55
>> +#define PCI_ROM_DATA_STRUCT_SIGNATURE 0x52494350
>> +#define PCI_ROM_DATA_STRUCT_LEN 0x0A
> Can you please align the values with tabs.
Sure.
>> +
>>   /**
>>    * pci_enable_rom - enable ROM decoding for a PCI device
>>    * @pdev: PCI device to enable
>> @@ -69,6 +78,86 @@ void pci_disable_rom(struct pci_dev *pdev)
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
> Add include for IS_ALIGNED().
Sure, Added in v7.
>> +		return false;
>> +
>> +	if (check_add_overflow((unsigned long)image, PCI_ROM_HEADER_SIZE,
> Add include.
Sure.
>
>> +	    &header_end))
> Aligned to a wrong (.
>
Changed in v7.
>> +		return false;
>> +
>> +	if (image < rom || header_end > rom_end)
>> +		return false;
>> +
>> +	/* Standard PCI ROMs start out with these bytes 55 AA */
>> +	if (readw(image) == PCI_ROM_IMAGE_SIGNATURE)
> Missing include for readw() (a pre-existing problem in this file).
OK, Added in v7.
>> +		return true;
>> +
>> +	if (last_image)
>> +		pci_info(pdev, "Invalid PCI ROM header signature: expecting %#06x, got %#06x\n",
>> +			 PCI_ROM_IMAGE_SIGNATURE, readw(image));
>> +	else
> Add braces as the block is multiple lines.
Changed in v7.
>> +		pci_info(pdev, "No more image in the PCI ROM\n");
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
>> +	    &end))
> Aligned to a wrong (.
Changed in v7.
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
>> +	return false;
>> +}
>> +
>>   /**
>>    * pci_get_rom_size - obtain the actual size of the ROM image
>>    * @pdev: target PCI device
>> @@ -84,37 +173,27 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
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
>> +		last_image = readb(pds + PCI_ROM_LAST_IMAGE_INDICATOR) & BIT(7);
> You forgot to name this BIT(7).
Added in v7.
>> +		length = readw(pds + PCI_ROM_IMAGE_LEN);
>> +		image += length * PCI_ROM_IMAGE_LEN_UNIT_BYTES;
> I'd have put the define conversion to own patch to reduce extra line
> changes in the fix itself.
OK, I will put them to a separate patch.

Thanks for the advice.

Best Regards,
Guixin Liu

