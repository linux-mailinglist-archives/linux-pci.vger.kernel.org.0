Return-Path: <linux-pci+bounces-41409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE1FC648FA
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 15:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4522B343F17
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 14:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE20A333732;
	Mon, 17 Nov 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZXzaZ8r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA822AEF5;
	Mon, 17 Nov 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388033; cv=none; b=RFx4rGiVDIfaUHvnxgCnfxigj6/EsKy+SfpXg5v7ROEuZ6TUUVMYYbayNI5wmkrTVBPL2FB9wqC/KPPziEj9ozPR03ZlHNzo3L5A3IqgsQC2IG+dlIt4wTt/eAdn+ZMOw5NXJnfJxlaxIE9xvwU1Xp04bakrJNDHN7LqxGg0XG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388033; c=relaxed/simple;
	bh=V/BR6e27SASfgNWzEFxjjMuYtGP7obGAPVnBSdkKZ3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpHtXsNThKAXS45xLLfX82+sQ3GXkpSH7EMMV6STTqOLGtnwybPT++9gNMcQbCd0qNdIvNCcQnzigj3wGHgrAyBN6mggC3xNZQwV9D6kNCy+eFTdjdi7VybKXfj3ZXykgyHBDeTItsNMneTwIFmn50gT/BuFrlbenB4VhBTwJRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZXzaZ8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B02C2BC86;
	Mon, 17 Nov 2025 14:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763388033;
	bh=V/BR6e27SASfgNWzEFxjjMuYtGP7obGAPVnBSdkKZ3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SZXzaZ8rq8xrT+PDWOoNY/LuYV71ghFsRAOWhJ4fWdUgGitQRXLk7LahGe9U9bs0w
	 LuUxv0OqcfwHk3pmTb9WYoOBXKZSpkRQfGJc46GmU2ektv4u9TxwF77gav7vADzHlW
	 TqKAcM2Tuzu2BlnnYClbHl1yoNRLTNBdVyEgP3fGXdngBRehohKdSTjZkG8q6zibu4
	 4kghUGxkcq0htGtz4J7SzJFescWdmxgaPTqWktqhU7KJeKnHSTN8NKuC16f3xSog9v
	 SPQGSuaVKbCnMwGrclsEb3nPToR2myxw2RZO2lUMZag4tPlXrDBR8zRpL0lVAalW8z
	 PQsUrm2abJCtg==
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
Subject: [PATCH v2 02/11] coco: guest: arm64: Add Realm Host Interface and guest DA helper
Date: Mon, 17 Nov 2025 19:29:58 +0530
Message-ID: <20251117140007.122062-3-aneesh.kumar@kernel.org>
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

- describe the Realm Host Interface SMC IDs and result codes in a new
  `asm/rhi.h` header
- expose `struct rsi_host_call` plus an `rsi_host_call()` helper so we can
  invoke `SMC_RSI_HOST_CALL` from C code
- build a guest-side `rhi-da` helper that drives the vdev TDI state machine
  via RHI host calls and translates the firmware status codes

This provides the basic RHI plumbing that later DA features rely on.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rhi.h              |  50 +++++++
 arch/arm64/include/asm/rsi_cmds.h         |   9 ++
 arch/arm64/include/asm/rsi_smc.h          |   7 +
 drivers/virt/coco/arm-cca-guest/Makefile  |   2 +-
 drivers/virt/coco/arm-cca-guest/arm-cca.c |   3 +-
 drivers/virt/coco/arm-cca-guest/rhi-da.c  | 158 ++++++++++++++++++++++
 drivers/virt/coco/arm-cca-guest/rhi-da.h  |  14 ++
 7 files changed, 241 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/include/asm/rhi.h
 create mode 100644 drivers/virt/coco/arm-cca-guest/rhi-da.c
 create mode 100644 drivers/virt/coco/arm-cca-guest/rhi-da.h

