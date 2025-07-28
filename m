Return-Path: <linux-pci+bounces-33045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3639FB13C3E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60516541835
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845F126D4F6;
	Mon, 28 Jul 2025 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edxZctTq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567AE26D4E1;
	Mon, 28 Jul 2025 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710834; cv=none; b=BXi6QybvkV7KtZ1Wn5ByOpvDoYbGqi0XdKjE5EELELy0fQAcTVr5TEbyRkkMu4dEB7tW+wJ2Jzo3S1ebmxdW39pXQ3xIB6AFqNLKsW83Yh8ywb4xaIVSywLqoomDTcw/kXhttQmyEh47Frn9/gRImNXNTIasRiBSZbQ1aUC6UVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710834; c=relaxed/simple;
	bh=2SwyQ3vlGXa0Nm3vqUWA7biqP68F7YZnLp9tkXwlo4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DH5yQc3zj9JaF/U9H9cfgHXxfs9AzciFNlhxcYBj23y6zpNpR5ZBMgbM7tJzbPtWmb0y/DfOZkWm8qvW97WSzLMKcYPaS2hPGXH5SptmEN5U+xvZsscUcsO4TTCKCsJFGfAbar7lBj7rP2QoRllwLmNAAveW0Bmv7aqaUS3Ic+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edxZctTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34478C4CEE7;
	Mon, 28 Jul 2025 13:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710834;
	bh=2SwyQ3vlGXa0Nm3vqUWA7biqP68F7YZnLp9tkXwlo4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=edxZctTqLQn/0BWxgSyZfk71LkNYxySkxT0ZRaIe8fevY8yJn/N4Rk090WiH5Ss0Y
	 5kiVPtbIifzVsyTxyC2xC34MWOoX8mhBB9ETOtRRDqrNIzLGq2YXqcZ8a0QjNFiu3D
	 i66wCnbzOQDgRNpuYE2fTcjTP/ZyMLZhWp+TjFaGY5l4EaMK9mNa31qbCjSwrNTSeX
	 jLo0g+KlF1Eclf5rDp5KxoaYjC6PpGMeZOt8KuKzje5PCrhxdE7xlEkDF+l0Ph+nrt
	 y3cCThVEZotoIDCW7nGn6sYyTShwjYACx8wg3QPGD3tiuTsBiE9L27horyiWJlm0K+
	 jb94J79keriag==
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
Subject: [RFC PATCH v1 13/38] coco: host: arm64: Create a PDEV with rmm
Date: Mon, 28 Jul 2025 19:21:50 +0530
Message-ID: <20250728135216.48084-14-aneesh.kumar@kernel.org>
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

Create the realm physical device with RMM.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rmi_cmds.h        |  31 +++++
 arch/arm64/include/asm/rmi_smc.h         |  72 ++++++++++-
 drivers/virt/coco/arm-cca-host/Makefile  |   2 +-
 drivers/virt/coco/arm-cca-host/arm-cca.c |  10 +-
 drivers/virt/coco/arm-cca-host/rmm-da.c  | 150 +++++++++++++++++++++++
 drivers/virt/coco/arm-cca-host/rmm-da.h  |   5 +
 6 files changed, 267 insertions(+), 3 deletions(-)
 create mode 100644 drivers/virt/coco/arm-cca-host/rmm-da.c

diff --git a/arch/arm64/include/asm/rmi_cmds.h b/arch/arm64/include/asm/rmi_cmds.h
index ef53147c1984..f0817bd3bab4 100644
--- a/arch/arm64/include/asm/rmi_cmds.h
+++ b/arch/arm64/include/asm/rmi_cmds.h
@@ -505,4 +505,35 @@ static inline int rmi_rtt_unmap_unprotected(unsigned long rd,
 	return res.a0;
 }
 
