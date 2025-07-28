Return-Path: <linux-pci+bounces-33056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1221B13C56
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0658D188737B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B66272E68;
	Mon, 28 Jul 2025 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puHPfETZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4F51FBE9B;
	Mon, 28 Jul 2025 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710900; cv=none; b=uHiylAzqqgSIkXIa2MCKB05mheVfQyagkkutOAxKlA/5CPG5aFIENK0Q6fB3o/d7fgc5gxJZOJ8vIJ+DqAlgMqksi+v5vf6C4nSmVV/9UCV9WVbqA4StkmEuvXyA8uU4VbqVC9eYkjwnMzqVApWWfctXBi5r53/gtqYUkPZHmDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710900; c=relaxed/simple;
	bh=XSrCT05HbDUDeu8oleh4pmbLFUEXF7PC0mWM5VkwuCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSotZnedjXE3BDWXwaUrXfsMTfTrpBAXoI59htPXK6V1E9+wmgmM73TV0p9ZVKWUOPrACaN/IA4BdKrjoMvsC7eH5hWd4tkkBBQOHWuw3gsj9vZp/roqpzXpiSXcRWNxh2LQJT9BXFBjdABO4htBEBa/ESyn3ko2j9hJxUFZPso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puHPfETZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292BDC4CEFB;
	Mon, 28 Jul 2025 13:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710900;
	bh=XSrCT05HbDUDeu8oleh4pmbLFUEXF7PC0mWM5VkwuCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=puHPfETZ1gMQhA8IT3G5aX6ltI3YA+g/BgIE8eYx1ogB2suYv9YYwOTk2n9J3RbTN
	 qTZW9e3i8JUfBzfLGUDtEoo0zI64maAZUb3x3HV5Qd98FPblNspaPa6tovGwi50wk4
	 Q/kBY5exgSrYQ6AR9+NxPLvbm4kTIFmaDLYfONO4m+iIG/qMjYTzHw8839yYycfMf4
	 +j7GcoCSvk2X++9WlcE0qLEj6UoJ2ydrYtWgWn8aAVOgKOiLpbbevZx4TDdFpWZcde
	 FpQt2r0CaJ+eTawIoNh6HnJfrwAry32sqsWH33QmZJQetXW/3AfhEe3e9fmp3UJcm2
	 XEUM11EBoroZg==
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
Subject: [RFC PATCH v1 24/38] arm64: CCA: Register guest tsm callback
Date: Mon, 28 Jul 2025 19:22:01 +0530
Message-ID: <20250728135216.48084-25-aneesh.kumar@kernel.org>
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

Register the TSM callback if the DA feature is supported by RSI.

Additionally, adjust the build order so that the TSM class is created
before the arm-cca-guest driver initialization.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rsi.h              |  3 +
 arch/arm64/include/asm/rsi_cmds.h         | 18 ++++++
 arch/arm64/include/asm/rsi_smc.h          |  1 +
 arch/arm64/kernel/rsi.c                   | 24 ++++++--
 drivers/virt/coco/Makefile                |  2 +-
 drivers/virt/coco/arm-cca-guest/Kconfig   |  8 ++-
 drivers/virt/coco/arm-cca-guest/arm-cca.c | 71 ++++++++++++++++++++++-
 drivers/virt/coco/arm-cca-guest/rsi-da.h  | 27 +++++++++
 8 files changed, 144 insertions(+), 10 deletions(-)
 create mode 100644 drivers/virt/coco/arm-cca-guest/rsi-da.h

diff --git a/arch/arm64/include/asm/rsi.h b/arch/arm64/include/asm/rsi.h
index 26ef6143562b..35dfbba4767b 100644
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
index 2c8763876dfb..d4834baeef1b 100644
--- a/arch/arm64/include/asm/rsi_cmds.h
+++ b/arch/arm64/include/asm/rsi_cmds.h
@@ -159,4 +159,22 @@ static inline unsigned long rsi_attestation_token_continue(phys_addr_t granule,
 	return res.a0;
 }
 
