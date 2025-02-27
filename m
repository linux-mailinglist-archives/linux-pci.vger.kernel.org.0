Return-Path: <linux-pci+bounces-22584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF8BA485CF
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 17:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67C618874BF
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 16:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D033C1CAA67;
	Thu, 27 Feb 2025 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eje/hodl"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3C11AF0C2;
	Thu, 27 Feb 2025 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675026; cv=none; b=Ry6kMjheMkgWl99WML+u+de1vYjkxiTuQbe0tGtRAI125wbToHFv5tyM5FDxKbZDvDYuM5vaf56+hDu40OEoZGSmewl6j14BVJ/+CzdxC6z8g3ZaUwIc7iVovCXDq02dzMEtzQZZ2lbixg9DCo7E+D/TjPZCdealrG0Zv9BVsIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675026; c=relaxed/simple;
	bh=mR62XuSfzXZJNdY09zTjqiMM76glY7ee8nEqkeAlZk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0KdPWh0MMGKVp0SXPRIi1ppsYbKqq/8+kWsTeVtj8H/ntiSK/ZIxifTVX+arUU4bhP9PVwohtXmUBRI6PKENwT7dyQC31lidtLYtOqvAdZK97zyf8V5N8+VcqFIZ3+uHzg0u12oY58cYeKzxd/S7aTvSJNePiN6ZGQ1HmKhwd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eje/hodl; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=b3eACf/NqGtuvY52aeXEePolnc9Kdlg09f0o15Y4tjU=;
	b=eje/hodl5/f2qU348Ki4VDTJLF9l5RW4r/Dk00KH+FuwONGIutWdhChZt1kEnt
	Bfds/XDUEYtbcz63G/i25odB7Z6SxwF6C3Kv+vnlBZTWx/8u3+B042G+ow6LrR5s
	jktDqHBfuavtKxPxh+favHFKi+nFmCbvHK1qSEXU00w+g=
Received: from [192.168.71.45] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDHI+yil8Bn2SvOBA--.51118S2;
	Fri, 28 Feb 2025 00:49:38 +0800 (CST)
Message-ID: <f6e44f34-8800-421c-ba2c-755c10a6840e@163.com>
Date: Fri, 28 Feb 2025 00:49:38 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] genirq/msi: Add the address and data that show MSI/MSIX
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: tglx@linutronix.de, kw@linux.com, kwilczynski@kernel.org,
 bhelgaas@google.com, cassel@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250227162821.253020-1-18255117159@163.com>
 <20250227163937.wv4hsucatyandde3@thinkpad>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250227163937.wv4hsucatyandde3@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgDHI+yil8Bn2SvOBA--.51118S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr4Utw4fWFy8KryDKr1Dtrb_yoW8uFy7pr
	yDJF43Kr48Jr1UAwsrWF47Wr15Xrs0vayxJrykG34Skwn8Wwn2yF1DKa1fGa4aqr4ruw1j
	v3Wqvw47Kwn8CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U9ID7UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwcBo2fAkCC0WwAAsG



On 2025/2/28 00:39, Manivannan Sadhasivam wrote:
> On Fri, Feb 28, 2025 at 12:28:21AM +0800, Hans Zhang wrote:
>> Add to view the addresses and data stored in the MSI capability or the
>> addresses and data stored in the MSIX vector table.
>>
>> e.g.
>> root@root:/sys/bus/pci/devices/<dev>/msi_irqs# ls
>> 86  87  88  89
>> root@root:/sys/bus/pci/devices/<dev>/msi_irqs# cat *
>> msix
>>   address_hi: 0x00000000
>>   address_lo: 0x0e060040
>>   msg_data: 0x00000000
>> msix
>>   address_hi: 0x00000000
>>   address_lo: 0x0e060040
>>   msg_data: 0x00000001
>> msix
>>   address_hi: 0x00000000
>>   address_lo: 0x0e060040
>>   msg_data: 0x00000002
>> msix
>>   address_hi: 0x00000000
>>   address_lo: 0x0e060040
>>   msg_data: 0x00000003
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   kernel/irq/msi.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
>> index 396a067a8a56..a37a3e535fb8 100644
>> --- a/kernel/irq/msi.c
>> +++ b/kernel/irq/msi.c
>> @@ -503,8 +503,18 @@ static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
>>   {
>>   	/* MSI vs. MSIX is per device not per interrupt */
>>   	bool is_msix = dev_is_pci(dev) ? to_pci_dev(dev)->msix_enabled : false;
>> +	struct msi_desc *desc;
>> +	u32 irq;
>> +
>> +	if (kstrtoint(attr->attr.name, 10, &irq) < 0)
>> +		return 0;
>>   
>> -	return sysfs_emit(buf, "%s\n", is_msix ? "msix" : "msi");
>> +	desc = irq_get_msi_desc(irq);
>> +	return sysfs_emit(
>> +		buf,
>> +		"%s\n address_hi: 0x%08x\n address_lo: 0x%08x\n msg_data: 0x%08x\n",
>> +		is_msix ? "msix" : "msi", desc->msg.address_hi,
>> +		desc->msg.address_lo, desc->msg.data);
> 
> Sysfs is an ABI. You cannot change the semantics of an attribute.
> 

Thanks Mani for the tip.

If I want to implement similar functionality, where should I add it? 
Since this sysfs node is the only one that displays the MSI/MSIX 
interrupt number, I don't know where to implement similar debug 
functionality at this time. Do you have any suggestions? Or it shouldn't 
have a similar function.

Best regards
Hans


