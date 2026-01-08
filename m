Return-Path: <linux-pci+bounces-44278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC85D03A68
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 16:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C2F73035BE6
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 14:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A355469200;
	Thu,  8 Jan 2026 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6XHm5x1U"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAC043786E;
	Thu,  8 Jan 2026 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873005; cv=none; b=JJeqA2pleSrI9ng1rwNSKsQeHcGQtjh0shtYv/mePmH3ddGnmG4qr5QiJowfqMgt/h9y8H2F1K67BceKT4A1x0AYLy0tN+wwmXFxSuYuZUPHrc8F7Y+9CTg+PAmfbEcfnWMG3tlvk0Eak19pHlMKAUR8hraJZ7Nudu7MHNteh/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873005; c=relaxed/simple;
	bh=RZZiXLnQYj7o8vK4ZvmaFTOOYbsFVa18PaFV0h/lnKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rmRefyYLgD33GzqDIDdndEv8K4vcWqdFgFftYNR3j9vo3PTEmXXlHaqTyK8c5zZep1U1eT9Uz3Rr3K323USFIziEgth6nEHRA+u66TwUwMVFa2cPdoZffRRSEsDO6dx3jMwLoPsZemwsuINnp8KMy/BiwOl4Thcc3pGnkVfeiFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6XHm5x1U; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IIAYIR1JRujg4RUx1H4Vbdh8dDPd9mYsFWHyjWbLXs0=;
	b=6XHm5x1UWdHA4OrVzsAF73qiH/VhfJwSX2yZoA4ApxnoASlP8X8I2DXHdeIgQTsym7BV6W9Cv
	+NiVoKtOqwHAt6z55B5yH9YiVVEJpe/mzFboWgDMSGON7+6HiVLxbWXETVsHxAkRbo+ocwP9Uug
	4JDiEj/F3ZXY5I2m4+Etkh8=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dn35t5zgYzLlVy;
	Thu,  8 Jan 2026 19:46:42 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 3AEB340565;
	Thu,  8 Jan 2026 19:49:58 +0800 (CST)
Received: from [100.103.109.72] (100.103.109.72) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Jan 2026 19:49:57 +0800
Message-ID: <98ecea9b-ca2f-4ef7-9f1a-848faa9c92a3@huawei.com>
Date: Thu, 8 Jan 2026 19:49:57 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI/sysfs: Prohibit unaligned access to I/O port
 on non-x86
To: David Laight <david.laight.linux@gmail.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <liuyongqiang13@huawei.com>
References: <20260108015944.3520719-1-duziming2@huawei.com>
 <20260108015944.3520719-4-duziming2@huawei.com>
 <20260108085611.0f07816d@pumpkin>
From: duziming <duziming2@huawei.com>
In-Reply-To: <20260108085611.0f07816d@pumpkin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500012.china.huawei.com (7.202.195.23)


在 2026/1/8 16:56, David Laight 写道:
> On Thu, 8 Jan 2026 09:59:44 +0800
> Ziming Du <duziming2@huawei.com> wrote:
>
>> From: Yongqiang Liu <liuyongqiang13@huawei.com>
>>
>> Unaligned access is harmful for non-x86 archs such as arm64. When we
>> use pwrite or pread to access the I/O port resources with unaligned
>> offset, system will crash as follows:
>>
>> Unable to handle kernel paging request at virtual address fffffbfffe8010c1
>> Internal error: Oops: 0000000096000061 [#1] SMP
>> Call trace:
>>   _outw include/asm-generic/io.h:594 [inline]
>>   logic_outw+0x54/0x218 lib/logic_pio.c:305
>>   pci_resource_io drivers/pci/pci-sysfs.c:1157 [inline]
>>   pci_write_resource_io drivers/pci/pci-sysfs.c:1191 [inline]
>>   pci_write_resource_io+0x208/0x260 drivers/pci/pci-sysfs.c:1181
>>   sysfs_kf_bin_write+0x188/0x210 fs/sysfs/file.c:158
>>   kernfs_fop_write_iter+0x2e8/0x4b0 fs/kernfs/file.c:338
>>   vfs_write+0x7bc/0xac8 fs/read_write.c:586
>>   ksys_write+0x12c/0x270 fs/read_write.c:639
>>   __arm64_sys_write+0x78/0xb8 fs/read_write.c:648
>>
>> Powerpc seems affected as well, so prohibit the unaligned access
>> on non-x86 archs.
> I'm not sure it makes any real sense for x86 either.
> IIRC io space is just like memory space, so a 16bit io access looks the
> same as two 8bit accesses to an 8bit device (some put the 'data fifo' on
> addresses 0 and 1 so the code could use 16bit io accesses to speed things up).
> The same will have applied to misaligned accesses.
> But, in reality, all device registers are aligned.
>
> I'm not sure EFAULT is the best error code though, EINVAL might be better.
> (EINVAL is returned for other address/size errors.)
> EFAULT is usually returned for errors accessing the user buffer, a least
> one unix system raises SIGSEGV whenever EFAULT is returned.
>
> 	David
Just to confirm: should all architectures prohibit unaligned access to 
device registers?
>> Fixes: 8633328be242 ("PCI: Allow read/write access to sysfs I/O port resources")
>> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
>> Signed-off-by: Ziming Du <duziming2@huawei.com>
>> ---
>>   drivers/pci/pci-sysfs.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index 7e697b82c5e1..11d8b7ec4263 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -31,6 +31,7 @@
>>   #include <linux/of.h>
>>   #include <linux/aperture.h>
>>   #include <linux/unaligned.h>
>> +#include <linux/align.h>
>>   #include "pci.h"
>>   
>>   #ifndef ARCH_PCI_DEV_GROUPS
>> @@ -1166,12 +1167,20 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
>>   			*(u8 *)buf = inb(port);
>>   		return 1;
>>   	case 2:
>> +		#if !defined(CONFIG_X86)
>> +			if (!IS_ALIGNED(port, count))
>> +				return -EFAULT;
>> +		#endif
>>   		if (write)
>>   			outw(*(u16 *)buf, port);
>>   		else
>>   			*(u16 *)buf = inw(port);
>>   		return 2;
>>   	case 4:
>> +		#if !defined(CONFIG_X86)
>> +			if (!IS_ALIGNED(port, count))
>> +				return -EFAULT;
>> +		#endif
>>   		if (write)
>>   			outl(*(u32 *)buf, port);
>>   		else

