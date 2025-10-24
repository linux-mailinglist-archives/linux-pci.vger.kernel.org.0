Return-Path: <linux-pci+bounces-39214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 260DEC0412C
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 04:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7823C4EF86C
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 02:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF7D225A3D;
	Fri, 24 Oct 2025 02:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0Jo3StP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ECD224B05
	for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 02:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271460; cv=none; b=pq7bsPk3ba2nQHOeQf6gR0goDs3/exquBtXsBnu3CPYJoYuHT6sQMLGoF/eg1WxUevH957YpCb/m62FN0etwM0mpu/eVSI0X89yZSxJeyExigBmN73hdxoyb4iZNvJlC0aG/JNMPsxl6kna42xEujlj6xSxnYS12VMKF3JVs6i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271460; c=relaxed/simple;
	bh=f/x+kuFZDW8+S+hAF69IPN9s4MbxddWK4kKJjnjuy28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsJHqR8Ph2hxM6267d7sEK+EV131SIdhrxTKSKQXUhITDC1PMYDePMx0H727l29wqYjSUIXxGIhTU5YSjIkpc+5/SG2ZeW7R8t6u3pJ/g2kYRvFpbt5VKkk6dHySOAlKDanB+qmNbBZFi3JIFzIAZjN0HSJjWyLgTrQtjWOpTpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0Jo3StP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761271459; x=1792807459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f/x+kuFZDW8+S+hAF69IPN9s4MbxddWK4kKJjnjuy28=;
  b=j0Jo3StPazmjauYOSUIDefOg1zBAZBuhuCkZkzplkWUgJ5E9MD6WzVEB
   hkS1i+MopKQ+M3l2vfmE3B0Ggs8CzYkNOY/6qS9ENcBsqzqAc1BJGo5tT
   asV0DBrngLTdNDYv1xDw9cDrE/opCglKKPdqQ2k3WAbSZnsrzUiGJk7FB
   mRXv6wQnEVh0asoKwDpmJ2QhPk/IfWsGTn+OyVE/X0B7yAC/58U8iQewJ
   5XOk23NVvto2ys8/rccx87WUsP/WpzZqCajwNWgpYlts55ShuhXKgYknh
   fcJYg2QyhzFoFA7vrkCFVom1H2eTznCyjoN3dKcTPw7HAXUvY62fqApH4
   Q==;
X-CSE-ConnectionGUID: d5hkvUYOSvOpz3c4Sw8PmA==
X-CSE-MsgGUID: 92Vd2LvCRwacDIju+NoKLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67319368"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="67319368"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 19:04:17 -0700
X-CSE-ConnectionGUID: HgH6Q+mRR622r1OJr/pjgg==
X-CSE-MsgGUID: xGpNHt67RGCPZdoOxBcTTw==
X-ExtLoop1: 1
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa003.fm.intel.com with ESMTP; 23 Oct 2025 19:04:16 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: aik@amd.com,
	yilun.xu@linux.intel.com,
	aneesh.kumar@kernel.org,
	bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v7 1/9] coco/tsm: Introduce a core device for TEE Security Managers
Date: Thu, 23 Oct 2025 19:04:10 -0700
Message-ID: <20251024020418.1366664-2-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024020418.1366664-1-dan.j.williams@intel.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A "TSM" is a platform component that provides an API for securely
provisioning resources for a confidential guest (TVM) to consume. The
name originates from the PCI specification for platform agent that
carries out operations for PCIe TDISP (TEE Device Interface Security
Protocol).

Instances of this core device are parented by a device representing the
platform security function like CONFIG_CRYPTO_DEV_CCP or
CONFIG_INTEL_TDX_HOST.

This device interface is a frontend to the aspects of a TSM and TEE I/O
that are cross-architecture common. This includes mechanisms like
enumerating available platform TEE I/O capabilities and provisioning
connections between the platform TSM and device DSMs (Device Security
Manager (TDISP)).

For now this is just the scaffolding for registering a TSM device sysfs
interface.

Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/virt/coco/Kconfig                 |   3 +
 drivers/virt/coco/Makefile                |   1 +
 Documentation/ABI/testing/sysfs-class-tsm |   9 ++
 include/linux/tsm.h                       |   4 +
 drivers/virt/coco/tsm-core.c              | 109 ++++++++++++++++++++++
 MAINTAINERS                               |   2 +-
 6 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
 create mode 100644 drivers/virt/coco/tsm-core.c

diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index 819a97e8ba99..bb0c6d6ddcc8 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -14,3 +14,6 @@ source "drivers/virt/coco/tdx-guest/Kconfig"
 source "drivers/virt/coco/arm-cca-guest/Kconfig"
 
 source "drivers/virt/coco/guest/Kconfig"
+
+config TSM
+	bool
diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
index f918bbb61737..cb52021912b3 100644
--- a/drivers/virt/coco/Makefile
+++ b/drivers/virt/coco/Makefile
@@ -7,4 +7,5 @@ obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
 obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
 obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
