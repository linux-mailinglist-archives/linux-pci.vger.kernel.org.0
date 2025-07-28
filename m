Return-Path: <linux-pci+bounces-33070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DD6B13C81
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A15A3BE603
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 14:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FBA285CAD;
	Mon, 28 Jul 2025 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwDn3PJK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB79627465B;
	Mon, 28 Jul 2025 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710983; cv=none; b=aLxD9HTupQKYTO7uPajqVhtsONEX22yow1is/dnIqFQ5V9FTHP+Zu3dSu7EvljGlTG/Cei1WAP0otO1l3lmdiKxs5SkqKGNn3pI3gtu58hB1RptMJX0dw4Xm5XWlc/N6BomL8JI2odpEZAncBWPZ0nPV9Xy1TuKsVr80N3eRR3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710983; c=relaxed/simple;
	bh=zn8+WC3ldTbm6RNjuQz9vx5QH2UWKPQEGiie3mc/TX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAwCUOnW4/9/pPMLYAwkbil8VV6arSqswqmq6Z36SNOpd0vwTcd/BWDFeh6H1wtWEkB2XAl9+lRE7nuQGnttt4AATuO6bQZ8qRe4WPnkKkCjvI0LUJ592a9tx9MyXiIcd/gxCoULDPxNIuyQji967KC71hN8pxSPw6Ptsvm77dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwDn3PJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363ECC4CEE7;
	Mon, 28 Jul 2025 13:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710983;
	bh=zn8+WC3ldTbm6RNjuQz9vx5QH2UWKPQEGiie3mc/TX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwDn3PJKkGU3RyLVl3OxHfdMUwn2VTXCyKVJnN/2hUdDC+s0UE7n84uOsgnCL8we7
	 kVlyHvgckHYXkaTMT1bY5Jwx7yWqHNc/h6/g0RjNDl8mYOdYTTY6U7jQDkQPG2gpzE
	 Rx076j8OEGtXyTyMq57DxranmZK0MvhRtZSdzo66K5s2r3e2/PHQ6KKvSZkZqYQLBr
	 exsNZsiuLFig4kCbDo0KZf6nApqMGZ+NO+AEVLhV++10wGSMwp9+rz38dN2qM2vN0C
	 +tzTcNyKO0XbctfM0ibZN7vGCvo254LJbJCsm08jMv2l5fJUl88PGu/WDqCDhGd2nD
	 H4rOXAel8FThA==
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
Subject: [RFC PATCH v1 38/38] coco: guest: arm64: Add support for fetching device info
Date: Mon, 28 Jul 2025 19:22:15 +0530
Message-ID: <20250728135216.48084-39-aneesh.kumar@kernel.org>
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

RSI_RDEV_GET_INFO returns different digest hash values, which can be
compared with host cached values to ensure the host didn't tamper with
the cached data.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rsi_cmds.h        |  12 +++
 arch/arm64/include/asm/rsi_smc.h         |  24 +++++
 drivers/virt/coco/arm-cca-guest/Kconfig  |   2 +
 drivers/virt/coco/arm-cca-guest/rsi-da.c | 128 +++++++++++++++++++++++
 drivers/virt/coco/arm-cca-guest/rsi-da.h |  13 +++
 5 files changed, 179 insertions(+)

diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
index 42b998f44a0e..6b90a6cdd7fb 100644
--- a/arch/arm64/include/asm/rsi_cmds.h
+++ b/arch/arm64/include/asm/rsi_cmds.h
@@ -276,4 +276,16 @@ static inline unsigned long __rsi_rdev_get_measurements(unsigned long vdev_id,
 	return res.a0;
 }
 
+static inline unsigned long rsi_rdev_get_info(unsigned long vdev_id,
+					      unsigned long inst_id,
+					      unsigned long digest_phys)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RSI_RDEV_GET_INFO,
+			     vdev_id, inst_id, digest_phys, &res);
+
+	return res.a0;
+}
+
 #endif /* __ASM_RSI_CMDS_H */
