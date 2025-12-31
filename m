Return-Path: <linux-pci+bounces-43885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16356CEC4C3
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 17:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6731300647E
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 16:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C77288505;
	Wed, 31 Dec 2025 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oagiJKLh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDBB28DB56;
	Wed, 31 Dec 2025 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767200105; cv=none; b=RH7x66rsrlmpX3tSEih/08cJz5asplSQ2p2yQYCF/r2Ow23mZe3xBz8S3y1emxm68HrO4ONzgnPfmo2rNT6t/Fd8vSIhsw1JNG6qmQWoUlVBZdq/oDL57SmBwvNttzOUtnBGupMPqd/zBNS8mc5DgkRiek9tTlb/nwzxUunIfSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767200105; c=relaxed/simple;
	bh=Y/5bf9h/NUrC5vUtyqz8GPzz/c0/aicl4xD+7PciqPc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ElcrwmIO1/ai/b52P9CTHw8spr/A4x/4Ir53GVgPnr0Ef6ejzTJe8oC9jo7L6OPJjTNM8aJ+DNBBMhnQJj4qdu4EDCIgo86OwApRASUHQomAYJqcz4d7GXueRVuPB9SsVvAFhaSHxvQIPC2R/zEnKIbtuXe7xpupT8tTXdCyOg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oagiJKLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3D0C113D0;
	Wed, 31 Dec 2025 16:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767200104;
	bh=Y/5bf9h/NUrC5vUtyqz8GPzz/c0/aicl4xD+7PciqPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oagiJKLhkxpnlRIWxJcrRtAo95NONHHB9nfMbLclU0sMm8g0eKfTjCvM8oYD6/J1T
	 UmLQDM0EvUDieGgI3S4q5f4KfLWkMI8pPUMins/Zy8tiW/D27m5XWk5S8ssmMahfVA
	 rTDdzfyMRZ72tNxlKbebnbRPW9x7R0Tp5agDjMLt5TywuhWrJbCznWdWeeSf6IHEOk
	 aKB+WGKI1IM0ktTXUfuNMhfPQwVValcVrLUGDAD/RtcX0lVjagoqo2gqHTZxq2Crn+
	 BfTdRAG1zIoIPNV5lnmCsdB/FnXjrKAToIqOS7vVj9dU8uV3yR+SIAAMoXlFPqi3nw
	 ufbmYZgk1qtsg==
Date: Wed, 31 Dec 2025 10:55:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: alexander.h.duyck@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PCI: Avoid work_on_cpu() in async probe workers
Message-ID: <20251231165503.GA159243@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251231075105.1368-1-guojinhui.liam@bytedance.com>

