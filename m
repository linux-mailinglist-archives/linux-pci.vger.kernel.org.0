Return-Path: <linux-pci+bounces-33059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DCCB13C65
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674963AD540
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F270273816;
	Mon, 28 Jul 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oca8P+Ad"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A85270EA9;
	Mon, 28 Jul 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710918; cv=none; b=nUge+oh5Zvnn7z76bH1NygGcOSghmNq9qEcuYnxY9hbmjBZhAAOO6LNUAJnIuMLMqCcl4a3km5xm/D0VnCwpyceC2JQNYJXtxPeeAjcWfy1gpxiaCwFCGaEyhWVj02kms/1fQc44J/iQqggQ+CHB7+s2IOExJko/sY0cgDApBVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710918; c=relaxed/simple;
	bh=fqnzlrHLcIMF/lg6bG+5Jt046U62wnLlnwGVVvNwy90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvWLMMYUY8eqcLmevY/ysK0nl1L1yf6tIR2A+GhxFlE2V/9UraZ7f0R/OorcoKqSpAYKyuqUn1nkfVrWcToDNm1TqT23X7uOS9OW+ZKPSQwRjB/FxmzuhMzKBNJt6DcNp6Wob92GnvY+skLb2ROMeJxLSU2l5wMSyzl0vMotbM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oca8P+Ad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CC7C4CEE7;
	Mon, 28 Jul 2025 13:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710918;
	bh=fqnzlrHLcIMF/lg6bG+5Jt046U62wnLlnwGVVvNwy90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oca8P+Adv6G68EpAKr+jO0tSMmI+LeTI3Qk8wtMpF6E3dcmlmxlAmH+jh3PxW0Xv/
	 9F1w2KqbDw33b9A88SmuAMFwDswj2UkojHBWqdp00+f9XJvN/aZ+NqPhbcrX3jCWct
	 6UTVZLOXA2TmYsjCtQ2NNnEkPZK3zZ6IDV0okrQ4AZvUISz5uSvACkscRVZ2Ij5HY/
	 5FHCPIKxlRh934rlUbgzvS6jBPf9MXf6a3XzXAO4DDVZH5BWUYlzsDeRLQyhR6ANAc
	 Km4Vm3P/BkE65z40HAcZKBRxevxEVF1I2hCwQ9mnNzvxWNKeNtMAUmNrykj2YJ98tI
	 mduY4ddfrFkfw==
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
Subject: [RFC PATCH v1 27/38] coco: host: arm64: add RSI_RDEV_GET_INSTANCE_ID related exit handler
Date: Mon, 28 Jul 2025 19:22:04 +0530
Message-ID: <20250728135216.48084-28-aneesh.kumar@kernel.org>
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

Mapping the VDEV object that matches a specified virtual device ID
results in a REC exit, which is handled by the VDEV request exit
handler.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rmi_cmds.h        |  8 +++++
 arch/arm64/include/asm/rmi_smc.h         |  9 ++++--
 drivers/virt/coco/arm-cca-host/arm-cca.c |  8 ++++-
 drivers/virt/coco/arm-cca-host/rmm-da.c  | 39 ++++++++++++++++++++++++
 drivers/virt/coco/arm-cca-host/rmm-da.h  |  2 ++
 5 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/rmi_cmds.h b/arch/arm64/include/asm/rmi_cmds.h
index eb4f67eb6b01..fcf6b319e953 100644
--- a/arch/arm64/include/asm/rmi_cmds.h
+++ b/arch/arm64/include/asm/rmi_cmds.h
@@ -629,5 +629,13 @@ static inline unsigned long rmi_vdev_destroy(unsigned long rd,
 	return res.a0;
 }
 
+static inline unsigned long rmi_vdev_complete(unsigned long rec_phys, unsigned long vdev_phys)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RMI_VDEV_COMPLETE, rec_phys, vdev_phys, &res);
+
+	return res.a0;
+}
 
 #endif /* __ASM_RMI_CMDS_H */
diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
index a5ef68b62bc0..6b23afa070d1 100644
--- a/arch/arm64/include/asm/rmi_smc.h
+++ b/arch/arm64/include/asm/rmi_smc.h
@@ -57,7 +57,8 @@
 #define SMC_RMI_VDEV_CREATE		SMC_RMI_CALL(0x0187)
 #define SMC_RMI_VDEV_DESTROY		SMC_RMI_CALL(0x0188)
 #define SMC_RMI_VDEV_GET_STATE		SMC_RMI_CALL(0x0189)
