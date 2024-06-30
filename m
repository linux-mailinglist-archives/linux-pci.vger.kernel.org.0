Return-Path: <linux-pci+bounces-9479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FDF91D3DF
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 22:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C2F1C20B89
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 20:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A64F13B59F;
	Sun, 30 Jun 2024 20:24:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0F3200C1;
	Sun, 30 Jun 2024 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719779083; cv=none; b=g2yk2aUhSXdtBr+QZCznP+UlAXwuEGD61irlY4zWA0Bgovoq8tk59Nn2/4Kxiew9B1aRH2Lc7/X7GyZgSxYLuG8YosYld6CHaU4B9tzBz5vnB6BoDGlZDLG1Gj8m1WBo1SPKCibE7cVCqWVn5M4Jefz0z+1m04KVmGlfMBF08ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719779083; c=relaxed/simple;
	bh=oXGJX2YYk1F9H/65jxNpeC6GiIRSjtENXXD9z/PAYEs=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=ufcN5iIMlilOXdIxgGT5fopwj1B6t5Hg3ZR3Ln7gPrWZuznUM0uBte9HiGbopUw04YUaVZ9pMLBDU8l1nqFP6uTbqzE4C/U4DlThXRSVvpOOUZWZyVAGe8fe0MewJHYfYYiNkECQxyRVWK27rkKBdlQSUtrLXlntPin2qQfRwE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 12F8610189C6B;
	Sun, 30 Jun 2024 22:24:39 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id C0E0861DA805;
	Sun, 30 Jun 2024 22:24:38 +0200 (CEST)
X-Mailbox-Line: From e42905e3e5f1d5be39355e833fefc349acb0b03c Mon Sep 17 00:00:00 2001
Message-ID: <e42905e3e5f1d5be39355e833fefc349acb0b03c.1719771133.git.lukas@wunner.de>
In-Reply-To: <cover.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 30 Jun 2024 21:47:00 +0200
Subject: [PATCH v2 12/18] PCI/CMA: Expose certificates in sysfs
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Cc: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair Francis <alistair.francis@wdc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, "Damien Le Moal" <dlemoal@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The kernel already caches certificate chains retrieved from a device
upon authentication.  Expose them in "slot[0-7]" files in sysfs for
examination by user space.

As noted in the ABI documentation, the "slot[0-7]" files always have a
file size of 65535 bytes (the maximum size of a certificate chain per
SPDM 1.0.0 table 18), even if the certificate chain in the slot is
actually smaller.  Although it would be possible to use the certifiate
chain's actual size as the file size, doing so would require a separate
struct attribute_group for each device, which would occupy additional
memory.

Slots are visible in sysfs even if they're currently unprovisioned
because a future commit will add support for certificate provisioning
by writing to the "slot[0-7]" files.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 Documentation/ABI/testing/sysfs-devices-spdm | 49 ++++++++++++
 drivers/pci/pci-sysfs.c                      |  1 +
 include/linux/spdm.h                         |  1 +
 lib/spdm/req-authenticate.c                  | 30 +++++++-
 lib/spdm/req-sysfs.c                         | 80 ++++++++++++++++++++
 lib/spdm/spdm.h                              |  3 +
 6 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-spdm b/Documentation/ABI/testing/sysfs-devices-spdm
index 2d6e5d513231..ed61405770d6 100644
--- a/Documentation/ABI/testing/sysfs-devices-spdm
+++ b/Documentation/ABI/testing/sysfs-devices-spdm
@@ -29,3 +29,52 @@ Description:
 		The reason why authentication support could not be determined
 		is apparent from "dmesg".  To re-probe authentication support
 		of PCI devices, exercise the "remove" and "rescan" attributes.
