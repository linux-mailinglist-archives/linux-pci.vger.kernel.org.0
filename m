Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF34761696
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 13:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbjGYLkk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 07:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbjGYLkf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 07:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D1019BB
        for <linux-pci@vger.kernel.org>; Tue, 25 Jul 2023 04:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690285186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5VZeYOBC+l8vnH+wdystzCFWmM5KCh4aRJ8MZ/Spvzc=;
        b=U8Jbemw+nctCyIYyeOT+48spm4IutiGk1DjshrcePqei7aYyQUCReUf01w2vyaFGakRqTM
        SFct6KX43vIprjCTAMzfkmEFiM9wYme5Sjn0DIn8Vv4A4wLgrH7K/X31CiFlynMnbUGebd
        ID5+/ILqKDc9rz5kyyNapMr4vSoJeAE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-N4Ozd6FYNXSiFJqw3SJEuQ-1; Tue, 25 Jul 2023 07:39:43 -0400
X-MC-Unique: N4Ozd6FYNXSiFJqw3SJEuQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EF9C856F67;
        Tue, 25 Jul 2023 11:39:42 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABD5E4094DC0;
        Tue, 25 Jul 2023 11:39:41 +0000 (UTC)
From:   Igor Mammedov <imammedo@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     terraluna977@gmail.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, imammedo@redhat.com, mst@redhat.com
Subject: [RFC 1/3] acpiphp: extra debug hack
Date:   Tue, 25 Jul 2023 13:39:36 +0200
Message-Id: <20230725113938.2277420-2-imammedo@redhat.com>
In-Reply-To: <20230725113938.2277420-1-imammedo@redhat.com>
References: <20230725113938.2277420-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 drivers/pci/hotplug/acpiphp_glue.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 5b1f271c6034..af1c73f2bee6 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -485,6 +485,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 	struct pci_bus *bus = slot->bus;
 	struct acpiphp_func *func;
 
+pci_info(bus, "enable_slot bus: bridge: %d, bus->self: %p\n", bridge, bus->self);
 	if (bridge && bus->self && hotplug_is_native(bus->self)) {
 		/*
 		 * If native hotplug is used, it will take care of hotplug
@@ -544,6 +545,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 		}
 		pci_dev_put(dev);
 	}
+pr_err("enable_slot: end\n");
 }
 
 /**
@@ -702,16 +704,20 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
 	if (bridge->is_going_away)
 		return;
 
-	if (bridge->pci_dev)
+	if (bridge->pci_dev) {
 		pm_runtime_get_sync(&bridge->pci_dev->dev);
+pci_info(bridge->pci_dev, "acpiphp_check_bridge\n");
+        }
 
 	list_for_each_entry(slot, &bridge->slots, node) {
 		struct pci_bus *bus = slot->bus;
 		struct pci_dev *dev, *tmp;
 
 		if (slot_no_hotplug(slot)) {
+pr_err("acpiphp_check_bridge: slot_no_hotplug\n");
 			; /* do nothing */
 		} else if (device_status_valid(get_slot_status(slot))) {
+pr_err("acpiphp_check_bridge: device_status_valid\n");
 			/* remove stale devices if any */
 			list_for_each_entry_safe_reverse(dev, tmp,
 							 &bus->devices, bus_list)
@@ -792,6 +798,7 @@ static void hotplug_event(u32 type, struct acpiphp_context *context)
 	if (bridge)
 		get_bridge(bridge);
 
+        acpi_handle_debug(handle, "hotplug_event: Slot: %s\n", slot_name(slot->slot)); 
 	acpi_unlock_hp_context();
 
 	pci_lock_rescan_remove();
@@ -799,7 +806,7 @@ static void hotplug_event(u32 type, struct acpiphp_context *context)
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
 		/* bus re-enumerate */
-		acpi_handle_debug(handle, "Bus check in %s()\n", __func__);
+		acpi_handle_debug(handle, "Bus check in %s(): bridge: %p\n", __func__, bridge);
 		if (bridge)
 			acpiphp_check_bridge(bridge);
 		else if (!(slot->flags & SLOT_IS_GOING_AWAY))
-- 
2.39.3

