Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD64FE2DAB
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 11:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391001AbfJXJjf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 05:39:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4757 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388539AbfJXJjf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 05:39:35 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4D269938E1B8B66A7C0E;
        Thu, 24 Oct 2019 17:39:32 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 24 Oct 2019
 17:39:31 +0800
Subject: Re: [PATCH] PCI: Warn about host bridge device when its numa node is
 NO_NODE
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mhocko@kernel.org>, <peterz@infradead.org>,
        <robin.murphy@arm.com>, <geert@linux-m68k.org>,
        <gregkh@linuxfoundation.org>, <paul.burton@mips.com>
References: <20191023171039.GA173290@google.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <eb14d1ae-4077-0ce0-d64e-7c25f5aebbb6@huawei.com>
Date:   Thu, 24 Oct 2019 17:39:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20191023171039.GA173290@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019/10/24 1:10, Bjorn Helgaas wrote:
> On Wed, Oct 23, 2019 at 04:22:43PM +0800, Yunsheng Lin wrote:
>> On 2019/10/23 5:04, Bjorn Helgaas wrote:
>>> On Sat, Oct 19, 2019 at 02:45:43PM +0800, Yunsheng Lin wrote:
>> And it seems a pci device's parent will always set to the bridge
>> device in pci_setup_device(), and device_add() which will set the
>> node to its parent's when the child device' node is NUMA_NO_NODE,
>> maybe we can add the bridge device' node checking to make sure
>> the pci device really does not have a node assigned, as below:
>>
>> if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE &&
>>     dev_to_node(bus->bridge) == NUMA_NO_NODE)
>> 	dev_err(&bus->dev, FW_BUG "No node assigned on NUMA capable HW. Please contact your vendor for updates.\n");
> 
> Anyway, would the attached patch work for you?  I have it tentatively
> queued up on pci/enumeration for v5.5.
> 

Yes, thanks for making the change when applying.

>>>
>>>
>>>> [1] https://lore.kernel.org/lkml/1568724534-146242-1-git-send-email-linyunsheng@huawei.com/
>>>>
>>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>>>> ---
>>>>  drivers/pci/probe.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>>> index 3d5271a..22be96a 100644
>>>> --- a/drivers/pci/probe.c
>>>> +++ b/drivers/pci/probe.c
>>>> @@ -927,6 +927,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>>>>  	list_add_tail(&bus->node, &pci_root_buses);
>>>>  	up_write(&pci_bus_sem);
>>>>  
>>>> +	if (nr_node_ids > 1 && dev_to_node(bus->bridge) == NUMA_NO_NODE)
>>>> +		dev_err(bus->bridge, FW_BUG "No node assigned on NUMA capable HW by BIOS. Please contact your vendor for updates.\n");
>>>> +
>>>>  	return 0;
>>>>  
>>>>  unregister:
> 
> commit 8f8cf239c4f1
> Author: Yunsheng Lin <linyunsheng@huawei.com>
> Date:   Sat Oct 19 14:45:43 2019 +0800
> 
>     PCI: Warn if no host bridge NUMA node info
>     
>     In pci_call_probe(), we try to run driver probe functions on the node where
>     the device is attached.  If we don't know which node the device is attached
>     to, the driver will likely run on the wrong node.  This will still work,
>     but performance will not be as good as it could be.
>     
>     On NUMA systems, warn if we don't know which node a PCI host bridge is
>     attached to.  This is likely an indication that ACPI didn't supply a _PXM
>     method or the DT didn't supply a "numa-node-id" property.
>     
>     [bhelgaas: commit log, check bus node]
>     Link: https://lore.kernel.org/r/1571467543-26125-1-git-send-email-linyunsheng@huawei.com
>     Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 3d5271a7a849..40259c38d66a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -897,6 +897,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	else
>  		pr_info("PCI host bridge to bus %s\n", name);
>  
> +	if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
> +		dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
> +
>  	/* Add initial resources to the bus */
>  	resource_list_for_each_entry_safe(window, n, &resources) {
>  		list_move_tail(&window->node, &bridge->windows);
> 
> .
> 

