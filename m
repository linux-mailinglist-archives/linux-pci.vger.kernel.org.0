Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8D176F133
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 20:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjHCSCa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 14:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjHCSCA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 14:02:00 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAEE4498
        for <linux-pci@vger.kernel.org>; Thu,  3 Aug 2023 11:01:12 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686c06b806cso866686b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Aug 2023 11:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691085656; x=1691690456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyY105ZWYDcmAte3LXmkGWmEUp/pfY0rBCzPBKLc5no=;
        b=F2No1P8dCodOCJka5dx2xLrl5WcKTOqh0CqE9s2TUtqnLixlF6cr/AUvszgzy2TZTu
         IpgJ+dCrZugmZepjC/tpy4R5LQ7Pz00gUcQA/TtEMUWoSfT5/uFb1jKxDzT1ZQsqsZTd
         n/YxBVubsZMRX+XTZS1a6+twWBxpWIcvQgGZi10KPo9NwU+hLzYpn1k3UmbuJPr0c0iN
         /xxd/mndMDktQMKzqNFO4efMHpBh/HZI7YvgUVyIjmX6wmoATvY7iqn4QFz7f0d+cSG4
         WzANehXdmfb0puBdKFejEfzCVDWLv6Eq7vxbamEiMtycsiO96UVNPeRmqmAhUEv2O88s
         z+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085656; x=1691690456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyY105ZWYDcmAte3LXmkGWmEUp/pfY0rBCzPBKLc5no=;
        b=GayzxUfeezC7EOftXzwIFpwrxPuJ13fTxUZmmchdUISTMOf/KuZuUlyPgwv1FuMSE0
         pMWzZQUsqfoz52Pr4ZeK18gGEx+emh1yrLndXI4xZq8xhslWfZjGNp+Qv2VLdSDc1BbK
         srgFRpMHiNU1m79BcU8nNgo30hH6FA9Rr5TIBxgJKM93vqFaP6jqjGojBRXE3PnEZs7t
         O1aTJT9rrUvYhpgve4AWTlKEdbQd9r6vqakO9VC0YMjX9CthB3ynu5TAZJqcw7+3MFf/
         nMhStyzKupLSUpj+LBPSN183qtSPpa1YpvcsBCUI5bx39/5FDgfXIrCHKZFAHx5JCdjq
         rkJQ==
X-Gm-Message-State: ABy/qLYFKFXdJU2ht2950OFTpV2eV9cHwsAPLNSrjngDwj5G7MyHRc/R
        xz7MAbKqzIZPQEFswi8cvhyJZQ==
X-Google-Smtp-Source: APBJJlF1KqR7PBmpd+0ur15adwkWpnUfiC6IMRYgAhf76Ujfi0pbNhhy0c6BhAYpNTIPaEB13Qkk0A==
X-Received: by 2002:a05:6a00:1883:b0:666:b254:1c9c with SMTP id x3-20020a056a00188300b00666b2541c9cmr22057156pfh.27.1691085656078;
        Thu, 03 Aug 2023 11:00:56 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0065a1b05193asm134952pfe.185.2023.08.03.11.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:00:55 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v1 11/21] swnode: Add support to create early during boot
Date:   Thu,  3 Aug 2023 23:29:06 +0530
Message-Id: <20230803175916.3174453-12-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Anup Patel <apatel@ventanamicro.com>

swnode framework can be used to create fwnode for interrupt
controllers. This helps in keeping the drivers same for both
DT and ACPI. To enable this, enhance the swnode framework so
that it can be created early during boot without dependency
on sysfs.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Co-developed-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/base/swnode.c    | 117 +++++++++++++++++++++++++++++++++------
 include/linux/property.h |   3 +
 2 files changed, 103 insertions(+), 17 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 1886995a0b3a..43f191a38980 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 
 #include "base.h"
 