+static inline unsigned long rmi_pdev_aux_count(unsigned long flags, u64 *aux_count)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RMI_PDEV_AUX_COUNT, flags, &res);
+
+	*aux_count = res.a1;
+	return res.a0;
+}
+
+static inline unsigned long rmi_pdev_create(unsigned long pdev_phys,
+					    unsigned long pdev_params_phys)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RMI_PDEV_CREATE,
+			     pdev_phys, pdev_params_phys, &res);
+
+	return res.a0;
+}
+
+static inline unsigned long rmi_pdev_get_state(unsigned long pdev_phys, unsigned long *state)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RMI_PDEV_GET_STATE, pdev_phys, &res);
+
+	*state = res.a1;
+	return res.a0;
+}
+
 #endif /* __ASM_RMI_CMDS_H */
diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
index 42708d500048..a84ed61e5001 100644
--- a/arch/arm64/include/asm/rmi_smc.h
+++ b/arch/arm64/include/asm/rmi_smc.h
@@ -26,7 +26,7 @@
 #define SMC_RMI_DATA_CREATE		SMC_RMI_CALL(0x0153)
 #define SMC_RMI_DATA_CREATE_UNKNOWN	SMC_RMI_CALL(0x0154)
 #define SMC_RMI_DATA_DESTROY		SMC_RMI_CALL(0x0155)
-
+#define SMC_RMI_PDEV_AUX_COUNT		SMC_RMI_CALL(0x0156)
 #define SMC_RMI_REALM_ACTIVATE		SMC_RMI_CALL(0x0157)
 #define SMC_RMI_REALM_CREATE		SMC_RMI_CALL(0x0158)
 #define SMC_RMI_REALM_DESTROY		SMC_RMI_CALL(0x0159)
@@ -47,6 +47,9 @@
 #define SMC_RMI_RTT_INIT_RIPAS		SMC_RMI_CALL(0x0168)
 #define SMC_RMI_RTT_SET_RIPAS		SMC_RMI_CALL(0x0169)
 
+#define SMC_RMI_PDEV_CREATE             SMC_RMI_CALL(0x0176)
+#define SMC_RMI_PDEV_GET_STATE		SMC_RMI_CALL(0x0178)
+
 #define RMI_ABI_MAJOR_VERSION	1
 #define RMI_ABI_MINOR_VERSION	0
 
@@ -268,4 +271,71 @@ struct rec_run {
 	struct rec_exit exit;
 };
 
+enum rmi_pdev_state {
+	RMI_PDEV_NEW,
+	RMI_PDEV_NEEDS_KEY,
+	RMI_PDEV_HAS_KEY,
+	RMI_PDEV_READY,
+	RMI_PDEV_COMMUNICATING,
+	RMI_PDEV_STOPPING,
+	RMI_PDEV_STOPPED,
+	RMI_PDEV_ERROR,
+};
+
+#define MAX_PDEV_AUX_GRANULES	32
+#define MAX_IOCOH_ADDR_RANGE	16
+#define MAX_FCOH_ADDR_RANGE	4
+
+#define RMI_PDEV_SPDM_TRUE	BIT(0)
+#define RMI_PDEV_IDE_TRUE	BIT(1)
+#define RMI_PDEV_FOCOH		BIT(2)
+#define RMI_PDEV_P2P_STREAM	BIT(3)
+
+#define RMI_HASH_SHA_256	0
+#define RMI_HASH_SHA_512	1
+
+struct rmi_pdev_addr_range {
+	unsigned long base;
+	unsigned long top;
+};
+
+struct rmi_pdev_params {
+	union {
+		struct {
+			u64 flags;
+			u64 pdev_id;
+			u64 segment_id;
+			u64 ecam_addr;
+			u64 root_id;
+			u64 cert_id;
+			u64 rid_base;
+			u64 rid_top;
+			u64 hash_algo;
+			u64 num_aux;
+			u64 ide_sid;
+			u64 ncoh_num_addr_range;
+			u64 coh_num_addr_range;
+		};
+		u8 padding1[0x100];
+	};
+
+	union { /* 0x100 */
+		u64 aux_granule[MAX_PDEV_AUX_GRANULES];
+		u8 padding2[0x100];
+	};
+
+	union { /* 0x200 */
+		struct {
+			struct rmi_pdev_addr_range ncoh_addr_range[MAX_IOCOH_ADDR_RANGE];
+		};
+		u8 padding3[0x100];
+	};
+	union { /* 0x300 */
+		struct {
+			struct rmi_pdev_addr_range coh_addr_range[MAX_FCOH_ADDR_RANGE];
+		};
+		u8 padding4[0x100];
+	};
+};
+
 #endif /* __ASM_RMI_SMC_H */
