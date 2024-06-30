Return-Path: <linux-pci+bounces-9480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 465A791D3E2
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 22:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86FD1F214BF
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 20:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2BF1527A2;
	Sun, 30 Jun 2024 20:26:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E389B273FD;
	Sun, 30 Jun 2024 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719779170; cv=none; b=lk7435dCVkfYHCOEknnha4q7lrSJ3kNGg58Og/tkuD4iAqyqsIbKkh8dgKuJl5DubebIONk3eGafyjxXJgi0bmitSuH62ZzysmBuAR0rYafzNUvpVaW3RFlX2E4xEKOcnK9vZaSKCMgkqWFWcfNoY9yjntGWtZSdQCL60yh3BdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719779170; c=relaxed/simple;
	bh=yM4Tr42yivUFpeGJtVaV/R8WxBL1QHCFFhsK2yZep3A=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=fnhSAa1288XvIMCpXEmri07lEgluCog/vIEkG6QVctPI8kyt7qxhOT8JXhR1po8F4BckNT412r5X2tZ4wTQXDZye2oRFYDGRvviqsqpTtusd2ILwdxgyNQ6yeow+LNN5Xj/dxVgXAWo8ZZ63SbOskMy0uCUA4dbYn5VWqWl1jpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id ABF0810190FA3;
	Sun, 30 Jun 2024 22:26:06 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 80FB561DA805;
	Sun, 30 Jun 2024 22:26:06 +0200 (CEST)
X-Mailbox-Line: From 16490618cbde91b5aac04873c39c8fb7666ff686 Mon Sep 17 00:00:00 2001
Message-ID: <16490618cbde91b5aac04873c39c8fb7666ff686.1719771133.git.lukas@wunner.de>
In-Reply-To: <cover.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 30 Jun 2024 21:48:00 +0200
Subject: [PATCH v2 13/18] sysfs: Allow bin_attributes to be added to groups
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Cc: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair Francis <alistair.francis@wdc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, "Damien Le Moal" <dlemoal@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>

Commit dfa87c824a9a ("sysfs: allow attributes to be added to groups")
introduced dynamic addition of sysfs attributes to groups.

Allow the same for bin_attributes, in support of a subsequent commit
which adds various bin_attributes every time a PCI device is
authenticated.

Addition of bin_attributes to groups differs from regular attributes in
that different kernfs_ops are selected by sysfs_add_bin_file_mode_ns()
vis-à-vis sysfs_add_file_mode_ns().

So call either of those two functions from sysfs_add_file_to_group()
based on an additional boolean parameter and add two wrapper functions,
one for bin_attributes and another for regular attributes.

Removal of bin_attributes from groups does not require a differentiation
for bin_attributes and can use the same code path as regular attributes.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 fs/sysfs/file.c       | 69 ++++++++++++++++++++++++++++++++++++-------
 include/linux/sysfs.h | 19 ++++++++++++
 2 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index d1995e2d6c94..9268232781b5 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -383,14 +383,14 @@ int sysfs_create_files(struct kobject *kobj, const struct attribute * const *ptr
 }
 EXPORT_SYMBOL_GPL(sysfs_create_files);
 
