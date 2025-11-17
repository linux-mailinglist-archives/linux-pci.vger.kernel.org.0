Return-Path: <linux-pci+bounces-41415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB024C648E2
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 15:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50C43A70B8
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53456336ED2;
	Mon, 17 Nov 2025 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KISwR/Pg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B3336EC7;
	Mon, 17 Nov 2025 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388075; cv=none; b=n4tm25AuG8vdisCjQ3RwoOeEc4fHMCm+q/yB0cn95Im6LOSJplA5EZz+3/KHTPn0lr7qTGVY9BFdf/RuwXatoPzbHITgTBYvn9RxpRrmmVjJzKOqhT9pJQEhPnz33nAHXouaEJoJpWa2Kwph9Uod1DLY4nYzarHQIDh1GhJkR+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388075; c=relaxed/simple;
	bh=83cGjVsHaKol+DxWoJqr/upzEHjkOyZzDL5nh2XAtIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/VcRfgxLOrugytyMRDJ+TeCRY8z2GURnbtEyRb2mRHw35Wm9YUldrHi6lDR5BRfEFekwrxqcdwtF1cjMkY9mvxy3j2d0imUsmnv1kDil2WhJOEjcMhiZhGrTBbzKMqBRAg/2m8qL1AbNp3xEMumVwMZ24QGSJ1c4onDy6m8xAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KISwR/Pg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE5EC4CEFB;
	Mon, 17 Nov 2025 14:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763388074;
	bh=83cGjVsHaKol+DxWoJqr/upzEHjkOyZzDL5nh2XAtIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KISwR/PgrPy3fHr1F7Jlawid4JIyto55j0KplUOlois4hUmlkmhYM2CzSI0v1/O/p
	 BU5fWLTSmbkebeBxLwHREhRd+Ape6dlEvE8T5rGTFug2rM1k+852y3PktQ4ePn8+kz
	 pUsuapk9jwd1KvFSbc97gH9woYswM8GX1X/hJeM38jAI98acVnCdCdl+GLIgFwRg9d
	 R5aC4xRFJXSBe2dgfWkDnZSDwQGTUno7n6WqRO/vWtmVxhaxwCs64VtbN2IgL23Jdv
	 JiwdbGbU2eZUrdD9uh9HqE2jTaBFDXj5hiWCdgSqCk70pgiqzwqb49AHqtrv26MdXk
	 h3nfT0XINVm8Q==
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
Subject: [PATCH v2 08/11] coco: guest: arm64: Add support for fetching and verifying device info
Date: Mon, 17 Nov 2025 19:30:04 +0530
Message-ID: <20251117140007.122062-9-aneesh.kumar@kernel.org>
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

RSI_RDEV_GET_INFO returns different digest hash values, which can be
compared with host cached values to ensure the host didn't tamper with
the cached data.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rsi_cmds.h        |  11 ++
 arch/arm64/include/asm/rsi_smc.h         |  44 +++++++
 drivers/virt/coco/arm-cca-guest/Kconfig  |   2 +
 drivers/virt/coco/arm-cca-guest/rsi-da.c | 139 ++++++++++++++++++++++-
 drivers/virt/coco/arm-cca-guest/rsi-da.h |  15 +++
 5 files changed, 210 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
index fe36dd2b96ac..e6d68760a729 100644
--- a/arch/arm64/include/asm/rsi_cmds.h
+++ b/arch/arm64/include/asm/rsi_cmds.h
@@ -214,4 +214,15 @@ rsi_vdev_validate_mapping(unsigned long vdev_id,
 	return res.a0;
 }
 
+static inline unsigned long rsi_vdev_get_info(unsigned long vdev_id,
+					      unsigned long digest_phys)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RSI_VDEV_GET_INFO,
+			     vdev_id, digest_phys, &res);
+
+	return res.a0;
+}
+
 #endif /* __ASM_RSI_CMDS_H */
diff --git a/arch/arm64/include/asm/rsi_smc.h b/arch/arm64/include/asm/rsi_smc.h
index 26aaa97469e8..49334d07dd55 100644
--- a/arch/arm64/include/asm/rsi_smc.h
+++ b/arch/arm64/include/asm/rsi_smc.h
@@ -125,6 +125,9 @@
 
 #ifndef __ASSEMBLY__
 
