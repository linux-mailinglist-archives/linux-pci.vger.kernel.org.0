Return-Path: <linux-pci+bounces-9485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6974691D3F7
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 22:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A691C20BD0
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 20:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486DB152E06;
	Sun, 30 Jun 2024 20:33:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1CF3A268;
	Sun, 30 Jun 2024 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719779605; cv=none; b=P9oZdDgnu7SI89ATTx9nhFYmehrx2guxShSp+hXflX+bgkEuc7ibne8i7x3yHRvWTOJKLjJqhAiZHXyZ0JRfGDsX3XVfzslzIGPBr0gRD+piop2+sSOiL1eKINHTTBsvUq8uQgPUCW16VT5b9emi5Dt8/YDpz/edgPpo6yjPjtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719779605; c=relaxed/simple;
	bh=7nuE1KfZ+7BNLKWM9fT+4fbsltUVH8PuI92OwB6eteQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=bY9il4UbsepH1sOch2Di88v1VHHwrsQ31/gllWcC/4ULW8d2a6AAG4LDzTd7PWu0UrtHfoEZUfehGjyWH1y9LfGvBn5Dn8JOdZuX+G6w+50QCe3TF9WIWA6RFWb9Hw0olnysYukaMTu0aQn2t/yUoI0PJFJDF99E/rM57r/hLWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 2A571101917A3;
	Sun, 30 Jun 2024 22:33:21 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id E400161DA805;
	Sun, 30 Jun 2024 22:33:20 +0200 (CEST)
X-Mailbox-Line: From ee3248f9f8d60cff9106a5a46c5f5d53ac81e60a Mon Sep 17 00:00:00 2001
Message-ID: <ee3248f9f8d60cff9106a5a46c5f5d53ac81e60a.1719771133.git.lukas@wunner.de>
In-Reply-To: <cover.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 30 Jun 2024 21:53:00 +0200
Subject: [PATCH v2 18/18] spdm: Allow control of next requester nonce through
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
Cc: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair Francis <alistair.francis@wdc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, "Damien Le Moal" <dlemoal@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>

Remote attestation services may mistrust the kernel to always use a
fresh nonce for SPDM authentication.

So allow user space to set the next requester nonce by writing to a
sysfs attribute.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jérôme Glisse <jglisse@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/ABI/testing/sysfs-devices-spdm | 29 ++++++++++++++++
 lib/spdm/core.c                              |  1 +
 lib/spdm/req-authenticate.c                  |  8 ++++-
 lib/spdm/req-sysfs.c                         | 35 ++++++++++++++++++++
 lib/spdm/spdm.h                              |  4 +++
 5 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-spdm b/Documentation/ABI/testing/sysfs-devices-spdm
index 5ce34ce10b9c..d315b47b4af0 100644
--- a/Documentation/ABI/testing/sysfs-devices-spdm
+++ b/Documentation/ABI/testing/sysfs-devices-spdm
@@ -216,3 +216,32 @@ Description:
 		necessary to parse the SPDM messages in the transcript to find
 		and extract the nonces, which is cumbersome.  That's why they
 		are exposed as separate files.
+
+
+What:		/sys/devices/.../signatures/next_requester_nonce
+Date:		June 2024
+Contact:	Lukas Wunner <lukas@wunner.de>
+Description:
+		If you do not trust the kernel to always use a fresh nonce,
+		write 32 bytes to this file to set the requester nonce used
+		in the next SPDM authentication sequence.
+
+		Meant for remote attestation services.  You are responsible
+		for providing a nonce with sufficient entropy.  The kernel
+		only uses the nonce once, so provide a new one every time
+		you reauthenticate the device.  If you do not provide a
+		nonce, the kernel generates a random one.
+
+		After the nonce has been consumed, it becomes readable as
+		the newest [0-9]*_requester_nonce, which proves its usage::
+
+		 # dd if=/dev/random bs=32 count=1 | \
+		   tee signatures/next_requester_nonce | hexdump
+		 0000000 e0 77 91 54 bd 56 99 c2 ea 4f 0b 1a 7f ba 6e 59
+		 0000010 8f ee f6 b2 26 82 58 34 9e e5 8c 8a 31 58 29 7e
+
+		 # echo re > authenticated
+
+		 # hexdump $(\ls -t signatures/[0-9]*_requester_nonce | head -1)
+		 0000000 e0 77 91 54 bd 56 99 c2 ea 4f 0b 1a 7f ba 6e 59
+		 0000010 8f ee f6 b2 26 82 58 34 9e e5 8c 8a 31 58 29 7e
diff --git a/lib/spdm/core.c b/lib/spdm/core.c
index b6a46bdbb2f9..7371adb7a52f 100644
--- a/lib/spdm/core.c
+++ b/lib/spdm/core.c
@@ -434,6 +434,7 @@ void spdm_destroy(struct spdm_state *spdm_state)
 	spdm_reset(spdm_state);
 	spdm_destroy_log(spdm_state);
 	mutex_destroy(&spdm_state->lock);