@@ -21,6 +22,7 @@ struct swnode {
 
 	/* hierarchy */
 	struct ida child_ids;
+	struct list_head early;
 	struct list_head entry;
 	struct list_head children;
 	struct swnode *parent;
@@ -32,6 +34,9 @@ struct swnode {
 static DEFINE_IDA(swnode_root_ids);
 static struct kset *swnode_kset;
 
+static DEFINE_SPINLOCK(swnode_early_lock);
+static LIST_HEAD(swnode_early_list);
+
 #define kobj_to_swnode(_kobj_) container_of(_kobj_, struct swnode, kobj)
 
 static const struct fwnode_operations software_node_ops;
@@ -73,6 +78,17 @@ software_node_to_swnode(const struct software_node *node)
 	if (!node)
 		return NULL;
 
+	spin_lock(&swnode_early_lock);
+
+	list_for_each_entry(swnode, &swnode_early_list, early) {
+		if (swnode->node == node) {
+			spin_unlock(&swnode_early_lock);
+			return swnode;
+		}
+	}
+
+	spin_unlock(&swnode_early_lock);
+
 	spin_lock(&swnode_kset->list_lock);
 
 	list_for_each_entry(k, &swnode_kset->list, entry) {
@@ -698,6 +714,19 @@ software_node_find_by_name(const struct software_node *parent, const char *name)
 	if (!name)
 		return NULL;
 
+	spin_lock(&swnode_early_lock);
+
+	list_for_each_entry(swnode, &swnode_early_list, early) {
+		if (parent == swnode->node->parent && swnode->node->name &&
+		    !strcmp(name, swnode->node->name)) {
+			kobject_get(&swnode->kobj);
+			spin_unlock(&swnode_early_lock);
+			return swnode->node;
+		}
+	}
+
+	spin_unlock(&swnode_early_lock);
+
 	spin_lock(&swnode_kset->list_lock);
 
 	list_for_each_entry(k, &swnode_kset->list, entry) {
@@ -742,10 +771,16 @@ static void software_node_free(const struct software_node *node)
 	kfree(node);
 }
 
-static void software_node_release(struct kobject *kobj)
+static void software_node_release_common(struct kobject *kobj, bool early)
 {
 	struct swnode *swnode = kobj_to_swnode(kobj);
 
+	if (early) {
+		spin_lock(&swnode_early_lock);
+		list_del(&swnode->early);
+		spin_unlock(&swnode_early_lock);
+	}
+
 	if (swnode->parent) {
 		ida_simple_remove(&swnode->parent->child_ids, swnode->id);
 		list_del(&swnode->entry);
@@ -760,6 +795,20 @@ static void software_node_release(struct kobject *kobj)
 	kfree(swnode);
 }
 
+static void software_node_release(struct kobject *kobj)
+{
+	software_node_release_common(kobj, false);
+}
+
+static void software_node_release_early(struct kobject *kobj)
+{
+	software_node_release_common(kobj, true);
+}
+
+static const struct kobj_type software_node_type_early = {
+	.release = software_node_release_early
+};
+
 static const struct kobj_type software_node_type = {
 	.release = software_node_release,
 	.sysfs_ops = &kobj_sysfs_ops,
@@ -767,7 +816,7 @@ static const struct kobj_type software_node_type = {
 
 static struct fwnode_handle *
 swnode_register(const struct software_node *node, struct swnode *parent,
-		unsigned int allocated)
+		unsigned int allocated, unsigned int early)
 {
 	struct swnode *swnode;
 	int ret;
@@ -786,21 +835,39 @@ swnode_register(const struct software_node *node, struct swnode *parent,
 	swnode->id = ret;
 	swnode->node = node;
 	swnode->parent = parent;
-	swnode->kobj.kset = swnode_kset;
+	swnode->kobj.kset = (!early) ? swnode_kset : NULL;
 	fwnode_init(&swnode->fwnode, &software_node_ops);
 
 	ida_init(&swnode->child_ids);
+	INIT_LIST_HEAD(&swnode->early);
 	INIT_LIST_HEAD(&swnode->entry);
 	INIT_LIST_HEAD(&swnode->children);
 
-	if (node->name)
-		ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
-					   parent ? &parent->kobj : NULL,
-					   "%s", node->name);
-	else
-		ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
-					   parent ? &parent->kobj : NULL,
-					   "node%d", swnode->id);
+	if (early) {
+		ret = 0;
+		kobject_init(&swnode->kobj, &software_node_type_early);
+		swnode->kobj.parent = parent ? &parent->kobj : NULL;
+		if (node->name)
+			ret = kobject_set_name(&swnode->kobj,
+					       "%s", node->name);
+		else
+			ret = kobject_set_name(&swnode->kobj,
+					       "node%d", swnode->id);
+		if (!ret) {
+			spin_lock(&swnode_early_lock);
+			list_add_tail(&swnode->early, &swnode_early_list);
+			spin_unlock(&swnode_early_lock);
+		}
+	} else {
+		if (node->name)
+			ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
+						   parent ? &parent->kobj : NULL,
+						   "%s", node->name);
+		else
+			ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
+						   parent ? &parent->kobj : NULL,
+						   "node%d", swnode->id);
+	}
 	if (ret) {
 		kobject_put(&swnode->kobj);
 		return ERR_PTR(ret);
@@ -815,7 +882,8 @@ swnode_register(const struct software_node *node, struct swnode *parent,
 	if (parent)
 		list_add_tail(&swnode->entry, &parent->children);
 
-	kobject_uevent(&swnode->kobj, KOBJ_ADD);
+	if (!early)
+		kobject_uevent(&swnode->kobj, KOBJ_ADD);
 	return &swnode->fwnode;
 }
 
@@ -892,7 +960,7 @@ int software_node_register(const struct software_node *node)
 	if (node->parent && !parent)
 		return -EINVAL;
 
-	return PTR_ERR_OR_ZERO(swnode_register(node, parent, 0));
+	return PTR_ERR_OR_ZERO(swnode_register(node, parent, 0, 0));
 }
 EXPORT_SYMBOL_GPL(software_node_register);
 
@@ -910,9 +978,10 @@ void software_node_unregister(const struct software_node *node)
 }
 EXPORT_SYMBOL_GPL(software_node_unregister);
 
-struct fwnode_handle *
-fwnode_create_software_node(const struct property_entry *properties,
-			    const struct fwnode_handle *parent)
+static struct fwnode_handle *
+fwnode_create_software_node_common(const struct property_entry *properties,
+				   const struct fwnode_handle *parent,
+				   bool early)
 {
 	struct fwnode_handle *fwnode;
 	struct software_node *node;
@@ -931,12 +1000,26 @@ fwnode_create_software_node(const struct property_entry *properties,
 
 	node->parent = p ? p->node : NULL;
 
-	fwnode = swnode_register(node, p, 1);
+	fwnode = swnode_register(node, p, 1, early);
 	if (IS_ERR(fwnode))
 		software_node_free(node);
 
 	return fwnode;
 }
+
+struct fwnode_handle *
+fwnode_create_software_node_early(const struct property_entry *properties,
+				  const struct fwnode_handle *parent)
+{
+	return fwnode_create_software_node_common(properties, parent, true);
+}
+
+struct fwnode_handle *
+fwnode_create_software_node(const struct property_entry *properties,
+			    const struct fwnode_handle *parent)
+{
+	return fwnode_create_software_node_common(properties, parent, false);
+}
 EXPORT_SYMBOL_GPL(fwnode_create_software_node);
 
 void fwnode_remove_software_node(struct fwnode_handle *fwnode)
diff --git a/include/linux/property.h b/include/linux/property.h
index 8c3c6685a2ae..7137338bfabb 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -503,6 +503,9 @@ void software_node_unregister_node_group(const struct software_node **node_group
 int software_node_register(const struct software_node *node);
 void software_node_unregister(const struct software_node *node);
 
+struct fwnode_handle *
+fwnode_create_software_node_early(const struct property_entry *properties,
+				  const struct fwnode_handle *parent);
 struct fwnode_handle *
 fwnode_create_software_node(const struct property_entry *properties,
 			    const struct fwnode_handle *parent);
-- 
2.39.2

