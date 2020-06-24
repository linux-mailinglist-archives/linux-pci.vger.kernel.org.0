Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3549A2072FD
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 14:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390115AbgFXMN5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 08:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389907AbgFXMN4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jun 2020 08:13:56 -0400
Received: from localhost (lfbn-ncy-1-996-218.w90-101.abo.wanadoo.fr [90.101.73.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C4C62088E;
        Wed, 24 Jun 2020 12:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593000836;
        bh=QzHyuz7ytmBCoTWY1f/kwZ7sJSq4u28blMy4Q4iNhwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+r1RPo8wq7doLhEr/5UAaZ2yaOtsIN0/OKMIDlyMRBj0DZi6BTccwXAHxBB5NyiY
         ueFwOdqbtlS2KSn4kzt3GyPFX57Or1hP9ncUqffw0uKjAYTAF2q/rrKXIScA2ndXb1
         GA0nLcaKL52VBPkG6Mb552Ct+WxPQsOVI2JWK5qo=
Date:   Wed, 24 Jun 2020 14:13:53 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mtosatti@redhat.com, juri.lelli@redhat.com, abelits@marvell.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, davem@davemloft.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com
Subject: Re: [Patch v3 1/3] lib: Restrict cpumask_local_spread to houskeeping
 CPUs
Message-ID: <20200624121352.GA28020@lenoir>
References: <20200623192331.215557-1-nitesh@redhat.com>
 <20200623192331.215557-2-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623192331.215557-2-nitesh@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 23, 2020 at 03:23:29PM -0400, Nitesh Narayan Lal wrote:
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
>  lib/cpumask.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index fb22fb266f93..d73104995981 100644
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

This should be HK_FLAG_MANAGED_IRQ instead of HK_FLAG_WQ since this
function seem to be used mostly to select CPUs to affine managed IRQs.
In the end the cpumask you pass to IRQ core will be filtered throughout
HK_FLAG_MANAGED_IRQ anyway so better select an appropriate one in the
first place to avoid an empty cpumask intersection.

Now even if cpumask_local_spread() is currently mostly used to select
managed irq targets, the name and role of the function don't refer to that.
Probably cpumask_local_spread() should take HK_ flag in parameter so that
it can correctly handle future users?

That being said, I plan to merge HK_FLAG_RCU, HK_FLAG_MISC, HK_FLAG_SCHED,
HK_FLAG_WQ and HK_FLAG_TIMER into HK_FLAG_UNBOUND since it doesn't make sense
to divide them all. And the actual flag used inside cpumask_local_spread()
could end up being HK_FLAG_DOMAIN | HK_FLAG_UNBOUND. So probably you don't
need to worry about that and just change the HK_FLAG_WQ in your patch
with HK_FLAG_MANAGED_IRQ.

Thanks.
