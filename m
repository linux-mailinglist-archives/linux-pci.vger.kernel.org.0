Return-Path: <linux-pci+bounces-43259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6D4CCAC37
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 09:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8ABD3014DD1
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 08:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA332BDC03;
	Thu, 18 Dec 2025 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HOa8+cQx"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC7B139579;
	Thu, 18 Dec 2025 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045039; cv=none; b=sCixXB2yuVwRJqbwYTkRS1RvhxWhfzEtQCio8ha8FDXX19Lg2PwTyuxNdQ7asyhR+5eWPgpMUs8gm/K1rp9/xtUcVlOifHUADmW8tdo1Urfv71Z8eOWH0Avva51uWdHHg2xgsDF8pHi+iUIyEEB6ARc2GrR1z6Dlx6B/vKXJRF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045039; c=relaxed/simple;
	bh=eSru0CIcIbNO8CfMjSugf7M/12HcZe1M77DzK8E6VhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gDMhkRSaCWts5zz2lRv6kl2R1DyEIi4kNnzg9m05L4C6swxTeHG3r86bOWFWAJLk223bkWip746J5qtLKoiyWEhqOgRm/cjECfUi+L9Vx9f3yW5R89A2peJgImRfSYWpGpo8+CKOBA8joP8AMSQ5A/LFIPR0XhgafFbX6Gw3lKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HOa8+cQx; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ftUWyLEv8LNO57kb5ZBXKNFNXzhIGdotmhdCztxWHXM=;
	b=HOa8+cQxQV5da6bDFYP2EU/pW0vd60ScEd2VtDBFwzysDPeouztTigY30PizagF0iPUEvDRhd
	pdHl2rVwlZJzEgxTyTzZHO8Qfux3thkcULGmIYrzEo71GlEMUIal/zeY5cKS173PZesjuU/CbUF
	4Fq+RuYu1/IvS/Q4zZpfA64=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dX35r14Khz1T4GD;
	Thu, 18 Dec 2025 16:01:36 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 962A41804F2;
	Thu, 18 Dec 2025 16:03:49 +0800 (CST)
Received: from [100.103.109.72] (100.103.109.72) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Dec 2025 16:03:48 +0800
Message-ID: <0d723f79-6330-4cb8-95bb-aeaebaf820dd@huawei.com>
Date: Thu, 18 Dec 2025 16:03:48 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] PCI/sysfs: Prohibit unaligned access to I/O port on
 non-x86
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <chrisw@redhat.com>,
	<jbarnes@virtuousgeek.org>, <alex.williamson@redhat.com>,
	<liuyongqiang13@huawei.com>
References: <20251216083912.758219-1-duziming2@huawei.com>
 <20251216083912.758219-3-duziming2@huawei.com>
 <43e40c50-e23b-0ebc-9f82-986b2ea55943@linux.intel.com>
 <e954fe32-4a6b-458f-97a7-d9fbefc48144@huawei.com>
 <f099dd63-ad76-bc55-2e20-89462593a12e@linux.intel.com>
From: duziming <duziming2@huawei.com>
In-Reply-To: <f099dd63-ad76-bc55-2e20-89462593a12e@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500012.china.huawei.com (7.202.195.23)


