Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C20207C26
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 21:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391289AbgFXT0u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 15:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391257AbgFXT0u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jun 2020 15:26:50 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE6C22081A;
        Wed, 24 Jun 2020 19:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593026809;
        bh=AaVrCkbvdrnTMJpjmNJkp9fgMy62sxa7lMZDueE1js8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=entyhUy2DAHhZzqGA1Mv5asRjmiJXX6k5MeNRPqcFMP75szXMr6iUsznNbTrbi16s
         O/pfC8TYPXREiUwau4gyu+P39POTpe7OhPwHuEKZY/Cli6Jmz1kba8IjeyHKvKwxti
         fk1io+KueFd4VBq6kTjVw6TSlVekpyxocW3s6x+U=
Date:   Wed, 24 Jun 2020 12:26:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, davem@davemloft.net,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com, yuqi jin <jinyuqi@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: Re: [Patch v3 1/3] lib: Restrict cpumask_local_spread to
 houskeeping CPUs
Message-Id: <20200624122647.766bec7760d9197ba71a58c4@linux-foundation.org>
In-Reply-To: <20200623192331.215557-2-nitesh@redhat.com>
References: <20200623192331.215557-1-nitesh@redhat.com>
        <20200623192331.215557-2-nitesh@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 23 Jun 2020 15:23:29 -0400 Nitesh Narayan Lal <nitesh@redhat.com> wrote:

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
> ...
>
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
> @@ -205,22 +206,27 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
>   */
>  unsigned int cpumask_local_spread(unsigned int i, int node)
>  {
> -	int cpu;
> +	int cpu, hk_flags;
> +	const struct cpumask *mask;
>  
> +	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
> +	mask = housekeeping_cpumask(hk_flags);
>  	/* Wrap: we always want a cpu. */
> -	i %= num_online_cpus();
> +	i %= cpumask_weight(mask);
>  
>  	if (node == NUMA_NO_NODE) {
> -		for_each_cpu(cpu, cpu_online_mask)
> +		for_each_cpu(cpu, mask) {
>  			if (i-- == 0)
>  				return cpu;
> +		}
>  	} else {
>  		/* NUMA first. */
> -		for_each_cpu_and(cpu, cpumask_of_node(node), cpu_online_mask)
> +		for_each_cpu_and(cpu, cpumask_of_node(node), mask) {
>  			if (i-- == 0)
>  				return cpu;
> +		}
>  
> -		for_each_cpu(cpu, cpu_online_mask) {
> +		for_each_cpu(cpu, mask) {
>  			/* Skip NUMA nodes, done above. */
>  			if (cpumask_test_cpu(cpu, cpumask_of_node(node)))
>  				continue;

Are you aware of these changes to cpu_local_spread()?
https://lore.kernel.org/lkml/1582768688-2314-1-git-send-email-zhangshaokun@hisilicon.com/

I don't see a lot of overlap but it would be nice for you folks to
check each other's homework ;)


