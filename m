Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B2F1A8697
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 19:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391297AbgDNRE1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 13:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391181AbgDNREW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2020 13:04:22 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055FBC0610D5
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:22 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o81so8229271wmo.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eLrGUkQF/19aLPogpUdvI8YbWXHnZsWpwrFi0/qg//E=;
        b=jcWTj9KA9f5VY5uyiHnSpNMFdHsiUDVFHJvYbLIJ1k5nGZkrkBosKsQxZAA2Ersqto
         xqO4NOz7bvvxqXgK/JAIpd3ouIdIIpW5id7o/UXbuMTKgUWZ3VDBoE0/VX1wLxQ8NQkb
         4rBlr5UIJyRYJLTK5N0YVAEefX7eUNMZOr7b1b+KSnmWKlW16EGkz2AZ6brRShm4MMoB
         0PN67tFMxxghG0GHwtK6PsyVCQcy6vyaZoEW8Fs1SfY1RIeHwyGIhpbVIibRyA4R8aTC
         GTj4KfhgRbNGi3wUqe9Lf7nUWJKJCEIHmDd2CcnIH0K7B4ije+5tpHBMMyZbAuQuQjn6
         Uj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eLrGUkQF/19aLPogpUdvI8YbWXHnZsWpwrFi0/qg//E=;
        b=A1nv/4t5mJG+9EELaxTAuZovwm25mtJbY15mXNRfnkBkqu804K9nHIzwReUnTFeBaD
         nq9FDNTFt3dSEKOUiMU/3JcOV9VVKoAQ2h+bjYE3ItHEv2kvUDhHMLu7W9jpFqo7BWGM
         BKYswyi956NIV27GJ+C/WcxYtPzpCDLPdX8WNO0YTdDC73KJ2sYCyuCEhAOIBib4Gpxk
         SP6gprnfgUkOsmHxQVOTryupnUKeLBMmhIjjLHq/bF4iI6shef9+U7r0FYgf5iyrvzT6
         aHVC7gBDGjxjAVHEOI3M8Q0A14smk3LjHsmy56sDXW30gXWCYu2pQI+NZegYdfmslyxi
         VPqA==
X-Gm-Message-State: AGi0PuZIBmkf+xegkZsOlXEVjEfg+cLoXNhN7Ww6N01vqsFYtqth/FiU
        s/KyVepkBJDiBxVlFDhXJtp6Cw==
X-Google-Smtp-Source: APiQypI17q9pmoEqMpYE3Ho1K62xazvPIwFsE4hbvGNnps1mqFZrj5S5490gV10S/cx2pFqzhgxx4Q==
X-Received: by 2002:a1c:4603:: with SMTP id t3mr763353wma.103.1586883860378;
        Tue, 14 Apr 2020 10:04:20 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:04:19 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v5 02/25] iommu/sva: Manage process address spaces
Date:   Tue, 14 Apr 2020 19:02:30 +0200
Message-Id: <20200414170252.714402-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a small library to help IOMMU drivers manage process address spaces
bound to their devices. Register an MMU notifier to track modification
on each address space bound to one or more devices.

IOMMU drivers must implement the io_mm_ops and can then use the helpers
provided by this library to easily implement the SVA API introduced by
commit 26b25a2b98e4 ("iommu: Bind process address spaces to devices").
The io_mm_ops are:

alloc: Allocate a PASID context private to the IOMMU driver. There is a
  single context per mm. IOMMU drivers may perform arch-specific
  operations in there, for example pinning down a CPU ASID (on Arm).

attach: Attach a context to the device, by setting up the PASID table
  entry.

invalidate: Invalidate TLB entries for this address range.

clear: Clear the context and invalidate IOTLBs. Called if the mm exits
  before unbind(). DMA may still be issued.

detach: Detach a context from the device. Unlike clear() this is always
  called, at unbind(), and DMA aren't issued anymore.

