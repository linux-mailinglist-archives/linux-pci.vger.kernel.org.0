Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0789A14CD59
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgA2P35 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:29:57 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55796 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726940AbgA2P34 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:29:56 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id B019A47622;
        Wed, 29 Jan 2020 15:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311794; x=1582126195; bh=a8caSKjaHcX9suJCtM2242IUOCtyhj9Wz3o
        39yZG1+A=; b=TQJMJBsRQd5XgIpbAAmgnA6V4BvhHFlKSQ5IDecmTUq0V8zE63H
        NfmP/j2PSM8L/xBANq59JGY4RTI/wHcjeKGW1DDW2hIMtnYG46EoYoqhYqSUXG2r
        Nr1NCNbXVtKndxqwNU/8JWozVrZhhZhbmr/CKeyHZlK61vm6+CZsMv7M=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YTdlROFsgnqe; Wed, 29 Jan 2020 18:29:54 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 13BC047608;
        Wed, 29 Jan 2020 18:29:52 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jan 2020 18:29:51 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Roese <sr@denx.de>,
        <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v7 06/26] PCI: hotplug: Recalculate every bridge window during rescan
Date:   Wed, 29 Jan 2020 18:29:17 +0300
Message-ID: <20200129152937.311162-7-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
References: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the movable BARs feature is enabled and a rescan has been requested,
release all the bridge windows and recalculate them from scratch, taking
into account all kinds for BARs: immovable+fixed, movable, new.

Comparing to simply trying to expand bridge windows, this also employs the
PCI ability to shuffle BARs within a bridge, increasing the chances to find
a memory space to fit BARs for newly hotplugged devices, especially if no
(not enough) gaps were reserved by the BIOS/bootloader/firmware.

The last step of writing the recalculated windows to the bridges is done
by the new pci_setup_bridges() function.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.h       |  1 +
 drivers/pci/probe.c     | 22 ++++++++++++++++++++++
 drivers/pci/setup-bus.c | 16 ++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ce8c53ca7a1e..fe995993b481 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -283,6 +283,7 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 				struct list_head *realloc_head,
 				struct list_head *fail_head);
 bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
+void pci_bus_release_root_bridge_resources(struct pci_bus *bus);
 
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
 void pci_disable_bridge_window(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9b6d15587f5d..daaaebdfd4c4 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3190,6 +3190,25 @@ static void pci_bus_rescan_done(struct pci_bus *bus)
 		pci_config_pm_runtime_put(bus->self);
 }
 
+static void pci_setup_bridges(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *child;
+
+		if (!pci_dev_is_added(dev))
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
@@ -3211,8 +3230,11 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
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
index 2cf07003d5fc..7a9bf979908d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1654,6 +1654,22 @@ static void pci_bus_release_bridge_resources(struct pci_bus *bus,
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
2.24.1

