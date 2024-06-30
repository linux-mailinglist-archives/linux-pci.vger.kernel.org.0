Return-Path: <linux-pci+bounces-9484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0D091D3F4
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 22:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95B82815B1
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 20:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D77153800;
	Sun, 30 Jun 2024 20:31:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD703A268;
	Sun, 30 Jun 2024 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719779500; cv=none; b=hT0y8jHmJC1v5v/bJowDZihAdFNinEg2/YUh7L/k9uiuz9lKa4HuWyjWHrCFtb5eWYw2hb/LTR9S3MKKqPNIeHv3EENBS/rkUlOULT5vSvaM3LDhjuXONdCiFfpBUhn7TdxmxNDEKjkLGxpJtJnnuawvWeG4sc8h3xbS8rt4meg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719779500; c=relaxed/simple;
	bh=wAoIc602GTzvToc6h/6z0r5MEBnGNorL/xibzZCdKHs=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=ABwb0GwrgVTDI6IXoeQIkoeWdfCB57P4zu5uKwB7HNbTRS9aH49iLMGAdVoR1WifRFCqGROlQS4wmBy/1Nv3Ly9JvCJ3ID/YVM7zZFn8rl4TQkcmCX1dRWE4WbEVVXbD09JxZIyGKkvxYGFNxGyo+MpFefIjhnAE0z83HKUoju0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 3C55110189B98;
	Sun, 30 Jun 2024 22:31:36 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 0EF6061DA805;
	Sun, 30 Jun 2024 22:31:36 +0200 (CEST)
X-Mailbox-Line: From dff8bcb091a3123e1c7c685f8149595e39bbdb8f Mon Sep 17 00:00:00 2001
Message-ID: <dff8bcb091a3123e1c7c685f8149595e39bbdb8f.1719771133.git.lukas@wunner.de>
In-Reply-To: <cover.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 30 Jun 2024 21:52:00 +0200
Subject: [PATCH v2 17/18] spdm: Authenticate devices despite invalid
 certificate chain
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Cc: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair Francis <alistair.francis@wdc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, "Damien Le Moal" <dlemoal@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The SPDM library has just been amended to keep a log of received
signatures from a device and expose it in sysfs.

Currently challenge-response authentication with a device is only
performed if one of its up to 8 certificate chains is considered valid
by the kernel.

Valid means several things:

* That the certificate chain adheres to requirements in the SPDM
  specification (e.g. each certificate in the chain is signed by the
  preceding certificate),
* that the certificate chain adheres to requirements in other
  specifications such as PCIe r6.1 sec 6.31.3,
* that the first certificate in the chain is signed by a trusted root
  certificate on the kernel's keyring
* or that none of the certificates in the chain is on the kernel's
  blacklist_keyring.

User space should be given the chance to make up its own mind on the
validity of a certificate chain and the signature generated with it.
So if none of the 8 certificate chains is considered valid by the
kernel, pick one of them and perform challenge-response authentication
with it for the sole purpose of exposing a signature to user space.

Do not verify that signature because if the kernel considers the
certificate chain invalid, the signature implicitly is as well.

Arbitrarily select the certificate chain in the first provisioned slot
(which is normally slot 0) for such "for user space only" authentication
attempts.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
I'd like to know whether people actually find this feature useful.
The patch is somewhat tentative and I may drop it if there is no interest,
so comments welcome!

 Documentation/ABI/testing/sysfs-devices-spdm |  5 +++
 lib/spdm/req-authenticate.c                  | 38 +++++++++++++-------
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-spdm b/Documentation/ABI/testing/sysfs-devices-spdm
index 8d8ee01672e1..5ce34ce10b9c 100644
--- a/Documentation/ABI/testing/sysfs-devices-spdm
+++ b/Documentation/ABI/testing/sysfs-devices-spdm
@@ -162,6 +162,11 @@ Description:
 		dissector needs to be fed the concatenation of "transcript"
 		and "signature".
 
+		Signatures are added to the log even if the kernel was unable
+		to verify them (e.g. due to a missing trusted root certificate
+		or forged signature).  Thereby, remote attestation services
+		may make up their own mind on the signature's validity.
+
 		Because the number prefixed to the filenames is 32 bit, it
 		wraps around to 0 after 4,294,967,295 signatures.  The kernel
 		avoids filename collisions on wraparound by purging old files,
diff --git a/lib/spdm/req-authenticate.c b/lib/spdm/req-authenticate.c
index 0c74dc0e5cf4..7c977f5835c1 100644
--- a/lib/spdm/req-authenticate.c
+++ b/lib/spdm/req-authenticate.c
@@ -615,7 +615,7 @@ static size_t spdm_challenge_rsp_sz(struct spdm_state *spdm_state,
 	return  size  + spdm_state->sig_len;	/* Signature */
 }
 
-static int spdm_challenge(struct spdm_state *spdm_state, u8 slot)
+static int spdm_challenge(struct spdm_state *spdm_state, u8 slot, bool verify)
 {
 	size_t req_sz, rsp_sz, rsp_sz_max, req_nonce_off, rsp_nonce_off;
 	struct spdm_challenge_rsp *rsp __free(kfree);
@@ -661,14 +661,19 @@ static int spdm_challenge(struct spdm_state *spdm_state, u8 slot)
 	if (rc)
 		return rc;
 
-	/* Verify signature at end of transcript against leaf key */
-	rc = spdm_verify_signature(spdm_state, spdm_context);
-	if (rc)
-		dev_err(spdm_state->dev,
-			"Cannot verify challenge_auth signature: %d\n", rc);
-	else
-		dev_info(spdm_state->dev,
-			 "Authenticated with certificate slot %u\n", slot);
+	rc = -EKEYREJECTED;
+	if (verify) {
+		/* Verify signature at end of transcript against leaf key */
+		rc = spdm_verify_signature(spdm_state, spdm_context);
+		if (rc)
+			dev_err(spdm_state->dev,
+				"Cannot verify challenge_auth signature: %d\n",
+				rc);
+		else
+			dev_info(spdm_state->dev,
+				 "Authenticated with certificate slot %u\n",
+				 slot);
+	}
 
 	spdm_create_log_entry(spdm_state, spdm_context, slot,
 			      req_nonce_off, rsp_nonce_off);
@@ -692,6 +697,7 @@ static int spdm_challenge(struct spdm_state *spdm_state, u8 slot)
  */
 int spdm_authenticate(struct spdm_state *spdm_state)
 {
+	bool verify = false;
 	u8 slot;
 	int rc;
 
@@ -726,13 +732,21 @@ int spdm_authenticate(struct spdm_state *spdm_state)
 
 	for_each_set_bit(slot, &spdm_state->provisioned_slots, SPDM_SLOTS) {
 		rc = spdm_validate_cert_chain(spdm_state, slot);
-		if (rc == 0)
+		if (rc == 0) {
+			verify = true;
 			break;
+		}
 	}
+
+	/*
+	 * If no cert chain validates, perform challenge-response with
+	 * arbitrary slot to be able to expose a signature in sysfs
+	 * about which user space can make up its own mind.
+	 */
 	if (rc)
-		goto unlock;
+		slot = __ffs(spdm_state->provisioned_slots);
 
-	rc = spdm_challenge(spdm_state, slot);
+	rc = spdm_challenge(spdm_state, slot, verify);
 
 unlock:
 	if (rc)
-- 
2.43.0