+
+
+What:		/sys/devices/.../certificates/
+What:		/sys/devices/.../certificates/slot[0-7]
+Date:		June 2024
+Contact:	Lukas Wunner <lukas@wunner.de>
+Description:
+		The "certificates" directory provides access to the certificate
+		chains contained in the up to 8 slots of a device.
+
+		A certificate chain is the concatenation of one or more ASN.1
+		DER-encoded X.509 v3 certificates (SPDM 1.0.0 sec 4.9.2.1).
+		It can be examined as follows::
+
+		 # openssl storeutl -text certificates/slot0
+
+		A common use case is to add the first certificate in a chain
+		to the keyring of trusted root certificates (".cma" in this
+		example) after comparing its fingerprint to the one provided
+		by the device manufacturer::
+
+		 # openssl x509 -in certificates/slot0 -fingerprint -nocert
+		 # openssl x509 -in certificates/slot0 -outform DER | \
+		   keyctl padd asymmetric "" %:.cma
+		 # echo re > authenticated
+
+		The file size of each slot is always 65535 bytes (the maximum
+		size of a certificate chain per SPDM 1.0.0 table 18), even if
+		the certificate chain in the slot is actually smaller.
+
+		Unprovisioned slots are represented as empty files.
+
+		Unsupported slots (introduced by SPDM 1.3 margin no 366) are
+		not visible.  If the device only supports SPDM version 1.2 or
+		earlier, all 8 slots are assumed to be supported and therefore
+		visible.
+
+		The kernel learns which slots are supported when authenticating
+		the device for the first time.  Hence, no slots are visible
+		until at least one authentication attempt has been performed.
+
+		SPDM doesn't support on-demand retrieval of certificate chains,
+		so the kernel caches them when (re-)authenticating the device.
+		SPDM allows provisioning slots behind the kernel's back by
+		sending a SET_CERTIFICATE request through a different transport
+		(e.g. via MCTP from a Baseboard Management Controller).
+		SPDM does not specify how to notify the kernel of such events,
+		so unless reauthentication is manually initiated to update the
+		kernel's cache, the "slot[0-7]" files may contain stale data.
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d9e467cbec6e..a85388211104 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1664,6 +1664,7 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 #endif
 #ifdef CONFIG_PCI_CMA
 	&spdm_attr_group,
+	&spdm_certificates_group,
 #endif
 	NULL,
 };
diff --git a/include/linux/spdm.h b/include/linux/spdm.h
index 9835a3202a0e..97c7d4feab76 100644
--- a/include/linux/spdm.h
+++ b/include/linux/spdm.h
@@ -35,5 +35,6 @@ int spdm_authenticate(struct spdm_state *spdm_state);
 void spdm_destroy(struct spdm_state *spdm_state);
 
 extern const struct attribute_group spdm_attr_group;
+extern const struct attribute_group spdm_certificates_group;
 
 #endif
diff --git a/lib/spdm/req-authenticate.c b/lib/spdm/req-authenticate.c
index 90f7a7f2629c..1f701d07ad46 100644
--- a/lib/spdm/req-authenticate.c
+++ b/lib/spdm/req-authenticate.c
@@ -14,6 +14,7 @@
 #include "spdm.h"
 
 #include <linux/dev_printk.h>
+#include <linux/device.h>
 #include <linux/key.h>
 #include <linux/random.h>
 
@@ -288,9 +289,9 @@ static int spdm_get_digests(struct spdm_state *spdm_state)
 	struct spdm_get_digests_req *req = spdm_state->transcript_end;
 	struct spdm_get_digests_rsp *rsp;
 	unsigned long deprovisioned_slots;
+	u8 slot, supported_slots;
 	int rc, length;
 	size_t rsp_sz;
-	u8 slot;
 
 	*req = (struct spdm_get_digests_req) {
 		.code = SPDM_GET_DIGESTS,
@@ -338,6 +339,33 @@ static int spdm_get_digests(struct spdm_state *spdm_state)
 		return -EPROTO;
 	}
 
+	/*
+	 * If a bit is set in ProvisionedSlotMask, the corresponding bit in
+	 * SupportedSlotMask shall also be set (SPDM 1.3.0 table 35).
+	 */
+	if (spdm_state->version >= 0x13 && rsp->param2 & ~rsp->param1) {
+		dev_err(spdm_state->dev, "Malformed digests response\n");
+		return -EPROTO;
+	}
+
+	if (spdm_state->version >= 0x13)
+		supported_slots = rsp->param1;
+	else
+		supported_slots = GENMASK(7, 0);
+
+	if (spdm_state->supported_slots != supported_slots) {
+		spdm_state->supported_slots = supported_slots;
+
+		if (device_is_registered(spdm_state->dev)) {
+			rc = sysfs_update_group(&spdm_state->dev->kobj,
+						&spdm_certificates_group);
+			if (rc)
+				dev_err(spdm_state->dev,
+					"Cannot update certificates in sysfs: "
+					"%d\n", rc);
+		}
+	}
+
 	return 0;
 }
 
diff --git a/lib/spdm/req-sysfs.c b/lib/spdm/req-sysfs.c
index 9bbed7abc153..afba3c5a2e8f 100644
--- a/lib/spdm/req-sysfs.c
+++ b/lib/spdm/req-sysfs.c
@@ -93,3 +93,83 @@ const struct attribute_group spdm_attr_group = {
 	.attrs = spdm_attrs,
 	.is_visible = spdm_attrs_are_visible,
 };
