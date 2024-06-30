Return-Path: <linux-pci+bounces-9470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAD191D3B7
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 22:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692DD1C208B5
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 20:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C2826AC9;
	Sun, 30 Jun 2024 20:02:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9880E347A2;
	Sun, 30 Jun 2024 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719777748; cv=none; b=X+IY4eRSp+zNJqGthZSsZk5wM/dxQ9dCLuXu42t/t+ojPQoHtyVnfoaXxdDT+6OfzrzLM8R1SnyZpfp5PyCEW2nhyd8pI9lzYUT4Ss3iEmFV6ScYzRYKw11cv/A93fsQi7YBeJBGQsYzj/3rxzrW4Et7MtVx4PHs52NbFeqDqS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719777748; c=relaxed/simple;
	bh=WWq+5OJcGEmUfUFrgruPJrtTAOjHBRQIseKELq2K224=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=CELwTK8lT24nXOdP8fji9BBx2bIJT7K9mT2O4/3d1KGMjjMYNfUJSlaj1pTcFu9xr00NUGJcJNoKii2TsHEuR3SnfF6K7R4QXcr3Zwg2IEQbHq8YOFBXAHUCNSvBmfY8dG6ZUqcZaP1tB3XFQO1nf+L0TwP0Fhd3zqIwTdUD2/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 5912710190FA3;
	Sun, 30 Jun 2024 22:02:24 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 22E2861DA805;
	Sun, 30 Jun 2024 22:02:24 +0200 (CEST)
X-Mailbox-Line: From cf34e283103de55b07fcddcbe39b60ea32b6d891 Mon Sep 17 00:00:00 2001
Message-ID: <cf34e283103de55b07fcddcbe39b60ea32b6d891.1719771133.git.lukas@wunner.de>
In-Reply-To: <cover.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 30 Jun 2024 21:38:00 +0200
Subject: [PATCH v2 03/18] X.509: Move certificate length retrieval into new
 helper
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Cc: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair Francis <alistair.francis@wdc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, "Damien Le Moal" <dlemoal@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, Eric Biggers <ebiggers@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The upcoming in-kernel SPDM library (Security Protocol and Data Model,
https://www.dmtf.org/dsp/DSP0274) needs to retrieve the length from
ASN.1 DER-encoded X.509 certificates.

Such code already exists in x509_load_certificate_list(), so move it
into a new helper for reuse by SPDM.

Export the helper so that SPDM can be tristate.  (Some upcoming users of
the SPDM libray may be modular, such as SCSI and ATA.)

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 crypto/asymmetric_keys/x509_loader.c | 38 +++++++++++++++++++---------
 include/keys/asymmetric-type.h       |  2 ++
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/crypto/asymmetric_keys/x509_loader.c b/crypto/asymmetric_keys/x509_loader.c
index a41741326998..25ff027fad1d 100644
--- a/crypto/asymmetric_keys/x509_loader.c
+++ b/crypto/asymmetric_keys/x509_loader.c
@@ -4,28 +4,42 @@
 #include <linux/key.h>
 #include <keys/asymmetric-type.h>
 
+ssize_t x509_get_certificate_length(const u8 *p, unsigned long buflen)
+{
+	ssize_t plen;
+
+	/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
+	 * than 256 bytes in size.
+	 */
+	if (buflen < 4)
+		return -EINVAL;
+
+	if (p[0] != 0x30 &&
+	    p[1] != 0x82)
+		return -EINVAL;
+
+	plen = (p[2] << 8) | p[3];
+	plen += 4;
+	if (plen > buflen)
+		return -EINVAL;
+
+	return plen;
+}
+EXPORT_SYMBOL_GPL(x509_get_certificate_length);
+
 int x509_load_certificate_list(const u8 cert_list[],
 			       const unsigned long list_size,
 			       const struct key *keyring)
 {
 	key_ref_t key;
 	const u8 *p, *end;
-	size_t plen;
+	ssize_t plen;
 
 	p = cert_list;
 	end = p + list_size;
 	while (p < end) {
-		/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
-		 * than 256 bytes in size.
-		 */
-		if (end - p < 4)
-			goto dodgy_cert;
-		if (p[0] != 0x30 &&
-		    p[1] != 0x82)
-			goto dodgy_cert;
-		plen = (p[2] << 8) | p[3];
-		plen += 4;
-		if (plen > end - p)
+		plen = x509_get_certificate_length(p, end - p);
+		if (plen < 0)
 			goto dodgy_cert;
 
 		key = key_create_or_update(make_key_ref(keyring, 1),
diff --git a/include/keys/asymmetric-type.h b/include/keys/asymmetric-type.h
index 69a13e1e5b2e..e2af07fec3c6 100644
--- a/include/keys/asymmetric-type.h
+++ b/include/keys/asymmetric-type.h
@@ -84,6 +84,8 @@ extern struct key *find_asymmetric_key(struct key *keyring,
 				       const struct asymmetric_key_id *id_2,
 				       bool partial);
 
+ssize_t x509_get_certificate_length(const u8 *p, unsigned long buflen);
+
 int x509_load_certificate_list(const u8 cert_list[], const unsigned long list_size,
 			       const struct key *keyring);
 
-- 
2.43.0


