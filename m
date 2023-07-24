Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B6575F91A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 16:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjGXN76 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 09:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGXN75 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 09:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F233F125
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2023 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690207149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P2aZVU7pPnDc/RmZQW4iakWRtXamS7FJFx+fSy45nyM=;
        b=QymtMmsTSY3Ev2cIqp6Ix7MseEEcWqIwRWNx3PhIqH2fSbt3fa+2F/JBee0l6rYM1grPHV
        3EWyDEDk0QvVdHs/p01w/F0Xg5T67hU5WBkgPKmU5DM38YssvZLUS2tnoNGEjsnyKUjQW/
        DcGQRxYVNKyb88niZ/CjiXBEupfsMgM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-NK6o2GkLNmuwifLXGGNa6Q-1; Mon, 24 Jul 2023 09:59:05 -0400
X-MC-Unique: NK6o2GkLNmuwifLXGGNa6Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51785800159;
        Mon, 24 Jul 2023 13:59:05 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67ED040C2063;
        Mon, 24 Jul 2023 13:59:04 +0000 (UTC)
From:   Igor Mammedov <imammedo@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     terraluna977@gmail.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, imammedo@redhat.com, mst@redhat.com
Subject: [PATCH] hack to debug acpiphp crash
Date:   Mon, 24 Jul 2023 15:59:02 +0200
Message-Id: <20230724135902.2217991-1-imammedo@redhat.com>
In-Reply-To: <11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com>
References: <11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Woody thanks for testing,

can you try following patch which will try to workaround NULL bus->self if it's
a really cuplrit and print an extra debug information.
Add following to kernel command line(make sure that CONFIG_DYNAMIC_DEBUG is enabled):

dyndbg="file drivers/pci/access.c +p; file drivers/pci/hotplug/acpiphp_glue.c +p; file drivers/pci/bus.c +p; file drivers/pci/pci.c +p; file drivers/pci/setup-bus.c +p" ignore_loglevel

What I find odd in you logs is that enable_slot() is called while native PCIe
should be used. Additional info might help to understand what's going on:
  1: 'lspci' output
  2:  DSDT and all SSDT ACPI tables (you can use 'acpidump -b' to get them).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 drivers/pci/hotplug/acpiphp_glue.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 328d1e416014..9ce3fd9d72a9 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -485,7 +485,10 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 	struct pci_bus *bus = slot->bus;
 	struct acpiphp_func *func;
 
+WARN(1, "enable_slot");
+pci_info(bus, "enable_slot bus\n");
 	if (bridge && bus->self && hotplug_is_native(bus->self)) {
+pr_err("enable_slot: bridge branch\n");
 		/*
 		 * If native hotplug is used, it will take care of hotplug
 		 * slot management and resource allocation for hotplug
@@ -498,8 +501,10 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 				acpiphp_native_scan_bridge(dev);
 		}
 	} else {
+		LIST_HEAD(add_list);
 		int max, pass;
 
+pr_err("enable_slot: acpiphp_rescan_slot branch\n");
 		acpiphp_rescan_slot(slot);
 		max = acpiphp_max_busnr(bus);
 		for (pass = 0; pass < 2; pass++) {
@@ -508,13 +513,23 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 					continue;
 
 				max = pci_scan_bridge(bus, dev, max, pass);
+pci_info(dev, "enable_slot: pci_scan_bridge: max: %d\n", max);
 				if (pass && dev->subordinate) {
 					check_hotplug_bridge(slot, dev);
 					pcibios_resource_survey_bus(dev->subordinate);
+                                        if (bus->self)
+						__pci_bus_size_bridges(dev->subordinate,
+								       &add_list);
 				}
 			}
 		}
-		pci_assign_unassigned_bridge_resources(bus->self);
+                if (bus->self) {
+pci_info(bus->self, "enable_slot: pci_assign_unassigned_bridge_resources:\n");
+			pci_assign_unassigned_bridge_resources(bus->self);
+                } else {
+pci_info(bus, "enable_slot: __pci_bus_assign_resources:\n");
+			__pci_bus_assign_resources(bus, &add_list, NULL);
+		}
 	}
 
 	acpiphp_sanitize_bus(bus);
@@ -541,6 +556,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 		}
 		pci_dev_put(dev);
 	}
+pr_err("enable_slot: end\n");
 }
 
 /**
-- 
2.39.3

