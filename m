Return-Path: <linux-pci+bounces-9474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C78791D3CA
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 22:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842AE1C209AB
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 20:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82968152534;
	Sun, 30 Jun 2024 20:17:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0BC4502B;
	Sun, 30 Jun 2024 20:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719778624; cv=none; b=jCav4IZO048lL1MjheWZAnC7gzIDoXgO5/uyqhpXm/63Gw4BI19+yohFRJ2BPhV9Bu4vdLgXu/JZXU4Z3hXWXcfh+X5Pv/g/TBnn80aTT0aZiHmzaEfeHldaVQel7iC8Jv5x0OjvjS/AQ9mmk1iDqlqCkcUQI7/ZsJ8d6e9CNkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719778624; c=relaxed/simple;
	bh=Qs1mfHeJyDecUsqRAC487DbyOatnnUDe1LTTh2ZRxSc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=e3HllTFHgbHqLJcIeGdV+9z4e6LAEV/YVMsJzdX6n7bgU+6coMCQInpFSYdJnfxRmn5Jsx8Iy/UqX0zRItokNuKfuNYedDSbnQJNHsE5318dPdDz4qFxXuPZDOfxKGU3J4ZZc1LluiyAdopWxSWDyQXMMFRC0B8kA04p5t9/E2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id A524410189C6B;
	Sun, 30 Jun 2024 22:16:57 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 5F05561DA805;
	Sun, 30 Jun 2024 22:16:57 +0200 (CEST)
X-Mailbox-Line: From bbbea6e1b7d27463243a0fcb871ad2953312fe3a Mon Sep 17 00:00:00 2001
Message-ID: <bbbea6e1b7d27463243a0fcb871ad2953312fe3a.1719771133.git.lukas@wunner.de>
In-Reply-To: <cover.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 30 Jun 2024 21:42:00 +0200
Subject: [PATCH v2 07/18] spdm: Introduce library to authenticate devices
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Cc: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair Francis <alistair.francis@wdc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, "Damien Le Moal" <dlemoal@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, Eric Biggers <ebiggers@google.com>, Stefan Berger <stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The Security Protocol and Data Model (SPDM) allows for device
authentication, measurement, key exchange and encrypted sessions.

SPDM was conceived by the Distributed Management Task Force (DMTF).
Its specification defines a request/response protocol spoken between
host and attached devices over a variety of transports:

  https://www.dmtf.org/dsp/DSP0274

This implementation supports SPDM 1.0 through 1.3 (the latest version).
It is designed to be transport-agnostic as the kernel already supports
four different SPDM-capable transports:

* PCIe Data Object Exchange, which is a mailbox in PCI config space
  (PCIe r6.2 sec 6.30, drivers/pci/doe.c)
* Management Component Transport Protocol
  (MCTP, Documentation/networking/mctp.rst)
* TCP/IP (in draft stage)
  https://www.dmtf.org/sites/default/files/standards/documents/DSP0287_1.0.0WIP99.pdf
* SCSI and ATA (in draft stage)
  "SECURITY PROTOCOL IN/OUT" and "TRUSTED SEND/RECEIVE" commands

Use cases for SPDM include, but are not limited to:

* PCIe Component Measurement and Authentication (PCIe r6.2 sec 6.31)
* Compute Express Link (CXL r3.0 sec 14.11.6)
* Open Compute Project (Attestation of System Components v1.0)
  https://www.opencompute.org/documents/attestation-v1-0-20201104-pdf
* Open Compute Project (Datacenter NVMe SSD Specification v2.0)
  https://www.opencompute.org/documents/datacenter-nvme-ssd-specification-v2-0r21-pdf

The initial focus of this implementation is enabling PCIe CMA device
authentication.  As such, only a subset of the SPDM specification is
contained herein, namely the request/response sequence GET_VERSION,
GET_CAPABILITIES, NEGOTIATE_ALGORITHMS, GET_DIGESTS, GET_CERTIFICATE
and CHALLENGE.

This sequence first negotiates the SPDM protocol version, capabilities
and algorithms with the device.  It then retrieves the up to eight
certificate chains which may be provisioned on the device.  Finally it
performs challenge-response authentication with the device using one of
those eight certificate chains and the algorithms negotiated before.
The challenge-response authentication comprises computing a hash over
all exchanged messages to detect modification by a man-in-the-middle
or media error.  The hash is then signed with the device's private key
and the resulting signature is verified by the kernel using the device's
public key from the certificate chain.  Nonces are included in the
message sequence to protect against replay attacks.

A simple API is provided for subsystems wishing to authenticate devices:
spdm_create(), spdm_authenticate() (can be called repeatedly for
reauthentication) and spdm_destroy().  Certificates presented by devices
are validated against an in-kernel keyring of trusted root certificates.
A pointer to the keyring is passed to spdm_create().

The set of supported cryptographic algorithms is limited to those
declared mandatory in PCIe r6.2 sec 6.31.3.  Adding more algorithms
is straightforward as long as the crypto subsystem supports them.

Future commits will extend this implementation with support for
measurement, key exchange and encrypted sessions.

So far, only the SPDM requester role is implemented.  Care was taken to
allow for effortless addition of the responder role at a later stage.
This could be needed for a PCIe host bridge operating in endpoint mode.
The responder role will be able to reuse struct definitions and helpers
such as spdm_create_combined_prefix().

Credits:  Jonathan wrote a proof-of-concept of this SPDM implementation.
Lukas reworked it for upstream.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-developed-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 MAINTAINERS                 |  11 +
 include/linux/spdm.h        |  33 ++
 lib/Kconfig                 |  15 +
 lib/Makefile                |   2 +
 lib/spdm/Makefile           |  10 +
 lib/spdm/core.c             | 425 ++++++++++++++++++++++
 lib/spdm/req-authenticate.c | 704 ++++++++++++++++++++++++++++++++++++
 lib/spdm/spdm.h             | 520 ++++++++++++++++++++++++++
 8 files changed, 1720 insertions(+)
 create mode 100644 include/linux/spdm.h
 create mode 100644 lib/spdm/Makefile
 create mode 100644 lib/spdm/core.c
 create mode 100644 lib/spdm/req-authenticate.c
 create mode 100644 lib/spdm/spdm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..dbe16eea8818 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20145,6 +20145,17 @@ M:	Security Officers <security@kernel.org>
 S:	Supported
 F:	Documentation/process/security-bugs.rst
 
+SECURITY PROTOCOL AND DATA MODEL (SPDM)
+M:	Jonathan Cameron <jic23@kernel.org>
+M:	Lukas Wunner <lukas@wunner.de>
+L:	linux-coco@lists.linux.dev
+L:	linux-cxl@vger.kernel.org
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
+F:	include/linux/spdm.h
+F:	lib/spdm/
+
 SECURITY SUBSYSTEM
 M:	Paul Moore <paul@paul-moore.com>
 M:	James Morris <jmorris@namei.org>
diff --git a/include/linux/spdm.h b/include/linux/spdm.h
new file mode 100644
index 000000000000..0da7340020c4
--- /dev/null
+++ b/include/linux/spdm.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DMTF Security Protocol and Data Model (SPDM)
+ * https://www.dmtf.org/dsp/DSP0274
+ *
+ * Copyright (C) 2021-22 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ *
+ * Copyright (C) 2022-24 Intel Corporation
+ */
+
+#ifndef _SPDM_H_
+#define _SPDM_H_
+
+#include <linux/types.h>
+
+struct key;
+struct device;
+struct spdm_state;
+
+typedef ssize_t (spdm_transport)(void *priv, struct device *dev,
+				 const void *request, size_t request_sz,
+				 void *response, size_t response_sz);
+
+struct spdm_state *spdm_create(struct device *dev, spdm_transport *transport,
+			       void *transport_priv, u32 transport_sz,
+			       struct key *keyring);
+
+int spdm_authenticate(struct spdm_state *spdm_state);
+
+void spdm_destroy(struct spdm_state *spdm_state);
+
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index d33a268bc256..9011fa32af45 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -782,3 +782,18 @@ config POLYNOMIAL
 
 config FIRMWARE_TABLE
 	bool
+
+config SPDM
+	tristate
+	select CRYPTO
+	select KEYS
+	select ASYMMETRIC_KEY_TYPE
+	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select X509_CERTIFICATE_PARSER
+	help
+	  The Security Protocol and Data Model (SPDM) allows for device
+	  authentication, measurement, key exchange and encrypted sessions.
+
+	  Crypto algorithms negotiated with SPDM are limited to those enabled
+	  in .config.  Drivers selecting SPDM therefore need to also select
+	  any algorithms they deem mandatory.
diff --git a/lib/Makefile b/lib/Makefile
index 3b1769045651..b2ef14d1fa71 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -301,6 +301,8 @@ obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
 obj-$(CONFIG_ASN1) += asn1_decoder.o
 obj-$(CONFIG_ASN1_ENCODER) += asn1_encoder.o
 
+obj-$(CONFIG_SPDM) += spdm/
+
 obj-$(CONFIG_FONT_SUPPORT) += fonts/
 
 hostprogs	:= gen_crc32table
