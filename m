Return-Path: <linux-pci+bounces-33063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BC7B13C6A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D6F4E3052
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 14:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183D4273D7C;
	Mon, 28 Jul 2025 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8Ap4s3E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB98626F478;
	Mon, 28 Jul 2025 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710943; cv=none; b=TXO3OdXm0dggbfnpinA6iWacAEsqgc+qBTxV0L9pcUPTsOtYZVqBdrPG+DAZl0INV4QxMZ/wEbD2pUjPeK7MNAB6cSE6THtrn/377h1BRfDkIXWPKEKU7Fs7rGjNvT0h0YO/8ixHXqNxOrf2xWL7o2HGBf8v4lDFbXotx30Up+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710943; c=relaxed/simple;
	bh=jMF8HCm3Xp9lU82DGkhsoTy0DGh7IgTN4O7PJLsN8Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9b6H/t4tH+b8kM0YfAHEmpLPkA0CBJAy4r+bNC6Lk23wAy4Fb4R5Eobsvrw6ORCHBFEO3h6+IGuoJUpRp3Bkh8Th1QE83DZsjzVPYK9zshG4k/pcqUDCsrablinoABPDwO6djAjycSzFlAbMr7u3xNyvOTB9aud4C0AKLJJheg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8Ap4s3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174DAC4CEFA;
	Mon, 28 Jul 2025 13:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710941;
	bh=jMF8HCm3Xp9lU82DGkhsoTy0DGh7IgTN4O7PJLsN8Po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O8Ap4s3EyktRj3uCJ/vsNBOMv69LSBbdRvAhSe8qBTwNOb2q2VGnCR6xN9wwh1jzw
	 IhOuBKOoseNZHI8Lwzv7VMjFOFek1C5KoG4k1H+pd9qRccd0kPaGQ18Kh/meg+cdv+
	 Pr9rYm2iFIwQ/YsJRQgPoS2A1WXrKYe4frnmVaNqrJSl7TkmXevClKogQ3bhq4rRR2
	 gbdosR0WcxUCaUms2uoFu4Nawp/V7XCHasalAzsmvkpU46PFtuw4H1fSmnFWYphJ9z
	 hDTNIt8TZB2sUDSGvtPpEDfyAS5FbCE6HIDdXB2cgWeBawt0ErrI4YsM6KEXS+HLL5
	 vr7rJh4rzb/2w==
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
Subject: [RFC PATCH v1 31/38] coco: guest: arm64: Add support for fetching interface report and certificate chain from host
Date: Mon, 28 Jul 2025 19:22:08 +0530
Message-ID: <20250728135216.48084-32-aneesh.kumar@kernel.org>
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

Fetch interface report and certificate chain from the host using RHI calls.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rsi_cmds.h        |   9 ++
 arch/arm64/include/asm/rsi_smc.h         |   6 ++
 drivers/virt/coco/arm-cca-guest/rsi-da.c | 131 +++++++++++++++++++++++
 drivers/virt/coco/arm-cca-guest/rsi-da.h |   5 +
 4 files changed, 151 insertions(+)

diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
index 1d76f7d37cb6..18fc4e1ce577 100644
--- a/arch/arm64/include/asm/rsi_cmds.h
+++ b/arch/arm64/include/asm/rsi_cmds.h
@@ -219,4 +219,13 @@ static inline unsigned long __rsi_rdev_get_interface_report(unsigned long vdev_i
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
index 6afcccee2ae7..1d762fe3777b 100644
--- a/arch/arm64/include/asm/rsi_smc.h
+++ b/arch/arm64/include/asm/rsi_smc.h
@@ -183,6 +183,12 @@ struct realm_config {
  */
 #define SMC_RSI_IPA_STATE_GET			SMC_RSI_FID(0x198)
 
+struct rsi_host_call {
+	u16 imm;
+	u8 padding[6];
+	u64 gprs[31];
+};
+
 /*
  * Make a Host call.
  *
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
index 28ec946df1e2..47b379318e7c 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.c
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/pci.h>
+#include <linux/mem_encrypt.h>
 #include <asm/rsi_cmds.h>
 
 #include "rsi-da.h"
@@ -50,6 +51,121 @@ rsi_rdev_get_interface_report(struct pci_dev *pdev, unsigned long vdev_id,
 	return RSI_SUCCESS;
 }
 
+static long rhi_get_report(int vdev_id, int da_object_type, void **report, int *report_size)
+{
+	int ret, enc_ret = 0;
+	int nr_pages;
+	int max_data_len;
+	void *data_buf_shared, *data_buf_private;
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
+	if (ret != RSI_SUCCESS) {
+		ret =  -EIO;
+		goto err_out;
+	}
+
+	if (rhicall->gprs[0] != 0x3) {
+		ret =  -EIO;
+		goto err_out;
+	}
+
+	rhicall->imm = 0;
+	rhicall->gprs[0] = RHI_DA_OBJECT_SIZE;
+	rhicall->gprs[1] = vdev_id;
+	rhicall->gprs[2] = da_object_type;
+
+	ret = rsi_host_call(virt_to_phys(rhicall));
+	if (ret != RSI_SUCCESS) {
+		ret =  -EIO;
+		goto err_out;
+	}
+	if (rhicall->gprs[0] != RHI_DA_SUCCESS) {
+		ret =  -EIO;
+		goto err_out;
+	}
+	max_data_len = rhicall->gprs[1];
+	*report_size = max_data_len;
+
+	/*
+	 * We need to share this memory with hypervisor.
+	 * So it should be multiple of sharing unit.
+	 */
+	max_data_len = ALIGN(max_data_len, PAGE_SIZE);
+	nr_pages = max_data_len >> PAGE_SHIFT;
+
+	if (!max_data_len || nr_pages > MAX_ORDER_NR_PAGES) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	/*
+	 * We need to share this memory with hypervisor.
+	 * So it should be multiple of sharing unit.
+	 */
+	data_buf_shared = (void *)__get_free_pages(GFP_KERNEL, get_order(max_data_len));
+	if (!data_buf_shared) {
+		ret =  -ENOMEM;
+		goto err_out;
+	}
+
+	data_buf_private = kmalloc(*report_size, GFP_KERNEL);
+	if (!data_buf_private) {
+		ret =  -ENOMEM;
+		goto err_private_alloc;
+	}
+
+	ret = set_memory_decrypted((unsigned long)data_buf_shared, nr_pages);
+	if (ret) {
+		ret =  -EIO;
+		goto err_decrypt;
+	}
+
+	rhicall->imm = 0;
+	rhicall->gprs[0] = RHI_DA_OBJECT_READ;
+	rhicall->gprs[1] = vdev_id;
+	rhicall->gprs[2] = da_object_type;
+	rhicall->gprs[3] = 0; /* offset within the data buffer */
+	rhicall->gprs[4] = max_data_len;
+	rhicall->gprs[5] = virt_to_phys(data_buf_shared);
+	ret = rsi_host_call(virt_to_phys(rhicall));
+	if (ret != RSI_SUCCESS || rhicall->gprs[0] != RHI_DA_SUCCESS) {
+		ret =  -EIO;
+		goto err_rhi_call;
+	}
+
+	memcpy(data_buf_private, data_buf_shared, *report_size);
+	enc_ret = set_memory_encrypted((unsigned long)data_buf_shared, nr_pages);
+	if (!enc_ret)
+		/* If we fail to mark it encrypted don't free it back */
+		free_pages((unsigned long)data_buf_shared, get_order(max_data_len));
+
+	*report = data_buf_private;
+	kfree(rhicall);
+	return 0;
+
+err_rhi_call:
+	enc_ret = set_memory_encrypted((unsigned long)data_buf_shared, nr_pages);
+err_decrypt:
+	kfree(data_buf_private);
+err_private_alloc:
+	if (!enc_ret)
+		/* If we fail to mark it encrypted don't free it back */
+		free_pages((unsigned long)data_buf_shared, get_order(max_data_len));
+err_out:
+	*report = NULL;
+	*report_size = 0;
+	kfree(rhicall);
+	return ret;
+}
+
 int rsi_device_lock(struct pci_dev *pdev)
 {
 	unsigned long ret;
@@ -82,5 +198,20 @@ int rsi_device_lock(struct pci_dev *pdev)
 		return -EOPNOTSUPP;
 	}
 
+	/* Now make a host call to copy the interface report to guest. */
+	ret = rhi_get_report(vdev_id, RHI_DA_OBJECT_INTERFACE_REPORT,
+			     &dsm->interface_report, &dsm->interface_report_size);
+	if (ret) {
+		pci_err(pdev, "failed to get interface report from the host (%lu)\n", ret);
+		return -EIO;
+	}
+
+	ret = rhi_get_report(vdev_id, RHI_DA_OBJECT_CERTIFICATE,
+			     &dsm->certificate, &dsm->certificate_size);
+	if (ret) {
+		pci_err(pdev, "failed to get device certificate from the host (%lu)\n", ret);
+		return -EIO;
+	}
+
 	return ret;
 }
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
index f12430c7d792..bd565785ff4b 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.h
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
@@ -9,10 +9,15 @@
 #include <linux/pci.h>
 #include <linux/pci-tsm.h>
 #include <asm/rsi_smc.h>
+#include <asm/rhi.h>
 
 struct cca_guest_dsc {
 	struct pci_tsm_pf0 pci;
 	unsigned long instance_id;
+	void *interface_report;
+	int interface_report_size;
+	void *certificate;
+	int certificate_size;
 };
 
 static inline struct cca_guest_dsc *to_cca_guest_dsc(struct pci_dev *pdev)
-- 
2.43.0


