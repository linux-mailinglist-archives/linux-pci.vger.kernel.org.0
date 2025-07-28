Return-Path: <linux-pci+bounces-33067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C70B13C77
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E814E3F05
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 14:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AB4283FD6;
	Mon, 28 Jul 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0XKvpm4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6053E27465A;
	Mon, 28 Jul 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710965; cv=none; b=IJNdmk100zA3LByaDXlogCrepV949bw9EuSGahjFITqWz9nnLDiRd2jObpjkEPQfdaQzIIdrKiC4fr13YTkK/dHRXqCIB1CMDbEXXyaqIajccPcsfeLBZ2ZxGKmX+3FHsl+mMvGBGduaNUyAXlYO/RSqfV0Zb9CQHTTmBlhf7SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710965; c=relaxed/simple;
	bh=V4MrTdte0492OtV3PFGAqQTiSyPRnkCgmWBOOJ+F/+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ug2DbAkwwWuQv9eXF6ZcgFyhe2xW/oXYJe96YMU6Rhjs4p4G5vl0a2iuU7Kh9IHX6pPH31fYE95SD9f9sWcd45UFloycB5Jf5fAcWME2GQSA73yg3gYxdajFaLbSpVLfCdoi0m65OEDAGi8nxf+sgyX05HiWT/7AWgOUDac6eOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0XKvpm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB80C4CEE7;
	Mon, 28 Jul 2025 13:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710965;
	bh=V4MrTdte0492OtV3PFGAqQTiSyPRnkCgmWBOOJ+F/+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0XKvpm4JRHxtgfKKcHwlhKi8gPmHZt6IK22YSgaGAh8qw7SRs1jBgKcJEPfiX4xS
	 +Q6+RcgQTYvQXYA6HIWjv+tli5JIDfbik6D5cTiILvRIpLejIOXz7hK46l74nYcUMR
	 6VO4JEilZKoxOQzedneSW8P1/8e8W119c7RfD0U4/tF21Tfw8Os5Ygdy2CFFW+qDdU
	 DsE9Qo/ySfVO/CQ/bei1Ev4wINusZ7RuQ7Z6MsCGFKfXwViXpfQLw0k/SeKpkd10uf
	 PqBkaHFCi+AG+uJhOU5ZIk9rp/W6DbADI3awjSrfFH1V3PUe5fgQzeArQ9aAZzl+iN
	 i449r3JK7O3QA==
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
Subject: [RFC PATCH v1 35/38] coco: guest: arm64: Add Realm device start and stop support
Date: Mon, 28 Jul 2025 19:22:12 +0530
Message-ID: <20250728135216.48084-36-aneesh.kumar@kernel.org>
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

Writing 1 to 'tsm/acceept' will initiate the TDISP RUN sequence.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rsi_cmds.h         | 19 +++++++
 arch/arm64/include/asm/rsi_smc.h          |  2 +
 drivers/virt/coco/arm-cca-guest/arm-cca.c | 15 ++++++
 drivers/virt/coco/arm-cca-guest/rsi-da.c  | 60 +++++++++++++++++++++++
 drivers/virt/coco/arm-cca-guest/rsi-da.h  |  2 +-
 5 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
index 1cc00d404e53..3463d571d7db 100644
--- a/arch/arm64/include/asm/rsi_cmds.h
+++ b/arch/arm64/include/asm/rsi_cmds.h
@@ -246,4 +246,23 @@ rsi_rdev_validate_mapping(unsigned long vdev_id, unsigned long inst_id,
 		return -EINVAL;
 	return 0;
 }
+
+static inline unsigned long __rsi_rdev_start(unsigned long vdev_id, unsigned long inst_id)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RSI_RDEV_START, vdev_id, inst_id, &res);
+
+	return res.a0;
+}
+
+static inline unsigned long __rsi_rdev_stop(unsigned long vdev_id, unsigned long inst_id)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RSI_RDEV_STOP, vdev_id, inst_id, &res);
+
+	return res.a0;
+}
+
 #endif /* __ASM_RSI_CMDS_H */
