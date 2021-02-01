Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190CC30AE77
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 18:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhBARwR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 12:52:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20461 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232613AbhBARwM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Feb 2021 12:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612201845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UFisRaZ0xO1HdQ49kCdB0yl96ksAM6/3yFLOwHvoRz4=;
        b=B3JCcIV/ZZ9i+/rQbQGs/UYX4Q239sm4YwxxqtPAcSkNW7wQykc9NPmbBzxuV6S8AcS+Li
        39D8dAlpbQNpTYzdl0pVKK6PETfiP/zOLtye0tzXHFGh87r1GhEuQhnxy0CyDYRMBGYjZs
        Gmv282k3jVvwLDSaCG0OcEB2Z+4TWpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-0IydLlIZNRKGGK9PZjogDA-1; Mon, 01 Feb 2021 12:50:41 -0500
X-MC-Unique: 0IydLlIZNRKGGK9PZjogDA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A40331015940;
        Mon,  1 Feb 2021 17:50:38 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CCC410016DB;
        Mon,  1 Feb 2021 17:50:31 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id D67294178902; Mon,  1 Feb 2021 14:50:03 -0300 (-03)
Date:   Mon, 1 Feb 2021 14:50:02 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Alex Belits <abelits@marvell.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, juri.lelli@redhat.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        jinyuqi@huawei.com, zhangshaokun@hisilicon.com
Subject: Re: [EXT] Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to
 houskeeping CPUs
Message-ID: <20210201175002.GA27318@fuller.cnet>
References: <20200625223443.2684-1-nitesh@redhat.com>
 <20200625223443.2684-2-nitesh@redhat.com>
 <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com>
 <20210127121939.GA54725@fuller.cnet>
 <c5cba5f3-287a-d087-c329-6e6613634370@arm.com>
 <20210127130925.GA64740@fuller.cnet>
 <87tur1cay0.fsf@nanos.tec.linutronix.de>
 <02ac9d85-7ddd-96da-1252-4663feea7c9f@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02ac9d85-7ddd-96da-1252-4663feea7c9f@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 29, 2021 at 07:41:27AM -0800, Alex Belits wrote:
> On 1/28/21 07:56, Thomas Gleixner wrote:
> > External Email
> > 
> > ----------------------------------------------------------------------
> > On Wed, Jan 27 2021 at 10:09, Marcelo Tosatti wrote:
> > > On Wed, Jan 27, 2021 at 12:36:30PM +0000, Robin Murphy wrote:
> > > > > > >     /**
> > > > > > >      * cpumask_next - get the next cpu in a cpumask
> > > > > > > @@ -205,22 +206,27 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
> > > > > > >      */
> > > > > > >     unsigned int cpumask_local_spread(unsigned int i, int node)
> > > > > > >     {
> > > > > > > -	int cpu;
> > > > > > > +	int cpu, hk_flags;
> > > > > > > +	const struct cpumask *mask;
> > > > > > > +	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_MANAGED_IRQ;
> > > > > > > +	mask = housekeeping_cpumask(hk_flags);
> > > > > > 
> > > > > > AFAICS, this generally resolves to something based on cpu_possible_mask
> > > > > > rather than cpu_online_mask as before, so could now potentially return an
> > > > > > offline CPU. Was that an intentional change?
> > > > > 
> > > > > Robin,
> > > > > 
> > > > > AFAICS online CPUs should be filtered.
> > > > 
> > > > Apologies if I'm being thick, but can you explain how? In the case of
> > > > isolation being disabled or compiled out, housekeeping_cpumask() is
> > > > literally just "return cpu_possible_mask;". If we then iterate over that
> > > > with for_each_cpu() and just return the i'th possible CPU (e.g. in the
> > > > NUMA_NO_NODE case), what guarantees that CPU is actually online?
> > > > 
> > > > Robin.
> > > 
> > > Nothing, but that was the situation before 1abdfe706a579a702799fce465bceb9fb01d407c
> > > as well.
> > > 
> > > cpumask_local_spread() should probably be disabling CPU hotplug.
> > 
> > It can't unless all callers are from preemtible code.
> > 
> > Aside of that this whole frenzy to sprinkle housekeeping_cpumask() all
> > over the kernel is just wrong, really.
> > 
> > As I explained several times before there are very valid reasons for
> > having queues and interrupts on isolated CPUs. Just optimizing for the
> > usecases some people care about is not making anything better.
> 
> However making it mandatory for isolated CPUs to allow interrupts is not a
> good idea, either. Providing an environment free of disturbances is a valid
> goal, so we can't do something that will make it impossible to achieve. We
> know that both there is a great amount of demand for this feature and
> implementing it is doable, so cutting off the possibility of development in
> this direction would be bad.
> 
> Before there was housekeeping mask, I had to implement another, more
> cumbersome model that ended up being more intrusive than I wanted. That was
> one of the reasons why I have spent some time working on it in, please
> forgive me the pun, isolation.
> 
> I was relieved when housekeeping mask appeared, and I was able to remove a
> large chunk of code that distinguished between CPUs that "are there" and
> CPUs "available to run work". Housekeeping is supposed to define the set of
> CPUs that are intended to run work that is not specifically triggered by
> anything running on those CPUs. "CPUs that are there" are CPUs that are
> being maintained as a part of the system, so they are usable for running
> things on them.
> 
> My idea at the time was that we can separate this into two directions of
> development:
> 
> 1. Make sure that housekeeping mask applies to all kinds of work that
> appears on CPUs, so nothing random will end up running there. Because this
> is very much in line of what it does.

