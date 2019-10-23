Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0D5E1403
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 10:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390079AbfJWIWs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Oct 2019 04:22:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47254 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390088AbfJWIWs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 04:22:48 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E8491EEA58C97B172FF5;
        Wed, 23 Oct 2019 16:22:46 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 16:22:44 +0800
Subject: Re: [PATCH] PCI: Warn about host bridge device when its numa node is
 NO_NODE
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mhocko@kernel.org>, <peterz@infradead.org>,
        <robin.murphy@arm.com>, <geert@linux-m68k.org>,
        <gregkh@linuxfoundation.org>, <paul.burton@mips.com>
References: <20191022210420.GA17717@google.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <76d37d5b-49bd-e45c-d42c-415235504893@huawei.com>
Date:   Wed, 23 Oct 2019 16:22:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20191022210420.GA17717@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019/10/23 5:04, Bjorn Helgaas wrote:
> On Sat, Oct 19, 2019 at 02:45:43PM +0800, Yunsheng Lin wrote:
>> As the disscusion in [1]:
> 
> We need to justify this patch right here in the commit log, not with a
> pointer to a 50+ message email thread.

Ok, thanks.

> 
>> A PCI device really _MUST_ have a node assigned. 
> 
> No, it's not really essential.  It's *nice* if we know the node
> closest to a PCI device, but the system should function correctly even
> if we don't.  The only problem is that it will be slower.

Ok, will try to mention the info you mention here in the commit log.

> 
> I think the underlying problem you're addressing is that:
> 
>   - NUMA_NO_NODE == -1,
>   - dev_to_node(dev) may return NUMA_NO_NODE,
>   - kmalloc(dev) relies on cpumask_of_node(dev_to_node(dev)), and
>   - cpumask_of_node(NUMA_NO_NODE) makes an invalid array reference
> 
> For example, on arm64, mips loongson, s390, and x86,
> cpumask_of_node(node) returns "node_to_cpumask_map[node]", and -1 is
> an invalid array index.

The invalid array index of -1 is the underlying problem here when
cpumask_of_node(dev_to_node(dev)) is called and cpumask_of_node()
is not NUMA_NO_NODE aware yet.

In the "numa: make node_to_cpumask_map() NUMA_NO_NODE aware" thread
disscusion, it is requested that it is better to warn about the pcie
device without a node assigned by the firmware before making the
cpumask_of_node() NUMA_NO_NODE aware, so that the system with pci
devices of "NUMA_NO_NODE" node can be fixed by their vendor.

See: https://lore.kernel.org/lkml/20191011111539.GX2311@hirez.programming.kicks-ass.net/

> 
> That problem can't be solved by emitting a warning, of course.  I
> assume some variation of your "numa: make node_to_cpumask_map()
> NUMA_NO_NODE aware" patch [a] will solve that problem.
> 
> [a] https://lore.kernel.org/linux-mips/1568535656-158979-1-git-send-email-linyunsheng@huawei.com/T/#u
> 
> It is probably a good idea to emit a warning about the performance
> issue.
> 
> When I run your patch on qemu, I see this:
> 
>   ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
>   acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
>   acpi PNP0A08:00: _OSC: platform does not support [LTR]
>   acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapability]
>   PCI host bridge to bus 0000:00
>   pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
>   pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
>   pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
>   pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
>   pci_bus 0000:00: root bus resource [mem 0x100000000-0x8ffffffff window]
>   pci_bus 0000:00: root bus resource [bus 00-ff]
>    pci0000:00: [Firmware Bug]: No node assigned on NUMA capable HW by BIOS. Please contact your vendor for updates.
> 
> I didn't debug it to see what's wrong with the " pci0000:00" string.
> Ideally it would be connected with "acpi PNP0A08:00" since that's the
> place where BIOS would make a fix but I suppose "pci_bus 0000:00"
> would be adequate.

It seems the string at the beginning of dev_err() output is consisted
of dev_driver_string() and dev_name().

drivers/base/core.c:
const char *dev_driver_string(const struct device *dev)
{
	struct device_driver *drv;

	/* dev->driver can change to NULL underneath us because of unbinding,
	 * so be careful about accessing it.  dev->bus and dev->class should
	 * never change once they are set, so they don't need special care.
	 */
	drv = READ_ONCE(dev->driver);
	return drv ? drv->name :
			(dev->bus ? dev->bus->name :
			(dev->class ? dev->class->name : ""));
}

The bridge device does not have a driver, a bus or a class, so
dev_driver_string() will return "", that is why there is a extral
space at the beginning of the " pci0000:00". I am not familiar with
the pci, so not sure if this is a problem that the bridge device
does not have a driver, a bus or a class.

And the bus device has a class of pcibus_class, and name of
pcibus_class is "pci_bus".

So maybe change the warning to below:

if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
	dev_err(&bus->dev, FW_BUG "No node assigned on NUMA capable HW. Please contact your vendor for updates.\n");

And it seems a pci device's parent will always set to the bridge
device in pci_setup_device(), and device_add() which will set the
node to its parent's when the child device' node is NUMA_NO_NODE,
maybe we can add the bridge device' node checking to make sure
the pci device really does not have a node assigned, as below:

if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE &&
    dev_to_node(bus->bridge) == NUMA_NO_NODE)
	dev_err(&bus->dev, FW_BUG "No node assigned on NUMA capable HW. Please contact your vendor for updates.\n");


> 
>> It is possible to
>> have a PCI bridge shared between two nodes, such that the PCI
>> devices have equidistance. But the moment you scale this out, you
>> either get devices that are 'local' to a package while having
>> multiple packages, or if you maintain a single bridge in a big
>> system, things become so slow it all doesn't matter anyway.
>> Assigning a node (one of the shared) is, in the generic ase of
>> multiple packages, the better solution over assigning all nodes.
>>
>> As pci_device_add() will assign the pci device' node according to
>> the bus the device is on, which is decided by pcibus_to_node().
>> Currently different arch may implement the pcibus_to_node() based
>> on bus->sysdata or bus device' node, which has the same node as
>> the bridge device.
>>
>> And for devices behind another bridge case, the child bus device
>> is setup with proper parent bus device and inherit its parent'
>> sysdata in pci_alloc_child_bus(), so the pcie device under the
>> child bus should have the same node as the parent bridge when
>> device_add() is called, which will set the node to its parent's
>> node when the child device' node is NUMA_NO_NODE.
>>
>> So this patch only warns about the case when a host bridge device
>> is registered with a node of NO_NODE in pci_register_host_bridge().
>> And it only warns about that when there are more than one numa
>> nodes in the system.
> 
> 
>> [1] https://lore.kernel.org/lkml/1568724534-146242-1-git-send-email-linyunsheng@huawei.com/
>>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>  drivers/pci/probe.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 3d5271a..22be96a 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -927,6 +927,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>>  	list_add_tail(&bus->node, &pci_root_buses);
>>  	up_write(&pci_bus_sem);
>>  
>> +	if (nr_node_ids > 1 && dev_to_node(bus->bridge) == NUMA_NO_NODE)
>> +		dev_err(bus->bridge, FW_BUG "No node assigned on NUMA capable HW by BIOS. Please contact your vendor for updates.\n");
>> +
>>  	return 0;
>>  
>>  unregister:
> 
> .
> 

