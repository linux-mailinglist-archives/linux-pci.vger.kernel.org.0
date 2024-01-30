Return-Path: <linux-pci+bounces-2786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B00841F58
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 10:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BFB1C25379
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 09:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0248060B8C;
	Tue, 30 Jan 2024 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZKpS3l2g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360160B97
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606652; cv=none; b=N+NaQhJ1JTVzDJE7KqDG+RtbWjB7tVELKQk0ehC38W7JykisfOaYKDB+UxQiE7Lqc7cAhviX4zFuDKRhE9GJGMNhLPUZJ/NY4svbOi7xdWIeDwaQPLHE3DRi4eNZxnvgbuR3teAzV42/eVirQ/QHMAzkDoPKs2P4QXu9hwMlMe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606652; c=relaxed/simple;
	bh=nIZRVvuaMSKoi1E+P4eke63UOXkToOu6hJbfGXNf7mU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJEKUpom+hPSPgKQy6BvQrA5GP+x0cEunBPTjB562tEiy+BenycPIBG9RzoAnWL2PIpe0VzlpmGyP4vrtkrttkSKFMYYf8bn8CyXZQU0TvHcdOLxZayF/5UH6iyaJiL4kl7BzPCczUYsrDkJzQfXZ8tZXaacawyrmLisnpPUlWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZKpS3l2g; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706606651; x=1738142651;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nIZRVvuaMSKoi1E+P4eke63UOXkToOu6hJbfGXNf7mU=;
  b=ZKpS3l2g95DoOoa0Ci4JtZC6jSizgCTcPNjut5CA/httOeQ3BgTny3OH
   YV6F5iBMEQUfiNcqbaS3bD46So6pk0BUTwgxwe026PPYkO9VEzhgw3jE2
   pihiyWzfspJmVgkbFiA4CHVYsYuPmYgwTU7zIS5Wy6bNOwgUaE3UqcH0r
   5oQtaWHvE94loLA4BTx+pqTZ8pHfnkLuqC0s7ROWg4WNkeItz1gHS1qWf
   PTtUYZf/ce33qSKQQOrbigQJSjNAll2la7t1e8cAJvLI8OZQ1H5EJwTsz
   VLFvGM5gpXkNKuEyUnosykfPrs5oJVaY/ycd7YS64bEZMvBtAnACL6yF0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="24699937"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="24699937"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:24:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="788141965"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="788141965"
Received: from djayasin-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.72.104])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:24:08 -0800
Subject: [RFC PATCH 4/5] sysfs: Introduce a mechanism to hide static
 attribute_groups
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
Date: Tue, 30 Jan 2024 01:24:08 -0800
Message-ID: <170660664848.224441.8152468052311375109.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add a mechanism for named attribute_groups to hide their directory at
sysfs_update_group() time, or otherwise skip emitting the group
directory when the group is first registered. It piggybacks on
is_visible() in a similar manner as SYSFS_PREALLOC, i.e. special flags
in the upper bits of the returned mode. To use it, specify a symbol
prefix to DEFINE_SYSFS_GROUP_VISIBLE(), and then pass that same prefix
to SYSFS_GROUP_VISIBLE() when assigning the @is_visible() callback:

	DEFINE_SYSFS_GROUP_VISIBLE($prefix)

	struct attribute_group $prefix_group = {
		.name = $name,
		.is_visible = SYSFS_GROUP_VISIBLE($prefix),
	};

SYSFS_GROUP_VISIBLE() expects a definition of $prefix_group_visible()
and $prefix_attr_visible(), where $prefix_group_visible() just returns
true / false and $prefix_attr_visible() behaves as normal.

The motivation for this capability is to centralize PCI device
authentication in the PCI core with a named sysfs group while keeping
that group hidden for devices and platforms that do not meet the
requirements. In a PCI topology, most devices will not support
authentication, a small subset will support just PCI CMA (Component
Measurement and Authentication), a smaller subset will support PCI CMA +
PCIe IDE (Link Integrity and Encryption), and only next generation
server hosts will start to include a platform TSM (TEE Security
Manager).

Without this capability the alternatives are:

* Check if all attributes are invisible and if so, hide the directory.
  Beyond trouble getting this to work [1], this is an ABI change for
  scenarios if userspace happens to depend on group visibility absent any
  attributes. I.e. this new capability avoids regression since it does
  not retroactively apply to existing cases.

