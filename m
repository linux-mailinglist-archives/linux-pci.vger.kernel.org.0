Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A45307CB2
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 18:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhA1RhU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 12:37:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233170AbhA1RhP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 12:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611855349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TWWXXrKtDvXCZYJdS454rtlLyStjMZruwt0GmOtcIHc=;
        b=Mn3bYytbJ5oYbMtlAMOxXDJC7Nr+6KoeTMZdSigvWp1B6KosnjybYAXbJWNuAoGa8a+FVH
        /Ct0Wi1F07Q8cnoqK426N4i75j6cx6V+6P6izQ5KJ7e+AHlihf3XFmQYQpUn6DVFkiMtIM
        tPpyDZqVMG9Kc4yfCm14woB8NquC1fU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-boJcy9VeNuyehTGpv1lUnw-1; Thu, 28 Jan 2021 12:35:47 -0500
X-MC-Unique: boJcy9VeNuyehTGpv1lUnw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 741C784A5E0;
        Thu, 28 Jan 2021 17:35:44 +0000 (UTC)
Received: from [10.10.113.213] (ovpn-113-213.rdu2.redhat.com [10.10.113.213])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0012310016DB;
        Thu, 28 Jan 2021 17:35:36 +0000 (UTC)
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping
 CPUs
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
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
 <20210128165903.GB38339@fuller.cnet>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Organization: Red Hat Inc,
Message-ID: <3f138a52-7e6a-2c40-23f7-33515893a178@redhat.com>
Date:   Thu, 28 Jan 2021 12:35:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210128165903.GB38339@fuller.cnet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 1/28/21 11:59 AM, Marcelo Tosatti wrote:
> On Thu, Jan 28, 2021 at 05:02:41PM +0100, Thomas Gleixner wrote:
>> On Wed, Jan 27 2021 at 09:19, Marcelo Tosatti wrote:
>>> On Wed, Jan 27, 2021 at 11:57:16AM +0000, Robin Murphy wrote:
>>>>> +	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_MANAGED_IRQ;
>>>>> +	mask = housekeeping_cpumask(hk_flags);
>>>> AFAICS, this generally resolves to something based on cpu_possible_mask
>>>> rather than cpu_online_mask as before, so could now potentially return an
>>>> offline CPU. Was that an intentional change?
>>> Robin,
>>>
>>> AFAICS online CPUs should be filtered.
>> The whole pile wants to be reverted. It's simply broken in several ways.
> I was asking for your comments on interaction with CPU hotplug :-)
> Anyway...
>
> So housekeeping_cpumask has multiple meanings. In this case:
>
> HK_FLAG_DOMAIN | HK_FLAG_MANAGED_IRQ
>
>      domain
>        Isolate from the general SMP balancing and scheduling
>        algorithms. Note that performing domain isolation this way
>        is irreversible: it's not possible to bring back a CPU to
>        the domains once isolated through isolcpus. It's strongly
>        advised to use cpusets instead to disable scheduler load
>        balancing through the "cpuset.sched_load_balance" file.
>        It offers a much more flexible interface where CPUs can
>        move in and out of an isolated set anytime.
>
>        You can move a process onto or off an "isolated" CPU via
>        the CPU affinity syscalls or cpuset.
>        <cpu number> begins at 0 and the maximum value is
>        "number of CPUs in system - 1".
>
>      managed_irq
>
>        Isolate from being targeted by managed interrupts
>        which have an interrupt mask containing isolated
>        CPUs. The affinity of managed interrupts is
>        handled by the kernel and cannot be changed via
>        the /proc/irq/* interfaces.
>
>        This isolation is best effort and only effective
>        if the automatically assigned interrupt mask of a
>        device queue contains isolated and housekeeping
>        CPUs. If housekeeping CPUs are online then such
>        interrupts are directed to the housekeeping CPU
>        so that IO submitted on the housekeeping CPU
>        cannot disturb the isolated CPU.
>
>        If a queue's affinity mask contains only isolated
>        CPUs then this parameter has no effect on the
>        interrupt routing decision, though interrupts are
>        only delivered when tasks running on those
>        isolated CPUs submit IO. IO submitted on
>        housekeeping CPUs has no influence on those
>        queues.
>
> So as long as the meaning of the flags are respected, seems
> alright.
>
> Nitesh, is there anything preventing this from being fixed
> in userspace ? (as Thomas suggested previously).

I think it should be doable atleast for most of the devices.
However, I do wonder if there is a better way of fixing this generically
from the kernel?

Currently, as Thomas mentioned housekeeping_cpumask() is used at different
locations just to fix the issue corresponding to that component or driver.

-- 
Thanks
Nitesh