free: Free a context.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v4->v5:
* Simplify locking
* Add clear() op
* Improve doc
---
 drivers/iommu/Kconfig     |   7 +
 drivers/iommu/Makefile    |   1 +
 drivers/iommu/iommu-sva.h |  78 ++++++
 include/linux/iommu.h     |   4 +
 drivers/iommu/iommu-sva.c | 527 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c     |   1 +
 6 files changed, 618 insertions(+)
 create mode 100644 drivers/iommu/iommu-sva.h
 create mode 100644 drivers/iommu/iommu-sva.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 58b4a4dbfc78b..e81842f59b037 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -102,6 +102,13 @@ config IOMMU_DMA
 	select IRQ_MSI_IOMMU
 	select NEED_SG_DMA_LENGTH
 
+# Shared Virtual Addressing library
+config IOMMU_SVA
+	bool
+	select IOASID
+	select IOMMU_API
+	select MMU_NOTIFIER
+
 config FSL_PAMU
 	bool "Freescale IOMMU support"
 	depends on PCI
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 9f33fdb3bb051..40c800dd4e3ef 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -37,3 +37,4 @@ obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
+obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/iommu-sva.h
new file mode 100644
index 0000000000000..3c4c7e886a6be
--- /dev/null
+++ b/drivers/iommu/iommu-sva.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SVA library for IOMMU drivers
+ */
+#ifndef _IOMMU_SVA_H
+#define _IOMMU_SVA_H
+
+#include <linux/iommu.h>
+#include <linux/kref.h>
+#include <linux/mmu_notifier.h>
+
+struct io_mm_ops {
+	/* Allocate a PASID context for an mm */
+	void *(*alloc)(struct mm_struct *mm);
+
+	/*
+	 * Attach a PASID context to a device. Write the entry into the PASID
+	 * table.
+	 *
+	 * @attach_domain is true when no other device in the IOMMU domain is
+	 *   already attached to this context. IOMMU drivers that share the
+	 *   PASID tables within a domain don't need to write the PASID entry
+	 *   when @attach_domain is false.
+	 */
+	int (*attach)(struct device *dev, int pasid, void *ctx,
+		      bool attach_domain);
+
+	/* Invalidate a range of addresses. Cannot sleep. */
+	void (*invalidate)(struct device *dev, int pasid, void *ctx,
+			   unsigned long vaddr, size_t size);
+
+	/*
+	 * Clear a PASID context, invalidate IOTLBs. Called when the address
+	 * space attached to this context exits. Until detach() is called, the
+	 * PASID is not freed. The IOMMU driver should expect incoming DMA
+	 * transactions for this PASID and abort them quietly. The IOMMU driver
+	 * can still queue incoming page faults for this PASID, they will be
+	 * silently aborted.
+	 */
+	void (*clear)(struct device *dev, int pasid, void *ctx);
+
+	/*
+	 * Detach a PASID context from a device. Unlike exit() this is final.
+	 * There are no more incoming DMA transactions, and page faults have
+	 * been flushed.
+	 *
+	 * @detach_domain is true when no other device in the IOMMU domain is
+	 *   still attached to this context. IOMMU drivers that share the PASID
+	 *   table within a domain don't need to clear the PASID entry when
+	 *   @detach_domain is false, only invalidate the caches.
+	 *
+	 * @cleared is true if the clear() op has already been called for this
+	 *   context. In this case there is no need to invalidate IOTLBs
+	 */
+	void (*detach)(struct device *dev, int pasid, void *ctx,
+		       bool detach_domain, bool cleared);
+
+	/* Free a context. Cannot sleep. */
+	void (*free)(void *ctx);
+};
+
+struct iommu_sva_param {
+	u32			min_pasid;
+	u32			max_pasid;
+	int			nr_bonds;
+};
+
+struct iommu_sva *
+iommu_sva_bind_generic(struct device *dev, struct mm_struct *mm,
+		       const struct io_mm_ops *ops, void *drvdata);
+void iommu_sva_unbind_generic(struct iommu_sva *handle);
+int iommu_sva_get_pasid_generic(struct iommu_sva *handle);
+
+int iommu_sva_enable(struct device *dev, struct iommu_sva_param *sva_param);
+int iommu_sva_disable(struct device *dev);
+bool iommu_sva_enabled(struct device *dev);
+
+#endif /* _IOMMU_SVA_H */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b62525747bd91..167e468dd3510 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -347,6 +347,8 @@ struct iommu_fault_param {
  * struct dev_iommu - Collection of per-device IOMMU data
  *
  * @fault_param: IOMMU detected device fault reporting data
