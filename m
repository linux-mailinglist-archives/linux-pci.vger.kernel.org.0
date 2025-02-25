Return-Path: <linux-pci+bounces-22371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6E3A448E2
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1EB01661BA
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 17:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1B1195B1A;
	Tue, 25 Feb 2025 17:46:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077BC19CC0E
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505595; cv=none; b=hgGeNMTrxLT6NO7soSDqdP0+mtMXDdYW6rnsSyp5KfT8ADtGWKc+F40tcx1tyrofnuj2Mdf/4SUEklirbRhuD3/+i+9jJabji0h5r+jkn9FcwzohI9IqnOMh+kDdr2fcMttYLNTEnL+akORwNcfdhOoVIg2jjXDnFlbzkp9FW6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505595; c=relaxed/simple;
	bh=6sxmmC+NKV3hbVTFUXekqgf7FUdZiF2I4RpriziH2AM=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=HlrDVX/MHdnw/QoiyJCke7Ep+KQo1Bn5uha4Ooi63pKZqxuRosVAkTzblTlBBxZiHPI7vqG2ByUBDwwOoJR3vQ8sCmue/ed+EDncVKydKN7pQc5hcEx8Iw+Mzx62hVorL73bkhTOY79fUyi+tcdmMzBjzzdrWVps09eQP+PQLF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 3CE27101E69A4;
	Tue, 25 Feb 2025 18:46:31 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id E6FC56018C39;
	Tue, 25 Feb 2025 18:46:30 +0100 (CET)
X-Mailbox-Line: From c207f03cfe32ae9002d9b453001a1dd63d9ab3fb Mon Sep 17 00:00:00 2001
Message-ID: <c207f03cfe32ae9002d9b453001a1dd63d9ab3fb.1740501868.git.lukas@wunner.de>
In-Reply-To: <cover.1740501868.git.lukas@wunner.de>
References: <cover.1740501868.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 25 Feb 2025 18:06:05 +0100
Subject: [PATCH 5/5] PCI: hotplug: Inline pci_hp_{create,remove}_module_link()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

For no apparent reason, the pci_hp_{create,remove}_module_link() helpers
live in slot.c, even though they're only called from two functions in
pci_hotplug_core.c.

Inline the helpers to reduce code size and number of exported symbols.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pci_hotplug_core.c | 14 +++++++--
 drivers/pci/slot.c                     | 42 --------------------------
 include/linux/pci.h                    |  5 ---
 3 files changed, 11 insertions(+), 50 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index a992bf51af98..d30f1316c98e 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -245,10 +245,18 @@ static bool has_test_file(struct hotplug_slot *slot)
 
 static int fs_add_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
 {
+	struct kobject *kobj;
 	int retval = 0;
 
 	/* Create symbolic link to the hotplug driver module */
-	pci_hp_create_module_link(pci_slot);
+	kobj = kset_find_obj(module_kset, slot->mod_name);
+	if (kobj) {
+		retval = sysfs_create_link(&pci_slot->kobj, kobj, "module");
+		if (retval)
+			dev_err(&pci_slot->bus->dev,
+				"Error creating sysfs link (%d)\n", retval);
+		kobject_put(kobj);
+	}
 
 	if (has_power_file(slot)) {
 		retval = sysfs_create_file(&pci_slot->kobj,
@@ -302,7 +310,7 @@ static int fs_add_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
 	if (has_power_file(slot))
 		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_power.attr);
 exit_power:
-	pci_hp_remove_module_link(pci_slot);
+	sysfs_remove_link(&pci_slot->kobj, "module");
 exit:
 	return retval;
 }
@@ -326,7 +334,7 @@ static void fs_remove_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
 	if (has_test_file(slot))
 		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_test.attr);
 
-	pci_hp_remove_module_link(pci_slot);
+	sysfs_remove_link(&pci_slot->kobj, "module");
 }
 
 /**
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index dd6e80b7db09..50fb3eb595fe 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -7,7 +7,6 @@
 
 #include <linux/kobject.h>
 #include <linux/slab.h>
-#include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/err.h>
 #include "pci.h"
@@ -325,47 +324,6 @@ void pci_destroy_slot(struct pci_slot *slot)
 }
 EXPORT_SYMBOL_GPL(pci_destroy_slot);
 
-#if defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)
-#include <linux/pci_hotplug.h>
-/**
- * pci_hp_create_module_link - create symbolic link to hotplug driver module
- * @pci_slot: struct pci_slot
- *
- * Helper function for pci_hotplug_core.c to create symbolic link to
- * the hotplug driver module.
- */
-void pci_hp_create_module_link(struct pci_slot *pci_slot)
-{
-	struct hotplug_slot *slot = pci_slot->hotplug;
-	struct kobject *kobj = NULL;
-	int ret;
-
-	kobj = kset_find_obj(module_kset, slot->mod_name);
-	if (!kobj)
-		return;
-	ret = sysfs_create_link(&pci_slot->kobj, kobj, "module");
-	if (ret)
-		dev_err(&pci_slot->bus->dev, "Error creating sysfs link (%d)\n",
-			ret);
-	kobject_put(kobj);
-}
-EXPORT_SYMBOL_GPL(pci_hp_create_module_link);
-
-/**
- * pci_hp_remove_module_link - remove symbolic link to the hotplug driver
- * 	module.
- * @pci_slot: struct pci_slot
- *
- * Helper function for pci_hotplug_core.c to remove symbolic link to
- * the hotplug driver module.
- */
-void pci_hp_remove_module_link(struct pci_slot *pci_slot)
-{
-	sysfs_remove_link(&pci_slot->kobj, "module");
-}
-EXPORT_SYMBOL_GPL(pci_hp_remove_module_link);
-#endif
-
 static int pci_slot_init(void)
 {
 	struct kset *pci_bus_kset;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..a0f5c8fcd9c7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2447,11 +2447,6 @@ static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev, int res
 static inline void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe) { }
 #endif
 
-#if defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)
-void pci_hp_create_module_link(struct pci_slot *pci_slot);
-void pci_hp_remove_module_link(struct pci_slot *pci_slot);
-#endif
-
 /**
  * pci_pcie_cap - get the saved PCIe capability offset
  * @dev: PCI device
-- 
2.43.0


