Return-Path: <linux-pci+bounces-22370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E57FA4488D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A681B7A287D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 17:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2777A1547E3;
	Tue, 25 Feb 2025 17:41:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEE42745E
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505273; cv=none; b=s+s2C6pieYPXVpw5Od9OFJLjLKCdb9Q3r2fUSqiDTzz9j2Xi4HmARLeWI9qNRpbSBHquqCrxNsqsG1bsSznE9X28J1BU5iP2hYOCU1+gKJKTpYz9ykeGQ/OIRZ0nbbcUx/uJtOEcJkYkwLm4ZfU7+Birq5KbqZEb9KRZmeCvDfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505273; c=relaxed/simple;
	bh=aT5Vfu9YC3V56lJrVE0OBivNN805+pXzoGXqQs1NZQc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=aAv9XQLIAZURAl2sp1cgiCXFWes4Qd/xr3u1muAlGbO+0M5pJJAvrHgADrJ0EWx2slbe3XHGEaDSo8N+wmRp6x/99s7ZfsDmxNtlNFFLYm7nrShx9V3ERHyE3s5TeebZeCQF1RA01PDbAY4nWMi2Lnn4aKUSc3vQb+PM3uZTJwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 9F978101917AC;
	Tue, 25 Feb 2025 18:41:07 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 6F5ED6018966;
	Tue, 25 Feb 2025 18:41:07 +0100 (CET)
X-Mailbox-Line: From 5b2f5b4ac45285953d00fd7637732a93fd40d26e Mon Sep 17 00:00:00 2001
Message-ID: <5b2f5b4ac45285953d00fd7637732a93fd40d26e.1740501868.git.lukas@wunner.de>
In-Reply-To: <cover.1740501868.git.lukas@wunner.de>
References: <cover.1740501868.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 25 Feb 2025 18:06:04 +0100
Subject: [PATCH 4/5] PCI: hotplug: Avoid backpointer dereferencing in
 has_*_file()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The PCI hotplug core contains five has_*_file() functions to determine
whether a certain sysfs file shall be added (or removed) for a given
hotplug slot.

The functions receive a struct pci_slot pointer which they have to
dereference back to a struct hotplug_slot.

Avoid by passing them a struct hotplug_slot pointer directly.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pci_hotplug_core.c | 56 +++++++++++---------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index d4c12451570b..a992bf51af98 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -205,10 +205,8 @@ static struct pci_slot_attribute hotplug_slot_attr_test = {
 	.store = test_write_file
 };
 
-static bool has_power_file(struct pci_slot *pci_slot)
+static bool has_power_file(struct hotplug_slot *slot)
 {
-	struct hotplug_slot *slot = pci_slot->hotplug;
-
 	if ((slot->ops->enable_slot) ||
 	    (slot->ops->disable_slot) ||
 	    (slot->ops->get_power_status))
@@ -216,79 +214,71 @@ static bool has_power_file(struct pci_slot *pci_slot)
 	return false;
 }
 
-static bool has_attention_file(struct pci_slot *pci_slot)
+static bool has_attention_file(struct hotplug_slot *slot)
 {
-	struct hotplug_slot *slot = pci_slot->hotplug;
-
 	if ((slot->ops->set_attention_status) ||
 	    (slot->ops->get_attention_status))
 		return true;
 	return false;
 }
 
-static bool has_latch_file(struct pci_slot *pci_slot)
+static bool has_latch_file(struct hotplug_slot *slot)
 {
-	struct hotplug_slot *slot = pci_slot->hotplug;
-
 	if (slot->ops->get_latch_status)
 		return true;
 	return false;
 }
 
-static bool has_adapter_file(struct pci_slot *pci_slot)
+static bool has_adapter_file(struct hotplug_slot *slot)
 {
-	struct hotplug_slot *slot = pci_slot->hotplug;
-
 	if (slot->ops->get_adapter_status)
 		return true;
 	return false;
 }
 
-static bool has_test_file(struct pci_slot *pci_slot)
+static bool has_test_file(struct hotplug_slot *slot)
 {
-	struct hotplug_slot *slot = pci_slot->hotplug;
-
 	if (slot->ops->hardware_test)
 		return true;
 	return false;
 }
 
