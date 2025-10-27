Return-Path: <linux-pci+bounces-39392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61263C0CD38
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 11:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE3664EF720
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637682FABE3;
	Mon, 27 Oct 2025 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhvEXaNP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D412FA0DD;
	Mon, 27 Oct 2025 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559011; cv=none; b=eHcMAK79Izjx3uVB0ncqu6+Pa9/fpCju3FryJCVLOaHu3B8Rc0lPYzXHH6GO/AT0OoGwNutwSdoTbuAIMcxJ/bCjd1JCCEWmmp42mAnV3gcARGDKQhxkelQ5K9AMaFM4eyeWGn6K3Cy8v+IeUKuI85TFNlnLyGPUDbZTcm/QEd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559011; c=relaxed/simple;
	bh=gBvpmEpy6YyVBCSVn6cH5J7g2XLImTLNf6qfNZEbRhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+5Ln9Q4YF0ju+6W0FaJZ0nMQ0sfNbUDA0OGtSeIkEvNDQMJPsobpTY9cr2CTmmW5fryV3QzyNUwJhuqnRJcZLWERbZTKLrxWSPAR3VUSjYldnqYNK3+5x9FWkQnAPbmr+lkgePW4/VMsbMc2oqH8jirR9hjdpEzsjNLzdCyAZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhvEXaNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D90C4CEF1;
	Mon, 27 Oct 2025 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761559010;
	bh=gBvpmEpy6YyVBCSVn6cH5J7g2XLImTLNf6qfNZEbRhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fhvEXaNP7qD/GKDMkjKy+jrOpMDYjukeeERAfjmEbps1GbOQ5k9l1j65no8Ka8nLM
	 Qdh9q0DQ47vdUxzGUGbiLxB5umnUWAjdfxhs+elqLOIJwC/+6MNSc7O+e07OiRP8Uc
	 q9ejIdMNIV76DfGd1iLddGiwtjPOSUH1gczkQscX2kFgPL23Sosk6Bfywj1mxzVL6T
	 CF7rR8IFjfgXeZFLYh1ZRSRJ3G7nBY5p/H5dWXDX+AUMr8/u78NAwbtjInTgJeZdwC
	 /svKBvX2d5G+vKJAH0IfKxv3Dhm2FCvPygP58n3egjzKOkqC8Y2HgUUlI6O/mW9O9U
	 3ulZNqDS5zYlQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com,
	aik@amd.com,
	lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH RESEND v2 04/12] coco: host: arm64: Add host TSM callback and IDE stream allocation support
Date: Mon, 27 Oct 2025 15:25:54 +0530
Message-ID: <20251027095602.1154418-5-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register the TSM callback when the DA feature is supported by KVM.

This driver handles IDE stream setup for both the root port and PCIe
endpoints. Root port IDE stream enablement itself is managed by RMM.

In addition, the driver registers `pci_tsm_ops` with the TSM subsystem.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rmi_smc.h         |   2 +
 drivers/firmware/smccc/smccc.c           |  19 +++
 drivers/virt/coco/Kconfig                |   2 +
 drivers/virt/coco/Makefile               |   1 +
 drivers/virt/coco/arm-cca-host/Kconfig   |  19 +++
 drivers/virt/coco/arm-cca-host/Makefile  |   5 +
 drivers/virt/coco/arm-cca-host/arm-cca.c | 192 +++++++++++++++++++++++
 drivers/virt/coco/arm-cca-host/rmi-da.h  |  41 +++++
 8 files changed, 281 insertions(+)
 create mode 100644 drivers/virt/coco/arm-cca-host/Kconfig
 create mode 100644 drivers/virt/coco/arm-cca-host/Makefile
 create mode 100644 drivers/virt/coco/arm-cca-host/arm-cca.c
 create mode 100644 drivers/virt/coco/arm-cca-host/rmi-da.h

diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
index 2ea657a87402..fe1c91ffc0ab 100644
--- a/arch/arm64/include/asm/rmi_smc.h
+++ b/arch/arm64/include/asm/rmi_smc.h
@@ -12,6 +12,8 @@
 
 #include <linux/arm-smccc.h>
 
+#define RMI_DEV_NAME "arm-rmi-dev"
+
 #define SMC_RMI_CALL(func)				\
 	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
 			   ARM_SMCCC_SMC_64,		\
diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index 3dbf0d067cc5..9cabe750533c 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -15,6 +15,7 @@
 #include <asm/archrandom.h>
 #ifdef CONFIG_ARM64
 #include <asm/rsi_cmds.h>
+#include <asm/rmi_smc.h>
 #endif
 
 static u32 smccc_version = ARM_SMCCC_VERSION_1_0;
@@ -99,10 +100,27 @@ static void __init register_rsi_device(struct platform_device *pdev)
 					"arm_cca_guest", RSI_DEV_NAME, NULL, 0);
 
 }
