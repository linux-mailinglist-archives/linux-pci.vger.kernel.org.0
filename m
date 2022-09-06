Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CC65AE656
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 13:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiIFLRA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 07:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiIFLQ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 07:16:59 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8927E70E5B;
        Tue,  6 Sep 2022 04:16:56 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMN5x2BCQz689DH;
        Tue,  6 Sep 2022 19:12:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 13:16:54 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 12:16:53 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Lukas Wunner <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Dan Williams <dan.j.williams@intel.com>,
        "Adam Manzanares" <a.manzanares@samsung.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben W <ben@bwidawsk.net>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        David E Box <david.e.box@intel.com>,
        Chuck Lever <chuck.lever@oracle.com>, <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Eric Biggers <ebiggers@google.com>
Subject: [RFC PATCH v3 2/4] spdm: Introduce a library for DMTF SPDM
Date:   Tue, 6 Sep 2022 12:15:54 +0100
Message-ID: <20220906111556.1544-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220906111556.1544-1-Jonathan.Cameron@huawei.com>
References: <20220906111556.1544-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Security Protocol and Data Model (SPDM) defines messages,
data objects and sequences for performing message exchanges between
devices over various transports and physical media.

Currently SPDM 1.1 and SPDM 1.2 are supported.  A given device
driver calling into this library may select the minimum version used.
A newer version may be used if both kernel and device have sufficient
support.

As the kernel supports several possible transports (mctp, PCI DOE)
introduce a library than can in turn be used with all those transports.

There are a large number of open questions around how we do this that
need to be resolved. These include:
*  Key chain management
   - Current approach is to use a keychain provide as part of per transport
     initialization for the root certificates which are assumed to be
     loaded into that keychain, perhaps in an initrd script.
   - Each SPDM instance then has its own keychain to manage its
     certificates. It may make sense to drop this, but that looks like it
     will make a lot of the standard infrastructure harder to use.
 *  ECC algorithms needing ASN1 encoded signatures. I'm struggling to find
    any specification that actual 'requires' that choice vs raw data, so my
    guess is that this is a question of existing use cases (x509 certs seem
    to use this form, but CHALLENGE_AUTH SPDM uses raw data).
    I'm not sure whether we are better off just encoding the signature in
    ASN1 as currently done in this series, or if it is worth a tweaking
    things in the crypto layers to add raw support alongside X9.62/asn.1
 *  Lots of options in actual implementation to look at.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

--
Since v2:
Support SPDM 1.2 based on 1.2.1 specification.
 - A few new fields resulting in 1 expanded data structure, plus the
   prefix and rehashing step needed to build the material against
   which a signature is verified.
 - Allow specification of minimum acceptable version.  Max mutually
   available version of SPDM will be used.  Tested by changing max
   supported in spdm-emu

Fix wrong encoding for ecdsa signatures. They were always x9.62 not raw.
Now picked up by better checks in the kernel.
Various minor fixes for wrong length endian calls etc.
---
 include/linux/spdm.h |   81 +++
 lib/Kconfig          |    3 +
 lib/Makefile         |    2 +
 lib/spdm.c           | 1333 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1419 insertions(+)

diff --git a/include/linux/spdm.h b/include/linux/spdm.h
new file mode 100644
index 000000000000..449c3de92d54
--- /dev/null
+++ b/include/linux/spdm.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DMTF Security Protocol and Data Model
+ * https://www.dmtf.org/dsp/DSP0274
+ *
+ * Copyright (C) 2021-22 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ */
+
+#ifndef _SPDM_H_
+#define _SPDM_H_
+
+#include <linux/types.h>
+
+enum spdm_base_hash_algo {
+	spdm_base_hash_sha_256 = 0,
+	spdm_base_hash_sha_384 = 1,
+	spdm_base_hash_sha_512 = 2,
+	spdm_base_hash_sha3_256 = 3,
+	spdm_base_hash_sha3_384 = 4,
+	spdm_base_hash_sha3_512 = 5,
+	spdm_base_hash_sm3_256 = 6,
+};
+
+enum spdm_meas_hash_algo {
+	spdm_meas_hash_raw = 0,
+	spdm_meas_hash_sha_256 = 1,
+	spdm_meas_hash_sha_384 = 2,
+	spdm_meas_hash_sha_512 = 3,
+	spdm_meas_hash_sha3_256 = 4,
+	spdm_meas_hash_sha3_384 = 5,
+	spdm_meas_hash_sha3_512 = 6,
+	spdm_meas_hash_sm3_257 = 7,
+};
+
+enum spdm_base_asym_algo {
+	spdm_asym_rsassa_2048 = 0,
+	spdm_asym_rsapss_2048 = 1,
+	spdm_asym_rsassa_3072 = 2,
+	spdm_asym_rsapss_3072 = 3,
+	spdm_asym_ecdsa_ecc_nist_p256 = 4,
+	spdm_asym_rsassa_4096 = 5,
+	spdm_asym_rsapss_4096 = 6,
+	spdm_asym_ecdsa_ecc_nist_p384 = 7,
+	spdm_asym_ecdsa_ecc_nist_p521 = 8,
+	spdm_asym_sm2_ecc_sm2_p256 = 9,
+	spdm_asym_eddsa_ed25519 = 10,
+	spdm_asym_eddsa_ed448 = 11,
+};
+
+struct crypto_shash;
+struct shash_desc;
+struct key;
+struct device;
+
+/*
+ * The SPDM specification does not actually define this as the header
+ * but all messages have the same first 4 named fields.
+ * Note however that the meaning of param1 and param2 is message dependent.
+ */
+struct spdm_header {
+	u8 version;
+	u8 code;  /* requestresponsecode */
+	u8 param1;
+	u8 param2;
+};
+
+struct spdm_exchange {
+	struct spdm_header *request;
+	size_t request_sz;
+	struct spdm_header *response;
+	size_t response_sz;
+	u8 code; /* Overwrites the request code */
+};
+struct spdm_state;
+
+struct spdm_state *spdm_create(int (*transport_ex)(void *priv, struct spdm_exchange *spdm_ex),
+			void *priv, struct device *dev, struct key *keyring);
+
+int spdm_authenticate(struct spdm_state *spdm_state);
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index dc1ab2ed1dc6..dee5bd7900eb 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -741,3 +741,6 @@ config ASN1_ENCODER
 
 config POLYNOMIAL
        tristate
+
+config SPDM
+       tristate
diff --git a/lib/Makefile b/lib/Makefile
index ffabc30a27d4..8c15b95a56d2 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -303,6 +303,8 @@ obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
 obj-$(CONFIG_ASN1) += asn1_decoder.o
 obj-$(CONFIG_ASN1_ENCODER) += asn1_encoder.o
 
+obj-$(CONFIG_SPDM) += spdm.o
+
 obj-$(CONFIG_FONT_SUPPORT) += fonts/
 
 hostprogs	:= gen_crc32table
