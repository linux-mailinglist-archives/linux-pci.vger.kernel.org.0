Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9138631209A
	for <lists+linux-pci@lfdr.de>; Sun,  7 Feb 2021 01:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhBGApP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Feb 2021 19:45:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229581AbhBGApO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Feb 2021 19:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612658627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BGO97t36igbcJ5TYTclR2hGDKIhlmk20Dxr2wSKLR70=;
        b=hg8SZVTFX2RJ8QbaqkxMAZpgLbx90IFEatwveeix9vHL0gurBXhkyzmuw3p1xQzv5DhGsD
        UKxLfSDLT2865VOfWdPpQhwnAtJh9jHDwO0A12W4IID2y7D5ddnYeKSyHCW+ovzPHnDZOp
        SXXQqVv+N3dBvoMMwlgPmDU2wQqW0IM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-FGHDHh7NM9KAxV6V6zgaTg-1; Sat, 06 Feb 2021 19:43:43 -0500
X-MC-Unique: FGHDHh7NM9KAxV6V6zgaTg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F3AD107ACE6;
        Sun,  7 Feb 2021 00:43:40 +0000 (UTC)
Received: from [10.10.112.236] (ovpn-112-236.rdu2.redhat.com [10.10.112.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F2B56E417;
        Sun,  7 Feb 2021 00:43:31 +0000 (UTC)
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping
 CPUs
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, frederic@kernel.org,
        juri.lelli@redhat.com, abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        jinyuqi@huawei.com, zhangshaokun@hisilicon.com
References: <20200625223443.2684-1-nitesh@redhat.com>
 <20200625223443.2684-2-nitesh@redhat.com>
 <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com>
 <20210127121939.GA54725@fuller.cnet> <87r1m5can2.fsf@nanos.tec.linutronix.de>
 <20210128165903.GB38339@fuller.cnet> <87h7n0de5a.fsf@nanos.tec.linutronix.de>
 <20210204181546.GA30113@fuller.cnet>
 <cfa138e9-38e3-e566-8903-1d64024c917b@redhat.com>
 <20210204190647.GA32868@fuller.cnet>
 <d8884413-84b4-b204-85c5-810342807d21@redhat.com>
 <87y2g26tnt.fsf@nanos.tec.linutronix.de>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Organization: Red Hat Inc,
Message-ID: <d0aed683-87ae-91a2-d093-de3f5d8a8251@redhat.com>
Date:   Sat, 6 Feb 2021 19:43:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <87y2g26tnt.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2/5/21 5:23 PM, Thomas Gleixner wrote:
> On Thu, Feb 04 2021 at 14:17, Nitesh Narayan Lal wrote:
>> On 2/4/21 2:06 PM, Marcelo Tosatti wrote:
>>>>> How about adding a new flag for isolcpus instead?
>>>>>
>>>> Do you mean a flag based on which we can switch the affinity mask to
>>>> housekeeping for all the devices at the time of IRQ distribution?
>>> Yes a new flag for isolcpus. HK_FLAG_IRQ_SPREAD or some better name.
>> Does sounds like a nice idea to explore, lets see what Thomas thinks about it.
> I just read back up on that whole discussion and stared into the usage
> sites a bit.
>
> There are a couple of issues here in a larger picture. Looking at it
> from the device side first:
>
> The spreading is done for non-managed queues/interrupts which makes them
> movable by user space. So it could be argued from both sides that the
> damage done by allowing the full online mask or by allowing only the
> house keeping mask can be fixed up by user space.
>
> But that's the trivial part of the problem. The real problem is CPU
> hotplug and offline CPUs and the way how interrupts are set up for their
> initial affinity.
>
> As Robin noticed, the change in 1abdfe706a57 ("lib: Restrict
> cpumask_local_spread to houskeeping CPUs") is broken as it can return
> offline CPUs in both the NOHZ_FULL and the !NOHZ_FULL case.

A quick question here, is there any reason why we don't have cpu_online_mask
instead of cpu_possible_mask in the housekeeping_cpumask()?
(not for this particular patch but in general)

>
> The original code is racy vs. hotplug unless the callers block hotplug.
>
> Let's look at all the callers and what they do with it.
>
>   cptvf_set_irq_affinity()     affinity hint
>   safexcel_request_ring_irq()  affinity hint
>   mv_cesa_probe()              affinity hint
>   bnxt_request_irq()           affinity hint
>   nicvf_set_irq_affinity()     affinity hint
>   cxgb4_set_msix_aff()         affinity hint
>   enic_init_affinity_hint(()   affinity hint
>   iavf_request_traffic_irqs()  affinity hint
>   ionic_alloc_qcq_interrupt()  affinity hint
>   efx_set_interrupt_affinity() affinity hint
>   i40e_vsi_request_irq_msix()  affinity hint
>
>   be_evt_queues_create()       affinity hint, queue affinity
>   hns3_nic_set_cpumask()       affinity hint, queue affinity
>   mlx4_en_init_affinity_hint() affinity hint, queue affinity
>   mlx4_en_create_tx_ring()     affinity hint, queue affinity
>   set_comp_irq_affinity_hint() affinity hint, queue affinity
>   i40e_config_xps_tx_ring()    affinity hint, queue affinity
>   
>   hclge_configure              affinity_hint, queue affinity, workqueue selection
>
>   ixgbe_alloc_q_vector()       node selection, affinity hint, queue affinity
>
> All of them do not care about disabling hotplug. Taking cpu_read_lock()
> inside of that spread function would not solve anything because once the
> lock is dropped the CPU can go away.
>
> There are 3 classes of this:
>
>    1) Does not matter: affinity hint
>
>    2) Might fail to set up the network queue when the selected CPU
>       is offline.
>
>    3) Broken: The hclge driver which uses the cpu to schedule work on
>       that cpu. That's broken, but unfortunately neither the workqueue
>       code nor the timer code will ever notice. The work just wont be
>       scheduled until the CPU comes online again which might be never.

Agreed.

> But looking at the above I really have to ask the question what the
> commit in question is actually trying to solve.
>
> AFAICT, nothing at all. Why?
>
>   1) The majority of the drivers sets the hint __after_ requesting the
>      interrupt
>
>   2) Even if set _before_ requesting the interrupt it does not solve
>      anything because it's a hint and the interrupt core code does
>      not care about it at all. It provides the storage and the procfs
>      interface nothing else.
>
> So how does that prevent the interrupt subsystem from assigning an
> interrupt to an isolated CPU? Not at all.
>
> Interrupts which are freshly allocated get the default interrupt
> affinity mask, which is either set on the command line or via /proc. The
> affinity of the interrupt can be changed after it has been populated in
> /proc.
>
> When the interrupt is requested then one of the online CPUs in it's
> affinity mask is chosen.
>
> X86 is special here because this also requires that there are free
> vectors on one of the online CPUs in the mask. If the CPUs in the
> affinity mask run out of vectors then it will grab a vector from some
> other CPU which might be an isolated CPU.
>
> When the affinity mask of the interrupt at the time when it is actually
> requested contains an isolated CPU then nothing prevents the kernel from
> steering it at an isolated CPU. But that has absolutely nothing to do
> with that spreading thingy.
>
> The only difference which this change makes is the fact that the
> affinity hint changes. Nothing else.
>

Thanks for the detailed explanation.

Before I posted this patch, I was doing some debugging on a setup where I
was observing some latency issues due to the iavf IRQs that were pinned on
the isolated CPUs.

Based on some initial traces I had this impression that the affinity hint
or cpumask_local_spread was somehow playing a role in deciding the affinity
mask of these IRQs. Although, that does look incorrect after going through
your explanation.
For some reason, with a kernel that had this patch when I tried creating
VFs iavf IRQs always ended up on the HK CPUs.

The reasoning for the above is still not very clear to me. I will investigate
this further to properly understand this behavior.

-- 
Nitesh