Its easier to specify "all members of set" rather than having to specify each
individual member. Thinking of set as a description of types of
activities that should not have a given CPU as a target.

> 2. Rely on housekeeping mask to exclude anything not specifically intended
> to run on isolated CPUs, and concentrate efforts on making sure that things
> that are intended to [eventually] happen on those CPUs are handled properly
> -- in case of my recent proposals, delayed until synchronization event at
> the next kernel entry.

Your point makes sense, but the "isolated CPU + one interrupt to this CPU"
use-case is a valid one.

"target CPU" is the CPU we are interested in executing the application
(and handling the interrupt). So isolation happens today in the
following components:

        1)  setup kernel boot parameters for isolation (suppose
            the goal is to move these to happen dynamically in
            userspace, so they would move to step 2 in the future).

        2)  disable certain activities from happening at target CPU: "exclude ALL
            activities for target CPU which can be performed by
            housekeeping CPUs" (which might involve a
            number of steps in userspace such as
            the RPS mask configuration, network queue configuration
            to avoid vector exhaustion, removal of other activities
            on target CPU).

        3) userspace informs status of execution of isolated
           application (via the prctl interface, the QUIESCE step).
           From this point on interruptions (not as in IRQs but as in
	   "isolation breaking events") should be either ignored
           or logged.

> If we want to have some kind of greater flexibility of CPU hotplug
> management, more runtime control of isolation and housekeeping masks, or

Well i think any activity which can possibly cause an interruption
should be blocked from happening in the kernel. Which can be done as
soon as the

        "if (cpu_is_isolated(cpu))"

Logic can be integrated.

> more specific definition of what housekeeping mask does, we still have to
> implement the intended functionality. Something still has to determine,
> where we should not place delayed work, interrupts, etc. for the purpose of
> distributing this kind of work.

Yes, and today the isolation is being performed:

1) At boot time.
2) At isolation configuration (userspace). We have been trying to
centralize this in tuned profiles:

* With isolcpus=domain,: https://github.com/redhat-performance/tuned/blob/master/profiles/realtime-virtual-host/realtime-virtual-host-variables.conf
* With cgroups sets / systemd affinity masks: https://github.com/redhat-performance/tuned/blob/master/profiles/cpu-partitioning/tuned.conf

