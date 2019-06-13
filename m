Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87DD443C8D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 17:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfFMPgY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 11:36:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18566 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727182AbfFMKRy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 06:17:54 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 81ECDD7D7A706F99E1A3;
        Thu, 13 Jun 2019 18:17:51 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Jun 2019
 18:17:44 +0800
Subject: Re: [PATCH v4 2/3] lib: logic_pio: Reject accesses to unregistered
 CPU MMIO regions
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <1560262374-67875-1-git-send-email-john.garry@huawei.com>
 <1560262374-67875-3-git-send-email-john.garry@huawei.com>
 <20190613032034.GE13533@google.com>
CC:     <lorenzo.pieralisi@arm.com>, <arnd@arndb.de>,
        <linux-pci@vger.kernel.org>, <rjw@rjwysocki.net>,
        <linux-arm-kernel@lists.infradead.org>, <will.deacon@arm.com>,
        <wangkefeng.wang@huawei.com>, <linuxarm@huawei.com>,
        <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2d5e6112-be27-33c2-c1fd-6ab06405fa40@huawei.com>
Date:   Thu, 13 Jun 2019 11:17:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190613032034.GE13533@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13/06/2019 04:20, Bjorn Helgaas wrote:
> On Tue, Jun 11, 2019 at 10:12:53PM +0800, John Garry wrote:
>> Currently when accessing logical indirect PIO addresses in
>> logic_{in, out}{,s}, we first ensure that the region is registered.
>

Hi Bjorn,

> I think logic_pio is specifically concerned with I/O port space, so
> it's a little bit unfortunate that we named this "PIO".
>
> PIO is a general term for "Programmed I/O", which just means the CPU
> is involved in each transfer, as opposed to DMA.  The transfers can be
> to either MMIO or I/O port space.
>
> So this ends up being a little confusing because I think you mean
> "Port I/O", not "Programmed I/O".
>

Personally I agree that the naming isn't great. But then Arnd does think 
that "PIO" is appropriate.

There were many different names along the way to this support merged, 
and I think that the naming became almost irrelevant in the end.

>> However, no such check exists for CPU MMIO regions. The CPU MMIO regions
>> would be registered by the PCI host (when PCI_IOBASE is defined) in
>> pci_register_io_range().
>
> IIUC this "CPU MMIO region" is an MMIO region where a memory load or
> store from the CPU is converted by a PCI host bridge into an I/O port
> transaction on PCI.
>

Right

> Again IIUC, logic_pio supports two kinds of I/O port space accesses:
>
>   1) The simple "bridge converts loads/stores to an MMIO region to PCI
>      I/O port transactions" kind, and
>
>   2) The more complicated "somebody supplies logic_pio_host_ops
>      functions that do arbitrary magic to generate I/O port
>      transactions on some bus.

Right

>
> And this patch is making the first kind smarter.  Previously it would
> perform the memory access whenever "addr < MMIO_UPPER_LIMIT", but
> after this patch it will only do it if find_io_range() succeeds.
>
> Right?  Sorry for restating what probably should have been obvious to
> me.
>

Yes, right. A logical PIO range is registered for a PCI MMIO region in 
pci_register_io_range(). As such, if no range is registered, we can 
assume that no PCI MMIO region has been mapped and discard any attempted 
access.

> I have two observations here:
>
>   1) The simple "bridge converts CPU MMIO space to PCI I/O port space"
>      flavor is essentially identical to what ia64 (and probably other
>      architectures) does.  This should really be combined somehow.
>

Maybe. For ia64, it seems to have some "platform" versions of IO port 
accessors, and then also accessors need a fence barrier. I'm not sure 
how well that would fit with logical PIO. It would need further analysis.

IIRC, PPC did have its own custom version of "indirect IO". So we could 
look to factor that out.

>   2) If you made a default set of logic_pio_host_ops that merely did
>      loads/stores and maybe added a couple fields in the struct
>      logic_pio_hwaddr, I bet you could unify the two kinds so
>      logic_inb() would look something like this:
>

Yeah, I did consider this. We do not provide host operators for PCI MMIO 
ranges. We could simply provide regular versions of inb et al for this. 
A small obstacle for this is that we redefine inb et al, so would need 
"direct" versions also. It would be strange.

So I'm not sure on the value of this.

