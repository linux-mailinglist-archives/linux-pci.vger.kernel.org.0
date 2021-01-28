Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0F9307BAE
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 18:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhA1RCT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 12:02:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56525 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232836AbhA1RBK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 12:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611853183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O4v5XWPNcZdSmISm472mH90bUGvUqIsL5GmAjen7+Gg=;
        b=THbRJBm9C9XSgmdfUbMY6x9m8FjBNm/k1tZeg1/K5xWDXqICJarKDeH0uohxvLCfiKUcdT
        au3NtKrJN8lMzOaEYs9OfF9zMoIXnlDaE84/R+F6gEEe0EDlTcJWni59xXbbdag9VClS7y
        Gn509y8Gkou2L/MWPmK/fJQJRXe6DLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-wSuEOgG5PI-g4NLjLJt2bw-1; Thu, 28 Jan 2021 11:59:39 -0500
X-MC-Unique: wSuEOgG5PI-g4NLjLJt2bw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B443280A5C0;
        Thu, 28 Jan 2021 16:59:36 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FEA01F450;
        Thu, 28 Jan 2021 16:59:29 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 7A60D4178900; Thu, 28 Jan 2021 13:59:03 -0300 (-03)
Date:   Thu, 28 Jan 2021 13:59:03 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Nitesh Narayan Lal <nitesh@redhat.com>
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
Message-ID: <20210128165903.GB38339@fuller.cnet>
References: <20200625223443.2684-1-nitesh@redhat.com>
 <20200625223443.2684-2-nitesh@redhat.com>
 <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com>
 <20210127121939.GA54725@fuller.cnet>
 <87r1m5can2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1m5can2.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 28, 2021 at 05:02:41PM +0100, Thomas Gleixner wrote:
> On Wed, Jan 27 2021 at 09:19, Marcelo Tosatti wrote:
> > On Wed, Jan 27, 2021 at 11:57:16AM +0000, Robin Murphy wrote:
> >> > +	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_MANAGED_IRQ;
> >> > +	mask = housekeeping_cpumask(hk_flags);
> >> 
> >> AFAICS, this generally resolves to something based on cpu_possible_mask
> >> rather than cpu_online_mask as before, so could now potentially return an
> >> offline CPU. Was that an intentional change?
> >
> > Robin,
> >
> > AFAICS online CPUs should be filtered.
> 
> The whole pile wants to be reverted. It's simply broken in several ways.

I was asking for your comments on interaction with CPU hotplug :-)
Anyway...

So housekeeping_cpumask has multiple meanings. In this case:

HK_FLAG_DOMAIN | HK_FLAG_MANAGED_IRQ

     domain
       Isolate from the general SMP balancing and scheduling
       algorithms. Note that performing domain isolation this way
       is irreversible: it's not possible to bring back a CPU to
       the domains once isolated through isolcpus. It's strongly
       advised to use cpusets instead to disable scheduler load
       balancing through the "cpuset.sched_load_balance" file.
       It offers a much more flexible interface where CPUs can
       move in and out of an isolated set anytime.

       You can move a process onto or off an "isolated" CPU via
       the CPU affinity syscalls or cpuset.
       <cpu number> begins at 0 and the maximum value is
       "number of CPUs in system - 1".

     managed_irq

       Isolate from being targeted by managed interrupts
       which have an interrupt mask containing isolated
       CPUs. The affinity of managed interrupts is
       handled by the kernel and cannot be changed via
       the /proc/irq/* interfaces.

       This isolation is best effort and only effective
       if the automatically assigned interrupt mask of a
       device queue contains isolated and housekeeping
       CPUs. If housekeeping CPUs are online then such
       interrupts are directed to the housekeeping CPU
       so that IO submitted on the housekeeping CPU
       cannot disturb the isolated CPU.

       If a queue's affinity mask contains only isolated
       CPUs then this parameter has no effect on the
       interrupt routing decision, though interrupts are
       only delivered when tasks running on those
       isolated CPUs submit IO. IO submitted on
       housekeeping CPUs has no influence on those
       queues.

So as long as the meaning of the flags are respected, seems
alright.

Nitesh, is there anything preventing this from being fixed
in userspace ? (as Thomas suggested previously).



