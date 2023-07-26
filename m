Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B2776366B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 14:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjGZMgP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jul 2023 08:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbjGZMgO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2023 08:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A59211F
        for <linux-pci@vger.kernel.org>; Wed, 26 Jul 2023 05:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690374926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XrRclP6rIDLOdKio+U8eIclA36kjoF7aS12oWTBS7Y8=;
        b=SH5qGEYvSB4HjIar2LqyR/gNL1mViwTG4Nibve5TzFmidKHbz0nCK9qLYTO7nXnm1zTiE6
        zPYRCB4dm+FX4VPq/U+oGp4FK5T93ukdDIIkUDV8A9foQw2zonAxPl1h8OKAAdyCN7jeCy
        01gqoONTi3ddP3mcZ00mw3UcEGiszyc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-wce5mkF9M-aFlY9zMsp0fg-1; Wed, 26 Jul 2023 08:35:23 -0400
X-MC-Unique: wce5mkF9M-aFlY9zMsp0fg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0550F805951;
        Wed, 26 Jul 2023 12:35:23 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4576492B01;
        Wed, 26 Jul 2023 12:35:21 +0000 (UTC)
From:   Igor Mammedov <imammedo@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     terraluna977@gmail.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, imammedo@redhat.com, mst@redhat.com,
        rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 1/1] PCI: acpiphp:: use pci_assign_unassigned_bridge_resources() only if bus->self not NULL
Date:   Wed, 26 Jul 2023 14:35:18 +0200
Message-Id: <20230726123518.2361181-2-imammedo@redhat.com>
In-Reply-To: <20230726123518.2361181-1-imammedo@redhat.com>
References: <20230726123518.2361181-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

Commit [1] switched acpiphp hotplug to use
   pci_assign_unassigned_bridge_resources()
which depends on bridge being available, however in some cases
when acpiphp is in use, enable_slot() can get a slot without
bridge associated.
  1. legitimate case of hotplug on root bus
      (likely not exiting on real hw, but widely used in virt world)
  2. broken firmware, that sends 'Bus check' events to non
     existing root ports (Dell Inspiron 7352/0W6WV0), which somehow
     endup at acpiphp:enable_slot(..., bridge = 0) and with bus
     without bridge assigned to it.

Issue is easy to reproduce with QEMU's 'pc' machine provides
PCI hotplug on hostbridge slots. to reproduce boot kernel at
commit [1] in VM started with followin CLI and hotplug a device:

once guest OS is fully booted at qemu prompt:

(qemu) device_add e1000

it will cause NULL pointer dereference at

    void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
    {
        struct pci_bus *parent = bridge->subordinate;

[  612.277651] BUG: kernel NULL pointer dereference, address: 0000000000000018
[...]
[  612.277798]  ? pci_assign_unassigned_bridge_resources+0x1f/0x260
[  612.277804]  ? pcibios_allocate_dev_resources+0x3c/0x2a0
[  612.277809]  enable_slot+0x21f/0x3e0
[  612.277816]  acpiphp_hotplug_notify+0x13d/0x260
[  612.277822]  ? __pfx_acpiphp_hotplug_notify+0x10/0x10
[  612.277827]  acpi_device_hotplug+0xbc/0x540
[  612.277834]  acpi_hotplug_work_fn+0x15/0x20
[  612.277839]  process_one_work+0x1f7/0x370
[  612.277845]  worker_thread+0x45/0x3b0
[  612.277850]  ? __pfx_worker_thread+0x10/0x10
[  612.277854]  kthread+0xdc/0x110
[  612.277860]  ? __pfx_kthread+0x10/0x10
[  612.277866]  ret_from_fork+0x28/0x40
[  612.277871]  ? __pfx_kthread+0x10/0x10
[  612.277876]  ret_from_fork_asm+0x1b/0x30

The issue was discovered on Dell Inspiron 7352/0W6WV0 laptop with
following sequence:
   1. suspend to RAM
   2. wake up with the same backtrace being observed:
   3. 2nd suspend to RAM attempt makes laptop freeze

Fix it by using __pci_bus_assign_resources() instead of
pci_assign_unassigned_bridge_resources()as we used to do
but only in case when bus doesn't have a bridge associated
with it.

That let us keep hotplug on root bus working like it used to be
but at the same time keeps resource reassignment usable on
root ports (and other 1st level bridges) that was fixed by [1].

1)
Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
Link: https://lore.kernel.org/r/11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com
Reported-by: Woody Suwalski <terraluna977@gmail.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 drivers/pci/hotplug/acpiphp_glue.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 328d1e416014..3bc4e1f3efee 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -498,6 +498,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 				acpiphp_native_scan_bridge(dev);
 		}
 	} else {
+		LIST_HEAD(add_list);
 		int max, pass;
 
 		acpiphp_rescan_slot(slot);
@@ -511,10 +512,15 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 				if (pass && dev->subordinate) {
 					check_hotplug_bridge(slot, dev);
 					pcibios_resource_survey_bus(dev->subordinate);
+					if (!bus->self)
+						__pci_bus_size_bridges(dev->subordinate, &add_list);
 				}
 			}
 		}
-		pci_assign_unassigned_bridge_resources(bus->self);
+		if (bus->self)
+			pci_assign_unassigned_bridge_resources(bus->self);
+		else
+			__pci_bus_assign_resources(bus, &add_list, NULL);
 	}
 
 	acpiphp_sanitize_bus(bus);
-- 
2.39.3

