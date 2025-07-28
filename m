Return-Path: <linux-pci+bounces-33051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4A0B13C4B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9FF0189F15B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 13:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3699D271A6D;
	Mon, 28 Jul 2025 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rozdvDTj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061BB27146D;
	Mon, 28 Jul 2025 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710871; cv=none; b=ttGn8IbB05qM2Eyz8FD3pFIjDmG2cL5TZk6ebC2ZhNX92AFb5J1A/Dk+qMx4OpzEaN9Rmc1O/luXSdk9mwB0Lth3goC5SzNiV6YhZ0kEPldd3p03ClhkaKZOwpTVcJ05f7BCs0fB9l8QR937DTZ98SwBTnwWzVHgcWEW4B4AL0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710871; c=relaxed/simple;
	bh=NfNusfkzh50PeDCdhq+KciggPStSiL2LRdEwdbf5nLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOTLXtNHMlfbg0FsBGCTtsv9oLDEXzskl1lybdN7r3xLol+k25U0uWd5dj4VSbh2HrSrAxZmYCsH1DZ8ZXG0LOczulfk8DMFk/XvAEkYoW7RMCdT3I7BSc+Kvf2wbbAdR/ZftRH/+E/9f7HQNDL1N9k5WlTVDKQ/uOdWRuYuUoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rozdvDTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A14C113CF;
	Mon, 28 Jul 2025 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710870;
	bh=NfNusfkzh50PeDCdhq+KciggPStSiL2LRdEwdbf5nLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rozdvDTjCuZNhT5CtSaslOibx/6eZT1yC7TUZ6mP2seostI1PWLgIgn1jOOnmxrja
	 UVCOlJl18+9Um/GIvRIDCG28yxagcZDBTvF23h/uc+L4ODszt6WcZpjMHQrs3p8eqY
	 nDt07+YEhyJUhOFWTYlCINFZrfLQm7DtFFPMnhv0S6D8WY0sFrB4cHRAN1/ST6/hO9
	 Hqbdckh1gqKPdMdzWk1eQS1PFvxMKobzpAwNM0NTCN7ZmqXR2CPCRTBGWibkr9Cczh
	 la7rdT6er0acUOuSr4JvTiCg52DuCOP0wG9EA2gk8QA/AlA1dM6sMfwCg0NO6oRONY
	 22M4v6a563rIg==
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
Subject: [RFC PATCH v1 19/38] coco: host: arm64: set_pubkey support
Date: Mon, 28 Jul 2025 19:21:56 +0530
Message-ID: <20250728135216.48084-20-aneesh.kumar@kernel.org>
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

Add changes to share the device's public key with the RMM.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rmi_cmds.h       |   9 ++
 arch/arm64/include/asm/rmi_smc.h        |  18 +++
 drivers/virt/coco/arm-cca-host/Kconfig  |   4 +
 drivers/virt/coco/arm-cca-host/rmm-da.c | 150 ++++++++++++++++++++++++
 drivers/virt/coco/arm-cca-host/rmm-da.h |   1 +
 5 files changed, 182 insertions(+)

diff --git a/arch/arm64/include/asm/rmi_cmds.h b/arch/arm64/include/asm/rmi_cmds.h
index d4ea9f8363f5..aef0b0ee062e 100644
--- a/arch/arm64/include/asm/rmi_cmds.h
+++ b/arch/arm64/include/asm/rmi_cmds.h
@@ -565,4 +565,13 @@ static inline unsigned long rmi_pdev_destroy(unsigned long pdev_phys)
 	return res.a0;
 }
 
+static inline unsigned long rmi_pdev_set_pubkey(unsigned long pdev_phys, unsigned long key_phys)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RMI_PDEV_SET_PUBKEY, pdev_phys, key_phys, &res);
+
+	return res.a0;
+}
+
 #endif /* __ASM_RMI_CMDS_H */
diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
index 9f25a876238e..4a5ba98c1c0d 100644
--- a/arch/arm64/include/asm/rmi_smc.h
+++ b/arch/arm64/include/asm/rmi_smc.h
@@ -51,6 +51,7 @@
 #define SMC_RMI_PDEV_CREATE             SMC_RMI_CALL(0x0176)
 #define SMC_RMI_PDEV_DESTROY		SMC_RMI_CALL(0x0177)
 #define SMC_RMI_PDEV_GET_STATE		SMC_RMI_CALL(0x0178)
+#define SMC_RMI_PDEV_SET_PUBKEY		SMC_RMI_CALL(0x017b)
 #define SMC_RMI_PDEV_STOP		SMC_RMI_CALL(0x017c)
 
 #define RMI_ABI_MAJOR_VERSION	1