+#define RSI_HASH_SHA_256 0
+#define RSI_HASH_SHA_512 1
+
 struct realm_config {
 	union {
 		struct {
@@ -183,6 +186,47 @@ struct realm_config {
  */
 #define SMC_RSI_IPA_STATE_GET			SMC_RSI_FID(0x198)
 
+struct rsi_vdevice_info {
+	union {
+		struct {
+			u64 flags;
+			u64 cert_id;
+			union {
+				u8 hash_algo;
+				u64 padding0;
+			};
+			u64 lock_nonce;
+			u64 meas_nonce;
+			u64 report_nonce;
+			u64 tdisp_version;
+			union {
+				u8 state;
+				u64 padding1;
+			};
+
+		};
+		u8 padding2[0x40];
+	};
+	union { /* 0x40  */
+		struct {
+			u8 vca_digest[0x40];
+			u8 cert_digest[0x40];
+			u8 pubkey_digest[0x40];
+			u8 meas_digest[0x40];
+			u8 report_digest[0x40];
+		};
+		u8 padding3[0x200 - 0x40];
+	};
+};
+
+/*
+ * Get information for a device.
+ * arg1 == Realm device identifier (vdev id)
+ * arg2 == IPA to which configuration data will be written
+ * ret0 == Status / error
+ */
+#define SMC_RSI_VDEV_GET_INFO			SMC_RSI_FID(0x19D)
+
 #define RSI_DEV_MEM_COHERENT		BIT(0)
 #define RSI_DEV_MEM_LIMITED_ORDER	BIT(1)
 #define SMC_RSI_VDEV_VALIDATE_MAPPING		SMC_RSI_FID(0x19F)
diff --git a/drivers/virt/coco/arm-cca-guest/Kconfig b/drivers/virt/coco/arm-cca-guest/Kconfig
index 66b2d9202b66..7407b5a464e3 100644
--- a/drivers/virt/coco/arm-cca-guest/Kconfig
+++ b/drivers/virt/coco/arm-cca-guest/Kconfig
@@ -5,6 +5,8 @@ config ARM_CCA_GUEST
 	tristate "Arm CCA Guest driver"
 	depends on ARM64
 	depends on PCI_TSM
+	select CRYPTO_LIB_SHA256
+	select CRYPTO_LIB_SHA512
 	select TSM_REPORTS
 	select AUXILIARY_BUS
 	select TSM
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
index c70fb7dd4838..c6b92f4ae9c5 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.c
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/mem_encrypt.h>
 #include <asm/rsi_cmds.h>
+#include <crypto/hash.h>
 
 #include "rsi-da.h"
 #include "rhi-da.h"
@@ -139,10 +140,12 @@ int cca_apply_interface_report_mappings(struct pci_dev *pdev, bool validate)
 	struct resource *r;
 	unsigned int range_id;
 	phys_addr_t mmio_start_phys;
+	unsigned long mmio_flags = 0; /* non coherent, not limited order */
 	struct pci_tdisp_mmio_range *mmio_range;
 	phys_addr_t ipa_start, ipa_end, bar_offset;
 	struct pci_tdisp_device_interface_report *interface_report;
 	struct cca_guest_dsc *dsc = to_cca_guest_dsc(pdev);
+	int vdev_id = rsi_vdev_id(pdev);
 
 	interface_report = (struct pci_tdisp_device_interface_report *)dsc->interface_report;
 	mmio_range = (struct pci_tdisp_mmio_range *)(interface_report + 1);
@@ -189,10 +192,144 @@ int cca_apply_interface_report_mappings(struct pci_dev *pdev, bool validate)
 		ipa_start = r->start + bar_offset;
 		ipa_end = ipa_start + (mmio_range->num_pages << 12);
 
-		if (!validate)
+		if (validate)
+			ret = rsi_validate_dev_mapping(vdev_id, ipa_start,
+						       ipa_end, mmio_start_phys,
+						       mmio_flags,
+						       dsc->dev_info.lock_nonce,
+						       dsc->dev_info.meas_nonce,
+						       dsc->dev_info.report_nonce);
+		else
 			ret = rsi_invalidate_dev_mapping(ipa_start, ipa_end);
 		if (ret)
 			return ret;
 	}
 	return 0;
 }
+
+static int verify_digests(struct cca_guest_dsc *dsc)
+{
+	u8 digest[SHA512_DIGEST_SIZE];
+	size_t digest_size;
+	void (*digest_func)(const u8 *data, size_t len, u8 *out);
+
+	struct pci_dev *pdev = dsc->pci.base_tsm.pdev;
+	struct {
+		uint8_t *report;
+		size_t size;
+		uint8_t *digest;
+	} reports[] = {
+		{
+			dsc->interface_report,
+			dsc->interface_report_size,
+			dsc->dev_info.report_digest
+		},
+		{
+			dsc->certificate,
+			dsc->certificate_size,
+			dsc->dev_info.cert_digest
+		},
+		{
+			dsc->measurements,
+			dsc->measurements_size,
+			dsc->dev_info.meas_digest
+		}
+	};
+
+	switch (dsc->dev_info.hash_algo) {
+	case RSI_HASH_SHA_256:
+		digest_func = sha256;
+		digest_size = SHA256_DIGEST_SIZE;
+		break;
+
+	case RSI_HASH_SHA_512:
+		digest_func = sha512;
+		digest_size = SHA512_DIGEST_SIZE;
+		break;
+	default:
+		pci_err(pdev, "Unknown realm hash algorithm!\n");
+		return -EINVAL;
+	}
+
+	for (int i = 0; i < ARRAY_SIZE(reports); i++) {
+
+		digest_func(reports[i].report, reports[i].size, digest);
+		if (memcmp(reports[i].digest, digest, digest_size)) {
+			pci_err(pdev, "Invalid digest\n");
+			return -EINVAL;
+		}
+	}
+
+	pci_dbg(pdev, "Successfully verified the digests\n");
+	return 0;
+}
+
+int cca_device_verify_and_accept(struct pci_dev *pdev)
+{
+	int ret;
+	int vdev_id = rsi_vdev_id(pdev);
+	struct rsi_vdevice_info *dev_info;
+	struct cca_guest_dsc *dsc = to_cca_guest_dsc(pdev);
+
+	/* Now make a host call to copy the interface report to guest. */
+	ret = rhi_read_cached_object(vdev_id, RHI_DA_OBJECT_INTERFACE_REPORT,
+				     &dsc->interface_report, &dsc->interface_report_size);
+	if (ret) {
+		pci_err(pdev, "failed to get interface report from the host (%d)\n", ret);
+		return ret;
+	}
+
+	ret = rhi_read_cached_object(vdev_id, RHI_DA_OBJECT_CERTIFICATE,
+				     &dsc->certificate, &dsc->certificate_size);
+	if (ret) {
+		pci_err(pdev, "failed to get device certificate from the host (%d)\n", ret);
+		return ret;
+	}
+
+	ret = rhi_read_cached_object(vdev_id, RHI_DA_OBJECT_MEASUREMENT,
+				     &dsc->measurements, &dsc->measurements_size);
+	if (ret) {
+		pci_err(pdev, "failed to get device certificate from the host (%d)\n", ret);
+		return ret;
+	}
+
+	/* RMM expects sizeof(*dev_info) = 512 bytes aligned address */
+	BUILD_BUG_ON(sizeof(*dev_info) != 512);
+	dev_info = kmalloc(sizeof(*dev_info), GFP_KERNEL);
+	if (!dev_info)
+		return -ENOMEM;
+
+	if (rsi_vdev_get_info(vdev_id, virt_to_phys(dev_info))) {
+		pci_err(pdev, "failed to get device digests (%d)\n", ret);
+		kfree(dev_info);
+		return -EIO;
+	}
+
+	dsc->dev_info.cert_id       = dev_info->cert_id;
+	dsc->dev_info.hash_algo     = dev_info->hash_algo;
+	dsc->dev_info.lock_nonce    = dev_info->lock_nonce;
+	dsc->dev_info.meas_nonce    = dev_info->meas_nonce;
+	dsc->dev_info.report_nonce  = dev_info->report_nonce;
+	memcpy(dsc->dev_info.cert_digest, dev_info->cert_digest, SHA512_DIGEST_SIZE);
+	memcpy(dsc->dev_info.meas_digest, dev_info->meas_digest, SHA512_DIGEST_SIZE);
+	memcpy(dsc->dev_info.report_digest, dev_info->report_digest, SHA512_DIGEST_SIZE);
+
+	kfree(dev_info);
+	/*
+	 * Verify that the digests of the provided reports match with the
+	 * digests from RMM
+	 */
+	ret = verify_digests(dsc);
+	if (ret) {
+		pci_err(pdev, "device digest validation failed (%d)\n", ret);
+		return ret;
+	}
+
+	ret = cca_apply_interface_report_mappings(pdev, true);
+	if (ret) {
+		pci_err(pdev, "failed to validate the interface report\n");
+		return -EIO;
+	}
+
+	return 0;
+}
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
index 32cf90beb55e..73d3d095ade6 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.h
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
@@ -9,6 +9,7 @@
 #include <linux/pci.h>
 #include <linux/pci-tsm.h>
 #include <asm/rsi_smc.h>
+#include <crypto/sha2.h>
 
 #define MAX_CACHE_OBJ_SIZE	SZ_16M
 
@@ -34,6 +35,18 @@ struct pci_tdisp_mmio_range {
 #define TSM_INTF_REPORT_MMIO_RESERVED		GENMASK(15, 4)
 #define TSM_INTF_REPORT_MMIO_RANGE_ID		GENMASK(31, 16)
 
+struct dsm_device_info {
+	u64 flags;
+	u64 cert_id;
+	u64 hash_algo;
+	u64 lock_nonce;
+	u64 meas_nonce;
+	u64 report_nonce;
+	u8 cert_digest[SHA512_DIGEST_SIZE];
+	u8 meas_digest[SHA512_DIGEST_SIZE];
+	u8 report_digest[SHA512_DIGEST_SIZE];
+};
+
 struct cca_guest_dsc {
 	struct pci_tsm_devsec pci;
 	void *interface_report;
@@ -42,6 +55,7 @@ struct cca_guest_dsc {
 	int certificate_size;
 	void *measurements;
 	int measurements_size;
+	struct dsm_device_info dev_info;
 };
 
 static inline struct cca_guest_dsc *to_cca_guest_dsc(struct pci_dev *pdev)
@@ -65,4 +79,5 @@ int cca_update_device_object_cache(struct pci_dev *pdev, struct cca_guest_dsc *d
 struct page *alloc_shared_pages(int nid, gfp_t gfp_mask, unsigned long min_size);
 int free_shared_pages(struct page *page, unsigned long min_size);
 int cca_apply_interface_report_mappings(struct pci_dev *pdev, bool validate);
+int cca_device_verify_and_accept(struct pci_dev *pdev);
 #endif
-- 
2.43.0


