Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7F78E463C
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 10:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437298AbfJYIvk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 04:51:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60588 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726986AbfJYIvk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Oct 2019 04:51:40 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B505B3ABD47898223926;
        Fri, 25 Oct 2019 16:51:34 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 25 Oct 2019
 16:51:34 +0800
Subject: Re: [PATCH] PCI: Warn about host bridge device when its numa node is
 NO_NODE
To:     Michal Hocko <mhocko@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <peterz@infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
        <geert@linux-m68k.org>, <gregkh@linuxfoundation.org>,
        <paul.burton@mips.com>
References: <20191024092013.GW17610@dhcp22.suse.cz>
 <20191024174013.GA149516@google.com> <20191025081617.GA17610@dhcp22.suse.cz>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <19540a07-b035-1159-64f5-c8a700a05788@huawei.com>
Date:   Fri, 25 Oct 2019 16:51:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20191025081617.GA17610@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019/10/25 16:16, Michal Hocko wrote:
> On Thu 24-10-19 12:40:13, Bjorn Helgaas wrote:
>> On Thu, Oct 24, 2019 at 11:20:13AM +0200, Michal Hocko wrote:
>>> On Wed 23-10-19 12:10:39, Bjorn Helgaas wrote:
>>>> On Wed, Oct 23, 2019 at 04:22:43PM +0800, Yunsheng Lin wrote:
>>>>> On 2019/10/23 5:04, Bjorn Helgaas wrote:
>>>>>> On Sat, Oct 19, 2019 at 02:45:43PM +0800, Yunsheng Lin wrote:
>>>>
>>>>>> I think the underlying problem you're addressing is that:
>>>>>>
>>>>>>   - NUMA_NO_NODE == -1,
>>>>>>   - dev_to_node(dev) may return NUMA_NO_NODE,
>>>>>>   - kmalloc(dev) relies on cpumask_of_node(dev_to_node(dev)), and
>>>>>>   - cpumask_of_node(NUMA_NO_NODE) makes an invalid array reference
>>>>>>
>>>>>> For example, on arm64, mips loongson, s390, and x86,
>>>>>> cpumask_of_node(node) returns "node_to_cpumask_map[node]", and -1 is
>>>>>> an invalid array index.
>>>>>
>>>>> The invalid array index of -1 is the underlying problem here when
>>>>> cpumask_of_node(dev_to_node(dev)) is called and cpumask_of_node()
>>>>> is not NUMA_NO_NODE aware yet.
>>>>>
>>>>> In the "numa: make node_to_cpumask_map() NUMA_NO_NODE aware" thread
>>>>> disscusion, it is requested that it is better to warn about the pcie
>>>>> device without a node assigned by the firmware before making the
>>>>> cpumask_of_node() NUMA_NO_NODE aware, so that the system with pci
>>>>> devices of "NUMA_NO_NODE" node can be fixed by their vendor.
>>>>>
>>>>> See: https://lore.kernel.org/lkml/20191011111539.GX2311@hirez.programming.kicks-ass.net/
>>>>
>>>> Right.  We should warn if the NUMA node number would help us but DT or
>>>> the firmware didn't give us one.
>>>>
>>>> But we can do that independently of any cpumask_of_node() changes.
>>>> There's no need to do one patch before the other.  Even if you make
>>>> cpumask_of_node() tolerate NUMA_NO_NODE, we'll still get the warning
>>>> because we're not actually changing any node assignments.
>>>
>>> Agreed. And this has been proposed previously I believe but my
>>> understanding was that Petr was against that.
>>
>> I don't think Peter was opposed to a warning.
> 
> Now, he was opposed to cpumask_of_node handling IIRC.

That was my understanding too.

But I am not sure if Peter is still opposed to cpumask_of_node() after
the pcie device without node affinity is warned in this patch.


From previous discussion [1]:

>Yunsheng> But I failed to see why the above is related to making node_to_cpumask_map()
>Yunsheng> NUMA_NO_NODE aware?

Peter> Your initial bug is for hns3, which is a PCI device, which really _MUST_
Peter> have a node assigned.

Peter> It not having one, is a straight up bug. We must not silently accept
Peter> NO_NODE there, ever."

I think Peter is not opposed to cpumask_of_node() after this patch if I
understand it correctly.


[1] https://lore.kernel.org/lkml/20191011111539.GX2311@hirez.programming.kicks-ass.net/

> 
>> I assume you're
>> referring to [1], which is about how cpumask_of_node() should work.
>> That's not my area, so I don't have a strong opinion.  From that
>> discussion:
>>
>> Yunsheng> From what I can see, the problem can be fixed in three
>> Yunsheng> place:
>> Yunsheng> 1. Make user dev_to_node return a valid node id
>> Yunsheng>    even when proximity domain is not set by bios(or node id
>> Yunsheng>    set by buggy bios is not valid), which may need info from
>> Yunsheng>    the numa system to make sure it will return a valid node.
>> Yunsheng>
>> Yunsheng> 2. User that call cpumask_of_node should ensure the node
>> Yunsheng>    id is valid before calling cpumask_of_node, and user also
>> Yunsheng>    need some info to make ensure node id is valid.
>> Yunsheng>
>> Yunsheng> 3. Make sure cpumask_of_node deal with invalid node id as
>> Yunsheng>    this patchset.
>>
>> Peter> 1) because even it is not set, the device really does belong
>> Peter> to a node.  It is impossible a device will have magic
>> Peter> uniform access to memory when CPUs cannot.
>> Peter> 
>> Peter> 2) is already true today, cpumask_of_node() requires a valid
>> Peter> node_id.
>> Peter> 
>> Peter> 3) is just wrong and increases overhead for everyone.
>>
>> I think Peter is advocating (1), i.e., if firmware doesn't tell us a
>> node ID, we just pick one.  We can certainly do that in *addition* to
>> adding a warning.  I'd like it to be a separate patch because I think
>> we want the warning no matter what so users have some clue that
>> performance could be better.
> 
> Yes, those should be two different patches.
> 
>> If we pick one, I guess we either assign some default, like node 0, to
>> everything; or we somehow pick a random node to assign.
> 
> I have tried to explain that picking a default node is tricky because
> node 0 is not generally available and you never know when a node might
> just disappear if the device is not bound to it.

Maybe the example you already mentioned in previous discussion may help
here:

3e8589963773 ("memcg: make it work on sparse non-0-node systems")


> 
> I really do not see why the proposed online_cpu_mask for that case is
> such a big deal. It will likely lead to suboptimal performance but what
> do you expect from a suboptimal HW description. There is no question
> that the proper node affinity should be set and the warning might really
> help here but trying to be clever and find a replacement sounds like
> potential for more subtly broken results than doing a straightforward
> thing.
> 
> But I will just go silent now because I am just repeating myself.
> 

