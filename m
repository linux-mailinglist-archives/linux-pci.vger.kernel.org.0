Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5064AE28CC
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 05:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408327AbfJXD1N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Oct 2019 23:27:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4754 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403962AbfJXD1N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 23:27:13 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4DCBAD337FCCB9B119C0;
        Thu, 24 Oct 2019 11:27:11 +0800 (CST)
Received: from [127.0.0.1] (10.133.224.57) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Thu, 24 Oct 2019
 11:27:01 +0800
Subject: Re: Kernel panic while doing vfio-pci hot-plug/unplug test
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <peterz@infradead.org>,
        <alex.williamson@redhat.com>,
        Wang Haibin <wanghaibin.wang@huawei.com>,
        Guoheyi <guoheyi@huawei.com>,
        yebiaoxiang <yebiaoxiang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20191023204638.GA8868@google.com>
From:   Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <2b43a560-787b-9e59-d74a-2f454759563c@huawei.com>
Date:   Thu, 24 Oct 2019 11:26:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191023204638.GA8868@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.224.57]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2019/10/24 4:46, Bjorn Helgaas wrote:
> [+cc Thomas, Rafael, beginning of thread at
> https://lore.kernel.org/r/79827f2f-9b43-4411-1376-b9063b67aee3@huawei.com]
> 
> On Wed, Oct 23, 2019 at 09:38:51AM -0700, Matthew Wilcox wrote:
>> On Wed, Oct 23, 2019 at 10:15:40AM -0500, Bjorn Helgaas wrote:
>>> I don't like being one of a handful of callers of __add_wait_queue(),
>>> so I like that solution from that point of view.
>>>
>>> The 7ea7e98fd8d0 ("PCI: Block on access to temporarily unavailable pci
>>> device") commit log suggests that using __add_wait_queue() is a
>>> significant optimization, but I don't know how important that is in
>>> practical terms.  Config accesses are never a performance path anyway,
>>> so I'd be inclined to use add_wait_queue() unless somebody complains.
>>
>> Wow, this has got pretty messy in the umpteen years since I last looked
>> at it.
>>
>> Some problems I see:
>>
>> 1. Commit df65c1bcd9b7b639177a5a15da1b8dc3bee4f5fa (tglx) says:
>>
>>     x86/PCI: Select CONFIG_PCI_LOCKLESS_CONFIG
>>     
>>     All x86 PCI configuration space accessors have either their own
>>     serialization or can operate completely lockless (ECAM).
>>     
>>     Disable the global lock in the generic PCI configuration space accessors.
>>
>> The concept behind this patch is broken.  We still need to lock out
>> config space accesses when devices are undergoing D-state transitions.
>> I would suggest that for the contention case that tglx is concerned about,
>> we should have a pci_bus_read_config_unlocked_##size set of functions
>> which can be used for devices we know never go into D states.
> 
> Host bridges that can't do config accesses atomically, e.g., they have
> something like the 0xcf8/0xcfc addr/data ports, need serialization.
> CONFIG_PCI_LOCKLESS_CONFIG removes the use of pci_lock for that, and I
> think that part makes sense regardless of whether devices can enter D
> states.
> 
> We *should* prevent config accesses during D-state transitions (per
> PCIe r5.0, sec 5.9), but I don't think pci_lock ever did that.
> pci_raw_set_power_state() contains delays, but that only prevents
> accesses from the caller, not from other threads or from userspace.
> I suppose we should also prevent accesses by other threads during
> transitions done by ACPI, e.g., _PS0, _PS1, _PS2, _PS3.  AFAICT we
> don't do any of that.
> 
> It looks like pci_lock currently:
> 
>   - Serializes all kernel config accesses system-wide in
>     pci_bus_read_config_##size() (unless CONFIG_PCI_LOCKLESS_CONFIG=y).
> 
>   - Serializes all userspace config accesses system-wide in
>     pci_user_read_config_##size() (this seems unnecessary when
>     CONFIG_PCI_LOCKLESS_CONFIG=y).
> 
>   - Serializes userspace config accesses with resets of the device via
>     the dev->block_cfg_access bit and waitqueue mechanism.
> 
>   - Serializes kernel and userspace config accesses with bus->ops
>     changes in pci_bus_set_ops() (except that we don't serialize
>     kernel config accesses if CONFIG_PCI_LOCKLESS_CONFIG=y, which is
>     probably a problem).  But pci_bus_set_ops() is hardly used and I'm
>     not sure it's worth keeping it.
> 
>> 2. Commit a2e27787f893621c5a6b865acf6b7766f8671328 (jan kiszka)
>>    exports pci_lock.  I think this is a mistake; at best there should be
>>    accessors for the pci_lock.  But I don't understand why it needs to
>>    exclude PCI config space changes throughout pci_check_and_set_intx_mask().
>>    Why can it not do:
>>
>> -	bus->ops->read(bus, dev->devfn, PCI_COMMAND, 4, &cmd_status_dword);
>> +	pci_read_config_dword(dev, PCI_COMMAND, &cmd_status_dword);
>>
>> 3. I don't understand why 511dd98ce8cf6dc4f8f2cb32a8af31ce9f4ba4a1
>>    changed pci_lock to be a raw spinlock.  The patch description
>>    essentially says "We need it for RT" which isn't terribly helpful.
>>
>> 4. Finally, getting back to the original problem report here, I wouldn't
>>    write this code this way today.  There's no reason not to use the
>>    regular add_wait_queue etc.  BUT!  Why are we using this custom locking
>>    mechanism?  It pretty much screams to me of an rwsem (reads/writes
>>    of config space take it for read; changes to config space accesses
>>    (disabling and changing of accessor methods) take it for write.
> 
> So maybe the immediate thing is to just convert to add_wait_queue()?

Hmmm... May I push a patch? :)

> 
> There's a lot we could clean up here, but I think it would take a fair
> bit of untangling before we actually solve this panic.
> 
> Bjorn
> 
> .
> 

-- 

Thanks,
Xiang

