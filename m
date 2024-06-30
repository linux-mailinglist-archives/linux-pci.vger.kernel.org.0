Return-Path: <linux-pci+bounces-9476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B61891D3D5
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 22:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503722815E4
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 20:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5DF13B59F;
	Sun, 30 Jun 2024 20:21:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BA3200C1;
	Sun, 30 Jun 2024 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719778868; cv=none; b=ZeOWf6LIKivpb0yGfFt6ktsAGmkQJUPtSn+JzF7ZYBRIjfiP0kmx/o8Ub6mq+8rtntFO11pkf5umoxmMsKjK7Nt6VxWroRz27h+OaAYMMxgekqYg/Q4wS0+jWyJrt4guls6m0GqqBSeZ66B7vOezD4WcA/mLomLhIceS4vH8Feo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719778868; c=relaxed/simple;
	bh=CPgj1RfUGYgIviDjTRnmjQ+0x79DBonimbQcZUHKa2k=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=B/3eFs5PEWTmGAsekUOkJkX/nKNFhcNUqam/R2hgr4fr1cLChCzkcizwyL0hsV0qc47SXXnunbiwmOqzp1MXasw5Op56HHN+jyrqly/OJFxzfqxCkYPyL053wbMeOFo7wDJpPCyzTvLd49rJ+0oKczKyn5x9LGySbYRYseyZqx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 3DEE910190FA3;
	Sun, 30 Jun 2024 22:21:04 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 088F061DA805;
	Sun, 30 Jun 2024 22:21:04 +0200 (CEST)
X-Mailbox-Line: From 8504d6303fac89d2d3a9c0661176d9cd1bb676fe Mon Sep 17 00:00:00 2001
Message-ID: <8504d6303fac89d2d3a9c0661176d9cd1bb676fe.1719771133.git.lukas@wunner.de>
In-Reply-To: <cover.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 30 Jun 2024 21:44:00 +0200
Subject: [PATCH v2 09/18] PCI/CMA: Validate Subject Alternative Name in
 certificates
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Cc: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair Francis <alistair.francis@wdc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, "Damien Le Moal" <dlemoal@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

PCIe r6.1 sec 6.31.3 stipulates requirements for Leaf Certificates
presented by devices, in particular the presence of a Subject Alternative
Name which encodes the Vendor ID, Device ID, Device Serial Number, etc.

This prevents a mismatch between the device identity in Config Space and
the certificate.  A device cannot misappropriate a certificate from a
different device without also spoofing Config Space.  As a corollary,
it cannot dupe an arbitrary driver into binding to it.  Only drivers
which bind to the device identity in the Subject Alternative Name work
(PCIe r6.1 sec 6.31 "Implementation Note: Overview of Threat Model").

The Subject Alternative Name is signed, hence constitutes a signed copy
of a Config Space portion.  It's the same concept as web certificates
which contain a set of domain names in the Subject Alternative Name for
identity verification.

Parse the Subject Alternative Name using a small ASN.1 module and
validate its contents.  The theory of operation is explained in a
comment at the top of the newly inserted code.

This functionality is introduced in a separate commit on top of basic
CMA-SPDM support to split the code into digestible, reviewable chunks.