@@ -389,4 +390,21 @@ struct rmi_dev_comm_data {
 	};
 };
 
+#define RMI_SIG_RSASSA_3072	0
+#define RMI_SIG_ECDSA_P256	1
+#define RMI_SIG_ECDSA_P384	2
+
+struct rmi_public_key_params {
+	union {
+		struct {
+			u8 public_key[1024];
+			u8 metadata[1024];
+			u64 public_key_len;
+			u64 metadata_len;
+			u8 rmi_signature_algorithm;
+		} __packed;
+		u8 padding[0x1000];
+	};
+};
+
 #endif /* __ASM_RMI_SMC_H */
diff --git a/drivers/virt/coco/arm-cca-host/Kconfig b/drivers/virt/coco/arm-cca-host/Kconfig
index 0f19fbf47613..a5b777f0d50e 100644
--- a/drivers/virt/coco/arm-cca-host/Kconfig
+++ b/drivers/virt/coco/arm-cca-host/Kconfig
@@ -6,7 +6,11 @@ config ARM_CCA_HOST
 	tristate "Arm CCA Host driver"
 	depends on ARM64
 	depends on PCI_TSM
+	select KEYS
+	select X509_CERTIFICATE_PARSER
 	select TSM
+	select CRYPTO_ECDSA
+	select CRYPTO_RSA
 
 	help
 	  The driver provides TSM backend for ARM CCA
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.c b/drivers/virt/coco/arm-cca-host/rmm-da.c
index ec8c5bfcee35..3715e6d58c83 100644
--- a/drivers/virt/coco/arm-cca-host/rmm-da.c
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.c
@@ -6,6 +6,9 @@
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
 #include <asm/rmi_cmds.h>
+#include <crypto/internal/rsa.h>
+#include <keys/asymmetric-type.h>
+#include <keys/x509-parser.h>
 
 #include "rmm-da.h"
 
@@ -311,6 +314,136 @@ static int do_pdev_communicate(struct pci_tsm *tsm, int target_state)
 	return do_dev_communicate(PDEV_COMMUNICATE, tsm, target_state);
 }
 
