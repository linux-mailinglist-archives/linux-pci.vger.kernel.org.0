Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A64305B3E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 13:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbhA0MZO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 07:25:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32495 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235925AbhA0MWC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jan 2021 07:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611750034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wb6zepnLUfjQE6SpoSSqkOZ1CmRA5GSq31+ma+nKIb4=;
        b=bOP0osJUrKXjtMw+g8LbzVKax9qLe1vjSge0ZkAQefb3uJRluzsOAQ4W6oC0NjegeVF++l
        s61jWNbHLiXeXXZNheinX/o0XZky45laPuCR9jMdYi3hav4tkyX4JByEpkhVeObYUv9FHN
        sN9QrNE22MrtdH01Wwx3rZd8oAsee8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-vUkMZCK3Mtq2CtLoziprjg-1; Wed, 27 Jan 2021 07:20:32 -0500
X-MC-Unique: vUkMZCK3Mtq2CtLoziprjg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7857107ACF6;
        Wed, 27 Jan 2021 12:20:29 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 655285C1C2;
        Wed, 27 Jan 2021 12:20:22 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 8958B4178900; Wed, 27 Jan 2021 09:19:39 -0300 (-03)
Date:   Wed, 27 Jan 2021 09:19:39 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, juri.lelli@redhat.com, abelits@marvell.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, davem@davemloft.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com, jinyuqi@huawei.com,
        zhangshaokun@hisilicon.com
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping
 CPUs
Message-ID: <20210127121939.GA54725@fuller.cnet>
References: <20200625223443.2684-1-nitesh@redhat.com>
 <20200625223443.2684-2-nitesh@redhat.com>
 <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 27, 2021 at 11:57:16AM +0000, Robin Murphy wrote:
> Hi,
> 
> On 2020-06-25 23:34, Nitesh Narayan Lal wrote:
> > From: Alex Belits <abelits@marvell.com>
> > 
> > The current implementation of cpumask_local_spread() does not respect the
> > isolated CPUs, i.e., even if a CPU has been isolated for Real-Time task,
> > it will return it to the caller for pinning of its IRQ threads. Having
> > these unwanted IRQ threads on an isolated CPU adds up to a latency
> > overhead.
> > 
> > Restrict the CPUs that are returned for spreading IRQs only to the
> > available housekeeping CPUs.
> > 
> > Signed-off-by: Alex Belits <abelits@marvell.com>
> > Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> > ---
> >   lib/cpumask.c | 16 +++++++++++-----
> >   1 file changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/lib/cpumask.c b/lib/cpumask.c
> > index fb22fb266f93..85da6ab4fbb5 100644
> > --- a/lib/cpumask.c
> > +++ b/lib/cpumask.c
> > @@ -6,6 +6,7 @@
> >   #include <linux/export.h>
> >   #include <linux/memblock.h>
> >   #include <linux/numa.h>
> > +#include <linux/sched/isolation.h>
> >   /**
> >    * cpumask_next - get the next cpu in a cpumask
> > @@ -205,22 +206,27 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
> >    */
> >   unsigned int cpumask_local_spread(unsigned int i, int node)
> >   {
> > -	int cpu;
> > +	int cpu, hk_flags;
> > +	const struct cpumask *mask;
> > +	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_MANAGED_IRQ;
> > +	mask = housekeeping_cpumask(hk_flags);
> 
> AFAICS, this generally resolves to something based on cpu_possible_mask
> rather than cpu_online_mask as before, so could now potentially return an
> offline CPU. Was that an intentional change?

Robin,

AFAICS online CPUs should be filtered.

> I was just looking at the current code since I had the rare presence of mind
> to check if something suitable already existed before I start open-coding
> "any online CPU, but local node preferred" logic for handling IRQ affinity
> in a driver - cpumask_local_spread() appears to be almost what I want (if a
> bit more heavyweight), if only it would actually guarantee an online CPU as
> the kerneldoc claims :(
> 
> Robin.
> 
> >   	/* Wrap: we always want a cpu. */
> > -	i %= num_online_cpus();
> > +	i %= cpumask_weight(mask);
> >   	if (node == NUMA_NO_NODE) {
> > -		for_each_cpu(cpu, cpu_online_mask)
> > +		for_each_cpu(cpu, mask) {
> >   			if (i-- == 0)
> >   				return cpu;
> > +		}
> >   	} else {
> >   		/* NUMA first. */
> > -		for_each_cpu_and(cpu, cpumask_of_node(node), cpu_online_mask)
> > +		for_each_cpu_and(cpu, cpumask_of_node(node), mask) {
> >   			if (i-- == 0)
> >   				return cpu;
> > +		}
> > -		for_each_cpu(cpu, cpu_online_mask) {
> > +		for_each_cpu(cpu, mask) {
> >   			/* Skip NUMA nodes, done above. */
> >   			if (cpumask_test_cpu(cpu, cpumask_of_node(node)))
> >   				continue;
> > 

