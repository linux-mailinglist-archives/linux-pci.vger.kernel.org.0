Return-Path: <linux-pci+bounces-33047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6AFB13C43
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38228189036A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B9527511E;
	Mon, 28 Jul 2025 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdTFlHcl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C721226E6F0;
	Mon, 28 Jul 2025 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710845; cv=none; b=ryVZyD/qvvdVgVH391mL9kOASG9bc/nEwqZiTnTFt2r2H+dce4TZ+nFNFyCvIyQ+N2styQ1z53g6rwq+SlAwfgYDfs/cmodfxtqetFhhOk4mQyWWJdAga9b2O9l+5Bq5/NUdPTPHEzp+hqhdAeZdbklYmegGqUrkz/cawrCu5cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710845; c=relaxed/simple;
	bh=39NjrON3fdz7R0RVBkNfRuMvDFDaOl+UaCfGWmmBGgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7s564zU7aFyDTVSAY2R22fSzcdUncv695LS7TF9STfQwJUKSLfHKkfO6APPV5QGutqWjLh6fEcPfX74a0rjtvcP3DxJj33SCdViHpvThaLTgk1dJto2MoufiNLbZESuqahgGfOFV7FIPRXTL6UNjYuNl9Y0TnZTosqiqk8t4A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdTFlHcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E21C4CEF7;
	Mon, 28 Jul 2025 13:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710845;
	bh=39NjrON3fdz7R0RVBkNfRuMvDFDaOl+UaCfGWmmBGgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pdTFlHclFtGJaQ3oOwHPM7Oe7iv7kimYB9D4wCfFnTgkGPVT1cFFr4RyglxPqxIxR
	 4qIfd1db/97/CLSjfa2BTf3yQMQ1NTat77P7UuwCLzwJPPs+WOXYyWoAJcEoNNNA5w
	 045VTrmWqvU3i5hPW78wSQRoRyVaLQRSRKcMpYMnCYFJW9Yly+l55rXnRKtH8H1K5q
	 67oHrADgRvnK0vNCZ/5RuAYuh6r3LXfw/BHE3r6+3vFnwbzcEh+Rf0v2XOWu07x8j6
	 A58IjLzE61E0AE7XHWAuluMHqorZJpo1292KUbOICOw9Ja2YQDY1fefv5ANd53tTQ1
	 i+wEL05nqn2rQ==
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
Subject: [RFC PATCH v1 15/38] coco: host: arm64: Stop and destroy the physical device
Date: Mon, 28 Jul 2025 19:21:52 +0530
Message-ID: <20250728135216.48084-16-aneesh.kumar@kernel.org>
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

Add support for stopping and destroying physical devices.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rmi_cmds.h        | 18 ++++++++++++++++++
 arch/arm64/include/asm/rmi_smc.h         |  2 ++
 drivers/virt/coco/arm-cca-host/arm-cca.c |  3 +++
 drivers/virt/coco/arm-cca-host/rmm-da.c  | 21 +++++++++++++++++++++
 drivers/virt/coco/arm-cca-host/rmm-da.h  |  1 +
 5 files changed, 45 insertions(+)

diff --git a/arch/arm64/include/asm/rmi_cmds.h b/arch/arm64/include/asm/rmi_cmds.h
index eb0034a675bb..d4ea9f8363f5 100644
--- a/arch/arm64/include/asm/rmi_cmds.h
+++ b/arch/arm64/include/asm/rmi_cmds.h
@@ -547,4 +547,22 @@ static inline unsigned long rmi_pdev_communicate(unsigned long pdev_phys,
 	return res.a0;
 }
 
+static inline unsigned long rmi_pdev_stop(unsigned long pdev_phys)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RMI_PDEV_STOP, pdev_phys, &res);
+
+	return res.a0;
+}
+
+static inline unsigned long rmi_pdev_destroy(unsigned long pdev_phys)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RMI_PDEV_DESTROY, pdev_phys, &res);
+
+	return res.a0;
+}
+
 #endif /* __ASM_RMI_CMDS_H */
diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
index 8bece465b670..9f25a876238e 100644
--- a/arch/arm64/include/asm/rmi_smc.h
+++ b/arch/arm64/include/asm/rmi_smc.h
@@ -49,7 +49,9 @@
 
 #define SMC_RMI_PDEV_COMMUNICATE        SMC_RMI_CALL(0x0175)
 #define SMC_RMI_PDEV_CREATE             SMC_RMI_CALL(0x0176)
+#define SMC_RMI_PDEV_DESTROY		SMC_RMI_CALL(0x0177)
 #define SMC_RMI_PDEV_GET_STATE		SMC_RMI_CALL(0x0178)
+#define SMC_RMI_PDEV_STOP		SMC_RMI_CALL(0x017c)
 
 #define RMI_ABI_MAJOR_VERSION	1
 #define RMI_ABI_MINOR_VERSION	0
diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
index 294a6ef60d5f..c65b81f0706f 100644
--- a/drivers/virt/coco/arm-cca-host/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
@@ -210,12 +210,15 @@ static void cca_tsm_disconnect(struct pci_dev *pdev)
 	ide = dsc_pf0->sel_stream;
 	dsc_pf0->sel_stream = NULL;
 	pci_ide_stream_disable(pdev, ide);
+	rme_unassign_device(pdev);
+	module_put(THIS_MODULE);
 	tsm_ide_stream_unregister(ide);
 	pci_ide_stream_teardown(rp, ide);
 	pci_ide_stream_teardown(pdev, ide);
 	pci_ide_stream_unregister(ide);
 	clear_bit(ide->stream_id, cca_stream_ids);
 	pci_ide_stream_free(ide);
+	free_dev_communication_buffers(&dsc_pf0->comm_data);
 }
 
 static const struct pci_tsm_ops cca_pci_ops = {
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.c b/drivers/virt/coco/arm-cca-host/rmm-da.c
index d123940ce82e..ec8c5bfcee35 100644
--- a/drivers/virt/coco/arm-cca-host/rmm-da.c
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.c
@@ -346,3 +346,24 @@ int schedule_rme_ide_setup(struct pci_dev *pdev)
 
 	return 0;
 }
+
+void rme_unassign_device(struct pci_dev *pdev)
+{
+	unsigned long ret;
+	unsigned long state;
+	phys_addr_t rmm_pdev_phys;
+	struct cca_host_dsc_pf0 *dsc_pf0;
+
+	dsc_pf0 = to_cca_dsc_pf0(pdev);
+	rmm_pdev_phys = virt_to_phys(dsc_pf0->rmm_pdev);
+	ret = rmi_pdev_stop(rmm_pdev_phys);
+	if (WARN_ON(ret != RMI_SUCCESS))
+		return;
+
+	state = do_pdev_communicate(pdev->tsm, RMI_PDEV_STOPPED);
+	/* ignore the error state and destroy the device */
+	WARN_ON(state != RMI_PDEV_STOPPED);
+	ret = rmi_pdev_destroy(rmm_pdev_phys);
+	if (WARN_ON(ret != RMI_SUCCESS))
+		return;
+}
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.h b/drivers/virt/coco/arm-cca-host/rmm-da.h
index b9ddc4d9112b..c401be55d770 100644
--- a/drivers/virt/coco/arm-cca-host/rmm-da.h
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.h
@@ -71,5 +71,6 @@ static inline struct cca_host_comm_data *to_cca_comm_data(struct pci_dev *pdev)
 }
 
 int rme_asign_device(struct pci_dev *pdev);
+void rme_unassign_device(struct pci_dev *pdev);
 int schedule_rme_ide_setup(struct pci_dev *pdev);
 #endif
-- 
2.43.0