diff --git a/arch/arm64/include/asm/rhi.h b/arch/arm64/include/asm/rhi.h
new file mode 100644
index 000000000000..335930bbf059
--- /dev/null
+++ b/arch/arm64/include/asm/rhi.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 ARM Ltd.
+ */
+
+#ifndef __ASM_RHI_H_
+#define __ASM_RHI_H_
+
+#include <linux/types.h>
+
+#define SMC_RHI_CALL(func)				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
+			   ARM_SMCCC_SMC_64,		\
+			   ARM_SMCCC_OWNER_STANDARD_HYP,\
+			   (func))
+
+#define RHI_DA_SUCCESS				0x0
+#define RHI_DA_INCOMPLETE			0x1
+#define RHI_DA_ERROR_DATA_NOT_AVAILABLE		0x2
+#define RHI_DA_ERROR_INVALID_VDEV_ID		0x3
+#define RHI_DA_ERROR_INVALID_OBJECT		0x4
+#define RHI_DA_ERROR_INPUT			0x5
+#define RHI_DA_ERROR_DEVICE			0x6
+#define RHI_DA_ERROR_INVALID_OFFSET		0x7
+#define RHI_DA_ERROR_ACCESS_FAILED		0x8
+#define RHI_DA_ERROR_BUSY			0x9
+
+#define RHI_DA_FEATURE_OBJECT_SIZE		BIT(0)
+#define RHI_DA_FEATURE_OBJECT_READ		BIT(1)
+#define RHI_DA_FEATURE_VDEV_CONTINUE		BIT(2)
+#define RHI_DA_FEATURE_VDEV_GET_MEASUREMENT	BIT(3)
+#define RHI_DA_FEATURE_VDEV_GET_INTF_REPORT	BIT(4)
+#define RHI_DA_FEATURE_VDEV_SET_TDI_STATE	BIT(5)
+
+#define RHI_DA_BASE_FEATURE	(RHI_DA_FEATURE_OBJECT_SIZE |		\
+				 RHI_DA_FEATURE_OBJECT_READ |		\
+				 RHI_DA_FEATURE_VDEV_GET_INTF_REPORT |	\
+				 RHI_DA_FEATURE_VDEV_GET_MEASUREMENT |	\
+				 RHI_DA_FEATURE_VDEV_SET_TDI_STATE)
+#define RHI_DA_FEATURES			SMC_RHI_CALL(0x004B)
+
+#define RHI_DA_VDEV_CONTINUE		SMC_RHI_CALL(0x0051)
+
+#define RHI_DA_TDI_CONFIG_UNLOCKED		0x0
+#define RHI_DA_TDI_CONFIG_LOCKED		0x1
+#define RHI_DA_TDI_CONFIG_RUN			0x2
+#define RHI_DA_VDEV_SET_TDI_STATE	SMC_RHI_CALL(0x0054)
+#define RHI_DA_VDEV_ABORT		SMC_RHI_CALL(0x0056)
+
+#endif
diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
index 6c2db7a24ef3..18aa1b9efb9b 100644
--- a/arch/arm64/include/asm/rsi_cmds.h
+++ b/arch/arm64/include/asm/rsi_cmds.h
@@ -176,4 +176,13 @@ static inline unsigned long rsi_features(unsigned long index, unsigned long *out
 	return res.a0;
 }
 
+static inline unsigned long rsi_host_call(phys_addr_t addr)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RSI_HOST_CALL, addr, &res);
+
+	return res.a0;
+}
+
 #endif /* __ASM_RSI_CMDS_H */
