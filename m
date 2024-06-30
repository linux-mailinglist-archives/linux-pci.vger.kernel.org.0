Return-Path: <linux-pci+bounces-9483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D8F91D3F1
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 22:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6400D1F21531
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 20:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC0C152E05;
	Sun, 30 Jun 2024 20:30:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AEC39FD0;
	Sun, 30 Jun 2024 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719779426; cv=none; b=kmnMDfZg7f8WMlu0ZSN9lVLC1tCbZqlADul+glRykGn7ZV5rXY9fjNlbBRPyF+NOV3ibnOUsIa43eHO1qWom0cxAoiTvQxA5Rd3jhxyKL0RXoGSqWMia2aZWWFuI6EMF2mlfsMKVngPD5SnCwfjOMQljHrsbyUpN91KwYupUtbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719779426; c=relaxed/simple;
	bh=Ycv8/9KvCDPr3dc8sp/oJlQt5StMDrFjIEwCqO7Ozc8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=uDokkLFIxeJ3SUZo1wWmvWKAhAWlL1o+K699r/Zuqd2QVvvqLNUfLMY9J+fUDLmJcKIk+mdx6+Bm7V8dmGoC6Kmi8RVtdmaChFQD9shQpODkP5lLwSLGcUko1PQiwi4EwGm2FSAV7vXIVVwD3gVyUA62iyBKE5n72nFvqtKmDTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 0F590101E69CA;
	Sun, 30 Jun 2024 22:30:22 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id A953961DA805;
	Sun, 30 Jun 2024 22:30:21 +0200 (CEST)
X-Mailbox-Line: From 2e6ee6670a5d450bc880e77a892ea0227a2cc3b4 Mon Sep 17 00:00:00 2001
Message-ID: <2e6ee6670a5d450bc880e77a892ea0227a2cc3b4.1719771133.git.lukas@wunner.de>
In-Reply-To: <cover.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 30 Jun 2024 21:51:00 +0200
Subject: [PATCH v2 16/18] spdm: Limit memory consumed by log of received
 signatures
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Cc: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair Francis <alistair.francis@wdc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, "Damien Le Moal" <dlemoal@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The SPDM library has just been amended to keep a log of received
signatures and expose it in sysfs.

Limit the log's memory footprint subject to a sysctl parameter.  Purge
old signatures when adding a new signature which causes the limit to be
exceeded.  Likewise purge old signatures when the sysctl parameter is
reduced.

The latter requires keeping a list of all struct spdm_state and
protecting it with a mutex.  It will come in handy when further global
sysctl parameters are added to the SPDM library.  Unfortunately an
xarray is not a better option in this case as the xarray-integrated
xa_lock() is a spinlock but purging signatures from sysfs may sleep
(due to kernfs_rwsem).

This functionality is introduced in a separate commit on top of basic
signature exposure to split the code into digestible, reviewable chunks.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 Documentation/ABI/testing/sysfs-devices-spdm | 15 ++++
 Documentation/admin-guide/sysctl/index.rst   |  2 +
 Documentation/admin-guide/sysctl/spdm.rst    | 33 ++++++++
 MAINTAINERS                                  |  1 +
 lib/spdm/core.c                              | 11 +++
 lib/spdm/req-sysfs.c                         | 80 +++++++++++++++++++-
 lib/spdm/spdm.h                              | 10 +++
 7 files changed, 150 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/admin-guide/sysctl/spdm.rst

diff --git a/Documentation/ABI/testing/sysfs-devices-spdm b/Documentation/ABI/testing/sysfs-devices-spdm
index ae7b3f701ded..8d8ee01672e1 100644
--- a/Documentation/ABI/testing/sysfs-devices-spdm
+++ b/Documentation/ABI/testing/sysfs-devices-spdm
@@ -162,6 +162,21 @@ Description:
 		dissector needs to be fed the concatenation of "transcript"
 		and "signature".
 