* Publish an empty /sys/bus/pci/devices/$pdev/tsm/ directory for all PCI
  devices (i.e. for the case when TSM platform support is present, but
  device support is absent). Unfortunate that this will be a vestigial
  empty directory in the vast majority of cases.

* Reintroduce usage of runtime calls to sysfs_{create,remove}_group()
  in the PCI core. Bjorn has already indicated that he does not want to
  see any growth of pci_sysfs_init() [2].

* Drop the named group and simulate a directory by prefixing all
  TSM-related attributes with "tsm_". Unfortunate to not use the naming
  capability of a sysfs group as intended.

In comparison, there is a small potential for regression if for some
reason an @is_visible() callback had dependencies on how many times it
was called. Additionally, it is no longer an error to update a group
that does not have its directory already present, and it is no longer a
WARN() to remove a group that was never visible.

Link: https://lore.kernel.org/all/2024012321-envious-procedure-4a58@gregkh/ [1]
Link: https://lore.kernel.org/linux-pci/20231019200110.GA1410324@bhelgaas/ [2]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/sysfs/group.c      |   45 ++++++++++++++++++++++++++++-------
 include/linux/sysfs.h |   63 ++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 87 insertions(+), 21 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 138676463336..ccb275cdabcb 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -31,6 +31,17 @@ static void remove_files(struct kernfs_node *parent,
 			kernfs_remove_by_name(parent, (*bin_attr)->attr.name);
 }
 
+static umode_t __first_visible(const struct attribute_group *grp, struct kobject *kobj)
+{
+	if (grp->attrs && grp->is_visible)
+		return grp->is_visible(kobj, grp->attrs[0], 0);
+
+	if (grp->bin_attrs && grp->is_bin_visible)
+		return grp->is_bin_visible(kobj, grp->bin_attrs[0], 0);
+
+	return 0;
+}
+
 static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 			kuid_t uid, kgid_t gid,
 			const struct attribute_group *grp, int update)
@@ -52,6 +63,7 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 				kernfs_remove_by_name(parent, (*attr)->name);
 			if (grp->is_visible) {
 				mode = grp->is_visible(kobj, *attr, i);
+				mode &= ~SYSFS_GROUP_INVISIBLE;
 				if (!mode)
 					continue;
 			}
@@ -81,6 +93,7 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 						(*bin_attr)->attr.name);
 			if (grp->is_bin_visible) {
 				mode = grp->is_bin_visible(kobj, *bin_attr, i);
+				mode &= ~SYSFS_GROUP_INVISIBLE;
 				if (!mode)
 					continue;
 			}
