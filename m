Return-Path: <linux-pci+bounces-39393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD87FC0CCC5
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAFC3BF4C1
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C692FB0A6;
	Mon, 27 Oct 2025 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJlcBNA3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3B72FB098;
	Mon, 27 Oct 2025 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559016; cv=none; b=nH4tjLmTxTKlhE9xi915c9GbONgqVvjUUD14vJ9GJFcmhIfjpZ3dS0x9WVRYf6LUduphjb1QUZKoMjyMs/+Z/u6c1tbaq/GzRDS6ITTx4+8QOJwLJgB/FMWWXu9eulK86DqVJSxUTYRG5x3nlSmRYqMEIHxAEahEhGSze3Q1KCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559016; c=relaxed/simple;
	bh=QyVzkmCjMu/50vNSNAkzNRdjuRbF3e26UinRbPg+dDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1aBmOXB0qCtuMyHmWk1+xuxP/bQVt72Gr+lxcKDDtjOb0Bn9bVPJwHaLr4g/7YfND6/UUkWxXbGmYMVFrbaHApM3vbXEU7d2IlHQYSNXPbCDx7+gS/REOepGDxGwNq9zObhgcfec+MpX2GRgvuzmno88qswELkTf2pdCa7738k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJlcBNA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51040C116B1;
	Mon, 27 Oct 2025 09:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761559016;
	bh=QyVzkmCjMu/50vNSNAkzNRdjuRbF3e26UinRbPg+dDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tJlcBNA3+4Yhov5KrB+mRKl4WzMDTBADx0RsmBLYiwRheSRdZcSPe4wzenu5Rp8G+
	 gxy2JV8nkNLSx0/Wa2flTCWnx6G96RlrJzCAkuD3Lx+JjCkjbsMy3JdF234gBCux3k
	 NOAvxLiyYkqoIKDCOdqDhLDPYSQqGkusR1PTN7oTL7ZGJbwdryQ0wIqIPGe+XN7qwK
	 ChBCfx7QLMwH48Klp8HeStViDS0k5TR337WwYI3pgjvicfqTLD0w129WfpMpIqvghU
	 PuDHVqM0jKywEizMBSkZwG0zQ8LfZ3iAtztXcZtVFRaJoETlQDK02X2hH5ciqLrda9
	 tL+5Wq1CB2Rqg==
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
Subject: [PATCH RESEND v2 05/12] coco: host: arm64: Build and register RMM pdev descriptors
Date: Mon, 27 Oct 2025 15:25:55 +0530
Message-ID: <20251027095602.1154418-6-aneesh.kumar@kernel.org>
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

Add the SMCCC plumbing for RMI_PDEV_AUX_COUNT, RMI_PDEV_CREATE, and
RMI_PDEV_GET_STATE, describe the pdev state enum/flags in rmi_smc.h,
and extend the PF0 descriptor so we can hold the RMM-side pdev handle
plus its auxiliary granules.

Implement pdev_create() to delegate backing pages, populate the pdev
parameters from the device's RID, ECAM window, IDE stream, and
non-coherent address ranges, and invoke RMI_PDEV_CREATE. The helper
keeps track of the allocated/assigned granules and unwinds them on
failure, so the host driver can reliably establish the pdev channel
before kicking off further IDE/TSM setup.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rmi_cmds.h       |  31 ++++++
 arch/arm64/include/asm/rmi_smc.h        |  94 +++++++++++++++-
 drivers/virt/coco/arm-cca-host/Makefile |   2 +-
 drivers/virt/coco/arm-cca-host/rmi-da.c | 141 ++++++++++++++++++++++++
 drivers/virt/coco/arm-cca-host/rmi-da.h |   5 +
 5 files changed, 271 insertions(+), 2 deletions(-)
 create mode 100644 drivers/virt/coco/arm-cca-host/rmi-da.c

diff --git a/arch/arm64/include/asm/rmi_cmds.h b/arch/arm64/include/asm/rmi_cmds.h
index ef53147c1984..4547ce0901a6 100644
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
+static inline unsigned long rmi_pdev_get_state(unsigned long pdev_phys, enum rmi_pdev_state *state)
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
index fe1c91ffc0ab..10f87a18f09a 100644
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
 
@@ -269,4 +272,93 @@ struct rec_run {
 	struct rec_exit exit;
 };
 
