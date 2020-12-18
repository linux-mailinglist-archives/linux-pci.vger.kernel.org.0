Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8728E2DE87E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 18:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgLRRnQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 12:43:16 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:38594 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728303AbgLRRnP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Dec 2020 12:43:15 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 1DEFF413C6;
        Fri, 18 Dec 2020 17:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1608313286; x=1610127687; bh=q1nRneZFbxTjerthzgu+a2DaENJ6zgP/ikt
        PPRLbAr0=; b=KrhnxaIu7jZR0kOoT0/LrAz+0SRbiDQhEqg0er38zt9JFtdQbi5
        A5b+mwz90cQk/jgsAP6g/30x18zndsbYPIp13VzagmmIyWDZ6YyyjtBuY9pW2Iz+
        VQLbeG0xx5KXeat2pwlB6m/d/PIahcKBKZJ/M1ZCHhyCvYf99OALr8pM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iEx8a77-hEw5; Fri, 18 Dec 2020 20:41:26 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 016A7413D8;
        Fri, 18 Dec 2020 20:41:10 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 18
 Dec 2020 20:41:09 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v9 20/26] PCI: hotplug: Retry bus assignment without reserved space
Date:   Fri, 18 Dec 2020 20:40:05 +0300
Message-ID: <20201218174011.340514-21-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A hot-added bridge with many hotplug-capable ports may request reserving
more IO space than the machine has. This could be overridden with the
"hpiosize=" kernel argument though.

But when BARs are movable, no need to reserve space anymore: new BARs are
allocated not from reserved gaps, but via rearranging the existing BARs.
Requesting a precise amount of space for bridge windows increases the
chances of adding the new bridge successfully.

Still, fixed BARs may interfere with an allocation, preventing it from
happening. So it makes sense to reserve some space when it is possible, so
movable BARs can be moved a bit more effectively later.

If a BAR allocation fails with additional bridge size, retry without them.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.h       | 1 +
 drivers/pci/probe.c     | 9 +++++++++
 drivers/pci/setup-bus.c | 9 +++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f7460ddd196a..685284c57a28 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -207,6 +207,7 @@ extern unsigned long pci_hotplug_io_size;
 extern unsigned long pci_hotplug_mmio_size;
 extern unsigned long pci_hotplug_mmio_pref_size;
 extern unsigned long pci_hotplug_bus_size;
+extern bool pci_hotplug_expand;
 
 /**
  * pci_match_one_device - Tell if a PCI device structure has a matching
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b8873ee82a4b..24793766b4b7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -41,6 +41,7 @@ EXPORT_SYMBOL(pci_root_buses);
  * were assigned before the rescan.
  */
 static bool pci_try_failed_bars = true;
+bool pci_hotplug_expand = true;
 bool pci_init_done;
 
 static LIST_HEAD(pci_domain_busn_res_list);
@@ -3542,6 +3543,13 @@ static void pci_reassign_root_bus_resources(struct pci_bus *root)
 		if (pci_bus_check_bars_assigned(root, pci_try_failed_bars))
 			break;
 
+		if (pci_hotplug_expand) {
+			dev_warn(&root->dev, "failed to assign all BARs, retry without additional window size\n");
+
+			pci_hotplug_expand = false;
+			continue;
+		}
+
 		if (pci_try_failed_bars) {
 			dev_warn(&root->dev, "failed to assign all BARs, retry without those failed before\n");
 
@@ -3564,6 +3572,7 @@ static void pci_reassign_root_bus_resources(struct pci_bus *root)
 	} while (true);
 
 	pci_try_failed_bars = true;
+	pci_hotplug_expand = true;
 }
 
 /**
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f98772474421..4b37815a9fcf 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1058,6 +1058,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	resource_size_t children_add_size = 0;
 	resource_size_t children_add_align = 0;
 	resource_size_t add_align = 0;
+	bool size0_can_add = pci_can_move_bars && !realloc_head;
 	int idx;
 	struct resource *fixed_range;
 	resource_size_t fixed_size;
@@ -1141,7 +1142,11 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
 	min_align = calculate_mem_align(aligns, max_order);
 	min_align = max(min_align, window_alignment(bus, b_res->flags));
-	size0 = calculate_memsize(size, min_size, 0, 0, resource_size(b_res), min_align);
+	size0 = calculate_memsize(size, min_size,
+				  size0_can_add ? add_size : 0,
+				  size0_can_add ? children_add_size : 0,
+				  resource_size(b_res), min_align);
+
 	add_align = max(min_align, add_align);
 	size1 = (!realloc_head || (realloc_head && !add_size && !children_add_size)) ? size0 :
 		calculate_memsize(size, min_size, add_size, children_add_size,
@@ -1316,7 +1321,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 
 	case PCI_HEADER_TYPE_BRIDGE:
 		pci_bridge_check_ranges(bus);
-		if (bus->self->is_hotplug_bridge) {
+		if (bus->self->is_hotplug_bridge && pci_hotplug_expand) {
 			additional_io_size  = pci_hotplug_io_size;
 			additional_mmio_size = pci_hotplug_mmio_size;
 			additional_mmio_pref_size = pci_hotplug_mmio_pref_size;
-- 
2.24.1

