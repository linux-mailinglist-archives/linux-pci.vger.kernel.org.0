Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2046305D95
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 14:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhA0Nv2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 08:51:28 -0500
Received: from foss.arm.com ([217.140.110.172]:47470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231461AbhA0Nui (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Jan 2021 08:50:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38BCE1FB;
        Wed, 27 Jan 2021 05:49:52 -0800 (PST)
Received: from [10.57.47.135] (unknown [10.57.47.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 435243F68F;
        Wed, 27 Jan 2021 05:49:49 -0800 (PST)
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping
 CPUs
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, juri.lelli@redhat.com, abelits@marvell.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, peterz@infradead.org,
        davem@davemloft.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com, jinyuqi@huawei.com,
        zhangshaokun@hisilicon.com
References: <20200625223443.2684-1-nitesh@redhat.com>
 <20200625223443.2684-2-nitesh@redhat.com>
 <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com>
 <20210127121939.GA54725@fuller.cnet>
 <c5cba5f3-287a-d087-c329-6e6613634370@arm.com>
 <20210127130925.GA64740@fuller.cnet>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <87b81c08-878f-8394-be94-f5b99ee0be5b@arm.com>
Date:   Wed, 27 Jan 2021 13:49:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210127130925.GA64740@fuller.cnet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-01-27 13:09, Marcelo Tosatti wrote:
> On Wed, Jan 27, 2021 at 12:36:30PM +0000, Robin Murphy wrote:
>> On 2021-01-27 12:19, Marcelo Tosatti wrote:
>>> On Wed, Jan 27, 2021 at 11:57:16AM +0000, Robin Murphy wrote:
>>>> Hi,
>>>>
>>>> On 2020-06-25 23:34, Nitesh Narayan Lal wrote:
>>>>> From: Alex Belits <abelits@marvell.com>
>>>>>
>>>>> The current implementation of cpumask_local_spread() does not respect the
>>>>> isolated CPUs, i.e., even if a CPU has been isolated for Real-Time task,
>>>>> it will return it to the caller for pinning of its IRQ threads. Having
>>>>> these unwanted IRQ threads on an isolated CPU adds up to a latency
>>>>> overhead.
>>>>>
>>>>> Restrict the CPUs that are returned for spreading IRQs only to the
>>>>> available housekeeping CPUs.
>>>>>
>>>>> Signed-off-by: Alex Belits <abelits@marvell.com>
>>>>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
>>>>> ---
>>>>>     lib/cpumask.c | 16 +++++++++++-----
>>>>>     1 file changed, 11 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/lib/cpumask.c b/lib/cpumask.c
>>>>> index fb22fb266f93..85da6ab4fbb5 100644
>>>>> --- a/lib/cpumask.c
>>>>> +++ b/lib/cpumask.c
>>>>> @@ -6,6 +6,7 @@
>>>>>     #include <linux/export.h>
>>>>>     #include <linux/memblock.h>
>>>>>     #include <linux/numa.h>
>>>>> +#include <linux/sched/isolation.h>
>>>>>     /**
>>>>>      * cpumask_next - get the next cpu in a cpumask
>>>>> @@ -205,22 +206,27 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
>>>>>      */
>>>>>     unsigned int cpumask_local_spread(unsigned int i, int node)
>>>>>     {
>>>>> -	int cpu;
>>>>> +	int cpu, hk_flags;
>>>>> +	const struct cpumask *mask;
>>>>> +	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_MANAGED_IRQ;
>>>>> +	mask = housekeeping_cpumask(hk_flags);
>>>>
>>>> AFAICS, this generally resolves to something based on cpu_possible_mask
>>>> rather than cpu_online_mask as before, so could now potentially return an
>>>> offline CPU. Was that an intentional change?
>>>
>>> Robin,
>>>
>>> AFAICS online CPUs should be filtered.
>>
>> Apologies if I'm being thick, but can you explain how? In the case of
>> isolation being disabled or compiled out, housekeeping_cpumask() is
>> literally just "return cpu_possible_mask;". If we then iterate over that
>> with for_each_cpu() and just return the i'th possible CPU (e.g. in the
>> NUMA_NO_NODE case), what guarantees that CPU is actually online?
>>
>> Robin.
> 
> Nothing, but that was the situation before 1abdfe706a579a702799fce465bceb9fb01d407c
> as well.

True, if someone calls from a racy context then there's not much we can 
do to ensure that any CPU *remains* online after we initially observed 
it to be, but when it's called from somewhere safe like a cpuhp offline 
handler, then picking from cpu_online_mask *did* always do the right 
thing (by my interpretation), whereas picking from 
housekeeping_cpumask() might not.

This is why I decided to ask rather than just send a patch to fix what I 
think might be a bug - I have no objection if this *is* intended 
behaviour, other than suggesting we amend the "...selects an online 
CPU..." comment if that aspect was never meant to be relied upon.

Thanks,
Robin.

> 
> cpumask_local_spread() should probably be disabling CPU hotplug.
> 
> Thomas?
> 
>>
>>>> I was just looking at the current code since I had the rare presence of mind
>>>> to check if something suitable already existed before I start open-coding
>>>> "any online CPU, but local node preferred" logic for handling IRQ affinity
>>>> in a driver - cpumask_local_spread() appears to be almost what I want (if a
>>>> bit more heavyweight), if only it would actually guarantee an online CPU as
>>>> the kerneldoc claims :(
>>>>
>>>> Robin.
>>>>
>>>>>     	/* Wrap: we always want a cpu. */
>>>>> -	i %= num_online_cpus();
>>>>> +	i %= cpumask_weight(mask);
>>>>>     	if (node == NUMA_NO_NODE) {
>>>>> -		for_each_cpu(cpu, cpu_online_mask)
>>>>> +		for_each_cpu(cpu, mask) {
>>>>>     			if (i-- == 0)
>>>>>     				return cpu;
>>>>> +		}
>>>>>     	} else {
>>>>>     		/* NUMA first. */
>>>>> -		for_each_cpu_and(cpu, cpumask_of_node(node), cpu_online_mask)
>>>>> +		for_each_cpu_and(cpu, cpumask_of_node(node), mask) {
>>>>>     			if (i-- == 0)
>>>>>     				return cpu;
>>>>> +		}
>>>>> -		for_each_cpu(cpu, cpu_online_mask) {
>>>>> +		for_each_cpu(cpu, mask) {
>>>>>     			/* Skip NUMA nodes, done above. */
>>>>>     			if (cpumask_test_cpu(cpu, cpumask_of_node(node)))
>>>>>     				continue;
>>>>>
>>>
> 
