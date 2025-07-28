Return-Path: <linux-pci+bounces-33064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08602B13C6E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ACA35413C2
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 14:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0CF27FB3E;
	Mon, 28 Jul 2025 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH3xFRjB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D0726FA60;
	Mon, 28 Jul 2025 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710947; cv=none; b=AoMQrI1GpNnILgTqfGYYI3K01I//14qncOheKZkWfcN0EuZnQCrnD8MH6bGZdM/FtbHSkX7UrSenDNRwsTeY2MNu9k39QvadfeisTgJCoIHwvUXn59txOLAdUxE2Q1J9ffnmrC2HLTlyhZO75Ty2gETEP0HJ6zStPV0IgHBhwZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710947; c=relaxed/simple;
	bh=a0YStxMFkGn3VVGT8LHrbE2+pWRULcaCe29nuP1s6PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6QvFyPexIOewiYhfiVhW86UnxGqtA+tHGhC6tT6Vzl0MZfi6HR8gAmbByEG/I7B7+OAV3qBtTTJURVtTN9q16QWkh0b/OcH5BlINTfXQIEMytDiCZS117b9t1G3HQH7KttimSaH7ZNICkUxZJQ5A/KsxfmImJpKnEc5UyR6S1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH3xFRjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CB6C4CEE7;
	Mon, 28 Jul 2025 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710947;
	bh=a0YStxMFkGn3VVGT8LHrbE2+pWRULcaCe29nuP1s6PQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fH3xFRjBTaZDjZhXgUBn3tyJ0Ckj9hK1LMVKW6Bb0zzPpxVnzuupQohFR7SOG4jv+
	 B317DahRvEeQhOrzYQgpn5LvHCrtEXlTw28DRjqAzTeeorqkRpec+q7J2q8xNG+Jtr
	 S83NBwKbb0yLiQzkPt6ekYh7Q8lRndjVestX6WY7jUWTH59ApSZvwPRXOJci3b4Srg
	 9f9I1qRbf4NlTTxrwDVWnHpWESXE8HtvXG9CfYZzsk7k78pxxIn2JViKNj9r0tzs3v
	 wySZeQNKrYAjYUwToiCF1NkHx5DYPoHf+hHvQxzYYg9lZCEdJOP29c1x9tT9M2l7FF
	 PfS2iMKCnGxGg==
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
Subject: [RFC PATCH v1 32/38] coco: guest: arm64: Add support for guest initiated TDI bind/unbind
Date: Mon, 28 Jul 2025 19:22:09 +0530
Message-ID: <20250728135216.48084-33-aneesh.kumar@kernel.org>
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

Add RHI for VDEV_SET_TDI_STATE

Note: This is not part of RHI spec. This is a POC implementation
and will be later switced to correct interface defined by RHI.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rhi.h              |  7 +++++
 arch/arm64/kernel/Makefile                |  2 +-
 arch/arm64/kernel/rhi.c                   | 35 +++++++++++++++++++++++
 drivers/virt/coco/arm-cca-guest/arm-cca.c | 22 ++++++++++++--
 drivers/virt/coco/arm-cca-host/arm-cca.c  |  8 ++++--
 5 files changed, 69 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/kernel/rhi.c

diff --git a/arch/arm64/include/asm/rhi.h b/arch/arm64/include/asm/rhi.h
index d3c22e582678..993b4b15b057 100644
--- a/arch/arm64/include/asm/rhi.h
+++ b/arch/arm64/include/asm/rhi.h
@@ -16,6 +16,7 @@
 #define RHI_DA_FEATURES			SMC_RHI_CALL(0x004d)
 #define RHI_DA_OBJECT_SIZE		SMC_RHI_CALL(0x004e)
 #define RHI_DA_OBJECT_READ		SMC_RHI_CALL(0x004f)
+#define RHI_DA_VDEV_SET_TDI_STATE	SMC_RHI_CALL(0x0052)
 
 #define RHI_DA_OBJECT_CERTIFICATE		0x1
 #define RHI_DA_OBJECT_MEASUREMENT		0x2
@@ -29,4 +30,10 @@
 #define RHI_ERROR_DATA_NOT_AVAILABLE		0x4
 #define RHI_ERROR_INVALID_OFFSET		0x5
 #define RHI_ERROR_INVALID_ADDR			0x6