[+cc Rafael, Danilo (driver core question), update Alexander's email]

On Wed, Dec 31, 2025 at 03:51:05PM +0800, Jinhui Guo wrote:
> On Tue, Dec 30, 2025 at 03:52:41PM -0600, Bjorn Helgaas wrote:
> > On Tue, Dec 30, 2025 at 10:27:36PM +0800, Jinhui Guo wrote:
> > > On Mon, Dec 29, 2025 at 08:08:57AM -1000, Tejun Heo wrote:
> > > > On Sat, Dec 27, 2025 at 07:33:26PM +0800, Jinhui Guo wrote:
> > > > > To fix the issue, pci_call_probe() must not call work_on_cpu() when it is
> > > > > already running inside an unbounded asynchronous worker. Because a driver
> > > > > can be probed asynchronously either by probe_type or by the kernel command
> > > > > line, we cannot rely on PROBE_PREFER_ASYNCHRONOUS alone. Instead, we test
> > > > > the PF_WQ_WORKER flag in current->flags; if it is set, pci_call_probe() is
> > > > > executing within an unbounded workqueue worker and should skip the extra
> > > > > work_on_cpu() call.
> > > > 
> > > > Why not just use queue_work_on() on system_dfl_wq (or any other unbound
> > > > workqueue)? Those are soft-affine to cache domain but can overflow to other
> > > > CPUs?
> > > 
> > > Hi, tejun,
> > > 
> > > Thank you for your time and helpful suggestions.
> > > I had considered replacing work_on_cpu() with queue_work_on(system_dfl_wq) +
> > > flush_work(), but that would be a refactor rather than a fix for the specific
> > > problem we hit.
> > > 
> > > Let me restate the issue:
> > > 
> > > 1. With PROBE_PREFER_ASYNCHRONOUS enabled, the driver core queues work on
> > >    async_wq to speed up driver probe.
> > > 2. The PCI core then calls work_on_cpu() to tie the probe thread to the PCI
> > >    device’s NUMA node, but it always picks the same CPU for every device on
> > >    that node, forcing the PCI probes to run serially.
> > > 
> > > Therefore I test current->flags & PF_WQ_WORKER to detect that we are already
> > > inside an async_wq worker and skip the extra nested work queue.
> > > 
> > > I agree with your point—using queue_work_on(system_dfl_wq) + flush_work()
> > > would be cleaner and would let different vendors’ drivers probe in parallel
> > > instead of fighting over the same CPU. I’ve prepared and tested another patch,
> > > but I’m still unsure it’s the better approach; any further suggestions would
> > > be greatly appreciated.
> > > 
> > > Test results for that patch:
> > >   nvme 0000:01:00.0: CPU: 2, COMM: kworker/u1025:3, probe cost: 34904955 ns
> > >   nvme 0000:02:00.0: CPU: 134, COMM: kworker/u1025:1, probe cost: 34774235 ns
> > >   nvme 0000:03:00.0: CPU: 1, COMM: kworker/u1025:4, probe cost: 34573054 ns
> > > 
> > > Key changes in the patch:
> > > 
> > > 1. Keep the current->flags & PF_WQ_WORKER test to avoid nested workers.
> > > 2. Replace work_on_cpu() with queue_work_node(system_dfl_wq) + flush_work()
> > >    to enable parallel probing when PROBE_PREFER_ASYNCHRONOUS is disabled.
> > > 3. Remove all cpumask operations.
> > > 4. Drop cpu_hotplug_disable() since both cpumask manipulation and work_on_cpu()
> > >    are gone.
> > > 
> > > The patch is shown below.
> > 
> > I love this patch because it makes pci_call_probe() so much simpler.
> > 
> > I *would* like a short higher-level description of the issue that
> > doesn't assume so much workqueue background.
> > 
> > I'm not an expert, but IIUC __driver_attach() schedules async workers
> > so driver probes can run in parallel, but the problem is that the
> > workers for devices on node X are currently serialized because they
> > all bind to the same CPU on that node.
> > 
> > Naive questions: It looks like async_schedule_dev() already schedules
> > an async worker on the device node, so why does pci_call_probe() need
> > to use queue_work_node() again?
> > 
> > pci_call_probe() dates to 2005 (d42c69972b85 ("[PATCH] PCI: Run PCI
> > driver initialization on local node")), but the async_schedule_dev()
> > looks like it was only added in 2019 (c37e20eaf4b2 ("driver core:
> > Attach devices on CPU local to device node")).  Maybe the
> > pci_call_probe() node awareness is no longer necessary?
> 
> Hi, Bjorn
> 
> Thank you for your time and kind reply.
> 
> As I see it, two scenarios should be borne in mind:
> 
> 1. Driver allowed to probe asynchronously
>    The driver core schedules async workers via async_schedule_dev(),
>    so pci_call_probe() needs no extra queue_work_node().
> 
> 2. Driver not allowed to probe asynchronously
>    The driver core (__driver_attach() or __device_attach()) calls
>    pci_call_probe() directly, without any async worker from
>    async_schedule_dev(). NUMA-node awareness in pci_call_probe()
>    is therefore still required.

Good point, we need the NUMA awareness in both sync and async probe
paths.

But node affinity is orthogonal to the sync/async question, so it
seems weird to deal with affinity in two separate places.  It also
seems sub-optimal to have node affinity in the driver core async path
but not the synchronous probe path.

Maybe driver_probe_device() should do something about NUMA affinity?

Bjorn