The CMA OID added here is taken from the official OID Repository
(it's not documented in the PCIe Base Spec):
https://oid-rep.orange-labs.fr/get/2.23.147

Side notes:

* PCIe r6.2 removes the spec language on the Subject Alternative Name.
  It still "requires the leaf certificate to include the information
  typically used by system software for device driver binding", but no
  longer specifies how that information is encoded into the certificate.

  According to the editor of the PCIe Base Spec and the author of the
  CMA 1.1 ECN (which caused this change), FPGA cards which mutate their
  device identity at runtime (due to a firmware update) were thought as
  unable to satisfy the previous spec language.  The Protocol Working
  Group could not agree on a better solution and therefore dropped the
  spec language entirely.  They acknowledge that the requirement is now
  under-spec'd.  Because products already exist which adhere to the
  Subject Alternative Name requirement per PCIe r6.1 sec 6.31.3, they
  recommended to "push through" and use it as the de facto standard.

  The FPGA concerns are easily overcome by reauthenticating the device
  after a firmware update, either via sysfs or pci_cma_reauthenticate()
  (added by a subsequent commit).

* PCIe r6.1 sec 6.31.3 strongly recommends to verify that "the
  information provided in the Subject Alternative Name entry is signed
  by the vendor indicated by the Vendor ID."  In other words, the root
  certificate on pci_cma_keyring which signs the device's certificate
  chain must have been created for a particular Vendor ID.

  Unfortunately the spec neglects to define how the Vendor ID shall be
  encoded into the root certificate.  So the recommendation cannot be
  implemented at this point and it is thus possible that a vendor signs
  device certificates of a different vendor.

* Instead of a Subject Alternative Name, Leaf Certificates may include
  "a Reference Integrity Manifest, e.g., see Trusted Computing Group" or
  "a pointer to a location where such a Reference Integrity Manifest can
  be obtained" (PCIe r6.1 sec 6.31.3).

  A Reference Integrity Manifest contains "golden" measurements which
  can be compared to actual measurements retrieved from a device.
  It serves a different purpose than the Subject Alternative Name,
  hence it is unclear why the spec says only either of them is necessary.
  It is also unclear how a Reference Integrity Manifest shall be encoded
  into a certificate.

  Hence ignore the Reference Integrity Manifest requirement.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # except ASN.1
---
 drivers/pci/Makefile         |   4 +-
 drivers/pci/cma.asn1         |  41 ++++++++++++
 drivers/pci/cma.c            | 124 ++++++++++++++++++++++++++++++++++-
 include/linux/oid_registry.h |   3 +
 include/linux/spdm.h         |   6 +-
 lib/spdm/core.c              |   5 +-
 lib/spdm/req-authenticate.c  |   6 ++
 lib/spdm/spdm.h              |   2 +
 8 files changed, 187 insertions(+), 4 deletions(-)
 create mode 100644 drivers/pci/cma.asn1

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 6bcfeb698961..5921a0d56104 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -35,7 +35,9 @@ obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 
-obj-$(CONFIG_PCI_CMA)		+= cma.o
+obj-$(CONFIG_PCI_CMA)		+= cma.o cma.asn1.o
+$(obj)/cma.o:			$(obj)/cma.asn1.h
+$(obj)/cma.asn1.o:		$(obj)/cma.asn1.c $(obj)/cma.asn1.h
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
diff --git a/drivers/pci/cma.asn1 b/drivers/pci/cma.asn1
new file mode 100644
index 000000000000..da41421d4085
--- /dev/null
+++ b/drivers/pci/cma.asn1
@@ -0,0 +1,41 @@
+-- SPDX-License-Identifier: BSD-3-Clause
+--
+-- Component Measurement and Authentication (CMA-SPDM, PCIe r6.1 sec 6.31.3)
+-- X.509 Subject Alternative Name (RFC 5280 sec 4.2.1.6)
+--
+-- Copyright (C) 2008 IETF Trust and the persons identified as authors
+-- of the code
+--
+-- https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.6
+--
+-- The ASN.1 module in RFC 5280 appendix A.1 uses EXPLICIT TAGS whereas the one
+-- in appendix A.2 uses IMPLICIT TAGS.  The kernel's simplified asn1_compiler.c
+-- always uses EXPLICIT TAGS, hence this ASN.1 module differs from RFC 5280 in
+-- that it adds IMPLICIT to definitions from appendix A.2 (such as GeneralName)
+-- and omits EXPLICIT in those definitions.
+
+SubjectAltName ::= GeneralNames
+
+GeneralNames ::= SEQUENCE OF GeneralName
+
+GeneralName ::= CHOICE {
+	otherName			[0] IMPLICIT OtherName,
+	rfc822Name			[1] IMPLICIT IA5String,
+	dNSName				[2] IMPLICIT IA5String,
+	x400Address			[3] ANY,
+	directoryName			[4] ANY,
+	ediPartyName			[5] IMPLICIT EDIPartyName,
+	uniformResourceIdentifier	[6] IMPLICIT IA5String,
+	iPAddress			[7] IMPLICIT OCTET STRING,
+	registeredID			[8] IMPLICIT OBJECT IDENTIFIER
+	}
+
+OtherName ::= SEQUENCE {
+	type-id			OBJECT IDENTIFIER ({ pci_cma_note_oid }),
+	value			[0] ANY ({ pci_cma_note_san })
+	}
+
+EDIPartyName ::= SEQUENCE {
+	nameAssigner		[0] ANY OPTIONAL,
+	partyName		[1] ANY
+	}
diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
index 275338b95640..e974d489c7a2 100644
--- a/drivers/pci/cma.c
+++ b/drivers/pci/cma.c
@@ -10,16 +10,137 @@
 
 #define dev_fmt(fmt) "CMA: " fmt
 
+#include <keys/x509-parser.h>
+#include <linux/asn1_decoder.h>
+#include <linux/oid_registry.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/pm_runtime.h>
 #include <linux/spdm.h>
 
+#include "cma.asn1.h"
 #include "pci.h"
 
 /* Keyring that userspace can poke certs into */
 static struct key *pci_cma_keyring;
 
+/*
+ * The spdm_requester.c library calls pci_cma_validate() to check requirements
+ * for Leaf Certificates per PCIe r6.1 sec 6.31.3.
+ *
+ * pci_cma_validate() parses the Subject Alternative Name using the ASN.1
+ * module cma.asn1, which calls pci_cma_note_oid() and pci_cma_note_san()
+ * to compare an OtherName against the expected name.
+ *
+ * The expected name is constructed beforehand by pci_cma_construct_san().
+ *
+ * PCIe r6.2 drops the Subject Alternative Name spec language, even though
+ * it continues to require "the leaf certificate to include the information
+ * typically used by system software for device driver binding".  Use the
+ * Subject Alternative Name per PCIe r6.1 for lack of a replacement and
+ * because it is the de facto standard among existing products.
+ */
+#define CMA_NAME_MAX sizeof("Vendor=1234:Device=1234:CC=123456:"	  \
+			    "REV=12:SSVID=1234:SSID=1234:1234567890123456")
+
+struct pci_cma_x509_context {
+	struct pci_dev *pdev;
+	u8 slot;
+	enum OID last_oid;
+	char expected_name[CMA_NAME_MAX];
+	unsigned int expected_len;
+	unsigned int found:1;
+};
+
+int pci_cma_note_oid(void *context, size_t hdrlen, unsigned char tag,
+		     const void *value, size_t vlen)
+{
+	struct pci_cma_x509_context *ctx = context;
+
+	ctx->last_oid = look_up_OID(value, vlen);
+
+	return 0;
+}
+
+int pci_cma_note_san(void *context, size_t hdrlen, unsigned char tag,
+		     const void *value, size_t vlen)
+{
+	struct pci_cma_x509_context *ctx = context;
+
+	/* These aren't the drOIDs we're looking for. */
+	if (ctx->last_oid != OID_CMA)
+		return 0;
+
+	if (tag != ASN1_UTF8STR ||
+	    vlen != ctx->expected_len ||
+	    memcmp(value, ctx->expected_name, vlen) != 0) {
+		pci_err(ctx->pdev, "Leaf certificate of slot %u "
+			"has invalid Subject Alternative Name\n", ctx->slot);
+		return -EINVAL;
+	}
+
+	ctx->found = true;
+
+	return 0;
+}
+
+static unsigned int pci_cma_construct_san(struct pci_dev *pdev, char *name)
+{
+	unsigned int len;
+	u64 serial;
+
+	len = snprintf(name, CMA_NAME_MAX,
+		       "Vendor=%04hx:Device=%04hx:CC=%06x:REV=%02hhx",
+		       pdev->vendor, pdev->device, pdev->class, pdev->revision);
+
+	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL)
+		len += snprintf(name + len, CMA_NAME_MAX - len,
+				":SSVID=%04hx:SSID=%04hx",
+				pdev->subsystem_vendor, pdev->subsystem_device);
+
+	serial = pci_get_dsn(pdev);
+	if (serial)
+		len += snprintf(name + len, CMA_NAME_MAX - len,
+				":%016llx", serial);
+
+	return len;
+}
+
+static int pci_cma_validate(struct device *dev, u8 slot,
+			    struct x509_certificate *leaf_cert)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_cma_x509_context ctx;
+	int ret;
+
+	if (!leaf_cert->raw_san) {
+		pci_err(pdev, "Leaf certificate of slot %u "
+			"has no Subject Alternative Name\n", slot);
+		return -EINVAL;
+	}
+
+	ctx.pdev = pdev;
+	ctx.slot = slot;
+	ctx.found = false;
+	ctx.expected_len = pci_cma_construct_san(pdev, ctx.expected_name);
+
+	ret = asn1_ber_decoder(&cma_decoder, &ctx, leaf_cert->raw_san,
+			       leaf_cert->raw_san_size);
+	if (ret == -EBADMSG || ret == -EMSGSIZE)
+		pci_err(pdev, "Leaf certificate of slot %u "
+			"has malformed Subject Alternative Name\n", slot);
+	if (ret < 0)
+		return ret;
+
+	if (!ctx.found) {
+		pci_err(pdev, "Leaf certificate of slot %u "
+			"has no OtherName with CMA OID\n", slot);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 #define PCI_DOE_FEATURE_CMA 1
 
 static ssize_t pci_doe_transport(void *priv, struct device *dev,
@@ -62,7 +183,8 @@ void pci_cma_init(struct pci_dev *pdev)
 		return;
 
 	pdev->spdm_state = spdm_create(&pdev->dev, pci_doe_transport, doe,
-				       PCI_DOE_MAX_PAYLOAD, pci_cma_keyring);
+				       PCI_DOE_MAX_PAYLOAD, pci_cma_keyring,
+				       pci_cma_validate);
 	if (!pdev->spdm_state)
 		return;
 
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 6f9242259edc..44679f0a3fd6 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -145,6 +145,9 @@ enum OID {
 	OID_id_rsassa_pkcs1_v1_5_with_sha3_384, /* 2.16.840.1.101.3.4.3.15 */
 	OID_id_rsassa_pkcs1_v1_5_with_sha3_512, /* 2.16.840.1.101.3.4.3.16 */
 
+	/* PCI */
+	OID_CMA,			/* 2.23.147 */
+
 	OID__NR
 };
 
diff --git a/include/linux/spdm.h b/include/linux/spdm.h
index 0da7340020c4..568c68b17f1f 100644
--- a/include/linux/spdm.h
+++ b/include/linux/spdm.h
@@ -17,14 +17,18 @@
 struct key;
 struct device;
 struct spdm_state;
+struct x509_certificate;
 
 typedef ssize_t (spdm_transport)(void *priv, struct device *dev,
 				 const void *request, size_t request_sz,
 				 void *response, size_t response_sz);
 
+typedef int (spdm_validate)(struct device *dev, u8 slot,
+			    struct x509_certificate *leaf_cert);
+
 struct spdm_state *spdm_create(struct device *dev, spdm_transport *transport,
 			       void *transport_priv, u32 transport_sz,
-			       struct key *keyring);
+			       struct key *keyring, spdm_validate *validate);
 
 int spdm_authenticate(struct spdm_state *spdm_state);
 
