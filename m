Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8767616A6
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 13:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbjGYLkw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 07:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbjGYLkm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 07:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A95CA0
        for <linux-pci@vger.kernel.org>; Tue, 25 Jul 2023 04:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690285191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WOPLGXJyHcm8uItFp881KDB1MO8xx1vwf3DX/HVbIqA=;
        b=V/DNqq90KrgB4G6+GGNicZUmn7g9tFgsCWcJK7KlTtDcxX4htgU3nxNPRkwoX+t+lmE/HE
        G6eDeILnKuLCe6tC1xSqYrrLTX+4EImdlRqD12/eHZH+OrqPUbfCK+dxp0PYzgOKpCsO3R
        prcEaHfBWL5dOXi6tE9OiBjHZYpDGmU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-geGf6MLaOEGavSKJSuucHA-1; Tue, 25 Jul 2023 07:39:45 -0400
X-MC-Unique: geGf6MLaOEGavSKJSuucHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFCF680027F;
        Tue, 25 Jul 2023 11:39:44 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 186844094DC0;
        Tue, 25 Jul 2023 11:39:43 +0000 (UTC)
From:   Igor Mammedov <imammedo@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     terraluna977@gmail.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, imammedo@redhat.com, mst@redhat.com
Subject: [RFC 3/3] acpipcihp: use __pci_bus_assign_resources() if bus doesn't have bridge
Date:   Tue, 25 Jul 2023 13:39:38 +0200
Message-Id: <20230725113938.2277420-4-imammedo@redhat.com>
In-Reply-To: <20230725113938.2277420-1-imammedo@redhat.com>
References: <20230725113938.2277420-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit [1] switched hotplug to pci_assign_unassigned_bridge_resources()
which requires bridge being available, however in S3 suspend/resume
cycle  acpipcihp might receive device check event from firmware and
in case bus->self == NULL, it would make kernel crash with NULL pointer
dereference.
The issue was triggered on  Dell Inspiron 7352/0W6WV0 laptop with
following sequence:
   1. suspend to RAM
   2. wake up
   3. suspend to RAM. which immediately wakes up and following
      backtrace is observed:

[  612.277651] BUG: kernel NULL pointer dereference, address: 0000000000000018
[...]
[  612.277735] Call Trace:
[  612.277739]  <TASK>
[  612.277741]  ? __die+0x1a/0x60
[  612.277749]  ? page_fault_oops+0x158/0x430
[  612.277755]  ? prb_read_valid+0x12/0x20
[  612.277759]  ? console_unlock+0x4d/0x100
[  612.277765]  ? __irq_work_queue_local+0x27/0x60
[  612.277771]  ? irq_work_queue+0x2b/0x50
[  612.277776]  ? exc_page_fault+0x357/0x600
[  612.277781]  ? dev_printk_emit+0x7e/0xa0
[  612.277786]  ? asm_exc_page_fault+0x22/0x30
[  612.277792]  ? __pfx_pci_conf1_read+0x10/0x10
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

Fix it by reverting to __pci_bus_assign_resources() usage instead of
pci_assign_unassigned_bridge_resources() when bus doesn't have bridge
assigned to it.

1) 40613da52b13fb21 (PCI: acpiphp: Reassign resources on bridge if necessary)

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v2: fix inverted bus->self condition
---
 drivers/pci/hotplug/acpiphp_glue.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index c0ffb1389fda..816555ab9171 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -499,6 +499,7 @@ pci_info(bus, "enable_slot bus: bridge: %d, bus->self: %p\n", bridge, bus->self)
 				acpiphp_native_scan_bridge(dev);
 		}
 	} else {
+		LIST_HEAD(add_list);
 		int max, pass;
 
 		acpiphp_rescan_slot(slot);
@@ -512,10 +513,18 @@ pci_info(bus, "enable_slot bus: bridge: %d, bus->self: %p\n", bridge, bus->self)
 				if (pass && dev->subordinate) {
 					check_hotplug_bridge(slot, dev);
 					pcibios_resource_survey_bus(dev->subordinate);
+					if (!bus->self)
+						__pci_bus_size_bridges(dev->subordinate, &add_list);
 				}
 			}
 		}
-		pci_assign_unassigned_bridge_resources(bus->self);
+		if (bus->self) {
+pci_info(bus->self, "enable_slot: pci_assign_unassigned_bridge_resources:\n");
+			pci_assign_unassigned_bridge_resources(bus->self);
+		} else {
+pci_info(bus, "enable_slot: __pci_bus_assign_resources:\n");
+			__pci_bus_assign_resources(bus, &add_list, NULL);
+                }
 	}
 
 	acpiphp_sanitize_bus(bus);
-- 
2.39.3

