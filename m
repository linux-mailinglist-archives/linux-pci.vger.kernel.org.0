Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C591FC23D
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 01:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgFPXWV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 19:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFPXWV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 19:22:21 -0400
Received: from localhost (lfbn-ncy-1-150-120.w83-194.abo.wanadoo.fr [83.194.232.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A257207E8;
        Tue, 16 Jun 2020 23:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592349740;
        bh=Q7XqjDbI5KF1xwlA2pFU0ud6lF4J0reUpw77Uk5OM0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZdGbq74tHPXO2Wt0cZq0o8vUmOKQNSUEuni9CHU3QPzO3yTtxrQQYLUdvmof/fKqd
         8U6SDr9+WOFs8po3lanJsWlgt0Ov5uAC3U86UrsDUx86uzJNhHMkmdJODhfvy+kHkX
         0TsL4eAqVwaiiyjeoT3SS8/1ysm8ksYEaq4ZCLfw=
Date:   Wed, 17 Jun 2020 01:22:18 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mtosatti@redhat.com, juri.lelli@redhat.com, abelits@marvell.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Subject: Re: [Patch v1 2/3] PCI: prevent work_on_cpu's probe to execute on
 isolated CPUs
Message-ID: <20200616232217.GB4914@lenoir>
References: <20200610161226.424337-1-nitesh@redhat.com>
 <20200610161226.424337-3-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610161226.424337-3-nitesh@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 10, 2020 at 12:12:25PM -0400, Nitesh Narayan Lal wrote:
> From: Alex Belits <abelits@marvell.com>
> 
> pci_call_probe() prevents the nesting of work_on_cpu()
> for a scenario where a VF device is probed from work_on_cpu()
> of the Physical device.
> This patch replaces the cpumask used in pci_call_probe()
> from all online CPUs to only housekeeping CPUs. This is to
> ensure that there are no additional latency overheads
> caused due to the pinning of jobs on isolated CPUs.
> 
> Signed-off-by: Alex Belits <abelits@marvell.com>
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> ---
>  drivers/pci/pci-driver.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index da6510af1221..449466f71040 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -12,6 +12,7 @@
>  #include <linux/string.h>
>  #include <linux/slab.h>
>  #include <linux/sched.h>
> +#include <linux/sched/isolation.h>
>  #include <linux/cpu.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/suspend.h>
> @@ -333,6 +334,7 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>  			  const struct pci_device_id *id)
>  {
>  	int error, node, cpu;
> +	int hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
>  	struct drv_dev_and_id ddi = { drv, dev, id };
>  
>  	/*
> @@ -353,7 +355,8 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>  	    pci_physfn_is_probed(dev))
>  		cpu = nr_cpu_ids;
>  	else
> -		cpu = cpumask_any_and(cpumask_of_node(node), cpu_online_mask);
> +		cpu = cpumask_any_and(cpumask_of_node(node),
> +				      housekeeping_cpumask(hk_flags));

Looks like cpumask_of_node() is based on online CPUs. So that all
looks good. Thanks!

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


>  
>  	if (cpu < nr_cpu_ids)
>  		error = work_on_cpu(cpu, local_pci_probe, &ddi);
> -- 
> 2.18.4
> 
