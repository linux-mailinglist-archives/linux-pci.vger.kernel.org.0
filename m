Return-Path: <linux-pci+bounces-41408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82B4C648A6
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 15:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9B93ACFEF
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 14:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA42A33342E;
	Mon, 17 Nov 2025 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERNEqSn/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B634323ABBE;
	Mon, 17 Nov 2025 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388026; cv=none; b=dcREW2KVS3O3RDuZCWISk5YJDKQnUdlPVhDvTUzY9D0IkDJObapPzOddWCk8/5yVO7XvkIsy7V3752MzIFXzRGVsvF6y29iqvwzBNTpefngy2ZFWeTVTzhKEBE1IngbgsKDdAaFFa6bRa6adVhyYz1SwiKL/uZ2qc3MGEeACh6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388026; c=relaxed/simple;
	bh=/aH15OSMAV10WoTY6Mh5z6rWizKj4fULVUZZPJBmHnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtCTDScCKn+rv0oqloqsOFKkjhnTAkwm7jPvNbndqpGMRFV0eI6prFwTWFZIvWkxEx6Dkf6gACrLU7L1+KRc9ylkVfsxNYZHEXI3/Fy2hx/QSuoWo8wakLlRsl28LpCKs9e2uNkDpYp3HnujHqxGAo2h15A8ABCLsiXo0lAVo2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERNEqSn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3870BC19424;
	Mon, 17 Nov 2025 14:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763388026;
	bh=/aH15OSMAV10WoTY6Mh5z6rWizKj4fULVUZZPJBmHnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ERNEqSn/W/O6E3RWeVVtNElQgmbIvjTTJzSIjxYjc0M3QniGZRDPluYnOLEp4utKS
	 45zEBM7inHpZPogLEUoWeMzOL0jC0yjdBxjoF9JeYhdXteOKdbkFTekc2xK7sHKgdD
	 ORdVEFlVZSrE+7+E8Py+65NkGkQrG20z9udQNY+u2vkJtDWwlHjdNdASh0ZgmaiYXp
	 FQYibZEpsSVLQZAnZa2jZUJvle9wOiv7ZaDAP4lFzHcrVIQaoSl0fAEXNwNn32ET3k
	 1S0EM7j+2MSYgoH8guLKk0bTEPXhEA4eq2NldLXUBVx1/zHua+XkoVysypEmm3Wdqe
	 P1DCmIiSvU+fw==
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
Subject: [PATCH v2 01/11] coco: guest: arm64: Guest TSM callback and realm device lock support
Date: Mon, 17 Nov 2025 19:29:57 +0530
Message-ID: <20251117140007.122062-2-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117140007.122062-1-aneesh.kumar@kernel.org>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register the TSM callback when the DA feature is supported by RSI. The
build order is also adjusted so that the TSM class is created before the
arm-cca-guest driver is initialized.

In addition, add support for the TDISP lock sequence. Writing a TSM
(TEE Security Manager) device name from `/sys/class/tsm` into `tsm/lock`
triggers the realm device lock operation.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rsi.h              |  3 ++
 arch/arm64/include/asm/rsi_cmds.h         | 17 +++++++
 arch/arm64/include/asm/rsi_smc.h          |  1 +
 arch/arm64/kernel/rsi.c                   | 11 +++++
 drivers/virt/coco/Makefile                |  2 +-
 drivers/virt/coco/arm-cca-guest/Kconfig   |  8 ++-
 drivers/virt/coco/arm-cca-guest/Makefile  |  1 +
 drivers/virt/coco/arm-cca-guest/arm-cca.c | 60 ++++++++++++++++++++++-
 drivers/virt/coco/arm-cca-guest/rsi-da.h  | 32 ++++++++++++
 9 files changed, 132 insertions(+), 3 deletions(-)
 create mode 100644 drivers/virt/coco/arm-cca-guest/rsi-da.h

diff --git a/arch/arm64/include/asm/rsi.h b/arch/arm64/include/asm/rsi.h
index 2d2d363aaaee..12ccd1ed3dfa 100644
--- a/arch/arm64/include/asm/rsi.h
+++ b/arch/arm64/include/asm/rsi.h
@@ -67,4 +67,7 @@ static inline int rsi_set_memory_range_shared(phys_addr_t start,
 	return rsi_set_memory_range(start, end, RSI_RIPAS_EMPTY,
 				    RSI_CHANGE_DESTROYED);
 }
+
+bool rsi_has_da_feature(void);
+
 #endif /* __ASM_RSI_H_ */
diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
index 2c8763876dfb..6c2db7a24ef3 100644
--- a/arch/arm64/include/asm/rsi_cmds.h
+++ b/arch/arm64/include/asm/rsi_cmds.h
@@ -159,4 +159,21 @@ static inline unsigned long rsi_attestation_token_continue(phys_addr_t granule,
 	return res.a0;
 }
 
+/**
+ * rsi_features() - Read feature register
+ * @index: Feature register index
+ * @out: Feature register value is written to this pointer
+ *
+ * Return: RSI return code
+ */
+static inline unsigned long rsi_features(unsigned long index, unsigned long *out)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RSI_FEATURES, index, &res);
+
+	*out = res.a1;
+	return res.a0;
+}
+
 #endif /* __ASM_RSI_CMDS_H */
diff --git a/arch/arm64/include/asm/rsi_smc.h b/arch/arm64/include/asm/rsi_smc.h
index 6cb070eca9e9..8e486cdef9eb 100644
--- a/arch/arm64/include/asm/rsi_smc.h
+++ b/arch/arm64/include/asm/rsi_smc.h
@@ -53,6 +53,7 @@
  */
 #define SMC_RSI_ABI_VERSION	SMC_RSI_FID(0x190)
 
+#define RSI_FEATURE_REGISTER_0_DA		BIT(0)
 /*
  * Read feature register.
  *
diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
index 1b716d18b80e..2ec0f5dff02e 100644
--- a/arch/arm64/kernel/rsi.c
+++ b/arch/arm64/kernel/rsi.c
@@ -15,6 +15,7 @@
 #include <asm/rsi.h>
 
 static struct realm_config config;
+static unsigned long rsi_feat_reg0;
 
 unsigned long prot_ns_shared;
 EXPORT_SYMBOL(prot_ns_shared);
@@ -22,6 +23,12 @@ EXPORT_SYMBOL(prot_ns_shared);
 DEFINE_STATIC_KEY_FALSE_RO(rsi_present);
 EXPORT_SYMBOL(rsi_present);
 
+bool rsi_has_da_feature(void)
+{
+	return u64_get_bits(rsi_feat_reg0, RSI_FEATURE_REGISTER_0_DA);
+}
+EXPORT_SYMBOL_GPL(rsi_has_da_feature);
+
 bool cc_platform_has(enum cc_attr attr)
 {
 	switch (attr) {
@@ -146,6 +153,10 @@ void __init arm64_rsi_init(void)
 		return;
 	if (WARN_ON(rsi_get_realm_config(&config)))
 		return;
+
+	if (WARN_ON(rsi_features(0, &rsi_feat_reg0)))
+		return;
+
 	prot_ns_shared = BIT(config.ipa_bits - 1);
 
 	if (arm64_ioremap_prot_hook_register(realm_ioremap_hook))
diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
index cb52021912b3..57556d7c1cec 100644
--- a/drivers/virt/coco/Makefile
+++ b/drivers/virt/coco/Makefile
@@ -6,6 +6,6 @@ obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
 obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
 obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
-obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
 obj-$(CONFIG_TSM) 		+= tsm-core.o
 obj-$(CONFIG_TSM_GUEST)		+= guest/
+obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
diff --git a/drivers/virt/coco/arm-cca-guest/Kconfig b/drivers/virt/coco/arm-cca-guest/Kconfig
index a42359a90558..66b2d9202b66 100644
--- a/drivers/virt/coco/arm-cca-guest/Kconfig
+++ b/drivers/virt/coco/arm-cca-guest/Kconfig
@@ -1,11 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 config ARM_CCA_GUEST
 	tristate "Arm CCA Guest driver"
 	depends on ARM64
+	depends on PCI_TSM
 	select TSM_REPORTS
 	select AUXILIARY_BUS
+	select TSM
 	help
-	  The driver provides userspace interface to request and
+	  The driver provides userspace interface to request an
 	  attestation report from the Realm Management Monitor(RMM).
+	  If the DA feature is supported, it also register with TSM framework.
 
 	  If you choose 'M' here, this module will be called
 	  arm-cca-guest.
diff --git a/drivers/virt/coco/arm-cca-guest/Makefile b/drivers/virt/coco/arm-cca-guest/Makefile
index 75a120e24fda..bc3b2be4019f 100644
--- a/drivers/virt/coco/arm-cca-guest/Makefile
+++ b/drivers/virt/coco/arm-cca-guest/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+#
 obj-$(CONFIG_ARM_CCA_GUEST) += arm-cca-guest.o
 
 arm-cca-guest-y +=  arm-cca.o
diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
index dc96171791db..288fa53ad0af 100644
--- a/drivers/virt/coco/arm-cca-guest/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2023 ARM Ltd.
+ * Copyright (C) 2025 ARM Ltd.
  */
 
 #include <linux/auxiliary_bus.h>