-static int fs_add_slot(struct pci_slot *pci_slot)
+static int fs_add_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
 {
 	int retval = 0;
 
 	/* Create symbolic link to the hotplug driver module */
 	pci_hp_create_module_link(pci_slot);
 
-	if (has_power_file(pci_slot)) {
+	if (has_power_file(slot)) {
 		retval = sysfs_create_file(&pci_slot->kobj,
 					   &hotplug_slot_attr_power.attr);
 		if (retval)
 			goto exit_power;
 	}
 
-	if (has_attention_file(pci_slot)) {
+	if (has_attention_file(slot)) {
 		retval = sysfs_create_file(&pci_slot->kobj,
 					   &hotplug_slot_attr_attention.attr);
 		if (retval)
 			goto exit_attention;
 	}
 
-	if (has_latch_file(pci_slot)) {
+	if (has_latch_file(slot)) {
 		retval = sysfs_create_file(&pci_slot->kobj,
 					   &hotplug_slot_attr_latch.attr);
 		if (retval)
 			goto exit_latch;
 	}
 
-	if (has_adapter_file(pci_slot)) {
+	if (has_adapter_file(slot)) {
 		retval = sysfs_create_file(&pci_slot->kobj,
 					   &hotplug_slot_attr_presence.attr);
 		if (retval)
 			goto exit_adapter;
 	}
 
-	if (has_test_file(pci_slot)) {
+	if (has_test_file(slot)) {
 		retval = sysfs_create_file(&pci_slot->kobj,
 					   &hotplug_slot_attr_test.attr);
 		if (retval)
@@ -298,18 +288,18 @@ static int fs_add_slot(struct pci_slot *pci_slot)
 	goto exit;
 
 exit_test:
-	if (has_adapter_file(pci_slot))
+	if (has_adapter_file(slot))
 		sysfs_remove_file(&pci_slot->kobj,
 				  &hotplug_slot_attr_presence.attr);
 exit_adapter:
-	if (has_latch_file(pci_slot))
+	if (has_latch_file(slot))
 		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_latch.attr);
 exit_latch:
-	if (has_attention_file(pci_slot))
+	if (has_attention_file(slot))
 		sysfs_remove_file(&pci_slot->kobj,
 				  &hotplug_slot_attr_attention.attr);
 exit_attention:
-	if (has_power_file(pci_slot))
+	if (has_power_file(slot))
 		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_power.attr);
 exit_power:
 	pci_hp_remove_module_link(pci_slot);
@@ -317,23 +307,23 @@ static int fs_add_slot(struct pci_slot *pci_slot)
 	return retval;
 }
 
-static void fs_remove_slot(struct pci_slot *pci_slot)
+static void fs_remove_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
 {
-	if (has_power_file(pci_slot))
+	if (has_power_file(slot))
 		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_power.attr);
 
-	if (has_attention_file(pci_slot))
+	if (has_attention_file(slot))
 		sysfs_remove_file(&pci_slot->kobj,
 				  &hotplug_slot_attr_attention.attr);
 
-	if (has_latch_file(pci_slot))
+	if (has_latch_file(slot))
 		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_latch.attr);
 
-	if (has_adapter_file(pci_slot))
+	if (has_adapter_file(slot))
 		sysfs_remove_file(&pci_slot->kobj,
 				  &hotplug_slot_attr_presence.attr);
 
-	if (has_test_file(pci_slot))
+	if (has_test_file(slot))
 		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_test.attr);
 
 	pci_hp_remove_module_link(pci_slot);
@@ -437,7 +427,7 @@ int pci_hp_add(struct hotplug_slot *slot)
 
 	pci_slot = slot->pci_slot;
 
-	result = fs_add_slot(pci_slot);
+	result = fs_add_slot(slot, pci_slot);
 	if (result)
 		return result;
 
@@ -471,7 +461,7 @@ void pci_hp_del(struct hotplug_slot *slot)
 	if (WARN_ON(!slot))
 		return;
 
-	fs_remove_slot(slot->pci_slot);
+	fs_remove_slot(slot, slot->pci_slot);
 }
 EXPORT_SYMBOL_GPL(pci_hp_del);
 
-- 
2.43.0