+static int parse_certificate_chain(struct pci_tsm *tsm)
+{
+	struct cca_host_dsc_pf0 *dsc_pf0;
+	unsigned int chain_size;
+	unsigned int offset = 0;
+	u8 *chain_data;
+	int ret = 0;
+
+	dsc_pf0 = to_cca_dsc_pf0(tsm->pdev);
+	chain_size = dsc_pf0->cert_chain.cache.size;
+	chain_data = dsc_pf0->cert_chain.cache.buf;
+
+	while (offset < chain_size) {
+		unsigned int cert_len =
+			x509_get_certificate_length(chain_data + offset,
+						    chain_size - offset);
+		struct x509_certificate *cert =
+			x509_cert_parse(chain_data + offset, cert_len);
+
+		if (IS_ERR(cert)) {
+			pr_warn("%s(): parsing of certificate chain not successful\n", __func__);
+			ret = PTR_ERR(cert);
+			break;
+		}
+
+		if (offset + cert_len == chain_size) {
+			dsc_pf0->cert_chain.public_key = kzalloc(cert->pub->keylen, GFP_KERNEL);
+			if (!dsc_pf0->cert_chain.public_key) {
+				ret = -ENOMEM;
+				x509_free_certificate(cert);
+				break;
+			}
+
+			if (!strcmp("ecdsa-nist-p256", cert->pub->pkey_algo)) {
+				dsc_pf0->rmi_signature_algorithm = RMI_SIG_ECDSA_P256;
+			} else if (!strcmp("ecdsa-nist-p384", cert->pub->pkey_algo)) {
+				dsc_pf0->rmi_signature_algorithm = RMI_SIG_ECDSA_P384;
+			} else if (!strcmp("rsa", cert->pub->pkey_algo)) {
+				dsc_pf0->rmi_signature_algorithm = RMI_SIG_RSASSA_3072;
+			} else {
+				ret = -ENXIO;
+				x509_free_certificate(cert);
+				break;
+			}
+			memcpy(dsc_pf0->cert_chain.public_key, cert->pub->key, cert->pub->keylen);
+			dsc_pf0->cert_chain.public_key_size = cert->pub->keylen;
+		}
+
+		x509_free_certificate(cert);
+
+		offset += cert_len;
+	}
+
+	if (ret == 0)
+		dsc_pf0->cert_chain.valid = true;
+
+	return ret;
+}
+
+static int pdev_set_public_key(struct pci_tsm *tsm)
+{
+	struct rmi_public_key_params *key_shared;
+	unsigned long expected_key_len = 0;
+	struct cca_host_dsc_pf0 *dsc_pf0;
+	int ret;
+
+	dsc_pf0 = to_cca_dsc_pf0(tsm->pdev);
+	/* Check that all the necessary information was captured from communication */
+	if (!dsc_pf0->cert_chain.valid)
+		return -EINVAL;
+
+	key_shared = (struct rmi_public_key_params *)get_zeroed_page(GFP_KERNEL);
+	if (!key_shared)
+		return -ENOMEM;
+
+	key_shared->rmi_signature_algorithm = dsc_pf0->rmi_signature_algorithm;
+
+	switch (key_shared->rmi_signature_algorithm) {
+	case RMI_SIG_ECDSA_P384:
+		expected_key_len = 97;
+
+		if (dsc_pf0->cert_chain.public_key_size != expected_key_len)
+			return -EINVAL;
+		key_shared->public_key_len = dsc_pf0->cert_chain.public_key_size;
+		memcpy(key_shared->public_key,
+		       dsc_pf0->cert_chain.public_key,
+		       dsc_pf0->cert_chain.public_key_size);
+		key_shared->metadata_len = 0;
+		break;
+	case RMI_SIG_ECDSA_P256:
+		expected_key_len = 65;
+
+		if (dsc_pf0->cert_chain.public_key_size != expected_key_len)
+			return -EINVAL;
+		key_shared->public_key_len = dsc_pf0->cert_chain.public_key_size;
+		memcpy(key_shared->public_key,
+		       dsc_pf0->cert_chain.public_key,
+		       dsc_pf0->cert_chain.public_key_size);
+		key_shared->metadata_len = 0;
+		break;
+	case RMI_SIG_RSASSA_3072:
+		expected_key_len = 385;
+		struct rsa_key rsa_key = {0};
+		int ret_rsa_parse = rsa_parse_pub_key(&rsa_key,
+						      dsc_pf0->cert_chain.public_key,
+						      dsc_pf0->cert_chain.public_key_size);
+		/* This also checks the key_len */
+		if (ret_rsa_parse)
+			return ret_rsa_parse;
+		/*
+		 * exponent is usally 65537 (size = 24bits) but in rare cases
+		 * it size can be as large as the modulus
+		 */
+		if (rsa_key.e_sz > expected_key_len)
+			return -EINVAL;
+		key_shared->public_key_len = rsa_key.n_sz;
+		key_shared->metadata_len = rsa_key.e_sz;
+		memcpy(key_shared->public_key, (unsigned char *)rsa_key.n, rsa_key.n_sz);
+		memcpy(key_shared->metadata, (unsigned char *)rsa_key.e, rsa_key.e_sz);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = rmi_pdev_set_pubkey(virt_to_phys(dsc_pf0->rmm_pdev),
+				  virt_to_phys(key_shared));
+	free_page((unsigned long)key_shared);
+	return ret;
+}
+
 struct dev_comm_work {
 	struct pci_tsm *tsm;
 	struct work_struct work;
@@ -319,6 +452,7 @@ struct dev_comm_work {
 
 static void pdev_ide_setup_work(struct work_struct *work)
 {
+	int ret;
 	unsigned long state;
 	struct pci_tsm *tsm;
 	struct dev_comm_work *setup_work;
@@ -329,6 +463,22 @@ static void pdev_ide_setup_work(struct work_struct *work)
 	state = do_pdev_communicate(tsm, RMI_PDEV_NEEDS_KEY);
 	WARN_ON(state != RMI_PDEV_NEEDS_KEY);
 
+	/*
+	 * we now have certificate chain in dsm->cert_chain. Parse
+	 * that and set the pubkey.
+	 */
+	ret = parse_certificate_chain(tsm);
+	if (ret)
+		goto err_out;
+
+	ret = pdev_set_public_key(tsm);
+	if (ret)
+		goto err_out;
+
+	state = do_pdev_communicate(tsm, RMI_PDEV_READY);
+	WARN_ON(state != RMI_PDEV_READY);
+
+err_out:
 	complete(&setup_work->complete);
 }
 
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.h b/drivers/virt/coco/arm-cca-host/rmm-da.h
index c401be55d770..03c3149b8a98 100644
--- a/drivers/virt/coco/arm-cca-host/rmm-da.h
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.h
@@ -33,6 +33,7 @@ struct cca_host_dsc_pf0 {
 	int num_aux;
 	void *aux[MAX_PDEV_AUX_GRANULES];
 
+	uint8_t rmi_signature_algorithm;
 	struct {
 		struct cache_object cache;
 
-- 
2.43.0


