Return-Path: <linux-pci+bounces-43761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 931BBCDF90C
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 12:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F41813009489
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 11:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED891313526;
	Sat, 27 Dec 2025 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ADqDne/d"
X-Original-To: linux-pci@vger.kernel.org
Received: from sg-1-104.ptr.blmpb.com (sg-1-104.ptr.blmpb.com [118.26.132.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C424113D
	for <linux-pci@vger.kernel.org>; Sat, 27 Dec 2025 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766835259; cv=none; b=riWGrU6HQTn2IVZ33PrxdIYKKknAH5mMGKQV3udlMWbEqi0qA5kIswoXzeIMBPkULuwJp6wdXkYIOQvtAZzeeKbOm7hwybm9lgjBxw4KvDwe7rCqpZtLzwj55+v9A+Izi+7Rc34CVa7G378MxaOAPCjElyxLwvKmSwcik3/SDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766835259; c=relaxed/simple;
	bh=BuIMaNT+UI0KsqsbHtmd0bHo46Jp/KXJIvwHEITBcSs=;
	h=Message-Id:Mime-Version:To:Cc:From:Subject:Date:Content-Type; b=GVQrDovu7F45/6XoJ8P4KKhwn3HvbbDDY4vKcbFE5KMh6qwd4dOuazFD+sdJxV/PvU24oWw0B8EHi2ZbDwQVGD9thFoGc1M3pox/pvoLGQy2vkwAR+ozBWnGVxiRFEeOgXZbPO+QJpD0v5swV7wlHjRjj4+gQCI843I4wJ0xlr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ADqDne/d; arc=none smtp.client-ip=118.26.132.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1766835243; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=zpBY2sbAf3ugjQp1+eDZumXA4vCMZxwygzISFCEom34=;
 b=ADqDne/dNqiQY/oKhsg8YHEli8etR5VzSQZGOBquF+f2yUFiTBCHWxhwKKCskgBk/yKR4c
 YTfbIMaC9+5E/vK3v6saXGxWJz1BRv+4iRePamQBgWx6vdvqUgMU4PP5fqwcUvtSqyYT3l
 4IP8GPsin8B9UWDxDWr2XVdW2d3An5xbNS7ztzuxIpSGA49MvF+CKpIvOmwgdnhsBnuhUU
 JHk0WeHxCq3bwaUxitcPrySe1KUw1uFEXovrHF6wNwIlGrPjntL4rDIHhrf0Pp1HNLrXhb
 4ft1rNFmxsGscujhNi6rdIV8CbE25lIj9rTcPtSwSpce2lo4tuMQk90mtvPlmw==
X-Mailer: git-send-email 2.17.1
Message-Id: <20251227113326.964-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+2694fc42a+856ee0+vger.kernel.org+guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: quoted-printable
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: <bhelgaas@google.com>, <bvanassche@acm.org>, <dan.j.williams@intel.com>, 
	<alexander.h.duyck@linux.intel.com>, <gregkh@linuxfoundation.org>
Cc: <guojinhui.liam@bytedance.com>, <linux-pci@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Subject: [PATCH] PCI: Avoid work_on_cpu() in async probe workers
Date: Sat, 27 Dec 2025 19:33:26 +0800
Content-Type: text/plain; charset=UTF-8

Commit ef0ff68351be ("driver core: Probe devices asynchronously instead of
the driver") speeds up the loading of large numbers of device drivers by
submitting asynchronous probe workers to an unbounded workqueue and binding
each worker to the CPU near the device=E2=80=99s NUMA node. These workers a=
re not
scheduled on isolated CPUs because their cpumask is restricted to
housekeeping_cpumask(HK_TYPE_WQ) and housekeeping_cpumask(HK_TYPE_DOMAIN).

However, when PCI devices reside on the same NUMA node, all their
drivers=E2=80=99 probe workers are bound to the same CPU within that node, =
yet
the probes still run in parallel because pci_call_probe() invokes
work_on_cpu(). Introduced by commit 873392ca514f ("PCI: work_on_cpu: use
in drivers/pci/pci-driver.c"), work_on_cpu() queues a worker on
system_percpu_wq to bind the probe thread to the first CPU in the
device=E2=80=99s NUMA node (chosen via cpumask_any_and() in pci_call_probe(=
)).

1. The function __driver_attach() submits an asynchronous worker with
   callback __driver_attach_async_helper().

   __driver_attach()
    async_schedule_dev(__driver_attach_async_helper, dev)
     async_schedule_node(func, dev, dev_to_node(dev))
      async_schedule_node_domain(func, data, node, &async_dfl_domain)
       __async_schedule_node_domain(func, data, node, domain, entry)
        queue_work_node(node, async_wq, &entry->work)

2. The asynchronous probe worker ultimately calls work_on_cpu() in
   pci_call_probe(), binding the worker to the same CPU within the
   device=E2=80=99s NUMA node.

   __driver_attach_async_helper()
    driver_probe_device(drv, dev)
     __driver_probe_device(drv, dev)
      really_probe(dev, drv)
       call_driver_probe(dev, drv)
        dev->bus->probe(dev)
         pci_device_probe(dev)
          __pci_device_probe(drv, pci_dev)
           pci_call_probe(drv, pci_dev, id)
            cpu =3D cpumask_any_and(cpumask_of_node(node), wq_domain_mask)
            error =3D work_on_cpu(cpu, local_pci_probe, &ddi)
             schedule_work_on(cpu, &wfc.work);
              queue_work_on(cpu, system_percpu_wq, work)

To fix the issue, pci_call_probe() must not call work_on_cpu() when it is
already running inside an unbounded asynchronous worker. Because a driver
can be probed asynchronously either by probe_type or by the kernel command
line, we cannot rely on PROBE_PREFER_ASYNCHRONOUS alone. Instead, we test
the PF_WQ_WORKER flag in current->flags; if it is set, pci_call_probe() is
executing within an unbounded workqueue worker and should skip the extra
work_on_cpu() call.

Testing three NVMe devices on the same NUMA node of an AMD EPYC 9A64
2.4 GHz processor shows a 35 % probe-time improvement with the patch:

Before (all on CPU 0):
  nvme 0000:01:00.0: CPU: 0, COMM: kworker/0:1, probe cost: 53372612 ns
  nvme 0000:02:00.0: CPU: 0, COMM: kworker/0:2, probe cost: 49532941 ns
  nvme 0000:03:00.0: CPU: 0, COMM: kworker/0:3, probe cost: 47315175 ns

After (spread across CPUs 1, 2, 5):
  nvme 0000:01:00.0: CPU: 5, COMM: kworker/u1025:5, probe cost: 34765890 ns
  nvme 0000:02:00.0: CPU: 1, COMM: kworker/u1025:2, probe cost: 34696433 ns
  nvme 0000:03:00.0: CPU: 2, COMM: kworker/u1025:3, probe cost: 33233323 ns

The improvement grows with more PCI devices because fewer probes contend
for the same CPU.

Fixes: ef0ff68351be ("driver core: Probe devices asynchronously instead of =
the driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/pci/pci-driver.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 7c2d9d596258..4bc47a84d330 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -366,9 +366,11 @@ static int pci_call_probe(struct pci_driver *drv, stru=
ct pci_dev *dev,
 	/*
 	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
 	 * device is probed from work_on_cpu() of the Physical device.
+	 * Check PF_WQ_WORKER to prevent invoking work_on_cpu() in an asynchronou=
s
+	 * probe worker when the driver allows asynchronous probing.
 	 */
 	if (node < 0 || node >=3D MAX_NUMNODES || !node_online(node) ||
-	    pci_physfn_is_probed(dev)) {
+	    pci_physfn_is_probed(dev) || (current->flags & PF_WQ_WORKER)) {
 		cpu =3D nr_cpu_ids;
 	} else {
 		cpumask_var_t wq_domain_mask;
--=20
2.20.1

