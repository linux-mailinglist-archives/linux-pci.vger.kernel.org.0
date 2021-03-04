Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8DE32DDD5
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 00:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhCDXXU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Mar 2021 18:23:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40097 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232959AbhCDXXT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Mar 2021 18:23:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614900199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MnytmvR9EgRDtqBYT2OPErFkvJpnrPLeu+T2bLeBpMQ=;
        b=C4M5+nrAR7JC3ILOsYdgAzOZOuEuASI81BGZX4er98vgDf2i+n2T3F3lAoFeegwA+WNYp3
        oZ/j3qektwMYRgMICd8dDNYi6IOQwuMzI722EfOPaZHxvggCC6LaIdH1AxcDNdpNGjA9mp
        BqQhbRZOXhbRfK9eKWPMxXoHk+uG5MM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-MogDKMT5MLqdHFaevOLoVQ-1; Thu, 04 Mar 2021 18:23:17 -0500
X-MC-Unique: MogDKMT5MLqdHFaevOLoVQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 333A61842146;
        Thu,  4 Mar 2021 23:23:14 +0000 (UTC)
Received: from [10.10.112.189] (ovpn-112-189.rdu2.redhat.com [10.10.112.189])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D0C639A71;
        Thu,  4 Mar 2021 23:23:04 +0000 (UTC)
Subject: Re: [EXT] Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to
 houskeeping CPUs
To:     Alex Belits <abelits@marvell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, frederic@kernel.org,
        juri.lelli@redhat.com, bhelgaas@google.com,
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
 <d0aed683-87ae-91a2-d093-de3f5d8a8251@redhat.com>
 <7780ae60-efbd-2902-caaa-0249a1f277d9@redhat.com>
 <07c04bc7-27f0-9c07-9f9e-2d1a450714ef@redhat.com>
 <faa8d84e-db67-7fbe-891e-f4987f106b20@marvell.com>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Organization: Red Hat Inc,