+ * @sva_param:	 IOMMU parameter for SVA
+ * @sva_lock:	 protects @sva_param
  * @fwspec:	 IOMMU fwspec data
  * @priv:	 IOMMU Driver private data
  *
@@ -356,6 +358,8 @@ struct iommu_fault_param {
 struct dev_iommu {
 	struct mutex lock;
 	struct iommu_fault_param	*fault_param;
+	struct iommu_sva_param		*sva_param;
+	struct mutex			sva_lock;
 	struct iommu_fwspec		*fwspec;
 	void				*priv;
 };
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
new file mode 100644
index 0000000000000..7fecc74a9f7d6
--- /dev/null
+++ b/drivers/iommu/iommu-sva.c
@@ -0,0 +1,527 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Manage PASIDs and bind process address spaces to devices.
+ *
+ * Copyright (C) 2020 ARM Ltd.
+ */
+
+#include <linux/idr.h>
+#include <linux/ioasid.h>
+#include <linux/iommu.h>
+#include <linux/sched/mm.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "iommu-sva.h"
+
+/**
+ * DOC: io_mm model
+ *
+ * The io_mm keeps track of process address spaces shared between CPU and IOMMU.
+ * The following example illustrates the relation between structures
+ * iommu_domain, io_mm and iommu_sva. The iommu_sva struct is a bond between
+ * io_mm and device. A device can have multiple io_mm and an io_mm may be bound
+ * to multiple devices.
+ *              ___________________________
+ *             |  IOMMU domain A           |
+ *             |  ________________         |
+ *             | |  IOMMU group   |        |
+ *             | |                |        |
+ *             | |   dev 00:00.0 ----+------- bond 1 --- io_mm X
+ *             | |________________|   \    |
+ *             |                       '----- bond 2 ---.
+ *             |___________________________|             \
+ *              ___________________________               \
+ *             |  IOMMU domain B           |             io_mm Y
+ *             |  ________________         |             / /
+ *             | |  IOMMU group   |        |            / /
+ *             | |                |        |           / /
+ *             | |   dev 00:01.0 ------------ bond 3 -' /
+ *             | |   dev 00:01.1 ------------ bond 4 --'
+ *             | |________________|        |
+ *             |___________________________|
+ *
+ * In this example, device 00:00.0 is in domain A, devices 00:01.* are in domain
+ * B. All devices within the same domain access the same address spaces. Device
+ * 00:00.0 accesses address spaces X and Y, each corresponding to an mm_struct.
+ * Devices 00:01.* only access address space Y.
+ *
+ * To obtain the above configuration, users would for instance issue the
+ * following calls:
+ *
+ *     iommu_sva_bind_device(dev 00:00.0, mm X, ...) -> bond 1
+ *     iommu_sva_bind_device(dev 00:00.0, mm Y, ...) -> bond 2
+ *     iommu_sva_bind_device(dev 00:01.0, mm Y, ...) -> bond 3
+ *     iommu_sva_bind_device(dev 00:01.1, mm Y, ...) -> bond 4
+ *
+ * A single Process Address Space ID (PASID) is allocated for each mm. It is a
+ * choice made for the Linux SVA implementation, not a hardware restriction. In
+ * the example, devices use PASID 1 to read/write into address space X and PASID
+ * 2 to read/write into address space Y. Calling iommu_sva_get_pasid() on bond 1
+ * returns 1, and calling it on bonds 2-4 returns 2.
+ *
+ * Hardware tables describing this configuration in the IOMMU would typically
+ * look like this:
+ *
+ *                                PASID tables
+ *                                 of domain A
+ *                              .->+--------+
+ *                             / 0 |        |-------> io_pgtable
+ *                            /    +--------+
+ *            Device tables  /   1 |        |-------> pgd X
+ *              +--------+  /      +--------+
+ *      00:00.0 |      A |-'     2 |        |--.
+ *              +--------+         +--------+   \
+ *              :        :       3 |        |    \
+ *              +--------+         +--------+     --> pgd Y
+ *      00:01.0 |      B |--.                    /
+ *              +--------+   \                  |
+ *      00:01.1 |      B |----+   PASID tables  |
+ *              +--------+     \   of domain B  |
+ *                              '->+--------+   |
+ *                               0 |        |-- | --> io_pgtable
+ *                                 +--------+   |
+ *                               1 |        |   |
+ *                                 +--------+   |
+ *                               2 |        |---'
+ *                                 +--------+
+ *                               3 |        |
+ *                                 +--------+
+ *
+ * With this model, a single call binds all devices in a given domain to an
+ * address space. Other devices in the domain will get the same bond implicitly.
+ * However, users must issue one bind() for each device, because IOMMUs may
+ * implement SVA differently. Furthermore, mandating one bind() per device
+ * allows the driver to perform sanity-checks on device capabilities.
+ *
+ * In some IOMMUs, one entry of the PASID table (typically the first one) can
+ * hold non-PASID translations. In this case PASID 0 is reserved and the first
+ * entry points to the io_pgtable pointer. In other IOMMUs PASID 0 is available
+ * to the allocator.
+ */
+
+struct io_mm {
+	struct hlist_head		devices;
+	struct mm_struct		*mm;
+	struct mmu_notifier		notifier;
+
+	/* Late initialization */
+	const struct io_mm_ops		*ops;
+	void				*ctx;
+	int				pasid;
+};
+
+#define mn_to_io_mm(mmu_notifier) \
+	container_of(mmu_notifier, struct io_mm, notifier)
+
+struct iommu_bond {
+	struct iommu_sva		sva;
+	struct io_mm			*io_mm;
+
+	struct hlist_node		mm_node;
+	void				*drvdata;
+	struct rcu_head			rcu_head;
+	refcount_t			refs;
+	bool				cleared;
+};
+
+#define to_iommu_bond(handle) container_of(handle, struct iommu_bond, sva)
+
+static DECLARE_IOASID_SET(shared_pasid);
+
+/*
+ * Serializes modifications of bonds.
+ * Lock order: Device SVA mutex; global SVA mutex; IOASID lock
+ */
+static DEFINE_MUTEX(iommu_sva_lock);
+
+struct io_mm_alloc_params {
+	const struct io_mm_ops *ops;
+	int min_pasid, max_pasid;
+};
+
+static struct mmu_notifier *io_mm_alloc(struct mm_struct *mm, void *privdata)
+{
+	int ret;
+	struct io_mm *io_mm;
+	struct io_mm_alloc_params *params = privdata;
+
+	io_mm = kzalloc(sizeof(*io_mm), GFP_KERNEL);
+	if (!io_mm)
+		return ERR_PTR(-ENOMEM);
+
+	io_mm->mm = mm;
+	io_mm->ops = params->ops;
+	INIT_HLIST_HEAD(&io_mm->devices);
+
+	io_mm->pasid = ioasid_alloc(&shared_pasid, params->min_pasid,
+				    params->max_pasid, io_mm->mm);
+	if (io_mm->pasid == INVALID_IOASID) {
+		ret = -ENOSPC;
+		goto err_free_io_mm;
+	}
+
+	io_mm->ctx = params->ops->alloc(mm);
+	if (IS_ERR(io_mm->ctx)) {
+		ret = PTR_ERR(io_mm->ctx);
+		goto err_free_pasid;
+	}
+	return &io_mm->notifier;
+
+err_free_pasid:
+	ioasid_free(io_mm->pasid);
+err_free_io_mm:
+	kfree(io_mm);
+	return ERR_PTR(ret);
+}
+
+static void io_mm_free(struct mmu_notifier *mn)
+{
+	struct io_mm *io_mm = mn_to_io_mm(mn);
+
+	WARN_ON(!hlist_empty(&io_mm->devices));
+
+	io_mm->ops->free(io_mm->ctx);
+	ioasid_free(io_mm->pasid);
+	kfree(io_mm);
+}
+
+static void io_mm_invalidate_range(struct mmu_notifier *mn,
+				   struct mm_struct *mm, unsigned long start,
+				   unsigned long end)
+{
+	struct iommu_bond *bond;
+	struct io_mm *io_mm = mn_to_io_mm(mn);
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(bond, &io_mm->devices, mm_node)
+		io_mm->ops->invalidate(bond->sva.dev, io_mm->pasid, io_mm->ctx,
+				       start, end - start);
+	rcu_read_unlock();
+}
+
+/*
+ * io_mm_release - release MMU notifier
+ *
+ * Called when the mm exits. To avoid spending too much time in here, we only
+ * clear page table pointers and invalidate IOTLBs here, but we don't stop DMA
+ * or free anything here.
+ */
+static void io_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
+{
+	struct iommu_bond *bond;
+	struct io_mm *io_mm = mn_to_io_mm(mn);
+
+	mutex_lock(&iommu_sva_lock);
+	hlist_for_each_entry(bond, &io_mm->devices, mm_node) {
+		/* The release notifier could fire multiple times. */
+		if (bond->cleared)
+			continue;
+
+		io_mm->ops->clear(bond->sva.dev, io_mm->pasid, io_mm->ctx);
+		bond->cleared = true;
+	}
+	mutex_unlock(&iommu_sva_lock);
+}
+
+static struct mmu_notifier_ops iommu_mmu_notifier_ops = {
+	.alloc_notifier		= io_mm_alloc,
+	.free_notifier		= io_mm_free,
+	.invalidate_range	= io_mm_invalidate_range,
+	.release		= io_mm_release,
+};
+
+/*
+ * io_mm_get - Allocate an io_mm or get the existing one for the given mm
+ * @mm: the mm
+ * @ops: callbacks for the IOMMU driver
+ * @min_pasid: minimum PASID value (inclusive)
+ * @max_pasid: maximum PASID value (inclusive)
+ *
+ * Returns a valid io_mm or an error pointer.
+ */
+static struct io_mm *io_mm_get(struct mm_struct *mm,
+			       const struct io_mm_ops *ops,
+			       int min_pasid, int max_pasid)
+{
+	struct io_mm *io_mm;
+	struct mmu_notifier *mn;
+	struct io_mm_alloc_params params = {
+		.ops		= ops,
+		.min_pasid	= min_pasid,
+		.max_pasid	= max_pasid,
+	};
+
+	/*
+	 * A single notifier can exist for this (ops, mm) pair. Allocate it if
+	 * necessary.
+	 */
+	mn = mmu_notifier_get(&iommu_mmu_notifier_ops, mm, &params);
+	if (IS_ERR(mn))
+		return ERR_CAST(mn);
+
+	io_mm = mn_to_io_mm(mn);
+	if (WARN_ON(io_mm->ops != ops)) {
+		mmu_notifier_put(mn);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return io_mm;
+}
+
+static void io_mm_put(struct io_mm *io_mm)
+{
+	mmu_notifier_put(&io_mm->notifier);
+}
+
+static struct iommu_sva *
+io_mm_attach(struct device *dev, struct io_mm *io_mm, void *drvdata)
+{
+	int ret;
+	bool attach_domain = true;
+	struct iommu_bond *bond, *tmp;
+	struct iommu_domain *domain, *other;
+	struct iommu_sva_param *param = dev->iommu->sva_param;
+
+	domain = iommu_get_domain_for_dev(dev);
+
+	/* Is it already bound to the device or domain? */
+	hlist_for_each_entry(tmp, &io_mm->devices, mm_node) {
+		if (tmp->sva.dev == dev) {
+			if (WARN_ON(tmp->drvdata != drvdata))
+				return ERR_PTR(-EINVAL);
+
+			/*
+			 * Hold a single io_mm reference per bond. Note that we
+			 * can't return an error after this, otherwise the
+			 * caller would drop an additional reference to the
+			 * io_mm.
+			 */
+			refcount_inc(&tmp->refs);
+			io_mm_put(io_mm);
+			return &tmp->sva;
+		}
+
+		if (!attach_domain)
+			continue;
+
+		other = iommu_get_domain_for_dev(tmp->sva.dev);
+		if (domain == other)
+			attach_domain = false;
+	}
+
+	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
+	if (!bond)
+		return ERR_PTR(-ENOMEM);
+
+	bond->sva.dev	= dev;
+	bond->drvdata	= drvdata;
+	bond->io_mm	= io_mm;
+	refcount_set(&bond->refs, 1);
+
+	hlist_add_head_rcu(&bond->mm_node, &io_mm->devices);
+
+	ret = io_mm->ops->attach(bond->sva.dev, io_mm->pasid, io_mm->ctx,
+				 attach_domain);
+	if (ret)
+		goto err_remove;
+
+	param->nr_bonds++;
+	return &bond->sva;
+
+err_remove:
+	/*
+	 * At this point concurrent threads may have started to access the
+	 * io_mm->devices list in order to invalidate address ranges, which
+	 * requires to free the bond via kfree_rcu()
+	 */
+	hlist_del_init_rcu(&bond->mm_node);
+	kfree_rcu(bond, rcu_head);
+	return ERR_PTR(ret);
+}
+
+static void io_mm_detach(struct iommu_bond *bond)
+{
+	struct iommu_bond *tmp;
+	bool detach_domain = true;
+	struct io_mm *io_mm = bond->io_mm;
+	struct device *dev = bond->sva.dev;
+	struct iommu_domain *domain, *other;
+	struct iommu_sva_param *param = dev->iommu->sva_param;
+
+	if (!refcount_dec_and_test(&bond->refs))
+		return;
+
+	param->nr_bonds--;
+
+	domain = iommu_get_domain_for_dev(bond->sva.dev);
+
+	/* Are other devices in the same domain still attached to this mm? */
+	hlist_for_each_entry(tmp, &io_mm->devices, mm_node) {
+		if (tmp == bond)
+			continue;
+		other = iommu_get_domain_for_dev(tmp->sva.dev);
+		if (domain == other) {
+			detach_domain = false;
+			break;
+		}
+	}
+
+	io_mm->ops->detach(bond->sva.dev, io_mm->pasid, io_mm->ctx,
+			   detach_domain, bond->cleared);
+
+	hlist_del_init_rcu(&bond->mm_node);
+	kfree_rcu(bond, rcu_head);
+	io_mm_put(io_mm);
+}
+
+
+struct iommu_sva *
+iommu_sva_bind_generic(struct device *dev, struct mm_struct *mm,
+		       const struct io_mm_ops *ops, void *drvdata)
+{
+	struct io_mm *io_mm;
+	struct iommu_sva *handle;
+	struct dev_iommu *param = dev->iommu;
+
+	if (!param)
+		return ERR_PTR(-ENODEV);
+
+	mutex_lock(&param->sva_lock);
+	mutex_lock(&iommu_sva_lock);
+	if (!param->sva_param) {
+		handle = ERR_PTR(-ENODEV);
+		goto out_unlock;
+	}
+
+	io_mm = io_mm_get(mm, ops, param->sva_param->min_pasid,
+			  param->sva_param->max_pasid);
+	if (IS_ERR(io_mm)) {
+		handle = ERR_CAST(io_mm);
+		goto out_unlock;
+	}
+
+	handle = io_mm_attach(dev, io_mm, drvdata);
+	if (IS_ERR(handle))
+		io_mm_put(io_mm);
+
+out_unlock:
+	mutex_unlock(&iommu_sva_lock);
+	mutex_unlock(&param->sva_lock);
+	return handle;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_bind_generic);
+
+void iommu_sva_unbind_generic(struct iommu_sva *handle)
+{
+	struct iommu_bond *bond = to_iommu_bond(handle);
+	struct dev_iommu *param = handle->dev->iommu;
+
+	if (WARN_ON(!param))
+		return;
+
+	mutex_lock(&param->sva_lock);
+	mutex_lock(&iommu_sva_lock);
+	io_mm_detach(bond);
+	mutex_unlock(&iommu_sva_lock);
+	mutex_unlock(&param->sva_lock);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unbind_generic);
+
+/**
+ * iommu_sva_enable() - Enable Shared Virtual Addressing for a device
+ * @dev: the device
+ * @sva_param: the parameters.
+ *
+ * Called by an IOMMU driver to setup the SVA parameters
+ * @sva_param is duplicated and can be freed when this function returns.
+ *
+ * Return 0 if initialization succeeded, or an error.
+ */
+int iommu_sva_enable(struct device *dev, struct iommu_sva_param *sva_param)
+{
+	int ret;
+	struct iommu_sva_param *new_param;
+	struct dev_iommu *param = dev->iommu;
+
+	if (!param)
+		return -ENODEV;
+
+	new_param = kmemdup(sva_param, sizeof(*new_param), GFP_KERNEL);
+	if (!new_param)
+		return -ENOMEM;
+
+	mutex_lock(&param->sva_lock);
+	if (param->sva_param) {
+		ret = -EEXIST;
+		goto err_unlock;
+	}
+
+	dev->iommu->sva_param = new_param;
+	mutex_unlock(&param->sva_lock);
+	return 0;
+
+err_unlock:
+	mutex_unlock(&param->sva_lock);
+	kfree(new_param);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_enable);
+
+/**
+ * iommu_sva_disable() - Disable Shared Virtual Addressing for a device
+ * @dev: the device
+ *
+ * IOMMU drivers call this to disable SVA.
+ */
+int iommu_sva_disable(struct device *dev)
+{
+	int ret = 0;
+	struct dev_iommu *param = dev->iommu;
+
+	if (!param)
+		return -EINVAL;
+
+	mutex_lock(&param->sva_lock);
+	if (!param->sva_param) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	/* Require that all contexts are unbound */
+	if (param->sva_param->nr_bonds) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	kfree(param->sva_param);
+	param->sva_param = NULL;
+out_unlock:
+	mutex_unlock(&param->sva_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_disable);
+
+bool iommu_sva_enabled(struct device *dev)
+{
+	bool enabled;
+	struct dev_iommu *param = dev->iommu;
+
+	if (!param)
+		return false;
+
+	mutex_lock(&param->sva_lock);
+	enabled = !!param->sva_param;
+	mutex_unlock(&param->sva_lock);
+	return enabled;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_enabled);
+
+int iommu_sva_get_pasid_generic(struct iommu_sva *handle)
+{
+	struct iommu_bond *bond = to_iommu_bond(handle);
+
+	return bond->io_mm->pasid;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_get_pasid_generic);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index dfed12328c032..6cc2ab6889e50 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -164,6 +164,7 @@ static struct dev_iommu *dev_iommu_get(struct device *dev)
 		return NULL;
 
 	mutex_init(&param->lock);
+	mutex_init(&param->sva_lock);
 	dev->iommu = param;
 	return param;
 }
-- 
2.26.0

