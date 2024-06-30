Return-Path: <linux-pci+bounces-9482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EFB91D3EE
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 22:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321C41F2142C
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 20:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308AC153BE2;
	Sun, 30 Jun 2024 20:28:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E2152E05;
	Sun, 30 Jun 2024 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719779314; cv=none; b=uXAphZymfF+KVy8j4ubqt6C68/oQpsFcV5spvc6Rq2j9dPajih1qPYfQebg169fE1aoqqzyyOUj7+6Q0fspI4Mukm6Zd/JuWD8+kalrZSUpXpIrqEY/Za9yAjWKMxGQZ+dR9Zk76VEGZ8RBSYkS3Sb91IfRxwx75zYLzBuCGdNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719779314; c=relaxed/simple;
	bh=w0w53+Evs2iGKvfuEtkfl1TtQsKoyxMLqWTEZZGNyG8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=gWyFTZB2VSjp8auXp+yQWwVsNiwjkXJyE/pP4HLXfWHhSTizK+3ltzl/JNysh4+MvDfN981RupbzW8+Bl4MDUCdXAC4h6Omr/PGAiAnhetOhbiblH7VRPkV3ymtB2y6qvCQZvmfQedRbH7WCtK+pvT96sWQ8i4PmL7Nn6mHcHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 2703310189C6B;
	Sun, 30 Jun 2024 22:28:28 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id E657F61DA805;
	Sun, 30 Jun 2024 22:28:27 +0200 (CEST)
X-Mailbox-Line: From 77f549685f994981c010aebb1e9057aa3555b18a Mon Sep 17 00:00:00 2001
Message-ID: <77f549685f994981c010aebb1e9057aa3555b18a.1719771133.git.lukas@wunner.de>
In-Reply-To: <cover.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 30 Jun 2024 21:50:00 +0200
Subject: [PATCH v2 15/18] PCI/CMA: Expose a log of received signatures in
 sysfs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Cc: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair Francis <alistair.francis@wdc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, "Damien Le Moal" <dlemoal@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>

When authenticating a device with CMA-SPDM, the kernel verifies the
challenge-response received from the device, but otherwise keeps it to
itself.

James Bottomley contends that's not good enough because user space or a
remote attestation service may want to re-verify the challenge-response:
Either because it mistrusts the kernel or because the kernel is unaware
of policy constraints that user space or the remote attestation service
want to apply.

Facilitate such use cases by exposing a log in sysfs which consists of
several files for each challenge-response event.  The files are prefixed
with a monotonically increasing number, starting at 0:

/sys/devices/.../signatures/0_signature
/sys/devices/.../signatures/0_transcript
/sys/devices/.../signatures/0_requester_nonce
/sys/devices/.../signatures/0_responder_nonce
/sys/devices/.../signatures/0_hash_algorithm
/sys/devices/.../signatures/0_combined_spdm_prefix
/sys/devices/.../signatures/0_certificate_chain
/sys/devices/.../signatures/0_type

The 0_signature is computed over the 0_transcript (a concatenation of
all SPDM messages exchanged with the device).

To verify the signature, 0_transcript is hashed with 0_hash_algorithm
(e.g. "sha384") and prefixed by 0_combined_spdm_prefix.

The public key to verify the signature against is the leaf certificate
contained in 0_certificate_chain.

The nonces chosen by requester and responder are exposed as separate
attributes to ease verification of their freshness.  They're already
contained in the transcript but their offsets within the transcript are
variable, so user space would otherwise have to parse the SPDM messages
in the transcript to find the nonces.

The type attribute contains the event type:  Currently it is always
"responder-challenge_auth signing".  In the future it may also contain
"responder-measurements signing".

This custom log format was chosen for lack of a better alternative.
Although the TCG PFP Specification defines DEVICE_SECURITY_EVENT_DATA
structures, those structures do not store the transcript (which can be
a few kBytes or up to several MBytes in size).  They do store nonces,
hence at least allow for verification of nonce freshness.  But without
the transcript, user space cannot verify the signature:

https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/

