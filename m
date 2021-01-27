Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B14305E12
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 15:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhA0OUZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 09:20:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231822AbhA0OS5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jan 2021 09:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611757049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VsZNc1B4nakIPnI1xAuLfFHKosTfI1vVpMK0rv+pxEo=;
        b=a+QR/sXRBkstBtucRjEr6DpuUXm2jMhhp58IApfBdGu8lvPWNC1DtNe/qozmklrW4d3gQN
        Ymn5xqeVBmmGYc1xkyczK9MCOUfX9uQ4bMQecP33eeTN+gOANRYnM9/bKp9obzyDHu3Z7w
        LeBqbOwp0oj5sxlR6z96alOXzs04eDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-ixX6X7loMQOpAE3pZKoF5A-1; Wed, 27 Jan 2021 09:17:26 -0500
X-MC-Unique: ixX6X7loMQOpAE3pZKoF5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29D99107ACF9;
        Wed, 27 Jan 2021 14:17:20 +0000 (UTC)
Received: from [10.40.192.126] (unknown [10.40.192.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F14AA5D9CA;
        Wed, 27 Jan 2021 14:17:07 +0000 (UTC)
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping
 CPUs
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "frederic@kernel.org" <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        juri.lelli@redhat.com, abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        jinyuqi@huawei.com, zhangshaokun@hisilicon.com
References: <20200625223443.2684-1-nitesh@redhat.com>
 <20200625223443.2684-2-nitesh@redhat.com>
 <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com>
 <20210127121939.GA54725@fuller.cnet>
 <c5cba5f3-287a-d087-c329-6e6613634370@arm.com>
 <20210127130925.GA64740@fuller.cnet>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Organization: Red Hat Inc,
Message-ID: <7b810c5a-c732-4df3-1034-c2959ae86e65@redhat.com>
Date:   Wed, 27 Jan 2021 09:16:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210127130925.GA64740@fuller.cnet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 1/27/21 8:09 AM, Marcelo Tosatti wrote:
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
>>>>>    lib/cpumask.c | 16 +++++++++++-----
>>>>>    1 file changed, 11 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/lib/cpumask.c b/lib/cpumask.c
>>>>> index fb22fb266f93..85da6ab4fbb5 100644
>>>>> --- a/lib/cpumask.c
>>>>> +++ b/lib/cpumask.c
>>>>> @@ -6,6 +6,7 @@
>>>>>    #include <linux/export.h>
>>>>>    #include <linux/memblock.h>
>>>>>    #include <linux/numa.h>
>>>>> +#include <linux/sched/isolation.h>
>>>>>    /**
>>>>>     * cpumask_next - get the next cpu in a cpumask
>>>>> @@ -205,22 +206,27 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
>>>>>     */
>>>>>    unsigned int cpumask_local_spread(unsigned int i, int node)
>>>>>    {
>>>>> -	int cpu;
>>>>> +	int cpu, hk_flags;
>>>>> +	const struct cpumask *mask;
>>>>> +	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_MANAGED_IRQ;
>>>>> +	mask = housekeeping_cpumask(hk_flags);
>>>> AFAICS, this generally resolves to something based on cpu_possible_mask
>>>> rather than cpu_online_mask as before, so could now potentially return an
>>>> offline CPU. Was that an intentional change?
>>> Robin,
>>>
>>> AFAICS online CPUs should be filtered.
>> Apologies if I'm being thick, but can you explain how? In the case of
>> isolation being disabled or compiled out, housekeeping_cpumask() is
>> literally just "return cpu_possible_mask;". If we then iterate over that
>> with for_each_cpu() and just return the i'th possible CPU (e.g. in the
>> NUMA_NO_NODE case), what guarantees that CPU is actually online?
>>
>> Robin.
> Nothing, but that was the situation before 1abdfe706a579a702799fce465bceb9fb01d407c
> as well.

Marcelo, before the commit cpumask_local_spread, was in fact, relying on
cpu_online_mask as Robin mentioned.
The problem here is with housekeeping_cpumask which always relied on the
cpu_possible_mask.

>
> cpumask_local_spread() should probably be disabling CPU hotplug.


Yes and this should also be done at several other places in the drivers
which don't take CPU hotplug into account eg. at the time of vector
allocation.


-- 
Thanks
Nitesh

