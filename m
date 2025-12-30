Return-Path: <linux-pci+bounces-43867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28929CEABCA
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 22:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9039300FA28
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 21:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24DC20ADF8;
	Tue, 30 Dec 2025 21:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dN7f+XVW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5891A9F9B;
	Tue, 30 Dec 2025 21:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767131563; cv=none; b=HxNhzroD3tioCU9WQFdFl5BkUWjjoMF4zapA5XXMPpcKRYQ7E9wOH5wzULt96Y905xbJrZa+QRqI0lQR6CQgefnVi8K6Jde/Nm/O8I1mmzypjcH2oDlxZPD35v/Jo2eJQhEEwU8Ezl1r209nF5ZKdcbhCsVwEsK+qWs7NXtqP94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767131563; c=relaxed/simple;
	bh=/7f6UR2N0IR2rTtuD08nNkDqA6F6GrGJFsIGPavzqLs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PzKLI84P93xV0abi6HBY9pXxLmV/vVeStZBHwrSd2QzwFQoVB1UW4m5orfnOI3ZQI7bxGk/SvFTg4/pi9OEYZMn7w9GJ3e7OKTj8pY6jsTUyNKqawUPhQg9oqf+oquKvP2ZNZ/7oK/qLqSJ9S/iOVKJm6em5EZ0qGrFXtsOOQTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dN7f+XVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35EDC4CEFB;
	Tue, 30 Dec 2025 21:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767131563;
	bh=/7f6UR2N0IR2rTtuD08nNkDqA6F6GrGJFsIGPavzqLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dN7f+XVWDbmufdUebMlqB5LWFvg9eNUBW8SG08bWJpZns6I6bs0slrp/3t7v7zyjp
	 MZU9QIdShCigPzRtLQAw1S9LgkQnz8TscAdKmP42f61ati2FHuGNY56SlFuGfmuGOw
	 BNIJB59bpFEdb1CnM4u8fj7nj0jgLKlQ9ubmNwNOj0R7mT8brs2v3NW/gEVmOggeiI
	 KzVrMv/EQ5Rl8M7a2Ih9fv5jKKwzyl06nmA53bHz/jAigUvebiJMLLnRMWYejkAc1S
	 xPiqFvpFW56gRifNh0UMCV2rkvh92kzPfSQ1k6fsnCT5CjyEbPkA1kLglAiLzR3VPP
	 LyzFNtczmGgKg==
Date: Tue, 30 Dec 2025 15:52:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: tj@kernel.org, alexander.h.duyck@linux.intel.com, bhelgaas@google.com,
	bvanassche@acm.org, dan.j.williams@intel.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: Avoid work_on_cpu() in async probe workers
Message-ID: <20251230215241.GA130710@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251230142736.1168-1-guojinhui.liam@bytedance.com>

On Tue, Dec 30, 2025 at 10:27:36PM +0800, Jinhui Guo wrote:
> On Mon, Dec 29, 2025 at 08:08:57AM -1000, Tejun Heo wrote:
> > On Sat, Dec 27, 2025 at 07:33:26PM +0800, Jinhui Guo wrote:
> > > To fix the issue, pci_call_probe() must not call work_on_cpu() when it is
> > > already running inside an unbounded asynchronous worker. Because a driver
> > > can be probed asynchronously either by probe_type or by the kernel command
> > > line, we cannot rely on PROBE_PREFER_ASYNCHRONOUS alone. Instead, we test
> > > the PF_WQ_WORKER flag in current->flags; if it is set, pci_call_probe() is
> > > executing within an unbounded workqueue worker and should skip the extra
> > > work_on_cpu() call.
> > 
> > Why not just use queue_work_on() on system_dfl_wq (or any other unbound
> > workqueue)? Those are soft-affine to cache domain but can overflow to other
> > CPUs?
> 
> Hi, tejun,
> 
> Thank you for your time and helpful suggestions.
> I had considered replacing work_on_cpu() with queue_work_on(system_dfl_wq) +
> flush_work(), but that would be a refactor rather than a fix for the specific
> problem we hit.
> 
> Let me restate the issue:
> 
> 1. With PROBE_PREFER_ASYNCHRONOUS enabled, the driver core queues work on
>    async_wq to speed up driver probe.
> 2. The PCI core then calls work_on_cpu() to tie the probe thread to the PCI
>    device’s NUMA node, but it always picks the same CPU for every device on
>    that node, forcing the PCI probes to run serially.
> 
> Therefore I test current->flags & PF_WQ_WORKER to detect that we are already
> inside an async_wq worker and skip the extra nested work queue.
> 
> I agree with your point—using queue_work_on(system_dfl_wq) + flush_work()
> would be cleaner and would let different vendors’ drivers probe in parallel
> instead of fighting over the same CPU. I’ve prepared and tested another patch,
> but I’m still unsure it’s the better approach; any further suggestions would
> be greatly appreciated.
> 
> Test results for that patch:
>   nvme 0000:01:00.0: CPU: 2, COMM: kworker/u1025:3, probe cost: 34904955 ns
>   nvme 0000:02:00.0: CPU: 134, COMM: kworker/u1025:1, probe cost: 34774235 ns
>   nvme 0000:03:00.0: CPU: 1, COMM: kworker/u1025:4, probe cost: 34573054 ns
> 
> Key changes in the patch:
> 
> 1. Keep the current->flags & PF_WQ_WORKER test to avoid nested workers.
> 2. Replace work_on_cpu() with queue_work_node(system_dfl_wq) + flush_work()
>    to enable parallel probing when PROBE_PREFER_ASYNCHRONOUS is disabled.
> 3. Remove all cpumask operations.
> 4. Drop cpu_hotplug_disable() since both cpumask manipulation and work_on_cpu()
>    are gone.
> 
> The patch is shown below.

