Return-Path: <linux-pci+bounces-43965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E729CF0B3F
	for <lists+linux-pci@lfdr.de>; Sun, 04 Jan 2026 08:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA7CC300B291
	for <lists+linux-pci@lfdr.de>; Sun,  4 Jan 2026 07:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F38A2C11EE;
	Sun,  4 Jan 2026 07:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lbdkFpNl"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78D821CC5C;
	Sun,  4 Jan 2026 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767511080; cv=none; b=FmrrCFo90ItJy1ylo6dgYMENZ5XkwjeB6FmB0M4Uh8g0bzb8411Xv9PdhTWHcr6nDRRRMyWXCvR0NtHBDKKuUitwW2WtS36vDCz8atMwvabLYJIiJb3nAeBt8uVYukf8hOfYVtJ96TJhH+ntAfcwBcNNFIUKb/msH3kDjLky3n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767511080; c=relaxed/simple;
	bh=ucR9PsJgWfg/nCmlvVpP5uZKGZGb8VvXpeLciNjpeb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=apuitJAgtFHoYRCkFjjc1YmXFrnKmZToX6YuMnXOJK3TGnAWPduY39821Dhg/H0WK6afZFMQgeiJ5JhjsVa2Wv+ybKrOchMLytrsz9fhIFetK2MCLyU5np7r9aJbt/0QAW360s8is+5AbBBq4bqXd0qvGJQHEosNxV84yqKI2EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lbdkFpNl; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=e2R39d2DpcuTn9Nu8s5MGnlLIK2L0FiSaxMkhAIWWs4=;
	b=lbdkFpNlR4gpgHE7ADtGXa2AvpyzmHOhCqGhPnwRxdiOowvISS/s+UeRfuY9WB1t5u7zVKZ1d
	MzSd6C2Q/KSXn2w0utMUPw8YzEhfUBSmhypVBUuz2C98aqiJ37JrZJtelEXoGiwOp5yP4t65qON
	RpU/xzU2RwknW1dx3xFdBrA=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dkTGX27SVz1T4Gh;
	Sun,  4 Jan 2026 15:15:16 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 95E2F40538;
	Sun,  4 Jan 2026 15:17:53 +0800 (CST)
Received: from [100.103.109.72] (100.103.109.72) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 4 Jan 2026 15:17:52 +0800
Message-ID: <590a8869-6166-4b5d-8b3e-5a144062699a@huawei.com>
Date: Sun, 4 Jan 2026 15:17:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI: Prevent overflow in proc_bus_pci_write()
To: Bjorn Helgaas <helgaas@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: <bhelgaas@google.com>, <jbarnes@virtuousgeek.org>, <chrisw@redhat.com>,
	<alex.williamson@redhat.com>, <linux-pci@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <liuyongqiang13@huawei.com>,
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
References: <20251231170434.GA160560@bhelgaas>
From: duziming <duziming2@huawei.com>
In-Reply-To: <20251231170434.GA160560@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500012.china.huawei.com (7.202.195.23)