diff --git a/arch/arm64/include/asm/rsi_smc.h b/arch/arm64/include/asm/rsi_smc.h
index 8e486cdef9eb..4dbd87a27d9b 100644
--- a/arch/arm64/include/asm/rsi_smc.h
+++ b/arch/arm64/include/asm/rsi_smc.h
@@ -183,6 +183,13 @@ struct realm_config {
  */
 #define SMC_RSI_IPA_STATE_GET			SMC_RSI_FID(0x198)
 
+struct rsi_host_call {
+	union {
+		u16 imm;
+		u64 padding0;
+	};
+	u64 gprs[31];
+} __aligned(0x100);
 /*
  * Make a Host call.
  *
diff --git a/drivers/virt/coco/arm-cca-guest/Makefile b/drivers/virt/coco/arm-cca-guest/Makefile
index bc3b2be4019f..04d26e398a1d 100644
--- a/drivers/virt/coco/arm-cca-guest/Makefile
+++ b/drivers/virt/coco/arm-cca-guest/Makefile
@@ -2,4 +2,4 @@
 #
 obj-$(CONFIG_ARM_CCA_GUEST) += arm-cca-guest.o
 
-arm-cca-guest-y +=  arm-cca.o
+arm-cca-guest-y +=  arm-cca.o rhi-da.o
diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
index 288fa53ad0af..26be2e8fe182 100644
--- a/drivers/virt/coco/arm-cca-guest/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
@@ -16,6 +16,7 @@
 #include <asm/rsi.h>
 
 #include "rsi-da.h"
+#include "rhi-da.h"
 
 /**
  * struct arm_cca_token_info - a descriptor for the token buffer.
@@ -266,7 +267,7 @@ static int cca_devsec_tsm_probe(struct auxiliary_device *adev,
 	}
 
 	/* Allow tsm report even if tsm_register fails */
-	if (rsi_has_da_feature())
+	if (rsi_has_da_feature() && rhi_has_da_support())
 		cca_devsec_tsm_register(adev);
 
 	return 0;
diff --git a/drivers/virt/coco/arm-cca-guest/rhi-da.c b/drivers/virt/coco/arm-cca-guest/rhi-da.c
new file mode 100644
index 000000000000..3430d8df4424
--- /dev/null
+++ b/drivers/virt/coco/arm-cca-guest/rhi-da.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 ARM Ltd.
+ */
+
+#include "rsi-da.h"
+#include "rhi-da.h"
+
+/* return value to indicate the need to call rhi_vdev_continue*/
+#define E_INCOMPLETE	1
+static inline int map_rhi_da_error(unsigned long rhi_da_error)
+{
+	switch (rhi_da_error) {
+	case RHI_DA_SUCCESS:
+		return 0;
+	case RHI_DA_INCOMPLETE:
+		return E_INCOMPLETE;
+	case RHI_DA_ERROR_BUSY:
+		return -EBUSY;
+	case RHI_DA_ERROR_INPUT:
+	case RHI_DA_ERROR_INVALID_VDEV_ID:
+		return -EINVAL;
+	case RHI_DA_ERROR_ACCESS_FAILED:
+		return -EFAULT;
+	case RHI_DA_ERROR_DEVICE:
+		return -EIO;
+	case RHI_DA_ERROR_INVALID_OBJECT:
+		return -EINVAL;
+	default:
+		return -EIO;
+	}
+}
+
+bool rhi_has_da_support(void)
+{
+	int ret;
+	struct rsi_host_call *rhicall;
+
+	rhicall = kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
+	if (!rhicall)
+		return -ENOMEM;
+
+	rhicall->imm = 0;
+	rhicall->gprs[0] = RHI_DA_FEATURES;
+
+	ret = rsi_host_call(virt_to_phys(rhicall));
+	if (ret != RSI_SUCCESS || rhicall->gprs[0] == SMCCC_RET_NOT_SUPPORTED)
+		return false;
+
+	/* For base DA to work we need these to be supported */
+	if ((rhicall->gprs[0] & RHI_DA_BASE_FEATURE) == RHI_DA_BASE_FEATURE)
+		return true;
+
+	return false;
+}
+
+static inline int rhi_vdev_continue(unsigned long vdev_id, unsigned long cookie)
+{
+	unsigned long ret;
+
+	struct rsi_host_call *rhi_call __free(kfree) =
+		kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
+	if (!rhi_call)
+		return -ENOMEM;
+
+	rhi_call->imm = 0;
+	rhi_call->gprs[0] = RHI_DA_VDEV_CONTINUE;
+	rhi_call->gprs[1] = vdev_id;
+	rhi_call->gprs[2] = cookie;
+
+	ret = rsi_host_call(virt_to_phys(rhi_call));
+	if (ret != RSI_SUCCESS)
+		return -EIO;
+
+	return map_rhi_da_error(rhi_call->gprs[0]);
+}
+
+static int __rhi_vdev_abort(unsigned long vdev_id, unsigned long *da_error)
+{
+	unsigned long ret;
+	struct rsi_host_call *rhi_call __free(kfree) =
+		kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
+	if (!rhi_call)
+		return -ENOMEM;
+
+	rhi_call->imm = 0;
+	rhi_call->gprs[0] = RHI_DA_VDEV_ABORT;
+	rhi_call->gprs[1] = vdev_id;
+
+	ret = rsi_host_call(virt_to_phys(rhi_call));
+	if (ret != RSI_SUCCESS)
+		return -EIO;
+
+	return *da_error = rhi_call->gprs[0];
+	return 0;
+}
+
+static bool should_abort_rhi_call_loop(unsigned long vdev_id)
+{
+	int ret;
+
+	cond_resched();
+	if (signal_pending(current)) {
+		unsigned long da_error;
+
+		ret = __rhi_vdev_abort(vdev_id, &da_error);
+		/* consider all kind of error as not aborted */
+		if (!ret && (da_error == RHI_DA_SUCCESS))
+			return true;
+	}
+	return false;
+}
+
+static int __rhi_vdev_set_tdi_state(unsigned long vdev_id,
+				    unsigned long target_state,
+				    unsigned long *cookie)
+{
+	unsigned long ret;
+
+	struct rsi_host_call *rhi_call __free(kfree) =
+		kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
+	if (!rhi_call)
+		return -ENOMEM;
+
+	rhi_call->imm = 0;
+	rhi_call->gprs[0] = RHI_DA_VDEV_SET_TDI_STATE;
+	rhi_call->gprs[1] = vdev_id;
+	rhi_call->gprs[2] = target_state;
+
+	ret = rsi_host_call(virt_to_phys(rhi_call));
+	if (ret != RSI_SUCCESS)
+		return -EIO;
+
+	*cookie = rhi_call->gprs[1];
+	return map_rhi_da_error(rhi_call->gprs[0]);
+}
+
+int rhi_vdev_set_tdi_state(struct pci_dev *pdev, unsigned long target_state)
+{
+	int ret;
+	unsigned long cookie;
+	int vdev_id = rsi_vdev_id(pdev);
+
+	for (;;) {
+		ret = __rhi_vdev_set_tdi_state(vdev_id, target_state, &cookie);
+		if (ret != -EBUSY)
+			break;
+		cond_resched();
+	}
+
+	while (ret == E_INCOMPLETE) {
+		if (should_abort_rhi_call_loop(vdev_id))
+			return -EINTR;
+		ret = rhi_vdev_continue(vdev_id, cookie);
+	}
+
+	return ret;
+}
diff --git a/drivers/virt/coco/arm-cca-guest/rhi-da.h b/drivers/virt/coco/arm-cca-guest/rhi-da.h
new file mode 100644
index 000000000000..8dd77c7ed645
--- /dev/null
+++ b/drivers/virt/coco/arm-cca-guest/rhi-da.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 ARM Ltd.
+ */
+
+#ifndef _VIRT_COCO_RHI_DA_H_
+#define _VIRT_COCO_RHI_DA_H_
+
+#include <asm/rhi.h>
+
+struct pci_dev;
+bool rhi_has_da_support(void);
+int rhi_vdev_set_tdi_state(struct pci_dev *pdev, unsigned long target_state);
+#endif
-- 
2.43.0