diff --git a/drivers/virt/coco/arm-cca-host/Makefile b/drivers/virt/coco/arm-cca-host/Makefile
index ad353b07e95a..8409220a6510 100644
--- a/drivers/virt/coco/arm-cca-host/Makefile
+++ b/drivers/virt/coco/arm-cca-host/Makefile
@@ -2,4 +2,4 @@
 #
 obj-$(CONFIG_ARM_CCA_HOST) += arm-cca-host.o
 
-arm-cca-host-$(CONFIG_TSM) +=  arm-cca.o
+arm-cca-host-$(CONFIG_TSM) +=  arm-cca.o rmm-da.o
diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
index c8b0e6db1f47..84d97dd41191 100644
--- a/drivers/virt/coco/arm-cca-host/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
@@ -124,7 +124,15 @@ static int cca_tsm_connect(struct pci_dev *pdev)
 	rc = tsm_ide_stream_register(pdev, ide);
 	if (rc)
 		goto err_tsm;
-
+	/*
+	 * Take a module reference so that we won't call unregister
+	 * without rme_unasign_device
+	 */
+	if (!try_module_get(THIS_MODULE)) {
+		rc = -ENXIO;
+		goto err_tsm;
+	}
+	rme_asign_device(pdev);
 	/*
 	 * Once ide is setup enable the stream at endpoint
 	 * Root port will be done by RMM
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.c b/drivers/virt/coco/arm-cca-host/rmm-da.c
new file mode 100644
index 000000000000..426e530ac182
--- /dev/null
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 ARM Ltd.
+ */
+
+#include <linux/pci.h>
+#include <linux/pci-ecam.h>
+#include <asm/rmi_cmds.h>
+
+#include "rmm-da.h"
+
+static int pci_res_to_pdev_addr(struct rmi_pdev_addr_range *pdev_addr,
+				unsigned int naddr, struct resource *res,
+				unsigned int nres)
+{
+	int i, j;
+
+	for (i = 0, j = 0; i < naddr && j < nres; j++) {
+		if (res[j].flags & IORESOURCE_MEM) {
+			pdev_addr[i].base = res[j].start;
+			pdev_addr[i].top  = res[j].end;
+			i++;
+		}
+	}
+	return i;
+}
+
+static void free_aux_pages(int cnt, void *aux[])
+{
+	int ret;
+
+	while (cnt--) {
+		ret = rmi_granule_undelegate(virt_to_phys(aux[cnt]));
+		if (!ret)
+			free_page((unsigned long)aux[cnt]);
+	}
+}
+
+static int init_pdev_params(struct pci_dev *pdev, struct rmi_pdev_params *params)
+{
+	void *aux;
+	int rid, ret, i;
+	phys_addr_t aux_phys;
+	struct cca_host_dsc_pf0 *dsc_pf0;
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	struct pci_config_window *cfg = pdev->bus->sysdata;
+
+	dsc_pf0 = to_cca_dsc_pf0(pdev);
+	/* assign the ep device with RMM */
+	rid = pci_dev_id(pdev);
+	params->pdev_id = rid;
+	/* slot number for certificate chain */
+	params->cert_id = 0;
+	/* io coherent spdm/ide and non p2p */
+	params->flags = RMI_PDEV_SPDM_TRUE | RMI_PDEV_IDE_TRUE;
+	params->ide_sid = dsc_pf0->sel_stream->stream_id;
+	params->hash_algo = RMI_HASH_SHA_256;
+	/* use the rid and MMIO resources of the epdev */
+	params->rid_top = params->rid_base = rid;
+	params->ecam_addr = cfg->res.start;
+	params->root_id = pci_dev_id(rp);
+
+	params->ncoh_num_addr_range = pci_res_to_pdev_addr(params->ncoh_addr_range,
+							    ARRAY_SIZE(params->ncoh_addr_range),
+							    pdev->resource,
+							    DEVICE_COUNT_RESOURCE);
+
+	rmi_pdev_aux_count(params->flags, &params->num_aux);
+	pr_debug("%s using %ld pdev aux granules\n", __func__, (unsigned long)params->num_aux);
+	dsc_pf0->num_aux = params->num_aux;
+	for (i = 0; i < params->num_aux; i++) {
+		aux = (void *)__get_free_page(GFP_KERNEL);
+		if (!aux) {
+			ret = -ENOMEM;
+			goto err_free_aux;
+		}
+
+		aux_phys = virt_to_phys(aux);
+		if (rmi_granule_delegate(aux_phys)) {
+			ret = -ENXIO;
+			free_page((unsigned long)aux);
+			goto err_free_aux;
+		}
+		params->aux_granule[i] = aux_phys;
+		dsc_pf0->aux[i] = aux;
+	}
+	return 0;
+
+err_free_aux:
+	free_aux_pages(i, dsc_pf0->aux[i]);
+	return -ENOMEM;
+}
+
+
+int rme_asign_device(struct pci_dev *pci_dev)
+{
+	int ret;
+	void *rmm_pdev;
+	unsigned long state;
+	phys_addr_t rmm_pdev_phys;
+	struct rmi_pdev_params *params;
+	struct cca_host_dsc_pf0 *dsc_pf0;
+
+	dsc_pf0 = to_cca_dsc_pf0(pci_dev);
+	rmm_pdev = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!rmm_pdev) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	rmm_pdev_phys = virt_to_phys(rmm_pdev);
+	if (rmi_granule_delegate(rmm_pdev_phys)) {
+		ret = -ENXIO;
+		goto err_free_pdev;
+	}
+
+	params = (struct rmi_pdev_params *)get_zeroed_page(GFP_KERNEL);
+	if (!params) {
+		ret = -ENOMEM;
+		goto err_granule_undelegate;
+	}
+
+	ret = init_pdev_params(pci_dev, params);
+	if (ret)
+		goto err_free_params;
+
+	ret = rmi_pdev_create(rmm_pdev_phys, virt_to_phys(params));
+	pr_info("rmi_pdev_create(0x%llx, 0x%llx): %d\n", rmm_pdev_phys, virt_to_phys(params), ret);
+	if (ret)
+		goto err_free_aux;
+
+	rmi_pdev_get_state(rmm_pdev_phys, &state);
+	if (state != RMI_PDEV_NEW)
+		goto err_free_aux;
+
+	dsc_pf0->rmm_pdev = rmm_pdev;
+	free_page((unsigned long)params);
+	return 0;
+
+err_free_aux:
+	free_aux_pages(dsc_pf0->num_aux, dsc_pf0->aux);
+err_free_params:
+	free_page((unsigned long)params);
+err_granule_undelegate:
+	rmi_granule_undelegate(rmm_pdev_phys);
+err_free_pdev:
+	free_page((unsigned long)rmm_pdev);
+err_out:
+	return ret;
+}
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.h b/drivers/virt/coco/arm-cca-host/rmm-da.h
index 840cb584acdd..179ba68f2430 100644
--- a/drivers/virt/coco/arm-cca-host/rmm-da.h
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.h
@@ -14,6 +14,10 @@
 struct cca_host_dsc_pf0 {
 	struct pci_tsm_pf0 pci;
 	struct pci_ide *sel_stream;
+
+	void *rmm_pdev;
+	int num_aux;
+	void *aux[MAX_PDEV_AUX_GRANULES];
 };
 
 static inline struct cca_host_dsc_pf0 *to_cca_dsc_pf0(struct pci_dev *pdev)
@@ -26,4 +30,5 @@ static inline struct cca_host_dsc_pf0 *to_cca_dsc_pf0(struct pci_dev *pdev)
 	return container_of(tsm, struct cca_host_dsc_pf0, pci.tsm);
 }
 
+int rme_asign_device(struct pci_dev *pdev);
 #endif
-- 
2.43.0