+	kfree(spdm_state->next_nonce);
 	kfree(spdm_state);
 }
 EXPORT_SYMBOL_GPL(spdm_destroy);
diff --git a/lib/spdm/req-authenticate.c b/lib/spdm/req-authenticate.c
index 7c977f5835c1..489fc88de74d 100644
--- a/lib/spdm/req-authenticate.c
+++ b/lib/spdm/req-authenticate.c
@@ -626,7 +626,13 @@ static int spdm_challenge(struct spdm_state *spdm_state, u8 slot, bool verify)
 	};
 	int rc, length;
 
-	get_random_bytes(&req.nonce, sizeof(req.nonce));
+	if (spdm_state->next_nonce) {
+		memcpy(&req.nonce, spdm_state->next_nonce, sizeof(req.nonce));
+		kfree(spdm_state->next_nonce);
+		spdm_state->next_nonce = NULL;
+	} else {
+		get_random_bytes(&req.nonce, sizeof(req.nonce));
+	}
 
 	if (spdm_state->version <= 0x12)
 		req_sz = offsetofend(typeof(req), nonce);
diff --git a/lib/spdm/req-sysfs.c b/lib/spdm/req-sysfs.c
index c782054f8e18..232d4a00a510 100644
--- a/lib/spdm/req-sysfs.c
+++ b/lib/spdm/req-sysfs.c
@@ -176,13 +176,48 @@ const struct attribute_group spdm_certificates_group = {
 
 /* signatures attributes */
 
+static umode_t spdm_signatures_are_visible(struct kobject *kobj,
+					   struct bin_attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct spdm_state *spdm_state = dev_to_spdm_state(dev);
+
+	if (IS_ERR_OR_NULL(spdm_state))
+		return SYSFS_GROUP_INVISIBLE;
+
+	return a->attr.mode;
+}
+
+static ssize_t next_requester_nonce_write(struct file *file,
+					  struct kobject *kobj,
+					  struct bin_attribute *attr,
+					  char *buf, loff_t off, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct spdm_state *spdm_state = dev_to_spdm_state(dev);
+
+	guard(mutex)(&spdm_state->lock);
+
+	if (!spdm_state->next_nonce) {
+		spdm_state->next_nonce = kmalloc(SPDM_NONCE_SZ, GFP_KERNEL);
+		if (!spdm_state->next_nonce)
+			return -ENOMEM;
+	}
+
+	memcpy(spdm_state->next_nonce + off, buf, count);
+	return count;
+}
+static BIN_ATTR_WO(next_requester_nonce, SPDM_NONCE_SZ);
+
 static struct bin_attribute *spdm_signatures_bin_attrs[] = {
+	&bin_attr_next_requester_nonce,
 	NULL
 };
 
 const struct attribute_group spdm_signatures_group = {
 	.name = "signatures",
 	.bin_attrs = spdm_signatures_bin_attrs,
+	.is_bin_visible = spdm_signatures_are_visible,
 };
 
 static unsigned int spdm_max_log_sz = SZ_16M; /* per device */
diff --git a/lib/spdm/spdm.h b/lib/spdm/spdm.h
index 448107c92db7..aa36aa55e718 100644
--- a/lib/spdm/spdm.h
+++ b/lib/spdm/spdm.h
@@ -475,6 +475,9 @@ struct spdm_error_rsp {
  *	itself and the transcript with trailing signature.
  * @log_counter: Number of generated log entries so far.  Will be prefixed to
  *	the sysfs files of the next generated log entry.
+ * @next_nonce: Requester nonce to be used for the next authentication
+ *	sequence.  Populated from user space through sysfs.
+ *	If user space does not provide a nonce, the kernel uses a random one.
  */
 struct spdm_state {
 	struct device *dev;
@@ -521,6 +524,7 @@ struct spdm_state {
 	struct list_head log;
 	size_t log_sz;
 	u32 log_counter;
+	u8 *next_nonce;
 };
 
 extern struct list_head spdm_state_list;
-- 
2.43.0


