Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80A2270CEC
	for <lists+linux-pci@lfdr.de>; Sat, 19 Sep 2020 12:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgISKWr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Sep 2020 06:22:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35380 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbgISKWr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 19 Sep 2020 06:22:47 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 589AED33047BBAA67BED;
        Sat, 19 Sep 2020 18:22:45 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Sat, 19 Sep 2020
 18:22:37 +0800
Subject: Re: [PATCH] PCI: Make sure the bus bridge powered on when scanning
 bus
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20200918161736.GA1810014@bjorn-Precision-5520>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linuxarm@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Wu <peter@lekensteyn.nl>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <0f900024-fb38-e485-9ba1-d7471c792bac@hisilicon.com>
Date:   Sat, 19 Sep 2020 18:22:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200918161736.GA1810014@bjorn-Precision-5520>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/9/19 0:17, Bjorn Helgaas wrote:

> On Fri, Sep 18, 2020 at 05:31:54PM +0800, Yicong Yang wrote:
>> On 2020/9/18 5:07, Bjorn Helgaas wrote:
>>> On Wed, Jul 29, 2020 at 07:30:23PM +0800, Yicong Yang wrote:
>>>> When the bus bridge is runtime suspended, we'll fail to rescan
>>>> the devices through sysfs as we cannot access the configuration
>>>> space correctly when the bridge is in D3hot.
>>>> It can be reproduced like:
>>>>
>>>> $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/0000:81:00.1/remove
>>>> $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/pci_bus/0000:81/rescan
>>>>
>>>> 0000:80:00.0 is root port and is runtime suspended and we cannot
>>>> get 0000:81:00.1 after rescan.
>>>>
>>>> Make bridge powered on when scanning the child bus, by adding
>>>> pm_runtime_get_sync()/pm_runtime_put() in pci_scan_child_bus_extend().
>>>>
>>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>>> ---
>>>>  drivers/pci/probe.c | 11 +++++++++++
>>>>  1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>>> index 2f66988..5bb502b 100644
>>>> --- a/drivers/pci/probe.c
>>>> +++ b/drivers/pci/probe.c
>>>> @@ -2795,6 +2795,14 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>>>>  
>>>>  	dev_dbg(&bus->dev, "scanning bus\n");
>>>>  
>>>> +	/*
>>>> +	 * Make sure the bus bridge is powered on, otherwise we may not be
>>>> +	 * able to scan the devices as we may fail to access the configuration
>>>> +	 * space of subordinates.
>>>> +	 */
>>>> +	if (bus->self)
>>>> +		pm_runtime_get_sync(&bus->self->dev);
>>> I think if we do this, we should be able to remove the call from
>>> pci_scan_bridge() added by d963f6512e15 ("PCI: Power on bridges before
>>> scanning new devices"), right?
>>>
>>> The reason we need it here is because there are two paths to
>>> pci_scan_child_bus_extend() and only one of them calls
>>> pm_runtime_get_sync():
>>>
>>>   pci_scan_bridge_extend
>>>     pm_runtime_get_sync
>>>     pci_scan_child_bus_extend
>>>
>>>   pci_scan_child_bus
>>>     pci_scan_child_bus_extend
>>>
>>> If we move the pm_runtime_get_sync() from pci_scan_bridge_extend() to
>>> pci_scan_child_bus_extend(), both paths should be safe.
>> A bit different, I think. The issue I met is a bit different from
>> Mika, as we go through different sysfs files. Think about rescanning
>> device under a root port,
>>
>> when echo 1 > /sysfs/bus/pci/devices/${RootPort}/rescan:
>>
>> rescan_store()
>>   pci_rescan_bus(pdev->bus) /* we will rescan the root bus */
>>     pci_rescan_child_bus()
>>       pci_scan_child_bus_extend()  /* we cannot wake up the bus bridge here as is on the root bus */
>>         pci_scan_bridge_extend() /* we have to wake up the root port here */
>>
>> when echo 1 > /sysfs/bus/pci/devices/${RootPort}/pci_bus/${PciBus}/rescan:
>>
>> rescan_store()
>>   pci_rescan_bus(bus) /* we will rescan the bus of the root port */
>>     pci_rescan_child_bus()
>>       pci_scan_child_bus_extend() /* we can wake up the bus bridge - root port here */
>>
>> As different bus is rescanned, so it'll have problem without patch
>> d963f6512e15.
> Sorry, I didn't quite follow the above.
>
> The problem here is about scanning a bridge's secondary bus when the
> bridge may be runtime-suspended.  The bridge may be in D0, D1, D2, or
> D3hot.  It is not in D3cold.  pm_runtime_get_sync() brings a device
> that may have been runtime-suspended back to D0.
>
> All PCI devices respond to config accesses when they are in D0, D1,
> D2, or D3hot [1], so we don't need pm_runtime_get_sync() to access a
> bridge's config space.
>
> But when a bridge is not in D0, it does not initiate transactions on
> its secondary bus [2], so we do need pm_runtime_get_sync() before we
> attempt config accesses for any children.
>
> pci_scan_bridge_extend() does not directly do anything with the
> secondary bus, which is why I'm not sure it needs
> pm_runtime_get_sync().
>
> The accesses to the secondary bus are in pci_scan_slot(), so the
> pm_runtime_get_sync() you added immediately before calling
> pci_scan_slot() makes sense to me.  Although possibly it could go in
> pci_scan_slot() itself, since there are several other callers.
>
> [1] PCIe r5.0, sec 5.3.1.4.1
> [2] PCIe r5.0, sec 5.3.1 implementation note

yes it's right. with this patch and patch d963f6512e15 removed, the rescan
works well and I've tested it. I didn't understand it correctly in my last
reply, sorry. I'll remove d963f6512e15 in v2 patch.

If we put the pm_runtime_get/put in the pci_scan_slot(), we'll get/put the
bridge many times. so maybe put it immediately before pci_scan_slot() is
better?

Thanks,
Yicong


>
>>>>  	/* Go find them, Rover! */
>>>>  	for (devfn = 0; devfn < 256; devfn += 8) {
>>>>  		nr_devs = pci_scan_slot(bus, devfn);
>>>> @@ -2907,6 +2915,9 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>>>>  		}
>>>>  	}
>>>>  
>>>> +	if (bus->self)
>>>> +		pm_runtime_put(&bus->self->dev);
>>> I would probably do this:
>>>
>>>   struct pci_dev *bridge = bus->self;
>>>
>>>   if (bridge)
>>>     pm_runtime_get_sync(&bridge->dev);
>>>   ...
>>>   if (bridge)
>>>     pm_runtime_put(&bridge->dev);
>> Sure.
>>
>> Regards,
>> Yicong
>>
>>
>>>>  	/*
>>>>  	 * We've scanned the bus and so we know all about what's on
>>>>  	 * the other side of any bridges that may be on this bus plus
>>>> -- 
>>>> 2.8.1
>>>>
>>> .
>>>
> .
>

