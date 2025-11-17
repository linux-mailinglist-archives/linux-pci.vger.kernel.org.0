Return-Path: <linux-pci+bounces-41418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB7DC64933
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 15:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 630B63622F2
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 14:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9821F33342E;
	Mon, 17 Nov 2025 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dC03GAh6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E9A2AEF5;
	Mon, 17 Nov 2025 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388096; cv=none; b=cEMvGco7m8+OYNiE+ZS77Kc2G7eLSGqr2HKjF4qoENgFBIOkUj2UvQKRa4+P4iDO7YbU1KgspxKkQ/CBB+7yeU2AvalMvhmKh+7RRSG8y0jW3bfRL2ybcz/pWwdC3jR42ZjR6hBEqrdStNWokx4gBG7vlNxf2tC7bWr8DWrXMvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388096; c=relaxed/simple;
	bh=jzqp5L6i6oSJSOFQ7k80/LJ+BF1WQ9a6s4hanokXhI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzvaGju2QWka8tReaZcUi2n5SWITCOK3XZzPg/PI3/AuhpJOFGeb6OSQVl44ZDWmHdcxgQQCdssUNpxCOadnau9+NsNZy+2q9QUH5iZpp2uGiC0woJLZ3eKVpAACtaeEWb35/ldztR4dfrwKzx/iVgh0OZZMEqadxxqtGMtqzPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dC03GAh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D1DC19424;
	Mon, 17 Nov 2025 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763388096;
	bh=jzqp5L6i6oSJSOFQ7k80/LJ+BF1WQ9a6s4hanokXhI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dC03GAh6W5C1RFPMo5liMfGzVU17Ta6KatQ/l0ICX5l64Ettk36M76oY0HA5QxrXV
	 PAhRg2PAOLDueI96eBHlOYnXNBQWTSrCxI9vVotB/iFfTAb9QheLVGEsK4+GHqAViB
	 Np3Qld9FiUA+mmkcYhfk9nl3pIzDenFzZXc83uQigO22G3d6Gjlj0U2fuy8V/FF8cQ
	 RdswForiQ2KDRZjfYzzyRzG9JQRYkJTjwhCo4UKJ99RmDH5jDTzsvHnvzjunBhMobs
	 uuPMMUzG2I6sNZgeYp/oea/A3BLZhQQsWYaIgvnu31tzdOqI51iY4g13G01jx47XnJ
	 MCIG3ZI4KUNbA==
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
Subject: [PATCH v2 11/11] coco: guest: arm64: Enable vdev DMA after attestation
Date: Mon, 17 Nov 2025 19:30:07 +0530
Message-ID: <20251117140007.122062-12-aneesh.kumar@kernel.org>
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

- define SMC_RSI_VDEV_DMA_ENABLE and add wrapper in rsi_cmds.h
- invoke the new helper from the guest accept path once the device
  passes attestation, rolling back to TDI_LOCKED on failure

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rsi_cmds.h        | 15 +++++++++++++++
 arch/arm64/include/asm/rsi_smc.h         |  2 ++
 drivers/virt/coco/arm-cca-guest/rsi-da.c | 14 ++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
index e6d68760a729..bce08778c799 100644
--- a/arch/arm64/include/asm/rsi_cmds.h
+++ b/arch/arm64/include/asm/rsi_cmds.h
@@ -225,4 +225,19 @@ static inline unsigned long rsi_vdev_get_info(unsigned long vdev_id,
 	return res.a0;
 }
 
+static inline unsigned long __rsi_vdev_dma_enable(unsigned long vdev_id,
+						  unsigned long non_ats_plane,
+						  unsigned long lock_nonce,
+						  unsigned long meas_nonce,
+						  unsigned long report_nonce)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RSI_VDEV_DMA_ENABLE, vdev_id,
+			     non_ats_plane, lock_nonce,
+			     meas_nonce, report_nonce, &res);
+
+	return res.a0;
+}
+
 #endif /* __ASM_RSI_CMDS_H */
diff --git a/arch/arm64/include/asm/rsi_smc.h b/arch/arm64/include/asm/rsi_smc.h
index 49334d07dd55..7bfc8bc5c2ff 100644
--- a/arch/arm64/include/asm/rsi_smc.h
+++ b/arch/arm64/include/asm/rsi_smc.h
@@ -186,6 +186,8 @@ struct realm_config {
  */
 #define SMC_RSI_IPA_STATE_GET			SMC_RSI_FID(0x198)
 
+#define SMC_RSI_VDEV_DMA_ENABLE			SMC_RSI_FID(0x19C)
+
 struct rsi_vdevice_info {
 	union {
 		struct {
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
index 4852a03dd17d..0b98f6271da6 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.c
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c
@@ -264,6 +264,13 @@ static int verify_digests(struct cca_guest_dsc *dsc)
 	return 0;
 }
 
+static inline int rsi_vdev_enable_dma(int vdev_id, struct dsm_device_info *dev_info)
+{
+	return __rsi_vdev_dma_enable(vdev_id, 0, dev_info->lock_nonce,
+				     dev_info->meas_nonce, dev_info->report_nonce);
+
+}
+
 int cca_device_verify_and_accept(struct pci_dev *pdev)
 {
 	int ret;
@@ -336,5 +343,12 @@ int cca_device_verify_and_accept(struct pci_dev *pdev)
 		pci_err(pdev, "failed to switch the device (%u) to RUN state\n", ret);
 		return -EIO;
 	}
+
+	if (rsi_vdev_enable_dma(vdev_id, &dsc->dev_info)) {
+		rhi_vdev_set_tdi_state(pdev, RHI_DA_TDI_CONFIG_LOCKED);
+		pci_err(pdev, "failed to enable DMA from the device %d\n", ret);
+		return -EIO;
+	}
+
 	return 0;
 }
-- 
2.43.0