-/**
- * sysfs_add_file_to_group - add an attribute file to a pre-existing group.
- * @kobj: object we're acting for.
- * @attr: attribute descriptor.
- * @group: group name.
- */
-int sysfs_add_file_to_group(struct kobject *kobj,
-		const struct attribute *attr, const char *group)
+static const struct bin_attribute *to_bin_attr(const struct attribute *attr)
+{
+	return container_of(attr, struct bin_attribute, attr);
+}
+
+static int __sysfs_add_file_to_group(struct kobject *kobj,
+				     const struct attribute *attr,
+				     const char *group, bool is_bin_attr)
 {
 	struct kernfs_node *parent;
 	kuid_t uid;
@@ -408,14 +408,49 @@ int sysfs_add_file_to_group(struct kobject *kobj,
 		return -ENOENT;
 
 	kobject_get_ownership(kobj, &uid, &gid);
-	error = sysfs_add_file_mode_ns(parent, attr, attr->mode, uid, gid,
-				       NULL);
+	if (is_bin_attr)
+		error = sysfs_add_bin_file_mode_ns(parent, to_bin_attr(attr),
+						   attr->mode, uid, gid, NULL);
+	else
+		error = sysfs_add_file_mode_ns(parent, attr,
+					       attr->mode, uid, gid, NULL);
 	kernfs_put(parent);
 
 	return error;
 }
+
+/**
+ * sysfs_add_file_to_group - add an attribute file to a pre-existing group.
+ * @kobj: object we're acting for.
+ * @attr: attribute descriptor.
+ * @group: group name.
+ *
+ * Returns 0 on success or error code on failure.
+ */
+int sysfs_add_file_to_group(struct kobject *kobj,
+			    const struct attribute *attr,
+			    const char *group)
+{
+	return __sysfs_add_file_to_group(kobj, attr, group, false);
+}
 EXPORT_SYMBOL_GPL(sysfs_add_file_to_group);
 
+/**
+ * sysfs_add_bin_file_to_group - add bin_attribute file to pre-existing group.
+ * @kobj: object we're acting for.
+ * @attr: attribute descriptor.
+ * @group: group name.
+ *
+ * Returns 0 on success or error code on failure.
+ */
+int sysfs_add_bin_file_to_group(struct kobject *kobj,
+				const struct bin_attribute *attr,
+				const char *group)
+{
+	return __sysfs_add_file_to_group(kobj, &attr->attr, group, true);
+}
+EXPORT_SYMBOL_GPL(sysfs_add_bin_file_to_group);
+
 /**
  * sysfs_chmod_file - update the modified mode value on an object attribute.
  * @kobj: object we're acting for.
@@ -565,6 +600,20 @@ void sysfs_remove_file_from_group(struct kobject *kobj,
 }
 EXPORT_SYMBOL_GPL(sysfs_remove_file_from_group);
 
+/**
+ * sysfs_remove_bin_file_from_group - remove bin_attribute file from group.
+ * @kobj: object we're acting for.
+ * @attr: attribute descriptor.
+ * @group: group name.
+ */
+void sysfs_remove_bin_file_from_group(struct kobject *kobj,
+				      const struct bin_attribute *attr,
+				      const char *group)
+{
+	sysfs_remove_file_from_group(kobj, &attr->attr, group);
+}
+EXPORT_SYMBOL_GPL(sysfs_remove_bin_file_from_group);
+
 /**
  *	sysfs_create_bin_file - create binary file for object.
  *	@kobj:	object.
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index a7d725fbf739..aff1d81e8971 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -451,6 +451,12 @@ int sysfs_add_file_to_group(struct kobject *kobj,
 			const struct attribute *attr, const char *group);
 void sysfs_remove_file_from_group(struct kobject *kobj,
 			const struct attribute *attr, const char *group);
+int sysfs_add_bin_file_to_group(struct kobject *kobj,
+				const struct bin_attribute *attr,
+				const char *group);
+void sysfs_remove_bin_file_from_group(struct kobject *kobj,
+				      const struct bin_attribute *attr,
+				      const char *group);
 int sysfs_merge_group(struct kobject *kobj,
 		       const struct attribute_group *grp);
 void sysfs_unmerge_group(struct kobject *kobj,
@@ -660,6 +666,19 @@ static inline void sysfs_remove_file_from_group(struct kobject *kobj,
 {
 }
 
+static inline int sysfs_add_bin_file_to_group(struct kobject *kobj,
+					      const struct bin_attribute *attr,
+					      const char *group)
+{
+	return 0;
+}
+
+static inline void sysfs_remove_bin_file_from_group(struct kobject *kobj,
+					      const struct bin_attribute *attr,
+					      const char *group)
+{
+}
+
 static inline int sysfs_merge_group(struct kobject *kobj,
 		       const struct attribute_group *grp)
 {
-- 
2.43.0