diff --git a/lib/spdm.c b/lib/spdm.c
new file mode 100644
index 000000000000..e3ba4c3534ac
--- /dev/null
+++ b/lib/spdm.c
@@ -0,0 +1,1333 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DMTF Security Protocol and Data Model
+ * https://www.dmtf.org/dsp/DSP0274
+ *
+ * Copyright (C) 2021-22 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ */
+
+#include <linux/asn1_encoder.h>
+#include <linux/asn1_ber_bytecode.h>
+#include <linux/bitfield.h>
+#include <linux/cred.h>
+#include <linux/dev_printk.h>
+#include <linux/digsig.h>
+#include <linux/idr.h>
+#include <linux/key.h>
+#include <linux/module.h>
+#include <linux/random.h>
+#include <linux/spdm.h>
+
+#include <crypto/akcipher.h>
+#include <crypto/hash.h>
+#include <crypto/public_key.h>
+#include <keys/asymmetric-type.h>
+#include <keys/user-type.h>
+#include <asm/unaligned.h>
+
+#define SPDM_MAX_VER 0x12
+/*
+ * Todo
+ * - Secure channel setup.
+ * - Multiple slot support.
+ * - Measurement support (over secure channel or within CHALLENGE_AUTH.
+ * - Support more core algorithms (not CMA does not require them, but may use
+ *   them if present.
+ * - Extended algorithm, support.
+ */
+/*
+ * Discussions points
+ * 1. Worth adding an SPDM layer around a transport layer?
+ * 2. Pad all SPDM request response to DWORD so we don't have to bounce for CMA /DOE.
+ * 3. Currently only implement one flow - so ignore whether we have certs cached.
+ *    Could implement the alternative flows, but at cost of complexity.
+ * 4. Keyring management. How to ensure we can easily check root key against
+ *    keys in appropriate keyring, but ensure we can't cross check keys
+ *    from different devices.  Current solution of one keyring per SPDM has issues
+ *    around cleanup when an error occurs.
+ * 5. Several corners of the SPDM specification were not totally clear to me, so
+ *    where unsure I verified options against openSPDM.
+ * Detailed stuff
+ * - SPDM spec doesn't define a header, but all requests and responses have same
+ *   first 4 bytes.  Either could define that as a header, or givem the better names
+ *   to reflect how param1 and param2 are actually used.
+ *
+ * 1.2.1 changes - not necessarily supported
+ * - Alias certificates. Device creates certificates that can incorportate some
+ *   mutable information into the keys - hence we may not be able to cache them?
+ */
+
+struct spdm_state {
+	enum spdm_meas_hash_algo measurement_hash_alg;
+	enum spdm_base_asym_algo base_asym_alg;
+	enum spdm_base_hash_algo base_hash_alg;
+	struct key *leaf_key;
+	size_t h; /* base hash length - H in specification */
+	size_t s; /* base asymmetric signature length - S in specification */
+	u32 responder_caps;
+
+	/*
+	 * The base hash algorithm is not know until we reach the
+	 * NEGOTIATE_ALGORITHMS response.
+	 * The CHALLENGE_AUTH response handling requires a digest of all
+	 * prior messages in the sequence. As such cache the messages in @a until
+	 * they can be used as the first input to the hash function.
+	 * Once the hash is known it can be updated as each additional req/rsp
+	 * becomes available.
+	 */
+	void *a;
+	size_t a_length;
+	struct crypto_shash *shash;
+	struct shash_desc *desc;
+
+	struct key *root_keyring; /* Keyring against which to check the root */
+	struct key *keyring; /* used to store certs from device */
+	u8 version;
+
+	/* Transport specific */
+	struct device *dev; /* For error reporting only */
+	void *transport_priv;
+	int (*transport_ex)(void *priv, struct spdm_exchange *spdm_ex);
+};
+
+static int spdm_append_buffer_a(struct spdm_state *spdm_state, void *data,
+				size_t data_size, bool reset)
+{
+	u8 *a_new;
+
+	if (reset) {
+		kfree(spdm_state->a);
+		spdm_state->a = NULL;
+		spdm_state->a_length = 0;
+	}
+
+	a_new = krealloc(spdm_state->a, spdm_state->a_length + data_size, GFP_KERNEL);
+	if (!a_new)
+		return -ENOMEM;
+
+	spdm_state->a = a_new;
+	memcpy(spdm_state->a + spdm_state->a_length, data, data_size);
+	spdm_state->a_length += data_size;
+
+	return 0;
+}
+
+#define SPDM_REQ 0x80
+#define SPDM_GET_VERSION 0x04
+
+struct spdm_get_version_req {
+	u8 version;
+	u8 code;
+	u8 param1;
+	u8 param2;
+};
+
+struct spdm_get_version_rsp {
+	u8 version;
+	u8 code;
+	u8 param1;
+	u8 param2;
+
+	u8 reserved;
+	u8 version_number_entry_count;
+	__le16 version_number_entries[];
+};
+
+#define SPDM_GET_CAPABILITIES 0x61
+
+/* For this exchange the request and response messages have the same form. */
+struct spdm_get_capabilities_reqrsp {
+	u8 version;
+	u8 code;
+	u8 param1;
+	u8 param2;
+
+	u8 reserved;
+	u8 ctexponent;
+	u16 reserved2;
+
+/* CACHE_CAP is only valid for response */
+#define SPDM_GET_CAP_FLAG_CACHE_CAP			BIT(0)
+#define SPDM_GET_CAP_FLAG_CERT_CAP			BIT(1)
+#define SPDM_GET_CAP_FLAG_CHAL_CAP			BIT(2)
+
+/* MEAS_CAP values other than 0 only for response */
+#define SPDM_GET_CAP_FLAG_MEAS_CAP_MSK			GENMASK(4, 3)
+#define   SPDM_GET_CAP_FLAG_MEAS_CAP_NO			0
+#define   SPDM_GET_CAP_FLAG_MEAS_CAP_MEAS		1
+#define   SPDM_GET_CAP_FLAG_MEAS_CAP_MEAS_SIG		2
+
+/* MEAS_FRESH_CAP == 0 for request */
+#define SPDM_GET_CAP_FLAG_MEAS_FRESH_CAP		BIT(5)
+#define SPDM_GET_CAP_FLAG_ENCRYPT_CAP			BIT(6)
+#define SPDM_GET_CAP_FLAG_MAC_CAP			BIT(7)
+#define SPDM_GET_CAP_FLAG_MUT_AUTH_CAP			BIT(8)
+#define SPDM_GET_CAP_FLAG_KEY_EX_CAP			BIT(9)
+
+#define SPDM_GET_CAP_FLAG_PSK_CAP_MSK			GENMASK(11, 10)
+#define   SPDM_GET_CAP_FLAG_PSK_CAP_NO_PRESHARE		0
+#define   SPDM_GET_CAP_FLAG_PSK_CAP_PRESHARE		1
+
+#define SPDM_GET_CAP_FLAG_ENCAP_CAP			BIT(12)
+#define SPDM_GET_CAP_FLAG_HBEAT_CAP			BIT(13)
+#define SPDM_GET_CAP_FLAG_KEY_UPD_CAP			BIT(14)
+#define SPDM_GET_CAP_FLAG_HANDSHAKE_ITC_CAP		BIT(15)
+#define SPDM_GET_CAP_FLAG_PUB_KEY_ID_CAP		BIT(16)
+	__le32 flags;
+	/* End of SPDM 1.1 structure */
+	__le32 data_transfer_size; /* 1.2 */
+	__le32 max_spdm_msg_size;  /* 1.2 */
+};
+
+#define SPDM_NEGOTIATE_ALGS 0x63
+
+struct spdm_negotiate_algs_req {
+	u8 version;
+	u8 code;
+	u8 param1; /* Numer of algorithm structure tables */
+	u8 param2;
+
+	__le16 length; /* <= 128 bytes */
+	u8 measurement_specification;  /* Only one bit set, BIT 0 == DMTF */
+	u8 other_params_support; /* 1.2 */
+	__le32 base_asym_algo;
+
+	/* Bit mask, entries form spdm_base_hash_algo */
+	__le32 base_hash_algo;
+
+	u8 reserved2[12];
+	u8 ext_asm_count;
+	u8 ext_hash_count;
+	u8 reserved3[2];
+
+	/*
+	 * Additional fields at end of this structure
+	 * - ExtAsym 4 * ext_asm_count
+	 * - ExtHash 4 * ext_hash_count
+	 * - ReqAlgStruct size * param1
+	 */
+};
+
+struct spdm_negotiate_algs_rsp {
+	u8 version;
+	u8 code;
+	u8 param1; /* Numer of algorithm structure tables */
+	u8 param2;
+
+	__le16 length; /* <= 128 bytes */
+	u8 measurement_specification;  /* Only one bit set, BIT 0 == DMTF */
+	u8 other_params_support; /* 1.2 */
+
+	/* Exactly one bit must be set if GET_MEASUREMENTS is supported */
+	__le32 measurement_hash_algo;
+	/* At most one bit set to reflect negotiated alg */
+	__le32 base_asym_sel;
+	__le32 base_hash_sel;
+	u8 reserved2[12];
+	u8 ext_asym_sel_count; /* Either 0 or 1 */
+	u8 ext_hash_sel_count; /* Either 0 or 1 */
+	u8 reserved3[2];
+
+	/*
+	 * Additional fields at end of this structure
+	 * - ExtAsym 4 * ext_asm_count
+	 * - ExtHash 4 * ext_hash_count
+	 * - ReqAlgStruct size * param1
+	 */
+};
+
+#define SPDM_REQ_ALG_STRUCT_TYPE_DHE			0x2
+#define   SPDM_DHE_ALGO_FFDHE_2048			BIT(0)
+#define   SPDM_DHE_ALGO_FFDHE_3072			BIT(1)
+#define   SPDM_DHE_ALGO_FFDHE_4096			BIT(2)
+#define   SPDM_DHE_ALGO_SECP_256R1			BIT(3)
+#define   SPDM_DHE_ALGO_SECP_384R1			BIT(4)
+#define   SPDM_DHE_ALGO_SECP_521R1			BIT(5)
+#define   SPDM_DHE_ALGO_SM2_P256			BIT(6)
+
+#define SPDM_REQ_ALG_STRUCT_TYPE_AEAD_CIPHER_SUITE	0x3
+#define   SPDM_AEAD_ALGO_AES_128_GCM			BIT(0)
+#define   SPDM_AEAD_ALGO_AES_256_GCM			BIT(1)
+#define   SPDM_AEAD_ALGO_CHACHA20_POLY1305		BIT(2)
+#define   SPDM_AEAD_ALGO_SM4_GCM			BIT(3)
+#define SPDM_REQ_ALG_STRUCT_TYPE_REQ_BASE_ASYM_ALG	0x4
+/* As for base_asym_algo above */
+
+#define SPDM_REQ_ALG_STRUCT_TYPE_KEY_SCHEDULE		0x5
+#define   SPDM_KEY_SCHEDULE_SPDM			BIT(0)
+
+struct spdm_req_alg_struct {
+	u8 alg_type;
+	u8 alg_count; /* 0x2K where K is number of alg_external entries */
+	/* This field is sized based on alg_count[7:5] - currently always 2 */
+	__le16 alg_supported;
+	__le32 alg_external[];
+};
+
+#define SPDM_GET_DIGESTS 0x01
+struct spdm_digest_req {
+	u8 version;
+	u8 code;
+	u8 param1; /* Reserved */
+	u8 param2; /* Reserved */
+};
+
+struct spdm_cert_chain {
+	__le16 length;
+	u8 reserved[2];
+	/*
+	 * Additional fields:
+	 * - Hash of the root
+	 * - Certs: ASN.1 Der-encoded X.509 v3 - First cert signed by root or is the root.
+	 */
+};
+
+struct spdm_digest_rsp {
+	u8 version;
+	u8 code;
+	u8 param1; /* Reserved */
+	u8 param2; /* Slot mask */
+	/* Hash of spdm_cert_chain for each slot */
+	u8 digests[];
+};
+
+#define SPDM_GET_CERTIFICATE 0x02
+struct spdm_certificate_req {
+	u8 version;
+	u8 code;
+	u8 param1; /* Slot number 0..7 */
+	u8 param2; /* Reserved */
+	__le16 offset;
+	__le16 length; /* Note 0xFFFF and offset 0 is special value meaning whole chain */
+};
+
+struct spdm_certificate_rsp {
+	u8 version;
+	u8 code;
+	u8 param1; /* Slot number 0..7 */
+	u8 param2; /* Reserved */
+	__le16 portion_length;
+	__le16 remainder_length;
+	u8 cert_chain[]; /* Portion Length Long */
+};
+
+
+#define SPDM_CHALLENGE 0x03
+struct spdm_challenge_req {
+	u8 version;
+	u8 code;
+	u8 param1; /* Slot number 0..7 */
+	u8 param2; /* Measurement summary hash type */
+	u8 nonce[32];
+};
+
+struct spdm_challenge_rsp {
+	u8 version;
+	u8 code;
+	u8 param1; /* response attribute field, slot id from challenge, bit 7 is mutual auth */
+	u8 param2; /* slot mask */
+	/* Hash length cert chain */
+	/* Nonce, 32 bytes */
+	/* Measurement Summary Hash - if present */
+	/* 2 byte opaque length */
+	/* opaque data if length non 0 */
+	/* Signature */
+};
+
+static size_t spdm_challenge_rsp_signature_offset(struct spdm_state *spdm_state,
+						 struct spdm_challenge_req *req,
+						 struct spdm_challenge_rsp *rsp)
+{
+	u16 opaque_length;
+	size_t offset;
+
+	offset = sizeof(*rsp);		/* Header offset */
+	offset += spdm_state->h;	/* CertChain hash */
+	offset += 32;			/* Nonce */
+
+	/* Measurement summary hash */
+	if (req->param2 &&
+	    (spdm_state->responder_caps & SPDM_GET_CAP_FLAG_MAC_CAP))
+		offset += spdm_state->h;
+	/*
+	 * This is almost certainly aligned, but that's not obvious from nearby code
+	 * so play safe.
+	 */
+	opaque_length = get_unaligned_le16((u8 *)rsp + offset);
+	offset += sizeof(__le16);
+	offset += opaque_length;
+
+	return offset;
+}
+
+#define SPDM_ERROR 0x7f
+enum spdm_error_code {
+	spdm_invalid_request = 0x01,
+	spdm_invalid_session = 0x02,
+	spdm_busy = 0x03,
+	spdm_unexpected_request = 0x04,
+	spdm_unspecified = 0x05,
+	spdm_decrypt_error = 0x06,
+	spdm_unsupported_request = 0x07,
+	spdm_request_in_flight = 0x08,
+	spdm_invalid_response_code = 0x09,
+	spdm_session_limit_exceeded = 0x0a,
+	spdm_session_required = 0x0b,
+	spdm_reset_required = 0x0c,
+	spdm_response_too_large = 0x0d,
+	spdm_request_too_large = 0x0e,
+	spdm_large_response = 0x0f,
+	spdm_message_lost = 0x10,
+	spdm_major_version_missmatch = 0x41,
+	spdm_response_not_ready = 0x42,
+	spdm_request_resync = 0x43,
+	spdm_vendor_defined_error = 0xff,
+};
+
+struct spdm_error_rsp {
+	u8 version;
+	u8 code;
+	u8 param1; /* Error code */
+	u8 param2; /* Error data */
+	u8 extended_error_data[];
+};
+#define SPDM_ERROR_MIN_SIZE sizeof(struct spdm_error_rsp)
+
+static void spdm_err(struct device *dev, enum spdm_error_code error_code,
+		     u8 error_data)
+{
+	switch (error_code) {
+	case spdm_invalid_request:
+		dev_err(dev, "Invalid Request\n");
+		break;
+	case spdm_invalid_session:
+		dev_err(dev, "Invalid Session %#x\n", error_data);
+		break;
+	case spdm_busy:
+		dev_err(dev, "Busy\n");
+		break;
+	case spdm_unexpected_request:
+		dev_err(dev, "Unexpected request\n");
+		break;
+	case spdm_unspecified:
+		dev_err(dev, "Unspecified\n");
+		break;
+	case spdm_decrypt_error:
+		dev_err(dev, "Decrypt Error\n");
+		break;
+	case spdm_unsupported_request:
+		dev_err(dev, "Unsupported Request %#x\n", error_data);
+		break;
+	case spdm_request_in_flight:
+		dev_err(dev, "Request in flight\n");
+		break;
+	case spdm_invalid_response_code:
+		dev_err(dev, "Invalid response code\n");
+		break;
+	case spdm_session_limit_exceeded:
+		dev_err(dev, "Session limit exceeded\n");
+		break;
+	case spdm_session_required:
+		dev_err(dev, "Session required\n");
+		break;
+	case spdm_reset_required:
+		dev_err(dev, "Reset required\n");
+		break;
+	case spdm_response_too_large:
+		dev_err(dev, "Response too large\n");
+		break;
+	case spdm_request_too_large:
+		dev_err(dev, "Request too large\n");
+		break;
+	case spdm_large_response:
+		dev_err(dev, "Large response - not handled yet\n");
+		break;
+	case spdm_message_lost:
+		dev_err(dev, "Message lost\n");
+		break;
+	case spdm_major_version_missmatch:
+		dev_err(dev, "Major version mismatch\n");
+		break;
+	case spdm_response_not_ready:
+		dev_err(dev, "Response not ready\n");
+		break;
+	case spdm_request_resync:
+		dev_err(dev, "Request resynchronization\n");
+		break;
+	case spdm_vendor_defined_error:
+		dev_err(dev, "Vendor defined error\n");
+		break;
+	}
+}
+
+static int __spdm_exchange(struct spdm_state *spdm_state, struct spdm_exchange *ex, u8 version)
+{
+	int length;
+	int rc;
+
+	if (ex->request_sz < sizeof(*ex->request) ||
+	    ex->response_sz < sizeof(*ex->response))
+		return -EINVAL;
+
+	ex->request->version = version;
+	ex->request->code = SPDM_REQ | ex->code;
+
+	/* Will become an op pointer if we have a second transport */
+	rc = spdm_state->transport_ex(spdm_state->transport_priv, ex);
+	if (rc < 0)
+		return rc;
+
+	length = rc;
+	if (length < SPDM_ERROR_MIN_SIZE)
+		return -EIO;
+
+	if (ex->response->code == SPDM_ERROR) {
+		spdm_err(spdm_state->dev, ex->response->param1,
+			 ex->response->param2);
+		return -EIO;
+	}
+
+	if (ex->response->code != ex->code) {
+		dev_err(spdm_state->dev,
+			"Invalid SPDM response received - does not match request code\n");
+		return -EIO;
+	}
+
+	return length;
+}
+
+static int spdm1p0_exchange(struct spdm_state *spdm_state, struct spdm_exchange *ex)
+{
+	return __spdm_exchange(spdm_state, ex, 0x10);
+}
+
+static int spdm_exchange(struct spdm_state *spdm_state, struct spdm_exchange *ex)
+{
+	return __spdm_exchange(spdm_state, ex, spdm_state->version);
+}
+
+static int spdm_get_version(struct spdm_state *spdm_state, u8 min_version)
+{
+	struct spdm_get_version_req req = {};
+	struct spdm_get_version_rsp *rsp;
+	struct spdm_exchange spdm_ex;
+	ssize_t rc, rsp_sz, length;
+	bool foundver = false;
+	int numversions = 2;
+	u8 version;
+	int i;
+
+retry:
+	rsp_sz = struct_size(rsp, version_number_entries, numversions);
+	rsp = kzalloc(rsp_sz, GFP_KERNEL);
+
+	spdm_ex = (struct spdm_exchange) {
+		.request = (struct spdm_header *)&req,
+		.request_sz = sizeof(req),
+		.response = (struct spdm_header *)rsp,
+		.response_sz = rsp_sz,
+		.code = SPDM_GET_VERSION,
+	};
+	rc = spdm1p0_exchange(spdm_state, &spdm_ex);
+	if (rc < 0)
+		goto err;
+
+	length = rc;
+
+	if (length < struct_size(rsp, version_number_entries, 1)) {
+		dev_err(spdm_state->dev, "SPDM must support at least one version\n");
+		rc = -EIO;
+		goto err;
+	}
+
+	/* If we didn't allocate enough space the first time, go around again */
+	if (rsp->version_number_entry_count > numversions) {
+		numversions = rsp->version_number_entry_count;
+		kfree(rsp);
+		goto retry;
+	}
+
+	for (i = 0; i < rsp->version_number_entry_count; i++) {
+		u8 ver = get_unaligned_le16(&rsp->version_number_entries[i]) >> 8;
+
+		if (ver >= min_version && ver <= SPDM_MAX_VER) {
+			foundver = true;
+			version = ver;
+		}
+	}
+	if (!foundver) {
+		dev_err(spdm_state->dev, "Version match failed\n");
+		rc = -EINVAL;
+		goto err;
+	}
+	spdm_state->version = version;
+
+	/*
+	 * Cache the request and response to use later to compute a message digest,
+	 * as the algorithm to use is not yet known.
+	 *
+	 * Response may be padded, so we need to compute the length rather than relying
+	 * on the length returned by the transport.
+	 */
+	length = struct_size(rsp, version_number_entries, rsp->version_number_entry_count);
+	rc = spdm_append_buffer_a(spdm_state, &req, sizeof(req), true);
+	if (rc)
+		goto err;
+
+	rc = spdm_append_buffer_a(spdm_state, rsp, length, false);
+
+err:
+	kfree(rsp);
+
+	return rc;
+}
+
+
+static int spdm_negotiate_caps(struct spdm_state *spdm_state, u32 req_caps,
+			       u32 *rsp_caps)
+{
+	struct spdm_get_capabilities_reqrsp req = {
+		.ctexponent = 2, /* FIXME: Chose sensible value */
+		.flags = cpu_to_le32(req_caps),
+	};
+	struct spdm_get_capabilities_reqrsp rsp;
+	struct spdm_exchange spdm_ex = {
+		.request = (struct spdm_header *)&req,
+		.response = (struct spdm_header *)&rsp,
+		.code = SPDM_GET_CAPABILITIES,
+	};
+	int rc, length;
+
+	if (spdm_state->version >= 0x12) {
+		req.data_transfer_size = cpu_to_le32(0x1000000);
+		req.max_spdm_msg_size = cpu_to_le32(0x1000000);
+		spdm_ex.request_sz = sizeof(req);
+		spdm_ex.response_sz = sizeof(rsp);
+	} else {
+		spdm_ex.request_sz = offsetof(typeof(req), data_transfer_size);
+		spdm_ex.response_sz = offsetof(typeof(rsp), data_transfer_size);
+	}
+	rc = spdm_exchange(spdm_state, &spdm_ex);
+	if (rc < 0)
+		return rc;
+	length = rc;
+
+	if (length < spdm_ex.response_sz) {
+		dev_err(spdm_state->dev, "NEGOTIATE_CAPS response short\n");
+		return -EIO;
+	}
+	/* Cache capability as can affect data layout for other messages */
+	spdm_state->responder_caps = le32_to_cpu(rsp.flags);
+
+	if (rsp_caps)
+		*rsp_caps = spdm_state->responder_caps;
+
+	rc = spdm_append_buffer_a(spdm_state, &req, spdm_ex.request_sz, false);
+	if (rc)
+		return rc;
+
+	return spdm_append_buffer_a(spdm_state, &rsp, spdm_ex.response_sz, false);
+}
+
+static int spdm_start_digest(struct spdm_state *spdm_state,
+			     void *req, size_t req_sz, void *rsp, size_t rsp_sz)
+{
+	int rc;
+
+	/* Build first part of challenge hash */
+	switch (spdm_state->base_hash_alg) {
+	case spdm_base_hash_sha_384:
+		spdm_state->shash = crypto_alloc_shash("sha384", 0, CRYPTO_ALG_ASYNC);
+		break;
+	case spdm_base_hash_sha_256:
+		spdm_state->shash = crypto_alloc_shash("sha256", 0, CRYPTO_ALG_ASYNC);
+		break;
+	default:
+		/* Given device must support one of the above, lets stick to them for now */
+		return -EINVAL;
+	}
+
+	if (!spdm_state->shash)
+		return -ENOMEM;
+
+	/* Used frequently to compute offsets, so cache H */
+	spdm_state->h = crypto_shash_digestsize(spdm_state->shash);
+
+	spdm_state->desc = kzalloc(struct_size(spdm_state->desc, __ctx,
+					       crypto_shash_descsize(spdm_state->shash)),
+				   GFP_KERNEL);
+	if (!spdm_state->desc) {
+		rc = -ENOMEM;
+		goto err_free_shash;
+	}
+	spdm_state->desc->tfm = spdm_state->shash;
+
+	rc = crypto_shash_init(spdm_state->desc);
+	if (rc)
+		goto err_free_desc;
+
+	rc = crypto_shash_update(spdm_state->desc, spdm_state->a,
+				 spdm_state->a_length);
+	if (rc)
+		goto err_free_desc;
+
+	rc = crypto_shash_update(spdm_state->desc, (u8 *)req, req_sz);
+
+	if (rc)
+		goto err_free_desc;
+
+	rc = crypto_shash_update(spdm_state->desc, (u8 *)rsp, rsp_sz);
+	if (rc)
+		goto err_free_desc;
+
+	kfree(spdm_state->a);
+	spdm_state->a = NULL;
+	spdm_state->a_length = 0;
+
+	return 0;
+
+err_free_desc:
+	kfree(spdm_state->desc);
+err_free_shash:
+	crypto_free_shash(spdm_state->shash);
+	return rc;
+}
+
+static int spdm_negotiate_algs(struct spdm_state *spdm_state)
+{
+	struct spdm_req_alg_struct *req_alg_struct;
+	/*
+	 * Current support is focused on enabling PCI/CMA
+	 *
+	 * CMA requires that device must support
+	 * One or more of:
+	 *  - RSASSA_3072
+	 *  - ECDSA_ECC_NIST_P256
+	 *  - ECDSA_ECC_NIST_P384
+	 * One or more of:
+	 *  - SHA_256
+	 *  - SHA_384
+	 */
+	struct spdm_negotiate_algs_req *req;
+	struct spdm_negotiate_algs_rsp *rsp;
+	struct spdm_exchange spdm_ex;
+	/*
+	 * There are several variable length elements at the end of these structures.
+	 * Allow for 0 Ext Asym, 0 Ext Hash, 4 ReqAlgStructs
+	 */
+	size_t req_sz = sizeof(*req) + 16;
+	/*
+	 * Response length may be less than this if not all algorithm types supported,
+	 * resulting in fewer AlgStructure fields than in the request.
+	 */
+	size_t rsp_sz = sizeof(*rsp) + 16;
+	size_t length;
+	int rc;
+
+	req = kzalloc(req_sz, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->param1 = 4;
+	req->code = SPDM_NEGOTIATE_ALGS | SPDM_REQ;
+	req->length = cpu_to_le16(req_sz);
+	req->measurement_specification = BIT(0);
+	if (spdm_state->version >= 0x12)
+		req->other_params_support = BIT(1); /* New in 1.2 */
+	req->base_asym_algo = cpu_to_le32(BIT(spdm_asym_rsassa_3072) |
+					  BIT(spdm_asym_ecdsa_ecc_nist_p256) |
+					  BIT(spdm_asym_ecdsa_ecc_nist_p384));
+	req->base_hash_algo = cpu_to_le32(BIT(spdm_base_hash_sha_256) |
+					  BIT(spdm_base_hash_sha_384));
+
+	req->ext_asm_count = 0;
+	req->ext_hash_count = 0;
+	req_alg_struct = (struct spdm_req_alg_struct *)(req + 1);
+	/*
+	 * For CMA only we don't need to support DHE, AEAD or Key Schedule - but the
+	 * responder may reply with them anyway.
+	 * TODO: Identify minimum set needed.
+	 */
+	req_alg_struct[0] = (struct spdm_req_alg_struct) {
+		.alg_type = SPDM_REQ_ALG_STRUCT_TYPE_DHE,
+		.alg_count = 0x20,
+		.alg_supported = cpu_to_le16(SPDM_DHE_ALGO_FFDHE_2048 |
+					     SPDM_DHE_ALGO_FFDHE_3072 |
+					     SPDM_DHE_ALGO_SECP_256R1 |
+					     SPDM_DHE_ALGO_SECP_384R1)
+					     };
+	req_alg_struct[1] = (struct spdm_req_alg_struct) {
+		.alg_type = SPDM_REQ_ALG_STRUCT_TYPE_AEAD_CIPHER_SUITE,
+		.alg_count = 0x20,
+		.alg_supported = cpu_to_le16(SPDM_AEAD_ALGO_AES_256_GCM |
+					     SPDM_AEAD_ALGO_CHACHA20_POLY1305)
+	};
+	req_alg_struct[2] = (struct spdm_req_alg_struct) {
+		.alg_type = SPDM_REQ_ALG_STRUCT_TYPE_REQ_BASE_ASYM_ALG,
+		.alg_count = 0x20,
+		.alg_supported = cpu_to_le16(BIT(spdm_asym_rsassa_3072) |
+					     BIT(spdm_asym_ecdsa_ecc_nist_p256) |
+					     BIT(spdm_asym_ecdsa_ecc_nist_p384)),
+	};
+	req_alg_struct[3] = (struct spdm_req_alg_struct) {
+		.alg_type = SPDM_REQ_ALG_STRUCT_TYPE_KEY_SCHEDULE,
+		.alg_count = 0x20,
+		.alg_supported = cpu_to_le16(SPDM_KEY_SCHEDULE_SPDM)
+	};
+
+	rsp = kzalloc(rsp_sz, GFP_KERNEL);
+	if (!rsp) {
+		rc = -ENOMEM;
+		goto err_free_req;
+	}
+
+	spdm_ex = (struct spdm_exchange) {
+		.request = (struct spdm_header *)req,
+		.request_sz = req_sz,
+		.response = (struct spdm_header *)rsp,
+		.response_sz = rsp_sz,
+		.code = SPDM_NEGOTIATE_ALGS,
+	};
+
+	rc = spdm_exchange(spdm_state, &spdm_ex);
+	if (rc < 0)
+		goto err_free_rsp;
+	length = rc;
+
+	//TODO: Check this cannot return short.
+	if (length < rsp_sz) {
+		dev_err(spdm_state->dev, "Response too short\n");
+		rc = -EIO;
+		goto err_free_rsp;
+	}
+
+	spdm_state->measurement_hash_alg = __ffs(le32_to_cpu(rsp->measurement_hash_algo));
+	spdm_state->base_asym_alg = __ffs(le32_to_cpu(rsp->base_asym_sel));
+	spdm_state->base_hash_alg = __ffs(le32_to_cpu(rsp->base_hash_sel));
+
+	switch (spdm_state->base_asym_alg) {
+	case spdm_asym_rsassa_3072:
+		spdm_state->s = 384;
+		break;
+	case spdm_asym_ecdsa_ecc_nist_p256:
+		spdm_state->s = 64;
+		break;
+	case spdm_asym_ecdsa_ecc_nist_p384:
+		spdm_state->s = 96;
+		break;
+	default:
+		dev_err(spdm_state->dev, "Unknown async base algorithm\n");
+		rc = -EINVAL;
+		goto err_free_rsp;
+	}
+
+	rsp_sz = sizeof(*rsp) + rsp->param1 * sizeof(struct spdm_req_alg_struct);
+	rc = spdm_start_digest(spdm_state, req, req_sz, rsp, rsp_sz);
+
+err_free_rsp:
+	kfree(rsp);
+err_free_req:
+	kfree(req);
+
+	return rc;
+}
+
+static int spdm_get_digests(struct spdm_state *spdm_state)
+{
+	struct spdm_digest_req req = {};
+	struct spdm_digest_rsp *rsp;
+	struct spdm_exchange spdm_ex;
+	unsigned long slot_bm;
+	int rc;
+	/* Assume all slots may be present */
+	size_t rsp_sz;
+
+	rsp_sz = struct_size(rsp, digests, spdm_state->h * 8);
+	rsp = kzalloc(rsp_sz, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	spdm_ex = (struct spdm_exchange) {
+		.request = (struct spdm_header *)&req,
+		.request_sz = sizeof(req),
+		.response = (struct spdm_header *)rsp,
+		.response_sz = rsp_sz,
+		.code = SPDM_GET_DIGESTS,
+	};
+
+	rc = spdm_exchange(spdm_state, &spdm_ex);
+	if (rc < 0)
+		return rc;
+
+	rc = crypto_shash_update(spdm_state->desc, (u8 *)&req, sizeof(req));
+	if (rc)
+		goto err_free_rsp;
+
+	slot_bm = rsp->param2;
+	rsp_sz = struct_size(rsp, digests,
+			     spdm_state->h *
+			     bitmap_weight(&slot_bm, 8 * sizeof(rsp->param2)));
+
+	rc = crypto_shash_update(spdm_state->desc, (u8 *)rsp, rsp_sz);
+
+err_free_rsp:
+	kfree(rsp);
+
+	return rc;
+}
+
+/* Used to give a unique name for per device keychains */
+static DEFINE_IDA(spdm_ida);
+
+static int spdm_get_certificate(struct spdm_state *spdm_state)
+{
+	//TODO: Test this.
+	/* This should ensure the limitation is rarely at the requester */
+	u16 bufsize = 0x8000;
+	struct spdm_certificate_req req = {
+		.param1 = 0, /* Slot 0 */
+	};
+	struct spdm_certificate_rsp *rsp;
+	size_t rsp_sz;
+	struct spdm_exchange spdm_ex;
+	u16 remainder_length = bufsize;
+	u16 offset = 0;
+	char *keyring_name;
+	int keyring_id;
+	u8 *certs = NULL;
+	u16 certs_length = 0;
+	u16 next_cert;
+	int rc;
+
+	rsp_sz = struct_size(rsp, cert_chain, bufsize);
+	rsp = kzalloc(rsp_sz, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	spdm_ex = (struct spdm_exchange) {
+		.request = (struct spdm_header *)&req,
+		.request_sz = sizeof(req),
+		.response = (struct spdm_header *)rsp,
+		.response_sz = rsp_sz,
+		.code = SPDM_GET_CERTIFICATE,
+	};
+
+	while (remainder_length > 0) {
+		u8 *newcerts;
+
+		req.length = cpu_to_le16(min(remainder_length, bufsize));
+		req.offset = cpu_to_le16(offset);
+
+		rc = spdm_exchange(spdm_state, &spdm_ex);
+		if (rc < 0)
+			goto err_free_certs;
+
+		/*
+		 * Taking the hash of each message was established by looking at
+		 * what openSPDM does, rather than it being clear from the SPDM
+		 * specification.
+		 */
+		rc = crypto_shash_update(spdm_state->desc, (u8 *)&req, sizeof(req));
+		if (rc)
+			goto err_free_certs;
+
+		/* Care needed - each message might not be full length due to padding */
+		rc = crypto_shash_update(spdm_state->desc, (u8 *)rsp,
+					 sizeof(rsp) + le16_to_cpu(rsp->portion_length));
+		if (rc)
+			goto err_free_certs;
+
+		certs_length += le16_to_cpu(rsp->portion_length);
+		newcerts = krealloc(certs, certs_length, GFP_KERNEL);
+		if (!newcerts) {
+			rc = -ENOMEM;
+			goto err_free_certs;
+		}
+		certs = newcerts;
+		memcpy(certs + offset, rsp->cert_chain, le16_to_cpu(rsp->portion_length));
+		offset += le16_to_cpu(rsp->portion_length);
+		remainder_length = le16_to_cpu(rsp->remainder_length);
+	}
+
+	keyring_id = ida_alloc(&spdm_ida, GFP_KERNEL);
+	if (keyring_id < 0) {
+		rc = keyring_id;
+		goto err_free_certs;
+
+	}
+
+	keyring_name = kasprintf(GFP_KERNEL, "_spdm%02d", keyring_id);
+	if (!keyring_name) {
+		rc = -ENOMEM;
+		goto err_free_ida;
+	}
+
+	/*
+	 * Create a spdm instance specific keyring to avoid mixing certs,
+	 * Not a child of _cma keyring, because the search below should
+	 * not find a self signed cert in here.
+	 *
+	 * Not sure how to release a keyring, so currently if this fails we leak.
+	 * That might be fine but an ida could get reused.
+	 */
+	spdm_state->keyring = keyring_alloc(keyring_name,
+					    KUIDT_INIT(0), KGIDT_INIT(0),
+					    current_cred(),
+					    (KEY_POS_ALL & ~KEY_POS_SETATTR) |
+					    KEY_USR_VIEW | KEY_USR_READ,
+					    KEY_ALLOC_NOT_IN_QUOTA |
+					    KEY_ALLOC_SET_KEEP,
+					    NULL, NULL);
+	kfree(keyring_name);
+	if (IS_ERR(spdm_state->keyring)) {
+		dev_err(spdm_state->dev,
+			"Failed to allocate per spdm keyring\n");
+		rc = PTR_ERR(spdm_state->keyring);
+		goto err_free_ida;
+	}
+
+	next_cert = sizeof(struct spdm_cert_chain) + spdm_state->h;
+
+	/*
+	 * Store the certificate chain on the per SPDM instance keyring.
+	 * Allow for up to 3 bytes padding as transport sends multiples of 4 bytes.
+	 */
+	while (next_cert < offset) {
+		struct key *key;
+		key_ref_t key2;
+
+		key2 = key_create_or_update(make_key_ref(spdm_state->keyring, 1),
+					    "asymmetric", NULL,
+					    certs + next_cert, offset - next_cert,
+					    (KEY_POS_ALL & ~KEY_POS_SETATTR) |
+					    KEY_USR_VIEW | KEY_USR_READ,
+					    KEY_ALLOC_NOT_IN_QUOTA);
+
+		if (IS_ERR(key2)) {
+			/* FIXME: Any additional cleanup to do here? */
+			rc = PTR_ERR(key2);
+			goto err_free_ida;
+		}
+
+		if (!spdm_state->leaf_key) {
+			/* First key in chain, so check against keys on _cma keyring */
+			struct public_key_signature *sig =
+				key_ref_to_ptr(key2)->payload.data[asym_auth];
+
+			key = find_asymmetric_key(spdm_state->root_keyring, sig->auth_ids[0],
+						  sig->auth_ids[1], NULL, false);
+			if (IS_ERR(key)) {
+				dev_err(spdm_state->dev,
+					"Unable to retrieve signing certificate from _cma keyring\n");
+				rc = PTR_ERR(key);
+				goto err_free_ida;
+			}
+
+			rc = verify_signature(key, sig);
+			if (rc) {
+				dev_err(spdm_state->dev,
+					"Unable to check SPDM cert against _cma keyring\n");
+				goto err_free_ida;
+			}
+
+			spdm_state->leaf_key = key_ref_to_ptr(key2);
+		} else {
+			/* Not the first key in chain, so check it against previous one */
+			struct public_key_signature *sig =
+				key_ref_to_ptr(key2)->payload.data[asym_auth];
+
+			rc = verify_signature(spdm_state->leaf_key, sig);
+			if (rc) {
+				dev_err(spdm_state->dev,
+					"Unable to verify SPDM cert against previous cert in chain\n");
+				goto err_free_ida;
+			}
+			spdm_state->leaf_key = key_ref_to_ptr(key2);
+		}
+		/*
+		 * Horrible but need to pull this directly from the ASN1 stream as the cert
+		 * chain is a concatentation of multiple cerificates.
+		 */
+		next_cert += get_unaligned_be16(certs + next_cert + 2) + 4;
+	}
+
+	kfree(certs);
+	kfree(rsp);
+
+	return 0;
+
+err_free_ida:
+	ida_free(&spdm_ida, keyring_id);
+err_free_certs:
+	kfree(certs);
+	kfree(rsp);
+
+	return rc;
+}
+
+
+static int spdm_verify_signature(struct spdm_state *spdm_state, u8 *sig_ptr,
+				 u8 *digest, unsigned int digest_size)
+{
+	const struct asymmetric_key_ids *ids;
+	struct public_key_signature sig = {};
+	/* Large enough for an ASN1 enocding of supported ECC signatures */
+	unsigned char buffer2[128] = {};
+	int rc;
+
+	/*
+	 * The ecdsa signatures are raw concatentation of the two values.
+	 * SPDM 1.2.1 section 2.2.3.4.1 refers to FIPS PUB 186-4 defining this
+	 * ordering.
+	 * In order to use verify_signature we need to reformat them into ASN1.
+	 */
+	switch (spdm_state->base_asym_alg) {
+	case spdm_asym_ecdsa_ecc_nist_p256:
+	case spdm_asym_ecdsa_ecc_nist_p384:
+	{
+		unsigned char buffer[128] = {};
+		unsigned char *p = buffer;
+		unsigned char *p2;
+
+		//TODO: test the ASN1 function rather more extensively.
+		/* First pack the two large integer values */
+		p = asn1_encode_integer_large_positive(p, buffer + sizeof(buffer),
+						       ASN1_INT, sig_ptr,
+						       spdm_state->s / 2);
+		p = asn1_encode_integer_large_positive(p, buffer + sizeof(buffer),
+						       ASN1_INT,
+						       sig_ptr + spdm_state->s  / 2,
+						       spdm_state->s / 2);
+
+		/* In turn pack those two large integer values into a sequence */
+		p2 = asn1_encode_sequence(buffer2, buffer2 + sizeof(buffer2),
+					  buffer, p - buffer);
+
+		sig.s = buffer2;
+		sig.s_size = p2 - buffer2;
+		sig.encoding = "x962";
+		break;
+	}
+
+	case spdm_asym_rsassa_3072:
+		sig.s = sig_ptr;
+		sig.s_size = spdm_state->s;
+		sig.encoding = "pkcs1";
+		break;
+	default:
+		dev_err(spdm_state->dev,
+			"Signature algorithm not yet supported\n");
+		return -EINVAL;
+	}
+	sig.digest = digest;
+	sig.digest_size = digest_size;
+	ids = asymmetric_key_ids(spdm_state->leaf_key);
+	sig.auth_ids[0] = ids->id[0];
+	sig.auth_ids[1] = ids->id[1];
+
+	switch (spdm_state->base_hash_alg) {
+	case spdm_base_hash_sha_384:
+		sig.hash_algo = "sha384";
+		break;
+	case spdm_base_hash_sha_256:
+		sig.hash_algo = "sha256";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	rc = verify_signature(spdm_state->leaf_key, &sig);
+	if (rc) {
+		dev_err(spdm_state->dev,
+			"Failed to verify challenge_auth signature %d\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+static int spdm_challenge(struct spdm_state *spdm_state)
+{
+	const char spdm_prefix[] = {
+		'd', 'm', 't', 'f', '-', 's', 'p', 'd', 'm', '-', 'v', '1', '.', '2', '.', '*',
+		'd', 'm', 't', 'f', '-', 's', 'p', 'd', 'm', '-', 'v', '1', '.', '2', '.', '*',
+		'd', 'm', 't', 'f', '-', 's', 'p', 'd', 'm', '-', 'v', '1', '.', '2', '.', '*',
+		'd', 'm', 't', 'f', '-', 's', 'p', 'd', 'm', '-', 'v', '1', '.', '2', '.', '*',
+		0, 0, 0, 0, /* pad here so length 100 */
+		'r', 'e', 's', 'p', 'o', 'n', 'd', 'e', 'r', '-',
+		'c', 'h', 'a', 'l', 'l', 'e', 'n', 'g', 'e', '_', 'a', 'u', 't', 'h', ' ',
+		's', 'i', 'g', 'n', 'i', 'n', 'g' };
+	struct spdm_challenge_req req = {
+		.param1 = 0, /* slot 0 for now */
+		.param2 = 0, /* no measurement summary hash */
+	};
+	struct spdm_challenge_rsp *rsp;
+	struct spdm_exchange spdm_ex;
+	size_t sig_offset, rsp_max_size;
+	int length, rc;
+	u8 *digest, *message;
+
+	BUILD_BUG_ON(sizeof(spdm_prefix) != 100);
+	/*
+	 * The response length is up to:
+	 * 4 byte header
+	 * H byte CertChainHash
+	 * 32 byte nonce
+	 * (H byte Measurement Summary Hash - not currently requested)
+	 * 2 byte Opaque Length
+	 * <= 1024 bytes Opaque Data
+	 * S byte signature
+	 */
+	rsp_max_size = sizeof(*rsp) + spdm_state->h + 32 + 2 + 1024 + spdm_state->s;
+	rsp = kzalloc(rsp_max_size, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	get_random_bytes(&req.nonce, sizeof(req.nonce));
+
+	spdm_ex = (struct spdm_exchange) {
+		.request = (struct spdm_header *)&req,
+		.request_sz = sizeof(req),
+		.response = (struct spdm_header *)rsp,
+		.response_sz = rsp_max_size,
+		.code = SPDM_CHALLENGE,
+	};
+
+	rc = spdm_exchange(spdm_state, &spdm_ex);
+	if (rc < 0)
+		goto err_free_rsp;
+	length = rc;
+
+	/* Last step of building the digest */
+	rc = crypto_shash_update(spdm_state->desc, (u8 *)&req, sizeof(req));
+	if (rc)
+		goto err_free_rsp;
+
+	/* The hash is complete + signature received; verify against leaf key */
+	sig_offset = spdm_challenge_rsp_signature_offset(spdm_state, &req, rsp);
+	if (sig_offset >= length) {
+		rc = -EIO;
+		goto err_free_rsp;
+	}
+
+	rc = crypto_shash_update(spdm_state->desc, (u8 *)rsp, sig_offset);
+	if (rc)
+		goto err_free_rsp;
+
+	digest = kmalloc(spdm_state->h, GFP_KERNEL);
+	if (!digest) {
+		rc = -ENOMEM;
+		goto err_free_rsp;
+	}
+
+	crypto_shash_final(spdm_state->desc, digest);
+	if (spdm_state->version >= 0x12) {
+		message = kmalloc(spdm_state->h + sizeof(spdm_prefix), GFP_KERNEL);
+		memcpy(message, spdm_prefix, sizeof(spdm_prefix));
+		memcpy(message + sizeof(spdm_prefix), digest, spdm_state->h);
+		/*
+		 * Not all 1.2 supported Asymmetric functions need this hashed
+		 * but all the ones supported here do.
+		 */
+		rc = crypto_shash_digest(spdm_state->desc, message,
+					 spdm_state->h + sizeof(spdm_prefix), digest);
+		if (rc) {
+			dev_err(spdm_state->dev, "Could not digest prefix + message\n");
+			kfree(message);
+			goto err_free_digest;
+		}
+	}
+
+	rc = spdm_verify_signature(spdm_state, (u8 *)rsp + sig_offset, digest,
+				   spdm_state->h);
+	if (rc) {
+		dev_err(spdm_state->dev, "Failed to verify SPDM challenge auth signature\n");
+		goto err_free_digest;
+	}
+
+	kfree(spdm_state->desc);
+
+	/* Clear to give a simple way to detect out of order */
+	spdm_state->desc = NULL;
+
+err_free_digest:
+	kfree(digest);
+
+err_free_rsp:
+	kfree(rsp);
+	return rc;
+}
+
+int spdm_authenticate(struct spdm_state *spdm_state)
+{
+	u32 req_caps, rsp_caps;
+	int rc;
+
+	rc = spdm_get_version(spdm_state, 0x11);
+	if (rc)
+		return rc;
+
+	/* TODO: work out if a subset of these is fine for CMA */
+	req_caps = SPDM_GET_CAP_FLAG_CERT_CAP |
+		SPDM_GET_CAP_FLAG_CHAL_CAP |
+		SPDM_GET_CAP_FLAG_ENCRYPT_CAP |
+		SPDM_GET_CAP_FLAG_MAC_CAP |
+		SPDM_GET_CAP_FLAG_MUT_AUTH_CAP |
+		SPDM_GET_CAP_FLAG_KEY_EX_CAP |
+		FIELD_PREP(SPDM_GET_CAP_FLAG_PSK_CAP_MSK, SPDM_GET_CAP_FLAG_PSK_CAP_PRESHARE) |
+		SPDM_GET_CAP_FLAG_ENCAP_CAP |
+		SPDM_GET_CAP_FLAG_HBEAT_CAP |
+		SPDM_GET_CAP_FLAG_KEY_UPD_CAP |
+		SPDM_GET_CAP_FLAG_HANDSHAKE_ITC_CAP;
+
+	rc = spdm_negotiate_caps(spdm_state, req_caps, &rsp_caps);
+	if (rc)
+		return rc;
+
+	rc = spdm_negotiate_algs(spdm_state);
+	if (rc)
+		return rc;
+
+	/* At this point we know the hash so can start calculating it as we go */
+	rc = spdm_get_digests(spdm_state);
+	if (rc)
+		goto err_free_hash;
+
+	rc = spdm_get_certificate(spdm_state);
+	if (rc)
+		goto err_free_hash;
+
+	rc = spdm_challenge(spdm_state);
+	if (rc)
+		goto err_free_hash;
+
+	/*
+	 * If we get to here, we have successfully verified the device is one we are happy
+	 * with using.
+	 */
+	return 0;
+
+err_free_hash:
+	kfree(spdm_state->desc);
+	crypto_free_shash(spdm_state->shash);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(spdm_authenticate);
+
+struct spdm_state *spdm_create(int (*transport_ex)(void *priv, struct spdm_exchange *spdm_ex),
+			       void *priv, struct device *dev, struct key *keyring)
+{
+	struct spdm_state *spdm_state = kzalloc(sizeof(*spdm_state), GFP_KERNEL);
+
+	spdm_state->transport_ex = transport_ex;
+	spdm_state->transport_priv = priv;
+	spdm_state->dev = dev;
+	spdm_state->root_keyring = keyring;
+
+	return spdm_state;
+}
+EXPORT_SYMBOL_GPL(spdm_create);
+
+MODULE_LICENSE("GPL");
-- 
2.32.0