+		Because the number prefixed to the filenames is 32 bit, it
+		wraps around to 0 after 4,294,967,295 signatures.  The kernel
+		avoids filename collisions on wraparound by purging old files,
+		subject to the limit set by "sysctl spdm.max_signatures_size"
+		(which defaults to 16 MiB).  It is advisable to regularly save
+		backups on non-volatile storage to retain access to signatures
+		that have been purged (or across reboots)::
+
+		 # tar -u -h -f /path/to/signatures.tar signatures/
+
+		The ctime of each file is the reception time of the signature.
+		However if the signature was received before the device became
+		registered in sysfs, the ctime is the registration time of the
+		device.
+
 
 What:		/sys/devices/.../signatures/[0-9]*_type
 Date:		June 2024
diff --git a/Documentation/admin-guide/sysctl/index.rst b/Documentation/admin-guide/sysctl/index.rst
index 03346f98c7b9..3b48f0039069 100644
--- a/Documentation/admin-guide/sysctl/index.rst
+++ b/Documentation/admin-guide/sysctl/index.rst
@@ -76,6 +76,7 @@ kernel/		global kernel info / tuning
 net/		networking stuff, for documentation look in:
 		<Documentation/networking/>
 proc/		<empty>
+spdm/		Security Protocol and Data Model (SPDM)
 sunrpc/		SUN Remote Procedure Call (NFS)
 vm/		memory management tuning
 		buffer and cache management
@@ -93,6 +94,7 @@ really like to hear about it :-)
    fs
    kernel
    net
+   spdm
    sunrpc
    user
    vm
diff --git a/Documentation/admin-guide/sysctl/spdm.rst b/Documentation/admin-guide/sysctl/spdm.rst
new file mode 100644
index 000000000000..0f3846c83cd4
--- /dev/null
+++ b/Documentation/admin-guide/sysctl/spdm.rst
@@ -0,0 +1,33 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================
+Documentation for /proc/sys/spdm/
+=================================
+
+Copyright (C) 2024 Intel Corporation
+
+This directory allows tuning Security Protocol and Data Model (SPDM)
+parameters.  SPDM enables device authentication, measurement, key
+exchange and encrypted sessions.
+
+max_signatures_size
+===================
+
+Maximum amount of memory occupied by the log of signatures (per device,
+in bytes, 16 MiB by default).
+
+The log is meant for re-verification of signatures by remote attestation
+services which do not trust the kernel to have verified the signatures
+correctly or which want to apply policy constraints of their own.
+A signature is computed over the transcript (a concatenation of all
+SPDM messages exchanged with the device during an authentication
+sequence).  The transcript can be a few kBytes or up to several MBytes
+in size, hence this parameter prevents the log from consuming too much
+memory.
+
+The kernel always stores the most recent signature in the log even if it
+exceeds ``max_signatures_size``.  Additionally as many older signatures
+are kept in the log as this limit allows.
+
+If you reduce the limit, signatures are purged immediately to free up
+memory.
diff --git a/MAINTAINERS b/MAINTAINERS
index 1ed5817e698c..41f35bbb8f1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20154,6 +20154,7 @@ L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
 F:	Documentation/ABI/testing/sysfs-devices-spdm
+F:	Documentation/admin-guide/sysctl/spdm.rst
 F:	drivers/pci/cma*
 F:	include/linux/spdm.h
 F:	lib/spdm/
diff --git a/lib/spdm/core.c b/lib/spdm/core.c
index d962a1344760..b6a46bdbb2f9 100644
--- a/lib/spdm/core.c
+++ b/lib/spdm/core.c
@@ -20,6 +20,9 @@
 #include <crypto/hash.h>
 #include <crypto/public_key.h>
 