-#define SMC_RMI_VDEV_STOP		SMC_RMI_CALL(0x018A)
+#define SMC_RMI_VDEV_STOP		SMC_RMI_CALL(0x018a)
+#define SMC_RMI_VDEV_COMPLETE		SMC_RMI_CALL(0x018e)
 
 #define RMI_ABI_MAJOR_VERSION	1
 #define RMI_ABI_MINOR_VERSION	0
@@ -262,7 +263,11 @@ struct rec_exit {
 		struct {
 			u64 ripas_base;
 			u64 ripas_top;
-			u64 ripas_value;
+			u8 ripas_value;
+			u8 padding8[15];
+			u64 s2ap_base;
+			u64 s2ap_top;
+			u64 vdev_id;
 		};
 		u8 padding5[0x100];
 	};
diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
index 3792d7b5cb99..837bd10ccd47 100644
--- a/drivers/virt/coco/arm-cca-host/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
@@ -275,13 +275,19 @@ static void cca_tsm_remove(void *tsm_core)
 
 static int cca_tsm_probe(struct platform_device *pdev)
 {
+	int rc;
 	struct tsm_core_dev *tsm_core;
 
 	tsm_core = tsm_register(&pdev->dev, NULL, &cca_pci_ops);
 	if (IS_ERR(tsm_core))
 		return PTR_ERR(tsm_core);
 
-	return devm_add_action_or_reset(&pdev->dev, cca_tsm_remove, tsm_core);
+	rc = devm_add_action_or_reset(&pdev->dev, cca_tsm_remove, tsm_core);
+	if (rc)
+		return rc;
+
+	rme_register_exit_handlers();
+	return 0;
 }
 
 static const struct platform_device_id arm_cca_host_id_table[] = {
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.c b/drivers/virt/coco/arm-cca-host/rmm-da.c
index 53072610fa67..d4f1da590b90 100644
--- a/drivers/virt/coco/arm-cca-host/rmm-da.c
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.c
@@ -660,3 +660,42 @@ void rme_unbind_vdev(struct realm *realm, struct pci_dev *pdev, struct pci_dev *
 		return;
 	}
 }
+
+static struct pci_tsm *find_pci_tsm_from_vdev_id(unsigned long vdev_id)
+{
+	struct pci_dev *pdev = NULL;
+	struct cca_host_tdi *host_tdi;
+
+	for_each_pci_dev(pdev) {
+		host_tdi = to_cca_host_tdi(pdev);
+		if (!host_tdi)
+			continue;
+		if (host_tdi->vdev_id == vdev_id)
+			return pdev->tsm;
+	}
+	return NULL;
+}
+
+static int rme_exit_vdev_req_handler(struct realm_rec *rec)
+{
+	struct cca_host_tdi *host_tdi = NULL;
+	unsigned long vdev_id = rec->run->exit.vdev_id;
+	struct pci_tsm *tsm = find_pci_tsm_from_vdev_id(vdev_id);
+	phys_addr_t rec_phys = virt_to_phys(rec->rec_page);
+
+	if (tsm)
+		host_tdi = to_cca_host_tdi(tsm->pdev);
+
+	if (host_tdi)
+		rmi_vdev_complete(rec_phys, virt_to_phys(host_tdi->rmm_vdev));
+	/*
+	 * Return back to the guest without calling vdev complete.
+	 * The Realm will treat that as an error.
+	 */
+	return 1;
+}
+
+void rme_register_exit_handlers(void)
+{
+	realm_exit_vdev_req_handler = rme_exit_vdev_req_handler;
+}
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.h b/drivers/virt/coco/arm-cca-host/rmm-da.h
index 6361f7403f95..7f51b611467b 100644
--- a/drivers/virt/coco/arm-cca-host/rmm-da.h
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.h
@@ -48,6 +48,7 @@ struct cca_host_dsc_pf0 {
 struct cca_host_tdi {
 	struct pci_tdi tdi;
 	void *rmm_vdev;
+	unsigned long vdev_id;
 };
 
 #define PDEV_COMMUNICATE	0x1
@@ -95,4 +96,5 @@ void *rme_create_vdev(struct realm *realm, struct pci_dev *pdev,
 		      struct pci_dev *pf0_dev, u32 guest_rid);
 void rme_unbind_vdev(struct realm *realm, struct pci_dev *pdev,
 		     struct pci_dev *pf0_dev);
+void rme_register_exit_handlers(void);
 #endif
-- 
2.43.0


