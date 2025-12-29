Return-Path: <linux-pci+bounces-43809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E4ACE7B8A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 18:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50172300E802
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5179821ADC7;
	Mon, 29 Dec 2025 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRL59e45"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2061B1F0E34;
	Mon, 29 Dec 2025 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767028803; cv=none; b=UM80iEdDseufW/9hHHs2L824FWQhpeL4C+2gvdc61nGXSvPjERLRobrWprtWxXm+FDq7UOJcaDT7H0lvRz4URICrFU10p/G3RAtxob/JhTFiXEU6KM56IoqIlu2c9lPkai96K1kyTSiagSnDK4kzd96ZEOuIXw/4un57IFDs/0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767028803; c=relaxed/simple;
	bh=BxTF7nZPk3oh2iy+meMqMvGwotcyCmURmLiq1LPEaD8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a8i8jJ2cZzaji3judeRmc7KgzUWzfgJJG+5HTRV4D9DtvPDKgzkz2PH6NRTWJSOEGC3TmaRjFLVLwmtZYgmi7nFtMEsbZIrxgh+/ZFK06f99Qq0ceyic8GOIyx86AANLIPJ73HE6S0LxVraiHGqTLHtqCT0UBH2RVXF7wf1+RpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRL59e45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECD4C4CEF7;
	Mon, 29 Dec 2025 17:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767028801;
	bh=BxTF7nZPk3oh2iy+meMqMvGwotcyCmURmLiq1LPEaD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WRL59e454aVAMzodwhgO7RjO3HmVy7avtiByjJDH95JRMY2aD4JLuv8B0UTThsvkx
	 dbAi/O1LZb1DyGpdVJSjdgm9/zRfHyxEtXA83NtmUhGddBEP5HZWXPokNWVnhInbYp
	 DVjm5drDksVlIaqqCvB04aoExQjRAmTEsVigKiTF4duD3M4nNTP4ZpS/tVPkPsUZaU
	 s1k9YfOZZglUmEpjorutVMGCQBmK8nC2xyN3GkZ2G5pT5koUOlWxVcqHvz4JGBN3qM
	 licsQB8TOxO9q40zw6gjF76J/VK4fad48DRzG0Tp9ipdtGqv2SyhVBjD/9s21kcGGw
	 5Y+jAAB7GqeEg==
Date: Mon, 29 Dec 2025 11:20:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: bhelgaas@google.com, bvanassche@acm.org, dan.j.williams@intel.com,
	alexander.h.duyck@linux.intel.com, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Marco Crivellari <marco.crivellari@suse.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] PCI: Avoid work_on_cpu() in async probe workers
Message-ID: <20251229172000.GA68570@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251227113326.964-1-guojinhui.liam@bytedance.com>

[+cc Marco, Tejun; just FYI since you have ongoing per-CPU wq work]

On Sat, Dec 27, 2025 at 07:33:26PM +0800, Jinhui Guo wrote:
> Commit ef0ff68351be ("driver core: Probe devices asynchronously instead of
> the driver") speeds up the loading of large numbers of device drivers by
> submitting asynchronous probe workers to an unbounded workqueue and binding
> each worker to the CPU near the device’s NUMA node. These workers are not
> scheduled on isolated CPUs because their cpumask is restricted to
> housekeeping_cpumask(HK_TYPE_WQ) and housekeeping_cpumask(HK_TYPE_DOMAIN).
> 
> However, when PCI devices reside on the same NUMA node, all their
> drivers’ probe workers are bound to the same CPU within that node, yet
> the probes still run in parallel because pci_call_probe() invokes
> work_on_cpu(). Introduced by commit 873392ca514f ("PCI: work_on_cpu: use
> in drivers/pci/pci-driver.c"), work_on_cpu() queues a worker on
> system_percpu_wq to bind the probe thread to the first CPU in the
> device’s NUMA node (chosen via cpumask_any_and() in pci_call_probe()).
> 
> 1. The function __driver_attach() submits an asynchronous worker with
>    callback __driver_attach_async_helper().
> 
>    __driver_attach()
>     async_schedule_dev(__driver_attach_async_helper, dev)
>      async_schedule_node(func, dev, dev_to_node(dev))
>       async_schedule_node_domain(func, data, node, &async_dfl_domain)
>        __async_schedule_node_domain(func, data, node, domain, entry)
>         queue_work_node(node, async_wq, &entry->work)
> 
> 2. The asynchronous probe worker ultimately calls work_on_cpu() in
>    pci_call_probe(), binding the worker to the same CPU within the
>    device’s NUMA node.
> 
>    __driver_attach_async_helper()
>     driver_probe_device(drv, dev)
>      __driver_probe_device(drv, dev)
>       really_probe(dev, drv)
>        call_driver_probe(dev, drv)
>         dev->bus->probe(dev)
>          pci_device_probe(dev)
>           __pci_device_probe(drv, pci_dev)
>            pci_call_probe(drv, pci_dev, id)
>             cpu = cpumask_any_and(cpumask_of_node(node), wq_domain_mask)
>             error = work_on_cpu(cpu, local_pci_probe, &ddi)
>              schedule_work_on(cpu, &wfc.work);
>               queue_work_on(cpu, system_percpu_wq, work)
> 
> To fix the issue, pci_call_probe() must not call work_on_cpu() when it is
> already running inside an unbounded asynchronous worker. Because a driver
> can be probed asynchronously either by probe_type or by the kernel command
> line, we cannot rely on PROBE_PREFER_ASYNCHRONOUS alone. Instead, we test
> the PF_WQ_WORKER flag in current->flags; if it is set, pci_call_probe() is
> executing within an unbounded workqueue worker and should skip the extra
> work_on_cpu() call.
> 
> Testing three NVMe devices on the same NUMA node of an AMD EPYC 9A64
> 2.4 GHz processor shows a 35 % probe-time improvement with the patch:
> 
> Before (all on CPU 0):
>   nvme 0000:01:00.0: CPU: 0, COMM: kworker/0:1, probe cost: 53372612 ns
>   nvme 0000:02:00.0: CPU: 0, COMM: kworker/0:2, probe cost: 49532941 ns
>   nvme 0000:03:00.0: CPU: 0, COMM: kworker/0:3, probe cost: 47315175 ns
> 
> After (spread across CPUs 1, 2, 5):
>   nvme 0000:01:00.0: CPU: 5, COMM: kworker/u1025:5, probe cost: 34765890 ns
>   nvme 0000:02:00.0: CPU: 1, COMM: kworker/u1025:2, probe cost: 34696433 ns
>   nvme 0000:03:00.0: CPU: 2, COMM: kworker/u1025:3, probe cost: 33233323 ns
> 
> The improvement grows with more PCI devices because fewer probes contend
> for the same CPU.
> 
> Fixes: ef0ff68351be ("driver core: Probe devices asynchronously instead of the driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---
>  drivers/pci/pci-driver.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 7c2d9d596258..4bc47a84d330 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -366,9 +366,11 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>  	/*
>  	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
>  	 * device is probed from work_on_cpu() of the Physical device.
> +	 * Check PF_WQ_WORKER to prevent invoking work_on_cpu() in an asynchronous
> +	 * probe worker when the driver allows asynchronous probing.
>  	 */
>  	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
> -	    pci_physfn_is_probed(dev)) {
> +	    pci_physfn_is_probed(dev) || (current->flags & PF_WQ_WORKER)) {
>  		cpu = nr_cpu_ids;
>  	} else {
>  		cpumask_var_t wq_domain_mask;
> -- 
> 2.20.1

