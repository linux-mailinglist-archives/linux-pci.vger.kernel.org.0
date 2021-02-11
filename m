Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F71318F4B
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 17:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhBKP7l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 10:59:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40183 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230303AbhBKP5c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 10:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613058966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FgID+L3tcWjGCzMJOEFzOMkSnQKXBsghqlTv8BLKjOs=;
        b=CsaarQP+3zaJN9wn918ApjtT7YK3QIFHfThI6e3rRrMX+SHZPPG0ScmPXn/AVfQwfzyCUe
        MoC6c+wzBdfYcgBgpLStF+okgwYy3dCG0Lc8q5hkZDLDLpWWXQh30cli9A/vxOrx60WW31
        2N9r/HrJZAT5b/uKVypaRLwEmcwrU+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-GDVA0jVsMKSpXZsXWaO46Q-1; Thu, 11 Feb 2021 10:56:01 -0500
X-MC-Unique: GDVA0jVsMKSpXZsXWaO46Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3117F8049C6;
        Thu, 11 Feb 2021 15:55:26 +0000 (UTC)
Received: from [10.10.117.219] (ovpn-117-219.rdu2.redhat.com [10.10.117.219])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FFC210013D7;
        Thu, 11 Feb 2021 15:55:19 +0000 (UTC)
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping
 CPUs
From:   Nitesh Narayan Lal <nitesh@redhat.com>
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
 <d0aed683-87ae-91a2-d093-de3f5d8a8251@redhat.com>
Organization: Red Hat Inc,
Message-ID: <7780ae60-efbd-2902-caaa-0249a1f277d9@redhat.com>
Date:   Thu, 11 Feb 2021 10:55:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <d0aed683-87ae-91a2-d093-de3f5d8a8251@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2/6/21 7:43 PM, Nitesh Narayan Lal wrote:
> On 2/5/21 5:23 PM, Thomas Gleixner wrote:
>> On Thu, Feb 04 2021 at 14:17, Nitesh Narayan Lal wrote:
>>> On 2/4/21 2:06 PM, Marcelo Tosatti wrote:
>>>>>> How about adding a new flag for isolcpus instead?
>>>>>>
>>>>> Do you mean a flag based on which we can switch the affinity mask to
>>>>> housekeeping for all the devices at the time of IRQ distribution?
>>>> Yes a new flag for isolcpus. HK_FLAG_IRQ_SPREAD or some better name.
>>> Does sounds like a nice idea to explore, lets see what Thomas thinks about it.

<snip>

>>> When the affinity mask of the interrupt at the time when it is actually
>>> requested contains an isolated CPU then nothing prevents the kernel from
>>> steering it at an isolated CPU. But that has absolutely nothing to do
>>> with that spreading thingy.
>>>
>>> The only difference which this change makes is the fact that the
>>> affinity hint changes. Nothing else.
>>>
> Thanks for the detailed explanation.
>
> Before I posted this patch, I was doing some debugging on a setup where I
> was observing some latency issues due to the iavf IRQs that were pinned on
> the isolated CPUs.
>
> Based on some initial traces I had this impression that the affinity hint
> or cpumask_local_spread was somehow playing a role in deciding the affinity
> mask of these IRQs. Although, that does look incorrect after going through
> your explanation.
> For some reason, with a kernel that had this patch when I tried creating
> VFs iavf IRQs always ended up on the HK CPUs.
>
> The reasoning for the above is still not very clear to me. I will investigate
> this further to properly understand this behavior.
>
>

After a little more digging, I found out why cpumask_local_spread change
affects the general/initial smp_affinity for certain device IRQs.

After the introduction of the commit:

    e2e64a932 genirq: Set initial affinity in irq_set_affinity_hint()

For all the drivers that set hint, initial affinity is set based on the
CPU retrieved from cpumask_local_spread. So in an environment where
irqbalance is disabled, these device IRQs remain on the CPUs that are
picked from cpumask_local_spread even though they are isolated. I think
the commit message of the reverted patch should have covered this as
well.

-- 
Thanks
Nitesh

