Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0C4D5CFB
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 10:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfJNIAx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 04:00:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbfJNIAx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Oct 2019 04:00:53 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 043818491006F9A592D1;
        Mon, 14 Oct 2019 16:00:49 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 14 Oct 2019
 16:00:46 +0800
Subject: Re: [PATCH v6] numa: make node_to_cpumask_map() NUMA_NO_NODE aware
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
        <rth@twiddle.net>, <ink@jurassic.park.msu.ru>,
        <mattst88@gmail.com>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <mpe@ellerman.id.au>,
        <heiko.carstens@de.ibm.com>, <gor@linux.ibm.com>,
        <borntraeger@de.ibm.com>, <ysato@users.sourceforge.jp>,
        <dalias@libc.org>, <davem@davemloft.net>, <ralf@linux-mips.org>,
        <paul.burton@mips.com>, <jhogan@kernel.org>,
        <jiaxun.yang@flygoat.com>, <chenhc@lemote.com>,
        <akpm@linux-foundation.org>, <rppt@linux.ibm.com>,
        <anshuman.khandual@arm.com>, <tglx@linutronix.de>, <cai@lca.pw>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <hpa@zytor.com>, <x86@kernel.org>,
        <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <len.brown@intel.com>, <axboe@kernel.dk>, <dledford@redhat.com>,
        <jeffrey.t.kirsher@intel.com>, <linux-alpha@vger.kernel.org>,
        <naveen.n.rao@linux.vnet.ibm.com>, <mwb@linux.vnet.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        <linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <tbogendoerfer@suse.de>, <linux-mips@vger.kernel.org>,
        <rafael@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>
References: <47fa4cee-8528-7c23-c7de-7be1b65aa2ae@huawei.com>
 <bec80499-86d9-bf1f-df23-9044a8099992@arm.com>
 <a5f0fc80-8e88-b781-77ce-1213e5d62125@huawei.com>
 <20191010073212.GB18412@dhcp22.suse.cz>
 <6cc94f9b-0d79-93a8-5ec2-4f6c21639268@huawei.com>
 <20191011111539.GX2311@hirez.programming.kicks-ass.net>
 <7fad58d6-5126-e8b8-a7d8-a91814da53ba@huawei.com>
 <20191012074014.GA2037204@kroah.com>
 <1e1ec851-b5e7-8f35-a627-4c12ca9c2d3c@huawei.com>
 <20191012104001.GA2052933@kroah.com> <20191012104742.GA2053473@kroah.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <82000bc8-6912-205b-0251-25b9cc430973@huawei.com>
Date:   Mon, 14 Oct 2019 16:00:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20191012104742.GA2053473@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019/10/12 18:47, Greg KH wrote:
> On Sat, Oct 12, 2019 at 12:40:01PM +0200, Greg KH wrote:
>> On Sat, Oct 12, 2019 at 05:47:56PM +0800, Yunsheng Lin wrote:
>>> On 2019/10/12 15:40, Greg KH wrote:
>>>> On Sat, Oct 12, 2019 at 02:17:26PM +0800, Yunsheng Lin wrote:
>>>>> add pci and acpi maintainer
>>>>> cc linux-pci@vger.kernel.org and linux-acpi@vger.kernel.org
>>>>>
>>>>> On 2019/10/11 19:15, Peter Zijlstra wrote:
>>>>>> On Fri, Oct 11, 2019 at 11:27:54AM +0800, Yunsheng Lin wrote:
>>>>>>> But I failed to see why the above is related to making node_to_cpumask_map()
>>>>>>> NUMA_NO_NODE aware?
>>>>>>
>>>>>> Your initial bug is for hns3, which is a PCI device, which really _MUST_
>>>>>> have a node assigned.
>>>>>>
>>>>>> It not having one, is a straight up bug. We must not silently accept
>>>>>> NO_NODE there, ever.
>>>>>>
>>>>>
>>>>> I suppose you mean reporting a lack of affinity when the node of a pcie
>>>>> device is not set by "not silently accept NO_NODE".
>>>>
>>>> If the firmware of a pci device does not provide the node information,
>>>> then yes, warn about that.
>>>>
>>>>> As Greg has asked about in [1]:
>>>>> what is a user to do when the user sees the kernel reporting that?
>>>>>
>>>>> We may tell user to contact their vendor for info or updates about
>>>>> that when they do not know about their system well enough, but their
>>>>> vendor may get away with this by quoting ACPI spec as the spec
>>>>> considering this optional. Should the user believe this is indeed a
>>>>> fw bug or a misreport from the kernel?
>>>>
>>>> Say it is a firmware bug, if it is a firmware bug, that's simple.
>>>>
>>>>> If this kind of reporting is common pratice and will not cause any
>>>>> misunderstanding, then maybe we can report that.
>>>>
>>>> Yes, please do so, that's the only way those boxes are ever going to get
>>>> fixed.  And go add the test to the "firmware testing" tool that is based
>>>> on Linux that Intel has somewhere, to give vendors a chance to fix this
>>>> before they ship hardware.
>>>>
>>>> This shouldn't be a big deal, we warn of other hardware bugs all the
>>>> time.
>>>
>>> Ok, thanks for clarifying.
>>>
>>> Will send a patch to catch the case when a pcie device without numa node
>>> being set and warn about it.
>>>
>>> Maybe use dev->bus to verify if it is a pci device?
>>
>> No, do that in the pci bus core code itself, when creating the devices
>> as that is when you know, or do not know, the numa node, right?
>>
>> This can't be in the driver core only, as each bus type will have a
>> different way of determining what the node the device is on.  For some
>> reason, I thought the PCI core code already does this, right?
> 
> Yes, pci_irq_get_node(), which NO ONE CALLS!  I should go delete that
> thing...
> 
> Anyway, it looks like the pci core code does call set_dev_node() based
> on the PCI bridge, so if that is set up properly, all should be fine.
> 
> If not, well, you have buggy firmware and you need to warn about that at
> the time you are creating the bridge.  Look at the call to
> pcibus_to_node() in pci_register_host_bridge().

Thanks for pointing out the specific function.
Maybe we do not need to warn about the case when the device has a parent,
because we must have warned about the parent if the device has a parent
and the parent also has a node of NO_NODE, so do not need to warn the child
device anymore? like blew:

@@ -932,6 +932,10 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
        list_add_tail(&bus->node, &pci_root_buses);
        up_write(&pci_bus_sem);

+       if (nr_node_ids > 1 && !parent &&
+           dev_to_node(bus->bridge) == NUMA_NO_NODE)
+               dev_err(bus->bridge, FW_BUG "No node assigned on NUMA capable HW. Please contact your vendor for updates.\n");
+
        return 0;


Also, we do not need to warn about that in pci_device_add(), Right?
Because we must have warned about the pci host bridge of the pci device.

I may be wrong about above because I am not so familiar with the pci.

> 
> And yes, you need to do this all on a per-bus-type basis, as has been
> pointed out.  It's up to the bus to create the device and set this up
> properly.

Thanks.
Will do that on per-bus-type basis.

> 
> thanks,
> 
> greg k-h
> 
> .
> 

