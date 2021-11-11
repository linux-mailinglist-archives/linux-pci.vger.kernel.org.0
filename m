Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDB644D3B2
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 10:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhKKJFx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 04:05:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232366AbhKKJFw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Nov 2021 04:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636621383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HDJlKWmITGGiSJRAEgTyI1lTFGvuDXl7ywXp7NhlzRE=;
        b=LJCu5iS/RbnNj5LCnro7rkJt0paVSu5lYZW7FNA51ZZAt2/hKw4c1l4j5Z/ezwEWki7LbW
        eGKGGZl218xFzaJEJSknH2g/5Vt1GHiKy2JseuPvacbyf42T7l9WTLAkOpZA++uK34LMde
        WiJBbQOoMDwHHtY9QEEbwaeKN1TFwIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-MfuEAeLuO3u2l5bcJsuzqA-1; Thu, 11 Nov 2021 04:03:00 -0500
X-MC-Unique: MfuEAeLuO3u2l5bcJsuzqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74A901927800;
        Thu, 11 Nov 2021 09:02:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.245])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23DA05D6D7;
        Thu, 11 Nov 2021 09:02:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 67A061800925; Thu, 11 Nov 2021 10:02:44 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     linux-pci@vger.kernel.org
Cc:     mst@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] pciehp: fast unplug for virtual machines
Date:   Thu, 11 Nov 2021 10:02:24 +0100
Message-Id: <20211111090225.946381-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe specification asks the OS to wait five seconds after the
attention button has been pressed before actually un-plugging the
device.  This gives the operator the chance to cancel the operation
by pressing the attention button again within those five seconds.

For physical hardware this makes sense.  Picking the wrong button
by accident can easily happen and it can be corrected that way.

For virtual hardware the benefits are questionable.  Typically
users find the five second delay annoying.

This patch adds the fast_virtual_unplug module parameter to the
pciehp driver.  When enabled (which is the default) the linux
kernel will simply skip the delay for virtual pcie ports, which
reduces the total time for the unplug operation from 6-7 seconds
to 1-2 seconds.

Virtual pcie ports are identified by PCI ID.  For now the qemu
pcie root ports are detected, other hardware can be added easily.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/pci/hotplug/pciehp.h      |  3 +++
 drivers/pci/hotplug/pciehp_core.c |  5 +++++
 drivers/pci/hotplug/pciehp_ctrl.c | 11 ++++++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 69fd401691be..131ffec2e947 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -79,6 +79,7 @@ extern int pciehp_poll_time;
  * @request_result: result of last user request submitted to the IRQ thread
  * @requester: wait queue to wake up on completion of user request,
  *	used for synchronous slot enable/disable request via sysfs
+ * @is_virtual: virtual machine pcie port.
  *
  * PCIe hotplug has a 1:1 relationship between controller and slot, hence
  * unlike other drivers, the two aren't represented by separate structures.
@@ -109,6 +110,8 @@ struct controller {
 	unsigned int ist_running;
 	int request_result;
 	wait_queue_head_t requester;
+
+	bool is_virtual;
 };
 
 /**
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ad3393930ecb..28867ec33f5b 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -227,6 +227,11 @@ static int pciehp_probe(struct pcie_device *dev)
 		goto err_out_shutdown_notification;
 	}
 
+	if (dev->port->vendor == PCI_VENDOR_ID_REDHAT &&
+	    dev->port->device == 0x000c)
+		/* qemu pcie root port */
+		ctrl->is_virtual = true;
+
 	pciehp_check_presence(ctrl);
 
 	return 0;
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 529c34808440..119bb11f87d6 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -15,12 +15,17 @@
 
 #define dev_fmt(fmt) "pciehp: " fmt
 
+#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/pm_runtime.h>
 #include <linux/pci.h>
 #include "pciehp.h"
 
+static bool fast_virtual_unplug = true;
+module_param(fast_virtual_unplug, bool, 0644);
+MODULE_PARM_DESC(fast_virtual_unplug, "Fast unplug (don't wait 5 seconds) for virtual machines.");
+
 /* The following routines constitute the bulk of the
    hotplug controller logic
  */
@@ -176,7 +181,11 @@ void pciehp_handle_button_press(struct controller *ctrl)
 		/* blink power indicator and turn off attention */
 		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
 				      PCI_EXP_SLTCTL_ATTN_IND_OFF);
-		schedule_delayed_work(&ctrl->button_work, 5 * HZ);
+		if (ctrl->is_virtual && fast_virtual_unplug) {
+			schedule_delayed_work(&ctrl->button_work, 1);
+		} else {
+			schedule_delayed_work(&ctrl->button_work, 5 * HZ);
+		}
 		break;
 	case BLINKINGOFF_STATE:
 	case BLINKINGON_STATE:
-- 
2.33.1