diff --git a/arch/arm64/include/asm/rsi_smc.h b/arch/arm64/include/asm/rsi_smc.h
index f051db54cdc3..e2b51cf58bd4 100644
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
@@ -200,6 +203,27 @@ struct rsi_host_call {
 #define SMC_RSI_RDEV_GET_INSTANCE_ID		SMC_RSI_FID(0x19c)
 #define SMC_RSI_RDEV_CONTINUE			SMC_RSI_FID(0x1a4)
 
+struct rsi_device_info {
+	union {
+		struct {
+			u64 flags;
+			u64 attest_type;
+			u64 cert_id;
+			u8 hash_algo;
+		};
+		u8 padding[0x40];
+	};
+	union { /* 0x40  */
+		struct {
+			u8 cert_digest[0x40];
+			u8 meas_digest[0x40];
+			u8 report_digest[0x40];
+		};
+		u8 padding2[0x200 - 0x40];
+	};
+};
+
+#define SMC_RSI_RDEV_GET_INFO			SMC_RSI_FID(0x1a5)
 #define SMC_RSI_RDEV_GET_INTERFACE_REPORT	SMC_RSI_FID(0x1a6)
 
 #define RSI_DEV_MEASURE_ALL		BIT(0)
diff --git a/drivers/virt/coco/arm-cca-guest/Kconfig b/drivers/virt/coco/arm-cca-guest/Kconfig
index 410d9c3fb2b3..6fc86c1f3900 100644
--- a/drivers/virt/coco/arm-cca-guest/Kconfig
+++ b/drivers/virt/coco/arm-cca-guest/Kconfig
@@ -5,6 +5,8 @@ config ARM_CCA_GUEST
 	tristate "Arm CCA Guest driver"
 	depends on ARM64
 	depends on PCI_TSM
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
 	select TSM_REPORTS
 	select TSM
 	help
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
index 6222b10964ee..a1bb225adb4c 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.c
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/mem_encrypt.h>
 #include <asm/rsi_cmds.h>
+#include <crypto/hash.h>
 
 #include "rsi-da.h"
 
@@ -186,11 +187,102 @@ rsi_rdev_get_measurements(struct pci_dev *pdev, unsigned long vdev_id,
 	return RSI_SUCCESS;
 }
 
+static int verify_digests(struct cca_guest_dsc *dsm)
+{
+	int i;
+	int ret;
+	u8 digest[SHA512_DIGEST_SIZE];
+	int sdesc_size;
+	size_t digest_size;
+	char *hash_alg_name;
+	struct shash_desc *shash;
+	struct crypto_shash *alg;
+	struct pci_dev *pdev = dsm->pci.tsm.pdev;
+	struct {
+		uint8_t *report;
+		size_t size;
+		uint8_t *digest;
+	} reports[] = {
+		{
+			dsm->interface_report,
+			dsm->interface_report_size,
+			dsm->dev_info.report_digest
+		},
+		{
+			dsm->certificate,
+			dsm->certificate_size,
+			dsm->dev_info.cert_digest
+		},
+		{
+			dsm->measurements,
+			dsm->measurements_size,
+			dsm->dev_info.meas_digest
+		}
+	};
+
+
+	if (dsm->dev_info.hash_algo == RSI_HASH_SHA_256) {
+		hash_alg_name = "sha256";
+		digest_size = SHA256_DIGEST_SIZE;
+	} else if (dsm->dev_info.hash_algo == RSI_HASH_SHA_512) {
+		hash_alg_name = "sha512";
+		digest_size = SHA512_DIGEST_SIZE;
+	} else {
+		pci_err(pdev, "unknown realm hash algorithm!\n");
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	alg = crypto_alloc_shash(hash_alg_name, 0, 0);
+	if (IS_ERR(alg)) {
+		pci_err(pdev, "cannot allocate %s\n", hash_alg_name);
+		return PTR_ERR(alg);
+	}
+
+	sdesc_size = sizeof(struct shash_desc) + crypto_shash_descsize(alg);
+	shash = kzalloc(sdesc_size, GFP_KERNEL);
+	if (!shash) {
+		pci_err(pdev, "cannot allocate sdesc\n");
+		ret = -ENOMEM;
+		goto err_free_shash;
+	}
+	shash->tfm = alg;
+
+	for (i = 0; i < ARRAY_SIZE(reports); i++) {
+		ret = crypto_shash_digest(shash, reports[i].report,
+					  reports[i].size, digest);
+		if (ret) {
+			pci_err(pdev, "failed to compute digest, %d\n", ret);
+			goto err_free_sdesc;
+		}
+
+		if (memcmp(reports[i].digest, digest, digest_size)) {
+			pci_err(pdev, "invalid digest\n");
+			ret = -EINVAL;
+			goto err_free_sdesc;
+		}
+	}
+
+	kfree(shash);
+	crypto_free_shash(alg);
+
+	pci_info(pdev, "Successfully verified the digests\n");
+	return 0;
+
+err_free_sdesc:
+	kfree(shash);
+err_free_shash:
+	crypto_free_shash(alg);
+err_out:
+	return ret;
+}
+
 int rsi_device_lock(struct pci_dev *pdev)
 {
 	unsigned long ret;
 	unsigned long tdisp_version;
 	struct rsi_device_measurements_params *rsi_dev_meas;
+	struct rsi_device_info *dev_info;
 	struct cca_guest_dsc *dsm = to_cca_guest_dsc(pdev);
 	int vdev_id = (pci_domain_nr(pdev->bus) << 16) |
 		PCI_DEVID(pdev->bus->number, pdev->devfn);
@@ -252,8 +344,44 @@ int rsi_device_lock(struct pci_dev *pdev)
 		return -EIO;
 	}
 
+	/* RMM expects sizeof(dev_info) (512 bytes) aligned address */
+	dev_info = kmalloc(sizeof(*dev_info), GFP_KERNEL);
+	if (!dev_info) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	ret = rsi_rdev_get_info(vdev_id, dsm->instance_id, virt_to_phys(dev_info));
+	if (ret != RSI_SUCCESS) {
+		pci_err(pdev, "failed to get device digests (%lu)\n", ret);
+		ret = -EIO;
+		kfree(dev_info);
+		goto err_out;
+	}
+
+	dsm->dev_info.attest_type   = dev_info->attest_type;
+	dsm->dev_info.cert_id       = dev_info->cert_id;
+	dsm->dev_info.hash_algo     = dev_info->hash_algo;
+	memcpy(dsm->dev_info.cert_digest, dev_info->cert_digest, SHA512_DIGEST_SIZE);
+	memcpy(dsm->dev_info.meas_digest, dev_info->meas_digest, SHA512_DIGEST_SIZE);
+	memcpy(dsm->dev_info.report_digest, dev_info->report_digest, SHA512_DIGEST_SIZE);
+
+	kfree(dev_info);
+	/*
+	 * Verify that the digests of the provided reports match with the
+	 * digests from RMM
+	 */
+	ret = verify_digests(dsm);
+	if (ret) {
+		pci_err(pdev, "device digest validation failed (%ld)\n", ret);
+		return ret;
+	}
+
+	return 0;
+err_out:
 	return ret;
 }
+
 static inline unsigned long rsi_rdev_start(struct pci_dev *pdev,
 					   unsigned long vdev_id, unsigned long inst_id)
 {
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
index f26156d9be81..e8953b8e85a3 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.h
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
@@ -10,6 +10,7 @@
 #include <linux/pci-tsm.h>
 #include <asm/rsi_smc.h>
 #include <asm/rhi.h>
+#include <crypto/sha2.h>
 
 struct pci_tdisp_device_interface_report {
 	u16 interface_info;
@@ -33,6 +34,17 @@ struct pci_tdisp_mmio_range {
 #define TSM_INTF_REPORT_MMIO_RESERVED		GENMASK(15, 4)
 #define TSM_INTF_REPORT_MMIO_RANGE_ID		GENMASK(31, 16)
 
+struct dsm_device_info {
+	u64 flags;
+	u64 attest_type;
+	u64 cert_id;
+	u64 hash_algo;
+	u8 cert_digest[SHA512_DIGEST_SIZE];
+	u8 meas_digest[SHA512_DIGEST_SIZE];
+	u8 report_digest[SHA512_DIGEST_SIZE];
+};
+
+
 struct cca_guest_dsc {
 	struct pci_tsm_pf0 pci;
 	unsigned long instance_id;
@@ -42,6 +54,7 @@ struct cca_guest_dsc {
 	int certificate_size;
 	void *measurements;
 	int measurements_size;
+	struct dsm_device_info dev_info;
 };
 
 static inline struct cca_guest_dsc *to_cca_guest_dsc(struct pci_dev *pdev)
-- 
2.43.0


