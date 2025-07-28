Return-Path: <linux-pci+bounces-33044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 364F7B13C3A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 15:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317D318893BF
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E57274B42;
	Mon, 28 Jul 2025 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDj5USVM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ACC274B25;
	Mon, 28 Jul 2025 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710828; cv=none; b=MgZGFftTH4FWZmZG4l2DF8boVw0JauUfEs6yQFDUDBtQ7iGHer6rl2J028/6QlkXz+20adhdKOvKGi/huVv9jJMxBnOzdQc+Gy4d4c0QuMOgPPfijXFuIC1NJ8MiMs0j01bxHy9QFnZ6V2jIHaHr5AQSlOg7TQiYPOWDGr+lZ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710828; c=relaxed/simple;
	bh=skkmTrobQDZGFt53QbtosVSpxpFbDP0+nW5NvEz59wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhYgEKn5ecfy4I1uI0+3FUsMIVtx82ArlSV8b8tbygkOk/04u96vqzU/0Ipsz/JPvG+15jNkoYa+JQLXG6bcPiHwMCUm9E5vJ7Jbv4RDADZemOgjdIu6BWp25koR8r5L4FW0x+MFHGIgCxRvqI6rq8UDTpIvQpnOCE2n9HbhJ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDj5USVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5079FC4CEF7;
	Mon, 28 Jul 2025 13:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710828;
	bh=skkmTrobQDZGFt53QbtosVSpxpFbDP0+nW5NvEz59wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDj5USVMbhRXmRBxR4tAWy3HrA9W0KOQGGr03N8mmrkma9x4TkkKI87JB3DmEYawK
	 RG1A9g51wQtN5LsBxR7rWDedvb3sVG7PrgFRJ/AlpsCb1nBspdESRL0fGrd+QjmCGe
	 lMZmtei3Gga6HOlbMtM5u+/imfLR+yeBuyTpnLB7YFjsqPcAhnrJZKLghfRkv7RUTC
	 6RB5E8UAX0unPHGNMxZUlLLK6kW/wBNx4o6JdxU3kxUEbRHRltb9E6GqYo9GUAv52H
	 Z9qAYHNQeIaJHKFtRu4rvm9xLfXDoHeOySON3Y8PvIz9P81LYRBbv7MD7h5BT4kVDg
	 1FGZL+4h7OrEA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aik@amd.com,
	lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [RFC PATCH v1 12/38] coco: host: arm64: CCA host platform device driver
Date: Mon, 28 Jul 2025 19:21:49 +0530
Message-ID: <20250728135216.48084-13-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728135216.48084-1-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver registers the pci_tsm_ops with tsm subsystem.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/virt/coco/Kconfig                |   2 +
 drivers/virt/coco/Makefile               |   1 +
 drivers/virt/coco/arm-cca-host/Kconfig   |  12 ++
 drivers/virt/coco/arm-cca-host/Makefile  |   5 +
 drivers/virt/coco/arm-cca-host/arm-cca.c | 209 +++++++++++++++++++++++
 drivers/virt/coco/arm-cca-host/rmm-da.h  |  29 ++++
 6 files changed, 258 insertions(+)
 create mode 100644 drivers/virt/coco/arm-cca-host/Kconfig
 create mode 100644 drivers/virt/coco/arm-cca-host/Makefile
 create mode 100644 drivers/virt/coco/arm-cca-host/arm-cca.c
 create mode 100644 drivers/virt/coco/arm-cca-host/rmm-da.h

diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index 57248b088545..43e9508301bf 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -15,5 +15,7 @@ source "drivers/virt/coco/arm-cca-guest/Kconfig"
 
 source "drivers/virt/coco/guest/Kconfig"
 
+source "drivers/virt/coco/arm-cca-host/Kconfig"
+
 config TSM
 	tristate
diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
index 04e124b2d7cf..d0a859dd9eaf 100644
--- a/drivers/virt/coco/Makefile
+++ b/drivers/virt/coco/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
 
 obj-$(CONFIG_TSM) 		+= tsm-core.o
 obj-y				+= guest/
