Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958AE774A2C
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 22:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHHUVH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 16:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjHHUU5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 16:20:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838495998;
        Tue,  8 Aug 2023 12:27:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19E4962ADC;
        Tue,  8 Aug 2023 19:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34991C433C7;
        Tue,  8 Aug 2023 19:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691522838;
        bh=koE2O1Koz3SVVKu8roIdMywrfi7dwuz5XC5ik2SFJXw=;
        h=From:To:Cc:Subject:Date:From;
        b=O1AjCojo2d4ECuimgWH06jPVzpH/QaAERktmLINMADX9gxIv1KBq+55GKvibimJBB
         SsWDa//FvdN9mLvCF6Gz4rzR00jpDVYgYeTNdbkw6EsoXxvr/ZqK3rsV0FNfyMMQYV
         AamSt0PbthTiZDUoxsDeSVO/IH8shpSyUbmwsK9SxQ/NwLmuyLuVULxcgOSrT960SK
         fVGeJw2xy5Aawhe66juAqadI53xX/X6Z6biI5VqucHCU1xsx+vl5xx1myfhclOCjmo
         J/TOmYfZnOhyRJrh7r2XX8hb6qYgBP66rNaABthrYrY1YO0rpe3QlxO7aMYe0Huqb+
         b07MmClz7aimQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Igor Mammedov <imammedo@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Woody Suwalski <terraluna977@gmail.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: acpiphp: Log more slot and notification details
Date:   Tue,  8 Aug 2023 14:27:13 -0500
Message-Id: <20230808192713.329414-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

When registering an acpiphp slot, log the slot name in the same style as
pciehp and include the PCI bus/device and whether a device is present or
the slot is empty.

When handling an ACPI notification, log the PCI bus/device and notification
type.

Sample dmesg log diff:

    ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
  - acpiphp: Slot [3] registered
  - acpiphp: Slot [4] registered
    PCI host bridge to bus 0000:00
    pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
    <ACPI Device Check notification>
    pci 0000:00:04.0: [8086:100e] type 00 class 0x020000

    ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
  + acpiphp: pci 0000:00:03 Slot(3) registered (enabled)
  + acpiphp: pci 0000:00:04 Slot(4) registered (empty)
    PCI host bridge to bus 0000:00
    pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
    <ACPI Device Check notification>
  + acpiphp: pci 0000:00:04 Slot(4) Device Check
    pci 0000:00:04.0: [8086:100e] type 00 class 0x020000

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/acpiphp_core.c |  4 ----
 drivers/pci/hotplug/acpiphp_glue.c | 23 +++++++++++++++++++++--
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_core.c b/drivers/pci/hotplug/acpiphp_core.c
index c02257f4b61c..19d47607d009 100644
--- a/drivers/pci/hotplug/acpiphp_core.c
+++ b/drivers/pci/hotplug/acpiphp_core.c
@@ -282,8 +282,6 @@ int acpiphp_register_hotplug_slot(struct acpiphp_slot *acpiphp_slot,
 		goto error_slot;
 	}
 
-	pr_info("Slot [%s] registered\n", slot_name(slot));
-
 	return 0;
 error_slot:
 	kfree(slot);
@@ -296,8 +294,6 @@ void acpiphp_unregister_hotplug_slot(struct acpiphp_slot *acpiphp_slot)
 {
 	struct slot *slot = acpiphp_slot->slot;
 
-	pr_info("Slot [%s] unregistered\n", slot_name(slot));
-
 	pci_hp_deregister(&slot->hotplug_slot);
 	kfree(slot);
 }
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 328d1e416014..eeca2753a5c7 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -25,7 +25,7 @@
  *    bus. It loses the refcount when the driver unloads.
  */
 
-#define pr_fmt(fmt) "acpiphp_glue: " fmt
+#define pr_fmt(fmt) "acpiphp: " fmt
 
 #include <linux/module.h>
 
@@ -333,6 +333,12 @@ static acpi_status acpiphp_add_context(acpi_handle handle, u32 lvl, void *data,
 				       &val, 60*1000))
 		slot->flags |= SLOT_ENABLED;
 
+	if (slot->slot)
+		pr_info("pci %04x:%02x:%02x Slot(%s) registered (%s)\n",
+			pci_domain_nr(slot->bus), slot->bus->number,
+			slot->device, slot_name(slot->slot),
+			slot->flags & SLOT_ENABLED ? "enabled" : "empty");
+
 	return AE_OK;
 }
 
@@ -351,8 +357,13 @@ static void cleanup_bridge(struct acpiphp_bridge *bridge)
 			acpi_unlock_hp_context();
 		}
 		slot->flags |= SLOT_IS_GOING_AWAY;
-		if (slot->slot)
+		if (slot->slot) {
+			pr_info("pci %04x:%02x:%02x Slot(%s) unregistered\n",
+				pci_domain_nr(slot->bus), slot->bus->number,
+				slot->device, slot_name(slot->slot));
+
 			acpiphp_unregister_hotplug_slot(slot);
+		}
 	}
 
 	mutex_lock(&bridge_mutex);
@@ -793,6 +804,14 @@ static void hotplug_event(u32 type, struct acpiphp_context *context)
 
 	pci_lock_rescan_remove();
 
+	pr_info("pci %04x:%02x:%02x Slot(%s) %s\n",
+		pci_domain_nr(slot->bus), slot->bus->number,
+		slot->device, slot_name(slot->slot),
+		type == ACPI_NOTIFY_BUS_CHECK ? "Bus Check" :
+		type == ACPI_NOTIFY_DEVICE_CHECK ? "Device Check" :
+		type == ACPI_NOTIFY_EJECT_REQUEST ? "Eject Request" :
+		"Notification");
+
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
 		/* bus re-enumerate */
-- 
2.34.1

