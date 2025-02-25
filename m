Return-Path: <linux-pci+bounces-22366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 647F2A4483C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE57A3B9325
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 17:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16971990AB;
	Tue, 25 Feb 2025 17:25:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA0E19ABD4
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504318; cv=none; b=NlhnhCxhrVMJbWl4yJGBd2VSq8AKf0ju6ObAzHrMl5JQIgV4JRs5s1HCOyqa+/E2EKgiVES0/HYA1qe3+Xk3rujX+Mp63xf44Gvt4jY4ZrB97Juun3HkQWSRtQiXr+5JNSbkgwLEKsRQ8V5IF5g17Uj7PThxi3D/HDvtbxYuWGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504318; c=relaxed/simple;
	bh=70sdq/sV8vV3YR0UN0Dy5ICvtW6RpqwECr/A9ot96/s=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=i3F5KL9V8ZccT6l9AZJCpPuYtgO+TVhE/rp3DhU2fDvGs3HnUx1BsdHFmcpAtAss2bR72a5rryRloVWGNv7Wjn6KDqWWbAwnAv9sOMIz9bCiwKf78SCdr00Zs2hp+MFqk9UYzHxHFALwARacKsdI/7NDcfwTOtHCeIDtsWhOAaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 198F6101E698A;
	Tue, 25 Feb 2025 18:15:36 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id CA97D60C8E39;
	Tue, 25 Feb 2025 18:15:35 +0100 (CET)
X-Mailbox-Line: From 603735bc50eb370bc7f1c358441ac671360bab25 Mon Sep 17 00:00:00 2001
Message-ID: <603735bc50eb370bc7f1c358441ac671360bab25.1740501868.git.lukas@wunner.de>
In-Reply-To: <cover.1740501868.git.lukas@wunner.de>
References: <cover.1740501868.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 25 Feb 2025 18:06:01 +0100
Subject: [PATCH 1/5] PCI: hotplug: Drop superfluous pci_hotplug_slot_list
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The PCI hotplug core keeps a list of all registered slots.  Its sole
purpose is to WARN() on slot removal if another slot is using the same
name.

But this can never happen because already on slot creation, an error is
returned and multiple messages are emitted if a slot's name is
duplicated:

  pci_hp_register()
    __pci_hp_register()
      __pci_hp_initialize()
        pci_create_slot()
          kobject_init_and_add()
            kobject_add_varg()
              kobject_add_internal()
                create_dir()
                  sysfs_create_dir_ns()
                    kernfs_create_dir_ns()
                      sysfs_warn_dup()
                        pr_warn("cannot create duplicate filename ...")
                pr_err("%s failed for %s with -EEXIST, ...");

Drop the superfluous list.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pci_hotplug_core.c | 32 --------------------------
 include/linux/pci_hotplug.h            |  2 --
 2 files changed, 34 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 36236ac88fd5..9e3cde91c167 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -18,14 +18,12 @@
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/list.h>
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
-#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
 #include <linux/uaccess.h>
@@ -42,9 +40,6 @@
 /* local variables */
 static bool debug;
 
-static LIST_HEAD(pci_hotplug_slot_list);
-static DEFINE_MUTEX(pci_hp_mutex);
-
 /* Weee, fun with macros... */
 #define GET_STATUS(name, type)	\
 static int get_##name(struct hotplug_slot *slot, type *value)		\
@@ -375,17 +370,6 @@ static void fs_remove_slot(struct pci_slot *pci_slot)
 	pci_hp_remove_module_link(pci_slot);
 }
 
-static struct hotplug_slot *get_slot_from_name(const char *name)
-{
-	struct hotplug_slot *slot;
-
-	list_for_each_entry(slot, &pci_hotplug_slot_list, slot_list) {
-		if (strcmp(hotplug_slot_name(slot), name) == 0)
-			return slot;
-	}
-	return NULL;
-}
-
 /**
  * __pci_hp_register - register a hotplug_slot with the PCI hotplug subsystem
  * @slot: pointer to the &struct hotplug_slot to register
@@ -484,10 +468,6 @@ int pci_hp_add(struct hotplug_slot *slot)
 		return result;
 
 	kobject_uevent(&pci_slot->kobj, KOBJ_ADD);
-	mutex_lock(&pci_hp_mutex);
-	list_add(&slot->slot_list, &pci_hotplug_slot_list);
-	mutex_unlock(&pci_hp_mutex);
-	dbg("Added slot %s to the list\n", hotplug_slot_name(slot));
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_hp_add);
@@ -514,21 +494,9 @@ EXPORT_SYMBOL_GPL(pci_hp_deregister);
  */
 void pci_hp_del(struct hotplug_slot *slot)
 {
-	struct hotplug_slot *temp;
-
 	if (WARN_ON(!slot))
 		return;
 
-	mutex_lock(&pci_hp_mutex);
-	temp = get_slot_from_name(hotplug_slot_name(slot));
-	if (WARN_ON(temp != slot)) {
-		mutex_unlock(&pci_hp_mutex);
-		return;
-	}
-
-	list_del(&slot->slot_list);
-	mutex_unlock(&pci_hp_mutex);
-	dbg("Removed slot %s from the list\n", hotplug_slot_name(slot));
 	fs_remove_slot(slot->pci_slot);
 }
 EXPORT_SYMBOL_GPL(pci_hp_del);
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index 3a10d6ec3ee7..ec77ccf1fc4d 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -50,7 +50,6 @@ struct hotplug_slot_ops {
 /**
  * struct hotplug_slot - used to register a physical slot with the hotplug pci core
  * @ops: pointer to the &struct hotplug_slot_ops to be used for this slot
- * @slot_list: internal list used to track hotplug PCI slots
  * @pci_slot: represents a physical slot
  * @owner: The module owner of this structure
  * @mod_name: The module name (KBUILD_MODNAME) of this structure
@@ -59,7 +58,6 @@ struct hotplug_slot {
 	const struct hotplug_slot_ops	*ops;
 
 	/* Variables below this are for use only by the hotplug pci core. */
-	struct list_head		slot_list;
 	struct pci_slot			*pci_slot;
 	struct module			*owner;
 	const char			*mod_name;
-- 
2.43.0


