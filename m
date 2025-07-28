Return-Path: <linux-pci+bounces-33054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7C5B13C51
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D571884F96
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079BB272E44;
	Mon, 28 Jul 2025 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3cvtuBs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF592701DC;
	Mon, 28 Jul 2025 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710888; cv=none; b=so9pYhPJMJr5BE+TKiKPcgr9bx+ITYx9hTqL6f+q2ue70RZmQW5mUpLzKDE5it4T8PIB/xYqZZOB/oKCBAVuM0Wkua5Ox7Ju30Z5x73r/SMl7P4oHVF0z9IZDN3kb9GZpolhq5zqe2iVYFbKlSFuBz7cBxqNVia1ODTJsJI9wz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710888; c=relaxed/simple;
	bh=b0HLfMpilQyrnxIwwp5ybtMAfIvQ43yfDBQfDKLvSC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaydVsH+Clrr4UXFy3I4BL0r95mliwQMRD6BKlVvIrne8Kq5R6nOSw6IC/MbK1fjmh4RPm59OSAgNVUfLk9+Nr/NfvzVeN7TVP2EOJSNNw8FywRJuGq5E2kFug82MkESgm4B+dan7JXADjQkC8fNiXsf+d1jtHBXiBPQg62b4Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3cvtuBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E20BC4CEFD;
	Mon, 28 Jul 2025 13:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710888;
	bh=b0HLfMpilQyrnxIwwp5ybtMAfIvQ43yfDBQfDKLvSC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T3cvtuBsxK9RgbLvp+iqcef4RKnKaapKnlrrC1pM4FzBJN8XGTfgS71LpHgsLpItJ
	 X+F6nKDSVjJbKHHXprl2Jdt+bOCVeQQQJrtQiRlfkz/tVURgR3DmNfnZdI1E23kRQ5
	 uefrvoO8bVFnoLq7Ldd1bHu3XUXBRzFkYaarf/ZHgc/8V0+QnrNCPthZd3wKfgTaY8
	 bXEGGb38jFUDZPs3DRTN2J8gpf6MQKx/J80BewcRX8VPqQc5zlMvILpEDXa4q17q73
	 rF3BrSX195NkhMPnSU6OAXY03R1SlJ+AeXLV53uGYGlBQnh0/hDUq+q/lAA5MRjeiz
	 GUcNx+pbzCeog==
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
Subject: [RFC PATCH v1 22/38] coco: host: arm64: Stop and destroy virtual device
Date: Mon, 28 Jul 2025 19:21:59 +0530
Message-ID: <20250728135216.48084-23-aneesh.kumar@kernel.org>
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

Add support for vdev_stop and vdev_destroy.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rmi_cmds.h        | 21 ++++++++
 arch/arm64/include/asm/rmi_smc.h         |  3 +-
 drivers/virt/coco/arm-cca-host/arm-cca.c | 10 ++++
 drivers/virt/coco/arm-cca-host/rmm-da.c  | 61 +++++++++++++++++++++++-
 drivers/virt/coco/arm-cca-host/rmm-da.h  |  2 +
 5 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/rmi_cmds.h b/arch/arm64/include/asm/rmi_cmds.h
index 25197f47a0a9..eb4f67eb6b01 100644
--- a/arch/arm64/include/asm/rmi_cmds.h
+++ b/arch/arm64/include/asm/rmi_cmds.h
@@ -609,4 +609,25 @@ static inline unsigned long rmi_vdev_get_state(unsigned long vdev_phys, unsigned
 	return res.a0;
 }
 
+static inline unsigned long rmi_vdev_stop(unsigned long vdev_phys)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RMI_VDEV_STOP, vdev_phys, &res);
+
+	return res.a0;
+}
+
+static inline unsigned long rmi_vdev_destroy(unsigned long rd,
+					     unsigned long pdev_phys,
+					     unsigned long vdev_phys)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RMI_VDEV_DESTROY, rd, pdev_phys, vdev_phys, &res);
+
+	return res.a0;
+}
+
+
 #endif /* __ASM_RMI_CMDS_H */
diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
index 127dd0938604..c6e16ab608e1 100644
--- a/arch/arm64/include/asm/rmi_smc.h
+++ b/arch/arm64/include/asm/rmi_smc.h
@@ -55,8 +55,9 @@
 #define SMC_RMI_PDEV_STOP		SMC_RMI_CALL(0x017c)
 #define SMC_RMI_VDEV_COMMUNICATE	SMC_RMI_CALL(0x0186)
 #define SMC_RMI_VDEV_CREATE		SMC_RMI_CALL(0x0187)
+#define SMC_RMI_VDEV_DESTROY		SMC_RMI_CALL(0x0188)
 #define SMC_RMI_VDEV_GET_STATE		SMC_RMI_CALL(0x0189)