+/**
+ * rsi_features() - Read feature register
+ * @index: Feature register index
+ * @out: Feature register value is written to this pointer
+ *
+ * Return: RSI return code
+ */
+static inline int rsi_features(unsigned long index, unsigned long *out)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RSI_FEATURES, index, &res);
+
+	if (out)
+		*out = res.a1;
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
index bf9ea99e2aa1..ef06c083990a 100644
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
+	return !!u64_get_bits(rsi_feat_reg0, RSI_FEATURE_REGISTER_0_DA);
+}
+EXPORT_SYMBOL_GPL(rsi_has_da_feature);
+
 bool cc_platform_has(enum cc_attr attr)
 {
 	switch (attr) {
@@ -128,6 +135,10 @@ void __init arm64_rsi_init(void)
 		return;
 	if (WARN_ON(rsi_get_realm_config(&config)))
 		return;
+
+	if (WARN_ON(rsi_features(0, &rsi_feat_reg0)))
+		return;
+
 	prot_ns_shared = BIT(config.ipa_bits - 1);
 
 	if (arm64_ioremap_prot_hook_register(realm_ioremap_hook))
@@ -141,17 +152,18 @@ void __init arm64_rsi_init(void)
 	static_branch_enable(&rsi_present);
 }
 
-static struct platform_device rsi_dev = {
+static struct platform_device cca_guest_dev = {
 	.name = RSI_DEV_NAME,
 	.id = PLATFORM_DEVID_NONE
 };
 
-static int __init arm64_create_dummy_rsi_dev(void)
+static int __init arm64_create_cca_guest_dev(void)
 {
-	if (is_realm_world() &&
-	    platform_device_register(&rsi_dev))
-		pr_err("failed to register rsi platform device\n");
+	if (is_realm_world()) {
+		if (!platform_device_register(&cca_guest_dev))
+			pr_info("CCA guest platform device registered.\n");
+	}
 	return 0;
 }
 
-arch_initcall(arm64_create_dummy_rsi_dev)
+device_initcall(arm64_create_cca_guest_dev)
diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
index d0a859dd9eaf..4264ee367b3b 100644
--- a/drivers/virt/coco/Makefile
+++ b/drivers/virt/coco/Makefile
@@ -7,8 +7,8 @@ obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
 obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
 obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
-obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
 
 obj-$(CONFIG_TSM) 		+= tsm-core.o
 obj-y				+= guest/
+obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
 obj-$(CONFIG_ARM_CCA_HOST)	+= arm-cca-host/
diff --git a/drivers/virt/coco/arm-cca-guest/Kconfig b/drivers/virt/coco/arm-cca-guest/Kconfig
index 3f0f013f03f1..410d9c3fb2b3 100644
--- a/drivers/virt/coco/arm-cca-guest/Kconfig
+++ b/drivers/virt/coco/arm-cca-guest/Kconfig
@@ -1,10 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
 config ARM_CCA_GUEST
 	tristate "Arm CCA Guest driver"
 	depends on ARM64
+	depends on PCI_TSM
 	select TSM_REPORTS
+	select TSM
 	help
-	  The driver provides userspace interface to request and
+	  The driver provides userspace interface to request an
 	  attestation report from the Realm Management Monitor(RMM).
+	  If the DA feature is supported, it also register with TSM framework.
 
 	  If you choose 'M' here, this module will be called
 	  arm-cca-guest.
diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
index 547fc2c79f7d..3adbbd67e06e 100644
--- a/drivers/virt/coco/arm-cca-guest/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2023 ARM Ltd.
+ * Copyright (C) 2025 ARM Ltd.
  */
 
 #include <linux/arm-smccc.h>
@@ -15,6 +15,8 @@
 
 #include <asm/rsi.h>
 
+#include "rsi-da.h"
+
 /**
  * struct arm_cca_token_info - a descriptor for the token buffer.
  * @challenge:		Pointer to the challenge data
@@ -192,6 +194,60 @@ static void unregister_cca_tsm_report(void *data)
 	tsm_report_unregister(&arm_cca_tsm_report_ops);
 }
 
+static struct pci_tsm *cca_tsm_pci_probe(struct pci_dev *pdev)
+{
+	struct cca_guest_dsc *cca_dsc __free(kfree);
+
+	if (!is_pci_tsm_pf0(pdev))
+		return NULL;
+
+	cca_dsc = kzalloc(sizeof(*cca_dsc), GFP_KERNEL);
+	if (!cca_dsc)
+		return NULL;
+
+	if (pci_tsm_pf0_initialize(pdev, &cca_dsc->pci))
+		return NULL;
+
+	pci_info(pdev, "Guest tsm enabled\n");
+	return &no_free_ptr(cca_dsc)->pci.tsm;
+}
+
+static void cca_tsm_pci_remove(struct pci_tsm *tsm)
+{
+	struct cca_guest_dsc *cca_dsc = to_cca_guest_dsc(tsm->pdev);
+
+	pci_dbg(tsm->pdev, "tsm disabled\n");
+	kfree(cca_dsc);
+}
+
+static const struct pci_tsm_ops cca_pci_ops = {
+	.probe = cca_tsm_pci_probe,
+	.remove = cca_tsm_pci_remove,
+};
+
+static void cca_tsm_unregister(void *tsm)
+{
+	tsm_unregister(tsm);
+}
+
+static int cca_tsm_register(struct platform_device *pdev)
+{
+	struct tsm_core_dev *tsm_core;
+	int rc;
+
+	tsm_core = tsm_register(&pdev->dev, NULL, &cca_pci_ops);
+	if (IS_ERR(tsm_core))
+		return PTR_ERR(tsm_core);
+
+	rc = devm_add_action_or_reset(&pdev->dev, cca_tsm_unregister, tsm_core);
+	if (rc) {
+		cca_tsm_unregister(tsm_core);
+		return rc;
+	}
+
+	return 0;
+}
+
 static int cca_guest_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -200,11 +256,22 @@ static int cca_guest_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	ret = tsm_report_register(&arm_cca_tsm_report_ops, NULL);
-	if (ret < 0)
+	if (ret < 0) {
 		pr_err("Error %d registering with TSM\n", ret);
+		goto err_out;
+	}
 
 	ret = devm_add_action_or_reset(&pdev->dev, unregister_cca_tsm_report, NULL);
+	if (ret < 0) {
+		pr_err("Error %d registering devm action\n", ret);
+		unregister_cca_tsm_report(NULL);
+		goto err_out;
+	}
+
+	if (rsi_has_da_feature())
+		ret = cca_tsm_register(pdev);
 
+err_out:
 	return ret;
 }
 
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
new file mode 100644
index 000000000000..8a4d5f1b0263
--- /dev/null
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 ARM Ltd.
+ */
+
+#ifndef RSI_DA_H_
+#define RSI_DA_H_
+
+#include <linux/pci.h>
+#include <linux/pci-tsm.h>
+#include <asm/rsi_smc.h>
+
+
+struct cca_guest_dsc {
+	struct pci_tsm_pf0 pci;
+};
+
+static inline struct cca_guest_dsc *to_cca_guest_dsc(struct pci_dev *pdev)
+{
+	struct pci_tsm *tsm = pdev->tsm;
+
+	if (!tsm)
+		return NULL;
+	return container_of(tsm, struct cca_guest_dsc, pci.tsm);
+}
+
+#endif
-- 
2.43.0


