Return-Path: <linux-pci+bounces-43622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D249DCDB128
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 02:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63DF1301897B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 01:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77682273D81;
	Wed, 24 Dec 2025 01:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="11oZWYb1"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1802826FA6F;
	Wed, 24 Dec 2025 01:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766539727; cv=none; b=B32/QuYhe+MF/bqljLQbvzRqEMwGjms2SVP89vOsKt8swEsoFuuvnz0PceXuMVdyJuG8WYYKIaiifxQLRG6QSdVYnLLyzQaxcwp8HPqysdDSeSFup9aqHuO+sLWXoldSv9DSR1J152l5gS/7fB02IXihjpWMGFv+Zm+uaPTF8bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766539727; c=relaxed/simple;
	bh=5e5V+WqLZPmiaIWN1CBJ1conoGX63A+JJuMQkhSSFAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DUo0P5RETwyPYRTsXoJWytljiNp8mTXIIixD/7TIEcMjntc0NdwDqoLcOxklAgCqf5S33N05byQplXCzs55/bh6wJYY1lXQxNxlZzqmBxsJI15hv7thnIO5+GCIYofCfTkBCnZ8qyq7JhnxL2EWOSDh0DiAULsCUNb2zY1nhrJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=11oZWYb1; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=W9d2qScMNOWru+CPzrUYHdZa+NQ+Sv85jO31AB4uwq0=;
	b=11oZWYb1oIgb8g5n8drSs2DysFqA8kO8kbpMUwgoySS3OsWAvX79NqOS3cscyKpS0kTdZLy6Q
	AHlLKIPqPk6UEMYgNlFXnK+TswP4DCzWx9MkbiS7ape7ZZmGJuuotf2uHmI3fJy55wycZhDHKzx
	LIFuvD9TuuGFdEcCSWswqnQ=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dbZ201db3zRhRm;
	Wed, 24 Dec 2025 09:25:28 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D3AD4036C;
	Wed, 24 Dec 2025 09:28:35 +0800 (CST)
Received: from [100.103.109.72] (100.103.109.72) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 24 Dec 2025 09:28:34 +0800
Message-ID: <500f12a0-bebe-45db-bcc0-9820f192f147@huawei.com>
Date: Wed, 24 Dec 2025 09:28:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] PCI/sysfs: fix null pointer dereference during PCI
 hotplug
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <chrisw@redhat.com>,
	<jbarnes@virtuousgeek.org>, <alex.williamson@redhat.com>,
	<liuyongqiang13@huawei.com>
References: <20251223165519.GA4023266@bhelgaas>
From: duziming <duziming2@huawei.com>
In-Reply-To: <20251223165519.GA4023266@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500012.china.huawei.com (7.202.195.23)