@@ -127,16 +140,31 @@ static int internal_create_group(struct kobject *kobj, int update,
 
 	kobject_get_ownership(kobj, &uid, &gid);
 	if (grp->name) {
+		umode_t mode = __first_visible(grp, kobj);
+
+		if (mode & SYSFS_GROUP_INVISIBLE)
+			mode = 0;
+		else
+			mode = S_IRWXU | S_IRUGO | S_IXUGO;
+
 		if (update) {
 			kn = kernfs_find_and_get(kobj->sd, grp->name);
 			if (!kn) {
-				pr_warn("Can't update unknown attr grp name: %s/%s\n",
-					kobj->name, grp->name);
-				return -EINVAL;
+				pr_debug("attr grp %s/%s not created yet\n",
+					 kobj->name, grp->name);
+				/* may have been invisible prior to this update */
+				update = 0;
+			} else if (!mode) {
+				sysfs_remove_group(kobj, grp);
+				kernfs_put(kn);
+				return 0;
 			}
-		} else {
-			kn = kernfs_create_dir_ns(kobj->sd, grp->name,
-						  S_IRWXU | S_IRUGO | S_IXUGO,
+		}
+
+		if (!update) {
+			if (!mode)
+				return 0;
+			kn = kernfs_create_dir_ns(kobj->sd, grp->name, mode,
 						  uid, gid, kobj, NULL);
 			if (IS_ERR(kn)) {
 				if (PTR_ERR(kn) == -EEXIST)
@@ -279,9 +307,8 @@ void sysfs_remove_group(struct kobject *kobj,
 	if (grp->name) {
 		kn = kernfs_find_and_get(parent, grp->name);
 		if (!kn) {
-			WARN(!kn, KERN_WARNING
-			     "sysfs group '%s' not found for kobject '%s'\n",
-			     grp->name, kobject_name(kobj));
+			pr_debug("sysfs group '%s' not found for kobject '%s'\n",
+				 grp->name, kobject_name(kobj));
 			return;
 		}
 	} else {
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index b717a70219f6..a42642b277dd 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -61,22 +61,32 @@ do {							\
 /**
  * struct attribute_group - data structure used to declare an attribute group.
  * @name:	Optional: Attribute group name
- *		If specified, the attribute group will be created in
- *		a new subdirectory with this name.
+ *		If specified, the attribute group will be created in a
+ *		new subdirectory with this name. Additionally when a
+ *		group is named, @is_visible and @is_bin_visible may
+ *		return SYSFS_GROUP_INVISIBLE to control visibility of
+ *		the directory itself.
  * @is_visible:	Optional: Function to return permissions associated with an
- *		attribute of the group. Will be called repeatedly for each
- *		non-binary attribute in the group. Only read/write
+ *		attribute of the group. Will be called repeatedly for
+ *		each non-binary attribute in the group. Only read/write
  *		permissions as well as SYSFS_PREALLOC are accepted. Must
- *		return 0 if an attribute is not visible. The returned value
- *		will replace static permissions defined in struct attribute.
+ *		return 0 if an attribute is not visible. The returned
+ *		value will replace static permissions defined in struct
+ *		attribute. Use SYSFS_GROUP_VISIBLE() when assigning this
+ *		callback to specify separate _group_visible() and
+ *		_attr_visible() handlers.
  * @is_bin_visible:
  *		Optional: Function to return permissions associated with a
  *		binary attribute of the group. Will be called repeatedly
  *		for each binary attribute in the group. Only read/write
- *		permissions as well as SYSFS_PREALLOC are accepted. Must
- *		return 0 if a binary attribute is not visible. The returned
- *		value will replace static permissions defined in
- *		struct bin_attribute.
+ *		permissions as well as SYSFS_PREALLOC (and the
+ *		visibility flags for named groups) are accepted. Must
+ *		return 0 if a binary attribute is not visible. The
+ *		returned value will replace static permissions defined
+ *		in struct bin_attribute. If @is_visible is not set, Use
+ *		SYSFS_GROUP_VISIBLE() when assigning this callback to
+ *		specify separate _group_visible() and _attr_visible()
+ *		handlers.
  * @attrs:	Pointer to NULL terminated list of attributes.
  * @bin_attrs:	Pointer to NULL terminated list of binary attributes.
  *		Either attrs or bin_attrs or both must be provided.
@@ -91,13 +101,42 @@ struct attribute_group {
 	struct bin_attribute	**bin_attrs;
 };
 
+#define SYSFS_PREALLOC		010000
+#define SYSFS_GROUP_INVISIBLE	020000
+
+/*
+ * The first call to is_visible() in the create / update path may
+ * indicate visibility for the entire group
+ */
+#define DEFINE_SYSFS_GROUP_VISIBLE(name)                             \
+	static inline umode_t sysfs_group_visible_##name(            \
+		struct kobject *kobj, struct attribute *attr, int n) \
+	{                                                            \
+		if (n == 0 && !name##_group_visible(kobj))           \
+			return SYSFS_GROUP_INVISIBLE;                \
+		return name##_attr_visible(kobj, attr, n);           \
+	}
+
+/*
+ * Same as DEFINE_SYSFS_GROUP_VISIBLE, but for groups with only binary
+ * attributes
+ */
+#define DEFINE_SYSFS_BIN_GROUP_VISIBLE(name)                             \
+	static inline umode_t sysfs_group_visible_##name(                \
+		struct kobject *kobj, struct bin_attribute *attr, int n) \
+	{                                                                \
+		if (n == 0 && !name##_group_visible(kobj))               \
+			return SYSFS_GROUP_INVISIBLE;                    \
+		return name##_attr_visible(kobj, attr, n);               \
+	}
+
+#define SYSFS_GROUP_VISIBLE(fn) sysfs_group_visible_##fn
+
 /*
  * Use these macros to make defining attributes easier.
  * See include/linux/device.h for examples..
  */
 
-#define SYSFS_PREALLOC 010000
-
 #define __ATTR(_name, _mode, _show, _store) {				\
 	.attr = {.name = __stringify(_name),				\
 		 .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\


