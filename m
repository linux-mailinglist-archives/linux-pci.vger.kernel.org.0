Return-Path: <linux-pci+bounces-19348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA106A02DCD
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 17:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26EE8188413A
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 16:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458421DE897;
	Mon,  6 Jan 2025 16:31:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9235A13E02D;
	Mon,  6 Jan 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181063; cv=none; b=tqCtdP++5Nj/68R30LP9Tvy8/bwHVb4qeHnAGjtTk9NJML68+JmKB6kqV82V5zx99zFIq2B7ySOroHdvSONF0+uCdGKfOT2pmAoEH2F2W+sCT6Ar7Zrca1wuYGTA0wj5S+BfAsAChlIt2qRpvB6RqPtLjYUiqaxe0Fwg23rDGb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181063; c=relaxed/simple;
	bh=xS5dluLs7XX4QkHb0JxE77O6dvG9rxB2Bd0KIGlUK28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEOlLI3/2KPa0HI1XFghXDy3bX1NoYZEEigxWrna//spMws7rE4jz7Yx81QiSSlhH4RHj+aTo6BQFErcufVDsZuMUPHBm27YKgxY/7SP6Ku2qLzHXE3yIL0TvcxZ2L4rFwozdYk648/Xt4TIkFRI5uNOTsm7KX5om3G7W8gI1IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 107721476;
	Mon,  6 Jan 2025 08:31:28 -0800 (PST)