在 2025/12/24 0:55, Bjorn Helgaas 写道:
> Capitalize first word of subject to match history (see
> "git log --oneline drivers/pci/pci-sysfs.c")
>
> Drop "PCI" in "PCI hotplug" -- we already know this is PCI.
>
> On Tue, Dec 16, 2025 at 04:39:10PM +0800, Ziming Du wrote:
>> During the concurrent process of creating and rescanning in VF, the resource
>> files for the same "pci_dev" may be created twice. The second creation attempt
>> fails, resulting the "res_attr" in "pci_dev" to 'kfree', but the pointer is not
>> set to NULL. This will subsequently lead to dereferencing a null pointer when
>> removing the device.
> Wrap this to fit in 75 columns so it still fits in 80 when git log
> indents it.
>
> Drop quotes around struct and member names, e.g., pci_dev, res_attr.
>
> Drop '' around function names and add "()" after, e.g., kfree().
>
>> When we perform the following operation:
>> "echo $vfcount > /sys/class/net/"$pfname"/device/sriov_numvfs &
>>   sleep 0.5
>>   echo 1 > /sys/bus/pci/rescan
>>   pci_remove "$pfname" "
>> system will crash as follows:
> Indent quoted material two spaces and drop the "" around it, e.g.,
>
> When we perform the following operation:
>
>    echo $vfcount > /sys/class/net/"$pfname"/device/sriov_numvfs &
>    sleep 0.5
>    ...
>
> system will crash as follows.
>
>> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>> Mem abort info:
>> ESR = 0x0000000096000004
>> EC = 0x25: DABT (current EL), IL = 32 bits
>> SET = 0, FnV = 0
>> EA = 0, S1PTW = 0
>> FSC = 0x04: level 0 translation fault
>> Data abort info:
>> ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>> CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>> GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> user pgtable: 4k pages, 48-bit VAs, pgdp=000020400d47b000
>> 0000000000000000 pgd=0000000000000000, p4d=0000000000000000
>> Internal error: Oops: 0000000096000004 #1 SMP
>> CPU: 115 PID: 13659 Comm: testEL_vf_resca Kdump: loaded Tainted: G W E 6.6.0 #9
>> Hardware name: Huawei TaiShan 2280 V2/BC82AMDD, BIOS 0.98 08/25/2019
>> pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> pc : __pi_strlen+0x14/0x150
>> lr : kernfs_name_hash+0x24/0xa8
>> sp : ffff8001425c38f0
>> x29: ffff8001425c38f0 x28: ffff204021a21540 x27: 0000000000000000
>> x26: 0000000000000000 x25: 0000000000000000 x24: ffff20400f97fad0
>> x23: ffff20403145a0c0 x22: 0000000000000000 x21: 0000000000000000
>> x20: 0000000000000000 x19: 0000000000000000 x18: ffffffffffffffff
>> x17: 2f35322f38302038 x16: 392e3020534f4942 x15: 00000000fffffffd
>> x14: 0000000000000000 x13: 30643378302f3863 x12: 3378302b636e7973
>> x11: 00000000ffff7fff x10: 0000000000000000 x9 : ffff800100594b3c
>> x8 : 0101010101010101 x7 : 0000000000210d00 x6 : 67241f72241f7224
>> x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
>> x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
>> Call trace:
>> __pi_strlen+0x14/0x150
>> kernfs_find_ns+0x54/0x120
>> kernfs_remove_by_name_ns+0x58/0xf0
>> sysfs_remove_bin_file+0x24/0x38
>> pci_remove_resource_files+0x44/0x90
>> pci_remove_sysfs_dev_files+0x28/0x40
>> pci_stop_bus_device+0xb8/0x118
>> pci_stop_and_remove_bus_device+0x20/0x40
>> pci_iov_remove_virtfn+0xb8/0x138
>> sriov_disable+0xbc/0x190
>> pci_disable_sriov+0x30/0x48
>> hinic_pci_sriov_disable+0x54/0x138 [hinic]
>> hinic_remove+0x140/0x290 [hinic]
>> pci_device_remove+0x4c/0xf8
>> device_remove+0x54/0x90
>> device_release_driver_internal+0x1d4/0x238
>> device_release_driver+0x20/0x38
>> pci_stop_bus_device+0xa8/0x118
>> pci_stop_and_remove_bus_device_locked+0x28/0x50
>> remove_store+0x128/0x208
> Indent this quoted material two spaces and remove parts that aren't
> relevant.
>
>> Fix this by set the pointer to NULL after releasing 'res_attr' immediately.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Ziming Du <duziming2@huawei.com>
>> ---
>>   drivers/pci/pci-sysfs.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index c2df915ad2d2..7e697b82c5e1 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -1222,12 +1222,14 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
>>   		if (res_attr) {
>>   			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
>>   			kfree(res_attr);
>> +			pdev->res_attr[i] = NULL;
>>   		}
>>   
>>   		res_attr = pdev->res_attr_wc[i];
>>   		if (res_attr) {
>>   			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
>>   			kfree(res_attr);
>> +			pdev->res_attr_wc[i] = NULL;
>>   		}
>>   	}
>>   }
>> -- 
>> 2.43.0
Thanks for your correction. We will include them in the v2 patch

