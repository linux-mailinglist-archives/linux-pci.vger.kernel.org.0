Return-Path: <linux-pci+bounces-33061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DEBB13C6C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6493A1B8F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 14:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE6D273D7F;
	Mon, 28 Jul 2025 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHTzaYAT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2612273D7C;
	Mon, 28 Jul 2025 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710929; cv=none; b=ALg4C5LKVr4M+eURqOspOHbPBIggVlieQeXXoZDa58xDiEnu6JpV299uevFkifLFKhrEbjDrbgIgfp8QbI+LQg6S4ku6Gs6TYXNCBA1FAzp7SwquQAln3FAS8nOFkjd9ZjUZtQYotLeSXgxZ8Onr7E0WawS0XkDd2W2u/oJ/MIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710929; c=relaxed/simple;
	bh=Ze7PT5F9v/p5VT9WHtpaCA4SAdVWFE+04WmlwvCiPpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRRZzN3E0YnmKTJcowu9Hvzb3Am5weht/+IfXwGx0j75PwPgjHMli0F2wQWLp+/IgclCzSjes5T4z9vyOUrYrP6s/NvH7yIE8dqywu1k1xyJPR8Byb6tKYl0Tir+hx+TiDf4QNmq5xu7vl8tgRtcSIKDlz5zIF1UJDbHf1HR5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHTzaYAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0FDC4CEF7;
	Mon, 28 Jul 2025 13:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710929;
	bh=Ze7PT5F9v/p5VT9WHtpaCA4SAdVWFE+04WmlwvCiPpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EHTzaYATelYucJ58eoPs+D2HGmOMerJ9TqheUwRR9fWa80wiu3b7afAwuTXXVMx0I
	 qsZeHTG96YAtnWohw8UHhyOWU2J/5tD2kQ50w4nSMXCSccAmy2AhKu+Ut7PD3VJduq
	 PufT9ds23yxb9pGu5O6xzmm2B1Y4R2ps9R4O9G0SNcMEZORyDtPltcVnV+x70gUOXm
	 VEyKWeePSybKuOavQnrlTsT5ftDRNVnkcAN9h+u2p/cmb9PE3q0uy3zi9E29Dz8LtJ
	 EmkeGgRzC0G2jfvSgWMMrUm7PD43syBGxXI3GABAkrgMJhYAxcSvG3Cnt80sFXokdY
	 OzFg2rvRigPXA==
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
Subject: [RFC PATCH v1 29/38] coco: guest: arm64: Add support for collecting interface reports
Date: Mon, 28 Jul 2025 19:22:06 +0530
Message-ID: <20250728135216.48084-30-aneesh.kumar@kernel.org>
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

Support collecting interface reports using RSI calls.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rsi_cmds.h        | 14 ++++++++++
 arch/arm64/include/asm/rsi_smc.h         |  2 ++
 drivers/virt/coco/arm-cca-guest/rsi-da.c | 34 ++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
index b9c4b8ff5631..1d76f7d37cb6 100644
--- a/arch/arm64/include/asm/rsi_cmds.h
+++ b/arch/arm64/include/asm/rsi_cmds.h
@@ -205,4 +205,18 @@ static inline unsigned long rsi_rdev_continue(unsigned long vdev_id, unsigned lo
 	return res.a0;
 }
 
+static inline unsigned long __rsi_rdev_get_interface_report(unsigned long vdev_id,
+							  unsigned long inst_id,
+							  unsigned long version_max,
+							  unsigned long *version)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RSI_RDEV_GET_INTERFACE_REPORT,
+			     vdev_id, inst_id, version_max, &res);
+
+	*version = res.a1;
+	return res.a0;
+}
+
 #endif /* __ASM_RSI_CMDS_H */
diff --git a/arch/arm64/include/asm/rsi_smc.h b/arch/arm64/include/asm/rsi_smc.h
index 44b583ab6d67..6afcccee2ae7 100644
--- a/arch/arm64/include/asm/rsi_smc.h
+++ b/arch/arm64/include/asm/rsi_smc.h
@@ -194,6 +194,8 @@ struct realm_config {
 #define SMC_RSI_RDEV_GET_INSTANCE_ID		SMC_RSI_FID(0x19c)
 #define SMC_RSI_RDEV_CONTINUE			SMC_RSI_FID(0x1a4)
 
+#define SMC_RSI_RDEV_GET_INTERFACE_REPORT	SMC_RSI_FID(0x1a6)
+
 #define SMC_RSI_RDEV_LOCK			SMC_RSI_FID(0x1a9)
 
 #endif /* __ASM_RSI_SMC_H_ */
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
index 097cf52ee199..28ec946df1e2 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.c
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c
@@ -29,9 +29,31 @@ static inline unsigned long rsi_rdev_lock(struct pci_dev *pdev,
 	return RSI_SUCCESS;
 }
 
+static inline unsigned long
+rsi_rdev_get_interface_report(struct pci_dev *pdev, unsigned long vdev_id,
+			      unsigned long inst_id, unsigned long version_max,
+			      unsigned long *version)
+{
+	unsigned long ret;
+
+	ret = __rsi_rdev_get_interface_report(vdev_id, inst_id, version_max, version);
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
 int rsi_device_lock(struct pci_dev *pdev)
 {
 	unsigned long ret;
+	unsigned long tdisp_version;
 	struct cca_guest_dsc *dsm = to_cca_guest_dsc(pdev);
 	int vdev_id = (pci_domain_nr(pdev->bus) << 16) |
 		PCI_DEVID(pdev->bus->number, pdev->devfn);
@@ -48,5 +70,17 @@ int rsi_device_lock(struct pci_dev *pdev)
 		return -EIO;
 	}
 
+	ret = rsi_rdev_get_interface_report(pdev, vdev_id, dsm->instance_id,
+					   PCI_TDISP_MESSAGE_VERSION_10, &tdisp_version);
+	if (ret != RSI_SUCCESS) {
+		pci_err(pdev, "failed to get interface report (%lu)\n", ret);
+		return -EIO;
+	}
+
+	if (tdisp_version != PCI_TDISP_MESSAGE_VERSION_10) {
+		pci_err(pdev, "unknown TDISP version (%lu)\n", tdisp_version);
+		return -EOPNOTSUPP;
+	}
+
 	return ret;
 }
-- 
2.43.0