+
+#define RHI_DA_TDI_CONFIG_UNLOCKED		0x0
+#define RHI_DA_TDI_CONFIG_LOCKED		0x1
+#define RHI_DA_TDI_CONFIG_RUN			0x2
+long rhi_da_vdev_set_tdi_state(unsigned long vdev_id, unsigned long target_state);
+
 #endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index a2faf0049dab..dde8fa78852c 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -34,7 +34,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o smccc-call.o	\
 			   syscall.o proton-pack.o idle.o patching.o pi/	\
-			   rsi.o jump_label.o
+			   rsi.o jump_label.o rhi.o
 
 obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
 					   sys_compat.o
diff --git a/arch/arm64/kernel/rhi.c b/arch/arm64/kernel/rhi.c
new file mode 100644
index 000000000000..3685b50c2e94
--- /dev/null
+++ b/arch/arm64/kernel/rhi.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 ARM Ltd.
+ */
+
+#include <asm/memory.h>
+#include <asm/string.h>
+#include <asm/rsi.h>
+#include <asm/rhi.h>
+
+#include <linux/slab.h>
+
+long rhi_da_vdev_set_tdi_state(unsigned long guest_rid, unsigned long target_state)
+{
+	long ret;
+	struct rsi_host_call *rhi_call;
+
+	rhi_call = kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
+	if (!rhi_call)
+		return -ENOMEM;
+
+	rhi_call->imm = 0;
+	rhi_call->gprs[0] = RHI_DA_VDEV_SET_TDI_STATE;
+	rhi_call->gprs[1] = guest_rid;
+	rhi_call->gprs[2] = target_state;
+
+	ret = rsi_host_call(virt_to_phys(rhi_call));
+	if (ret != RSI_SUCCESS)
+		ret =  -EIO;
+	else
+		ret = rhi_call->gprs[0];
+
+	kfree(rhi_call);
+	return ret;
+}
diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
index 2c0190bcb2a9..de70fba09e92 100644
--- a/drivers/virt/coco/arm-cca-guest/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
@@ -222,11 +222,20 @@ static void cca_tsm_pci_remove(struct pci_tsm *tsm)
 
 static int cca_tsm_lock(struct pci_dev *pdev)
 {
-	unsigned long ret;
+	long ret;
+	int vdev_id = (pci_domain_nr(pdev->bus) << 16) |
+		PCI_DEVID(pdev->bus->number, pdev->devfn);
 
+	ret = rhi_da_vdev_set_tdi_state(vdev_id, RHI_DA_TDI_CONFIG_LOCKED);
+	if (ret) {
+		pci_err(pdev, "failed to TSM bind the device (%ld)\n", ret);
+		return -EIO;
+	}
+
+	/* This will be done by above rhi in later spec */
 	ret = rsi_device_lock(pdev);
 	if (ret) {
-		pci_err(pdev, "failed to lock the device (%lu)\n", ret);
+		pci_err(pdev, "failed to lock the device (%ld)\n", ret);
 		return -EIO;
 	}
 	return 0;
@@ -234,6 +243,15 @@ static int cca_tsm_lock(struct pci_dev *pdev)
 
 static void cca_tsm_unlock(struct pci_dev *pdev)
 {
+	long ret;
+	int vdev_id = (pci_domain_nr(pdev->bus) << 16) |
+		PCI_DEVID(pdev->bus->number, pdev->devfn);
+
+	ret = rhi_da_vdev_set_tdi_state(vdev_id, RHI_DA_TDI_CONFIG_UNLOCKED);
+	if (ret) {
+		pci_err(pdev, "failed to TSM unbind the device (%ld)\n", ret);
+		return;
+	}
 }
 
 static const struct pci_tsm_ops cca_pci_ops = {
diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
index 0807fcf8d222..18d0a627baa4 100644
--- a/drivers/virt/coco/arm-cca-host/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
@@ -254,9 +254,13 @@ static struct pci_tdi *cca_tsm_bind(struct pci_dev *pdev, struct pci_dev *pf0_de
 static void cca_tsm_unbind(struct pci_tdi *tdi)
 {
 	struct realm *realm = &tdi->kvm->arch.realm;
-
+	/*
+	 * FIXME!!
+	 * All the related DEV RIPAS regions should be unmapped by now.
+	 * For now we handle them during stage2 teardown. There is no
+	 * bound IPA address available here. Possibly dmabuf can help
+	 */
 	rme_unbind_vdev(realm, tdi->pdev, tdi->pdev->tsm->dsm_dev);
-
 	module_put(THIS_MODULE);
 }
 
-- 
2.43.0