Exposing the transcript as an attribute of its own has the benefit that
it can directly be fed into a protocol dissector for debugging purposes
(think Wireshark).

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jérôme Glisse <jglisse@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/ABI/testing/sysfs-devices-spdm | 118 +++++++
 drivers/pci/cma.c                            |   6 +
 drivers/pci/pci-sysfs.c                      |   1 +
 drivers/pci/pci.h                            |   2 +
 drivers/pci/probe.c                          |   2 +
 include/linux/spdm.h                         |   6 +
 lib/spdm/core.c                              |   2 +
 lib/spdm/req-authenticate.c                  |   9 +-
 lib/spdm/req-sysfs.c                         | 333 +++++++++++++++++++
 lib/spdm/spdm.h                              |  20 ++
 10 files changed, 498 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-spdm b/Documentation/ABI/testing/sysfs-devices-spdm
index ed61405770d6..ae7b3f701ded 100644
--- a/Documentation/ABI/testing/sysfs-devices-spdm
+++ b/Documentation/ABI/testing/sysfs-devices-spdm
@@ -78,3 +78,121 @@ Description:
 		SPDM does not specify how to notify the kernel of such events,
 		so unless reauthentication is manually initiated to update the
 		kernel's cache, the "slot[0-7]" files may contain stale data.
+
+
+What:		/sys/devices/.../signatures/
+What:		/sys/devices/.../signatures/[0-9]*_signature
+What:		/sys/devices/.../signatures/[0-9]*_transcript
+What:		/sys/devices/.../signatures/[0-9]*_hash_algorithm
+What:		/sys/devices/.../signatures/[0-9]*_combined_spdm_prefix
+What:		/sys/devices/.../signatures/[0-9]*_certificate_chain
+Date:		June 2024
+Contact:	Lukas Wunner <lukas@wunner.de>
+Description:
+		The "signatures" directory contains a log of signatures
+		received from the device to allow for their re-verification.
+		It is meant for remote attestation services which do not trust
+		the kernel to have verified the signatures correctly or which
+		want to apply policy constraints of their own.
+
+		Each signature is exposed as a separate file.  The filename
+		is prefixed with a monotonically increasing, unsigned, 32 bit
+		number, starting at 0.
+
+		The signature is computed over the "transcript" file, which is
+		a concatenation of all SPDM messages exchanged with the device.
+		SPDM 1.2 and newer hash the transcript with "hash_algorithm"
+		and prepend the "combined_spdm_prefix" before computing the
+		signature (SPDM 1.2.0 sec 15).  For SPDM 1.0 and 1.1, that step
+		is omitted and "combined_spdm_prefix" is an empty file.
+
+		The signature is verified against the leaf certificate in the
+		"certificate_chain".  To save memory, "certificate_chain" is
+		a symbolic link to the slot used for signature generation.
+		If the slot has since been provisioned with a different
+		certificate chain, verification of the signature will fail.
+
+		In bash syntax, the signature is verified as follows::
+
+		 # number of signature to verify
+		 num=0
+
+		 # split certificate chain into individual certificates
+		 openssl storeutl -text ${num}_certificate_chain | \
+		     csplit -z -f /tmp/cert - '/^[0-9]*: Certificate$/' '{*}'
+
+		 # extract public key from leaf certificate
+		 leaf_cert=$(\ls /tmp/cert?? | tail -1)
+		 openssl x509 -pubkey -in ${leaf_cert} -out ${leaf_cert}.pub
+
+		 # verify signature
+		 if [ \! -s ${num}_combined_spdm_prefix ] ; then
+		     # SPDM 1.0 and 1.1
+		     openssl dgst -$(cat ${num}_hash_algorithm) \
+		         -signature ${num}_signature -verify ${leaf_cert}.pub \
+		         ${num}_transcript
+		 else
+		     # SPDM 1.2 and newer
+		     openssl dgst -$(cat ${num}_hash_algorithm) \
+		         -binary -out /tmp/transcript_hashed ${num}_transcript
+		     openssl dgst -$(cat ${num}_hash_algorithm) \
+		         -signature ${num}_signature -verify ${leaf_cert}.pub \
+		         ${num}_combined_spdm_prefix /tmp/transcript_hashed
+		 fi
+
+		Note: The above works for RSA signatures, but not for ECDSA.
+		SPDM encodes ECDSA signatures in P1363 format (concatenation of
+		two raw integers), whereas openssl only supports X9.62 format
+		(ASN.1 DER sequence of two integers).  There is no command line
+		utility to convert between the two formats, but most popular
+		crypto libraries offer conversion routines:
+
+		| https://github.com/java-crypto/cross_platform_crypto/blob/main/docs/ecdsa_signature_conversion.md
+
+		The "transcript" file can be fed to a protocol dissector to
+		examine the SPDM messages it contains:
+
+		| https://github.com/th-duvanel/spdm-wid
+		| https://github.com/jyao1/wireshark-spdm
+		| https://github.com/DMTF/spdm-dump
+
+		Note:  To ease signature verification, the "transcript" file
+		does not contain the trailing signature.  However the signature
+		is part of the final CHALLENGE_AUTH message, so the protocol
+		dissector needs to be fed the concatenation of "transcript"
+		and "signature".
+
+
+What:		/sys/devices/.../signatures/[0-9]*_type
+Date:		June 2024
+Contact:	Lukas Wunner <lukas@wunner.de>
+Description:
+		This file contains the type of event that led to signature
+		generation.  It is one of (sans quotes):
+
+		"responder-challenge_auth signing"
+
+
+What:		/sys/devices/.../signatures/[0-9]*_requester_nonce
+What:		/sys/devices/.../signatures/[0-9]*_responder_nonce
+Date:		June 2024
+Contact:	Lukas Wunner <lukas@wunner.de>
+Description:
+		These files contain the 32 byte nonce chosen by requester and
+		responder.  They allow remote attestation services to verify
+		freshness (uniqueness) of the nonces.  Nonces used more than
+		once can be identified with::
+
+		 # hexdump -e '32/1 "%02x" "\n"' [0-9]*_nonce | sort | \
+		   uniq -c | grep -v '^      1'
+
+		Remote attestation services may also want to verify that the
+		entropy of the nonces is acceptable::
+
+		 # ent 0_requester_nonce
+
+		Note:  The nonces are also contained in the "transcript", but
+		their offsets within the transcript are variable.  It would be
+		necessary to parse the SPDM messages in the transcript to find
+		and extract the nonces, which is cumbersome.  That's why they
+		are exposed as separate files.
diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
index 59558714f143..e5d9ab5d646e 100644
--- a/drivers/pci/cma.c
+++ b/drivers/pci/cma.c
@@ -199,6 +199,12 @@ void pci_cma_init(struct pci_dev *pdev)
 	spdm_authenticate(pdev->spdm_state);
 }
 