-
+#define SMC_RMI_VDEV_STOP		SMC_RMI_CALL(0x018A)
 
 #define RMI_ABI_MAJOR_VERSION	1
 #define RMI_ABI_MINOR_VERSION	0
diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
index 2da513f45974..3792d7b5cb99 100644
--- a/drivers/virt/coco/arm-cca-host/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
@@ -250,12 +250,22 @@ static struct pci_tdi *cca_tsm_bind(struct pci_dev *pdev, struct pci_dev *pf0_de
 	return rmm_vdev;
 }
 
+static void cca_tsm_unbind(struct pci_tdi *tdi)
+{
+	struct realm *realm = &tdi->kvm->arch.realm;
+
+	rme_unbind_vdev(realm, tdi->pdev, tdi->pdev->tsm->dsm_dev);
+
+	module_put(THIS_MODULE);
+}
+
 static const struct pci_tsm_ops cca_pci_ops = {
 	.probe = cca_tsm_pci_probe,
 	.remove = cca_tsm_pci_remove,
 	.connect = cca_tsm_connect,
 	.disconnect = cca_tsm_disconnect,
 	.bind	= cca_tsm_bind,
+	.unbind = cca_tsm_unbind,
 };
 
 static void cca_tsm_remove(void *tsm_core)
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.c b/drivers/virt/coco/arm-cca-host/rmm-da.c
index 8635f361bbe8..53072610fa67 100644
--- a/drivers/virt/coco/arm-cca-host/rmm-da.c
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.c
@@ -597,7 +597,66 @@ void *rme_create_vdev(struct realm *realm, struct pci_dev *pdev,
 	return ERR_PTR(ret);
 }
 
-static int __maybe_unused do_vdev_communicate(struct pci_tsm *tsm, int target_state)
+static int do_vdev_communicate(struct pci_tsm *tsm, int target_state)
 {
 	return do_dev_communicate(VDEV_COMMUNICATE, tsm, target_state);
 }
+
+static void vdev_stop_work(struct work_struct *work)
+{
+	struct dev_comm_work *stop_work;
+	struct pci_tsm *tsm;
+	unsigned long state;
+
+	stop_work = container_of(work, struct dev_comm_work, work);
+	tsm = stop_work->tsm;
+
+	state = do_vdev_communicate(tsm, RMI_VDEV_STOPPED);
+	WARN_ON(state != RMI_VDEV_STOPPED);
+
+	complete(&stop_work->complete);
+}
+
+static int schedule_vdev_unbind(struct pci_dev *pdev)
+{
+	struct dev_comm_work unbind_work = {
+		.tsm = pdev->tsm,
+	};
+
+	INIT_WORK_ONSTACK(&unbind_work.work, vdev_stop_work);
+	init_completion(&unbind_work.complete);
+	schedule_work(&unbind_work.work);
+	wait_for_completion(&unbind_work.complete);
+	destroy_work_on_stack(&unbind_work.work);
+
+	return 0;
+}
+
+void rme_unbind_vdev(struct realm *realm, struct pci_dev *pdev, struct pci_dev *pf0_dev)
+{
+	int ret;
+	phys_addr_t rmm_pdev_phys;
+	phys_addr_t rmm_vdev_phys;
+	struct cca_host_dsc_pf0 *dsc_pf0;
+	struct cca_host_tdi *host_tdi;
+	phys_addr_t rd_phys = virt_to_phys(realm->rd);
+
+	host_tdi = container_of(pdev->tsm->tdi, struct cca_host_tdi, tdi);
+	rmm_vdev_phys = virt_to_phys(host_tdi->rmm_vdev);
+
+	dsc_pf0 = to_cca_dsc_pf0(pf0_dev);
+	rmm_pdev_phys = virt_to_phys(dsc_pf0->rmm_pdev);
+	/* Request stopping the VDEV */
+	ret = rmi_vdev_stop(rmm_vdev_phys);
+	if (ret) {
+		pr_err("failed to stop vdev (%d)\n", ret);
+		return;
+	}
+
+	schedule_vdev_unbind(pdev);
+	ret = rmi_vdev_destroy(rd_phys, rmm_pdev_phys, rmm_vdev_phys);
+	if (ret) {
+		pr_err("failed to destroy vdev (%d)\n", ret);
+		return;
+	}
+}
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.h b/drivers/virt/coco/arm-cca-host/rmm-da.h
index 37a8f4dce68e..6361f7403f95 100644
--- a/drivers/virt/coco/arm-cca-host/rmm-da.h
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.h
@@ -93,4 +93,6 @@ void rme_unassign_device(struct pci_dev *pdev);
 int schedule_rme_ide_setup(struct pci_dev *pdev);
 void *rme_create_vdev(struct realm *realm, struct pci_dev *pdev,
 		      struct pci_dev *pf0_dev, u32 guest_rid);
+void rme_unbind_vdev(struct realm *realm, struct pci_dev *pdev,
+		     struct pci_dev *pf0_dev);
 #endif
-- 
2.43.0