@@ -15,6 +15,8 @@
 
 #include <asm/rsi.h>
 
+#include "rsi-da.h"
+
 /**
  * struct arm_cca_token_info - a descriptor for the token buffer.
  * @challenge:		Pointer to the challenge data
@@ -192,6 +194,57 @@ static void unregister_cca_tsm_report(void *data)
 	tsm_report_unregister(&arm_cca_tsm_report_ops);
 }
 
+static struct pci_tsm *cca_tsm_lock(struct tsm_dev *tsm_dev, struct pci_dev *pdev)
+{
+	int ret;
+
+	struct cca_guest_dsc *cca_dsc __free(kfree) =
+		kzalloc(sizeof(*cca_dsc), GFP_KERNEL);
+	if (!cca_dsc)
+		return ERR_PTR(-ENOMEM);
+
+	ret = pci_tsm_devsec_constructor(pdev, &cca_dsc->pci, tsm_dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return ERR_PTR(-EIO);
+}
+
+static void cca_tsm_unlock(struct pci_tsm *tsm)
+{
+	struct cca_guest_dsc *cca_dsc = to_cca_guest_dsc(tsm->pdev);
+
+	kfree(cca_dsc);
+}
+
+static struct pci_tsm_ops cca_devsec_pci_ops = {
+	.lock = cca_tsm_lock,
+	.unlock = cca_tsm_unlock,
+};
+
+static void cca_devsec_tsm_remove(void *tsm_dev)
+{
+	tsm_unregister(tsm_dev);
+}
+
+static int cca_devsec_tsm_register(struct auxiliary_device *adev)
+{
+	struct tsm_dev *tsm_dev;
+	int rc;
+
+	tsm_dev = tsm_register(&adev->dev, &cca_devsec_pci_ops);
+	if (IS_ERR(tsm_dev))
+		return PTR_ERR(tsm_dev);
+
+	rc = devm_add_action_or_reset(&adev->dev, cca_devsec_tsm_remove, tsm_dev);
+	if (rc) {
+		cca_devsec_tsm_remove(tsm_dev);
+		return rc;
+	}
+
+	return 0;
+}
+
 static int cca_devsec_tsm_probe(struct auxiliary_device *adev,
 				const struct auxiliary_device_id *id)
 {
@@ -212,6 +265,10 @@ static int cca_devsec_tsm_probe(struct auxiliary_device *adev,
 		return ret;
 	}
 
+	/* Allow tsm report even if tsm_register fails */
+	if (rsi_has_da_feature())
+		cca_devsec_tsm_register(adev);
+
 	return 0;
 }
 
@@ -227,5 +284,6 @@ static struct auxiliary_driver cca_devsec_tsm_driver = {
 };
 module_auxiliary_driver(cca_devsec_tsm_driver);
 MODULE_AUTHOR("Sami Mujawar <sami.mujawar@arm.com>");
+MODULE_AUTHOR("Aneesh Kumar <aneesh.kumar@kernel.org>");
 MODULE_DESCRIPTION("Arm CCA Guest TSM Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
new file mode 100644
index 000000000000..5ad3b740710e
--- /dev/null
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 ARM Ltd.
+ */
+
+#ifndef _VIRT_COCO_RSI_DA_H_
+#define _VIRT_COCO_RSI_DA_H_
+
+#include <linux/pci.h>
+#include <linux/pci-tsm.h>
+#include <asm/rsi_smc.h>
+
+struct cca_guest_dsc {
+	struct pci_tsm_devsec pci;
+};
+
+static inline struct cca_guest_dsc *to_cca_guest_dsc(struct pci_dev *pdev)
+{
+	struct pci_tsm *tsm = pdev->tsm;
+
+	if (!tsm)
+		return NULL;
+	return container_of(tsm, struct cca_guest_dsc, pci.base_tsm);
+}
+
+static inline int rsi_vdev_id(struct pci_dev *pdev)
+{
+	return (pci_domain_nr(pdev->bus) << 16) |
+	       PCI_DEVID(pdev->bus->number, pdev->devfn);
+}
+
+#endif
-- 
2.43.0