+
+/* certificates attributes */
+
+static umode_t spdm_certificates_are_visible(struct kobject *kobj,
+					     struct bin_attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct spdm_state *spdm_state = dev_to_spdm_state(dev);
+	u8 slot = a->attr.name[4] - '0';
+
+	if (IS_ERR_OR_NULL(spdm_state))
+		return SYSFS_GROUP_INVISIBLE;
+
+	if (!(spdm_state->supported_slots & BIT(slot)))
+		return 0;
+
+	return a->attr.mode;
+}
+
+static ssize_t spdm_cert_read(struct file *file, struct kobject *kobj,
+			      struct bin_attribute *a, char *buf, loff_t off,
+			      size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct spdm_state *spdm_state = dev_to_spdm_state(dev);
+	u8 slot = a->attr.name[4] - '0';
+	size_t header_size, cert_size;
+
+	/*
+	 * Serialize with spdm_authenticate() as it may change hash_len,
+	 * slot_sz[] and slot[] members in struct spdm_state.
+	 */
+	guard(mutex)(&spdm_state->lock);
+
+	/*
+	 * slot[] is prefixed by the 4 + H header per SPDM 1.0.0 table 15.
+	 * The header is not exposed to user space, only the certificates are.
+	 */
+	header_size = sizeof(struct spdm_cert_chain) + spdm_state->hash_len;
+	cert_size = spdm_state->slot_sz[slot] - header_size;
+
+	if (!spdm_state->slot[slot])
+		return 0;
+	if (!count)
+		return 0;
+	if (off > cert_size)
+		return 0;
+	if (off + count > cert_size)
+		count = cert_size - off;
+
+	memcpy(buf, (u8 *)spdm_state->slot[slot] + header_size + off, count);
+	return count;
+}
+
+static BIN_ATTR(slot0, 0444, spdm_cert_read, NULL, 0xffff);
+static BIN_ATTR(slot1, 0444, spdm_cert_read, NULL, 0xffff);
+static BIN_ATTR(slot2, 0444, spdm_cert_read, NULL, 0xffff);
+static BIN_ATTR(slot3, 0444, spdm_cert_read, NULL, 0xffff);
+static BIN_ATTR(slot4, 0444, spdm_cert_read, NULL, 0xffff);
+static BIN_ATTR(slot5, 0444, spdm_cert_read, NULL, 0xffff);
+static BIN_ATTR(slot6, 0444, spdm_cert_read, NULL, 0xffff);
+static BIN_ATTR(slot7, 0444, spdm_cert_read, NULL, 0xffff);
+
+static struct bin_attribute *spdm_certificates_bin_attrs[] = {
+	&bin_attr_slot0,
+	&bin_attr_slot1,
+	&bin_attr_slot2,
+	&bin_attr_slot3,
+	&bin_attr_slot4,
+	&bin_attr_slot5,
+	&bin_attr_slot6,
+	&bin_attr_slot7,
+	NULL
+};
+
+const struct attribute_group spdm_certificates_group = {
+	.name = "certificates",
+	.bin_attrs = spdm_certificates_bin_attrs,
+	.is_bin_visible = spdm_certificates_are_visible,
+};
diff --git a/lib/spdm/spdm.h b/lib/spdm/spdm.h
index 0992b2bc3942..6c426b2be372 100644
--- a/lib/spdm/spdm.h
+++ b/lib/spdm/spdm.h
@@ -436,6 +436,8 @@ struct spdm_error_rsp {
  * @base_hash_alg: Hash algorithm for signature verification of
  *	CHALLENGE_AUTH messages.
  *	Selected by responder during NEGOTIATE_ALGORITHMS exchange.
+ * @supported_slots: Bitmask of responder's supported certificate slots.
+ *	Received during GET_DIGESTS exchange (from SPDM 1.3).
  * @provisioned_slots: Bitmask of responder's provisioned certificate slots.
  *	Received during GET_DIGESTS exchange.
  * @base_asym_enc: Human-readable name of @base_asym_alg's signature encoding.
@@ -480,6 +482,7 @@ struct spdm_state {
 	u32 rsp_caps;
 	u32 base_asym_alg;
 	u32 base_hash_alg;
+	unsigned long supported_slots;
 	unsigned long provisioned_slots;
 
 	/* Signature algorithm */
-- 
2.43.0


