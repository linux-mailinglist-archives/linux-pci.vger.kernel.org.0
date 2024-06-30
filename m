Return-Path: <linux-pci+bounces-9481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E45A91D3E6
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 22:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5862815C9
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 20:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A665F12C49C;
	Sun, 30 Jun 2024 20:27:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693DD200C1;
	Sun, 30 Jun 2024 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719779257; cv=none; b=JP9QwykPkAy9gQp2I6QuXGHF6pg0S3nmMWsxyglbFKSwpP9ZXos8rcBLm7wD5j1hdKXG5TVORrAXtQZabQ07gP24pCwuexoxa4+X3pcaq3l8QrAy1+5gDiiBv2UVDx5x2ySro1c1eLYLY2xmbsJAXfbzbChjNFn1pMCvA+m1ZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719779257; c=relaxed/simple;
	bh=xRm+4EOYUGcr4/ggPqFOTFJU9KREfDSEf4i6MJYtOm4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=qfUB/gLlC75yV/ScuONNLOSfuQ/hpt0i4Q6fXaXUDVN1qNLd0isv6UgxKTSk8CEeH7ar0ALX2oFL3E2paB0m69r6zlcYau9fY2totqUWgDQoL9FwH7phMx2IoyA/MTYdMcEJnEM1AKKRJqYM4hFStTH8oibUYxGDQP9fT8FJCw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 77771101E6A35;
	Sun, 30 Jun 2024 22:27:32 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 23FBD61DA805;
	Sun, 30 Jun 2024 22:27:32 +0200 (CEST)
X-Mailbox-Line: From 7b4e324bdcd5910c9460bb5fc37aaf354f596ebf Mon Sep 17 00:00:00 2001
Message-ID: <7b4e324bdcd5910c9460bb5fc37aaf354f596ebf.1719771133.git.lukas@wunner.de>
In-Reply-To: <cover.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 30 Jun 2024 21:49:00 +0200
Subject: [PATCH v2 14/18] sysfs: Allow symlinks to be added between sibling
 groups
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Cc: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair Francis <alistair.francis@wdc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, "Damien Le Moal" <dlemoal@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

A subsequent commit has the need to create a symlink from an attribute
in a first group to an attribute in a second group.  Both groups belong
to the same kobject.

More specifically, each signature received from an authentication-
capable device is going to be represented by a file in the first group
and shall be accompanied by a symlink pointing to the certificate slot
in the second group which was used to generate the signature (a device
may have multiple certificate slots and each is represented by a
separate file in the second group):

/sys/devices/.../signatures/0_certificate_chain -> .../certificates/slot0

There is already a sysfs_add_link_to_group() helper to add a symlink to
a group which points to another kobject, but this isn't what's needed
here.

So add a new function to add a symlink among sibling groups of the same
kobject.

The existing sysfs_add_link_to_group() helper goes through a locking
dance of acquiring sysfs_symlink_target_lock in order to acquire a
reference on the target kobject.  That's unnecessary for the present
use case as the link itself and its target reside below the same
kobject.

To simplify error handling in the newly introduced function, add a
DEFINE_FREE() clause for kernfs_put().

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 fs/sysfs/group.c       | 33 +++++++++++++++++++++++++++++++++
 include/linux/kernfs.h |  2 ++
 include/linux/sysfs.h  | 10 ++++++++++
 3 files changed, 45 insertions(+)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index d22ad67a0f32..0cb52c9b9e19 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -445,6 +445,39 @@ void sysfs_remove_link_from_group(struct kobject *kobj, const char *group_name,
 }
 EXPORT_SYMBOL_GPL(sysfs_remove_link_from_group);
 
+/**
+ * sysfs_add_link_to_sibling_group - add a symlink to a sibling attribute group.
+ * @kobj:	The kobject containing the groups.
+ * @link_grp:	The name of the group in which to create the symlink.
+ * @link:	The name of the symlink to create.
+ * @target_grp:	The name of the target group.
+ * @target:	The name of the target attribute.
+ *
+ * Returns 0 on success or error code on failure.
+ */
+int sysfs_add_link_to_sibling_group(struct kobject *kobj,
+				    const char *link_grp, const char *link,
+				    const char *target_grp, const char *target)
+{
+	struct kernfs_node *target_grp_kn __free(kernfs_put),
+			   *target_kn __free(kernfs_put) = NULL,
+			   *link_grp_kn __free(kernfs_put) = NULL;
+
+	target_grp_kn = kernfs_find_and_get(kobj->sd, target_grp);
+	if (!target_grp_kn)
+		return -ENOENT;
+
+	target_kn = kernfs_find_and_get(target_grp_kn, target);
+	if (!target_kn)
+		return -ENOENT;
+
+	link_grp_kn = kernfs_find_and_get(kobj->sd, link_grp);
+	if (!link_grp_kn)
+		return -ENOENT;
+
+	return PTR_ERR_OR_ZERO(kernfs_create_link(link_grp_kn, link, target_kn));
+}
+
 /**
  * compat_only_sysfs_link_entry_to_kobj - add a symlink to a kobject pointing
  * to a group or an attribute
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 87c79d076d6d..d5726d070dba 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -407,6 +407,8 @@ struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
 void kernfs_get(struct kernfs_node *kn);
 void kernfs_put(struct kernfs_node *kn);
 
+DEFINE_FREE(kernfs_put, struct kernfs_node *, if (_T) kernfs_put(_T))
+
 struct kernfs_node *kernfs_node_from_dentry(struct dentry *dentry);
 struct kernfs_root *kernfs_root_from_sb(struct super_block *sb);
 struct inode *kernfs_get_inode(struct super_block *sb, struct kernfs_node *kn);
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index aff1d81e8971..6f970832bd36 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -465,6 +465,9 @@ int sysfs_add_link_to_group(struct kobject *kobj, const char *group_name,
 			    struct kobject *target, const char *link_name);
 void sysfs_remove_link_from_group(struct kobject *kobj, const char *group_name,
 				  const char *link_name);
+int sysfs_add_link_to_sibling_group(struct kobject *kobj,
+				    const char *link_grp, const char *link,
+				    const char *target_grp, const char *target);
 int compat_only_sysfs_link_entry_to_kobj(struct kobject *kobj,
 					 struct kobject *target_kobj,
 					 const char *target_name,
@@ -702,6 +705,13 @@ static inline void sysfs_remove_link_from_group(struct kobject *kobj,
 {
 }
 
+static inline int sysfs_add_link_to_sibling_group(struct kobject *kobj,
+		const char *link_grp, const char *link,
+		const char *target_grp, const char *target)
+{
+	return 0;
+}
+
 static inline int compat_only_sysfs_link_entry_to_kobj(struct kobject *kobj,
 						       struct kobject *target_kobj,
 						       const char *target_name,
-- 
2.43.0