> As far as I can tell, the real underlying problem is that if anything
> changes (hotplug happens, CPUs are added or removed from hotplug mask,
> etc.), for absolutely correct solution in the most general case we would
> have to modify all those masks that we have determined for various purposes
> in various pieces of code and re-apply them. So, say, RPS implemented in a
> running driver will be reconfigured to remove CPUs that are no longer there,
> or CPUs that we now no longer want in "housekeeping" or "available for RPS,
> delayed work, or something similar" mask.

We discussed separating housekeeping_mask in per feature masks here:

https://lkml.org/lkml/2020/9/3/1067

So that userspace could control each feature individually.

> To do that (and for full and complete support of hotplug we will have to do
> that), we would have to reconfigure all users of CPU masks on hotplug and on
> whatever other events that reassign CPUs purpose. 

Good point.

-> Isolate CPU event: steps 1 and 2 above.
-> Unisolate CPU event: undo steps 1 and 2 above (considering the
boot-time limitation of 1).

-> Network device creation: Currently the proposed solution seems to be 
https://lkml.org/lkml/2021/1/22/815, which requires userspace
code modification (still missing this case).

-> CPU hotplug/hotunplug: unclear. 

> This may be eventually
> done, however I don't know if it's a good idea to implement it at once, the
> task of "adjusting all consumers of feature X" usually takes a while, and
> even proposing such thing imposes a great amount of work on many people.

Agree. CPU hotplug for example is not a feature which is very common 
on this type of deployments. Having an initial implementation 
which is suitable for the use cases in production seems OK.

> However we can make a decision, if we really want to go into that direction,
> and provide a way of handling a general event "CPUs are being repurposed,
> now adjust whatever is being sent to them". It's my opinion that it would be
> a good idea, we just can't expect it to be adopted overnight, so we can't
> make it mandatory.
> 
> However if we don't want to block development of "full isolation" for a very
> long time over this, we can have some minimal implementation available
> before there will be a decision and implementation of completely dynamic
> handling of "what can be done on what CPU".

Agree: the dynamic handling can be done as a later step.

> So maybe we have to implement something much more simple. For CPU hotplug it
> may be something like, "CPU coming online should not be added to
> housekeeping mask unless full isolation is disabled". 

Not sure i get this. 

> Then we can add a
> procedure for adding a non-housekeeping CPU to housekeeping mask. And that
> procedure will fail if CPU is isolated. 
>
> If we will have dynamic
> configuration of isolated CPUs we can make it necessary to remove CPU from
> isolated mask and add it to housekeeping after that. That will never produce
> any problems. The worst that will happen, some users of CPU masks will miss
> an opportunity to add more CPUs to whatever they use.

The usecase here seems to be hardware with a single OS running both
isolated and non-isolated workloads (say a latency sensitive
application, using multiple cores, and it can scale up/down on 
the number of cores depending on load). On the remaining CPUs 
one can use non-latency sensitive workloads.

Does that make sense?

> Then there will be a problem, what to do when we want to remove CPU from
> housekeeping or maybe this new category "CPUs that are available for various
> things". Initially we can just allow it only on hotplug.

Fail to parse sentence. Can you expand on "CPUs that are available for
various things?" 

> If we will want to implement removing a CPU from housekeeping and adding it
> to become available for isolation in general, we will have to do something
> new. It will probably look like a different kind of hotplug.

Hum, not sure why, have you read the discussion mentioned above, about 
the sysfs interface to control housekeeping?

> Maybe it's a bad idea to have only one kind of "housekeeping". 

Yes! That seems to be the same conclusion on the thread.

Forgot to CC you here:
https://www.spinics.net/lists/kernel/msg3814616.html

Can probably drop patch 7/9 from your series once this is
integrated.

> As I said
> above, we may choose to implement "CPUs available for work intended to be
> spread over multiple CPUs". Or maybe there should be "CPUs available for
> long-term running kernel tasks that are not considered housekeeping". And we
> can have separate "CPUs that are allowed to handle timers". There may be
> reasons for supporting this, other than isolation -- for example, big.LITTLE
> or new kinds of power management policies. But then, of course, we will have
> to consider more possible uses for those features, and adjust them for those
> purposes.

