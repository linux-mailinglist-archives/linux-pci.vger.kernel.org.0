Return-Path: <linux-pci+bounces-39382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C027C0CC36
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED203A70AE
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287B12FBE03;
	Mon, 27 Oct 2025 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eiayt2bE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED712FBE01;
	Mon, 27 Oct 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558669; cv=none; b=DS6kz1axdfdd3nc6iOz1R50fxeV24JOPUNBHWod94uiO3Wouu96NJPnhgYIWpB4Owj8JNlZyWAfvAGld2vxsEj5hDMCoi0fCvjkeADJggal4pGkiiLMBR2NzmwalJ1WFxR7aw491ie0nvHYCb4CW88VV/S8UY5HiiRj1DukqI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558669; c=relaxed/simple;
	bh=Af4vjbB3fxE+UHzJd2A7AwcGlqakMGAYFn/zD5eKCZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcfp1B/J1tqnK3huvo1kF6w4Wrs19EEX2AO+LuusxQx/3WDrgfSeQPQEWHHdFlnCxYWKvKZ+6EJxgAyL4k8yeqWsrUKpqRDMkzY5sFg3ws1GDDYZDX0mf5KaWXLJeAMpzf9TJuQxA84TR1pP+97hf+SZmRQoc0oIhrX5Clmo840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eiayt2bE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4DFC19421;
	Mon, 27 Oct 2025 09:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761558668;
	bh=Af4vjbB3fxE+UHzJd2A7AwcGlqakMGAYFn/zD5eKCZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eiayt2bE9qQvGNsisE+w8aYJCdIU39z40VsuTS3f22ZU16cDEfhyM6VD423iXjGO7
	 4H4W1el4qZ47R5dmwViWXErODs66+H4s0l2H4y7hI/na0+Y4qTjHJJMEdOgjVF3owC
	 fAw+Tjt4JIkDpL4OLcKrDxRDNZg7I5AGyCuOP+1XkYIhJcX4wW7ewA4I+FYusGMlgv
	 SkpM5mSPoqjjKnWGNyeTpzmn9S+UkWLLd6PmuPq/MRXRXYULeNWmyM051aPMo8LUsr
	 QV236VSfY7bgTYy6SG7MmuG1PQa3ECrhR9o/BTnfAtihMV6erRhRD7ATCrVB21jtAK
	 V1oMVmftTMY2A==
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
Subject: [PATCH 12/12] coco: host: arm64: Register device public key with RMM
Date: Mon, 27 Oct 2025 15:19:03 +0530
Message-ID: <20251027094916.1153143-12-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027094916.1153143-1-aneesh.kumar@kernel.org>
References: <20251027094916.1153143-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

- Introduce the SMC_RMI_PDEV_SET_PUBKEY helper and the associated struct
rmi_public_key_params so the host can hand the device’s public key to
the RMM.

- Parse the certificate chain cached during IDE setup, extract the final
certificate’s public key, and recognise RSA-3072, ECDSA-P256, and
ECDSA-P384 keys before calling into the RMM.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rmi_cmds.h       |   9 ++
 arch/arm64/include/asm/rmi_smc.h        |  18 +++
 drivers/virt/coco/arm-cca-host/Kconfig  |   4 +
 drivers/virt/coco/arm-cca-host/rmi-da.c | 166 +++++++++++++++++++++++-
 drivers/virt/coco/arm-cca-host/rmi-da.h |   1 +
 5 files changed, 197 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/rmi_cmds.h b/arch/arm64/include/asm/rmi_cmds.h
index f10a0dcaa308..339bea517760 100644
--- a/arch/arm64/include/asm/rmi_cmds.h
+++ b/arch/arm64/include/asm/rmi_cmds.h
@@ -574,4 +574,13 @@ static inline unsigned long rmi_pdev_destroy(unsigned long pdev_phys)
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
index 6eb6f7e4b77f..1f46e13b92a4 100644
--- a/arch/arm64/include/asm/rmi_smc.h
+++ b/arch/arm64/include/asm/rmi_smc.h
@@ -52,6 +52,7 @@
 #define SMC_RMI_PDEV_CREATE             SMC_RMI_CALL(0x0176)
 #define SMC_RMI_PDEV_DESTROY		SMC_RMI_CALL(0x0177)
 #define SMC_RMI_PDEV_GET_STATE		SMC_RMI_CALL(0x0178)
+#define SMC_RMI_PDEV_SET_PUBKEY		SMC_RMI_CALL(0x017b)
 #define SMC_RMI_PDEV_STOP		SMC_RMI_CALL(0x017c)
 
 #define RMI_ABI_MAJOR_VERSION	1