+LIST_HEAD(spdm_state_list); /* list of all struct spdm_state */
+DEFINE_MUTEX(spdm_state_mutex); /* protects spdm_state_list */
+
 static int spdm_err(struct device *dev, struct spdm_error_rsp *rsp)
 {
 	switch (rsp->error_code) {
@@ -404,6 +407,10 @@ struct spdm_state *spdm_create(struct device *dev, spdm_transport *transport,
 	mutex_init(&spdm_state->lock);
 	INIT_LIST_HEAD(&spdm_state->log);
 
+	mutex_lock(&spdm_state_mutex);
+	list_add_tail(&spdm_state->list, &spdm_state_list);
+	mutex_unlock(&spdm_state_mutex);
+
 	return spdm_state;
 }
 EXPORT_SYMBOL_GPL(spdm_create);
@@ -417,6 +424,10 @@ void spdm_destroy(struct spdm_state *spdm_state)
 {
 	u8 slot;
 
+	mutex_lock(&spdm_state_mutex);
+	list_del(&spdm_state->list);
+	mutex_unlock(&spdm_state_mutex);
+
 	for_each_set_bit(slot, &spdm_state->provisioned_slots, SPDM_SLOTS)
 		kvfree(spdm_state->slot[slot]);
 
diff --git a/lib/spdm/req-sysfs.c b/lib/spdm/req-sysfs.c
index d3c4ca7dbbaa..c782054f8e18 100644
--- a/lib/spdm/req-sysfs.c
+++ b/lib/spdm/req-sysfs.c
@@ -185,6 +185,8 @@ const struct attribute_group spdm_signatures_group = {
 	.bin_attrs = spdm_signatures_bin_attrs,
 };
 
+static unsigned int spdm_max_log_sz = SZ_16M; /* per device */
+
 /**
  * struct spdm_log_entry - log entry representing one received SPDM signature
  *
@@ -332,13 +334,31 @@ static ssize_t spdm_read_combined_prefix(struct file *file,
 	return count;
 }
 
-static void spdm_destroy_log_entry(struct spdm_log_entry *log)
+static void spdm_destroy_log_entry(struct spdm_state *spdm_state,
+				   struct spdm_log_entry *log)
 {
+	spdm_state->log_sz -= log->transcript.size + log->sig.size +
+			      sizeof(*log);
+
 	list_del(&log->list);
 	kvfree(log->transcript.private);
 	kfree(log);
 }
 
+static void spdm_shrink_log(struct spdm_state *spdm_state)
+{
+	while (spdm_state->log_sz > spdm_max_log_sz &&
+	       !list_is_singular(&spdm_state->log)) {
+		struct spdm_log_entry *log =
+			list_first_entry(&spdm_state->log, typeof(*log), list);
+
+		if (device_is_registered(spdm_state->dev))
+			spdm_unpublish_log_entry(&spdm_state->dev->kobj, log);
+
+		spdm_destroy_log_entry(spdm_state, log);
+	}
+}
+
 /**
  * spdm_create_log_entry() - Allocate log entry for one received SPDM signature
  *
@@ -444,6 +464,11 @@ void spdm_create_log_entry(struct spdm_state *spdm_state,
 
 	list_add_tail(&log->list, &spdm_state->log);
 	spdm_state->log_counter++;
+	spdm_state->log_sz += log->transcript.size + log->sig.size +
+			      sizeof(*log);
+
+	/* Purge oldest log entries if max log size is exceeded */
+	spdm_shrink_log(spdm_state);
 
 	/* Steal transcript pointer ahead of spdm_free_transcript() */
 	spdm_state->transcript = NULL;
@@ -504,5 +529,56 @@ void spdm_destroy_log(struct spdm_state *spdm_state)
 	struct spdm_log_entry *log, *tmp;
 
 	list_for_each_entry_safe(log, tmp, &spdm_state->log, list)
-		spdm_destroy_log_entry(log);
+		spdm_destroy_log_entry(spdm_state, log);
+}
+
+#ifdef CONFIG_SYSCTL
+static int proc_max_log_sz(struct ctl_table *table, int write,
+			   void *buffer, size_t *lenp, loff_t *ppos)
+{
+	unsigned int old_max_log_sz = spdm_max_log_sz;
+	struct spdm_state *spdm_state;
+	int rc;
+
+	rc = proc_douintvec_minmax(table, write, buffer, lenp, ppos);
+	if (rc)
+		return rc;
+
+	/* Purge oldest log entries if max log size has been reduced */
+	if (write && spdm_max_log_sz < old_max_log_sz) {
+		mutex_lock(&spdm_state_mutex);
+		list_for_each_entry(spdm_state, &spdm_state_list, list) {
+			mutex_lock(&spdm_state->lock);
+			spdm_shrink_log(spdm_state);
+			mutex_unlock(&spdm_state->lock);
+		}
+		mutex_unlock(&spdm_state_mutex);
+	}
+
+	return 0;
+}
+
+static struct ctl_table spdm_ctl_table[] = {
+	{
+		.procname	= "max_signatures_size",
+		.data		= &spdm_max_log_sz,
+		.maxlen		= sizeof(spdm_max_log_sz),
+		.mode		= 0644,
+		.proc_handler	= proc_max_log_sz,
+		.extra1		= SYSCTL_ZERO,
+				  /*
+				   * 2 GiB limit avoids filename collision on
+				   * wraparound of unsigned 32-bit log_counter
+				   */
+		.extra2		= SYSCTL_INT_MAX,
+	},
+	{ }
+};
+
+static int __init spdm_init(void)
+{
+	register_sysctl_init("spdm", spdm_ctl_table);
+	return 0;
 }
+fs_initcall(spdm_init);
+#endif /* CONFIG_SYSCTL */
diff --git a/lib/spdm/spdm.h b/lib/spdm/spdm.h
index a63c2922af5d..448107c92db7 100644
--- a/lib/spdm/spdm.h
+++ b/lib/spdm/spdm.h
@@ -420,6 +420,8 @@ struct spdm_error_rsp {
  * @dev: Responder device.  Used for error reporting and passed to @transport.
  *	Attributes in sysfs appear below this device's directory.
  * @lock: Serializes multiple concurrent spdm_authenticate() calls.
+ * @list: List node.  Added to spdm_state_list.  Used to iterate over all
+ *	SPDM-capable devices when a global sysctl parameter is changed.
  * @authenticated: Whether device was authenticated successfully.
  * @dev: Responder device.  Used for error reporting and passed to @transport.
  * @transport: Transport function to perform one message exchange.
@@ -468,12 +470,16 @@ struct spdm_error_rsp {
  * @transcript_max: Allocation size of @transcript.  Multiple of PAGE_SIZE.
  * @log: Linked list of past authentication events.  Each list entry is of type
  *	struct spdm_log_entry and is exposed as several files in sysfs.
+ * @log_sz: Memory occupied by @log (in bytes) to enforce the limit set by
+ *	spdm_max_log_sz.  Includes, for every entry, the struct spdm_log_entry
+ *	itself and the transcript with trailing signature.
  * @log_counter: Number of generated log entries so far.  Will be prefixed to
  *	the sysfs files of the next generated log entry.
  */
 struct spdm_state {
 	struct device *dev;
 	struct mutex lock;
+	struct list_head list;
 	unsigned int authenticated:1;
 
 	/* Transport */
@@ -513,9 +519,13 @@ struct spdm_state {
 
 	/* Signatures Log */
 	struct list_head log;
+	size_t log_sz;
 	u32 log_counter;
 };
 
+extern struct list_head spdm_state_list;
+extern struct mutex spdm_state_mutex;
+
 ssize_t spdm_exchange(struct spdm_state *spdm_state,
 		      void *req, size_t req_sz, void *rsp, size_t rsp_sz);
 
-- 
2.43.0


