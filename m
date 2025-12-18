Return-Path: <linux-pci+bounces-43254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 662F8CCAA60
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 08:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2AB530B0928
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 07:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9594E31A06A;
	Thu, 18 Dec 2025 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="eB/lS7Aa"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AA7319857;
	Thu, 18 Dec 2025 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766042333; cv=none; b=eRKVDV/hhjexTe8rm5AMGXmymVJOynmpFXg3ed3ddasjC+eELHflZLLj/FDK0FsMv0FLvwFqVp1l2wHqT+SdWTty/8i2Lcqw7D1U6a45sNFqk3GrF+Fma5eUiuCj7I2Fr04p+52GYaxT225y+P7UNd3spmvrSweTbaCF+lTXCXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766042333; c=relaxed/simple;
	bh=9L2Ex/XF8nU6TDS3lsHO9keBJpGvrs5rOIt/pPtj6WM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KbRtUvojipVyJDefz3AYeO8VvIhJAqEJlcrf8t8YzWcOd7ItFaHCZJd57gHvx80BxUvHgiNcPmwuWb7hswunrGODYQ6hQAQ3xKiA8Lk4tljtTLtSSoyI2BFvz4OcE2hP9S5ZAi581OfezXl6P3akiaaecdpb3DTu9s5jOmW2JLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=eB/lS7Aa; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TtMrrXUE8QnMyr26DfOSehZ+/u75TA1uEkiu9u5pJ/c=;
	b=eB/lS7AahV9g52L2adm8wgtfmCsEjLPb3VUqCM1ibaQE96bfXYVI1TXWLHNSHf6EGEjqCy/gY
	u5wXGA/v+NU/uUB8SHmjaoA2M7XbhPQtrhcGgPwF6J7lS1m5ah9BBytKNKqBqrYHbnZePwWQ4+R
	yfDCGVnBtCbICQNAtONwSNA=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dX25F1pmLzpSvn;
	Thu, 18 Dec 2025 15:16:01 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id F1611140278;
	Thu, 18 Dec 2025 15:18:46 +0800 (CST)
Received: from [100.103.109.72] (100.103.109.72) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Dec 2025 15:18:46 +0800
Message-ID: <1d7f985d-0c3d-42cc-85fd-155fbda522cc@huawei.com>
Date: Thu, 18 Dec 2025 15:18:45 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] PCI: Prevent overflow in proc_bus_pci_write()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <chrisw@redhat.com>,
	<jbarnes@virtuousgeek.org>, <alex.williamson@redhat.com>,
	<liuyongqiang13@huawei.com>
References: <20251216083912.758219-1-duziming2@huawei.com>
 <20251216083912.758219-4-duziming2@huawei.com>
 <47ccdb75-7134-b86a-e8bb-eebb9f1e0b47@linux.intel.com>
 <df3dba86-e6c3-484a-b384-6c6197afcfe3@huawei.com>
 <e5a91378-4a41-32fb-00c6-2810084581bd@linux.intel.com>
From: duziming <duziming2@huawei.com>
In-Reply-To: <e5a91378-4a41-32fb-00c6-2810084581bd@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500012.china.huawei.com (7.202.195.23)


