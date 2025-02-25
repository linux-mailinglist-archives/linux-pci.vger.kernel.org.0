Return-Path: <linux-pci+bounces-22369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ACDA44908
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02E1884855
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 17:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1821A8F79;
	Tue, 25 Feb 2025 17:36:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ED51A3166
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505016; cv=none; b=Y7RcPQXML56JJOxgac6tf8U4S8cUWPoF44klGAHBdC9lULv2zsGw2JLX3qo5CwHyiei1lHv851bVkRaXptF0qcrn48ZMMxDDV8g8N8k8QpEnQYbG8TA3BHc/dkmNhite5LL98bKF3YTfd99w9fBWC34xcxK/ugmLHP5YWCVnh6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505016; c=relaxed/simple;
	bh=XTs3UVqhVHPpeOv+skJ7J9zOo8H/NaQifEvJVUukXJo=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=gkWFdNsbUgZHNxA8Yxk4AVU6u7kW6q/JiHbX13YKr6EC+8DCFmAHDxPmcjRLN3o/qOB3DGbc+THzic18kP3hPLUaIidDJnp+d9a6pGm6TpLLGx8KlgvPVJOO6KwY9FptbLV000RmHfe8Jf+dKl6RijcTstWH3gemsG3LHhc/LzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 35A7E101917AC;
	Tue, 25 Feb 2025 18:36:51 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id F34F46018966;
	Tue, 25 Feb 2025 18:36:50 +0100 (CET)
X-Mailbox-Line: From 37d1928edf8c3201a8b10794f1db3142e16e02b9 Mon Sep 17 00:00:00 2001
Message-ID: <37d1928edf8c3201a8b10794f1db3142e16e02b9.1740501868.git.lukas@wunner.de>
In-Reply-To: <cover.1740501868.git.lukas@wunner.de>
References: <cover.1740501868.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 25 Feb 2025 18:06:03 +0100
Subject: [PATCH 3/5] PCI: hotplug: Drop superfluous NULL pointer checks in
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

The functions perform NULL pointer checks for the hotplug_slot and its
hotplug_slot_ops.  However the callers already perform these checks:

  pci_hp_register()
    __pci_hp_register()
      __pci_hp_initialize()

  pci_hp_deregister()
    pci_hp_del()

The only way to actually trigger these checks is to call pci_hp_add()
without having called pci_hp_initialize().

Amend pci_hp_add() to catch that and drop the now superfluous NULL
pointer checks in has_*_file().

Drop the same superfluous checks from pci_hp_create_module_link(),
which is (only) called from pci_hp_add().

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pci_hotplug_core.c | 17 ++++++-----------
 drivers/pci/slot.c                     |  2 --
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index de5b501b40be..d4c12451570b 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -209,8 +209,6 @@ static bool has_power_file(struct pci_slot *pci_slot)
 {
 	struct hotplug_slot *slot = pci_slot->hotplug;
 
-	if ((!slot) || (!slot->ops))
-		return false;
 	if ((slot->ops->enable_slot) ||
 	    (slot->ops->disable_slot) ||
 	    (slot->ops->get_power_status))
@@ -222,8 +220,6 @@ static bool has_attention_file(struct pci_slot *pci_slot)
 {
 	struct hotplug_slot *slot = pci_slot->hotplug;
 
-	if ((!slot) || (!slot->ops))
-		return false;
 	if ((slot->ops->set_attention_status) ||
 	    (slot->ops->get_attention_status))
 		return true;
@@ -234,8 +230,6 @@ static bool has_latch_file(struct pci_slot *pci_slot)
 {
 	struct hotplug_slot *slot = pci_slot->hotplug;
 
-	if ((!slot) || (!slot->ops))
-		return false;
 	if (slot->ops->get_latch_status)
 		return true;
 	return false;
@@ -245,8 +239,6 @@ static bool has_adapter_file(struct pci_slot *pci_slot)
 {
 	struct hotplug_slot *slot = pci_slot->hotplug;
 
-	if ((!slot) || (!slot->ops))
-		return false;
 	if (slot->ops->get_adapter_status)
 		return true;
 	return false;
@@ -256,8 +248,6 @@ static bool has_test_file(struct pci_slot *pci_slot)
 {
 	struct hotplug_slot *slot = pci_slot->hotplug;
 
-	if ((!slot) || (!slot->ops))
-		return false;
 	if (slot->ops->hardware_test)
 		return true;
 	return false;
@@ -439,9 +429,14 @@ EXPORT_SYMBOL_GPL(__pci_hp_initialize);
  */
 int pci_hp_add(struct hotplug_slot *slot)
 {
-	struct pci_slot *pci_slot = slot->pci_slot;
+	struct pci_slot *pci_slot;
 	int result;
 
+	if (WARN_ON(!slot))
+		return -EINVAL;
+
+	pci_slot = slot->pci_slot;
+
 	result = fs_add_slot(pci_slot);
 	if (result)
 		return result;
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 36b44be0489d..dd6e80b7db09 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -340,8 +340,6 @@ void pci_hp_create_module_link(struct pci_slot *pci_slot)
 	struct kobject *kobj = NULL;
 	int ret;
 
-	if (!slot || !slot->ops)
-		return;
 	kobj = kset_find_obj(module_kset, slot->mod_name);
 	if (!kobj)
 		return;
-- 
2.43.0


