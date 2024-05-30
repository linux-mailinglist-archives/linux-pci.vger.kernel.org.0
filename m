Return-Path: <linux-pci+bounces-8095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5FC8D521D
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 21:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F103283ACC
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 19:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D756273513;
	Thu, 30 May 2024 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aSoNLzrp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B9C7319C;
	Thu, 30 May 2024 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717096377; cv=none; b=tkBmR5yUJvBmiPnKPPMo2gSnWZ0U6LxbfMMKl/MxSjrgG2v/IBCPYe7N8lpnlF1vlInn7UyWK8G33hU959r/+kr2zM7xQNnVBj9ivl+g0tJmH39PapnZf511bjpmZb7Y1KLwiAHixcW67D+FsLKVkq0+LmvEdT00fxZwcAsFc8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717096377; c=relaxed/simple;
	bh=KVhhI8ERJ5IQEAx8RbHSd/Tg60VIXNkXaDhLVs4tbr4=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=FMoKPnGaTl0Y+XfkIF3NDZX6uxpv4eyq3UajBW27A83z82IC6FVXerPW0WTCwT+jxXeaH6mfYEaIYtrIA0Uc980kWznZvYB/k55k9miBo7z84lxLsVrRPhYvJBw190RxTXCrtx7BiGAzYv8vm/bmn2MZCyWt7rqxsZ2vb93TuDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aSoNLzrp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717096376; x=1748632376;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KVhhI8ERJ5IQEAx8RbHSd/Tg60VIXNkXaDhLVs4tbr4=;
  b=aSoNLzrpkOx5/78CTePaeIDrhv56zKH1BRfp2nGcUGZQgzOJeHDzLjC0
   swYD8jOqEpheZOQvbjVUQR/RYZUuTsYjf05QrMC+87wnl7pqsw67BdbEt
   3hrsNoIp8YqwXBMdAa7POR2Zxh3nGODwCdsGnUHTAOmVTg6FJERgMUubM
   DqzQmWioOGyKIe/EXgAvc2jTg/tcUJ+IFZKVaFPkucYJzxYH12DSf5FnK
   49MLFVLbdiV39LhaE+LBlEcDIP893ynXmCQjpNbxVVMBA4cXdxG8girla
   LaiCcYJhClPs7CSitx/r2zK8iJVmPJA7S2vLNlXvv8shh083vHrPwpMy3
   A==;
X-CSE-ConnectionGUID: WUVk1w+XTl6rVqElAf90mA==
X-CSE-MsgGUID: ecTSl1lJQOymleaEtvnOJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24734656"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="24734656"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 12:12:55 -0700
X-CSE-ConnectionGUID: 8+WkG1kOQG6ZsFizcrAxVA==
X-CSE-MsgGUID: yXa92prMSZKMtSlPk6JJCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="40482698"
Received: from spittala-mobl3.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.84.244])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 12:12:55 -0700
Subject: [PATCH] PCI: Revert / replace the cfg_access_lock lockdep mechanism
From: Dan Williams <dan.j.williams@intel.com>
To: bhelgaas@google.com
Cc: Imre Deak <imre.deak@intel.com>, Jani Saarinen <jani.saarinen@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Date: Thu, 30 May 2024 12:12:54 -0700
Message-ID: <171709637423.1568751.11773767969980847536.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

While the experiment did reveal that there are additional places that
are missing the lock during secondary bus reset, one of the places that
needs to take cfg_access_lock (pci_bus_lock()) is not prepared for
lockdep annotation.

Specifically, pci_bus_lock() takes pci_dev_lock() recursively and is
currently dependent on the fact that the device_lock() is marked
lockdep_set_novalidate_class(&dev->mutex). Otherwise, without that
annotation, pci_bus_lock() would need to use something like a new
pci_dev_lock_nested() helper, a scheme to track a PCI device's depth in
the topology, and a hope that the depth of a PCI tree never exceeds the
max value for a lockdep subclass.

The alternative to ripping out the lockdep coverage would be to deploy a
dynamic lock key for every PCI device. Unfortunately, there is evidence
that increasing the number of keys that lockdep needs to track to be
per-PCI-device is prohibitively expensive for something like the
cfg_access_lock.