在 2025/12/17 18:19, Ilpo Järvinen 写道:
> On Wed, 17 Dec 2025, duziming wrote:
>> 在 2025/12/16 18:57, Ilpo Järvinen 写道:
>>> On Tue, 16 Dec 2025, Ziming Du wrote:
>>>
>>>> When the value of ppos over the INT_MAX, the pos will be
>>> is over
>>>
>>>> set a negtive value which will be pass to get_user() or
>>> set to a negative value which will be passed
>>>
>>>> pci_user_write_config_dword(). And unexpected behavior
>>> Please start the sentence with something else than And.
>>>
>>> Hmm, the lines look rather short too, can you please reflow the changelog
>>> paragraphs to 75 characters.
>> Thanks for the review. I'll reflow the changelog to 75-character lines and
>> avoid
>>
>> starting sentences with 'And' in the next revision.
>>
>>>> such as a softlock happens:
>>>>
>>>>    watchdog: BUG: soft lockup - CPU#0 stuck for 130s! [syz.3.109:3444]
>>>>    Modules linked in:
>>>>    CPU: 0 PID: 3444 Comm: syz.3.109 Not tainted 6.6.0+ #33
>>>>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>>>> rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>>>>    RIP: 0010:_raw_spin_unlock_irq+0x17/0x30
>>>>    Code: cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e
>>>> fa 0f 1f 44 00 00 e8 52 12 00 00 90 fb 65 ff 0d b1 a1 86 6d <74> 05 e9 42
>>>> 52 00 00 0f 1f 44 00 00 c3 cc cc cc cc 0f 1f 84 00 00
>>>>    RSP: 0018:ffff88816851fb50 EFLAGS: 00000246
>>>>    RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff927daf9b
>>>>    RDX: 0000000000000cfc RSI: 0000000000000046 RDI: ffffffff9a7c7400
>>>>    RBP: 00000000818bb9dc R08: 0000000000000001 R09: ffffed102d0a3f59
>>>>    R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000000
>>>>    R13: ffff888102220000 R14: ffffffff926d3b10 R15: 00000000210bbb5f
>>>>    FS:  00007ff2d4e56640(0000) GS:ffff8881f5c00000(0000)
>>>> knlGS:0000000000000000
>>>>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>    CR2: 00000000210bbb5b CR3: 0000000147374002 CR4: 0000000000772ef0
>>>>    PKRU: 00000000
>>>>    Call Trace:
>>>>     <TASK>
>>>>     pci_user_write_config_dword+0x126/0x1f0
>>>>     ? __get_user_nocheck_8+0x20/0x20
>>>>     proc_bus_pci_write+0x273/0x470
>>>>     proc_reg_write+0x1b6/0x280
>>>>     do_iter_write+0x48e/0x790
>>>>     ? import_iovec+0x47/0x90
>>>>     vfs_writev+0x125/0x4a0
>>>>     ? futex_wake+0xed/0x500
>>>>     ? __pfx_vfs_writev+0x10/0x10
>>>>     ? userfaultfd_ioctl+0x131/0x1ae0
>>>>     ? userfaultfd_ioctl+0x131/0x1ae0
>>>>     ? do_futex+0x17e/0x220
>>>>     ? __pfx_do_futex+0x10/0x10
>>>>     ? __fget_files+0x193/0x2b0
>>>>     __x64_sys_pwritev+0x1e2/0x2a0
>>>>     ? __pfx___x64_sys_pwritev+0x10/0x10
>>>>     do_syscall_64+0x59/0x110
>>>>     entry_SYSCALL_64_after_hwframe+0x78/0xe2
>>> Could you please trim the dump so it only contains things relevant to this
>>> issue () (also check trimming in the other patches).
>> Thanks for pointing that out, we'll make sure to only keep the relevant stacks
>> in future patches.
>>>> Fix this by use unsigned int for the pos.
>>>>
>>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>>> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
>>>> Signed-off-by: Ziming Du <duziming2@huawei.com>
>>>> ---
>>>>    drivers/pci/proc.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
>>>> index 9348a0fb8084..dbec1d4209c9 100644
>>>> --- a/drivers/pci/proc.c
>>>> +++ b/drivers/pci/proc.c
>>>> @@ -113,7 +113,7 @@ static ssize_t proc_bus_pci_write(struct file *file,
>>>> const char __user *buf,
>>>>    {
>>>>    	struct inode *ino = file_inode(file);
>>>>    	struct pci_dev *dev = pde_data(ino);
>>>> -	int pos = *ppos;
>>>> +	unsigned int pos = *ppos;
>>>>    	int size = dev->cfg_size;
>>>>    	int cnt, ret;
>>> So this still throws away some bits compared with the original ppos ?
>> The current approach may lose some precision compared to the original ppos,
>> but a later check ensures  pos
>>
>> remains valid—so any potential information loss is handled safely.
> That's somewhat odd definition of "valid" if a big ppos results in
> a smaller number after the precision loss that is smaller than size.

Oh, I get your concern now. In fact, in previous version, we fixed it 
like this :

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index dbec1d4209c9..200d42feafd8 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -113,7 +113,7 @@ static ssize_t proc_bus_pci_write(struct file *file, 
const char __user *buf,
  {
         struct inode *ino = file_inode(file);
         struct pci_dev *dev = pde_data(ino);
-       unsigned int pos = *ppos;
+       int pos = *ppos;
         int size = dev->cfg_size;
         int cnt, ret;

@@ -121,7 +121,7 @@ static ssize_t proc_bus_pci_write(struct file *file, 
const char __user *buf,
         if (ret)
                 return ret;

-       if (pos >= size)
+       if (pos >= size || pos < 0)
                 return 0;
         if (nbytes >= size)
                 nbytes = size;

In addition, we notice that in proc_bus_pci_read(), "unsigned int pos = 
*ppos" might also cause some issues.

>

