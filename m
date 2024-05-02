Return-Path: <linux-pci+bounces-7016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8168B9F18
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 18:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE541C2290D
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 16:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9098B16F91F;
	Thu,  2 May 2024 16:58:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7536A16F91B;
	Thu,  2 May 2024 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669136; cv=none; b=o0m8D1wDzY8Qcm5O3aa21DGB750XDzpbM+YvkrIckFZjJtoMGCYGwFWs/unoQIzABDns2r1wEYMXvqpjz/1G6c5x0GY+sCvboP1amsAcipvGNeE9/hVToakSGNHEXbOXBewQwQ0ZU4o35eSvuSd+ol8yNhkfc3GwledGxj3yATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669136; c=relaxed/simple;
	bh=Q5sy09O8iDSYIAN3/meQJU6BSUfriC2mE8pwdT3SBRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUw20/UZCqcz7COHGuc+/L3JMvuvzY406p3oqRAsaIrIo2G1/d3lRB+fGrO4aXGuPAEjkR0NjPzgdgPniMtJk+a3fRX3+9eYSw/nTNoS+lIHp16xISbNHBLmHkybyWhiJNgqDbcbiIeagzKgqahjmibOgayLnm1/0f4jfQWRRk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCE3C4AF14;
	Thu,  2 May 2024 16:58:55 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	bhelgaas@google.com,
	lukas@wunner.de
Subject: [PATCH v6 2/5] PCI: Add locking of upstream bridge for pci_reset_function()
Date: Thu,  2 May 2024 09:57:31 -0700
Message-ID: <20240502165851.1948523-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502165851.1948523-1-dave.jiang@intel.com>
References: <20240502165851.1948523-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a long standing locking gap for missing pci_cfg_access_lock() while
manipulating bridge reset registers and configuration during
pci_reset_bus_function(). Add calling of pci_dev_lock() against the
bridge device before locking the device. The locking is conditional
depending on whether the trigger device has an upstream bridge. If
the device is a root port then there would be no upstream bridge and
thus the locking of the bridge is unnecessary. As part of calling
pci_dev_lock(), pci_cfg_access_lock() happens and blocks the writing
of PCI config space by user space.

Add lockdep assertion via pci_dev->cfg_access_lock in order to verify
pci_dev->block_cfg_access is set.

Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/pci/access.c    |  4 ++++
 drivers/pci/pci.c       | 13 +++++++++++++
 drivers/pci/probe.c     |  3 +++
 include/linux/lockdep.h |  5 +++++
 include/linux/pci.h     |  2 ++
 5 files changed, 27 insertions(+)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 6449056b57dd..36f10c7f9ef5 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -275,6 +275,8 @@ void pci_cfg_access_lock(struct pci_dev *dev)
 {
 	might_sleep();
 
+	lock_map_acquire(&dev->cfg_access_lock);
+
 	raw_spin_lock_irq(&pci_lock);
 	if (dev->block_cfg_access)
 		pci_wait_cfg(dev);
@@ -329,6 +331,8 @@ void pci_cfg_access_unlock(struct pci_dev *dev)
 	raw_spin_unlock_irqrestore(&pci_lock, flags);
 
 	wake_up_all(&pci_cfg_wait);
+
+	lock_map_release(&dev->cfg_access_lock);
 }
 EXPORT_SYMBOL_GPL(pci_cfg_access_unlock);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd4288..482372f5d268 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4879,6 +4879,7 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
  */
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 {
+	lock_map_assert_held(&dev->cfg_access_lock);
 	pcibios_reset_secondary_bus(dev);
 
 	return pci_bridge_wait_for_secondary_bus(dev, "bus reset");
@@ -5245,11 +5246,20 @@ void pci_init_reset_methods(struct pci_dev *dev)
  */
 int pci_reset_function(struct pci_dev *dev)
 {
+	struct pci_dev *bridge;
 	int rc;
 
 	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
+	bridge = pci_upstream_bridge(dev);
+	/*
+	 * If there's no upstream bridge, then no locking is needed since there is no
+	 * upstream bridge configuration to hold consistent.
+	 */
+	if (bridge)
+		pci_dev_lock(bridge);
+
 	pci_dev_lock(dev);
 	pci_dev_save_and_disable(dev);
 
@@ -5258,6 +5268,9 @@ int pci_reset_function(struct pci_dev *dev)
 	pci_dev_restore(dev);
 	pci_dev_unlock(dev);
 
+	if (bridge)
+		pci_dev_unlock(bridge);
+
 	return rc;
 }
 EXPORT_SYMBOL_GPL(pci_reset_function);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1325fbae2f28..a3da776bf986 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2543,6 +2543,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->dev.dma_mask = &dev->dma_mask;
 	dev->dev.dma_parms = &dev->dma_parms;
 	dev->dev.coherent_dma_mask = 0xffffffffull;
+	lockdep_register_key(&dev->cfg_access_key);
+	lockdep_init_map(&dev->cfg_access_lock, dev_name(&dev->dev),
+			 &dev->cfg_access_key, 0);
 
 	dma_set_max_seg_size(&dev->dev, 65536);
 	dma_set_seg_boundary(&dev->dev, 0xffffffff);
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 08b0d1d9d78b..5e51b0de4c4b 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -297,6 +297,9 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 		.wait_type_inner = _wait_type,		\
 		.lock_type = LD_LOCK_WAIT_OVERRIDE, }
 
+#define lock_map_assert_held(l)		\
+	lockdep_assert(lock_is_held(l) != LOCK_STATE_NOT_HELD)
+
 #else /* !CONFIG_LOCKDEP */
 
 static inline void lockdep_init_task(struct task_struct *task)
@@ -388,6 +391,8 @@ extern int lockdep_is_held(const void *);
 #define DEFINE_WAIT_OVERRIDE_MAP(_name, _wait_type)	\
 	struct lockdep_map __maybe_unused _name = {}
 
+#define lock_map_assert_held(l)			do { (void)(l); } while (0)
+
 #endif /* !LOCKDEP */
 
 #ifdef CONFIG_PROVE_LOCKING
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 16493426a04f..e4e7b175af54 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -413,6 +413,8 @@ struct pci_dev {
 	struct resource driver_exclusive_resource;	 /* driver exclusive resource ranges */
 
 	bool		match_driver;		/* Skip attaching driver */
+	struct lock_class_key cfg_access_key;
+	struct lockdep_map cfg_access_lock;
 
 	unsigned int	transparent:1;		/* Subtractive decode bridge */
 	unsigned int	io_window:1;		/* Bridge has I/O window */
-- 
2.44.0