Received: from ampere-altra-2-1.usa.arm.com (ampere-altra-2-1.usa.arm.com [10.118.91.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 76B1C3F673;
	Mon,  6 Jan 2025 08:30:59 -0800 (PST)
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lenb@kernel.org,
	robert.moore@intel.com,
	bhelgaas@google.com
Cc: wei.huang2@amd.com,
	honnappa.nagarahalli@arm.com,
	dhruv.tripathi@arm.com,
	rob.herring@arm.com,
	jeremy.linton@arm.com,
	Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [RFC PATCH 1/2] ACPI: Add support for invoking select _DSM methods from user space
Date: Mon,  6 Jan 2025 16:30:44 +0000
Message-ID: <20250106163045.508959-2-wathsala.vithanage@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250106163045.508959-1-wathsala.vithanage@arm.com>
References: <20250106163045.508959-1-wathsala.vithanage@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Applications that bypass the kernel to access devices can benefit from
the ability to execute ACPI _DSM methods from the user space. This
commit introduces a generic netlink interface for user-space
applications to invoke _DSM methods registered by kernel subsystems for
the user space. User space applications invoke these _DSMs by sending an
ACPI_GENL_CMD_DSM-typed message to an "acpi-event" GENL family socket.
Irrespective of the _DSM being invoked, all messages typed
ACPI_GENL_CMD_DSM must be prefixed by a struct acpi_genl_dsm_id header
to uniquely identify the target _DSM as specified by the ACPI firmware
specification. Reminder of the message is specific to the _DSM being
invoked. Data from the _DSM method will be returned to the application
as a response with the same message header. In addition, the calling
user application needs the minimal capabilities and message lengths
(including the header) specified by the kernel subsystem that registers
the callback for the _DSM method.

The GENL message header for _DSM (acpi_genl_dsm_id header) has the
following format.

 0       1       2       3       4       5       6       7
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                                                               |
+                          _DSM GUID                            +
|                                                               |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|        _DSM REVISION          |     _DSM FUNCTION INDEX       |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
---
 drivers/acpi/Makefile                 |   3 +-
 drivers/acpi/{event.c => acpi_genl.c} | 110 +++++++++++++++++++++++++-
 drivers/acpi/acpi_genl_dsm.c          |  79 ++++++++++++++++++
 include/acpi/acpi_genl.h              |  61 ++++++++++++++
 include/linux/acpi.h                  |   1 +
 5 files changed, 249 insertions(+), 5 deletions(-)
 rename drivers/acpi/{event.c => acpi_genl.c} (63%)
 create mode 100644 drivers/acpi/acpi_genl_dsm.c
 create mode 100644 include/acpi/acpi_genl.h

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 40208a0f5dfb..4b1db58ff33a 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -49,7 +49,8 @@ acpi-y				+= acpi_apd.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= acpi_pnp.o
 acpi-y				+= power.o
-acpi-y				+= event.o
+acpi-y				+= acpi_genl.o
+acpi-y				+= acpi_genl_dsm.o
 acpi-y				+= evged.o
 acpi-y				+= sysfs.o
 acpi-y				+= property.o
diff --git a/drivers/acpi/event.c b/drivers/acpi/acpi_genl.c
similarity index 63%
rename from drivers/acpi/event.c
rename to drivers/acpi/acpi_genl.c
index 96a9aaaaf9f7..53703f6b2805 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/acpi_genl.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * event.c - exporting ACPI events via procfs
+ * acpi_genl.c - accessing ACPI events and _DSM functions via netlink
  *
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
@@ -50,7 +50,11 @@ int unregister_acpi_notifier(struct notifier_block *nb)
 EXPORT_SYMBOL(unregister_acpi_notifier);
 
 #ifdef CONFIG_NET
+
+int acpi_genl_dsm_invoke(struct sk_buff *skb, struct genl_info *info);
+
 static unsigned int acpi_event_seqnum;
+
 struct acpi_genl_event {
 	acpi_device_class device_class;
 	char bus_id[15];
@@ -59,17 +63,19 @@ struct acpi_genl_event {
 };
 
 /* attributes of acpi_genl_family */
-enum {
+enum acpi_genl_attr {
 	ACPI_GENL_ATTR_UNSPEC,
 	ACPI_GENL_ATTR_EVENT,	/* ACPI event info needed by user space */
+	ACPI_GENL_ATTR_DSM,	/* User space _DSM execution requests */
 	__ACPI_GENL_ATTR_MAX,
 };
 #define ACPI_GENL_ATTR_MAX (__ACPI_GENL_ATTR_MAX - 1)
 
 /* commands supported by the acpi_genl_family */
-enum {
+enum acpi_genl_cmd {
 	ACPI_GENL_CMD_UNSPEC,
 	ACPI_GENL_CMD_EVENT,	/* kernel->user notifications for ACPI events */
+	ACPI_GENL_CMD_DSM,	/* use<->kernel channel for _DSM execution */
 	__ACPI_GENL_CMD_MAX,
 };
 #define ACPI_GENL_CMD_MAX (__ACPI_GENL_CMD_MAX - 1)
@@ -78,6 +84,19 @@ enum {
 #define ACPI_GENL_VERSION		0x01
 #define ACPI_GENL_MCAST_GROUP_NAME 	"acpi_mc_group"
 
+
+static const struct nla_policy acpi_nla_policy[__ACPI_GENL_ATTR_MAX + 1] = {
+	[ACPI_GENL_ATTR_DSM] = {.type = NLA_BINARY},
+};
+
+static const struct genl_ops acpi_genl_ops[] = {
+	{
+		.cmd	= ACPI_GENL_CMD_DSM,
+		.policy = acpi_nla_policy,
+		.doit	= acpi_genl_dsm_invoke,
+	},
+};
+
 static const struct genl_multicast_group acpi_event_mcgrps[] = {
 	{ .name = ACPI_GENL_MCAST_GROUP_NAME, },
 };
@@ -87,6 +106,8 @@ static struct genl_family acpi_event_genl_family __ro_after_init = {
 	.name = ACPI_GENL_FAMILY_NAME,
 	.version = ACPI_GENL_VERSION,
 	.maxattr = ACPI_GENL_ATTR_MAX,
+	.ops = acpi_genl_ops,
+	.n_ops = ARRAY_SIZE(acpi_genl_ops),
 	.mcgrps = acpi_event_mcgrps,
 	.n_mcgrps = ARRAY_SIZE(acpi_event_mcgrps),
 };
@@ -144,11 +165,92 @@ int acpi_bus_generate_netlink_event(const char *device_class,
 
 EXPORT_SYMBOL(acpi_bus_generate_netlink_event);
 
+int acpi_genl_dsm_invoke(struct sk_buff *skb, struct genl_info *info)
+{
+	int ret = 0;
+	struct acpi_genl_dsm_id *dsm_arg = NULL, *dsm_ret = NULL;
+	u16 dsm_arg_len = 0;
+	struct acpi_genl_dsm_handle *handle;
+	struct sk_buff *reply_skb;
+	struct nlattr *attr;
+	void *hdr;
+
+	if (!info->attrs[ACPI_GENL_ATTR_DSM]) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	dsm_arg = (struct acpi_genl_dsm_id *)
+		   nla_data(info->attrs[ACPI_GENL_ATTR_DSM]);
+
+	/* Get the handle for the requested _DSM method. */
+	handle = acpi_genl_dsm_get_handle(dsm_arg);
+	if (!handle) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Make sure massage length matches the _DSM method argument size
+	 * specified in the _DSM handle registered by the dirver.
+	 */
+	dsm_arg_len = nla_len(info->attrs[ACPI_GENL_ATTR_DSM]);
+	if (dsm_arg_len != handle->arg_len) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Make sure the user-space caller has right capabilities to invoke this
+	 * _DSM handle.
+	 */
+	if (!capable(handle->cap)) {
+		ret = -EACCES;
+		goto out;
+	}
+
+	/*
+	 * Build a response of the size specified in the _DSM method handle.
+	 */
+	reply_skb = genlmsg_new(handle->ret_len, GFP_ATOMIC);
+	if (!skb) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	hdr = genlmsg_put_reply(reply_skb, info, &acpi_event_genl_family,
+				0, ACPI_GENL_CMD_DSM);
+	if (!hdr) {
+		nlmsg_free(reply_skb);
+		ret = -EMSGSIZE;
+		goto out;
+	}
+
+	attr = nla_reserve(reply_skb, ACPI_GENL_ATTR_DSM, handle->ret_len);
+	if (!attr) {
+		nlmsg_free(reply_skb);
+		ret = -EMSGSIZE;
+		goto out;
+	}
+
+	dsm_ret = nla_data(attr);
+	memset(dsm_ret, 0, handle->ret_len);
+
+	/*
+	 * Invoke the _DSM method via the driver provided callback and send
+	 * response.
+	 */
+	handle->dsm_cb(dsm_arg, dsm_ret);
+	genlmsg_end(reply_skb, hdr);
+	ret = genlmsg_reply(reply_skb, info);
+out:
+	return ret;
+}
+
 static int __init acpi_event_genetlink_init(void)
 {
 	return genl_register_family(&acpi_event_genl_family);
 }
-
 #else
 int acpi_bus_generate_netlink_event(const char *device_class,
 				      const char *bus_id,
diff --git a/drivers/acpi/acpi_genl_dsm.c b/drivers/acpi/acpi_genl_dsm.c
new file mode 100644
index 000000000000..ae6e3656dad8
--- /dev/null
+++ b/drivers/acpi/acpi_genl_dsm.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * acpi_genl_dsm.c - exports ACPI _DSM functions via netlink
+ *
+ *  Copyright (C) 2024  Wathsala Vithanage <wathsala.vithanage@arm.com>
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/jhash.h>
+#include <linux/hashtable.h>
+
+#include "internal.h"
+
+#define acpi_genl_dsm_hash_key(id)				\
+	jhash2((u32 *)&(id), sizeof((id))/sizeof(u32), 0)
+
+DEFINE_HASHTABLE(acpi_dsm_tbl, 4);
+
+/**
+ * acpi_genl_dsm_add_handle - add netlink handle to invoke _DSM via netlink.
+ * @dsm_handle: _DSM handle
+ *
+ * Add handle to a _DSM method that will be invoked when user space calls it
+ * via netlink.
+ */
+int acpi_genl_dsm_add_handle(struct acpi_genl_dsm_handle *handle)
+{
+	if (!handle)
+		return -EINVAL;
+	u32 id_hash = acpi_genl_dsm_hash_key(handle->id);
+
+	hash_add_rcu(acpi_dsm_tbl, &handle->entry, id_hash);
+	return 0;
+}
+EXPORT_SYMBOL(acpi_genl_dsm_add_handle);
+
+/**
+ * acpi_genl_dsm_get_handle - find netlink handle to a _DSM method.
+ * @id: _DSM identifier
+ *
+ * Find netlink handle to _DSM method by _DSM identifier.
+ */
+struct acpi_genl_dsm_handle *
+acpi_genl_dsm_get_handle(const struct acpi_genl_dsm_id *id)
+{
+	struct acpi_genl_dsm_handle *cur_obj;
+
+	if (!id)
+		return NULL;
+	u32 id_hash = acpi_genl_dsm_hash_key(*id);
+
+	hash_for_each_possible_rcu(acpi_dsm_tbl, cur_obj, entry, id_hash) {
+		if (!memcmp(cur_obj, id, sizeof(struct acpi_genl_dsm_id)))
+			return cur_obj;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(acpi_genl_dsm_get_handle);
+
+/**
+ * acpi_genl_dsm_del_handle - remove netlink handler to a _DSM method.
+ * @id: _DSM identifier
+ *
+ * Remove netlink handler to a _DSM method by _DSM identifier.
+ */
+int acpi_genl_dsm_del_handle(const struct acpi_genl_dsm_id *id)
+{
+	if (!id)
+		return -EINVAL;
+	struct acpi_genl_dsm_handle *handle = acpi_genl_dsm_get_handle(id);
+
+	if (!handle)
+		return -ENOENT;
+	hash_del_rcu(&handle->entry);
+	return 0;
+}
+EXPORT_SYMBOL(acpi_genl_dsm_del_handle);
+
diff --git a/include/acpi/acpi_genl.h b/include/acpi/acpi_genl.h
new file mode 100644
index 000000000000..efce8a1a53b4
--- /dev/null
+++ b/include/acpi/acpi_genl.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * acpi_genl_dsm.c - exports ACPI _DSM functions via netlink
+ *
+ *  Copyright (C) 2024  Wathsala Vithanage <wathsala.vithanage@arm.com>
+ *
+ */
+
+#ifndef __ACPI_GENL_H__
+#define __ACPI_GENL_H__
+
+/* _DSM method identifier */
+struct acpi_genl_dsm_id {
+	guid_t	guid;	/* ACPI _DSM GUID */
+	u64	rev;	/* _DSM method revision ID */
+	u64	func;	/* _DSM method index */
+} __packed;
+
+/* _DSM method handle */
+struct acpi_genl_dsm_handle {
+	struct acpi_genl_dsm_id id;	/* Unique _DSM method identifier */
+	u16 arg_len;	/* Size of arg passed into dsm_fn */
+	u16 ret_len;	/* Size of ret passed into dsm_fn */
+	/*
+	 * Callback to invoke the _DSM method.
+	 */
+	int (*dsm_cb)(struct acpi_genl_dsm_id *arg,
+		      struct acpi_genl_dsm_id *ret);
+	int cap;	/* Min cap for invoking _DSM from the user space */
+	struct hlist_node entry;
+};
+
+#ifdef CONFIG_ACPI
+
+int acpi_genl_dsm_add_handle(struct acpi_genl_dsm_handle *handle);
+
+struct acpi_genl_dsm_handle *
+acpi_genl_dsm_get_handle(const struct acpi_genl_dsm_id *id);
+
+int acpi_genl_dsm_del_handle(const struct acpi_genl_dsm_id *id);
+
+#else
+
+int acpi_genl_dsm_add_handle(const struct acpi_genl_dsm_handle *handle)
+{
+	return -ENOTSUP;
+}
+
+struct acpi_genl_dsm_handle *
+acpi_genl_dsm_get_handle(const struct acpi_genl_dsm_id *id)
+{
+	return NULL;
+}
+
+int acpi_genl_dsm_del_handle(struct acpi_genl_dsm_id *id)
+{
+	return -ENOTSUP;
+}
+
+#endif //CONFIG_ACPI
+#endif //__ACPI_GENL_H__
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6adcd1b92b20..ff15ec320705 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -38,6 +38,7 @@ struct irq_domain_ops;
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_io.h>
 #include <asm/acpi.h>
+#include <acpi/acpi_genl.h>
 
 #ifdef CONFIG_ACPI_TABLE_LIB
 #define EXPORT_SYMBOL_ACPI_LIB(x) EXPORT_SYMBOL_NS_GPL(x, "ACPI")
-- 
2.43.0


