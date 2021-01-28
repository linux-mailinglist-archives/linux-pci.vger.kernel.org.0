Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0693A307A22
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 16:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhA1P4u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 10:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhA1P4t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 10:56:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1613C061573;
        Thu, 28 Jan 2021 07:56:09 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611849368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v7DK13VqedaiRyhN6auJfQWVt4sAAgXlM3M2nfbOtUY=;
        b=mAJp81XYDDNmPyYCI/hh3OGaWEgZCDW2IsQxzxWaT0nQPgyLwSoEwobPADg6vmqLKf8Ih/
        qBqp1eJDTI3H5LzYPeL36XmJKiBK2ZrbyGLrLjrJlgtObvtmF+rLcM/ya+F9e1atNWhZ2R
        OoFn0XUhOj/yziq23ckc6bIany0T1SAl7+ORWVVvIEtnrYWkNOqDF1mR7SiPEm/oXuxgLo
        mFlGiHT2kIla7mlNfLrVPZ/bNIrEk1wTWK/PlilbK6OhU8rfn31acVopi6XLenk0Z35hGi
        z92eTKmCrdB0dFpbJfB50SphU5Gut3u/tCJPwTzmQub9wkdyx+b8KyOyT915HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611849368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v7DK13VqedaiRyhN6auJfQWVt4sAAgXlM3M2nfbOtUY=;
        b=5BtMopMHLwtdC6uXbEdZ3WBadV+aKxb1e4f1h4B/3iCJTwCJfRVVyDEoxzpXSItf5mxr1I
        NeWz5zXeDqsDRWCQ==
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, juri.lelli@redhat.com, abelits@marvell.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, peterz@infradead.org,
        davem@davemloft.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com, jinyuqi@huawei.com,
        zhangshaokun@hisilicon.com
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping CPUs
In-Reply-To: <20210127130925.GA64740@fuller.cnet>
References: <20200625223443.2684-1-nitesh@redhat.com> <20200625223443.2684-2-nitesh@redhat.com> <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com> <20210127121939.GA54725@fuller.cnet> <c5cba5f3-287a-d087-c329-6e6613634370@arm.com> <20210127130925.GA64740@fuller.cnet>
Date:   Thu, 28 Jan 2021 16:56:07 +0100
Message-ID: <87tur1cay0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 27 2021 at 10:09, Marcelo Tosatti wrote:
> On Wed, Jan 27, 2021 at 12:36:30PM +0000, Robin Murphy wrote:
>> > > >    /**
>> > > >     * cpumask_next - get the next cpu in a cpumask
>> > > > @@ -205,22 +206,27 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
>> > > >     */
>> > > >    unsigned int cpumask_local_spread(unsigned int i, int node)
>> > > >    {
>> > > > -	int cpu;
>> > > > +	int cpu, hk_flags;
>> > > > +	const struct cpumask *mask;
>> > > > +	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_MANAGED_IRQ;
>> > > > +	mask = housekeeping_cpumask(hk_flags);
>> > > 
>> > > AFAICS, this generally resolves to something based on cpu_possible_mask
>> > > rather than cpu_online_mask as before, so could now potentially return an
>> > > offline CPU. Was that an intentional change?
>> > 
>> > Robin,
>> > 
>> > AFAICS online CPUs should be filtered.
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
>
> cpumask_local_spread() should probably be disabling CPU hotplug.

It can't unless all callers are from preemtible code.

Aside of that this whole frenzy to sprinkle housekeeping_cpumask() all
over the kernel is just wrong, really.

As I explained several times before there are very valid reasons for
having queues and interrupts on isolated CPUs. Just optimizing for the
usecases some people care about is not making anything better.

Thanks,

        tglx
