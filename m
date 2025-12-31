Return-Path: <linux-pci+bounces-43870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39190CEB79A
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 08:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA15A3009107
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 07:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABBB30F94E;
	Wed, 31 Dec 2025 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="i0cDoN0J"
X-Original-To: linux-pci@vger.kernel.org
Received: from sg-1-104.ptr.blmpb.com (sg-1-104.ptr.blmpb.com [118.26.132.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD17259C80
	for <linux-pci@vger.kernel.org>; Wed, 31 Dec 2025 07:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767167497; cv=none; b=fqxhysR3cHuaF5KuHfbjTS1R8TqRDJrVHLGtOX6CvPOhBZMCjl0mH/HT7a+oAboojR4vx68qXPmwtW+86jZ4O6kCKSMMHBsaqbFcuzMyKft95lx6k+U3vfndReI5O09uYbFWrZzgz0/aVa5Ck9zskJ1JSYxrfAlvoqOfU55rry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767167497; c=relaxed/simple;
	bh=5OhfQh94QrWrHPOEwimZhgVrzHBQO14VZlluCJQpk+4=;
	h=From:Date:Message-Id:In-Reply-To:Mime-Version:Content-Type:
	 References:To:Cc:Subject; b=oNnn0TElANAdtw4rs80EKwsd3jhr8zPu1qZVEV9dxj7mKc1qFaQkmYcB6H2/hyWvrzMPqL0HyVT4R8vXmSVGtHz+SXxGe/i8Qh2FE2S2i3sPJQ5ySxJrbUDmGpM5VqVoU0k39myv1rGaTsdLOirOeM+TOen/7o/Otrkq85tU4n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=i0cDoN0J; arc=none smtp.client-ip=118.26.132.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1767167487; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=XcspS1IKS8vFQcHe5Ltr51i0quFjOWyZrLSyAxS3hJs=;
 b=i0cDoN0JL1Il/Q6XcMWZJ/1iUhsiErysdUDkBYRBmsfimjNPu9lGK4+lxtdsagloG7Ajj2
 jcLhLDxEjiaHbc69zCissWCZ6OZRRfjV1VENQsI2XYQcGw7rYJrMwXkVebNBmSc6NY9KJy
 9ggvuTXneTCt1rOOMcjXITnV1fwZS1JedbvLW45qtRNao14M+NMxaHZqgaAUi1N4rRCA6o
 baU/Lh2WYzRYc9Q0tQdB2jWtm+e3Oo4s1EYqKTI8cyDEknQNNMggI2nmtBb09z9vJ9ro7T
 0okEXhPD5z0ta6+40W0qUFFBVl36p0rGvMW8syO3eLJTerj6k9a9CLvC1Kigow==
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Date: Wed, 31 Dec 2025 15:51:05 +0800
Message-Id: <20251231075105.1368-1-guojinhui.liam@bytedance.com>
In-Reply-To: <20251230215241.GA130710@bhelgaas>
X-Lms-Return-Path: <lba+26954d5fd+fdc0ff+vger.kernel.org+guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.17.1
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
References: <20251230215241.GA130710@bhelgaas>
To: <helgaas@kernel.org>
Cc: <alexander.h.duyck@linux.intel.com>, <bhelgaas@google.com>, 
	<bvanassche@acm.org>, <dan.j.williams@intel.com>, 
	<gregkh@linuxfoundation.org>, <guojinhui.liam@bytedance.com>, 
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, 
	<stable@vger.kernel.org>, <tj@kernel.org>
Subject: Re: [PATCH] PCI: Avoid work_on_cpu() in async probe workers

On Tue, Dec 30, 2025 at 03:52:41PM -0600, Bjorn Helgaas wrote:
> On Tue, Dec 30, 2025 at 10:27:36PM +0800, Jinhui Guo wrote:
> > On Mon, Dec 29, 2025 at 08:08:57AM -1000, Tejun Heo wrote:
> > > On Sat, Dec 27, 2025 at 07:33:26PM +0800, Jinhui Guo wrote:
> > > > To fix the issue, pci_call_probe() must not call work_on_cpu() when=
 it is
> > > > already running inside an unbounded asynchronous worker. Because a =
driver
> > > > can be probed asynchronously either by probe_type or by the kernel =
command
> > > > line, we cannot rely on PROBE_PREFER_ASYNCHRONOUS alone. Instead, w=
e test
> > > > the PF_WQ_WORKER flag in current->flags; if it is set, pci_call_pro=
be() is
> > > > executing within an unbounded workqueue worker and should skip the =
extra
> > > > work_on_cpu() call.
> > >=20
> > > Why not just use queue_work_on() on system_dfl_wq (or any other unbou=
nd
> > > workqueue)? Those are soft-affine to cache domain but can overflow to=
 other
> > > CPUs?
> >=20
> > Hi, tejun,
> >=20
> > Thank you for your time and helpful suggestions.
> > I had considered replacing work_on_cpu() with queue_work_on(system_dfl_=
wq) +
> > flush_work(), but that would be a refactor rather than a fix for the sp=
ecific
> > problem we hit.
> >=20
> > Let me restate the issue:
> >=20
> > 1. With PROBE_PREFER_ASYNCHRONOUS enabled, the driver core queues work =
on
> >    async_wq to speed up driver probe.
> > 2. The PCI core then calls work_on_cpu() to tie the probe thread to the=
 PCI
> >    device=E2=80=99s NUMA node, but it always picks the same CPU for eve=
ry device on
> >    that node, forcing the PCI probes to run serially.
> >=20
> > Therefore I test current->flags & PF_WQ_WORKER to detect that we are al=
ready
> > inside an async_wq worker and skip the extra nested work queue.
> >=20
> > I agree with your point=E2=80=94using queue_work_on(system_dfl_wq) + fl=
ush_work()
> > would be cleaner and would let different vendors=E2=80=99 drivers probe=
 in parallel
> > instead of fighting over the same CPU. I=E2=80=99ve prepared and tested=
 another patch,
> > but I=E2=80=99m still unsure it=E2=80=99s the better approach; any furt=
her suggestions would
> > be greatly appreciated.
> >=20
> > Test results for that patch:
> >   nvme 0000:01:00.0: CPU: 2, COMM: kworker/u1025:3, probe cost: 3490495=
5 ns
> >   nvme 0000:02:00.0: CPU: 134, COMM: kworker/u1025:1, probe cost: 34774=
235 ns
> >   nvme 0000:03:00.0: CPU: 1, COMM: kworker/u1025:4, probe cost: 3457305=
4 ns
> >=20
> > Key changes in the patch:
> >=20
> > 1. Keep the current->flags & PF_WQ_WORKER test to avoid nested workers.
> > 2. Replace work_on_cpu() with queue_work_node(system_dfl_wq) + flush_wo=
rk()
> >    to enable parallel probing when PROBE_PREFER_ASYNCHRONOUS is disable=
d.
> > 3. Remove all cpumask operations.
> > 4. Drop cpu_hotplug_disable() since both cpumask manipulation and work_=
on_cpu()
> >    are gone.
> >=20
> > The patch is shown below.
>=20
> I love this patch because it makes pci_call_probe() so much simpler.
>=20
> I *would* like a short higher-level description of the issue that
> doesn't assume so much workqueue background.
>=20
> I'm not an expert, but IIUC __driver_attach() schedules async workers
> so driver probes can run in parallel, but the problem is that the
> workers for devices on node X are currently serialized because they
> all bind to the same CPU on that node.
>=20
> Naive questions: It looks like async_schedule_dev() already schedules
> an async worker on the device node, so why does pci_call_probe() need
> to use queue_work_node() again?
>=20
> pci_call_probe() dates to 2005 (d42c69972b85 ("[PATCH] PCI: Run PCI
> driver initialization on local node")), but the async_schedule_dev()
> looks like it was only added in 2019 (c37e20eaf4b2 ("driver core:
> Attach devices on CPU local to device node")).  Maybe the
> pci_call_probe() node awareness is no longer necessary?

Hi, Bjorn

Thank you for your time and kind reply.

As I see it, two scenarios should be borne in mind:

1. Driver allowed to probe asynchronously
   The driver core schedules async workers via async_schedule_dev(),
   so pci_call_probe() needs no extra queue_work_node().

2. Driver not allowed to probe asynchronously
   The driver core (__driver_attach() or __device_attach()) calls
   pci_call_probe() directly, without any async worker from
   async_schedule_dev(). NUMA-node awareness in pci_call_probe()
   is therefore still required.

Best Regards,
Jinhui

