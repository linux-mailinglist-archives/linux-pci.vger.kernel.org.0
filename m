Return-Path: <linux-pci+bounces-11108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146DE944AE6
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 14:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42101B2704C
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 12:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4898619F48D;
	Thu,  1 Aug 2024 12:05:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764FD19F48B
	for <linux-pci@vger.kernel.org>; Thu,  1 Aug 2024 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722513955; cv=none; b=n18ilbSB9V2rdO3d53tOBf3METDTpTt43tVQnNsG1cOKW7fLZfPzyun2fGkFWX5sG/MqZgtU1k5p7Su9coPOC+w5KVsY52LvyLrsyjlWaBhUEzs7bYJb70Pzj36WnPfyYRl8Nh54D9FCIApbedm7gqNpdtCCLiKT9wMG0wmWkVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722513955; c=relaxed/simple;
	bh=3DrjXaCexd6uVRKqaKPpki0RUm5ceUzGxB1ISlIQvMM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ektoYmHAhkp9XCecXj+dRKrPdpcEBituP7v3J1778alzGdRB+ACB2rbX4hpgelqLx20tIHsBOrY969SPl7zN3bvZXpRoyhB20xDU6oWWW1SKRDkLQUKmL8bso4Dmr+mAH0KQAMJxomJDcf1IURs3AwzaJONxZ1Nl6vIIJfgyL7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WZSN10LdVz1L9MX;
	Thu,  1 Aug 2024 20:05:37 +0800 (CST)
Received: from kwepemd100012.china.huawei.com (unknown [7.221.188.214])
	by mail.maildlp.com (Postfix) with ESMTPS id B54B6140109;
	Thu,  1 Aug 2024 20:05:49 +0800 (CST)
Received: from [10.40.188.234] (10.40.188.234) by
 kwepemd100012.china.huawei.com (7.221.188.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 1 Aug 2024 20:05:49 +0800
Subject: Re: [PATCH] PCI/ASPM: Update ASPM sysfs on MFD function removal to
 avoid use-after-free
To: Bjorn Helgaas <helgaas@kernel.org>, Ding Hui <dinghui@sangfor.com.cn>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>
References: <20240731214606.GA83038@bhelgaas>
From: Jay Fang <f.fangjian@huawei.com>
Message-ID: <155bccea-2728-2a12-7fb5-5b811d04b04f@huawei.com>
Date: Thu, 1 Aug 2024 20:05:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240731214606.GA83038@bhelgaas>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100012.china.huawei.com (7.221.188.214)

On 2024/8/1 5:46, Bjorn Helgaas wrote:
> On Tue, Jul 30, 2024 at 05:57:43PM +0800, Ding Hui wrote:
>> On 2024/7/30 9:16, Jay Fang wrote:
>>>  From 'commit 456d8aa37d0f ("PCI/ASPM: Disable ASPM on MFD function removal
>>> to avoid use-after-free")' we know that PCIe spec r6.0, sec 7.5.3.7,
>>> recommends that software program the same ASPM Control(pcie_link_state)
>>> value in all functions of multi-function devices, and free the
>>> pcie_link_state when any child function is removed.
>>>
>>> However, ASPM Control sysfs is still visible to other children even if it
>>> has been removed by any child function, and careless use it will
>>> trigger use-after-free error, e.g.:
>>>
>>>    # lspci -tv
>>>      -[0000:16]---00.0-[17]--+-00.0  Device 19e5:0222
>>>                              \-00.1  Device 19e5:0222
>>>    # echo 1 > /sys/bus/pci/devices/0000:17:00.0/remove       // pcie_link_state will be released
>>>    # echo 1 > /sys/bus/pci/devices/0000:17:00.1/link/l1_aspm // will trigger error
>>>
>>>    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
>>>    Call trace:
>>>     aspm_attr_store_common.constprop.0+0x10c/0x154
>>>     l1_aspm_store+0x24/0x30
>>>     dev_attr_store+0x20/0x34
>>>     sysfs_kf_write+0x4c/0x5c
>>>
>>> We can solve this problem by updating the ASPM Control sysfs of all
>>> children immediately after ASPM Control have been freed.
>>>
>>> Fixes: 456d8aa37d0f ("PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free")
>>> Signed-off-by: Jay Fang <f.fangjian@huawei.com>
>>> ---
>>>   drivers/pci/pcie/aspm.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>> index cee2365e54b8..eee9e6739924 100644
>>> --- a/drivers/pci/pcie/aspm.c
>>> +++ b/drivers/pci/pcie/aspm.c
>>> @@ -1262,6 +1262,8 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>>>   		pcie_config_aspm_path(parent_link);
>>>   	}
>>> +	pcie_aspm_update_sysfs_visibility(parent);
>>> +
>>
>> To be more rigorous, is there still a race window in
>> aspm_attr_{show,store}_common or clkpm_{show,store} before updating
>> the visibility, we can get an old or NULL pointer by
>> pcie_aspm_get_link()?
> 
> Yeah, I think we still have a problem even with this patch.
If so, maybe we need a new solution to completely sovle this problem.

> 
> For one thing, aspm_attr_store_common() captures the pointer from
> pcie_aspm_get_link() before the critical section, so by the time it
> *uses* the pointer, pcie_aspm_exit_link_state() may have freed the
> link state.
> 
> And there are several other callers of pcie_aspm_get_link() that
> either call it before a critical section or don't have a critical
> section at all.
> 
> I think it may be a mistake to alloc/free the link state separately
> from the pci_dev itself.
> 
>>>   	mutex_unlock(&aspm_lock);
>>>   	up_read(&pci_bus_sem);
>>>   }
>>
>> -- 
>> Thanks,
>> - Ding Hui
>>
> 
> .
> 


