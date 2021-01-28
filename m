Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC7F307BAD
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 18:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhA1RCP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 12:02:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232802AbhA1RBI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 12:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611853181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wTELoI+QrGDN20yA6IDTMLz1Sp4P4GWFu2WQqjSfVlw=;
        b=Z92Ph6dSQSdIuQo9cARE0OxcmhTnQE7AxkQgUYeCXHqKPXiqa7/whIfhIZhXdAovXfGOLJ
        ycPDExW8y00P5wU/0++De53Tx33c1mDPW0I/L+xet5SpDGW8nT5NXI27wRMf2Gu8W/ysAK
        5h+A9ulzfI0s+7zH6gF0miMbzxfHTFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-yVqbzrkBO6u43q4oeO7o4Q-1; Thu, 28 Jan 2021 11:59:39 -0500
X-MC-Unique: yVqbzrkBO6u43q4oeO7o4Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4375B180A09D;
        Thu, 28 Jan 2021 16:59:36 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8842F62464;
        Thu, 28 Jan 2021 16:59:29 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 2C988416D87F; Thu, 28 Jan 2021 13:33:33 -0300 (-03)
Date:   Thu, 28 Jan 2021 13:33:33 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, juri.lelli@redhat.com, abelits@marvell.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, peterz@infradead.org,
        davem@davemloft.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com, jinyuqi@huawei.com,
        zhangshaokun@hisilicon.com
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping
 CPUs
Message-ID: <20210128163333.GA38339@fuller.cnet>
References: <20200625223443.2684-1-nitesh@redhat.com>
 <20200625223443.2684-2-nitesh@redhat.com>
 <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com>
 <20210127121939.GA54725@fuller.cnet>
 <c5cba5f3-287a-d087-c329-6e6613634370@arm.com>
 <20210127130925.GA64740@fuller.cnet>
 <87tur1cay0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tur1cay0.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 28, 2021 at 04:56:07PM +0100, Thomas Gleixner wrote:
> On Wed, Jan 27 2021 at 10:09, Marcelo Tosatti wrote:
> > On Wed, Jan 27, 2021 at 12:36:30PM +0000, Robin Murphy wrote:
> >> > > >    /**
> >> > > >     * cpumask_next - get the next cpu in a cpumask
> >> > > > @@ -205,22 +206,27 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
> >> > > >     */
> >> > > >    unsigned int cpumask_local_spread(unsigned int i, int node)
> >> > > >    {
> >> > > > -	int cpu;
> >> > > > +	int cpu, hk_flags;
> >> > > > +	const struct cpumask *mask;
> >> > > > +	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_MANAGED_IRQ;
> >> > > > +	mask = housekeeping_cpumask(hk_flags);
> >> > > 
> >> > > AFAICS, this generally resolves to something based on cpu_possible_mask
> >> > > rather than cpu_online_mask as before, so could now potentially return an
> >> > > offline CPU. Was that an intentional change?
> >> > 
> >> > Robin,
> >> > 
> >> > AFAICS online CPUs should be filtered.
> >> 
> >> Apologies if I'm being thick, but can you explain how? In the case of
> >> isolation being disabled or compiled out, housekeeping_cpumask() is
> >> literally just "return cpu_possible_mask;". If we then iterate over that
> >> with for_each_cpu() and just return the i'th possible CPU (e.g. in the
> >> NUMA_NO_NODE case), what guarantees that CPU is actually online?
> >> 
> >> Robin.
> >
> > Nothing, but that was the situation before 1abdfe706a579a702799fce465bceb9fb01d407c
> > as well.
> >
> > cpumask_local_spread() should probably be disabling CPU hotplug.
> 
> It can't unless all callers are from preemtible code.
> 
> Aside of that this whole frenzy to sprinkle housekeeping_cpumask() all
> over the kernel is just wrong, really.
> 
> As I explained several times before there are very valid reasons for
> having queues and interrupts on isolated CPUs. Just optimizing for the
> usecases some people care about is not making anything better.

And that is right.