@@ -426,4 +427,21 @@ struct rmi_dev_comm_data {
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
index 1febd316fb77..efa66e960ad5 100644
--- a/drivers/virt/coco/arm-cca-host/Kconfig
+++ b/drivers/virt/coco/arm-cca-host/Kconfig
@@ -7,8 +7,12 @@ config ARM_CCA_HOST
 	depends on ARM64
 	depends on PCI_TSM
 	depends on KVM
+	select KEYS
+	select X509_CERTIFICATE_PARSER
 	select TSM
 	select AUXILIARY_BUS
+	select CRYPTO_ECDSA
+	select CRYPTO_RSA
 
 	help
 	  ARM CCA RMM firmware is the trusted runtime that enforces memory
diff --git a/drivers/virt/coco/arm-cca-host/rmi-da.c b/drivers/virt/coco/arm-cca-host/rmi-da.c
index 644609618a7a..c9780ca64c17 100644
--- a/drivers/virt/coco/arm-cca-host/rmi-da.c
+++ b/drivers/virt/coco/arm-cca-host/rmi-da.c
@@ -8,6 +8,9 @@
 #include <linux/pci-doe.h>
 #include <linux/delay.h>
 #include <asm/rmi_cmds.h>
+#include <crypto/internal/rsa.h>
+#include <keys/asymmetric-type.h>
+#include <keys/x509-parser.h>
 
 #include "rmi-da.h"
 
@@ -361,6 +364,146 @@ static int do_pdev_communicate(struct pci_tsm *tsm, enum rmi_pdev_state target_s
 	return do_dev_communicate(PDEV_COMMUNICATE, tsm, target_state, RMI_PDEV_ERROR);
 }
 
+static int parse_certificate_chain(struct pci_tsm *tsm)
+{
+	struct cca_host_pf0_dsc *pf0_dsc;
+	unsigned int chain_size;
+	unsigned int offset = 0;
+	u8 *chain_data;
+
+	pf0_dsc = to_cca_pf0_dsc(tsm->pdev);
+
+	/* If device communication didn't results in certificate caching. */
+	if (!pf0_dsc->cert_chain.cache || !pf0_dsc->cert_chain.cache->offset)
+		return -EINVAL;
+
+	chain_size = pf0_dsc->cert_chain.cache->offset;
+	chain_data = pf0_dsc->cert_chain.cache->buf;
+
+	while (offset < chain_size) {
+		ssize_t cert_len =
+			x509_get_certificate_length(chain_data + offset,
+						    chain_size - offset);
+		if (cert_len < 0)
+			return cert_len;
+
+		struct x509_certificate *cert __free(x509_free_certificate) =
+			x509_cert_parse(chain_data + offset, cert_len);
+
+		if (IS_ERR(cert)) {
+			pci_warn(tsm->pdev, "parsing of certificate chain not successful\n");
+			return PTR_ERR(cert);
+		}
+
+		/* The key in the last cert in the chain is used */
+		if (offset + cert_len == chain_size) {
+			pf0_dsc->cert_chain.public_key = kzalloc(cert->pub->keylen, GFP_KERNEL);
+			if (!pf0_dsc->cert_chain.public_key)
+				return -ENOMEM;
+
+			if (!strcmp("ecdsa-nist-p256", cert->pub->pkey_algo)) {
+				pf0_dsc->rmi_signature_algorithm = RMI_SIG_ECDSA_P256;
+			} else if (!strcmp("ecdsa-nist-p384", cert->pub->pkey_algo)) {
+				pf0_dsc->rmi_signature_algorithm = RMI_SIG_ECDSA_P384;
+			} else if (!strcmp("rsa", cert->pub->pkey_algo)) {
+				pf0_dsc->rmi_signature_algorithm = RMI_SIG_RSASSA_3072;
+			} else {
+				kfree(pf0_dsc->cert_chain.public_key);
+				pf0_dsc->cert_chain.public_key = NULL;
+				return -ENXIO;
+			}
+			memcpy(pf0_dsc->cert_chain.public_key, cert->pub->key, cert->pub->keylen);
+			pf0_dsc->cert_chain.public_key_size = cert->pub->keylen;
+		}
+
+		offset += cert_len;
+	}
+
+	pf0_dsc->cert_chain.valid = true;
+	return 0;
+}
+
+DEFINE_FREE(free_page, unsigned long, if (_T) free_page(_T))
+static int pdev_set_public_key(struct pci_tsm *tsm)
+{
+	unsigned long expected_key_len;
+	struct cca_host_pf0_dsc *pf0_dsc;
+	int ret;
+
+	pf0_dsc = to_cca_pf0_dsc(tsm->pdev);
+	/* Check that all the necessary information was captured from communication */
+	if (!pf0_dsc->cert_chain.valid)
+		return -EINVAL;
+
+	struct rmi_public_key_params *key_params __free(free_page) =
+		(struct rmi_public_key_params *)get_zeroed_page(GFP_KERNEL);
+	if (!key_params)
+		return -ENOMEM;
+
+	key_params->rmi_signature_algorithm = pf0_dsc->rmi_signature_algorithm;
+
+	switch (key_params->rmi_signature_algorithm) {
+	case RMI_SIG_ECDSA_P384:
+	{
+		expected_key_len = 97;
+
+		if (pf0_dsc->cert_chain.public_key_size != expected_key_len)
+			return -EINVAL;
+
+		key_params->public_key_len = pf0_dsc->cert_chain.public_key_size;
+		memcpy(key_params->public_key,
+		       pf0_dsc->cert_chain.public_key,
+		       pf0_dsc->cert_chain.public_key_size);
+		key_params->metadata_len = 0;
+		break;
+	}
+	case RMI_SIG_ECDSA_P256:
+	{
+		expected_key_len = 65;
+
+		if (pf0_dsc->cert_chain.public_key_size != expected_key_len)
+			return -EINVAL;
+
+		key_params->public_key_len = pf0_dsc->cert_chain.public_key_size;
+		memcpy(key_params->public_key,
+		       pf0_dsc->cert_chain.public_key,
+		       pf0_dsc->cert_chain.public_key_size);
+		key_params->metadata_len = 0;
+		break;
+	}
+	case RMI_SIG_RSASSA_3072:
+	{
+		struct rsa_key rsa_key = {0};
+
+		expected_key_len = 385;
+		int ret_rsa_parse = rsa_parse_pub_key(&rsa_key,
+						      pf0_dsc->cert_chain.public_key,
+						      pf0_dsc->cert_chain.public_key_size);
+		/* This also checks the key_len */
+		if (ret_rsa_parse)
+			return ret_rsa_parse;
+		/*
+		 * exponent is usually 65537 (size = 24bits) but in rare cases
+		 * the size can be as large as the modulus
+		 */
+		if (rsa_key.e_sz > expected_key_len)
+			return -EINVAL;
+
+		key_params->public_key_len = rsa_key.n_sz;
+		key_params->metadata_len = rsa_key.e_sz;
+		memcpy(key_params->public_key, rsa_key.n, rsa_key.n_sz);
+		memcpy(key_params->metadata, rsa_key.e, rsa_key.e_sz);
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	ret = rmi_pdev_set_pubkey(virt_to_phys(pf0_dsc->rmm_pdev),
+				  virt_to_phys(key_params));
+	return ret;
+}
+
 void pdev_communicate_work(struct work_struct *work)
 {
 	unsigned long state;
@@ -410,7 +553,28 @@ static int submit_pdev_comm_work(struct pci_dev *pdev, int target_state)
 
 int pdev_ide_setup(struct pci_dev *pdev)
 {
-	return submit_pdev_comm_work(pdev, RMI_PDEV_NEEDS_KEY);
+	int ret;
+
+	ret = submit_pdev_comm_work(pdev, RMI_PDEV_NEEDS_KEY);
+	if (ret)
+		return ret;
+	/*
+	 * we now have certificate chain in dsm->cert_chain. Parse
+	 * that and set the pubkey.
+	 */
+	ret = parse_certificate_chain(pdev->tsm);
+	if (ret)
+		return ret;
+
+	ret = pdev_set_public_key(pdev->tsm);
+	if (ret)
+		return ret;
+
+	ret = submit_pdev_comm_work(pdev, RMI_PDEV_READY);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 void pdev_stop_and_destroy(struct pci_dev *pdev)
diff --git a/drivers/virt/coco/arm-cca-host/rmi-da.h b/drivers/virt/coco/arm-cca-host/rmi-da.h
index e556ccecc1cb..f1a840b6d4fb 100644
--- a/drivers/virt/coco/arm-cca-host/rmi-da.h
+++ b/drivers/virt/coco/arm-cca-host/rmi-da.h
@@ -51,6 +51,7 @@ struct cca_host_pf0_dsc {
 	int num_aux;
 	void *aux[MAX_PDEV_AUX_GRANULES];
 
+	uint8_t rmi_signature_algorithm;
 	struct mutex object_lock;
 	struct {
 		struct cache_object *cache;
-- 
2.43.0


