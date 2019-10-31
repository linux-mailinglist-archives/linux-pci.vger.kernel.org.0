Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 699A0EA97F
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2019 04:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfJaD0L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Oct 2019 23:26:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60838 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbfJaD0K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Oct 2019 23:26:10 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A11698C8659FB5227AE0;
        Thu, 31 Oct 2019 11:26:07 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 31 Oct 2019
 11:26:05 +0800
Subject: Re: [PATCH v7] numa: make node_to_cpumask_map() NUMA_NO_NODE aware
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>, <mingo@redhat.com>,
        <bp@alien8.de>, <rth@twiddle.net>, <ink@jurassic.park.msu.ru>,
        <mattst88@gmail.com>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <mpe@ellerman.id.au>,
        <heiko.carstens@de.ibm.com>, <gor@linux.ibm.com>,
        <borntraeger@de.ibm.com>, <ysato@users.sourceforge.jp>,
        <dalias@libc.org>, <davem@davemloft.net>, <ralf@linux-mips.org>,
        <paul.burton@mips.com>, <jhogan@kernel.org>,
        <jiaxun.yang@flygoat.com>, <chenhc@lemote.com>,
        <akpm@linux-foundation.org>, <rppt@linux.ibm.com>,
        <anshuman.khandual@arm.com>, <tglx@linutronix.de>, <cai@lca.pw>,
        <robin.murphy@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <hpa@zytor.com>, <x86@kernel.org>,
        <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <len.brown@intel.com>, <axboe@kernel.dk>, <dledford@redhat.com>,
        <jeffrey.t.kirsher@intel.com>, <linux-alpha@vger.kernel.org>,
        <naveen.n.rao@linux.vnet.ibm.com>, <mwb@linux.vnet.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        <linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <tbogendoerfer@suse.de>, <linux-mips@vger.kernel.org>,
        <rafael@kernel.org>, <mhocko@kernel.org>,
        <gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
References: <1572428068-180880-1-git-send-email-linyunsheng@huawei.com>
 <20191030101449.GW4097@hirez.programming.kicks-ass.net>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <f7aa833e-3ed3-aba0-8c6e-8753a68182c2@huawei.com>
Date:   Thu, 31 Oct 2019 11:26:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20191030101449.GW4097@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019/10/30 18:14, Peter Zijlstra wrote:
> On Wed, Oct 30, 2019 at 05:34:28PM +0800, Yunsheng Lin wrote:
>> When passing the return value of dev_to_node() to cpumask_of_node()
>> without checking if the device's node id is NUMA_NO_NODE, there is
>> global-out-of-bounds detected by KASAN.
>>
>> From the discussion [1], NUMA_NO_NODE really means no node affinity,
>> which also means all cpus should be usable. So the cpumask_of_node()
>> should always return all cpus online when user passes the node id as
>> NUMA_NO_NODE, just like similar semantic that page allocator handles
>> NUMA_NO_NODE.
>>
>> But we cannot really copy the page allocator logic. Simply because the
>> page allocator doesn't enforce the near node affinity. It just picks it
>> up as a preferred node but then it is free to fallback to any other numa
>> node. This is not the case here and node_to_cpumask_map will only restrict
>> to the particular node's cpus which would have really non deterministic
>> behavior depending on where the code is executed. So in fact we really
>> want to return cpu_online_mask for NUMA_NO_NODE.
>>
>> Also there is a debugging version of node_to_cpumask_map() for x86 and
>> arm64, which is only used when CONFIG_DEBUG_PER_CPU_MAPS is defined, this
>> patch changes it to handle NUMA_NO_NODE as normal node_to_cpumask_map().
>>
>> [1] https://lkml.org/lkml/2019/9/11/66
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> Suggested-by: Michal Hocko <mhocko@kernel.org>
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> Acked-by: Paul Burton <paul.burton@mips.com> # MIPS bits
> 
> Still:
> 
> Nacked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

It seems I still misunderstood your meaning by "We must not silently accept
NO_NODE there" in [1].

I am not sure if there is still disagreement that the NO_NODE state for
dev->numa_node should exist at all.

From the previous disscussion [2], you seem to propose to do "wild guess" or
"fixup" for all devices(including virtual and physcial) with NO_NODE, which means
the NO_NODE is needed anymore and should be removed when the "wild guess" or "fixup"
is done. So maybe the reason for your nack here it is that there should be no other
NO_NODE handling or fixing related to NO_NODE before the "wild guess" or "fixup"
process is finished, so making node_to_cpumask_map() NUMA_NO_NODE aware is unnecessary.

Or your reason for the nack is still specific to the pcie device without a numa node,
the "wild guess" need to be done for this case before making node_to_cpumask_map()
NUMA_NO_NODE?

Please help to clarify the reason for nack. Or is there still some other reason for the
nack I missed from the previous disscussion?

Thanks.

[1] https://lore.kernel.org/lkml/20191011111539.GX2311@hirez.programming.kicks-ass.net/
[2] https://lore.kernel.org/lkml/20191014094912.GY2311@hirez.programming.kicks-ass.net/
> 
> .
> 