+obj-$(CONFIG_ARM_CCA_HOST)	+= arm-cca-host/
diff --git a/drivers/virt/coco/arm-cca-host/Kconfig b/drivers/virt/coco/arm-cca-host/Kconfig
new file mode 100644
index 000000000000..0f19fbf47613
--- /dev/null
+++ b/drivers/virt/coco/arm-cca-host/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# TSM (TEE Security Manager) host drivers
+#
+config ARM_CCA_HOST
+	tristate "Arm CCA Host driver"
+	depends on ARM64
+	depends on PCI_TSM
+	select TSM
+
+	help
+	  The driver provides TSM backend for ARM CCA
diff --git a/drivers/virt/coco/arm-cca-host/Makefile b/drivers/virt/coco/arm-cca-host/Makefile
new file mode 100644
index 000000000000..ad353b07e95a
--- /dev/null
+++ b/drivers/virt/coco/arm-cca-host/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+obj-$(CONFIG_ARM_CCA_HOST) += arm-cca-host.o
+
+arm-cca-host-$(CONFIG_TSM) +=  arm-cca.o
diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
new file mode 100644
index 000000000000..c8b0e6db1f47
--- /dev/null
+++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 ARM Ltd.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/pci-tsm.h>
+#include <linux/pci-ide.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/tsm.h>
+#include <linux/vmalloc.h>
+
+#include "rmm-da.h"
+
+/* Number of streams that we can support at the hostbridge level */
+#define CCA_HB_PLATFORM_STREAMS 4
+
+/* Total number of stream id supported at root port level */
+#define MAX_STREAM_ID	256
+
+DEFINE_FREE(vfree, void *, if (!IS_ERR_OR_NULL(_T)) vfree(_T))
+static struct pci_tsm *cca_tsm_pci_probe(struct pci_dev *pdev)
+{
+	int rc;
+	struct pci_host_bridge *hb;
+	struct cca_host_dsc_pf0 *dsc_pf0 __free(vfree) = NULL;
+
+	if (pdev->is_virtfn)
+		return NULL;
+
+	if (!is_pci_tsm_pf0(pdev)) {
+		struct pci_tsm *tsm = kzalloc(sizeof(*tsm), GFP_KERNEL);
+
+		if (!tsm)
+			goto err_out;
+
+		pci_tsm_initialize(pdev, tsm);
+		return tsm;
+	}
+
+	if (!pdev->ide_cap)
+		goto err_out;
+
+	dsc_pf0 = vcalloc(sizeof(*dsc_pf0), GFP_KERNEL);
+	if (!dsc_pf0)
+		goto err_out;
+
+	rc = pci_tsm_pf0_initialize(pdev, &dsc_pf0->pci);
+	if (rc)
+		return NULL;
+	/*
+	 * FIXME!!
+	 * update the hostbridge details. This should go into
+	 * some host bridge probe/init routine.
+	 * than the selective index supported by the endpoint
+	 */
+	hb = pci_find_host_bridge(pdev->bus);
+	pci_ide_init_nr_streams(hb, CCA_HB_PLATFORM_STREAMS);
+
+	pci_info(pdev, "tsm enabled\n");
+	return &no_free_ptr(dsc_pf0)->pci.tsm;
+
+err_out:
+	return NULL;
+}
+
+static void cca_tsm_pci_remove(struct pci_tsm *tsm)
+{
+	struct pci_dev *pdev = tsm->pdev;
+	struct cca_host_dsc_pf0 *dsc_pf0;
+
+	if (WARN_ON(pdev->is_virtfn))
+		return;
+
+	if (!is_pci_tsm_pf0(pdev)) {
+
+		pci_dbg(tsm->pdev, "tsm disabled\n");
+		kfree(pdev->tsm);
+		return;
+	}
+
+	dsc_pf0 = to_cca_dsc_pf0(pdev);
+	pci_dbg(tsm->pdev, "tsm disabled\n");
+	vfree(dsc_pf0);
+}
+
+/* per root port unique with multiple restrictions. For now global */
+static DECLARE_BITMAP(cca_stream_ids, MAX_STREAM_ID);
+
+static int cca_tsm_connect(struct pci_dev *pdev)
+{
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	struct cca_host_dsc_pf0 *dsc_pf0;
+	struct pci_ide *ide;
+	int rc, stream_id;
+
+	/* Only function 0 supports connect in host */
+	if (WARN_ON(!is_pci_tsm_pf0(pdev)))
+		return -EIO;
+
+	dsc_pf0 = to_cca_dsc_pf0(pdev);
+	/* Allocate stream id */
+	stream_id = find_first_zero_bit(cca_stream_ids, MAX_STREAM_ID);
+	if (stream_id == MAX_STREAM_ID)
+		return -EBUSY;
+	set_bit(stream_id, cca_stream_ids);
+
+	ide = pci_ide_stream_alloc(pdev);
+	if (!ide) {
+		rc = -ENOMEM;
+		goto err_stream_alloc;
+	}
+
+	dsc_pf0->sel_stream = ide;
+	ide->stream_id = stream_id;
+	rc = pci_ide_stream_register(ide);
+	if (rc)
+		goto err_stream;
+
+	pci_ide_stream_setup(pdev, ide);
+	pci_ide_stream_setup(rp, ide);
+
+	rc = tsm_ide_stream_register(pdev, ide);
+	if (rc)
+		goto err_tsm;
+
+	/*
+	 * Once ide is setup enable the stream at endpoint
+	 * Root port will be done by RMM
+	 */
+	pci_ide_stream_enable(pdev, ide);
+	return 0;
+
+err_tsm:
+	pci_ide_stream_teardown(rp, ide);
+	pci_ide_stream_teardown(pdev, ide);
+	pci_ide_stream_unregister(ide);
+err_stream:
+	pci_ide_stream_free(ide);
+err_stream_alloc:
+	clear_bit(stream_id, cca_stream_ids);
+
+	return rc;
+}
+
+static void cca_tsm_disconnect(struct pci_dev *pdev)
+{
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	struct cca_host_dsc_pf0 *dsc_pf0;
+	struct pci_ide *ide;
+
+	if (WARN_ON(!is_pci_tsm_pf0(pdev)))
+		return;
+
+	dsc_pf0 = to_cca_dsc_pf0(pdev);
+	ide = dsc_pf0->sel_stream;
+	dsc_pf0->sel_stream = NULL;
+	pci_ide_stream_disable(pdev, ide);
+	tsm_ide_stream_unregister(ide);
+	pci_ide_stream_teardown(rp, ide);
+	pci_ide_stream_teardown(pdev, ide);
+	pci_ide_stream_unregister(ide);
+	clear_bit(ide->stream_id, cca_stream_ids);
+	pci_ide_stream_free(ide);
+}
+
+static const struct pci_tsm_ops cca_pci_ops = {
+	.probe = cca_tsm_pci_probe,
+	.remove = cca_tsm_pci_remove,
+	.connect = cca_tsm_connect,
+	.disconnect = cca_tsm_disconnect,
+};
+
+static void cca_tsm_remove(void *tsm_core)
+{
+	tsm_unregister(tsm_core);
+}
+
+static int cca_tsm_probe(struct platform_device *pdev)
+{
+	struct tsm_core_dev *tsm_core;
+
+	tsm_core = tsm_register(&pdev->dev, NULL, &cca_pci_ops);
+	if (IS_ERR(tsm_core))
+		return PTR_ERR(tsm_core);
+
+	return devm_add_action_or_reset(&pdev->dev, cca_tsm_remove, tsm_core);
+}
+
+static const struct platform_device_id arm_cca_host_id_table[] = {
+	{ RMI_DEV_NAME, 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, arm_cca_host_id_table);
+
+
+static struct platform_driver cca_tsm_platform_driver = {
+	.probe = cca_tsm_probe,
+	.id_table = arm_cca_host_id_table,
+	.driver = {
+		.name = "cca_tsm",
+	},
+};
+
+MODULE_IMPORT_NS("PCI_IDE");
+module_platform_driver(cca_tsm_platform_driver);
+MODULE_DESCRIPTION("ARM CCA Host TSM driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.h b/drivers/virt/coco/arm-cca-host/rmm-da.h
new file mode 100644
index 000000000000..840cb584acdd
--- /dev/null
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 ARM Ltd.
+ */
+
+#ifndef RMM_DA_H_
+#define RMM_DA_H_
+
+#include <linux/pci.h>
+#include <linux/pci-ide.h>
+#include <linux/pci-tsm.h>
+#include <asm/rmi_smc.h>
+
+struct cca_host_dsc_pf0 {
+	struct pci_tsm_pf0 pci;
+	struct pci_ide *sel_stream;
+};
+
+static inline struct cca_host_dsc_pf0 *to_cca_dsc_pf0(struct pci_dev *pdev)
+{
+	struct pci_tsm *tsm = pdev->tsm;
+
+	if (!tsm || pdev->is_virtfn || !is_pci_tsm_pf0(pdev))
+		return NULL;
+
+	return container_of(tsm, struct cca_host_dsc_pf0, pci.tsm);
+}
+
+#endif
-- 
2.43.0