diff --git a/arch/arm64/include/asm/rsi_smc.h b/arch/arm64/include/asm/rsi_smc.h
index a28b41cf01ca..f6aa647239c0 100644
--- a/arch/arm64/include/asm/rsi_smc.h
+++ b/arch/arm64/include/asm/rsi_smc.h
@@ -203,6 +203,8 @@ struct rsi_host_call {
 #define SMC_RSI_RDEV_GET_INTERFACE_REPORT	SMC_RSI_FID(0x1a6)
 
 #define SMC_RSI_RDEV_LOCK			SMC_RSI_FID(0x1a9)
+#define SMC_RSI_RDEV_START			SMC_RSI_FID(0x1aa)
+#define SMC_RSI_RDEV_STOP			SMC_RSI_FID(0x1ab)
 
 #define RSI_DEV_MEM_COHERENT		BIT(0)
 #define RSI_DEV_MEM_LIMITED_ORDER	BIT(1)
diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
index c1cefb983ac7..7eeb9732d20a 100644
--- a/drivers/virt/coco/arm-cca-guest/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
@@ -250,6 +250,8 @@ static void cca_tsm_unlock(struct pci_dev *pdev)
 	/* invalidate dev mapping based on interface report */
 	rsi_update_interface_report(pdev, false);
 
+	rsi_device_stop(pdev);
+
 	ret = rhi_da_vdev_set_tdi_state(vdev_id, RHI_DA_TDI_CONFIG_UNLOCKED);
 	if (ret) {
 		pci_err(pdev, "failed to TSM unbind the device (%ld)\n", ret);
@@ -257,11 +259,24 @@ static void cca_tsm_unlock(struct pci_dev *pdev)
 	}
 }
 
+static int cca_tsm_accept(struct pci_dev *pdev)
+{
+	int ret;
+
+	ret = rsi_device_start(pdev);
+	if (ret) {
+		pci_err(pdev, "failed to transition the device to run state (%d)\n", ret);
+		return -EIO;
+	}
+	return 0;
+}
+
 static const struct pci_tsm_ops cca_pci_ops = {
 	.probe = cca_tsm_pci_probe,
 	.remove = cca_tsm_pci_remove,
 	.lock = cca_tsm_lock,
 	.unlock = cca_tsm_unlock,
+	.accept	 = cca_tsm_accept,
 };
 
 static void cca_tsm_unregister(void *tsm)
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
index 936f844880de..64034d220e02 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.c
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c
@@ -215,6 +215,24 @@ int rsi_device_lock(struct pci_dev *pdev)
 
 	return ret;
 }
+static inline unsigned long rsi_rdev_start(struct pci_dev *pdev,
+					   unsigned long vdev_id, unsigned long inst_id)
+{
+	unsigned long ret;
+
+	ret = __rsi_rdev_start(vdev_id, inst_id);
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
 
 static inline unsigned long
 rsi_validate_dev_mapping(unsigned long vdev_id, unsigned long inst_id,
@@ -338,6 +356,9 @@ int rsi_update_interface_report(struct pci_dev *pdev, bool validate)
 int rsi_device_start(struct pci_dev *pdev)
 {
 	int ret;
+	struct cca_guest_dsc *dsm = to_cca_guest_dsc(pdev);
+	int vdev_id = (pci_domain_nr(pdev->bus) << 16) |
+		PCI_DEVID(pdev->bus->number, pdev->devfn);
 
 	ret = rsi_update_interface_report(pdev, true);
 	if (ret) {
@@ -345,5 +366,44 @@ int rsi_device_start(struct pci_dev *pdev)
 		return -EIO;
 	}
 
+	ret = rsi_rdev_start(pdev, vdev_id, dsm->instance_id);
+	if (ret != RSI_SUCCESS) {
+		pci_err(pdev, "failed to start the device (%u)\n", ret);
+		return -EIO;
+	}
+	return 0;
+}
+
+static inline unsigned long rsi_rdev_stop(struct pci_dev *pdev,
+					  unsigned long vdev_id, unsigned long inst_id)
+{
+	unsigned long ret;
+
+	ret = __rsi_rdev_stop(vdev_id, inst_id);
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
+int rsi_device_stop(struct pci_dev *pdev)
+{
+	int ret;
+	struct cca_guest_dsc *dsm = to_cca_guest_dsc(pdev);
+	int vdev_id = (pci_domain_nr(pdev->bus) << 16) |
+		PCI_DEVID(pdev->bus->number, pdev->devfn);
+
+	ret = rsi_rdev_stop(pdev, vdev_id, dsm->instance_id);
+	if (ret != RSI_SUCCESS) {
+		pci_err(pdev, "failed to stop the device (%u)\n", ret);
+		return -EIO;
+	}
 	return 0;
 }
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
index 0d6e1c0ada4a..71ee1edb832e 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.h
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
@@ -54,5 +54,5 @@ static inline struct cca_guest_dsc *to_cca_guest_dsc(struct pci_dev *pdev)
 int rsi_update_interface_report(struct pci_dev *pdev, bool validate);
 int rsi_device_lock(struct pci_dev *pdev);
 int rsi_device_start(struct pci_dev *pdev);
-
+int rsi_device_stop(struct pci_dev *pdev);
 #endif
-- 
2.43.0


