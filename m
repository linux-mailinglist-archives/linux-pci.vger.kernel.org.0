Return-Path: <linux-pci+bounces-44213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D334CFF962
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 19:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F705317989F
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 18:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B141318BB6;
	Wed,  7 Jan 2026 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UBDUJGEQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from va-2-114.ptr.blmpb.com (va-2-114.ptr.blmpb.com [209.127.231.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE53C1ADC97
	for <linux-pci@vger.kernel.org>; Wed,  7 Jan 2026 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767809405; cv=none; b=rkEfL6vJ+LxgvoFNL7QYniemcxZd2TqilMhroMU2lIwMtNKtibACgLZWdLxa/k9jw0g96uU+mxXZgFDYKl4sDbqkkJ4DzsNHpydvZD9tvIxdtmKvZheaFntbCjV7mCxqWTldgpUs6gshMb0nE4DhQNR+CwHs2KwGH1nawb7/ISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767809405; c=relaxed/simple;
	bh=euUvQ4Y+m1NwcCGrMBJ1nu9fJDEqdhilEPh8Wmv5G3M=;
	h=Cc:Date:Subject:References:In-Reply-To:Mime-Version:To:From:
	 Message-Id:Content-Type; b=ee4F8dkHSDIffZeTpK4B/FCas+UAkxY4aAjtD2CrrPZqJHnkCZcFEmrQht8F0qtNZFGE8GnF8Jb4+bdgyzKbIUVJ5NzOYKUqvw/o+Eeh1VXBg8l+NVJr36PXa4ecpczu4YBQT+keEOlG6o3I9IqL3DcgiyjMBJ/aC4xbuAFJAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UBDUJGEQ; arc=none smtp.client-ip=209.127.231.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1767808672; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=tHAaPhycBRyZtfkz6/mgLYSwAX3tMag4G7w4Obd7jlY=;
 b=UBDUJGEQktMPWyxx/H1uRnRjCJKfDhb4AnLTNuAU7sAued9Bg8tm4g620Tb/6w/14igY1V
 CUn3GoR1JRWUq5oK3kNpEesvght9S0BkM/60yENr3Dnb95TROygXxgA8kfa4oYK9nXDu3X
 V3t1IRPptFYqC9NLqz1sMUi6vP5E+UWCtMhGZQGeng8vViNlQfNYhR7fbDSBjLh0BIgh4g
 IArWT3lpdZyXZP1fFB7I9s3YoBKleYSW0E9BXPdw67qaUA4aqFuDAlDzpmUJRhlki3exXC
 T3AqQfht/Ke5Yj9oH3sCtPB/j04a1m4Nf72z+hJl6tcOG8vZ9qM4nvnNg3zgFg==
Cc: <guojinhui.liam@bytedance.com>, <linux-kernel@vger.kernel.org>, 
	<linux-pci@vger.kernel.org>
Date: Thu,  8 Jan 2026 01:55:48 +0800
Subject: [PATCH 3/3] PCI: Clean up NUMA-node awareness in pci_bus_type probe
References: <20260107175548.1792-1-guojinhui.liam@bytedance.com>
In-Reply-To: <20260107175548.1792-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
X-Lms-Return-Path: <lba+2695e9e9e+522cb4+vger.kernel.org+guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: 7bit
To: <dakr@kernel.org>, <alexander.h.duyck@linux.intel.com>, 
	<alexanderduyck@fb.com>, <bhelgaas@google.com>, <bvanassche@acm.org>, 
	<dan.j.williams@intel.com>, <gregkh@linuxfoundation.org>, 
	<helgaas@kernel.org>, <rafael@kernel.org>, <tj@kernel.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Message-Id: <20260107175548.1792-4-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8

With NUMA-node-aware probing now handled by the driver core,
the equivalent code in the PCI driver is redundant and can
be removed.

Dropping it speeds up asynchronous probe by 35%; the gain
comes from eliminating the work_on_cpu() call in pci_call_probe()
that previously pinned every worker to the same CPU, forcing
serial probe of devices on the same NUMA node.

Testing three NVMe devices on the same NUMA node of an AMD
EPYC 9A64 2.4 GHz processor shows a 35% probe-time improvement
with the patch:

Before (all on CPU 0):
  nvme 0000:01:00.0: CPU: 0, COMM: kworker/0:1, cost: 52266334ns
  nvme 0000:02:00.0: CPU: 0, COMM: kworker/0:0, cost: 50787194ns
  nvme 0000:03:00.0: CPU: 0, COMM: kworker/0:2, cost: 50541584ns

After (spread across CPUs 1, 2, 4):
  nvme 0000:01:00.0: CPU: 1, COMM: kworker/u1025:2, cost: 35399608ns
  nvme 0000:02:00.0: CPU: 2, COMM: kworker/u1025:3, cost: 35156157ns
  nvme 0000:03:00.0: CPU: 4, COMM: kworker/u1025:0, cost: 35322116ns

The improvement grows with more PCI devices because fewer probes
contend for the same CPU.

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/pci/pci-driver.c | 83 ++++------------------------------------
 include/linux/pci.h      |  1 -
 2 files changed, 8 insertions(+), 76 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 7c2d9d596258..683bc682e750 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -296,18 +296,9 @@ static struct attribute *pci_drv_attrs[] = {
 };
 ATTRIBUTE_GROUPS(pci_drv);
 
-struct drv_dev_and_id {
-	struct pci_driver *drv;
-	struct pci_dev *dev;
-	const struct pci_device_id *id;
-};
-
-static long local_pci_probe(void *_ddi)
+static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
+			  const struct pci_device_id *id)
 {
-	struct drv_dev_and_id *ddi = _ddi;
-	struct pci_dev *pci_dev = ddi->dev;
-	struct pci_driver *pci_drv = ddi->drv;
-	struct device *dev = &pci_dev->dev;
 	int rc;
 
 	/*
@@ -319,83 +310,25 @@ static long local_pci_probe(void *_ddi)
 	 * count, in its probe routine and pm_runtime_get_noresume() in
 	 * its remove routine.
 	 */
-	pm_runtime_get_sync(dev);
-	pci_dev->driver = pci_drv;
-	rc = pci_drv->probe(pci_dev, ddi->id);
+	pm_runtime_get_sync(&dev->dev);
+	dev->driver = drv;
+	rc = drv->probe(dev, id);
 	if (!rc)
 		return rc;
 	if (rc < 0) {
-		pci_dev->driver = NULL;
-		pm_runtime_put_sync(dev);
+		dev->driver = NULL;
+		pm_runtime_put_sync(&dev->dev);
 		return rc;
 	}
 	/*
 	 * Probe function should return < 0 for failure, 0 for success
 	 * Treat values > 0 as success, but warn.
 	 */
-	pci_warn(pci_dev, "Driver probe function unexpectedly returned %d\n",
+	pci_warn(dev, "Driver probe function unexpectedly returned %d\n",
 		 rc);
 	return 0;
 }
 
-static bool pci_physfn_is_probed(struct pci_dev *dev)
-{
-#ifdef CONFIG_PCI_IOV
-	return dev->is_virtfn && dev->physfn->is_probed;
-#else
-	return false;
-#endif
-}
-
-static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
-			  const struct pci_device_id *id)
-{
-	int error, node, cpu;
-	struct drv_dev_and_id ddi = { drv, dev, id };
-
-	/*
-	 * Execute driver initialization on node where the device is
-	 * attached.  This way the driver likely allocates its local memory
-	 * on the right node.
-	 */
-	node = dev_to_node(&dev->dev);
-	dev->is_probed = 1;
-
-	cpu_hotplug_disable();
-
-	/*
-	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
-	 * device is probed from work_on_cpu() of the Physical device.
-	 */
-	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
-	    pci_physfn_is_probed(dev)) {
-		cpu = nr_cpu_ids;
-	} else {
-		cpumask_var_t wq_domain_mask;
-
-		if (!zalloc_cpumask_var(&wq_domain_mask, GFP_KERNEL)) {
-			error = -ENOMEM;
-			goto out;
-		}
-		cpumask_and(wq_domain_mask,
-			    housekeeping_cpumask(HK_TYPE_WQ),
-			    housekeeping_cpumask(HK_TYPE_DOMAIN));
-
-		cpu = cpumask_any_and(cpumask_of_node(node),
-				      wq_domain_mask);
-		free_cpumask_var(wq_domain_mask);
-	}
-
-	if (cpu < nr_cpu_ids)
-		error = work_on_cpu(cpu, local_pci_probe, &ddi);
-	else
-		error = local_pci_probe(&ddi);
-out:
-	dev->is_probed = 0;
-	cpu_hotplug_enable();
-	return error;
-}
-
 /**
  * __pci_device_probe - check if a driver wants to claim a specific PCI device
  * @drv: driver to call to check if it wants the PCI device
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 864775651c6f..cbc0db2f2b84 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -481,7 +481,6 @@ struct pci_dev {
 	unsigned int	io_window_1k:1;		/* Intel bridge 1K I/O windows */
 	unsigned int	irq_managed:1;
 	unsigned int	non_compliant_bars:1;	/* Broken BARs; ignore them */
-	unsigned int	is_probed:1;		/* Device probing in progress */
 	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
 	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
 	unsigned int	no_command_memory:1;	/* No PCI_COMMAND_MEMORY */
-- 
2.20.1

