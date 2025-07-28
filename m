Return-Path: <linux-pci+bounces-33036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B967B13C21
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 15:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C29C171983
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C60F27056B;
	Mon, 28 Jul 2025 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvWNFLot"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7DA26E706;
	Mon, 28 Jul 2025 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710780; cv=none; b=RAMrhOjnqNUSiG11TWJcRS5Rm+dYHtTqSyz2cRTPrYaCGVBvC3K2XD6pIvvw3yT4Ely0QGkH1jNciAw9BRfotmXmntTjH5maT+RhF2oE0Tvx4vJNW5aAvoZ+8Q37H2calvtwpvrAv++sQE88BG8WG+TGfHwSXuHZz6CjcrhVbcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710780; c=relaxed/simple;
	bh=crQmIBxnXL3o3APy/KQ9gWV678svZmleS6w7UUsQBYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ihj6jD7xWgRLeDeGf8lX4YKTocyprICgNZBVAEDwy+k84j0mWOCSA3LQ/o3aXywzUTlsSgXQHAu2vteEvrj8NACCDwHW9ctr78ixlXJXSnWNiicEkFeCuLSsgqR+6C7ZwbEWk0dLDkjnlLv+kV1foikRkzXL1BuGMYhU+9BtPFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvWNFLot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77FFC4CEEF;
	Mon, 28 Jul 2025 13:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710780;
	bh=crQmIBxnXL3o3APy/KQ9gWV678svZmleS6w7UUsQBYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gvWNFLotkMFXKc2YnfRzLBhcO6Ch2DrZp6shgUC6yA0OTdhEukyJzBbql4VQl5Tfs
	 5tt2LpzoJtcb7ZT/qWVxelh6+LGYKPyU6Ays4SqHlbEznEJJEgT2DKX8dWGpU0mI8j
	 CesKY5K3Rc5dKdT9szwGJYeO+ojwd1jorT/3gylSG1wtW6JPWUelIX7IA3gupHQMRv
	 2wC7Xe/9XoK2MWpd669RWoVncOF09EmVuvhgBujyYWsk3WTfyGLfJxa9EvzuLreWDo
	 hibfXaYXqgGIyThhX47foGPCNj6dQRGunRL9h1dJD3RYgNdJScJsEvYHfxiChPRQRC
	 TB1vsPV71XjvA==
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
Subject: [RFC PATCH v1 04/38] tsm: Support DMA Allocation from private memory
Date: Mon, 28 Jul 2025 19:21:41 +0530
Message-ID: <20250728135216.48084-5-aneesh.kumar@kernel.org>
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

Currently, we enforce the use of bounce buffers to ensure that memory
accessed by non-secure devices is explicitly shared with the host [1].
However, for secure devices, this approach must be avoided.

To achieve this, we introduce a device flag that controls whether a
bounce buffer allocation is required for the device. Additionally, this flag is
used to manage the top IPA bit assignment for setting up
protected/unprotected IPA aliases.

[1] commit fbf979a01375 ("arm64: Enforce bounce buffers for realm DMA")

based on changes from Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/mem_encrypt.h |  6 +-----
 arch/arm64/mm/mem_encrypt.c          | 10 ++++++++++
 drivers/pci/tsm.c                    |  6 ++++++
 include/linux/device.h               |  1 +
 include/linux/swiotlb.h              |  4 ++++
 5 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/mem_encrypt.h b/arch/arm64/include/asm/mem_encrypt.h
index 314b2b52025f..d77c10cd5b79 100644
--- a/arch/arm64/include/asm/mem_encrypt.h
+++ b/arch/arm64/include/asm/mem_encrypt.h
@@ -15,14 +15,10 @@ int arm64_mem_crypt_ops_register(const struct arm64_mem_crypt_ops *ops);
 
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
+bool force_dma_unencrypted(struct device *dev);
 
 int realm_register_memory_enc_ops(void);
 
-static inline bool force_dma_unencrypted(struct device *dev)
-{
-	return is_realm_world();
-}
-
 /*
  * For Arm CCA guests, canonical addresses are "encrypted", so no changes
  * required for dma_addr_encrypted().
diff --git a/arch/arm64/mm/mem_encrypt.c b/arch/arm64/mm/mem_encrypt.c
index ee3c0ab04384..279696a8af3f 100644
--- a/arch/arm64/mm/mem_encrypt.c
+++ b/arch/arm64/mm/mem_encrypt.c
@@ -17,6 +17,7 @@
 #include <linux/compiler.h>
 #include <linux/err.h>
 #include <linux/mm.h>
+#include <linux/device.h>
 
 #include <asm/mem_encrypt.h>
 
@@ -48,3 +49,12 @@ int set_memory_decrypted(unsigned long addr, int numpages)
 	return crypt_ops->decrypt(addr, numpages);
 }
 EXPORT_SYMBOL_GPL(set_memory_decrypted);
+
+bool force_dma_unencrypted(struct device *dev)
+{
+	if (dev->tdi_enabled)
+		return false;
+
+	return is_realm_world();
+}
+EXPORT_SYMBOL_GPL(force_dma_unencrypted);
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index e4a3b5b37939..60f50d57a725 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -120,6 +120,7 @@ static int pci_tsm_disconnect(struct pci_dev *pdev)
 
 	tsm_ops->disconnect(pdev);
 	tsm->state = PCI_TSM_INIT;
+	pdev->dev.tdi_enabled = false;
 
 	return 0;
 }
@@ -199,6 +200,8 @@ static int pci_tsm_accept(struct pci_dev *pdev)
 	if (rc)
 		return rc;
 	tsm->state = PCI_TSM_ACCEPT;
+	pdev->dev.tdi_enabled = true;
+
 	return 0;
 }
 
@@ -557,6 +560,9 @@ static void __pci_tsm_init(struct pci_dev *pdev)
 	default:
 		break;
 	}
+
+	/* FIXME!! should this be default true and switch to false for TEE capable device */
+	pdev->dev.tdi_enabled = false;
 }
 
 void pci_tsm_init(struct pci_dev *pdev)
diff --git a/include/linux/device.h b/include/linux/device.h
index 4940db137fff..d62e0dd9d8ee 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -688,6 +688,7 @@ struct device {
 #ifdef CONFIG_IOMMU_DMA
 	bool			dma_iommu:1;
 #endif
+	bool			tdi_enabled:1;
 };
 
 /**
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063..61e7cff7768b 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -173,6 +173,10 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 
+	if (dev->tdi_enabled) {
+		dev_warn_once(dev, "(TIO) Disable SWIOTLB");
+		return false;
+	}
 	return mem && mem->force_bounce;
 }
 
-- 
2.43.0