在 2025/12/17 18:15, Ilpo Järvinen 写道:
> On Wed, 17 Dec 2025, duziming wrote:
>
>> 在 2025/12/16 18:43, Ilpo Järvinen 写道:
>>> On Tue, 16 Dec 2025, Ziming Du wrote:
>>>
>>>> From: Yongqiang Liu <liuyongqiang13@huawei.com>
>>>>
>>>> Unaligned access is harmful for non-x86 archs such as arm64. When we
>>>> use pwrite or pread to access the I/O port resources with unaligned
>>>> offset, system will crash as follows:
>>>>
>>>> Unable to handle kernel paging request at virtual address fffffbfffe8010c1
>>>> Internal error: Oops: 0000000096000061 [#1] SMP
>>>> Modules linked in:
>>>> CPU: 1 PID: 44230 Comm: syz.1.10955 Not tainted 6.6.0+ #1
>>>> Hardware name: linux,dummy-virt (DT)
>>>> pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>> pc : __raw_writew arch/arm64/include/asm/io.h:33 [inline]
>>>> pc : _outw include/asm-generic/io.h:594 [inline]
>>>> pc : logic_outw+0x54/0x218 lib/logic_pio.c:305
>>>> lr : _outw include/asm-generic/io.h:593 [inline]
>>>> lr : logic_outw+0x40/0x218 lib/logic_pio.c:305
>>>> sp : ffff800083097a30
>>>> x29: ffff800083097a30 x28: ffffba71ba86e130 x27: 1ffff00010612f93
>>>> x26: ffff3bae63b3a420 x25: ffffba71bbf585d0 x24: 0000000000005ac1
>>>> x23: 00000000000010c1 x22: ffff3baf0deb6488 x21: 0000000000000002
>>>> x20: 00000000000010c1 x19: 0000000000ffbffe x18: 0000000000000000
>>>> x17: 0000000000000000 x16: ffffba71b9f44b48 x15: 00000000200002c0
>>>> x14: 0000000000000000 x13: 0000000000000000 x12: ffff6775ca80451f
>>>> x11: 1fffe775ca80451e x10: ffff6775ca80451e x9 : ffffba71bb78cf2c
>>>> x8 : 0000988a357fbae2 x7 : ffff3bae540228f7 x6 : 0000000000000001
>>>> x5 : 1fffe775e2b43c78 x4 : dfff800000000000 x3 : ffffba71b9a00000
>>>> x2 : ffff80008d22a000 x1 : ffffc58ec6600000 x0 : fffffbfffe8010c1
>>>> Call trace:
>>>>    _outw include/asm-generic/io.h:594 [inline]
>>>>    logic_outw+0x54/0x218 lib/logic_pio.c:305
>>>>    pci_resource_io drivers/pci/pci-sysfs.c:1157 [inline]
>>>>    pci_write_resource_io drivers/pci/pci-sysfs.c:1191 [inline]
>>>>    pci_write_resource_io+0x208/0x260 drivers/pci/pci-sysfs.c:1181
>>>>    sysfs_kf_bin_write+0x188/0x210 fs/sysfs/file.c:158
>>>>    kernfs_fop_write_iter+0x2e8/0x4b0 fs/kernfs/file.c:338
>>>>    call_write_iter include/linux/fs.h:2085 [inline]
>>>>    new_sync_write fs/read_write.c:493 [inline]
>>>>    vfs_write+0x7bc/0xac8 fs/read_write.c:586
>>>>    ksys_write+0x12c/0x270 fs/read_write.c:639
>>>>    __do_sys_write fs/read_write.c:651 [inline]
>>>>    __se_sys_write fs/read_write.c:648 [inline]
>>>>    __arm64_sys_write+0x78/0xb8 fs/read_write.c:648
>>>>    __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
>>>>    invoke_syscall+0x8c/0x2e0 arch/arm64/kernel/syscall.c:51
>>>>    el0_svc_common.constprop.0+0x200/0x2a8 arch/arm64/kernel/syscall.c:134
>>>>    do_el0_svc+0x4c/0x70 arch/arm64/kernel/syscall.c:176
>>>>    el0_svc+0x44/0x1d8 arch/arm64/kernel/entry-common.c:806
>>>>    el0t_64_sync_handler+0x100/0x130 arch/arm64/kernel/entry-common.c:844
>>>>    el0t_64_sync+0x3c8/0x3d0 arch/arm64/kernel/entry.S:757
>>>>
>>>> Powerpc seems affected as well, so prohibit the unaligned access
>>>> on non-x86 archs.
>>>>
>>>> Fixes: 8633328be242 ("PCI: Allow read/write access to sysfs I/O port
>>>> resources")
>>>> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
>>>> Signed-off-by: Ziming Du <duziming2@huawei.com>
>>>> ---
>>>>    drivers/pci/pci-sysfs.c | 12 ++++++++++++
>>>>    1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>>>> index 7e697b82c5e1..6fa3c9d0e97e 100644
>>>> --- a/drivers/pci/pci-sysfs.c
>>>> +++ b/drivers/pci/pci-sysfs.c
>>>> @@ -1141,6 +1141,13 @@ static int pci_mmap_resource_wc(struct file *filp,
>>>> struct kobject *kobj,
>>>>    	return pci_mmap_resource(kobj, attr, vma, 1);
>>>>    }
>>>>    +#if !defined(CONFIG_X86)
>>>> +static bool is_unaligned(unsigned long port, size_t size)
>>>> +{
>>>> +	return port & (size - 1);
>>>> +}
>>>> +#endif
>>>> +
>>>>    static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
>>>>    			       const struct bin_attribute *attr, char *buf,
>>>>    			       loff_t off, size_t count, bool write)
>>>> @@ -1158,6 +1165,11 @@ static ssize_t pci_resource_io(struct file *filp,
>>>> struct kobject *kobj,
>>>>    	if (port + count - 1 > pci_resource_end(pdev, bar))
>>>>    		return -EINVAL;
>>>>    +#if !defined(CONFIG_X86)
>>>> +	if (is_unaligned(port, count))
>>>> +		return -EFAULT;
>>>> +#endif
>>>> +
>>> This changes return value from -EINVAL -> -EFAULT for some values of count
>>> which seems not justified.
>>>
>>> To me it's not clear why even x86 should allow unaligned access. This
>>> interface is very much geared towards natural alignment and sizing of the
>>> reads (e.g. count = 3 leads to -EINVAL), so it feels somewhat artificial
>>> to make x86 behave different here from the others.
>> Thanks for your review! We verify that when count = 3, the return value will
>> not be
>>
>> -EFAULT; It will only return -EFAULT in cases of unaligned access.
> Oh, then there's even worse problem in your code as your is_aligned()
> assumes size is a power of two value.
>
> Also, is_aligned() seems to be duplicating IS_ALIGNED() (your naming is
> very misleading as it's a prefixless name that overlaps with a generic
> macro with the very same name).

Thanks for pointing that out. I'll update it to use the existing macro.

Our test shows the panic only triggers when count is 2 or 4, so we will 
scope**the fix to power of two

values and allow other cases to fall through to the default 
-EINVAL return without extra handling.

>> We conduct a POC on QEMU with the ARM architecture as follows:
>>
>> #include <stdio.h>
>> #include <fcntl.h>
>> #include <unistd.h>
>>
>> int main()
>> {
>>          int fd = open("/sys/bus/pci/devices/0000:00:01.0/resource0", O_RDWR);
>>          char buf[] = "1233333";
>>          if (fd < 0) {
>>                  printf("open failed\n");
>>                  return 1;
>>          }
>>
>>          pwrite(fd, buf, 2, 1);
>>
>>          return 0;
>> }
>>
>> On x86, this does not trigger a kernel panic.
>>
>>>>    	switch (count) {
>>>>    	case 1:
>>>>    		if (write)
>>>>

