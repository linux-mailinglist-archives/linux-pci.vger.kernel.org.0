Return-Path: <linux-pci+bounces-41586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E40C6D098
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 08:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7E1A352DC7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 07:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67712D9498;
	Wed, 19 Nov 2025 07:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Z+MX5hAf"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774B4260583
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 07:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763536220; cv=none; b=VEookBxs9otreKV+f1LzuOIupPiwYGJ12XmtV7F95VweGGimUt8mScUctM6k/7gTfBgzFHqvqHBasjA+w3ncA5E1Q2JQFRNPMSJKH2oan6ur30cmnycpC+JdMq+G9wv4c/h334mWnIMnR8EYGJpIpEiziPmmDID8TgHBMJTAWzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763536220; c=relaxed/simple;
	bh=xGuOjPFb3RpZCqapKtkaRek9zGjGdz2acxtw4o2DLe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Imny9N6Iyw3KPXWkjvN9FD1c1feXyEuSCD/Gzn3W0Ky+d6BSqGoHe6vz8dUZ90klDCmK75R/keVrVKgyA+8xFUvZUERfJeMyInr1EPUXwotsqKt8H1n6ZZPKbKBVaSEmCoCTePkB4CAzydvWkGZRxp8uG+W5dPC/zXjDBe2HVNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Z+MX5hAf; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763536208; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bScDHEorsEDy34tWeZC0qZyGF/abO4EY19vip7+hrIs=;
	b=Z+MX5hAfKCGzmS7PGcQYegye5t78q+AHEi3StnIDfsT5L9pC0tmkGnS6Nu06jFnl2cHsEXsd3vx6eYBa2+vfgphDsa+7s5AK2+gvpoRgJxQsRbnh8Itd18a7tw6bOXrDBqVU5ZQ7siM4QL7mpXjrFrvpnfv/tNDbklSg77Vt8BA=
Received: from 30.178.83.6(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WsnZ0ka_1763536207 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Nov 2025 15:10:08 +0800
Message-ID: <261a835a-7ab1-4899-afd5-496c9bbac452@linux.alibaba.com>
Date: Wed, 19 Nov 2025 15:10:06 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] PCI: Check rom image addr at every step
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20251114063411.88744-1-kanie@linux.alibaba.com>
 <aRyVIebrZk__gkKE@black.igk.intel.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <aRyVIebrZk__gkKE@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/18 23:47, Andy Shevchenko 写道:
> On Fri, Nov 14, 2025 at 02:34:11PM +0800, Guixin Liu wrote:
>> We meet a crash when running stress-ng:
> + blank line.
>
>>    BUG: unable to handle page fault for address: ffa0000007f40000
>>    RIP: 0010:pci_get_rom_size+0x52/0x220
>>    Call Trace:
>>    <TASK>
>>    pci_map_rom+0x80/0x130
>>    pci_read_rom+0x4b/0xe0
>>    kernfs_file_read_iter+0x96/0x180
>>    vfs_read+0x1b1/0x300
>>    ksys_read+0x63/0xe0
>>    do_syscall_64+0x34/0x80
>>    entry_SYSCALL_64_after_hwframe+0x78/0xe2
> Please, read
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages
> and act accordingly (I think of 4 least significant lines)
>
> + blank line.
Will be changed in v2, thanks.
>> Bcause of broken rom space, before calling readl(pds), pds already
>> points to the rom space end (rom + size - 1), invoking readl()
>> would therefore cause an out-of-bounds access and trigger a crash.
>>
>> Fix this by adding every step address checking.
>  From the description and the code I'm not sure this is the best approach. Since
> the accesses seem to be not 4-byte aligned, perhaps readl() should be split to
> something shorter in such cases? Dunno, I haven't looked at the code.
>
> Ah, it seems we are looking for the full 4 bytes to match. But then we need more, no?
> See below.
>
> ...
In my case, the rom start addr is 0xffa0000007f30000, the size is 
0x10000, we got a data structure addr 0xffa0000007f3ffff which point to 
the end of rom space, readl() will read 4 bytes therefore cause an 
out-of-bounds access.
>
>> +#define PCI_ROM_DATA_STRUCT_OFFSET 24
>> +#define PCI_ROM_LAST_IMAGE_OFFSET 21
>> +#define PCI_ROM_LAST_IMAGE_LEN_OFFSET 16
> Are those based on PCI specifications? Perhaps if we go this way the reference
> to the spec needs to be added.
>
> ...
>
>> static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
>>   	void __iomem *image;
>>   	int last_image;
>>   	unsigned int length;
>> +	void __iomem *end = rom + size;
> Can you group together IOMEM addresses?
>
> 	void __iomem *end = rom + size;
> 	void __iomem *image;
> 	int last_image;
> 	unsigned int length;
>
>>   
>>   	image = rom;
>>   	do {
>>   		void __iomem *pds;
>> +		if (image + 2 >= end)
>> +			break;
> Shouldn't we rather check the size to be at least necessary minimum? With this
> done, this check won't be needed here. Or we would need another one to check
> for the length for the entire structure needed.
>
>>   		/* Standard PCI ROMs start out with these bytes 55 AA */
>>   		if (readw(image) != 0xAA55) {
>>   			pci_info(pdev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
>>   				 readw(image));
>>   			break;
>>   		}
>> +		if (image + PCI_ROM_DATA_STRUCT_OFFSET + 2 >= end)
>> +			break;
>>   		/* get the PCI data structure and check its "PCIR" signature */
>> -		pds = image + readw(image + 24);
>> +		pds = image + readw(image + PCI_ROM_DATA_STRUCT_OFFSET);
>> +		if (pds + 4 >= end)
>> +			break;
>>   		if (readl(pds) != 0x52494350) {
>>   			pci_info(pdev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
>>   				 readl(pds));
> You also want to reconsider double readl(). Would it have side-effects? What about hot-plug?
>
>>   			break;
>>   		}
>> -		last_image = readb(pds + 21) & 0x80;
>> -		length = readw(pds + 16);
>> +
>> +		if (pds + PCI_ROM_LAST_IMAGE_OFFSET + 1 >= end)
>> +			break;
>> +		last_image = readb(pds + PCI_ROM_LAST_IMAGE_OFFSET) & 0x80;
>> +		length = readw(pds + PCI_ROM_LAST_IMAGE_LEN_OFFSET);
>>   		image += length * 512;
>>   		/* Avoid iterating through memory outside the resource window */
>> -		if (image >= rom + size)
>> +		if (image + 2 >= end)
>>   			break;
>>   		if (!last_image) {
>>   			if (readw(image) != 0xAA55) {
> I agree that defensive programming helps, but I think it's too much in this
> case. We may relax and do less, but comprehensive checks.
>
> ...
>
> Thanks for the testing and proposing a fix, nevertheless!
>
In v2, I will change to checking addr is in the range of the header
or data structure per spec.

Best Regards,
Guixin Liu