>        u8 logic_inb(unsigned long addr)
>        {
>          struct logic_pio_hwaddr *range = find_io_range(addr);
>
> 	 if (!range)
> 	   return (u8) ~0;
>
>          return (u8) range->ops->in(range->hostdata, addr, sz);
>        }
>
>> We have seen scenarios when systems which don't have a PCI host, or they
>> do but the PCI host probe fails, certain drivers attempts to still attempt
>> to access PCI IO ports; examples are in [1] and [2].
>>
>> Such is a case on an ARM64 system without a PCI host:
>>
>> root@(none)$ insmod hwmon/f71805f.ko
>>  Unable to handle kernel paging request at virtual address ffff7dfffee0002e
>>  Mem abort info:
>>    ESR = 0x96000046
>>    Exception class = DABT (current EL), IL = 32 bits
>>    SET = 0, FnV = 0
>>    EA = 0, S1PTW = 0
>>  Data abort info:
>>    ISV = 0, ISS = 0x00000046
>>    CM = 0, WnR = 1
>>  swapper pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
>>  [ffff7dfffee0002e] pgd=000000000141c003, pud=000000000141d003, pmd=0000000000000000
>>  Internal error: Oops: 96000046 [#1] PREEMPT SMP
>>  Modules linked in: f71805f(+)
>>  CPU: 20 PID: 2736 Comm: insmod Not tainted 5.1.0-rc1-00003-g6f1bfec2a620-dirty #99
>>  Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT21 Nemo 2.0 RC0 04/18/2018
>>  pstate: 80000005 (Nzcv daif -PAN -UAO)
>>  pc : logic_outb+0x54/0xb8
>>  lr : f71805f_find+0x2c/0x1b8 [f71805f]
>>  sp : ffff000025fbba90
>>  x29: ffff000025fbba90 x28: ffff000008b944d0
>>  x27: ffff000025fbbdf0 x26: 0000000000000100
>>  x25: ffff801f8c270580 x24: ffff000011420000
>>  x23: ffff000025fbbb3e x22: ffff000025fbbb40
>>  x21: ffff000008b991b8 x20: 0000000000000087
>>  x19: 000000000000002e x18: ffffffffffffffff
>>  x17: 0000000000000000 x16: 0000000000000000
>>  x15: ffff00001127d6c8 x14: 0000000000000000
>>  x13: 0000000000000000 x12: 0000000000000000
>>  x11: 0000000000010820 x10: 0000841fdac40000
>>  x9 : 0000000000000001 x8 : 0000000040000000
>>  x7 : 0000000000210d00 x6 : 0000000000000000
>>  x5 : ffff801fb6a46040 x4 : ffff841febeaeda0
>>  x3 : 0000000000ffbffe x2 : ffff000025fbbb40
>>  x1 : ffff7dfffee0002e x0 : ffff7dfffee00000
>>  Process insmod (pid: 2736, stack limit = 0x(____ptrval____))
>>  Call trace:
>>   logic_outb+0x54/0xb8
>>   f71805f_find+0x2c/0x1b8 [f71805f]
>>   f71805f_init+0x38/0xe48 [f71805f]
>>   do_one_initcall+0x5c/0x198
>>   do_init_module+0x54/0x1b0
>>   load_module+0x1dc4/0x2158
>>   __se_sys_init_module+0x14c/0x1e8
>>   __arm64_sys_init_module+0x18/0x20
>>   el0_svc_common+0x5c/0x100
>>   el0_svc_handler+0x2c/0x80
>>   el0_svc+0x8/0xc
>>  Code: d2bfdc00 f2cfbfe0 f2ffffe0 8b000021 (39000034)
>>  ---[ end trace 10ea80bde051bbfc ]---
>> root@(none)$
>>
>> Well-behaved drivers call request_{muxed_}region() to grab the IO port
>> region, but success here still doesn't actually mean that there is some IO
>> port mapped in this region.
>>
>> This patch adds a check to ensure that the CPU MMIO region is registered
>> prior to accessing the PCI IO ports.
>>
>> Any failed checks silently return.
>
> I *think* what you're doing here is making inb/outb/etc work the same
> as on x86, i.e., if no device responds to an inb(), the caller gets
> ~0, and if no device claims an outb() the data gets dropped.
>

Correct, but with a caveat: when you say no device responds, this means 
that - for arm64 case - no PCI MMIO region is mapped.

> That should be explicit in the commit log.
>
>> [1] https://lore.kernel.org/linux-pci/56F209A9.4040304@huawei.com
>> [2] https://lore.kernel.org/linux-arm-kernel/e6995b4a-184a-d8d4-f4d4-9ce75d8f47c0@huawei.com/
>>

Thanks