The main motivation for adding the annotation in the first place was to
catch unlocked secondary bus resets, not necessarily catch lock ordering
problems between cfg_access_lock and other locks.

Replace the lockdep tracking with a pci_warn_once() for that primary
concern.

Fixes: 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
Reported-by: Imre Deak <imre.deak@intel.com>
Closes: https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_134186v1/shard-dg2-1/igt@device_reset@unbind-reset-rebind.html
Cc: Jani Saarinen <jani.saarinen@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/access.c    |    4 ----
 drivers/pci/pci.c       |    4 +++-
 drivers/pci/probe.c     |    3 ---
 include/linux/lockdep.h |    5 -----
 include/linux/pci.h     |    2 --
 5 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 30f031de9cfe..b123da16b63b 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -289,8 +289,6 @@ void pci_cfg_access_lock(struct pci_dev *dev)
 {
 	might_sleep();
 
-	lock_map_acquire(&dev->cfg_access_lock);
-
 	raw_spin_lock_irq(&pci_lock);
 	if (dev->block_cfg_access)
 		pci_wait_cfg(dev);
@@ -345,8 +343,6 @@ void pci_cfg_access_unlock(struct pci_dev *dev)
 	raw_spin_unlock_irqrestore(&pci_lock, flags);
 
 	wake_up_all(&pci_cfg_wait);
-
-	lock_map_release(&dev->cfg_access_lock);
 }
 EXPORT_SYMBOL_GPL(pci_cfg_access_unlock);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59e0949fb079..8df32a3a0979 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4883,7 +4883,9 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
  */
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 {
-	lock_map_assert_held(&dev->cfg_access_lock);
+	if (!dev->block_cfg_access)
+		pci_warn_once(dev, "unlocked secondary bus reset via: %pS\n",
+			      __builtin_return_address(0));
 	pcibios_reset_secondary_bus(dev);
 
 	return pci_bridge_wait_for_secondary_bus(dev, "bus reset");
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8e696e547565..5fbabb4e3425 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2546,9 +2546,6 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->dev.dma_mask = &dev->dma_mask;
 	dev->dev.dma_parms = &dev->dma_parms;
 	dev->dev.coherent_dma_mask = 0xffffffffull;
-	lockdep_register_key(&dev->cfg_access_key);
-	lockdep_init_map(&dev->cfg_access_lock, dev_name(&dev->dev),
-			 &dev->cfg_access_key, 0);
 
 	dma_set_max_seg_size(&dev->dev, 65536);
 	dma_set_seg_boundary(&dev->dev, 0xffffffff);
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 5e51b0de4c4b..08b0d1d9d78b 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -297,9 +297,6 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 		.wait_type_inner = _wait_type,		\
 		.lock_type = LD_LOCK_WAIT_OVERRIDE, }
 
-#define lock_map_assert_held(l)		\
-	lockdep_assert(lock_is_held(l) != LOCK_STATE_NOT_HELD)
-
 #else /* !CONFIG_LOCKDEP */
 
 static inline void lockdep_init_task(struct task_struct *task)
@@ -391,8 +388,6 @@ extern int lockdep_is_held(const void *);
 #define DEFINE_WAIT_OVERRIDE_MAP(_name, _wait_type)	\
 	struct lockdep_map __maybe_unused _name = {}
 
-#define lock_map_assert_held(l)			do { (void)(l); } while (0)
-
 #endif /* !LOCKDEP */
 
 #ifdef CONFIG_PROVE_LOCKING
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fb004fd4e889..cafc5ab1cbcb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -413,8 +413,6 @@ struct pci_dev {
 	struct resource driver_exclusive_resource;	 /* driver exclusive resource ranges */
 
 	bool		match_driver;		/* Skip attaching driver */
-	struct lock_class_key cfg_access_key;
-	struct lockdep_map cfg_access_lock;
 
 	unsigned int	transparent:1;		/* Subtractive decode bridge */
 	unsigned int	io_window:1;		/* Bridge has I/O window */