+void pci_cma_publish(struct pci_dev *pdev)
+{
+	if (!IS_ERR_OR_NULL(pdev->spdm_state))
+		spdm_publish_log(pdev->spdm_state);
+}
+
 /**
  * pci_cma_reauthenticate() - Perform CMA-SPDM authentication again
  * @pdev: Device to reauthenticate
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index a85388211104..bf019371ef9a 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1665,6 +1665,7 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 #ifdef CONFIG_PCI_CMA
 	&spdm_attr_group,
 	&spdm_certificates_group,
+	&spdm_signatures_group,
 #endif
 	NULL,
 };
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0041d39ca089..452cbfcc0ca0 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -336,6 +336,7 @@ static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #ifdef CONFIG_PCI_CMA
 void pci_cma_init(struct pci_dev *pdev);
 void pci_cma_destroy(struct pci_dev *pdev);
+void pci_cma_publish(struct pci_dev *pdev);
 void pci_cma_reauthenticate(struct pci_dev *pdev);
 static inline void pci_cma_disable(struct pci_dev *pdev)
 {
@@ -344,6 +345,7 @@ static inline void pci_cma_disable(struct pci_dev *pdev)
 #else
 static inline void pci_cma_init(struct pci_dev *pdev) { }
 static inline void pci_cma_destroy(struct pci_dev *pdev) { }
+static inline void pci_cma_publish(struct pci_dev *pdev) { }
 static inline void pci_cma_reauthenticate(struct pci_dev *pdev) { }
 static inline void pci_cma_disable(struct pci_dev *pdev) { }
 #endif
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5297f9a08ca2..0493fc44da13 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2583,6 +2583,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->match_driver = false;
 	ret = device_add(&dev->dev);
 	WARN_ON(ret < 0);
+
+	pci_cma_publish(dev);
 }
 
 struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
diff --git a/include/linux/spdm.h b/include/linux/spdm.h
index 97c7d4feab76..cc8aa8f77368 100644
--- a/include/linux/spdm.h
+++ b/include/linux/spdm.h
@@ -34,7 +34,13 @@ int spdm_authenticate(struct spdm_state *spdm_state);
 
 void spdm_destroy(struct spdm_state *spdm_state);
 
+#ifdef CONFIG_SYSFS
 extern const struct attribute_group spdm_attr_group;
 extern const struct attribute_group spdm_certificates_group;
+extern const struct attribute_group spdm_signatures_group;
+void spdm_publish_log(struct spdm_state *spdm_state);
+#else
+static inline void spdm_publish_log(struct spdm_state *spdm_state) { }
+#endif
 
 #endif
diff --git a/lib/spdm/core.c b/lib/spdm/core.c
index be063b4fe73b..d962a1344760 100644
--- a/lib/spdm/core.c
+++ b/lib/spdm/core.c
@@ -402,6 +402,7 @@ struct spdm_state *spdm_create(struct device *dev, spdm_transport *transport,
 	spdm_state->validate = validate;
 
 	mutex_init(&spdm_state->lock);
+	INIT_LIST_HEAD(&spdm_state->log);
 
 	return spdm_state;
 }
@@ -420,6 +421,7 @@ void spdm_destroy(struct spdm_state *spdm_state)
 		kvfree(spdm_state->slot[slot]);
 
 	spdm_reset(spdm_state);
+	spdm_destroy_log(spdm_state);
 	mutex_destroy(&spdm_state->lock);
 	kfree(spdm_state);
 }
diff --git a/lib/spdm/req-authenticate.c b/lib/spdm/req-authenticate.c
index 1f701d07ad46..0c74dc0e5cf4 100644
--- a/lib/spdm/req-authenticate.c
+++ b/lib/spdm/req-authenticate.c
@@ -617,13 +617,13 @@ static size_t spdm_challenge_rsp_sz(struct spdm_state *spdm_state,
 
 static int spdm_challenge(struct spdm_state *spdm_state, u8 slot)
 {
+	size_t req_sz, rsp_sz, rsp_sz_max, req_nonce_off, rsp_nonce_off;
 	struct spdm_challenge_rsp *rsp __free(kfree);
 	struct spdm_challenge_req req = {
 		.code = SPDM_CHALLENGE,
 		.param1 = slot,
 		.param2 = 0, /* No measurement summary hash */
 	};
