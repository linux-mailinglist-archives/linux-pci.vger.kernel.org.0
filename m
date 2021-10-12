Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979A0429BA0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 04:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhJLCt0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 22:49:26 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:25174 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhJLCtZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 22:49:25 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HT0RF21Y3z8tVt;
        Tue, 12 Oct 2021 10:46:17 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 12 Oct 2021 10:47:22 +0800
Received: from [10.174.176.245] (10.174.176.245) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 12 Oct 2021 10:47:21 +0800
Subject: Re: [PATCH] PCI/MSI: fix page fault when msi_populate_sysfs() failed
To:     Barry Song <21cnbao@gmail.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Barry Song" <song.bao.hua@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20211012020959.GA1708781@bhelgaas>
 <a6b772d6-edf6-c0a7-078d-0fdbdb9f4f2a@huawei.com>
 <CAGsJ_4xx1NVd2m8iBLOG6sf1k_9-254Ro=C-Vb=3LLvZdW9wMA@mail.gmail.com>
From:   "wanghai (M)" <wanghai38@huawei.com>
Message-ID: <49eb8550-f868-a63e-dd54-a6edec8f049f@huawei.com>
Date:   Tue, 12 Oct 2021 10:47:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGsJ_4xx1NVd2m8iBLOG6sf1k_9-254Ro=C-Vb=3LLvZdW9wMA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.245]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


在 2021/10/12 10:39, Barry Song 写道:
> On Tue, Oct 12, 2021 at 3:25 PM wanghai (M) <wanghai38@huawei.com> wrote:
>>
>> 在 2021/10/12 10:09, Bjorn Helgaas 写道:
>>> On Tue, Oct 12, 2021 at 09:59:40AM +0800, wanghai (M) wrote:
>>>> 在 2021/10/12 1:11, Bjorn Helgaas 写道:
>>>>> For v2, please note "git log --oneline drivers/pci/msi.c" and make
>>>>> your patch follow the style, including capitalization.
>>>>>
>>>>> On Mon, Oct 11, 2021 at 05:15:28PM +0800, wanghai (M) wrote:
>>>>>> 在 2021/10/11 16:52, Barry Song 写道:
>>>>>>> On Mon, Oct 11, 2021 at 9:24 PM Wang Hai <wanghai38@huawei.com> wrote:
>>>>>>>> I got a page fault report when doing fault injection test:
>>>>> When you send v2, can you include information about how you injected
>>>>> the fault?  If it's easy, others can reproduce the failure that way.
>>>> Sorry, the reproduction needs to be based on the fault injection framework
>>>> provided by Hulk Robot. I don't know how the framework is implemented.
>>>>
>>>> The way to reproduce this is to do a fault injection to make
>>>> 'msi_attrs = kcalloc() in msi_populate_sysfs()' fail when insmod
>>>> 9pnet_virtio.ko.
>>>>
>>>> I sent v2 yesterday, can you help review it?
>>>> https://lore.kernel.org/linux-pci/20211011130837.766323-1-wanghai38@huawei.com/
>>>>>>>> BUG: unable to handle page fault for address: fffffffffffffff4
>>>>>>>> ...
>>>>>>>> RIP: 0010:sysfs_remove_groups+0x25/0x60
>>>>>>>> ...
>>>>>>>> Call Trace:
>>>>>>>>      msi_destroy_sysfs+0x30/0xa0
>>>>>>>>      free_msi_irqs+0x11d/0x1b0
>>>>>>>>      __pci_enable_msix_range+0x67f/0x760
>>>>>>>>      pci_alloc_irq_vectors_affinity+0xe7/0x170
>>>>>>>>      vp_find_vqs_msix+0x129/0x560
>>>>>>>>      vp_find_vqs+0x52/0x230
>>>>>>>>      vp_modern_find_vqs+0x47/0xb0
>>>>>>>>      p9_virtio_probe+0xa1/0x460 [9pnet_virtio]
>>>>>>>>      virtio_dev_probe+0x1ed/0x2e0
>>>>>>>>      really_probe+0x1c7/0x400
>>>>>>>>      __driver_probe_device+0xa4/0x120
>>>>>>>>      driver_probe_device+0x32/0xe0
>>>>>>>>      __driver_attach+0xbf/0x130
>>>>>>>>      bus_for_each_dev+0xbb/0x110
>>>>>>>>      driver_attach+0x27/0x30
>>>>>>>>      bus_add_driver+0x1d9/0x270
>>>>>>>>      driver_register+0xa9/0x180
>>>>>>>>      register_virtio_driver+0x31/0x50
>>>>>>>>      p9_virtio_init+0x3c/0x1000 [9pnet_virtio]
>>>>>>>>      do_one_initcall+0x7b/0x380
>>>>>>>>      do_init_module+0x5f/0x21e
>>>>>>>>      load_module+0x265c/0x2c60
>>>>>>>>      __do_sys_finit_module+0xb0/0xf0
>>>>>>>>      __x64_sys_finit_module+0x1a/0x20
>>>>>>>>      do_syscall_64+0x34/0xb0
>>>>>>>>      entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>>>>>
>>>>>>>> When populating msi_irqs sysfs failed in msi_capability_init() or
>>>>>>>> msix_capability_init(), dev->msi_irq_groups will point to ERR_PTR(...).
>>>>>>>> This will cause a page fault when destroying the wrong
>>>>>>>> dev->msi_irq_groups in free_msi_irqs().
>>>>>>>>
>>>>>>>> Fix this by setting dev->msi_irq_groups to NULL when msi_populate_sysfs()
>>>>>>>> failed.
>>>>>>>>
>>>>>>>> Fixes: 2f170814bdd2 ("genirq/msi: Move MSI sysfs handling from PCI to MSI core")
>>>>>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>>> What exactly was reported by the Hulk Robot?  Did it really do the
>>>>> fault injection and report the page fault?
>>>> Yes, it reported the error and provided a way to reproduce it
>>> Great, can you include a link to that report then?
>>> .
>> Currently hulk robot is still in the process of continuous improvement and
>> is not open to the public for the time being, so you can not access our
>> links at the moment. We will open it in the future when it is perfected.
> hi hai, would you like to put some information in the commit log like
> if  'msi_attrs = kcalloc() in msi_populate_sysfs()' fails, blah, blah, blah...
>
> It seems this can make things a bit clearer to me. Anyway, it doesn't matter
> too much. The fix is correct.
Okay, I'll refine the commit log and resend a patch
>> --
>> Wang Hai
>>
> Thanks
> barry
> .
>
-- 
Wang Hai

