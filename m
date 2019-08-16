Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E70F9061B
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 18:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfHPQvQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 12:51:16 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:51342 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbfHPQvQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 12:51:16 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id C61A342ECB;
        Fri, 16 Aug 2019 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1565974272; x=1567788673; bh=BJFN/GI/KntO7wMlGqrMXAQaRUhb2OOfNPC
        26t3z61E=; b=iAasaNqorP9V0Ny9KkdAJMj5+iAkMBKhWxLykG0pkd2+N8IF/ah
        aUlRQ9CPKk1DXJqU6kCqcOlkOeCI3mhTvgw0GQdQ7cRy4dh2nLihXGZimLmu6QAD
        IhErlwyIM+ifNwgZZGbYkHj18abfEiG8+nP18gIR4mFEI2WEYSu3uxFo=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SaXNuS75WM6f; Fri, 16 Aug 2019 19:51:12 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 9234F42ECD;
        Fri, 16 Aug 2019 19:51:10 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 16
 Aug 2019 19:51:09 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v5 06/23] PCI: hotplug: movable BARs: Recalculate all bridge windows during rescan
Date:   Fri, 16 Aug 2019 19:50:44 +0300
Message-ID: <20190816165101.911-7-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816165101.911-1-s.miroshnichenko@yadro.com>
References: <20190816165101.911-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the movable BARs feature is enabled and a rescan has been requested,
release all the bridge windows and recalculate them from scratch, taking
into account all kinds for BARs: fixed, immovable, movable, new.

This increases the chances to find a memory space to fit BARs for newly
hotplugged devices, especially if no/not enough gaps were reserved by the
BIOS/bootloader/firmware.

The last step of writing the recalculated windows to the bridges is done
by the new pci_setup_bridges() function.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.h       |  1 +
 drivers/pci/probe.c     | 22 ++++++++++++++++++++++
 drivers/pci/setup-bus.c | 16 ++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index be7acc477c64..a0ec696512eb 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -253,6 +253,7 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 				struct list_head *realloc_head,
 				struct list_head *fail_head);
 bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
+void pci_bus_release_root_bridge_resources(struct pci_bus *bus);
 
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
 void pci_disable_bridge_window(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 60e3b48d2251..a26bf740e9ab 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3474,6 +3474,25 @@ static void pci_bus_rescan_done(struct pci_bus *bus)
 		pci_config_pm_runtime_put(bus->self);
 }
 
+static void pci_setup_bridges(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *child;
+
+		if (!pci_dev_is_added(dev) || pci_dev_is_ignored(dev))
+			continue;
+
+		child = dev->subordinate;
+		if (child)
+			pci_setup_bridges(child);
+	}
+
+	if (bus->self)
+		pci_setup_bridge(bus);
+}
+
 /**
  * pci_rescan_bus - Scan a PCI bus for devices
  * @bus: PCI bus to scan
@@ -3495,8 +3514,11 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 		pci_bus_rescan_prepare(root);
 
 		max = pci_scan_child_bus(root);
+
+		pci_bus_release_root_bridge_resources(root);
 		pci_assign_unassigned_root_bus_resources(root);
 
+		pci_setup_bridges(root);
 		pci_bus_rescan_done(root);
 	} else {
 		max = pci_scan_child_bus(bus);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7c2c57f77c6f..04f626e1ac18 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1635,6 +1635,22 @@ static void pci_bus_release_bridge_resources(struct pci_bus *bus,
 		pci_bridge_release_resources(bus, type);
 }
 
+void pci_bus_release_root_bridge_resources(struct pci_bus *root_bus)
+{
+	int i;
+	struct resource *r;
+
+	pci_bus_release_bridge_resources(root_bus, IORESOURCE_IO, whole_subtree);
+	pci_bus_release_bridge_resources(root_bus, IORESOURCE_MEM, whole_subtree);
+	pci_bus_release_bridge_resources(root_bus,
+					 IORESOURCE_MEM_64 | IORESOURCE_PREFETCH,
+					 whole_subtree);
+
+	pci_bus_for_each_resource(root_bus, r, i) {
+		pci_release_child_resources(root_bus, r);
+	}
+}
+
 static void pci_bus_dump_res(struct pci_bus *bus)
 {
 	struct resource *res;
-- 
2.21.0

