Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8B4355A32
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 19:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244555AbhDFRWR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 6 Apr 2021 13:22:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:29859 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233676AbhDFRWR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 13:22:17 -0400
IronPort-SDR: b9JvhyY60nU91zlsaL51Oh7f2wxZjb/aLvG9zZ/oikt8wbrv+B6YpOqOze610i9+X9W7BZUw1E
 vv9kg7hFz8qQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="189911506"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="189911506"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 10:22:09 -0700
IronPort-SDR: 60qCf+vkBQ0uu7Ll0cvSt+RQvqIwZ7ph+BZE/9nswI81XdmB0Bj74dtbXyU7M/RHWfEopZAPWg
 fJG61m5Alggw==
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="448685775"
Received: from jbrandeb-mobl4.amr.corp.intel.com (HELO localhost) ([10.212.227.101])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 10:22:08 -0700
Date:   Tue, 6 Apr 2021 10:22:07 -0700
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, juri.lelli@redhat.com, abelits@marvell.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, peterz@infradead.org,
        davem@davemloft.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com, jinyuqi@huawei.com,
        zhangshaokun@hisilicon.com
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to
 houskeeping CPUs
Message-ID: <20210406102207.0000485c@intel.com>
In-Reply-To: <07c04bc7-27f0-9c07-9f9e-2d1a450714ef@redhat.com>
References: <20200625223443.2684-1-nitesh@redhat.com>
        <20200625223443.2684-2-nitesh@redhat.com>
        <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com>
        <20210127121939.GA54725@fuller.cnet>
        <87r1m5can2.fsf@nanos.tec.linutronix.de>
        <20210128165903.GB38339@fuller.cnet>
        <87h7n0de5a.fsf@nanos.tec.linutronix.de>
        <20210204181546.GA30113@fuller.cnet>
        <cfa138e9-38e3-e566-8903-1d64024c917b@redhat.com>
        <20210204190647.GA32868@fuller.cnet>
        <d8884413-84b4-b204-85c5-810342807d21@redhat.com>
        <87y2g26tnt.fsf@nanos.tec.linutronix.de>
        <d0aed683-87ae-91a2-d093-de3f5d8a8251@redhat.com>
        <7780ae60-efbd-2902-caaa-0249a1f277d9@redhat.com>
        <07c04bc7-27f0-9c07-9f9e-2d1a450714ef@redhat.com>
X-Mailer: Claws Mail 3.12.0 (GTK+ 2.24.28; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Continuing a thread from a bit ago...

Nitesh Narayan Lal wrote:

> > After a little more digging, I found out why cpumask_local_spread change
> > affects the general/initial smp_affinity for certain device IRQs.
> >
> > After the introduction of the commit:
> >
> >     e2e64a932 genirq: Set initial affinity in irq_set_affinity_hint()
> >
> 
> Continuing the conversation about the above commit and adding Jesse.
> I was trying to understand the problem that the commit message explains
> "The default behavior of the kernel is somewhat undesirable as all
> requested interrupts end up on CPU0 after registration.", I have also been
> trying to reproduce this behavior without the patch but I failed in doing
> so, maybe because I am missing something here.
> 
> @Jesse Can you please explain? FWIU IRQ affinity should be decided based on
> the default affinity mask.

The original issue as seen, was that if you rmmod/insmod a driver
*without* irqbalance running, the default irq mask is -1, which means
any CPU. The older kernels (this issue was patched in 2014) used to use
that affinity mask, but the value programmed into all the interrupt
registers "actual affinity" would end up delivering all interrupts to
CPU0, and if the machine was under traffic load incoming when the
driver loaded, CPU0 would start to poll among all the different netdev
queues, all on CPU0.

The above then leads to the condition that the device is stuck polling
even if the affinity gets updated from user space, and the polling will
continue until traffic stops.

> The problem with the commit is that when we overwrite the affinity mask
> based on the hinting mask we completely ignore the default SMP affinity
> mask. If we do want to overwrite the affinity based on the hint mask we
> should atleast consider the default SMP affinity.

Maybe the right thing is to fix which CPUs are passed in as the valid
mask, or make sure the kernel cross checks that what the driver asks
for is a "valid CPU"?