+enum rmi_pdev_state {
+	RMI_PDEV_NEW,
+	RMI_PDEV_NEEDS_KEY,
+	RMI_PDEV_HAS_KEY,
+	RMI_PDEV_READY,
+	RMI_PDEV_IDE_RESETTING,
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
+#define RMI_PDEV_FLAGS_SPDM		BIT(0)
+#define RMI_PDEV_FLAGS_NCOH_IDE		BIT(1)
+#define RMI_PDEV_FLAGS_NCOH_ADDR	BIT(2)
+#define RMI_PDEV_FLAGS_COH_IDE		BIT(3)
+#define RMI_PDEV_FLAGS_COH_ADDR		BIT(4)
+#define RMI_PDEV_FLAGS_P2P		BIT(5)
+#define RMI_PDEV_FLAGS_COMP_TRUST	BIT(6)
+#define RMI_PDEV_FLAGS_CATEGORY		GENMASK(8, 7)
+
+#define RMI_PDEV_CMEM_CXL_CATEGORY	BIT(7)
+
+#define RMI_HASH_SHA_256	0
+#define RMI_HASH_SHA_512	1
+
+struct rmi_pdev_addr_range {
+	u64 base;
+	u64 top;
+};
+
+struct rmi_pdev_params {
+	union {
+		struct {
+			u64 flags;
+			u64 pdev_id;
+			union {
+				u8 segment_id;
+				u64 padding0;
+			};
+			u64 ecam_addr;
+			union {
+				u16 root_id;
+				u64 padding1;
+			};
+			u64 cert_id;
+			union {
+				u16 rid_base;
+				u64 padding2;
+			};
+			union {
+				u16 rid_top;
+				u64 padding3;
+			};
+			union {
+				u8 hash_algo;
+				u64 padding4;
+			};
+			u64 num_aux;
+			u64 ncoh_ide_sid;
+			u64 ncoh_num_addr_range;
+			u64 coh_num_addr_range;
+		};
+		u8 padding5[0x100];
+	};
+
+	union { /* 0x100 */
+		u64 aux_granule[MAX_PDEV_AUX_GRANULES];
+		u8 padding6[0x100];
+	};
+
+	union { /* 0x200 */
+		struct {
+			struct rmi_pdev_addr_range ncoh_addr_range[MAX_IOCOH_ADDR_RANGE];
+		};
+		u8 padding7[0x100];
+	};
+	union { /* 0x300 */
+		struct {
+			struct rmi_pdev_addr_range coh_addr_range[MAX_FCOH_ADDR_RANGE];
+		};
+		u8 padding8[0x100];
+	};
+};
+
 #endif /* __ASM_RMI_SMC_H */
diff --git a/drivers/virt/coco/arm-cca-host/Makefile b/drivers/virt/coco/arm-cca-host/Makefile
index ad353b07e95a..a5694a3a7983 100644
--- a/drivers/virt/coco/arm-cca-host/Makefile
+++ b/drivers/virt/coco/arm-cca-host/Makefile
@@ -2,4 +2,4 @@
 #
 obj-$(CONFIG_ARM_CCA_HOST) += arm-cca-host.o
 
-arm-cca-host-$(CONFIG_TSM) +=  arm-cca.o
+arm-cca-host-$(CONFIG_TSM) +=  arm-cca.o rmi-da.o
diff --git a/drivers/virt/coco/arm-cca-host/rmi-da.c b/drivers/virt/coco/arm-cca-host/rmi-da.c
new file mode 100644
index 000000000000..390b8f05c7cf
--- /dev/null
+++ b/drivers/virt/coco/arm-cca-host/rmi-da.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 ARM Ltd.
+ */
+
+#include <linux/pci.h>
+#include <linux/pci-ecam.h>
+#include <asm/rmi_cmds.h>
+
+#include "rmi-da.h"
+
+static int pci_ide_aassoc_register_to_pdev_addr(struct rmi_pdev_addr_range *pdev_addr,
+						unsigned int naddr, struct pci_ide_partner *partner)
+{
+	pdev_addr[0].base = partner->mem_assoc.start;
+	pdev_addr[0].top  = partner->mem_assoc.end + 1;
+	naddr--;
+
+	if (!naddr)
+		return 1;
+
+	pdev_addr[1].base = partner->pref_assoc.start;
+	pdev_addr[1].top  = partner->pref_assoc.end + 1;
+
+	return 2;
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
+	int rid, ret, i;
+	phys_addr_t aux_phys;
+	struct pci_config_window *cfg = pdev->bus->sysdata;
+	struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(pdev);
+	struct pci_ide *ide = pf0_dsc->sel_stream;
+
+	/* assign the ep device with RMM */
+	rid = pci_dev_id(pdev);
+	params->pdev_id = rid;
+	/* slot number for certificate chain */
+	params->cert_id = 0;
+	/* io coherent spdm/ide and non p2p */
+	params->flags = RMI_PDEV_FLAGS_SPDM | RMI_PDEV_FLAGS_NCOH_IDE |
+			RMI_PDEV_FLAGS_NCOH_ADDR;
+	params->ncoh_ide_sid = ide->stream_id;
+	params->hash_algo = RMI_HASH_SHA_256;
+	/* use the rid and MMIO resources of the end point pdev */
+	params->rid_base = rid;
+	params->rid_top = params->rid_base + 1;
+	params->ecam_addr = cfg->res.start;
+	params->root_id = pci_dev_id(pcie_find_root_port(pdev));
+
+	params->ncoh_num_addr_range = pci_ide_aassoc_register_to_pdev_addr(params->ncoh_addr_range,
+								ARRAY_SIZE(params->ncoh_addr_range),
+								&ide->partner[PCI_IDE_RP]);
+
+	rmi_pdev_aux_count(params->flags, &params->num_aux);
+	pf0_dsc->num_aux = params->num_aux;
+	for (i = 0; i < params->num_aux; i++) {
+		void *aux =  (void *)__get_free_page(GFP_KERNEL);
+
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
+		pf0_dsc->aux[i] = aux;
+	}
+	return 0;
+
+err_free_aux:
+	free_aux_pages(i, pf0_dsc->aux);
+	return ret;
+}
+
+int pdev_create(struct pci_dev *pci_dev)
+{
+	int ret;
+	void *rmm_pdev;
+	bool should_free = true;
+	phys_addr_t rmm_pdev_phys;
+	struct rmi_pdev_params *params;
+	struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(pci_dev);
+
+	rmm_pdev = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!rmm_pdev)
+		return -ENOMEM;
+
+	rmm_pdev_phys = virt_to_phys(rmm_pdev);
+	if (rmi_granule_delegate(rmm_pdev_phys)) {
+		ret = -ENXIO;
+		goto err_granule_delegate;
+	}
+
+	params = (struct rmi_pdev_params *)get_zeroed_page(GFP_KERNEL);
+	if (!params) {
+		ret = -ENOMEM;
+		goto err_param_alloc;
+	}
+
+	ret = init_pdev_params(pci_dev, params);
+	if (ret)
+		goto err_init_pdev_params;
+
+	ret = rmi_pdev_create(rmm_pdev_phys, virt_to_phys(params));
+	if (ret)
+		goto err_pdev_create;
+
+	pf0_dsc->rmm_pdev = rmm_pdev;
+	free_page((unsigned long)params);
+	return 0;
+
+err_pdev_create:
+	free_aux_pages(pf0_dsc->num_aux, pf0_dsc->aux);
+err_init_pdev_params:
+	free_page((unsigned long)params);
+err_param_alloc:
+	if (rmi_granule_undelegate(rmm_pdev_phys))
+		should_free = false;
+err_granule_delegate:
+	if (should_free)
+		free_page((unsigned long)rmm_pdev);
+	return ret;
+}
diff --git a/drivers/virt/coco/arm-cca-host/rmi-da.h b/drivers/virt/coco/arm-cca-host/rmi-da.h
index 01dfb42cd39e..6764bf8d98ce 100644
--- a/drivers/virt/coco/arm-cca-host/rmi-da.h
+++ b/drivers/virt/coco/arm-cca-host/rmi-da.h
@@ -15,6 +15,10 @@
 struct cca_host_pf0_dsc {
 	struct pci_tsm_pf0 pci;
 	struct pci_ide *sel_stream;
+
+	void *rmm_pdev;
+	int num_aux;
+	void *aux[MAX_PDEV_AUX_GRANULES];
 };
 
 struct cca_host_fn_dsc {
@@ -38,4 +42,5 @@ static inline struct cca_host_fn_dsc *to_cca_fn_dsc(struct pci_dev *pdev)
 	return container_of(tsm, struct cca_host_fn_dsc, pci);
 }
 
+int pdev_create(struct pci_dev *pdev);
 #endif
-- 
2.43.0