I love this patch because it makes pci_call_probe() so much simpler.

I *would* like a short higher-level description of the issue that
doesn't assume so much workqueue background.

I'm not an expert, but IIUC __driver_attach() schedules async workers
so driver probes can run in parallel, but the problem is that the
workers for devices on node X are currently serialized because they
all bind to the same CPU on that node.

Naive questions: It looks like async_schedule_dev() already schedules
an async worker on the device node, so why does pci_call_probe() need
to use queue_work_node() again?

pci_call_probe() dates to 2005 (d42c69972b85 ("[PATCH] PCI: Run PCI
driver initialization on local node")), but the async_schedule_dev()
looks like it was only added in 2019 (c37e20eaf4b2 ("driver core:
Attach devices on CPU local to device node")).  Maybe the
pci_call_probe() node awareness is no longer necessary?

> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 7c2d9d5962586..e66a67c48f28d 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -347,10 +347,24 @@ static bool pci_physfn_is_probed(struct pci_dev *dev)
>  #endif
>  }
> 
> +struct pci_probe_work {
> +    struct work_struct work;
> +    struct drv_dev_and_id ddi;
> +    int result;
> +};
> +
> +static void pci_probe_work_func(struct work_struct *work)
> +{
> +       struct pci_probe_work *pw = container_of(work, struct pci_probe_work, work);
> +
> +       pw->result = local_pci_probe(&pw->ddi);
> +}
> +
>  static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>                           const struct pci_device_id *id)
>  {
>         int error, node, cpu;
> +       struct pci_probe_work pw;
>         struct drv_dev_and_id ddi = { drv, dev, id };
> 
>         /*
> @@ -361,38 +375,25 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>         node = dev_to_node(&dev->dev);
>         dev->is_probed = 1;
> 
> -       cpu_hotplug_disable();
> -
>         /*
>          * Prevent nesting work_on_cpu() for the case where a Virtual Function
>          * device is probed from work_on_cpu() of the Physical device.
>          */
>         if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
> -           pci_physfn_is_probed(dev)) {
> -               cpu = nr_cpu_ids;
> -       } else {
> -               cpumask_var_t wq_domain_mask;
> -
> -               if (!zalloc_cpumask_var(&wq_domain_mask, GFP_KERNEL)) {
> -                       error = -ENOMEM;
> -                       goto out;
> -               }
> -               cpumask_and(wq_domain_mask,
> -                           housekeeping_cpumask(HK_TYPE_WQ),
> -                           housekeeping_cpumask(HK_TYPE_DOMAIN));
> -
> -               cpu = cpumask_any_and(cpumask_of_node(node),
> -                                     wq_domain_mask);
> -               free_cpumask_var(wq_domain_mask);
> +           pci_physfn_is_probed(dev) || (current->flags & PF_WQ_WORKER)) {
> +               error = local_pci_probe(&ddi);
> +               goto out;
>         }
> 
> -       if (cpu < nr_cpu_ids)
> -               error = work_on_cpu(cpu, local_pci_probe, &ddi);
> -       else
> -               error = local_pci_probe(&ddi);
> +       INIT_WORK_ONSTACK(&pw.work, pci_probe_work_func);
> +       pw.ddi = ddi;
> +       queue_work_node(node, system_dfl_wq, &pw.work);
> +       flush_work(&pw.work);
> +       error = pw.result;
> +       destroy_work_on_stack(&pw.work);
> +
>  out:
>         dev->is_probed = 0;
> -       cpu_hotplug_enable();
>         return error;
>  }
> 
> 
> Best Regards,
> Jinhui

