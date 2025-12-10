Return-Path: <linux-pci+bounces-42873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A67FCB19CE
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 02:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3A6530CB813
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 01:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06471FCFEF;
	Wed, 10 Dec 2025 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cb2gQ4y4"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40C31FBC8C
	for <linux-pci@vger.kernel.org>; Wed, 10 Dec 2025 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765330982; cv=none; b=fXWxN1br0cvAXtLzWcw/a1VLykAXN9p4QM1B1M9oIDmAabV2CQ9RP8laCotu7gTY2sBLQJzFGBOKDNE9Aw1Y8JBwb0/FH3unEz6d4usYmKOjPFyXJIGylL9We4CnD8UDlz6dpPTbBfXRZ/a1QgS6X5xmPuchOI9Q2iSUvJ77Apo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765330982; c=relaxed/simple;
	bh=Vskog0CpTIgdsaZOMf/ddar4Qoee8OXICbY5d7Oq7lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HE8W42QsJPY9Dq1656LoTKlTr/nZAJwjhis1WzmY5K9fgFWc3yf6woczge5vnAbKLJkj8ht0xH0B7vEi1bEVDSc1/rRhE+pX4DnUgGYY5E0e2kNSOXp7yVvDNPylQRzHdGbo9GO6txtPp+VUBIz46wc3wFSvho0mfNyj4OXvmNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cb2gQ4y4; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765330970; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GbFZbxv+RQ+BM8C1hp0xSy6g/BldGeHIOU69Qtm+nbM=;
	b=cb2gQ4y4BXHpPNMr5HB05Z/aUEMoxNP4u4rX7ScDTbTgwUxxMiSi6hEBXXi9UBk0FYzQ3dEANensDCEXhPbiI6oEKSNgcEsazYUHhMGSlvv7Wjb/eRgmjmysLwVDGyfn86Dcj8efx3aekBlQulSCu17fvuBjj+WluwCM1sJJwOY=
Received: from 30.178.82.212(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WuUd04u_1765330969 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Dec 2025 09:42:49 +0800
Message-ID: <ba4c3c2c-6b73-4e93-a57f-51b61a13816d@linux.alibaba.com>
Date: Wed, 10 Dec 2025 09:42:48 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH RESEND v5] PCI: Check rom header and data structure addr
 before accessing
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, linux-pci@vger.kernel.org
References: <20251209055114.66392-1-kanie@linux.alibaba.com>
 <5c2fb339-80df-3cbd-4477-05b2773b45d3@linux.intel.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <5c2fb339-80df-3cbd-4477-05b2773b45d3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/9 15:18, Ilpo Järvinen 写道:
> On Tue, 9 Dec 2025, Guixin Liu wrote:
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
>>   drivers/pci/rom.c | 109 ++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 90 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
>> index e18d3a4383ba..b0de38211f39 100644
>> --- a/drivers/pci/rom.c
>> +++ b/drivers/pci/rom.c
>> @@ -69,6 +69,87 @@ void pci_disable_rom(struct pci_dev *pdev)
>>   }
>>   EXPORT_SYMBOL_GPL(pci_disable_rom);
>>   
>> +#define PCI_ROM_HEADER_SIZE 0x1A
>> +
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
>> +	    &header_end))
>> +		return false;
>> +
>> +	if (image < rom || header_end > rom_end)
>> +		return false;
>> +
>> +	/* Standard PCI ROMs start out with these bytes 55 AA */
>> +	if (readw(image) == 0xAA55)
>> +		return true;
>> +
>> +	if (last_image)
>> +		pci_info(pdev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
>> +			 readw(image));
>> +	else
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
>> +	/* Before reading length, check range. */
>> +	if (check_add_overflow((unsigned long)pds, 0x0B, &end))
>> +		return false;
>> +
>> +	if (pds < rom || end > rom_end)
>> +		return false;
>> +
>> +	data_len = readw(pds + 0x0A);
>> +	if (!data_len || data_len == U16_MAX)
>> +		return false;
>> +
>> +	if (check_add_overflow((unsigned long)pds, data_len, &end))
>> +		return false;
>> +
>> +	if (end > rom_end)
>> +		return false;
>> +
>> +	if (readl(pds) == 0x52494350)
>> +		return true;
>> +
>> +	pci_info(pdev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
>> +		 readl(pds));
>> +	return false;
>> +}
>> +
>>   /**
>>    * pci_get_rom_size - obtain the actual size of the ROM image
>>    * @pdev: target PCI device
>> @@ -84,37 +165,27 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
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
>>   		pds = image + readw(image + 24);
>> -		if (readl(pds) != 0x52494350) {
>> -			pci_info(pdev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
>> -				 readl(pds));
>> +		if (!pci_rom_is_data_struct_valid(pdev, pds, rom, size))
>>   			break;
>> -		}
>> -		last_image = readb(pds + 21) & 0x80;
>> +
>> +		last_image = readb(pds + 21) & BIT(7);
>>   		length = readw(pds + 16);
>>   		image += length * 512;
>> -		/* Avoid iterating through memory outside the resource window */
>> -		if (image >= rom + size)
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
> As a general comment, there seems to be lots of literals in this code
> which would be nice to convert to named defines.
>
Sure, I will use macro instead of magic number, changed in v6, thanks.

Best Regards,
Guixin Liu


