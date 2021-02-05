Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B63311919
	for <lists+linux-pci@lfdr.de>; Sat,  6 Feb 2021 03:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhBFCyr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 21:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhBFCb7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Feb 2021 21:31:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F97BC0698CD;
        Fri,  5 Feb 2021 14:23:20 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612563798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JYkA3RrLpslNe4BPJ+qwNAmLtBwJzPONHv5u5sY8rJo=;
        b=pa62pz5j6fpyq6BNunJWRioIZHzt03EMO+9YMDITawcqTDW5+K96CExRcGZoaI20pUNgHp
        BegjgG+Zc/KPn3v2NRU8HZwcJvVSEVhJeff9T73VLslq782utfOKlqfaGR66zzegF/RR+o
        24yO0HWtVr9h6Efdn4Fj5p9bittzl57OMZhH+NxRy51ImzBewC7RkAsXxPuda/6v9vKfvK
        08wkWmmDeZTMQrnyY6PRslq1pQ89TXdTCv8P7TwdFUoK6Xlh9eYbk3nLPZqNYmxMVaJzud
        a855pKafYmIxVofnRRrQ8nySQ7oLddCwwUTsnIws/LM+q1sFVGzbb4I5oMAaDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612563798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JYkA3RrLpslNe4BPJ+qwNAmLtBwJzPONHv5u5sY8rJo=;
        b=ia/I81znDMIupeN3U68VCQP8ZCE1PviKLTuK5n8y7MyuNaRFcYYTUgPcyAmBfVS980JGnc
        K7WB5FKOT2abohCQ==
To:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, frederic@kernel.org,
        juri.lelli@redhat.com, abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        jinyuqi@huawei.com, zhangshaokun@hisilicon.com
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping CPUs
In-Reply-To: <d8884413-84b4-b204-85c5-810342807d21@redhat.com>
References: <20200625223443.2684-1-nitesh@redhat.com> <20200625223443.2684-2-nitesh@redhat.com> <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com> <20210127121939.GA54725@fuller.cnet> <87r1m5can2.fsf@nanos.tec.linutronix.de> <20210128165903.GB38339@fuller.cnet> <87h7n0de5a.fsf@nanos.tec.linutronix.de> <20210204181546.GA30113@fuller.cnet> <cfa138e9-38e3-e566-8903-1d64024c917b@redhat.com> <20210204190647.GA32868@fuller.cnet> <d8884413-84b4-b204-85c5-810342807d21@redhat.com>
Date:   Fri, 05 Feb 2021 23:23:18 +0100
Message-ID: <87y2g26tnt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 04 2021 at 14:17, Nitesh Narayan Lal wrote:
> On 2/4/21 2:06 PM, Marcelo Tosatti wrote:
>>>> How about adding a new flag for isolcpus instead?
>>>>
>>> Do you mean a flag based on which we can switch the affinity mask to
>>> housekeeping for all the devices at the time of IRQ distribution?
>> Yes a new flag for isolcpus. HK_FLAG_IRQ_SPREAD or some better name.
>
> Does sounds like a nice idea to explore, lets see what Thomas thinks about it.

I just read back up on that whole discussion and stared into the usage
sites a bit.

There are a couple of issues here in a larger picture. Looking at it
from the device side first:

The spreading is done for non-managed queues/interrupts which makes them
movable by user space. So it could be argued from both sides that the
damage done by allowing the full online mask or by allowing only the
house keeping mask can be fixed up by user space.

But that's the trivial part of the problem. The real problem is CPU
hotplug and offline CPUs and the way how interrupts are set up for their
initial affinity.

As Robin noticed, the change in 1abdfe706a57 ("lib: Restrict
cpumask_local_spread to houskeeping CPUs") is broken as it can return
offline CPUs in both the NOHZ_FULL and the !NOHZ_FULL case.

The original code is racy vs. hotplug unless the callers block hotplug.

Let's look at all the callers and what they do with it.

  cptvf_set_irq_affinity()     affinity hint
  safexcel_request_ring_irq()  affinity hint
  mv_cesa_probe()              affinity hint
  bnxt_request_irq()           affinity hint
  nicvf_set_irq_affinity()     affinity hint
  cxgb4_set_msix_aff()         affinity hint
  enic_init_affinity_hint(()   affinity hint
  iavf_request_traffic_irqs()  affinity hint
  ionic_alloc_qcq_interrupt()  affinity hint
  efx_set_interrupt_affinity() affinity hint
  i40e_vsi_request_irq_msix()  affinity hint

  be_evt_queues_create()       affinity hint, queue affinity
  hns3_nic_set_cpumask()       affinity hint, queue affinity
  mlx4_en_init_affinity_hint() affinity hint, queue affinity
  mlx4_en_create_tx_ring()     affinity hint, queue affinity
  set_comp_irq_affinity_hint() affinity hint, queue affinity
  i40e_config_xps_tx_ring()    affinity hint, queue affinity
  
  hclge_configure              affinity_hint, queue affinity, workqueue selection

  ixgbe_alloc_q_vector()       node selection, affinity hint, queue affinity

All of them do not care about disabling hotplug. Taking cpu_read_lock()
inside of that spread function would not solve anything because once the
lock is dropped the CPU can go away.

There are 3 classes of this:

   1) Does not matter: affinity hint

   2) Might fail to set up the network queue when the selected CPU
      is offline.

   3) Broken: The hclge driver which uses the cpu to schedule work on
      that cpu. That's broken, but unfortunately neither the workqueue
      code nor the timer code will ever notice. The work just wont be
      scheduled until the CPU comes online again which might be never.

But looking at the above I really have to ask the question what the
commit in question is actually trying to solve.

AFAICT, nothing at all. Why?

  1) The majority of the drivers sets the hint __after_ requesting the
     interrupt

  2) Even if set _before_ requesting the interrupt it does not solve
     anything because it's a hint and the interrupt core code does
     not care about it at all. It provides the storage and the procfs
     interface nothing else.

So how does that prevent the interrupt subsystem from assigning an
interrupt to an isolated CPU? Not at all.

Interrupts which are freshly allocated get the default interrupt
affinity mask, which is either set on the command line or via /proc. The
affinity of the interrupt can be changed after it has been populated in
/proc.

When the interrupt is requested then one of the online CPUs in it's
affinity mask is chosen.

X86 is special here because this also requires that there are free
vectors on one of the online CPUs in the mask. If the CPUs in the
affinity mask run out of vectors then it will grab a vector from some
other CPU which might be an isolated CPU.

When the affinity mask of the interrupt at the time when it is actually
requested contains an isolated CPU then nothing prevents the kernel from
steering it at an isolated CPU. But that has absolutely nothing to do
with that spreading thingy.

The only difference which this change makes is the fact that the
affinity hint changes. Nothing else.

This whole blurb about it might break isolation when an interrupt is
requested is just nonsensical, really.

If the default affinity mask is not correctly set up before devices are
initialized then it's not going to be cured by changing that spread
function. If the user space irq balancer ignores the isolation mask and
blindly moves stuff to the affinity hint, then this monstrosity needs to
be fixed.

So I'm going to revert this commit because it _IS_ broken _AND_ useless
and does not solve anything it claims to solve.

Thanks,

        tglx