Message-ID: <250eedca-e594-e8d4-358b-4472aa9e3588@redhat.com>
Date:   Thu, 4 Mar 2021 18:23:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <faa8d84e-db67-7fbe-891e-f4987f106b20@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/4/21 4:13 PM, Alex Belits wrote:
> On 3/4/21 10:15, Nitesh Narayan Lal wrote:
>> External Email
>>
>> ----------------------------------------------------------------------
>>
>> On 2/11/21 10:55 AM, Nitesh Narayan Lal wrote:
>>> On 2/6/21 7:43 PM, Nitesh Narayan Lal wrote:
>>>> On 2/5/21 5:23 PM, Thomas Gleixner wrote:
>>>>> On Thu, Feb 04 2021 at 14:17, Nitesh Narayan Lal wrote:
>>>>>> On 2/4/21 2:06 PM, Marcelo Tosatti wrote:
>>>>>>>>> How about adding a new flag for isolcpus instead?
>>>>>>>>>
>>>>>>>> Do you mean a flag based on which we can switch the affinity mask to
>>>>>>>> housekeeping for all the devices at the time of IRQ distribution?
>>>>>>> Yes a new flag for isolcpus. HK_FLAG_IRQ_SPREAD or some better name.
>>>>>> Does sounds like a nice idea to explore, lets see what Thomas thinks
>>>>>> about it.
>>> <snip>
>>>
>>>>>> When the affinity mask of the interrupt at the time when it is actually
>>>>>> requested contains an isolated CPU then nothing prevents the kernel from
>>>>>> steering it at an isolated CPU. But that has absolutely nothing to do
>>>>>> with that spreading thingy.
>>>>>>
>>>>>> The only difference which this change makes is the fact that the
>>>>>> affinity hint changes. Nothing else.
>>>>>>
>>>> Thanks for the detailed explanation.
>>>>
>>>> Before I posted this patch, I was doing some debugging on a setup where I
>>>> was observing some latency issues due to the iavf IRQs that were pinned on
>>>> the isolated CPUs.
>>>>
>>>> Based on some initial traces I had this impression that the affinity hint
>>>> or cpumask_local_spread was somehow playing a role in deciding the affinity
>>>> mask of these IRQs. Although, that does look incorrect after going through
>>>> your explanation.
>>>> For some reason, with a kernel that had this patch when I tried creating
>>>> VFs iavf IRQs always ended up on the HK CPUs.
>>>>
>>>> The reasoning for the above is still not very clear to me. I will
>>>> investigate
>>>> this further to properly understand this behavior.
>>>>
>>>>
>>> After a little more digging, I found out why cpumask_local_spread change
>>> affects the general/initial smp_affinity for certain device IRQs.
>>>
>>> After the introduction of the commit:
>>>
>>>      e2e64a932 genirq: Set initial affinity in irq_set_affinity_hint()
>>>
>>
>> Continuing the conversation about the above commit and adding Jesse.
>> I was trying to understand the problem that the commit message explains
>> "The default behavior of the kernel is somewhat undesirable as all
>> requested interrupts end up on CPU0 after registration.", I have also been
>> trying to reproduce this behavior without the patch but I failed in doing
>> so, maybe because I am missing something here.
>>
>> @Jesse Can you please explain? FWIU IRQ affinity should be decided based on
>> the default affinity mask.
>>
>> The problem with the commit is that when we overwrite the affinity mask
>> based on the hinting mask we completely ignore the default SMP affinity
>> mask. If we do want to overwrite the affinity based on the hint mask we
>> should atleast consider the default SMP affinity.
>>
>
> cpumask_local_spread() is used by a small number of drivers, mostly for
> Ethernet and cryptographic devices, however it includes Cavium and Marvell
> devices that were included in every piece of hardware that I and Yury Norov
> worked on. Without my patch (or previous, later replaced, Yury's patch that
> was developed before there were housekeeping CPUs), driver would completely
> break any attempts to configure task isolation, because it would distribute
> processing over CPUs regardless of any masks related to isolation (and later
> housekeeping). This is why it was created, and it just happens that it also
> makes sense for CPU isolation in general. Of course, none of it would be
> experienced on hardware that does not include those devices, possibly
> creating some wrong impression about its effect and purpose.
>
> It may be that my patch can be criticized for not accommodating CPU hotplug
> and other runtime changes of masks. Or drivers can be criticized for their
> behavior that relies on calling cpumask_local_spread() once on
> initialization and then assuming that all CPUs are configured forever.
> However as far as I can tell, currently we have no other means of
> controlling the behavior of drivers that manage their own interrupt or
> thread to CPU mapping, and no way to communicate any of those changes to
> them while they are running. Drivers may have legitimate reasons for
> maintaining permanent or semi-permanent CPU core to interrupt mapping,
> especially on devices with very large numbers of CPU cores and built-in
> support for parallel processing of network packets.
>
> If we want it to be done in some manner that accommodates current demands,
> we should simply replace cpumask_local_spread() with something else, or,
> maybe, add some means that will allow dynamic changes. Thankfully, there are
> very few (IIRC, 19) places where cpumask_local_spread() is used, so it may
> be accommodated with relatively small amount of code to write and test. Then
> everything else will be able to switch to the same mechanism whenever
> necessary.
>

So there are two different issues, the first issue is how the mask
retrieved based on the cpumask_local_spread is used to set IRQ affinity.
Ideally when a device is initialized its IRQs are distributed based on the
default SMP affinity mask (considering irqbalance is disabled). However, it
is not the case right now as some drivers that set their hint affinity
using cpumask_local_spread overwrites the previously set affinity mask for
the IRQs. So even if you configure the default_smp_affinity from the
userspace it will not affect these device IRQs. This is precisely why your
fix for cpumask_local_spread helped in improving the isolation.

The second issue that you brought up is to balance the IRQ-specific load
between CPUs efficiently. FWIU if you have irqbalance enabled it should
already be doing that based on the policy that you define in the userspace.
Is that not the case or maybe I am missing something?

-- 
Thanks
Nitesh