diff --git a/lib/spdm/Makefile b/lib/spdm/Makefile
new file mode 100644
index 000000000000..f579cc898dbc
--- /dev/null
+++ b/lib/spdm/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# DMTF Security Protocol and Data Model (SPDM)
+# https://www.dmtf.org/dsp/DSP0274
+#
+# Copyright (C) 2024 Intel Corporation
+
+obj-$(CONFIG_SPDM) += spdm.o
+
+spdm-y := core.o req-authenticate.o
diff --git a/lib/spdm/core.c b/lib/spdm/core.c
new file mode 100644
index 000000000000..f06402f6d127
--- /dev/null
+++ b/lib/spdm/core.c
@@ -0,0 +1,425 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DMTF Security Protocol and Data Model (SPDM)
+ * https://www.dmtf.org/dsp/DSP0274
+ *
+ * Core routines for message exchange, message transcript,
+ * signature verification and session state lifecycle
+ *
+ * Copyright (C) 2021-22 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ *
+ * Copyright (C) 2022-24 Intel Corporation
+ */
+
+#include "spdm.h"
+
+#include <linux/dev_printk.h>
+#include <linux/module.h>
+
+#include <crypto/hash.h>
+#include <crypto/public_key.h>
+
+static int spdm_err(struct device *dev, struct spdm_error_rsp *rsp)
+{
+	switch (rsp->error_code) {
+	case SPDM_INVALID_REQUEST:
+		dev_err(dev, "Invalid request\n");
+		return -EINVAL;
+	case SPDM_INVALID_SESSION:
+		if (rsp->version == 0x11) {
+			dev_err(dev, "Invalid session %#x\n", rsp->error_data);
+			return -EINVAL;
+		}
+		break;
+	case SPDM_BUSY:
+		dev_err(dev, "Busy\n");
+		return -EBUSY;
+	case SPDM_UNEXPECTED_REQUEST:
+		dev_err(dev, "Unexpected request\n");
+		return -EINVAL;
+	case SPDM_UNSPECIFIED:
+		dev_err(dev, "Unspecified error\n");
+		return -EINVAL;
+	case SPDM_DECRYPT_ERROR:
+		dev_err(dev, "Decrypt error\n");
+		return -EIO;
+	case SPDM_UNSUPPORTED_REQUEST:
+		dev_err(dev, "Unsupported request %#x\n", rsp->error_data);
+		return -EINVAL;
+	case SPDM_REQUEST_IN_FLIGHT:
+		dev_err(dev, "Request in flight\n");
+		return -EINVAL;
+	case SPDM_INVALID_RESPONSE_CODE:
+		dev_err(dev, "Invalid response code\n");
+		return -EINVAL;
+	case SPDM_SESSION_LIMIT_EXCEEDED:
+		dev_err(dev, "Session limit exceeded\n");
+		return -EBUSY;
+	case SPDM_SESSION_REQUIRED:
+		dev_err(dev, "Session required\n");
+		return -EINVAL;
+	case SPDM_RESET_REQUIRED:
+		dev_err(dev, "Reset required\n");
+		return -ECONNRESET;
+	case SPDM_RESPONSE_TOO_LARGE:
+		dev_err(dev, "Response too large\n");
+		return -EINVAL;
+	case SPDM_REQUEST_TOO_LARGE:
+		dev_err(dev, "Request too large\n");
+		return -EINVAL;
+	case SPDM_LARGE_RESPONSE:
+		dev_err(dev, "Large response\n");
+		return -EMSGSIZE;
+	case SPDM_MESSAGE_LOST:
+		dev_err(dev, "Message lost\n");
+		return -EIO;
+	case SPDM_INVALID_POLICY:
+		dev_err(dev, "Invalid policy\n");
+		return -EINVAL;
+	case SPDM_VERSION_MISMATCH:
+		dev_err(dev, "Version mismatch\n");
+		return -EINVAL;
+	case SPDM_RESPONSE_NOT_READY:
+		dev_err(dev, "Response not ready\n");
+		return -EINPROGRESS;
+	case SPDM_REQUEST_RESYNCH:
+		dev_err(dev, "Request resynchronization\n");
+		return -ECONNRESET;
+	case SPDM_OPERATION_FAILED:
+		dev_err(dev, "Operation failed\n");
+		return -EINVAL;
+	case SPDM_NO_PENDING_REQUESTS:
+		return -ENOENT;
+	case SPDM_VENDOR_DEFINED_ERROR:
+		dev_err(dev, "Vendor defined error\n");
+		return -EINVAL;
+	}
+
+	dev_err(dev, "Undefined error %#x\n", rsp->error_code);
+	return -EINVAL;
+}
+
+/**
+ * spdm_exchange() - Perform SPDM message exchange with device
+ *
+ * @spdm_state: SPDM session state
+ * @req: Request message
+ * @req_sz: Size of @req
+ * @rsp: Response message
+ * @rsp_sz: Size of @rsp
+ *
+ * Send the request @req to the device via the @transport in @spdm_state and
+ * receive the response into @rsp, respecting the maximum buffer size @rsp_sz.
+ * The request version is automatically populated.
+ *
+ * Return response size on success or a negative errno.  Response size may be
+ * less than @rsp_sz and the caller is responsible for checking that.  It may
+ * also be more than expected (though never more than @rsp_sz), e.g. if the
+ * transport receives only dword-sized chunks.
+ */
+ssize_t spdm_exchange(struct spdm_state *spdm_state,
+		      void *req, size_t req_sz, void *rsp, size_t rsp_sz)
+{
+	struct spdm_header *request = req;
+	struct spdm_header *response = rsp;
+	ssize_t rc, length;
+
+	if (req_sz < sizeof(struct spdm_header) ||
+	    rsp_sz < sizeof(struct spdm_header))
+		return -EINVAL;
+
+	request->version = spdm_state->version;
+
+	rc = spdm_state->transport(spdm_state->transport_priv, spdm_state->dev,
+				   req, req_sz, rsp, rsp_sz);
+	if (rc < 0)
+		return rc;
+
+	length = rc;
+	if (length < sizeof(struct spdm_header))
+		return length; /* Truncated response is handled by callers */
+
+	if (response->code == SPDM_ERROR)
+		return spdm_err(spdm_state->dev, (struct spdm_error_rsp *)rsp);
+
+	if (response->code != (request->code & ~SPDM_REQ)) {
+		dev_err(spdm_state->dev,
+			"Response code %#x does not match request code %#x\n",
+			response->code, request->code);
+		return -EPROTO;
+	}
+
+	return length;
+}
+
+/**
+ * spdm_alloc_transcript() - Allocate transcript buffer
+ *
+ * @spdm_state: SPDM session state
+ *
+ * Allocate a buffer to accommodate the concatenation of all SPDM messages
+ * exchanged during an authentication sequence.  Used to verify the signature,
+ * as it is computed over the hashed transcript.
+ *
+ * Transcript size is initially one page.  It grows by additional pages as
+ * needed.  Minimum size of an authentication sequence is 1k (only one slot
+ * occupied, only one ECC P256 certificate in chain, SHA 256 hash selected).
+ * Maximum can be several MBytes.  Between 4k and 64k is probably typical.
+ *
+ * Return 0 on success or a negative errno.
+ */
+int spdm_alloc_transcript(struct spdm_state *spdm_state)
+{
+	spdm_state->transcript = kvmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!spdm_state->transcript)
+		return -ENOMEM;
+
+	spdm_state->transcript_end = spdm_state->transcript;
+	spdm_state->transcript_max = PAGE_SIZE;
+
+	return 0;
+}
+
+/**
+ * spdm_free_transcript() - Free transcript buffer
+ *
+ * @spdm_state: SPDM session state
+ *
+ * Free the transcript buffer after performing authentication.  Reset the
+ * pointer to the current end of transcript as well as the allocation size.
+ */
+void spdm_free_transcript(struct spdm_state *spdm_state)
+{
+	kvfree(spdm_state->transcript);
+	spdm_state->transcript_end = NULL;
+	spdm_state->transcript_max = 0;
+}
+
+/**
+ * spdm_append_transcript() - Append a message to transcript buffer
+ *
+ * @spdm_state: SPDM session state
+ * @msg: SPDM message
+ * @msg_sz: Size of @msg
+ *
+ * Append an SPDM message to the transcript after reception or transmission.
+ * Reallocate a larger transcript buffer if the message exceeds its current
+ * allocation size.
+ *
+ * If the message to be appended is known to fit into the allocation size,
+ * it may be directly received into or transmitted from the transcript buffer
+ * instead of calling this function:  Simply use the @transcript_end pointer in
+ * struct spdm_state as the position to store the message, then advance the
+ * pointer by the message size.
+ *
+ * Return 0 on success or a negative errno.
+ */
+int spdm_append_transcript(struct spdm_state *spdm_state,
+			   const void *msg, size_t msg_sz)
+{
+	size_t transcript_sz = spdm_state->transcript_end -
+			       spdm_state->transcript;
+
+	if (transcript_sz + msg_sz > spdm_state->transcript_max) {
+		size_t new_sz = round_up(transcript_sz + msg_sz, PAGE_SIZE);
+		void *new = kvrealloc(spdm_state->transcript,
+				      spdm_state->transcript_max,
+				      new_sz, GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
+
+		spdm_state->transcript = new;
+		spdm_state->transcript_end = new + transcript_sz;
+		spdm_state->transcript_max = new_sz;
+	}
+
+	memcpy(spdm_state->transcript_end, msg, msg_sz);
+	spdm_state->transcript_end += msg_sz;
+
+	return 0;
+}
+
+/**
+ * spdm_create_combined_prefix() - Create combined_spdm_prefix for a hash
+ *
+ * @version: SPDM version negotiated during GET_VERSION exchange
+ * @spdm_context: SPDM context of signature generation (or verification)
+ * @buf: Buffer to receive combined_spdm_prefix (100 bytes)
+ *
+ * From SPDM 1.2, a hash is prefixed with the SPDM version and context before
+ * a signature is generated (or verified) over the resulting concatenation
+ * (SPDM 1.2.0 section 15).  Create that prefix.
+ */
+void spdm_create_combined_prefix(u8 version, const char *spdm_context,
+				 void *buf)
+{
+	u8 major = FIELD_GET(0xf0, version);
+	u8 minor = FIELD_GET(0x0f, version);
+	size_t len = strlen(spdm_context);
+	int rc, zero_pad;
+
+	rc = snprintf(buf, SPDM_PREFIX_SZ + 1,
+		      "dmtf-spdm-v%hhx.%hhx.*dmtf-spdm-v%hhx.%hhx.*"
+		      "dmtf-spdm-v%hhx.%hhx.*dmtf-spdm-v%hhx.%hhx.*",
+		      major, minor, major, minor, major, minor, major, minor);
+	WARN_ON(rc != SPDM_PREFIX_SZ);
+
+	zero_pad = SPDM_COMBINED_PREFIX_SZ - SPDM_PREFIX_SZ - 1 - len;
+	WARN_ON(zero_pad < 0);
+
+	memset(buf + SPDM_PREFIX_SZ + 1, 0, zero_pad);
+	memcpy(buf + SPDM_PREFIX_SZ + 1 + zero_pad, spdm_context, len);
+}
+
+/**
+ * spdm_verify_signature() - Verify signature against leaf key
+ *
+ * @spdm_state: SPDM session state
+ * @spdm_context: SPDM context (used to create combined_spdm_prefix)
+ *
+ * Implementation of the abstract SPDMSignatureVerify() function described in
+ * SPDM 1.2.0 section 16:  Compute the hash over @spdm_state->transcript and
+ * verify that the signature at the end of the transcript was generated by
+ * @spdm_state->leaf_key.  Hashing the entire transcript allows detection
+ * of message modification by a man-in-the-middle or media error.
+ *
+ * Return 0 on success or a negative errno.
+ */
+int spdm_verify_signature(struct spdm_state *spdm_state,
+			  const char *spdm_context)
+{
+	struct public_key_signature sig = {
+		.s = spdm_state->transcript_end - spdm_state->sig_len,
+		.s_size = spdm_state->sig_len,
+		.encoding = spdm_state->base_asym_enc,
+		.hash_algo = spdm_state->base_hash_alg_name,
+	};
+	u8 *mhash __free(kfree) = NULL;
+	u8 *m __free(kfree);
+	int rc;
+
+	m = kmalloc(SPDM_COMBINED_PREFIX_SZ + spdm_state->hash_len, GFP_KERNEL);
+	if (!m)
+		return -ENOMEM;
+
+	/* Hash the transcript (sans trailing signature) */
+	rc = crypto_shash_digest(spdm_state->desc, spdm_state->transcript,
+				 (void *)sig.s - spdm_state->transcript,
+				 m + SPDM_COMBINED_PREFIX_SZ);
+	if (rc)
+		return rc;
+
+	if (spdm_state->version <= 0x11) {
+		/*
+		 * SPDM 1.0 and 1.1 compute the signature only over the hash
+		 * (SPDM 1.0.0 section 4.9.2.7).
+		 */
+		sig.digest = m + SPDM_COMBINED_PREFIX_SZ;
+		sig.digest_size = spdm_state->hash_len;
+	} else {
+		/*
+		 * From SPDM 1.2, the hash is prefixed with spdm_context before
+		 * computing the signature over the resulting message M
+		 * (SPDM 1.2.0 sec 15).
+		 */
+		spdm_create_combined_prefix(spdm_state->version, spdm_context,
+					    m);
+
+		/*
+		 * RSA and ECDSA algorithms require that M is hashed once more.
+		 * EdDSA and SM2 algorithms omit that step.
+		 * The switch statement prepares for their introduction.
+		 */
+		switch (spdm_state->base_asym_alg) {
+		default:
+			mhash = kmalloc(spdm_state->hash_len, GFP_KERNEL);
+			if (!mhash)
+				return -ENOMEM;
+
+			rc = crypto_shash_digest(spdm_state->desc, m,
+				SPDM_COMBINED_PREFIX_SZ + spdm_state->hash_len,
+				mhash);
+			if (rc)
+				return rc;
+
+			sig.digest = mhash;
+			sig.digest_size = spdm_state->hash_len;
+			break;
+		}
+	}
+
+	return public_key_verify_signature(spdm_state->leaf_key, &sig);
+}
+
+/**
+ * spdm_reset() - Free cryptographic data structures
+ *
+ * @spdm_state: SPDM session state
+ *
+ * Free cryptographic data structures when an SPDM session is destroyed or
+ * when the device is reauthenticated.
+ */
+void spdm_reset(struct spdm_state *spdm_state)
+{
+	public_key_free(spdm_state->leaf_key);
+	spdm_state->leaf_key = NULL;
+
+	kfree(spdm_state->desc);
+	spdm_state->desc = NULL;
+
+	crypto_free_shash(spdm_state->shash);
+	spdm_state->shash = NULL;
+}
+
+/**
+ * spdm_create() - Allocate SPDM session
+ *
+ * @dev: Responder device
+ * @transport: Transport function to perform one message exchange
+ * @transport_priv: Transport private data
+ * @transport_sz: Maximum message size the transport is capable of (in bytes)
+ * @keyring: Trusted root certificates
+ *
+ * Return a pointer to the allocated SPDM session state or NULL on error.
+ */
+struct spdm_state *spdm_create(struct device *dev, spdm_transport *transport,
+			       void *transport_priv, u32 transport_sz,
+			       struct key *keyring)
+{
+	struct spdm_state *spdm_state = kzalloc(sizeof(*spdm_state), GFP_KERNEL);
+
+	if (!spdm_state)
+		return NULL;
+
+	spdm_state->dev = dev;
+	spdm_state->transport = transport;
+	spdm_state->transport_priv = transport_priv;
+	spdm_state->transport_sz = transport_sz;
+	spdm_state->root_keyring = keyring;
+
+	mutex_init(&spdm_state->lock);
+
+	return spdm_state;
+}
+EXPORT_SYMBOL_GPL(spdm_create);
+
+/**
+ * spdm_destroy() - Destroy SPDM session
+ *
+ * @spdm_state: SPDM session state
+ */
+void spdm_destroy(struct spdm_state *spdm_state)
+{
+	u8 slot;
+
+	for_each_set_bit(slot, &spdm_state->provisioned_slots, SPDM_SLOTS)
+		kvfree(spdm_state->slot[slot]);
+
+	spdm_reset(spdm_state);
+	mutex_destroy(&spdm_state->lock);
+	kfree(spdm_state);
+}
+EXPORT_SYMBOL_GPL(spdm_destroy);
+
+MODULE_LICENSE("GPL");
diff --git a/lib/spdm/req-authenticate.c b/lib/spdm/req-authenticate.c
new file mode 100644
index 000000000000..51fdb88f519b
--- /dev/null
+++ b/lib/spdm/req-authenticate.c
@@ -0,0 +1,704 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DMTF Security Protocol and Data Model (SPDM)
+ * https://www.dmtf.org/dsp/DSP0274
+ *
+ * Requester role: Authenticate a device
+ *
+ * Copyright (C) 2021-22 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ *
+ * Copyright (C) 2022-24 Intel Corporation
+ */
+
+#include "spdm.h"
+
+#include <linux/dev_printk.h>
+#include <linux/key.h>
+#include <linux/random.h>
+
+#include <asm/unaligned.h>
+#include <crypto/hash.h>
+#include <crypto/hash_info.h>
+#include <keys/asymmetric-type.h>
+#include <keys/x509-parser.h>
+
+/* SPDM 1.2.0 margin no 359 and 803 */
+static const char *spdm_context = "responder-challenge_auth signing";
+
+/*
+ * All SPDM messages exchanged during an authentication sequence up to and
+ * including GET_DIGESTS fit into a single page, hence are stored in the
+ * transcript without bounds checking.  Only subsequent GET_CERTIFICATE
+ * and CHALLENGE exchanges may exceed one page.
+ */
+static_assert(PAGE_SIZE >=
+	sizeof(struct spdm_get_version_req) +
+	struct_size_t(struct spdm_get_version_rsp,
+		      version_number_entries, 255) +
+	sizeof(struct spdm_get_capabilities_req) +
+	sizeof(struct spdm_get_capabilities_rsp) +
+	sizeof(struct spdm_negotiate_algs_req) +
+	sizeof(struct spdm_negotiate_algs_rsp) +
+	sizeof(struct spdm_req_alg_struct) * 2 * SPDM_MAX_REQ_ALG_STRUCT +
+	sizeof(struct spdm_get_digests_req) +
+	struct_size_t(struct spdm_get_digests_rsp,
+		      digests, SPDM_SLOTS * SHA512_DIGEST_SIZE));
+
+static int spdm_get_version(struct spdm_state *spdm_state)
+{
+	struct spdm_get_version_req *req = spdm_state->transcript;
+	struct spdm_get_version_rsp *rsp;
+	bool foundver = false;
+	int rc, length, i;
+
+	spdm_state->version = 0x10;
+
+	*req = (struct spdm_get_version_req) {
+		.code = SPDM_GET_VERSION,
+	};
+
+	rsp = spdm_state->transcript_end += sizeof(*req);
+
+	rc = spdm_exchange(spdm_state, req, sizeof(*req), rsp,
+			   struct_size(rsp, version_number_entries, 255));
+	if (rc < 0)
+		return rc;
+
+	length = rc;
+	if (length < sizeof(*rsp) ||
+	    length < struct_size(rsp, version_number_entries,
+				 rsp->version_number_entry_count)) {
+		dev_err(spdm_state->dev, "Truncated version response\n");
+		return -EIO;
+	}
+
+	spdm_state->transcript_end +=
+		     struct_size(rsp, version_number_entries,
+				 rsp->version_number_entry_count);
+
+	for (i = 0; i < rsp->version_number_entry_count; i++) {
+		u8 ver = le16_to_cpu(rsp->version_number_entries[i]) >> 8;
+
+		if (ver >= spdm_state->version && ver <= SPDM_MAX_VER) {
+			spdm_state->version = ver;
+			foundver = true;
+		}
+	}
+	if (!foundver) {
+		dev_err(spdm_state->dev, "No common supported version\n");
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
+static int spdm_get_capabilities(struct spdm_state *spdm_state)
+{
+	struct spdm_get_capabilities_req *req = spdm_state->transcript_end;
+	struct spdm_get_capabilities_rsp *rsp;
+	size_t req_sz, rsp_sz;
+	int rc, length;
+
+	*req = (struct spdm_get_capabilities_req) {
+		.code = SPDM_GET_CAPABILITIES,
+		.ctexponent = SPDM_CTEXPONENT,
+		.flags = cpu_to_le32(SPDM_REQ_CAPS),
+	};
+
+	if (spdm_state->version == 0x10) {
+		req_sz = offsetofend(typeof(*req), param2);
+		rsp_sz = offsetofend(typeof(*rsp), flags);
+	} else if (spdm_state->version == 0x11) {
+		req_sz = offsetofend(typeof(*req), flags);
+		rsp_sz = offsetofend(typeof(*rsp), flags);
+	} else {
+		req_sz = sizeof(*req);
+		rsp_sz = sizeof(*rsp);
+		req->data_transfer_size = cpu_to_le32(spdm_state->transport_sz);
+		req->max_spdm_msg_size = cpu_to_le32(spdm_state->transport_sz);
+	}
+
+	rsp = spdm_state->transcript_end += req_sz;
+
+	rc = spdm_exchange(spdm_state, req, req_sz, rsp, rsp_sz);
+	if (rc < 0)
+		return rc;
+
+	length = rc;
+	if (length < rsp_sz) {
+		dev_err(spdm_state->dev, "Truncated capabilities response\n");
+		return -EIO;
+	}
+
+	spdm_state->transcript_end += rsp_sz;
+
+	spdm_state->rsp_caps = le32_to_cpu(rsp->flags);
+	if ((spdm_state->rsp_caps & SPDM_RSP_MIN_CAPS) != SPDM_RSP_MIN_CAPS)
+		return -EPROTONOSUPPORT;
+
+	if (spdm_state->version >= 0x12) {
+		u32 data_transfer_size = le32_to_cpu(rsp->data_transfer_size);
+		if (data_transfer_size < SPDM_MIN_DATA_TRANSFER_SIZE) {
+			dev_err(spdm_state->dev,
+				"Malformed capabilities response\n");
+			return -EPROTO;
+		}
+		spdm_state->transport_sz = min(spdm_state->transport_sz,
+					       data_transfer_size);
+	}
+
+	return 0;
+}
+
+static int spdm_parse_algs(struct spdm_state *spdm_state)
+{
+	switch (spdm_state->base_asym_alg) {
+	case SPDM_ASYM_RSASSA_2048:
+		spdm_state->sig_len = 256;
+		spdm_state->base_asym_enc = "pkcs1";
+		break;
+	case SPDM_ASYM_RSASSA_3072:
+		spdm_state->sig_len = 384;
+		spdm_state->base_asym_enc = "pkcs1";
+		break;
+	case SPDM_ASYM_RSASSA_4096:
+		spdm_state->sig_len = 512;
+		spdm_state->base_asym_enc = "pkcs1";
+		break;
+	case SPDM_ASYM_ECDSA_ECC_NIST_P256:
+		spdm_state->sig_len = 64;
+		spdm_state->base_asym_enc = "p1363";
+		break;
+	case SPDM_ASYM_ECDSA_ECC_NIST_P384:
+		spdm_state->sig_len = 96;
+		spdm_state->base_asym_enc = "p1363";
+		break;
+	case SPDM_ASYM_ECDSA_ECC_NIST_P521:
+		spdm_state->sig_len = 132;
+		spdm_state->base_asym_enc = "p1363";
+		break;
+	default:
+		dev_err(spdm_state->dev, "Unknown asym algorithm\n");
+		return -EINVAL;
+	}
+
+	switch (spdm_state->base_hash_alg) {
+	case SPDM_HASH_SHA_256:
+		spdm_state->base_hash_alg_name = "sha256";
+		break;
+	case SPDM_HASH_SHA_384:
+		spdm_state->base_hash_alg_name = "sha384";
+		break;
+	case SPDM_HASH_SHA_512:
+		spdm_state->base_hash_alg_name = "sha512";
+		break;
+	default:
+		dev_err(spdm_state->dev, "Unknown hash algorithm\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * shash and desc allocations are reused for subsequent measurement
+	 * retrieval, hence are not freed until spdm_reset().
+	 */
+	spdm_state->shash = crypto_alloc_shash(spdm_state->base_hash_alg_name,
+					       0, 0);
+	if (!spdm_state->shash)
+		return -ENOMEM;
+
+	spdm_state->desc = kzalloc(sizeof(*spdm_state->desc) +
+				   crypto_shash_descsize(spdm_state->shash),
+				   GFP_KERNEL);
+	if (!spdm_state->desc)
+		return -ENOMEM;
+
+	spdm_state->desc->tfm = spdm_state->shash;
+
+	/* Used frequently to compute offsets, so cache H */
+	spdm_state->hash_len = crypto_shash_digestsize(spdm_state->shash);
+
+	return crypto_shash_init(spdm_state->desc);
+}
+
+static int spdm_negotiate_algs(struct spdm_state *spdm_state)
+{
+	struct spdm_negotiate_algs_req *req = spdm_state->transcript_end;
+	struct spdm_negotiate_algs_rsp *rsp;
+	struct spdm_req_alg_struct *req_alg_struct;
+	size_t req_sz = sizeof(*req);
+	size_t rsp_sz = sizeof(*rsp);
+	int rc, length;
+
+	/* Request length shall be <= 128 bytes (SPDM 1.1.0 margin no 185) */
+	BUILD_BUG_ON(req_sz > 128);
+
+	*req = (struct spdm_negotiate_algs_req) {
+		.code = SPDM_NEGOTIATE_ALGS,
+		.length = cpu_to_le16(req_sz),
+		.base_asym_algo = cpu_to_le32(SPDM_ASYM_ALGOS),
+		.base_hash_algo = cpu_to_le32(SPDM_HASH_ALGOS),
+	};
+
+	rsp = spdm_state->transcript_end += req_sz;
+
+	rc = spdm_exchange(spdm_state, req, req_sz, rsp, rsp_sz);
+	if (rc < 0)
+		return rc;
+
+	length = rc;
+	if (length < sizeof(*rsp) ||
+	    length < sizeof(*rsp) + rsp->param1 * sizeof(*req_alg_struct)) {
+		dev_err(spdm_state->dev, "Truncated algorithms response\n");
+		return -EIO;
+	}
+
+	/*
+	 * If request contained a ReqAlgStruct not supported by responder,
+	 * the corresponding RespAlgStruct may be omitted in response.
+	 * Calculate the actual (possibly shorter) response length:
+	 */
+	spdm_state->transcript_end +=
+		     sizeof(*rsp) + rsp->param1 * sizeof(*req_alg_struct);
+
+	spdm_state->base_asym_alg = le32_to_cpu(rsp->base_asym_sel);
+	spdm_state->base_hash_alg = le32_to_cpu(rsp->base_hash_sel);
+
+	if ((spdm_state->base_asym_alg & SPDM_ASYM_ALGOS) == 0 ||
+	    (spdm_state->base_hash_alg & SPDM_HASH_ALGOS) == 0) {
+		dev_err(spdm_state->dev, "No common supported algorithms\n");
+		return -EPROTO;
+	}
+
+	/* Responder shall select exactly 1 alg (SPDM 1.0.0 table 14) */
+	if (hweight32(spdm_state->base_asym_alg) != 1 ||
+	    hweight32(spdm_state->base_hash_alg) != 1 ||
+	    rsp->ext_asym_sel_count != 0 ||
+	    rsp->ext_hash_sel_count != 0 ||
+	    rsp->param1 > req->param1) {
+		dev_err(spdm_state->dev, "Malformed algorithms response\n");
+		return -EPROTO;
+	}
+
+	return spdm_parse_algs(spdm_state);
+}
+
+static int spdm_get_digests(struct spdm_state *spdm_state)
+{
+	struct spdm_get_digests_req *req = spdm_state->transcript_end;
+	struct spdm_get_digests_rsp *rsp;
+	unsigned long deprovisioned_slots;
+	int rc, length;
+	size_t rsp_sz;
+	u8 slot;
+
+	*req = (struct spdm_get_digests_req) {
+		.code = SPDM_GET_DIGESTS,
+	};
+
+	rsp = spdm_state->transcript_end += sizeof(*req);
+
+	/*
+	 * Assume all 8 slots are populated.  We know the hash length (and thus
+	 * the response size) because the responder only returns digests for
+	 * the hash algorithm selected during the NEGOTIATE_ALGORITHMS exchange
+	 * (SPDM 1.1.2 margin no 206).
+	 */
+	rsp_sz = sizeof(*rsp) + SPDM_SLOTS * spdm_state->hash_len;
+
+	rc = spdm_exchange(spdm_state, req, sizeof(*req), rsp, rsp_sz);
+	if (rc < 0)
+		return rc;
+
+	length = rc;
+	if (length < sizeof(*rsp) ||
+	    length < sizeof(*rsp) + hweight8(rsp->param2) *
+				    spdm_state->hash_len) {
+		dev_err(spdm_state->dev, "Truncated digests response\n");
+		return -EIO;
+	}
+
+	spdm_state->transcript_end += sizeof(*rsp) + hweight8(rsp->param2) *
+						     spdm_state->hash_len;
+
+	deprovisioned_slots = spdm_state->provisioned_slots & ~rsp->param2;
+	for_each_set_bit(slot, &deprovisioned_slots, SPDM_SLOTS) {
+		kvfree(spdm_state->slot[slot]);
+		spdm_state->slot_sz[slot] = 0;
+		spdm_state->slot[slot] = NULL;
+	}
+
+	/*
+	 * Authentication-capable endpoints must carry at least 1 cert chain
+	 * (SPDM 1.0.0 section 4.9.2.1).
+	 */
+	spdm_state->provisioned_slots = rsp->param2;
+	if (!spdm_state->provisioned_slots) {
+		dev_err(spdm_state->dev, "No certificates provisioned\n");
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
+static int spdm_get_certificate(struct spdm_state *spdm_state, u8 slot)
+{
+	struct spdm_cert_chain *certs __free(kvfree) = NULL;
+	struct spdm_get_certificate_rsp *rsp __free(kvfree);
+	struct spdm_get_certificate_req req = {
+		.code = SPDM_GET_CERTIFICATE,
+		.param1 = slot,
+	};
+	size_t rsp_sz, total_length, header_length;
+	u16 remainder_length = 0xffff;
+	u16 portion_length;
+	u16 offset = 0;
+	int rc, length;
+
+	/*
+	 * It is legal for the responder to send more bytes than requested.
+	 * (Note the "should" in SPDM 1.0.0 table 19.)  If we allocate a
+	 * too small buffer, we can't calculate the hash over the (truncated)
+	 * response.  Only choice is thus to allocate the maximum possible 64k.
+	 */
+	rsp_sz = min_t(u32, sizeof(*rsp) + 0xffff, spdm_state->transport_sz);
+	rsp = kvmalloc(rsp_sz, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	do {
+		/*
+		 * If transport_sz is sufficiently large, first request will be
+		 * for offset 0 and length 0xffff, which means entire cert
+		 * chain (SPDM 1.0.0 table 18).
+		 */
+		req.offset = cpu_to_le16(offset);
+		req.length = cpu_to_le16(min_t(size_t, remainder_length,
+					       rsp_sz - sizeof(*rsp)));
+
+		rc = spdm_exchange(spdm_state, &req, sizeof(req), rsp, rsp_sz);
+		if (rc < 0)
+			return rc;
+
+		length = rc;
+		if (length < sizeof(*rsp) ||
+		    length < sizeof(*rsp) + le16_to_cpu(rsp->portion_length)) {
+			dev_err(spdm_state->dev,
+				"Truncated certificate response\n");
+			return -EIO;
+		}
+
+		portion_length = le16_to_cpu(rsp->portion_length);
+		remainder_length = le16_to_cpu(rsp->remainder_length);
+
+		rc = spdm_append_transcript(spdm_state, &req, sizeof(req));
+		if (rc)
+			return rc;
+
+		rc = spdm_append_transcript(spdm_state, rsp,
+					    sizeof(*rsp) + portion_length);
+		if (rc)
+			return rc;
+
+		/*
+		 * On first response we learn total length of cert chain.
+		 * Should portion_length + remainder_length exceed 0xffff,
+		 * the min() ensures that the malformed check triggers below.
+		 */
+		if (!certs) {
+			total_length = min(portion_length + remainder_length,
+					   0xffff);
+			certs = kvmalloc(total_length, GFP_KERNEL);
+			if (!certs)
+				return -ENOMEM;
+		}
+
+		if (!portion_length ||
+		    (rsp->param1 & 0xf) != slot ||
+		    offset + portion_length + remainder_length != total_length)
+		{
+			dev_err(spdm_state->dev,
+				"Malformed certificate response\n");
+			return -EPROTO;
+		}
+
+		memcpy((u8 *)certs + offset, rsp->cert_chain, portion_length);
+		offset += portion_length;
+	} while (remainder_length > 0);
+
+	header_length = sizeof(struct spdm_cert_chain) + spdm_state->hash_len;
+
+	if (total_length < header_length ||
+	    total_length != le16_to_cpu(certs->length)) {
+		dev_err(spdm_state->dev,
+			"Malformed certificate chain in slot %u\n", slot);
+		return -EPROTO;
+	}
+
+	kvfree(spdm_state->slot[slot]);
+	spdm_state->slot_sz[slot] = total_length;
+	spdm_state->slot[slot] = no_free_ptr(certs);
+
+	return 0;
+}
+
+static int spdm_validate_cert_chain(struct spdm_state *spdm_state, u8 slot)
+{
+	struct x509_certificate *cert __free(x509_free_certificate) = NULL;
+	struct x509_certificate *prev __free(x509_free_certificate) = NULL;
+	size_t header_length, total_length;
+	bool is_leaf_cert;
+	size_t offset = 0;
+	struct key *key;
+	int rc, length;
+	u8 *certs;
+
+	header_length = sizeof(struct spdm_cert_chain) + spdm_state->hash_len;
+	total_length = spdm_state->slot_sz[slot] - header_length;
+	certs = (u8 *)spdm_state->slot[slot] + header_length;
+
+	do {
+		rc = x509_get_certificate_length(certs + offset,
+						 total_length - offset);
+		if (rc < 0) {
+			dev_err(spdm_state->dev, "Invalid certificate length "
+				"at slot %u offset %zu\n", slot, offset);
+			return rc;
+		}
+
+		length = rc;
+		is_leaf_cert = offset + length == total_length;
+
+		cert = x509_cert_parse(certs + offset, length);
+		if (IS_ERR(cert)) {
+			dev_err(spdm_state->dev, "Certificate parse error %pe "
+				"at slot %u offset %zu\n", cert, slot, offset);
+			return PTR_ERR(cert);
+		}
+		if (cert->unsupported_sig) {
+			dev_err(spdm_state->dev, "Unsupported signature "
+				"at slot %u offset %zu\n", slot, offset);
+			return -EKEYREJECTED;
+		}
+		if (cert->blacklisted)
+			return -EKEYREJECTED;
+
+		/*
+		 * Basic Constraints CA value shall be false for leaf cert,
+		 * true for intermediate and root certs (SPDM 1.3.0 table 42).
+		 * Key Usage bit for digital signature shall be set, except
+		 * for GenericCert in slot > 0 (SPDM 1.3.0 margin no 354).
+		 * KeyCertSign bit must be 0 for non-CA (RFC 5280 sec 4.2.1.9).
+		 */
+		if ((is_leaf_cert ==
+		     test_bit(KEY_EFLAG_CA, &cert->pub->key_eflags)) ||
+		    (is_leaf_cert && slot == 0 &&
+		     !test_bit(KEY_EFLAG_DIGITALSIG, &cert->pub->key_eflags)) ||
+		    (is_leaf_cert &&
+		     test_bit(KEY_EFLAG_KEYCERTSIGN, &cert->pub->key_eflags))) {
+			dev_err(spdm_state->dev, "Malformed certificate "
+				"at slot %u offset %zu\n", slot, offset);
+			return -EKEYREJECTED;
+		}
+
+		if (!prev) {
+			/* First cert in chain, check against root_keyring */
+			key = find_asymmetric_key(spdm_state->root_keyring,
+						  cert->sig->auth_ids[0],
+						  cert->sig->auth_ids[1],
+						  cert->sig->auth_ids[2],
+						  false);
+			if (IS_ERR(key)) {
+				dev_info(spdm_state->dev, "Root certificate "
+					 "of slot %u not found in %s "
+					 "keyring: %s\n", slot,
+					 spdm_state->root_keyring->description,
+					 cert->issuer);
+				return PTR_ERR(key);
+			}
+
+			rc = verify_signature(key, cert->sig);
+			key_put(key);
+		} else {
+			/* Subsequent cert in chain, check against previous */
+			rc = public_key_verify_signature(prev->pub, cert->sig);
+		}
+
+		if (rc) {
+			dev_err(spdm_state->dev, "Signature validation error "
+				"%d at slot %u offset %zu\n", rc, slot, offset);
+			return rc;
+		}
+
+		x509_free_certificate(prev);
+		prev = cert;
+		cert = ERR_PTR(-ENOKEY);
+
+		offset += length;
+	} while (offset < total_length);
+
+	/* Steal pub pointer ahead of x509_free_certificate() */
+	spdm_state->leaf_key = prev->pub;
+	prev->pub = NULL;
+
+	return 0;
+}
+
+/**
+ * spdm_challenge_rsp_sz() - Calculate CHALLENGE_AUTH response size
+ *
+ * @spdm_state: SPDM session state
+ * @rsp: CHALLENGE_AUTH response (optional)
+ *
+ * A CHALLENGE_AUTH response contains multiple variable-length fields
+ * as well as optional fields.  This helper eases calculating its size.
+ *
+ * If @rsp is %NULL, assume the maximum OpaqueDataLength of 1024 bytes
+ * (SPDM 1.0.0 table 21).  Otherwise read OpaqueDataLength from @rsp.
+ * OpaqueDataLength can only be > 0 for SPDM 1.0 and 1.1, as they lack
+ * the OtherParamsSupport field in the NEGOTIATE_ALGORITHMS request.
+ * For SPDM 1.2+, we do not offer any Opaque Data Formats in that field,
+ * which forces OpaqueDataLength to 0 (SPDM 1.2.0 margin no 261).
+ */
+static size_t spdm_challenge_rsp_sz(struct spdm_state *spdm_state,
+				    struct spdm_challenge_rsp *rsp)
+{
+	size_t  size  = sizeof(*rsp)		/* Header */
+		      + spdm_state->hash_len	/* CertChainHash */
+		      + SPDM_NONCE_SZ;		/* Nonce */
+
+	if (rsp)
+		/* May be unaligned if hash algorithm has odd length */
+		size += get_unaligned_le16((u8 *)rsp + size);
+	else
+		size += SPDM_MAX_OPAQUE_DATA;	/* OpaqueData */
+
+	size += 2;				/* OpaqueDataLength */
+
+	if (spdm_state->version >= 0x13)
+		size += 8;			/* RequesterContext */
+
+	return  size  + spdm_state->sig_len;	/* Signature */
+}
+
+static int spdm_challenge(struct spdm_state *spdm_state, u8 slot)
+{
+	struct spdm_challenge_rsp *rsp __free(kfree);
+	struct spdm_challenge_req req = {
+		.code = SPDM_CHALLENGE,
+		.param1 = slot,
+		.param2 = 0, /* No measurement summary hash */
+	};
+	size_t req_sz, rsp_sz, rsp_sz_max;
+	int rc, length;
+
+	get_random_bytes(&req.nonce, sizeof(req.nonce));
+
+	if (spdm_state->version <= 0x12)
+		req_sz = offsetofend(typeof(req), nonce);
+	else
+		req_sz = sizeof(req);
+
+	rsp_sz_max = spdm_challenge_rsp_sz(spdm_state, NULL);
+	rsp = kzalloc(rsp_sz_max, GFP_KERNEL);
+	if (!rsp)
+		return -ENOMEM;
+
+	rc = spdm_exchange(spdm_state, &req, req_sz, rsp, rsp_sz_max);
+	if (rc < 0)
+		return rc;
+
+	length = rc;
+	rsp_sz = spdm_challenge_rsp_sz(spdm_state, rsp);
+	if (length < rsp_sz) {
+		dev_err(spdm_state->dev, "Truncated challenge_auth response\n");
+		return -EIO;
+	}
+
+	rc = spdm_append_transcript(spdm_state, &req, req_sz);
+	if (rc)
+		return rc;
+
+	rc = spdm_append_transcript(spdm_state, rsp, rsp_sz);
+	if (rc)
+		return rc;
+
+	/* Verify signature at end of transcript against leaf key */
+	rc = spdm_verify_signature(spdm_state, spdm_context);
+	if (rc)
+		dev_err(spdm_state->dev,
+			"Cannot verify challenge_auth signature: %d\n", rc);
+	else
+		dev_info(spdm_state->dev,
+			 "Authenticated with certificate slot %u\n", slot);
+
+	return rc;
+}
+
+/**
+ * spdm_authenticate() - Authenticate device
+ *
+ * @spdm_state: SPDM session state
+ *
+ * Authenticate a device through a sequence of GET_VERSION, GET_CAPABILITIES,
+ * NEGOTIATE_ALGORITHMS, GET_DIGESTS, GET_CERTIFICATE and CHALLENGE exchanges.
+ *
+ * Perform internal locking to serialize multiple concurrent invocations.
+ * Can be called repeatedly for reauthentication.
+ *
+ * Return 0 on success or a negative errno.  In particular, -EPROTONOSUPPORT
+ * indicates authentication is not supported by the device.
+ */
+int spdm_authenticate(struct spdm_state *spdm_state)
+{
+	u8 slot;
+	int rc;
+
+	mutex_lock(&spdm_state->lock);
+	spdm_reset(spdm_state);
+
+	rc = spdm_alloc_transcript(spdm_state);
+	if (rc)
+		goto unlock;
+
+	rc = spdm_get_version(spdm_state);
+	if (rc)
+		goto unlock;
+
+	rc = spdm_get_capabilities(spdm_state);
+	if (rc)
+		goto unlock;
+
+	rc = spdm_negotiate_algs(spdm_state);
+	if (rc)
+		goto unlock;
+
+	rc = spdm_get_digests(spdm_state);
+	if (rc)
+		goto unlock;
+
+	for_each_set_bit(slot, &spdm_state->provisioned_slots, SPDM_SLOTS) {
+		rc = spdm_get_certificate(spdm_state, slot);
+		if (rc)
+			goto unlock;
+	}
+
+	for_each_set_bit(slot, &spdm_state->provisioned_slots, SPDM_SLOTS) {
+		rc = spdm_validate_cert_chain(spdm_state, slot);
+		if (rc == 0)
+			break;
+	}
+	if (rc)
+		goto unlock;
+
+	rc = spdm_challenge(spdm_state, slot);
+
+unlock:
+	if (rc)
+		spdm_reset(spdm_state);
+	spdm_state->authenticated = !rc;
+	spdm_free_transcript(spdm_state);
+	mutex_unlock(&spdm_state->lock);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(spdm_authenticate);
diff --git a/lib/spdm/spdm.h b/lib/spdm/spdm.h
new file mode 100644
index 000000000000..3a104959ad53
--- /dev/null
+++ b/lib/spdm/spdm.h
@@ -0,0 +1,520 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DMTF Security Protocol and Data Model (SPDM)
+ * https://www.dmtf.org/dsp/DSP0274
+ *
+ * Copyright (C) 2021-22 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ *
+ * Copyright (C) 2022-24 Intel Corporation
+ */
+
+#ifndef _LIB_SPDM_H_
+#define _LIB_SPDM_H_
+
+#undef  DEFAULT_SYMBOL_NAMESPACE
+#define DEFAULT_SYMBOL_NAMESPACE SPDM
+
+#define dev_fmt(fmt) "SPDM: " fmt
+
+#include <linux/bitfield.h>
+#include <linux/mutex.h>
+#include <linux/spdm.h>
+
+/* SPDM versions supported by this implementation */
+#define SPDM_MIN_VER 0x10
+#define SPDM_MAX_VER 0x13
+
+/* SPDM capabilities (SPDM 1.1.0 margin no 177, 178) */
+#define SPDM_CACHE_CAP			BIT(0)		/* 1.0 resp only */
+#define SPDM_CERT_CAP			BIT(1)		/* 1.0 */
+#define SPDM_CHAL_CAP			BIT(2)		/* 1.0 */
+#define SPDM_MEAS_CAP_MASK		GENMASK(4, 3)	/* 1.0 resp only */
+#define   SPDM_MEAS_CAP_NO		0		/* 1.0 resp only */
+#define   SPDM_MEAS_CAP_MEAS		1		/* 1.0 resp only */
+#define   SPDM_MEAS_CAP_MEAS_SIG	2		/* 1.0 resp only */
+#define SPDM_MEAS_FRESH_CAP		BIT(5)		/* 1.0 resp only */
+#define SPDM_ENCRYPT_CAP		BIT(6)		/* 1.1 */
+#define SPDM_MAC_CAP			BIT(7)		/* 1.1 */
+#define SPDM_MUT_AUTH_CAP		BIT(8)		/* 1.1 */
+#define SPDM_KEY_EX_CAP			BIT(9)		/* 1.1 */
+#define SPDM_PSK_CAP_MASK		GENMASK(11, 10)	/* 1.1 */
+#define   SPDM_PSK_CAP_NO		0		/* 1.1 */
+#define   SPDM_PSK_CAP_PSK		1		/* 1.1 */
+#define   SPDM_PSK_CAP_PSK_CTX		2		/* 1.1 resp only */
+#define SPDM_ENCAP_CAP			BIT(12)		/* 1.1 */
+#define SPDM_HBEAT_CAP			BIT(13)		/* 1.1 */
+#define SPDM_KEY_UPD_CAP		BIT(14)		/* 1.1 */
+#define SPDM_HANDSHAKE_ITC_CAP		BIT(15)		/* 1.1 */
+#define SPDM_PUB_KEY_ID_CAP		BIT(16)		/* 1.1 */
+#define SPDM_CHUNK_CAP			BIT(17)		/* 1.2 */
+#define SPDM_ALIAS_CERT_CAP		BIT(18)		/* 1.2 resp only */
+#define SPDM_SET_CERT_CAP		BIT(19)		/* 1.2 resp only */
+#define SPDM_CSR_CAP			BIT(20)		/* 1.2 resp only */
+#define SPDM_CERT_INST_RESET_CAP	BIT(21)		/* 1.2 resp only */
+#define SPDM_EP_INFO_CAP_MASK		GENMASK(23, 22) /* 1.3 */
+#define   SPDM_EP_INFO_CAP_NO		0		/* 1.3 */
+#define   SPDM_EP_INFO_CAP_RSP		1		/* 1.3 */
+#define   SPDM_EP_INFO_CAP_RSP_SIG	2		/* 1.3 */
+#define SPDM_MEL_CAP			BIT(24)		/* 1.3 resp only */
+#define SPDM_EVENT_CAP			BIT(25)		/* 1.3 */
+#define SPDM_MULTI_KEY_CAP_MASK		GENMASK(27, 26)	/* 1.3 */
+#define   SPDM_MULTI_KEY_CAP_NO		0		/* 1.3 */
+#define   SPDM_MULTI_KEY_CAP_ONLY	1		/* 1.3 */
+#define   SPDM_MULTI_KEY_CAP_SEL	2		/* 1.3 */
+#define SPDM_GET_KEY_PAIR_INFO_CAP	BIT(28)		/* 1.3 resp only */
+#define SPDM_SET_KEY_PAIR_INFO_CAP	BIT(29)		/* 1.3 resp only */
+
+/* SPDM capabilities supported by this implementation */
+#define SPDM_REQ_CAPS			(SPDM_CERT_CAP | SPDM_CHAL_CAP)
+
+/* SPDM capabilities required from responders */
+#define SPDM_RSP_MIN_CAPS		(SPDM_CERT_CAP | SPDM_CHAL_CAP)
+
+/*
+ * SPDM cryptographic timeout of this implementation:
+ * Assume calculations may take up to 1 sec on a busy machine, which equals
+ * roughly 1 << 20.  That's within the limits mandated for responders by CMA
+ * (1 << 23 usec, PCIe r6.2 sec 6.31.3) and DOE (1 sec, PCIe r6.2 sec 6.30.2).
+ * Used in GET_CAPABILITIES exchange.
+ */
+#define SPDM_CTEXPONENT			20
+
+/* SPDM asymmetric key signature algorithms (SPDM 1.0.0 table 13) */
+#define SPDM_ASYM_RSASSA_2048		BIT(0)		/* 1.0 */
+#define SPDM_ASYM_RSAPSS_2048		BIT(1)		/* 1.0 */
+#define SPDM_ASYM_RSASSA_3072		BIT(2)		/* 1.0 */
+#define SPDM_ASYM_RSAPSS_3072		BIT(3)		/* 1.0 */
+#define SPDM_ASYM_ECDSA_ECC_NIST_P256	BIT(4)		/* 1.0 */
+#define SPDM_ASYM_RSASSA_4096		BIT(5)		/* 1.0 */
+#define SPDM_ASYM_RSAPSS_4096		BIT(6)		/* 1.0 */
+#define SPDM_ASYM_ECDSA_ECC_NIST_P384	BIT(7)		/* 1.0 */
+#define SPDM_ASYM_ECDSA_ECC_NIST_P521	BIT(8)		/* 1.0 */
+#define SPDM_ASYM_SM2_ECC_SM2_P256	BIT(9)		/* 1.2 */
+#define SPDM_ASYM_EDDSA_ED25519		BIT(10)		/* 1.2 */
+#define SPDM_ASYM_EDDSA_ED448		BIT(11)		/* 1.2 */
+
+/* SPDM hash algorithms (SPDM 1.0.0 table 13) */
+#define SPDM_HASH_SHA_256		BIT(0)		/* 1.0 */
+#define SPDM_HASH_SHA_384		BIT(1)		/* 1.0 */
+#define SPDM_HASH_SHA_512		BIT(2)		/* 1.0 */
+#define SPDM_HASH_SHA3_256		BIT(3)		/* 1.0 */
+#define SPDM_HASH_SHA3_384		BIT(4)		/* 1.0 */
+#define SPDM_HASH_SHA3_512		BIT(5)		/* 1.0 */
+#define SPDM_HASH_SM3_256		BIT(6)		/* 1.2 */
+
+#if IS_ENABLED(CONFIG_CRYPTO_RSA)
+#define SPDM_ASYM_RSA			SPDM_ASYM_RSASSA_2048 |		\
+					SPDM_ASYM_RSASSA_3072 |		\
+					SPDM_ASYM_RSASSA_4096
+#else
+#define SPDM_ASYM_RSA			0
+#endif
+
+#if IS_ENABLED(CONFIG_CRYPTO_ECDSA)
+#define SPDM_ASYM_ECDSA			SPDM_ASYM_ECDSA_ECC_NIST_P256 |	\
+					SPDM_ASYM_ECDSA_ECC_NIST_P384 | \
+					SPDM_ASYM_ECDSA_ECC_NIST_P521
+#else
+#define SPDM_ASYM_ECDSA			0
+#endif
+
+#if IS_ENABLED(CONFIG_CRYPTO_SHA256)
+#define SPDM_HASH_SHA2_256		SPDM_HASH_SHA_256
+#else
+#define SPDM_HASH_SHA2_256		0
+#endif
+
+#if IS_ENABLED(CONFIG_CRYPTO_SHA512)
+#define SPDM_HASH_SHA2_384_512		SPDM_HASH_SHA_384 |		\
+					SPDM_HASH_SHA_512
+#else
+#define SPDM_HASH_SHA2_384_512		0
+#endif
+
+/* SPDM algorithms supported by this implementation */
+#define SPDM_ASYM_ALGOS		       (SPDM_ASYM_RSA |			\
+					SPDM_ASYM_ECDSA)
+
+#define SPDM_HASH_ALGOS		       (SPDM_HASH_SHA2_256 |		\
+					SPDM_HASH_SHA2_384_512)
+
+/*
+ * Common header shared by all messages.
+ * Note that the meaning of param1 and param2 is message dependent.
+ */
+struct spdm_header {
+	u8 version;
+	u8 code;  /* RequestResponseCode */
+	u8 param1;
+	u8 param2;
+} __packed;
+
+#define SPDM_REQ	 0x80
+#define SPDM_GET_VERSION 0x84
+
+struct spdm_get_version_req {
+	u8 version;
+	u8 code;
+	u8 param1;
+	u8 param2;
+} __packed;
+
+struct spdm_get_version_rsp {
+	u8 version;
+	u8 code;
+	u8 param1;
+	u8 param2;
+
+	u8 reserved;
+	u8 version_number_entry_count;
+	__le16 version_number_entries[] __counted_by(version_number_entry_count);
+} __packed;
+
+#define SPDM_GET_CAPABILITIES 0xe1
+#define SPDM_MIN_DATA_TRANSFER_SIZE 42 /* SPDM 1.2.0 margin no 226 */
+
+/*
+ * Newer SPDM versions insert fields at the end of messages (enlarging them)
+ * or use reserved space for new fields (leaving message size unchanged).
+ */
+struct spdm_get_capabilities_req {
+	u8 version;
+	u8 code;
+	u8 param1;
+	u8 param2;
+	/* End of SPDM 1.0 structure */
+
+	u8 reserved1;					/* 1.1 */
+	u8 ctexponent;					/* 1.1 */
+	u16 reserved2;					/* 1.1 */
+	__le32 flags;					/* 1.1 */
+	/* End of SPDM 1.1 structure */
+
+	__le32 data_transfer_size;			/* 1.2 */
+	__le32 max_spdm_msg_size;			/* 1.2 */
+} __packed;
+
+struct spdm_get_capabilities_rsp {
+	u8 version;
+	u8 code;
+	u8 param1;
+	u8 param2;
+
+	u8 reserved1;
+	u8 ctexponent;
+	u16 reserved2;
+	__le32 flags;
+	/* End of SPDM 1.0 structure */
+
+	__le32 data_transfer_size;			/* 1.2 */
+	__le32 max_spdm_msg_size;			/* 1.2 */
+	/* End of SPDM 1.2 structure */
+
+	/*
+	 * Additional optional fields at end of this structure:
+	 * - SupportedAlgorithms: variable size		 * 1.3 *
+	 */
+} __packed;
+
+#define SPDM_NEGOTIATE_ALGS 0xe3
+
+struct spdm_negotiate_algs_req {
+	u8 version;
+	u8 code;
+	u8 param1; /* Number of ReqAlgStruct entries at end */
+	u8 param2;
+
+	__le16 length;
+	u8 measurement_specification;
+	u8 other_params_support;			/* 1.2 */
+
+	__le32 base_asym_algo;
+	__le32 base_hash_algo;
+
+	u8 reserved1[12];
+	u8 ext_asym_count;
+	u8 ext_hash_count;
+	u8 reserved2;
+	u8 mel_specification;				/* 1.3 */
+
+	/*
+	 * Additional optional fields at end of this structure:
+	 * - ExtAsym: 4 bytes * ext_asym_count
+	 * - ExtHash: 4 bytes * ext_hash_count
+	 * - ReqAlgStruct: variable size * param1	 * 1.1 *
+	 */
+} __packed;
+
+struct spdm_negotiate_algs_rsp {
+	u8 version;
+	u8 code;
+	u8 param1; /* Number of RespAlgStruct entries at end */
+	u8 param2;
+
+	__le16 length;
+	u8 measurement_specification_sel;
+	u8 other_params_sel;				/* 1.2 */
+
+	__le32 measurement_hash_algo;
+	__le32 base_asym_sel;
+	__le32 base_hash_sel;
+
+	u8 reserved1[11];
+	u8 mel_specification_sel;			/* 1.3 */
+	u8 ext_asym_sel_count; /* Either 0 or 1 */
+	u8 ext_hash_sel_count; /* Either 0 or 1 */
+	u8 reserved2[2];
+
+	/*
+	 * Additional optional fields at end of this structure:
+	 * - ExtAsym: 4 bytes * ext_asym_count
+	 * - ExtHash: 4 bytes * ext_hash_count
+	 * - RespAlgStruct: variable size * param1	 * 1.1 *
+	 */
+} __packed;
+
+/* Maximum number of ReqAlgStructs sent by this implementation */
+#define SPDM_MAX_REQ_ALG_STRUCT 0
+
+struct spdm_req_alg_struct {
+	u8 alg_type;
+	u8 alg_count; /* 0x2K where K is number of alg_external entries */
+	__le16 alg_supported; /* Size is in alg_count[7:4], always 2 */
+	__le32 alg_external[];
+} __packed;
+
+#define SPDM_GET_DIGESTS 0x81
+
+struct spdm_get_digests_req {
+	u8 version;
+	u8 code;
+	u8 param1; /* Reserved */
+	u8 param2; /* Reserved */
+} __packed;
+
+struct spdm_get_digests_rsp {
+	u8 version;
+	u8 code;
+	u8 param1; /* SupportedSlotMask */		/* 1.3 */
+	u8 param2; /* ProvisionedSlotMask */
+	u8 digests[]; /* Hash of struct spdm_cert_chain for each slot */
+	/* End of SPDM 1.2 (and earlier) structure */
+
+	/*
+	 * Additional optional fields at end of this structure:
+	 * (omitted as long as we do not advertise MULTI_KEY_CAP)
+	 * - KeyPairID: 1 byte for each slot		 * 1.3 *
+	 * - CertificateInfo: 1 byte for each slot	 * 1.3 *
+	 * - KeyUsageMask: 2 bytes for each slot	 * 1.3 *
+	 */
+} __packed;
+
+#define SPDM_GET_CERTIFICATE 0x82
+#define SPDM_SLOTS 8 /* SPDM 1.0.0 section 4.9.2.1 */
+
+struct spdm_get_certificate_req {
+	u8 version;
+	u8 code;
+	u8 param1; /* Slot number 0..7 */
+	u8 param2; /* SlotSizeRequested */		/* 1.3 */
+	__le16 offset;
+	__le16 length;
+} __packed;
+
+struct spdm_get_certificate_rsp {
+	u8 version;
+	u8 code;
+	u8 param1; /* Slot number 0..7 */
+	u8 param2; /* CertificateInfo */		/* 1.3 */
+	__le16 portion_length;
+	__le16 remainder_length;
+	u8 cert_chain[]; /* PortionLength long */
+} __packed;
+
+struct spdm_cert_chain {
+	__le16 length;
+	u8 reserved[2];
+	/*
+	 * Additional fields at end of this structure:
+	 * - RootHash: Digest of Root Certificate
+	 * - Certificates: Chain of ASN.1 DER-encoded X.509 v3 certificates
+	 */
+} __packed;
+
+#define SPDM_CHALLENGE 0x83
+#define SPDM_NONCE_SZ 32 /* SPDM 1.0.0 table 20 */
+#define SPDM_PREFIX_SZ 64 /* SPDM 1.2.0 margin no 803 */
+#define SPDM_COMBINED_PREFIX_SZ 100 /* SPDM 1.2.0 margin no 806 */
+#define SPDM_MAX_OPAQUE_DATA 1024 /* SPDM 1.0.0 table 21 */
+
+struct spdm_challenge_req {
+	u8 version;
+	u8 code;
+	u8 param1; /* Slot number 0..7 */
+	u8 param2; /* MeasurementSummaryHash type */
+	u8 nonce[SPDM_NONCE_SZ];
+	/* End of SPDM 1.2 (and earlier) structure */
+
+	u8 context[8];					/* 1.3 */
+} __packed;
+
+struct spdm_challenge_rsp {
+	u8 version;
+	u8 code;
+	u8 param1; /* Slot number 0..7 */
+	u8 param2; /* Slot mask */
+	/*
+	 * Additional fields at end of this structure:
+	 * - CertChainHash: Hash of struct spdm_cert_chain for selected slot
+	 * - Nonce: 32 bytes long
+	 * - MeasurementSummaryHash: Optional hash of selected measurements
+	 * - OpaqueDataLength: 2 bytes long
+	 * - OpaqueData: Up to 1024 bytes long
+	 * - RequesterContext: 8 bytes long		 * 1.3 *
+	 *   (inserted, moves Signature field)
+	 * - Signature
+	 */
+} __packed;
+
+#define SPDM_ERROR 0x7f
+
+enum spdm_error_code {
+	SPDM_INVALID_REQUEST		= 0x01,		/* 1.0 */
+	SPDM_INVALID_SESSION		= 0x02,		/* 1.1 only */
+	SPDM_BUSY			= 0x03,		/* 1.0 */
+	SPDM_UNEXPECTED_REQUEST		= 0x04,		/* 1.0 */
+	SPDM_UNSPECIFIED		= 0x05,		/* 1.0 */
+	SPDM_DECRYPT_ERROR		= 0x06,		/* 1.1 */
+	SPDM_UNSUPPORTED_REQUEST	= 0x07,		/* 1.0 */
+	SPDM_REQUEST_IN_FLIGHT		= 0x08,		/* 1.1 */
+	SPDM_INVALID_RESPONSE_CODE	= 0x09,		/* 1.1 */
+	SPDM_SESSION_LIMIT_EXCEEDED	= 0x0a,		/* 1.1 */
+	SPDM_SESSION_REQUIRED		= 0x0b,		/* 1.2 */
+	SPDM_RESET_REQUIRED		= 0x0c,		/* 1.2 */
+	SPDM_RESPONSE_TOO_LARGE		= 0x0d,		/* 1.2 */
+	SPDM_REQUEST_TOO_LARGE		= 0x0e,		/* 1.2 */
+	SPDM_LARGE_RESPONSE		= 0x0f,		/* 1.2 */
+	SPDM_MESSAGE_LOST		= 0x10,		/* 1.2 */
+	SPDM_INVALID_POLICY		= 0x11,		/* 1.3 */
+	SPDM_VERSION_MISMATCH		= 0x41,		/* 1.0 */
+	SPDM_RESPONSE_NOT_READY		= 0x42,		/* 1.0 */
+	SPDM_REQUEST_RESYNCH		= 0x43,		/* 1.0 */
+	SPDM_OPERATION_FAILED		= 0x44,		/* 1.3 */
+	SPDM_NO_PENDING_REQUESTS	= 0x45,		/* 1.3 */
+	SPDM_VENDOR_DEFINED_ERROR	= 0xff,		/* 1.0 */
+};
+
+struct spdm_error_rsp {
+	u8 version;
+	u8 code;
+	enum spdm_error_code error_code:8;
+	u8 error_data;
+
+	u8 extended_error_data[];
+} __packed;
+
+/**
+ * struct spdm_state - SPDM session state
+ *
+ * @dev: Responder device.  Used for error reporting and passed to @transport.
+ * @lock: Serializes multiple concurrent spdm_authenticate() calls.
+ * @authenticated: Whether device was authenticated successfully.
+ * @dev: Responder device.  Used for error reporting and passed to @transport.
+ * @transport: Transport function to perform one message exchange.
+ * @transport_priv: Transport private data.
+ * @transport_sz: Maximum message size the transport is capable of (in bytes).
+ *	Used as DataTransferSize in GET_CAPABILITIES exchange.
+ * @version: Maximum common supported version of requester and responder.
+ *	Negotiated during GET_VERSION exchange.
+ * @rsp_caps: Cached capabilities of responder.
+ *	Received during GET_CAPABILITIES exchange.
+ * @base_asym_alg: Asymmetric key algorithm for signature verification of
+ *	CHALLENGE_AUTH messages.
+ *	Selected by responder during NEGOTIATE_ALGORITHMS exchange.
+ * @base_hash_alg: Hash algorithm for signature verification of
+ *	CHALLENGE_AUTH messages.
+ *	Selected by responder during NEGOTIATE_ALGORITHMS exchange.
+ * @provisioned_slots: Bitmask of responder's provisioned certificate slots.
+ *	Received during GET_DIGESTS exchange.
+ * @base_asym_enc: Human-readable name of @base_asym_alg's signature encoding.
+ *	Passed to crypto subsystem when calling verify_signature().
+ * @sig_len: Signature length of @base_asym_alg (in bytes).
+ *	S or SigLen in SPDM specification.
+ * @base_hash_alg_name: Human-readable name of @base_hash_alg.
+ *	Passed to crypto subsystem when calling crypto_alloc_shash() and
+ *	verify_signature().
+ * @shash: Synchronous hash handle for @base_hash_alg computation.
+ * @desc: Synchronous hash context for @base_hash_alg computation.
+ * @hash_len: Hash length of @base_hash_alg (in bytes).
+ *	H in SPDM specification.
+ * @slot: Certificate chain in each of the 8 slots.  NULL pointer if a slot is
+ *	not populated.  Prefixed by the 4 + H header per SPDM 1.0.0 table 15.
+ * @slot_sz: Certificate chain size (in bytes).
+ * @leaf_key: Public key portion of leaf certificate against which to check
+ *	responder's signatures.
+ * @root_keyring: Keyring against which to check the first certificate in
+ *	responder's certificate chain.
+ * @transcript: Concatenation of all SPDM messages exchanged during an
+ *	authentication sequence.  Used to verify the signature, as it is
+ *	computed over the hashed transcript.
+ * @transcript_end: Pointer into the @transcript buffer.  Marks the current
+ *	end of transcript.  If another message is transmitted, it is appended
+ *	at this position.
+ * @transcript_max: Allocation size of @transcript.  Multiple of PAGE_SIZE.
+ */
+struct spdm_state {
+	struct device *dev;
+	struct mutex lock;
+	unsigned int authenticated:1;
+
+	/* Transport */
+	spdm_transport *transport;
+	void *transport_priv;
+	u32 transport_sz;
+
+	/* Negotiated state */
+	u8 version;
+	u32 rsp_caps;
+	u32 base_asym_alg;
+	u32 base_hash_alg;
+	unsigned long provisioned_slots;
+
+	/* Signature algorithm */
+	const char *base_asym_enc;
+	size_t sig_len;
+
+	/* Hash algorithm */
+	const char *base_hash_alg_name;
+	struct crypto_shash *shash;
+	struct shash_desc *desc;
+	size_t hash_len;
+
+	/* Certificates */
+	struct spdm_cert_chain *slot[SPDM_SLOTS];
+	size_t slot_sz[SPDM_SLOTS];
+	struct public_key *leaf_key;
+	struct key *root_keyring;
+
+	/* Transcript */
+	void *transcript;
+	void *transcript_end;
+	size_t transcript_max;
+};
+
+ssize_t spdm_exchange(struct spdm_state *spdm_state,
+		      void *req, size_t req_sz, void *rsp, size_t rsp_sz);
+
+int spdm_alloc_transcript(struct spdm_state *spdm_state);
+void spdm_free_transcript(struct spdm_state *spdm_state);
+int spdm_append_transcript(struct spdm_state *spdm_state,
+			   const void *msg, size_t msg_sz);
+
+void spdm_create_combined_prefix(u8 version, const char *spdm_context,
+				 void *buf);
+int spdm_verify_signature(struct spdm_state *spdm_state,
+			  const char *spdm_context);
+
+void spdm_reset(struct spdm_state *spdm_state);
+
+#endif /* _LIB_SPDM_H_ */
-- 
2.43.0


