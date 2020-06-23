Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17010204DD9
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 11:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbgFWJWj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jun 2020 05:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbgFWJWj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jun 2020 05:22:39 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B66C061573;
        Tue, 23 Jun 2020 02:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OmbjYzCaroWn1F04OAz4836knNUd+iPJjfihjjrrios=; b=nD1kI6VEM2mWuvdksMzqpuE+0/
        RwYAaA0TcZPfAequ8SlzGVHloQTR4uPnpeO3ZAZcfBLDtIb1j0yknAwgi7eqd/zLJg35kCqPWXLyX
        kvOAWndJ76KlllDup9LYJT0k8Evcv7gMWwXTSvxAP+hwgeXsPyMOhVPhB3LzxmJ15Qf7B+MCNd5OW
        1c86qelYEL6EkCnuiOLgSCpOuxojoBN18r19TMDdbbY1ftYDDJ5h+RyYrdiVQ4si9Dwp8E/kFHILD
        j341Gn43rwkVfjZ3I4DzfJ50FobY4exjUI29hfkkmqhMLrX30m6MuztDx7JPuRaMin5r6hzWgs/vu
        7IoeZbJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnf7d-0002XB-Qw; Tue, 23 Jun 2020 09:21:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8A23E30477A;
        Tue, 23 Jun 2020 11:21:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0113D237095E6; Tue, 23 Jun 2020 11:21:39 +0200 (CEST)
Date:   Tue, 23 Jun 2020 11:21:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        tglx@linutronix.de, davem@davemloft.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com
Subject: Re: [Patch v2 1/3] lib: Restrict cpumask_local_spread to houskeeping
 CPUs
Message-ID: <20200623092139.GB4781@hirez.programming.kicks-ass.net>
References: <20200622234510.240834-1-nitesh@redhat.com>
 <20200622234510.240834-2-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622234510.240834-2-nitesh@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 22, 2020 at 07:45:08PM -0400, Nitesh Narayan Lal wrote:
> From: Alex Belits <abelits@marvell.com>
> 
> The current implementation of cpumask_local_spread() does not respect the
> isolated CPUs, i.e., even if a CPU has been isolated for Real-Time task,
> it will return it to the caller for pinning of its IRQ threads. Having
> these unwanted IRQ threads on an isolated CPU adds up to a latency
> overhead.
> 
> Restrict the CPUs that are returned for spreading IRQs only to the
> available housekeeping CPUs.
> 
> Signed-off-by: Alex Belits <abelits@marvell.com>
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> ---
>  lib/cpumask.c | 43 +++++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index fb22fb266f93..cc4311a8c079 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -6,6 +6,7 @@
>  #include <linux/export.h>
>  #include <linux/memblock.h>
>  #include <linux/numa.h>
> +#include <linux/sched/isolation.h>
>  
>  /**
>   * cpumask_next - get the next cpu in a cpumask
> @@ -205,28 +206,34 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
>   */
>  unsigned int cpumask_local_spread(unsigned int i, int node)
>  {
> -	int cpu;
> +	int cpu, m, n, hk_flags;
> +	const struct cpumask *mask;
>  
> +	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
> +	mask = housekeeping_cpumask(hk_flags);
> +	m = cpumask_weight(mask);
>  	/* Wrap: we always want a cpu. */
> -	i %= num_online_cpus();
> +	n = i % m;
> +	while (m-- > 0) {

I are confuzled. What do we need this outer loop for?

Why isn't something like:

	i %= cpumask_weight(mask);

good enough? That voids having to touch the test.
Still when you're there, at the very least you can fix the horrible
style:


> +		if (node == NUMA_NO_NODE) {
> +			for_each_cpu(cpu, mask)
> +				if (n-- == 0)
> +					return cpu;

{ }

> +		} else {
> +			/* NUMA first. */
> +			for_each_cpu_and(cpu, cpumask_of_node(node), mask)
> +				if (n-- == 0)
> +					return cpu;

{ }

>  
> +			for_each_cpu(cpu, mask) {
> +				/* Skip NUMA nodes, done above. */
> +				if (cpumask_test_cpu(cpu,
> +						     cpumask_of_node(node)))
> +					continue;

No linebreak please.

>  
> +				if (n-- == 0)
> +					return cpu;
> +			}
>  		}
>  	}
>  	BUG();
> -- 
> 2.18.4
> 
