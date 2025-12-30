Return-Path: <linux-pci+bounces-43829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFEFCE8FFA
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 09:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D9DA3011F85
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 08:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AA32FFF81;
	Tue, 30 Dec 2025 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kuKnWS/6"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7192E06D2;
	Tue, 30 Dec 2025 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767082845; cv=none; b=cIpA8JbA4tWQpp7griv47oBUWlDsQspTIuUmuK43ay0gh+4mbkcJzErAPbOR7LU0op0f4cnP6BZE4iS725myhDd7fdcyI6USGnAI5K6wJb/32lp0sWBTMhJfQaMlxN+65I2IDFgcOe5HY7GAv/vryT+KiMaFmHXu96rZ19DaJdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767082845; c=relaxed/simple;
	bh=2/5NAQlEox6CBkcgUUp2SS9yehzrMKqvr56fo5T1OKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UePgoH3FIDd7k+rZEgRCYbdddYiJN0rHecYoX2QjeyxgiqcyaIZE7NnOR8Pj1mX5Yc1+6m35nFnvxUerB59EQGXidgQB/ibUy1lxPg5KQzjp9W0ulUcfV2TcAmAai0PhiCSxNkd4l7cgFCu/77VnwaM48I5wY8N+JSw6pkjSKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kuKnWS/6; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=l6gmkoiawVMtNh5wd3dvaceiMe3wDNhUmnPZk8aV7uY=;
	b=kuKnWS/6icUaMRwY93A+AMovcXoyurTVB15bOTghMEydPGF4XXZSLSO/KgC6xXKQ47S6Iw+9C
	nb/e1M0ZWksQlIZa4scFjXq7VniD2zDgzRoCKGitNKPN0eCe0ouaqbuXs1k06j79JO8xbZUQrXW
	BIAzESL0u9/Tj2cw/NLZHJk=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dgQtV3t4yzRhSM;
	Tue, 30 Dec 2025 16:17:22 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 60A0040562;
	Tue, 30 Dec 2025 16:20:33 +0800 (CST)
Received: from [100.103.109.72] (100.103.109.72) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Dec 2025 16:20:32 +0800
Message-ID: <6c63e3b4-c542-4a9f-bc9f-fa214a139039@huawei.com>
Date: Tue, 30 Dec 2025 16:20:32 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI: Prevent overflow in proc_bus_pci_write()
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <jbarnes@virtuousgeek.org>, <chrisw@redhat.com>,
	<alex.williamson@redhat.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <liuyongqiang13@huawei.com>,
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
References: <20251229180742.GA69587@bhelgaas>
From: duziming <duziming2@huawei.com>
In-Reply-To: <20251229180742.GA69587@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500012.china.huawei.com (7.202.195.23)


在 2025/12/30 2:07, Bjorn Helgaas 写道:
> [+cc Krzysztof; I thought we looked at this long ago?]
>
> On Wed, Dec 24, 2025 at 05:27:18PM +0800, Ziming Du wrote:
>> From: Yongqiang Liu <liuyongqiang13@huawei.com>
>>
>> When the value of ppos over the INT_MAX, the pos is over set to a negtive
>> value which will be passed to get_user() or pci_user_write_config_dword().
>> Unexpected behavior such as a softlock will happen as follows:
> s/negtive/negative/
> s/softlock/soft lockup/ to match message below
Thanks for pointing out the ambiguous parts.
> s/ppos/pos/ (or fix this to refer to "*ppos", which I think is what
> you're referring to)
>
> I guess the point is that proc_bus_pci_write() takes a "loff_t *ppos",
> loff_t is a signed type, and negative read/write offsets are invalid.

Actually, the *loff_t *ppos *passed in is not a negative value. The root 
cause of the issue

lies in the cast *int* *pos = *ppos*. When the value of **ppos* over the 
INT_MAX, the pos is over set

to a negative value. This negative *pos* then propagates through 
subsequent logic, leading to the observed errors.

> If this is easily reproducible with "dd" or similar, could maybe
> include a sample command line?

We reproduced the issue using the following POC:

     #include <stdio.h>

     #include <string.h>
     #include <unistd.h>
     #include <fcntl.h>
     #include <sys/uio.h>

     int main() {
     int fd = open("/proc/bus/pci/00/02.0", O_RDWR);
     if (fd < 0) {
         perror("open failed");
         return 1;
     }
     char data[] = "926b7719201054f37a1d9d391e862c";
     off_t offset = 0x80800001;
     struct iovec iov = {
         .iov_base = data,
         .iov_len = 0xf
     };
     pwritev(fd, &iov, 1, offset);
     return 0;
}

>>   watchdog: BUG: soft lockup - CPU#0 stuck for 130s! [syz.3.109:3444]
>>   RIP: 0010:_raw_spin_unlock_irq+0x17/0x30
>>   Call Trace:
>>    <TASK>
>>    pci_user_write_config_dword+0x126/0x1f0
>>    proc_bus_pci_write+0x273/0x470
>>    proc_reg_write+0x1b6/0x280
>>    do_iter_write+0x48e/0x790
>>    vfs_writev+0x125/0x4a0
>>    __x64_sys_pwritev+0x1e2/0x2a0
>>    do_syscall_64+0x59/0x110
>>    entry_SYSCALL_64_after_hwframe+0x78/0xe2
>>
>> Fix this by add check for the pos.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
>> Signed-off-by: Ziming Du <duziming2@huawei.com>
>> ---
>>   drivers/pci/proc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
>> index 9348a0fb8084..200d42feafd8 100644
>> --- a/drivers/pci/proc.c
>> +++ b/drivers/pci/proc.c
>> @@ -121,7 +121,7 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
>>   	if (ret)
>>   		return ret;
>>   
>> -	if (pos >= size)
>> +	if (pos >= size || pos < 0)
>>   		return 0;
> I see a few similar cases that look like this; maybe we should do the
> same?
>
>    if (pos < 0)
>      return -EINVAL;
>
> Looks like proc_bus_pci_read() has the same issue?

proc_bus_pci_read() may also trigger similar issue as mentioned by Ilpo 
Järvinen in

https://lore.kernel.org/linux-pci/e5a91378-4a41-32fb-00c6-2810084581bd@linux.intel.com/

However, it does not result in an overflow to a negative number.

>
> What about pci_read_config(), pci_write_config(),
> pci_llseek_resource(), pci_read_legacy_io(), pci_write_legacy_io(),
> pci_read_resource_io(), pci_write_resource_io(), pci_read_rom()?
> These are all sysfs things; does the sysfs infrastructure take care of
> negative offsets before we get to these?

In do_pwritev(), the following check has been performed:

    if (pos < 0)
          return -EINVAL;

Theoretically, a negative offset should not occur.

>>   	if (nbytes >= size)
>>   		nbytes = size;
>> -- 
>> 2.43.0
>>