+
+static void __init register_rmi_device(struct platform_device *pdev)
+{
+	struct arm_smccc_res res;
+	unsigned long host_version = RMI_ABI_VERSION(RMI_ABI_MAJOR_VERSION,
+						     RMI_ABI_MINOR_VERSION);
+
+	arm_smccc_1_1_invoke(SMC_RMI_VERSION, host_version, &res);
+	if (res.a0 == RMI_SUCCESS)
+		__devm_auxiliary_device_create(&pdev->dev,
+					"arm_cca_host", RMI_DEV_NAME, NULL, 0);
+}
 #else
 static void __init register_rsi_device(struct platform_device *pdev)
 {
 
+}
+
+static void __init register_rmi_device(struct platform_device *pdev)
+{
+
 }
 #endif
 
@@ -120,6 +138,7 @@ static int __init smccc_devices_init(void)
 		 * the required SMCCC function IDs at a supported revision.
 		 */
 		register_rsi_device(pdev);
+		register_rmi_device(pdev);
 	}
 
 	if (smccc_trng_available) {
diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index bb0c6d6ddcc8..65b284c59b96 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -15,5 +15,7 @@ source "drivers/virt/coco/arm-cca-guest/Kconfig"
 
 source "drivers/virt/coco/guest/Kconfig"
 
+source "drivers/virt/coco/arm-cca-host/Kconfig"
+
 config TSM
 	bool
diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
index cb52021912b3..c06b66041a49 100644
--- a/drivers/virt/coco/Makefile
+++ b/drivers/virt/coco/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
 obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
 obj-$(CONFIG_TSM) 		+= tsm-core.o
 obj-$(CONFIG_TSM_GUEST)		+= guest/
+obj-$(CONFIG_ARM_CCA_HOST)	+= arm-cca-host/
diff --git a/drivers/virt/coco/arm-cca-host/Kconfig b/drivers/virt/coco/arm-cca-host/Kconfig
new file mode 100644
index 000000000000..1febd316fb77
--- /dev/null
+++ b/drivers/virt/coco/arm-cca-host/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# TSM (TEE Security Manager) host drivers
+#
+config ARM_CCA_HOST
+	tristate "Arm CCA Host driver"
+	depends on ARM64
+	depends on PCI_TSM
+	depends on KVM
+	select TSM
+	select AUXILIARY_BUS
+
+	help
+	  ARM CCA RMM firmware is the trusted runtime that enforces memory
+	  isolation and security for confidential computing on ARM. This driver
+	  provides the interface for communicating with RMM to support secure
+	  device assignment.
+
+	  If you choose 'M' here, this module will be called arm-cca-host.
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
index 000000000000..18e5bf6adea4
--- /dev/null
+++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 ARM Ltd.
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/pci-tsm.h>
+#include <linux/pci-ide.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/tsm.h>
+#include <linux/vmalloc.h>
+#include <linux/cleanup.h>
+#include <linux/kvm_host.h>
+
+#include "rmi-da.h"
+
+/* Total number of stream id supported at root port level */
+#define MAX_STREAM_ID	256
+
+
+static struct pci_tsm *cca_tsm_pci_probe(struct tsm_dev *tsm_dev, struct pci_dev *pdev)
+{
+	int rc;
+
+	if (!is_pci_tsm_pf0(pdev)) {
+		struct cca_host_fn_dsc *fn_dsc __free(kfree) =
+			kzalloc(sizeof(*fn_dsc), GFP_KERNEL);
+
+		if (!fn_dsc)
+			return NULL;
+
+		rc = pci_tsm_link_constructor(pdev, &fn_dsc->pci, tsm_dev);
+		if (rc)
+			return NULL;
+
+		return &no_free_ptr(fn_dsc)->pci;
+	}
+
+	if (!pdev->ide_cap)
+		return NULL;
+
+	struct cca_host_pf0_dsc *pf0_dsc __free(kfree) =
+					kzalloc(sizeof(*pf0_dsc), GFP_KERNEL);
+	if (!pf0_dsc)
+		return NULL;
+
+	rc = pci_tsm_pf0_constructor(pdev, &pf0_dsc->pci, tsm_dev);
+	if (rc)
+		return NULL;
+
+	pci_dbg(pdev, "tsm enabled\n");
+	return &no_free_ptr(pf0_dsc)->pci.base_tsm;
+}
+
+static void cca_tsm_pci_remove(struct pci_tsm *tsm)
+{
+	struct pci_dev *pdev = tsm->pdev;
+
+	if (is_pci_tsm_pf0(pdev)) {
+		struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(pdev);
+
+		pci_tsm_pf0_destructor(&pf0_dsc->pci);
+		kfree(pf0_dsc);
+	} else {
+		struct cca_host_fn_dsc *fn_dsc = to_cca_fn_dsc(pdev);
+
+		kfree(fn_dsc);
+		return;
+	}
+}
+
+/* For now global for simplicity. Protected by pci_tsm_rwsem */
+static DECLARE_BITMAP(cca_stream_ids, MAX_STREAM_ID);
+
+static int cca_tsm_connect(struct pci_dev *pdev)
+{
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	struct cca_host_pf0_dsc *pf0_dsc;
+	struct pci_ide *ide;
+	int rc, stream_id;
+
+	/* Only function 0 supports connect in host */
+	if (WARN_ON(!is_pci_tsm_pf0(pdev)))
+		return -EIO;
+
+	pf0_dsc = to_cca_pf0_dsc(pdev);
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
+	pf0_dsc->sel_stream = ide;
+	ide->stream_id = stream_id;
+	rc = pci_ide_stream_register(ide);
+	if (rc)
+		goto err_stream;
+
+	pci_ide_stream_setup(pdev, ide);
+	pci_ide_stream_setup(rp, ide);
+
+	rc = tsm_ide_stream_register(ide);
+	if (rc)
+		goto err_tsm;
+
+	/*
+	 * Once ide is setup, enable the stream at the endpoint
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
+	int stream_id;
+	struct pci_ide *ide;
+	struct cca_host_pf0_dsc *pf0_dsc;
+
+	pf0_dsc = to_cca_pf0_dsc(pdev);
+	if (!pf0_dsc)
+		return;
+
+	ide = pf0_dsc->sel_stream;
+	stream_id = ide->stream_id;
+	pf0_dsc->sel_stream = NULL;
+
+	pci_ide_stream_release(ide);
+	clear_bit(stream_id, cca_stream_ids);
+}
+
+static struct pci_tsm_ops cca_link_pci_ops = {
+	.probe = cca_tsm_pci_probe,
+	.remove = cca_tsm_pci_remove,
+	.connect = cca_tsm_connect,
+	.disconnect = cca_tsm_disconnect,
+};
+
+static void cca_link_tsm_remove(void *tsm_dev)
+{
+	tsm_unregister(tsm_dev);
+}
+
+static int cca_link_tsm_probe(struct auxiliary_device *adev,
+			      const struct auxiliary_device_id *id)
+{
+	if (kvm_has_da_feature()) {
+		struct tsm_dev *tsm_dev;
+
+		tsm_dev = tsm_register(&adev->dev, &cca_link_pci_ops);
+		if (IS_ERR(tsm_dev))
+			return PTR_ERR(tsm_dev);
+
+		return devm_add_action_or_reset(&adev->dev,
+					cca_link_tsm_remove, tsm_dev);
+	}
+	return -ENODEV;
+}
+
+static const struct auxiliary_device_id cca_link_tsm_id_table[] = {
+	{ .name =  KBUILD_MODNAME "." RMI_DEV_NAME },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, cca_link_tsm_id_table);
+
+static struct auxiliary_driver cca_link_tsm_driver = {
+	.probe = cca_link_tsm_probe,
+	.id_table = cca_link_tsm_id_table,
+};
+module_auxiliary_driver(cca_link_tsm_driver);
+MODULE_IMPORT_NS("PCI_IDE");
+MODULE_AUTHOR("Aneesh Kumar <aneesh.kumar@kernel.org>");
+MODULE_DESCRIPTION("ARM CCA Host TSM driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/virt/coco/arm-cca-host/rmi-da.h b/drivers/virt/coco/arm-cca-host/rmi-da.h
new file mode 100644
index 000000000000..01dfb42cd39e
--- /dev/null
+++ b/drivers/virt/coco/arm-cca-host/rmi-da.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 ARM Ltd.
+ */
+
+#ifndef _VIRT_COCO_RMM_DA_H_
+#define _VIRT_COCO_RMM_DA_H_
+
+#include <linux/pci.h>
+#include <linux/pci-ide.h>
+#include <linux/pci-tsm.h>
+#include <asm/rmi_smc.h>
+
+/* dsc = device security context */
+struct cca_host_pf0_dsc {
+	struct pci_tsm_pf0 pci;
+	struct pci_ide *sel_stream;
+};
+
+struct cca_host_fn_dsc {
+	struct pci_tsm pci;
+};
+
+static inline struct cca_host_pf0_dsc *to_cca_pf0_dsc(struct pci_dev *pdev)
+{
+	struct pci_tsm *tsm = pdev->tsm;
+
+	if (!tsm || pdev->is_virtfn || !is_pci_tsm_pf0(pdev))
+		return NULL;
+
+	return container_of(tsm, struct cca_host_pf0_dsc, pci.base_tsm);
+}
+
+static inline struct cca_host_fn_dsc *to_cca_fn_dsc(struct pci_dev *pdev)
+{
+	struct pci_tsm *tsm = pdev->tsm;
+
+	return container_of(tsm, struct cca_host_fn_dsc, pci);
+}
+
+#endif
-- 
2.43.0