+obj-$(CONFIG_TSM) 		+= tsm-core.o
 obj-$(CONFIG_TSM_GUEST)		+= guest/
diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
new file mode 100644
index 000000000000..2949468deaf7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-tsm
@@ -0,0 +1,9 @@
+What:		/sys/class/tsm/tsmN
+Contact:	linux-coco@lists.linux.dev
+Description:
+		"tsmN" is a device that represents the generic attributes of a
+		platform TEE Security Manager.  It is typically a child of a
+		platform enumerated TSM device. /sys/class/tsm/tsmN/uevent
+		signals when the PCI layer is able to support establishment of
+		link encryption and other device-security features coordinated
+		through a platform tsm.
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 431054810dca..aa906eb67360 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -5,6 +5,7 @@
 #include <linux/sizes.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
+#include <linux/device.h>
 
 #define TSM_REPORT_INBLOB_MAX 64
 #define TSM_REPORT_OUTBLOB_MAX SZ_32K
@@ -109,4 +110,7 @@ struct tsm_report_ops {
 
 int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
 int tsm_report_unregister(const struct tsm_report_ops *ops);
+struct tsm_dev;
+struct tsm_dev *tsm_register(struct device *parent);
+void tsm_unregister(struct tsm_dev *tsm_dev);
 #endif /* __TSM_H */
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
new file mode 100644
index 000000000000..a64b776642cf
--- /dev/null
+++ b/drivers/virt/coco/tsm-core.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/tsm.h>
+#include <linux/idr.h>
+#include <linux/rwsem.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/cleanup.h>
+
+static struct class *tsm_class;
+static DECLARE_RWSEM(tsm_rwsem);
+static DEFINE_IDR(tsm_idr);
+
+struct tsm_dev {
+	struct device dev;
+	int id;
+};
+
+static struct tsm_dev *alloc_tsm_dev(struct device *parent)
+{
+	struct tsm_dev *tsm_dev __free(kfree) =
+		kzalloc(sizeof(*tsm_dev), GFP_KERNEL);
+	struct device *dev;
+	int id;
+
+	if (!tsm_dev)
+		return ERR_PTR(-ENOMEM);
+
+	guard(rwsem_write)(&tsm_rwsem);
+	id = idr_alloc(&tsm_idr, tsm_dev, 0, INT_MAX, GFP_KERNEL);
+	if (id < 0)
+		return ERR_PTR(id);
+
+	tsm_dev->id = id;
+	dev = &tsm_dev->dev;
+	dev->parent = parent;
+	dev->class = tsm_class;
+	device_initialize(dev);
+	return no_free_ptr(tsm_dev);
+}
+
+static void put_tsm_dev(struct tsm_dev *tsm_dev)
+{
+	if (!IS_ERR_OR_NULL(tsm_dev))
+		put_device(&tsm_dev->dev);
+}
+
+DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
+	    if (!IS_ERR_OR_NULL(_T)) put_tsm_dev(_T))
+
+struct tsm_dev *tsm_register(struct device *parent)
+{
+	struct tsm_dev *tsm_dev __free(put_tsm_dev) = alloc_tsm_dev(parent);
+	struct device *dev;
+	int rc;
+
+	if (IS_ERR(tsm_dev))
+		return tsm_dev;
+
+	dev = &tsm_dev->dev;
+	rc = dev_set_name(dev, "tsm%d", tsm_dev->id);
+	if (rc)
+		return ERR_PTR(rc);
+
+	rc = device_add(dev);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return no_free_ptr(tsm_dev);
+}
+EXPORT_SYMBOL_GPL(tsm_register);
+
+void tsm_unregister(struct tsm_dev *tsm_dev)
+{
+	device_unregister(&tsm_dev->dev);
+}
+EXPORT_SYMBOL_GPL(tsm_unregister);
+
+static void tsm_release(struct device *dev)
+{
+	struct tsm_dev *tsm_dev = container_of(dev, typeof(*tsm_dev), dev);
+
+	guard(rwsem_write)(&tsm_rwsem);
+	idr_remove(&tsm_idr, tsm_dev->id);
+	kfree(tsm_dev);
+}
+
+static int __init tsm_init(void)
+{
+	tsm_class = class_create("tsm");
+	if (IS_ERR(tsm_class))
+		return PTR_ERR(tsm_class);
+
+	tsm_class->dev_release = tsm_release;
+	return 0;
+}
+module_init(tsm_init)
+
+static void __exit tsm_exit(void)
+{
+	class_destroy(tsm_class);
+}
+module_exit(tsm_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("TEE Security Manager Class Device");
diff --git a/MAINTAINERS b/MAINTAINERS
index 545a4776795e..06285f3a24df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26097,7 +26097,7 @@ M:	David Lechner <dlechner@baylibre.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/trigger-source/*
 
-TRUSTED SECURITY MODULE (TSM) INFRASTRUCTURE
+TRUSTED EXECUTION ENVIRONMENT SECURITY MANAGER (TSM)
 M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-coco@lists.linux.dev
 S:	Maintained
-- 
2.51.0


