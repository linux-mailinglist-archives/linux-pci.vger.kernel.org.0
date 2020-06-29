Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182AD20EA7D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 02:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgF3Asz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jun 2020 20:48:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6880 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726056AbgF3Asz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jun 2020 20:48:55 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 53CFF9DD4C284405C498;
        Mon, 29 Jun 2020 17:01:50 +0800 (CST)
Received: from [127.0.0.1] (10.67.76.251) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Mon, 29 Jun 2020
 17:01:41 +0800
Subject: Re: [Patch v3 1/3] lib: Restrict cpumask_local_spread to houskeeping
 CPUs
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <frederic@kernel.org>, <mtosatti@redhat.com>,
        <juri.lelli@redhat.com>, <abelits@marvell.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <rostedt@goodmis.org>, <mingo@kernel.org>, <peterz@infradead.org>,
        <tglx@linutronix.de>, <davem@davemloft.net>,
        <sfr@canb.auug.org.au>, <stephen@networkplumber.org>,
        <rppt@linux.vnet.ibm.com>, yuqi jin <jinyuqi@huawei.com>
References: <20200623192331.215557-1-nitesh@redhat.com>
 <20200623192331.215557-2-nitesh@redhat.com>
 <20200624122647.766bec7760d9197ba71a58c4@linux-foundation.org>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <e6c261a1-1fec-3faf-c49c-51a88a7f521c@hisilicon.com>
Date:   Mon, 29 Jun 2020 17:01:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200624122647.766bec7760d9197ba71a58c4@linux-foundation.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.76.251]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew,

ÔÚ 2020/6/25 3:26, Andrew Morton Ð´µÀ:
> On Tue, 23 Jun 2020 15:23:29 -0400 Nitesh Narayan Lal <nitesh@redhat.com> wrote:
> 
>> From: Alex Belits <abelits@marvell.com>
>>
>> The current implementation of cpumask_local_spread() does not respect the
>> isolated CPUs, i.e., even if a CPU has been isolated for Real-Time task,
>> it will return it to the caller for pinning of its IRQ threads. Having
>> these unwanted IRQ threads on an isolated CPU adds up to a latency
>> overhead.
>>
>> Restrict the CPUs that are returned for spreading IRQs only to the
>> available housekeeping CPUs.
>>
>> ...
>>
>> --- a/lib/cpumask.c
>> +++ b/lib/cpumask.c
>> @@ -6,6 +6,7 @@
>>  #include <linux/export.h>
>>  #include <linux/memblock.h>
>>  #include <linux/numa.h>
>> +#include <linux/sched/isolation.h>
>>  
>>  /**
>>   * cpumask_next - get the next cpu in a cpumask
>> @@ -205,22 +206,27 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
>>   */
>>  unsigned int cpumask_local_spread(unsigned int i, int node)
>>  {
>> -	int cpu;
>> +	int cpu, hk_flags;
>> +	const struct cpumask *mask;
>>  
>> +	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
>> +	mask = housekeeping_cpumask(hk_flags);
>>  	/* Wrap: we always want a cpu. */
>> -	i %= num_online_cpus();
>> +	i %= cpumask_weight(mask);
>>  
>>  	if (node == NUMA_NO_NODE) {
>> -		for_each_cpu(cpu, cpu_online_mask)
>> +		for_each_cpu(cpu, mask) {
>>  			if (i-- == 0)
>>  				return cpu;
>> +		}
>>  	} else {
>>  		/* NUMA first. */
>> -		for_each_cpu_and(cpu, cpumask_of_node(node), cpu_online_mask)
>> +		for_each_cpu_and(cpu, cpumask_of_node(node), mask) {
>>  			if (i-- == 0)
>>  				return cpu;
>> +		}
>>  
>> -		for_each_cpu(cpu, cpu_online_mask) {
>> +		for_each_cpu(cpu, mask) {
>>  			/* Skip NUMA nodes, done above. */
>>  			if (cpumask_test_cpu(cpu, cpumask_of_node(node)))
>>  				continue;
> 
> Are you aware of these changes to cpu_local_spread()?
> https://lore.kernel.org/lkml/1582768688-2314-1-git-send-email-zhangshaokun@hisilicon.com/
> 
> I don't see a lot of overlap but it would be nice for you folks to

Yeah, it's a different issue from Nitesh. About our's patch, it has been
linux-next long time, will it be merged in Linus's tree?

Thanks,
Shaokun

> check each other's homework ;)
> 
> 
> 
> .
> 

