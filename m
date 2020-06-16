Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2118E1FBFB5
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 22:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgFPUFw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 16:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbgFPUFw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 16:05:52 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8410208B3;
        Tue, 16 Jun 2020 20:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592337952;
        bh=9S2l7F1bJLuoWduI/Oax+k4EarI3OHINr4Tj9mZDTh4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CUS/ORZplp+jgX29dZTDOoF6PiKCnPuGsSd+bWgZfVCW4LxzpyoJ0P877fMuf1jM/
         3jiT/99zbk9Z1n0wx1uoDpjOR7Eqst7K4YAAjt17ofPAS6BecitS1kk6Ik4WajzSZv
         2khhiUurye85ZDXpUUJRwzq9/vpE/RZisXaA5OxQ=
Date:   Tue, 16 Jun 2020 15:05:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de
Subject: Re: [Patch v1 2/3] PCI: prevent work_on_cpu's probe to execute on
 isolated CPUs
Message-ID: <20200616200550.GA1977307@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610161226.424337-3-nitesh@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"git log --oneline drivers/pci/pci-driver.c" tells you that the
subject should be something like:

  PCI: Restrict probe functions to housekeeping CPUs

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

s/Physical/PF/ (since you used "VF" earlier, this should match that)

s/This patch replaces/Replace the/

Please rewrap this to fill a 75 column line (so it doesn't overflow 80
columns when "git log" adds 4 spaces).

This should be two paragraphs; add a blank line between them.

> Signed-off-by: Alex Belits <abelits@marvell.com>
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

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
>  
>  	if (cpu < nr_cpu_ids)
>  		error = work_on_cpu(cpu, local_pci_probe, &ddi);
> -- 
> 2.18.4
> 