diff --git a/lib/spdm/core.c b/lib/spdm/core.c
index f06402f6d127..be063b4fe73b 100644
--- a/lib/spdm/core.c
+++ b/lib/spdm/core.c
@@ -380,12 +380,14 @@ void spdm_reset(struct spdm_state *spdm_state)
  * @transport_priv: Transport private data
  * @transport_sz: Maximum message size the transport is capable of (in bytes)
  * @keyring: Trusted root certificates
+ * @validate: Function to validate additional leaf certificate requirements
+ *	(optional, may be %NULL)
  *
  * Return a pointer to the allocated SPDM session state or NULL on error.
  */
 struct spdm_state *spdm_create(struct device *dev, spdm_transport *transport,
 			       void *transport_priv, u32 transport_sz,
-			       struct key *keyring)
+			       struct key *keyring, spdm_validate *validate)
 {
 	struct spdm_state *spdm_state = kzalloc(sizeof(*spdm_state), GFP_KERNEL);
 
@@ -397,6 +399,7 @@ struct spdm_state *spdm_create(struct device *dev, spdm_transport *transport,
 	spdm_state->transport_priv = transport_priv;
 	spdm_state->transport_sz = transport_sz;
 	spdm_state->root_keyring = keyring;
+	spdm_state->validate = validate;
 
 	mutex_init(&spdm_state->lock);
 
diff --git a/lib/spdm/req-authenticate.c b/lib/spdm/req-authenticate.c
index 51fdb88f519b..90f7a7f2629c 100644
--- a/lib/spdm/req-authenticate.c
+++ b/lib/spdm/req-authenticate.c
@@ -537,6 +537,12 @@ static int spdm_validate_cert_chain(struct spdm_state *spdm_state, u8 slot)
 		offset += length;
 	} while (offset < total_length);
 
+	if (spdm_state->validate) {
+		rc = spdm_state->validate(spdm_state->dev, slot, prev);
+		if (rc)
+			return rc;
+	}
+
 	/* Steal pub pointer ahead of x509_free_certificate() */
 	spdm_state->leaf_key = prev->pub;
 	prev->pub = NULL;
diff --git a/lib/spdm/spdm.h b/lib/spdm/spdm.h
index 3a104959ad53..0e3bb6e18d91 100644
--- a/lib/spdm/spdm.h
+++ b/lib/spdm/spdm.h
@@ -455,6 +455,7 @@ struct spdm_error_rsp {
  *	responder's signatures.
  * @root_keyring: Keyring against which to check the first certificate in
  *	responder's certificate chain.
+ * @validate: Function to validate additional leaf certificate requirements.
  * @transcript: Concatenation of all SPDM messages exchanged during an
  *	authentication sequence.  Used to verify the signature, as it is
  *	computed over the hashed transcript.
@@ -495,6 +496,7 @@ struct spdm_state {
 	size_t slot_sz[SPDM_SLOTS];
 	struct public_key *leaf_key;
 	struct key *root_keyring;
+	spdm_validate *validate;
 
 	/* Transcript */
 	void *transcript;
-- 
2.43.0


