Return-Path: <linux-pci+bounces-33057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82CAB13C60
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C2C170EA5
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93872797BD;
	Mon, 28 Jul 2025 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBtlceBu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D23B270EAB;
	Mon, 28 Jul 2025 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710906; cv=none; b=MLEY/6Gf7PLAWM6i4WzJipXuXF6yBizdzZcFkWlp+oOiFA0CHQ+j5rx7qCSTIP/uqkM/IWY33EhspRbtr9yYZ1d3RAmbH2F/nldde2agoHkGutnGhARuqnfPw7i8W+4S4Qp48MSnG7/+/aTO0ZNeyvSBofsr2dTL3zEj+GhHoss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710906; c=relaxed/simple;
	bh=Lk97WGWsKchJQr3PhJmRHtHWylEzWXYJvraenT8o+zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvzDAQNKVnwm1wWV97eSlBgHMnzNi1PyuKW0OkrE7vFcv3a7ZDd+V+gT2RUGDy/urJcrQxW+vl4xNIRB1BcfijmDbETvaYk2yNcNLReppxDrGs4GPH8dPFmJ22LteWBdAM/vz1clCzKos7TejW9SlAxZpsiU5cZhqJGV8rwlH9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBtlceBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B744BC113CF;
	Mon, 28 Jul 2025 13:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710906;
	bh=Lk97WGWsKchJQr3PhJmRHtHWylEzWXYJvraenT8o+zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dBtlceBu4lEJlJk1f8YMPlJuJwJf1Pbb9RnV1xOX1lvTAoOsXFK5tvjBHVCZliISu
	 ivvQ0Inly0gRb+H4cGlW4aev7UzJWtTG9Pv9Dm9KN0nMOgRl5pUUvDphUnlGzkc1F4
	 O+Ehu7jBIVZMnjt8x/g8c6TRrZbRgtlq+S208FXofV4bCHnu2vI65Q5oJANN/2ge+Y
	 J4S0QNOIsjuYwFvaXHpdymPV43vBpBH8qfDiR7vwe8CshlgbhlmPrh9QGojbo/ZUEz
	 lcYuTLosxkYgfAUxzRnPpSgQifBZMRWlkO2/C4H+4Mmz37S/+lNyHaAUmZLhtQSbjD
	 5bmUqOh2zdNaQ==
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
Subject: [RFC PATCH v1 25/38] cca: guest: arm64: Realm device lock support
Date: Mon, 28 Jul 2025 19:22:02 +0530
Message-ID: <20250728135216.48084-26-aneesh.kumar@kernel.org>
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

Writing 1 to 'tsm/lock' will initiate the TDISP lock sequence.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rsi_cmds.h         | 32 +++++++++++++-
 arch/arm64/include/asm/rsi_smc.h          |  5 +++
 drivers/virt/coco/arm-cca-guest/Makefile  |  2 +-
 drivers/virt/coco/arm-cca-guest/arm-cca.c | 18 ++++++++
 drivers/virt/coco/arm-cca-guest/rsi-da.c  | 52 +++++++++++++++++++++++
 drivers/virt/coco/arm-cca-guest/rsi-da.h  |  3 +-
 6 files changed, 108 insertions(+), 4 deletions(-)
 create mode 100644 drivers/virt/coco/arm-cca-guest/rsi-da.c

diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
index d4834baeef1b..b9c4b8ff5631 100644
--- a/arch/arm64/include/asm/rsi_cmds.h
+++ b/arch/arm64/include/asm/rsi_cmds.h
@@ -172,8 +172,36 @@ static inline int rsi_features(unsigned long index, unsigned long *out)
 
 	arm_smccc_1_1_invoke(SMC_RSI_FEATURES, index, &res);
 
-	if (out)
-		*out = res.a1;
+	*out = res.a1;
+	return res.a0;
+}
+
+static inline unsigned long rsi_rdev_get_instance_id(unsigned long vdev_id, unsigned long *inst_id)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RSI_RDEV_GET_INSTANCE_ID, vdev_id, &res);
+
+	*inst_id = res.a1;
+	return res.a0;
+}
+
+static inline unsigned long __rsi_rdev_lock(unsigned long vdev_id, unsigned long inst_id)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RSI_RDEV_LOCK, vdev_id, inst_id, &res);
+
+	return res.a0;
+}
+
+
+static inline unsigned long rsi_rdev_continue(unsigned long vdev_id, unsigned long inst_id)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RSI_RDEV_CONTINUE, vdev_id, inst_id, &res);
+
 	return res.a0;
 }
 