-	size_t req_sz, rsp_sz, rsp_sz_max;
 	int rc, length;
 
 	get_random_bytes(&req.nonce, sizeof(req.nonce));
@@ -649,10 +649,14 @@ static int spdm_challenge(struct spdm_state *spdm_state, u8 slot)
 		return -EIO;
 	}
 
+	req_nonce_off = spdm_state->transcript_end - spdm_state->transcript +
+			offsetof(typeof(req), nonce);
 	rc = spdm_append_transcript(spdm_state, &req, req_sz);
 	if (rc)
 		return rc;
 
+	rsp_nonce_off = spdm_state->transcript_end - spdm_state->transcript +
+			sizeof(*rsp) + spdm_state->hash_len;
 	rc = spdm_append_transcript(spdm_state, rsp, rsp_sz);
 	if (rc)
 		return rc;
@@ -666,6 +670,9 @@ static int spdm_challenge(struct spdm_state *spdm_state, u8 slot)
 		dev_info(spdm_state->dev,
 			 "Authenticated with certificate slot %u\n", slot);
 
+	spdm_create_log_entry(spdm_state, spdm_context, slot,
+			      req_nonce_off, rsp_nonce_off);
+
 	return rc;
 }
 
diff --git a/lib/spdm/req-sysfs.c b/lib/spdm/req-sysfs.c
index afba3c5a2e8f..d3c4ca7dbbaa 100644
--- a/lib/spdm/req-sysfs.c
+++ b/lib/spdm/req-sysfs.c
@@ -173,3 +173,336 @@ const struct attribute_group spdm_certificates_group = {
 	.bin_attrs = spdm_certificates_bin_attrs,
 	.is_bin_visible = spdm_certificates_are_visible,
 };
