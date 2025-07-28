Return-Path: <linux-pci+bounces-33053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A256AB13C5A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8518B4E073A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48671276054;
	Mon, 28 Jul 2025 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1OMyLaW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCFB2701DC;
	Mon, 28 Jul 2025 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710883; cv=none; b=tB4hPGqqu9Au41zeOB4XHDj+RpKceK2kD9qEpjAAj3JTJeKn8TEVIp+OH83du1yFIFxcGEXBppR4TUIM/TdUaOg44P/y8cd2jSWU+H/ASDX/1sJadHPkk3SvnvqsYBNmFW4R70GjnYI/AGyQPougtWPDz0UwqPo/ei9PJOoVCEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710883; c=relaxed/simple;
	bh=ca64YW29BY+3yIJN+Yk7BMDE8wvfxyvVL6RXDmvMNyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjXXjTFpiq7U+AgB8G81Mpvo6IkGhI8trTHC+lOIpSkIrkIc4DhPQEVcKGnthIHjSGbSKmMi8QrLKroGDVwJtAkVpiOpDWGeBvxcPVHauKEEsxJW+gvTY4UC0hezDewa3kspig4arApZWMs/kH92IjS1xsCaSfp5OkcCcOmNWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1OMyLaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604A4C4CEEF;
	Mon, 28 Jul 2025 13:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710883;
	bh=ca64YW29BY+3yIJN+Yk7BMDE8wvfxyvVL6RXDmvMNyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p1OMyLaWhvCNRDeCNZRukzEocmJ0dFl7+RLKUeM9FqtqhPViDI9p7YGHOUMa42vKW
	 VhGqcHqQgv+ZMcw8nSR6nr8PmdU1YtrvViSMoriSwH10QDPok3euRktO+e1ge8Jxpl
	 iRWEvBfNPIKYJEdR1CKWkdvkH7+ZIvIcErteCyvhdS3NhMfIdMI0a4nGqBzvR6/j1+
	 Z3HBdqH9HC0bcKgEv1zu3pYQJkRRwzB/hwmAd685vjf51ZdnZjwur9gp7V5dwOGKFo
	 5qwBernyZOOCI937jw73EIJXmixAe6Ifhz23oB/+70LvPxJVC4wD+KU7qEAiqlmLI0
	 D5nOF9A5eoCkA==
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
Subject: [RFC PATCH v1 21/38] coco: host: arm64: Add support for virtual device communication
Date: Mon, 28 Jul 2025 19:21:58 +0530
Message-ID: <20250728135216.48084-22-aneesh.kumar@kernel.org>
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

Add support for vdev_communicate with RMM.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rmi_cmds.h       | 22 ++++++++++++++++++++++
 arch/arm64/include/asm/rmi_smc.h        |  2 ++
 drivers/virt/coco/arm-cca-host/rmm-da.c | 21 +++++++++++++++++++--
 drivers/virt/coco/arm-cca-host/rmm-da.h |  2 ++
 4 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/rmi_cmds.h b/arch/arm64/include/asm/rmi_cmds.h
index 7d91f847069b..25197f47a0a9 100644
--- a/arch/arm64/include/asm/rmi_cmds.h
+++ b/arch/arm64/include/asm/rmi_cmds.h
@@ -587,4 +587,26 @@ static inline unsigned long rmi_vdev_create(unsigned long rd,
 	return res.a0;
 }
 
+static inline unsigned long rmi_vdev_communicate(unsigned long pdev_phys,
+						 unsigned long vdev_phys,
+						 unsigned long vdev_comm_data_phys)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RMI_VDEV_COMMUNICATE,
+			     pdev_phys, vdev_phys, vdev_comm_data_phys, &res);
+
+	return res.a0;
+}
+
+static inline unsigned long rmi_vdev_get_state(unsigned long vdev_phys, unsigned long *state)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RMI_VDEV_GET_STATE, vdev_phys, &res);
+
+	*state = res.a1;
+	return res.a0;
+}
+
 #endif /* __ASM_RMI_CMDS_H */
diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
index e5238b271493..127dd0938604 100644
--- a/arch/arm64/include/asm/rmi_smc.h
+++ b/arch/arm64/include/asm/rmi_smc.h
@@ -53,7 +53,9 @@
 #define SMC_RMI_PDEV_GET_STATE		SMC_RMI_CALL(0x0178)
 #define SMC_RMI_PDEV_SET_PUBKEY		SMC_RMI_CALL(0x017b)
 #define SMC_RMI_PDEV_STOP		SMC_RMI_CALL(0x017c)
+#define SMC_RMI_VDEV_COMMUNICATE	SMC_RMI_CALL(0x0186)
 #define SMC_RMI_VDEV_CREATE		SMC_RMI_CALL(0x0187)
+#define SMC_RMI_VDEV_GET_STATE		SMC_RMI_CALL(0x0189)
 
 
 #define RMI_ABI_MAJOR_VERSION	1
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.c b/drivers/virt/coco/arm-cca-host/rmm-da.c
index 41314db1d568..8635f361bbe8 100644
--- a/drivers/virt/coco/arm-cca-host/rmm-da.c
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.c
@@ -207,8 +207,14 @@ static int __do_dev_communicate(int type, struct pci_tsm *tsm)
 	if (type == PDEV_COMMUNICATE)
 		ret = rmi_pdev_communicate(virt_to_phys(dsc_pf0->rmm_pdev),
 					   virt_to_phys(comm_data->io_params));
-	else
-		ret = RMI_ERROR_INPUT;
+	else {
+		struct cca_host_tdi *host_tdi = container_of(tsm->tdi, struct cca_host_tdi, tdi);
+
+		ret = rmi_vdev_communicate(virt_to_phys(dsc_pf0->rmm_pdev),
+					   virt_to_phys(host_tdi->rmm_vdev),
+					   virt_to_phys(comm_data->io_params));
+	}
+
 	if (ret != RMI_SUCCESS) {
 		pr_err("pdev communicate error\n");
 		return ret;
@@ -299,6 +305,12 @@ static int do_dev_communicate(int type, struct pci_tsm *tsm, int target_state)
 			ret = rmi_pdev_get_state(virt_to_phys(dsc_pf0->rmm_pdev),
 						 &state);
 			error_state = RMI_PDEV_ERROR;
+		} else {
+			struct cca_host_tdi *host_tdi = container_of(tsm->tdi, struct cca_host_tdi, tdi);
+
+			ret = rmi_vdev_get_state(virt_to_phys(host_tdi->rmm_vdev),
+						 &state);
+			error_state = RMI_VDEV_ERROR;
 		}
 		if (ret != 0) {
 			pr_err("Get dev state error\n");
@@ -584,3 +596,8 @@ void *rme_create_vdev(struct realm *realm, struct pci_dev *pdev,
 err_out:
 	return ERR_PTR(ret);
 }
+
+static int __maybe_unused do_vdev_communicate(struct pci_tsm *tsm, int target_state)
+{
+	return do_dev_communicate(VDEV_COMMUNICATE, tsm, target_state);
+}
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.h b/drivers/virt/coco/arm-cca-host/rmm-da.h
index 6d612ea3b87f..37a8f4dce68e 100644
--- a/drivers/virt/coco/arm-cca-host/rmm-da.h
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.h
@@ -51,6 +51,8 @@ struct cca_host_tdi {
 };
 
 #define PDEV_COMMUNICATE	0x1
+#define VDEV_COMMUNICATE	0x2
+
 static inline struct cca_host_dsc_pf0 *to_cca_dsc_pf0(struct pci_dev *pdev)
 {
 	struct pci_tsm *tsm = pdev->tsm;
-- 
2.43.0