diff --git a/arch/arm64/include/asm/rsi_smc.h b/arch/arm64/include/asm/rsi_smc.h
index 8e486cdef9eb..44b583ab6d67 100644
--- a/arch/arm64/include/asm/rsi_smc.h
+++ b/arch/arm64/include/asm/rsi_smc.h
@@ -191,4 +191,9 @@ struct realm_config {
  */
 #define SMC_RSI_HOST_CALL			SMC_RSI_FID(0x199)
 
+#define SMC_RSI_RDEV_GET_INSTANCE_ID		SMC_RSI_FID(0x19c)
+#define SMC_RSI_RDEV_CONTINUE			SMC_RSI_FID(0x1a4)
+
+#define SMC_RSI_RDEV_LOCK			SMC_RSI_FID(0x1a9)
+
 #endif /* __ASM_RSI_SMC_H_ */
diff --git a/drivers/virt/coco/arm-cca-guest/Makefile b/drivers/virt/coco/arm-cca-guest/Makefile
index 609462ea9438..341c7b37d610 100644
--- a/drivers/virt/coco/arm-cca-guest/Makefile
+++ b/drivers/virt/coco/arm-cca-guest/Makefile
@@ -2,4 +2,4 @@
 #
 obj-$(CONFIG_ARM_CCA_GUEST) += arm-cca-guest.o
 
-arm-cca-guest-$(CONFIG_TSM) +=  arm-cca.o
+arm-cca-guest-$(CONFIG_TSM) +=  arm-cca.o rsi-da.o
diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
index 3adbbd67e06e..2c0190bcb2a9 100644
--- a/drivers/virt/coco/arm-cca-guest/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
@@ -220,9 +220,27 @@ static void cca_tsm_pci_remove(struct pci_tsm *tsm)
 	kfree(cca_dsc);
 }
 
+static int cca_tsm_lock(struct pci_dev *pdev)
+{
+	unsigned long ret;
+
+	ret = rsi_device_lock(pdev);
+	if (ret) {
+		pci_err(pdev, "failed to lock the device (%lu)\n", ret);
+		return -EIO;
+	}
+	return 0;
+}
+
+static void cca_tsm_unlock(struct pci_dev *pdev)
+{
+}
+
 static const struct pci_tsm_ops cca_pci_ops = {
 	.probe = cca_tsm_pci_probe,
 	.remove = cca_tsm_pci_remove,
+	.lock = cca_tsm_lock,
+	.unlock = cca_tsm_unlock,
 };
 
 static void cca_tsm_unregister(void *tsm)
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
new file mode 100644
index 000000000000..097cf52ee199
--- /dev/null
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 ARM Ltd.
+ */
+
+#include <linux/pci.h>
+#include <asm/rsi_cmds.h>
+
+#include "rsi-da.h"
+
+#define PCI_TDISP_MESSAGE_VERSION_10	0x10
+
+static inline unsigned long rsi_rdev_lock(struct pci_dev *pdev,
+					  unsigned long vdev_id, unsigned long inst_id)
+{
+	unsigned long ret;
+
+	ret = __rsi_rdev_lock(vdev_id, inst_id);
+	if (ret != RSI_SUCCESS)
+		return ret;
+
+	do {
+		ret = rsi_rdev_continue(vdev_id, inst_id);
+	} while (ret == RSI_INCOMPLETE);
+	if (ret != RSI_SUCCESS) {
+		pci_err(pdev, "failed to communicate with the device (%lu)\n", ret);
+		return ret;
+	}
+	return RSI_SUCCESS;
+}
+
+int rsi_device_lock(struct pci_dev *pdev)
+{
+	unsigned long ret;
+	struct cca_guest_dsc *dsm = to_cca_guest_dsc(pdev);
+	int vdev_id = (pci_domain_nr(pdev->bus) << 16) |
+		PCI_DEVID(pdev->bus->number, pdev->devfn);
+
+	ret = rsi_rdev_get_instance_id(vdev_id, &dsm->instance_id);
+	if (ret != RSI_SUCCESS) {
+		pci_err(pdev, "failed to get the device instance id (%lu)\n", ret);
+		return -EIO;
+	}
+
+	ret = rsi_rdev_lock(pdev, vdev_id, dsm->instance_id);
+	if (ret != RSI_SUCCESS) {
+		pci_err(pdev, "failed to lock the device (%lu)\n", ret);
+		return -EIO;
+	}
+
+	return ret;
+}
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
index 8a4d5f1b0263..f12430c7d792 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.h
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
@@ -10,9 +10,9 @@
 #include <linux/pci-tsm.h>
 #include <asm/rsi_smc.h>
 
-
 struct cca_guest_dsc {
 	struct pci_tsm_pf0 pci;
+	unsigned long instance_id;
 };
 
 static inline struct cca_guest_dsc *to_cca_guest_dsc(struct pci_dev *pdev)
@@ -24,4 +24,5 @@ static inline struct cca_guest_dsc *to_cca_guest_dsc(struct pci_dev *pdev)
 	return container_of(tsm, struct cca_guest_dsc, pci.tsm);
 }
 
+int rsi_device_lock(struct pci_dev *pdev);
 #endif
-- 
2.43.0