在 2026/1/1 1:04, Bjorn Helgaas 写道:
> On Wed, Dec 31, 2025 at 11:31:47AM +0200, Ilpo Järvinen wrote:
>> On Tue, 30 Dec 2025, duziming wrote:
>>> 在 2025/12/30 2:07, Bjorn Helgaas 写道:
>>>> [+cc Krzysztof; I thought we looked at this long ago?]
>>>>
>>>> On Wed, Dec 24, 2025 at 05:27:18PM +0800, Ziming Du wrote:
>>>>> From: Yongqiang Liu <liuyongqiang13@huawei.com>
>>>>>
>>>>> When the value of ppos over the INT_MAX, the pos is over set to a negtive
>>>>> value which will be passed to get_user() or pci_user_write_config_dword().
>>>>> Unexpected behavior such as a softlock will happen as follows:
>>>> s/negtive/negative/
>>>> s/softlock/soft lockup/ to match message below
>>> Thanks for pointing out the ambiguous parts.
>>>> s/ppos/pos/ (or fix this to refer to "*ppos", which I think is what
>>>> you're referring to)
>>>>
>>>> I guess the point is that proc_bus_pci_write() takes a "loff_t *ppos",
>>>> loff_t is a signed type, and negative read/write offsets are invalid.
>>> Actually, the *loff_t *ppos *passed in is not a negative value. The root cause
>>> of the issue
>>>
>>> lies in the cast *int* *pos = *ppos*. When the value of **ppos* over the
>>> INT_MAX, the pos is over set
>>>
>>> to a negative value. This negative *pos* then propagates through subsequent
>>> logic, leading to the observed errors.
>>>
>>>> If this is easily reproducible with "dd" or similar, could maybe
>>>> include a sample command line?
>>> We reproduced the issue using the following POC:
>>>
>>>      #include <stdio.h>
>>>
>>>      #include <string.h>
>>>      #include <unistd.h>
>>>      #include <fcntl.h>
>>>      #include <sys/uio.h>
>>>
>>>      int main() {
>>>      int fd = open("/proc/bus/pci/00/02.0", O_RDWR);
>>>      if (fd < 0) {
>>>          perror("open failed");
>>>          return 1;
>>>      }
>>>      char data[] = "926b7719201054f37a1d9d391e862c";
>>>      off_t offset = 0x80800001;
>>>      struct iovec iov = {
>>>          .iov_base = data,
>>>          .iov_len = 0xf
>>>      };
>>>      pwritev(fd, &iov, 1, offset);
>>>      return 0;
>>> }
>>>
>>>>>    watchdog: BUG: soft lockup - CPU#0 stuck for 130s! [syz.3.109:3444]
>>>>>    RIP: 0010:_raw_spin_unlock_irq+0x17/0x30
>>>>>    Call Trace:
>>>>>     <TASK>
>>>>>     pci_user_write_config_dword+0x126/0x1f0
>>>>>     proc_bus_pci_write+0x273/0x470
>>>>>     proc_reg_write+0x1b6/0x280
>>>>>     do_iter_write+0x48e/0x790
>>>>>     vfs_writev+0x125/0x4a0
>>>>>     __x64_sys_pwritev+0x1e2/0x2a0
>>>>>     do_syscall_64+0x59/0x110
>>>>>     entry_SYSCALL_64_after_hwframe+0x78/0xe2
>>>>>
>>>>> Fix this by add check for the pos.
>>>>>
>>>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>>>> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
>>>>> Signed-off-by: Ziming Du <duziming2@huawei.com>
>>>>> ---
>>>>>    drivers/pci/proc.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
>>>>> index 9348a0fb8084..200d42feafd8 100644
>>>>> --- a/drivers/pci/proc.c
>>>>> +++ b/drivers/pci/proc.c
>>>>> @@ -121,7 +121,7 @@ static ssize_t proc_bus_pci_write(struct file *file,
>>>>> const char __user *buf,
>>>>>    	if (ret)
>>>>>    		return ret;
>>>>>    -	if (pos >= size)
>>>>> +	if (pos >= size || pos < 0)
>>>>>    		return 0;
>>>> I see a few similar cases that look like this; maybe we should do the
>>>> same?
>>>>
>>>>     if (pos < 0)
>>>>       return -EINVAL;
>>>>
>>>> Looks like proc_bus_pci_read() has the same issue?
>>> proc_bus_pci_read() may also trigger similar issue as mentioned by Ilpo
>>> Järvinen in
>>>
>>> https://lore.kernel.org/linux-pci/e5a91378-4a41-32fb-00c6-2810084581bd@linux.intel.com/
>>>
>>> However, it does not result in an overflow to a negative number.
>> Why does the cast has to happen first here?
>>
>> This would ensure _correctness_ without any false alignment issues for
>> large numbers:
>>
>> 	int pos;
>> 	int size = dev->cfg_size;
>>
>> 	...
>> 	if (*ppos > INT_MAX)
> Isn't *ppos a signed quantity?  If so, wouldn't we want to check for
> "*ppos < 0"?

If *ppos < 0, it will be discarded in the previous process, just like in 
do_pwritev(), where it returns -EINVAL

when pos is negative. So we think that here using "*ppos > INT_MAX" 
might be more reasonable.

>