+
+/* signatures attributes */
+
+static struct bin_attribute *spdm_signatures_bin_attrs[] = {
+	NULL
+};
+
+const struct attribute_group spdm_signatures_group = {
+	.name = "signatures",
+	.bin_attrs = spdm_signatures_bin_attrs,
+};
+
+/**
+ * struct spdm_log_entry - log entry representing one received SPDM signature
+ *
+ * @list: List node.  Added to the @log list in struct spdm_state.
+ * @sig: sysfs attribute of received signature (located at end of transcript).
+ * @req_nonce: sysfs attribute of requester nonce (located within transcript).
+ * @rsp_nonce: sysfs attribute of responder nonce (located within transcript).
+ * @transcript: sysfs attribute of transcript (concatenation of all SPDM
+ *	messages exchanged during an authentication sequence) sans trailing
+ *	signature (to simplify signature verification by user space).
+ * @combined_prefix: sysfs attribute of combined_spdm_prefix
+ *	(SPDM 1.2.0 margin no 806, needed to verify signature).
+ * @spdm_context: sysfs attribute of spdm_context
+ *	(SPDM 1.2.0 margin no 803, needed to create combined_spdm_prefix).
+ * @hash_alg: sysfs attribute of hash algorithm (needed to verify signature).
+ * @sig_name: Name of @sig attribute (with prepended signature counter).
+ * @req_nonce_name: Name of @req_nonce attribute.
+ * @rsp_nonce_name: Name of @rsp_nonce attribute.
+ * @transcript_name: Name of @transcript attribute.
+ * @combined_prefix_name: Name of @combined_prefix attribute.
+ * @spdm_context_name: Name of @spdm_context attribute.
+ * @hash_alg_name: Name of @hash_alg attribute.
+ * @counter: Signature counter (needed to create certificate_chain symlink).
+ * @version: Negotiated SPDM version
+ *	(SPDM 1.2.0 margin no 803, needed to create combined_spdm_prefix).
+ * @slot: Slot which was used to generate the signature
+ *	(needed to create certificate_chain symlink).
+ */
+struct spdm_log_entry {
+	struct list_head list;
+	struct bin_attribute sig;
+	struct bin_attribute req_nonce;
+	struct bin_attribute rsp_nonce;
+	struct bin_attribute transcript;
+	struct bin_attribute combined_prefix;
+	struct dev_ext_attribute spdm_context;
+	struct dev_ext_attribute hash_alg;
+	char sig_name[sizeof(__stringify(UINT_MAX) "_signature")];
+	char req_nonce_name[sizeof(__stringify(UINT_MAX) "_requester_nonce")];
+	char rsp_nonce_name[sizeof(__stringify(UINT_MAX) "_responder_nonce")];
+	char transcript_name[sizeof(__stringify(UINT_MAX) "_transcript")];
+	char combined_prefix_name[sizeof(__stringify(UINT_MAX) "_combined_spdm_prefix")];
+	char spdm_context_name[sizeof(__stringify(UINT_MAX) "_type")];
+	char hash_alg_name[sizeof(__stringify(UINT_MAX) "_hash_algorithm")];
+	u32 counter;
+	u8 version;
+	u8 slot;
+};
+
+static void spdm_unpublish_log_entry(struct kobject *kobj,
+				     struct spdm_log_entry *log)
+{
+	const char *group = spdm_signatures_group.name;
+
+	sysfs_remove_bin_file_from_group(kobj, &log->sig, group);
+	sysfs_remove_bin_file_from_group(kobj, &log->req_nonce, group);
+	sysfs_remove_bin_file_from_group(kobj, &log->rsp_nonce, group);
+	sysfs_remove_bin_file_from_group(kobj, &log->transcript, group);
+	sysfs_remove_bin_file_from_group(kobj, &log->combined_prefix, group);
+	sysfs_remove_file_from_group(kobj, &log->spdm_context.attr.attr, group);
+	sysfs_remove_file_from_group(kobj, &log->hash_alg.attr.attr, group);
+
+	char cert_chain[sizeof(__stringify(UINT_MAX) "_certificate_chain")];
+	snprintf(cert_chain, sizeof(cert_chain), "%u_certificate_chain",
+		 log->counter);
+
+	sysfs_remove_link_from_group(kobj, group, cert_chain);
+}
+
+static void spdm_publish_log_entry(struct kobject *kobj,
+				   struct spdm_log_entry *log)
+{
+	const char *group = spdm_signatures_group.name;
+	int rc;
+
+	rc = sysfs_add_bin_file_to_group(kobj, &log->sig, group);
+	if (rc)
+		goto err;
+
+	rc = sysfs_add_bin_file_to_group(kobj, &log->req_nonce, group);
+	if (rc)
+		goto err;
+
+	rc = sysfs_add_bin_file_to_group(kobj, &log->rsp_nonce, group);
+	if (rc)
+		goto err;
+
+	rc = sysfs_add_bin_file_to_group(kobj, &log->transcript, group);
+	if (rc)
+		goto err;
+
+	rc = sysfs_add_bin_file_to_group(kobj, &log->combined_prefix, group);
+	if (rc)
+		goto err;
+
+	rc = sysfs_add_file_to_group(kobj, &log->spdm_context.attr.attr, group);
+	if (rc)
+		goto err;
+
+	rc = sysfs_add_file_to_group(kobj, &log->hash_alg.attr.attr, group);
+	if (rc)
+		goto err;
+
+	char cert_chain[sizeof(__stringify(UINT_MAX) "_certificate_chain")];
+	snprintf(cert_chain, sizeof(cert_chain), "%u_certificate_chain",
+		 log->counter);
+
+	char slot[sizeof("slot0")];
+	snprintf(slot, sizeof(slot), "slot%hhu", log->slot);
+
+	rc = sysfs_add_link_to_sibling_group(kobj, group, cert_chain,
+					     spdm_certificates_group.name,
+					     slot);
+	if (rc)
+		goto err;
+
+	return;
+
+err:
+	dev_err(kobj_to_dev(kobj),
+		"Failed to publish signature log entry in sysfs: %d\n", rc);
+	spdm_unpublish_log_entry(kobj, log);
+}
+
+static ssize_t spdm_read_combined_prefix(struct file *file,
+					 struct kobject *kobj,
+					 struct bin_attribute *attr,
+					 char *buf, loff_t off, size_t count)
+{
+	struct spdm_log_entry *log = attr->private;
+
+	/*
+	 * SPDM 1.0 and 1.1 do not add a combined prefix to the hash
+	 * before computing the signature, so return an empty file.
+	 */
+	if (log->version <= 0x11)
+		return 0;
+
+	void *tmp __free(kfree) = kmalloc(SPDM_COMBINED_PREFIX_SZ, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	spdm_create_combined_prefix(log->version, log->spdm_context.var, tmp);
+	memcpy(buf, tmp + off, count);
+	return count;
+}
+
+static void spdm_destroy_log_entry(struct spdm_log_entry *log)
+{
+	list_del(&log->list);
+	kvfree(log->transcript.private);
+	kfree(log);
+}
+
+/**
+ * spdm_create_log_entry() - Allocate log entry for one received SPDM signature
+ *
+ * @spdm_state: SPDM session state
+ * @spdm_context: SPDM context (needed to create combined_spdm_prefix)
+ * @slot: Slot which was used to generate the signature
+ *	(needed to create certificate_chain symlink)
+ * @req_nonce_off: Requester nonce offset within the transcript
+ * @rsp_nonce_off: Responder nonce offset within the transcript
+ *
+ * Allocate and populate a struct spdm_log_entry upon device authentication.
+ * Publish it in sysfs if the device has already been registered through
+ * device_add().
+ */
+void spdm_create_log_entry(struct spdm_state *spdm_state,
+			   const char *spdm_context, u8 slot,
+			   size_t req_nonce_off, size_t rsp_nonce_off)
+{
+	struct spdm_log_entry *log = kmalloc(sizeof(*log), GFP_KERNEL);
+	if (!log)
+		return;
+
+	*log = (struct spdm_log_entry) {
+		.slot		   = slot,
+		.version	   = spdm_state->version,
+		.counter	   = spdm_state->log_counter,
+		.list		   = LIST_HEAD_INIT(log->list),
+
+		.sig = {
+			.attr.name = log->sig_name,
+			.attr.mode = 0444,
+			.read	   = sysfs_bin_attr_simple_read,
+			.private   = spdm_state->transcript_end -
+				     spdm_state->sig_len,
+			.size	   = spdm_state->sig_len },
+
+		.req_nonce = {
+			.attr.name = log->req_nonce_name,
+			.attr.mode = 0444,
+			.read	   = sysfs_bin_attr_simple_read,
+			.private   = spdm_state->transcript + req_nonce_off,
+			.size	   = SPDM_NONCE_SZ },
+
+		.rsp_nonce = {
+			.attr.name = log->rsp_nonce_name,
+			.attr.mode = 0444,
+			.read	   = sysfs_bin_attr_simple_read,
+			.private   = spdm_state->transcript + rsp_nonce_off,
+			.size	   = SPDM_NONCE_SZ },
+
+		.transcript = {
+			.attr.name = log->transcript_name,
+			.attr.mode = 0444,
+			.read	   = sysfs_bin_attr_simple_read,
+			.private   = spdm_state->transcript,
+			.size	   = spdm_state->transcript_end -
+				     spdm_state->transcript -
+				     spdm_state->sig_len },
+
+		.combined_prefix = {
+			.attr.name = log->combined_prefix_name,
+			.attr.mode = 0444,
+			.read	   = spdm_read_combined_prefix,
+			.private   = log,
+			.size	   = spdm_state->version <= 0x11 ? 0 :
+				     SPDM_COMBINED_PREFIX_SZ },
+
+		.spdm_context = {
+			.attr.attr.name = log->spdm_context_name,
+			.attr.attr.mode = 0444,
+			.attr.show = device_show_string,
+			.var	   = (char *)spdm_context },
+
+		.hash_alg = {
+			.attr.attr.name = log->hash_alg_name,
+			.attr.attr.mode = 0444,
+			.attr.show = device_show_string,
+			.var	   = (char *)spdm_state->base_hash_alg_name },
+	};
+
+	snprintf(log->sig_name, sizeof(log->sig_name),
+		 "%u_signature", spdm_state->log_counter);
+	snprintf(log->req_nonce_name, sizeof(log->req_nonce_name),
+		 "%u_requester_nonce", spdm_state->log_counter);
+	snprintf(log->rsp_nonce_name, sizeof(log->rsp_nonce_name),
+		 "%u_responder_nonce", spdm_state->log_counter);
+	snprintf(log->transcript_name, sizeof(log->transcript_name),
+		 "%u_transcript", spdm_state->log_counter);
+	snprintf(log->combined_prefix_name, sizeof(log->combined_prefix_name),
+		 "%u_combined_spdm_prefix", spdm_state->log_counter);
+	snprintf(log->spdm_context_name, sizeof(log->spdm_context_name),
+		 "%u_type", spdm_state->log_counter);
+	snprintf(log->hash_alg_name, sizeof(log->hash_alg_name),
+		 "%u_hash_algorithm", spdm_state->log_counter);
+
+	sysfs_bin_attr_init(&log->sig);
+	sysfs_bin_attr_init(&log->req_nonce);
+	sysfs_bin_attr_init(&log->rsp_nonce);
+	sysfs_bin_attr_init(&log->transcript);
+	sysfs_bin_attr_init(&log->combined_prefix);
+	sysfs_attr_init(&log->spdm_context.attr.attr);
+	sysfs_attr_init(&log->hash_alg.attr.attr);
+
+	list_add_tail(&log->list, &spdm_state->log);
+	spdm_state->log_counter++;
+
+	/* Steal transcript pointer ahead of spdm_free_transcript() */
+	spdm_state->transcript = NULL;
+
+	if (device_is_registered(spdm_state->dev))
+		spdm_publish_log_entry(&spdm_state->dev->kobj, log);
+}
+
+/**
+ * spdm_publish_log() - Publish log of received SPDM signatures in sysfs
+ *
+ * @spdm_state: SPDM session state
+ *
+ * sysfs attributes representing received SPDM signatures are not static,
+ * but created dynamically upon authentication.  If a device was authenticated
+ * before it became visible in sysfs, the attributes could not be created.
+ * This function retroactively creates those attributes in sysfs after the
+ * device has become visible through device_add().
+ */
+void spdm_publish_log(struct spdm_state *spdm_state)
+{
+	struct kobject *kobj = &spdm_state->dev->kobj;
+	struct kernfs_node *grp_kn __free(kernfs_put);
+	struct spdm_log_entry *log;
+
+	grp_kn = kernfs_find_and_get(kobj->sd, spdm_signatures_group.name);
+	if (WARN_ON(!grp_kn))
+		return;
+
+	mutex_lock(&spdm_state->lock);
+	list_for_each_entry(log, &spdm_state->log, list) {
+		struct kernfs_node *sig_kn __free(kernfs_put);
+
+		/*
+		 * Skip over log entries created in-between device_add() and
+		 * spdm_publish_log() as they've already been published.
+		 */
+		sig_kn = kernfs_find_and_get(grp_kn, log->sig_name);
+		if (sig_kn)
+			continue;
+
+		spdm_publish_log_entry(kobj, log);
+	}
+	mutex_unlock(&spdm_state->lock);
+}
+EXPORT_SYMBOL_GPL(spdm_publish_log);
+
+/**
+ * spdm_destroy_log() - Destroy log of received SPDM signatures
+ *
+ * @spdm_state: SPDM session state
+ *
+ * Be sure to unregister the device through device_del() beforehand,
+ * which implicitly unpublishes the log in sysfs.
+ */
+void spdm_destroy_log(struct spdm_state *spdm_state)
+{
+	struct spdm_log_entry *log, *tmp;
+
+	list_for_each_entry_safe(log, tmp, &spdm_state->log, list)
+		spdm_destroy_log_entry(log);
+}
diff --git a/lib/spdm/spdm.h b/lib/spdm/spdm.h
index 6c426b2be372..a63c2922af5d 100644
--- a/lib/spdm/spdm.h
+++ b/lib/spdm/spdm.h
@@ -466,6 +466,10 @@ struct spdm_error_rsp {
  *	end of transcript.  If another message is transmitted, it is appended
  *	at this position.
  * @transcript_max: Allocation size of @transcript.  Multiple of PAGE_SIZE.
+ * @log: Linked list of past authentication events.  Each list entry is of type
+ *	struct spdm_log_entry and is exposed as several files in sysfs.
+ * @log_counter: Number of generated log entries so far.  Will be prefixed to
+ *	the sysfs files of the next generated log entry.
  */
 struct spdm_state {
 	struct device *dev;
@@ -506,6 +510,10 @@ struct spdm_state {
 	void *transcript;
 	void *transcript_end;
 	size_t transcript_max;
+
+	/* Signatures Log */
+	struct list_head log;
+	u32 log_counter;
 };
 
 ssize_t spdm_exchange(struct spdm_state *spdm_state,
@@ -523,4 +531,16 @@ int spdm_verify_signature(struct spdm_state *spdm_state,
 
 void spdm_reset(struct spdm_state *spdm_state);
 
+#ifdef CONFIG_SYSFS
+void spdm_create_log_entry(struct spdm_state *spdm_state,
+			   const char *spdm_context, u8 slot,
+			   size_t req_nonce_off, size_t rsp_nonce_off);
+void spdm_destroy_log(struct spdm_state *spdm_state);
+#else
+static inline void spdm_create_log_entry(struct spdm_state *spdm_state,
+			   const char *spdm_context, u8 slot,
+			   size_t req_nonce_off, size_t rsp_nonce_off) { }
+static inline void spdm_destroy_log(struct spdm_state *spdm_state) { }
+#endif
+
 #endif /* _LIB_SPDM_H_ */
-- 
2.43.0


