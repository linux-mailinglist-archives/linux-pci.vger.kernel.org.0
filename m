Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C37DE3975
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408021AbfJXRMq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:12:46 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:48802 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409968AbfJXRMq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:12:46 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 47FE543E0C;
        Thu, 24 Oct 2019 17:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1571937163; x=1573751564; bh=HZgKRN6tOARhBhsn62fHxtGaNd6lFwfoMrp
        mmOp4nHk=; b=JufeTIOh4c1paPuUJzwoxcjqL4K+SaQHIDLSG6cdHDq2FJOPBw/
        PU04gXr+syBke6E5pte7aHrew35gmJ7954CCFu2CriOXcT6hNCIYvZL/T03NibvM
        9t3H/1tUeszIZKjl3YjkEz/y1xeiWJ1N/HAr5MXKQCrpgZQfldMFcWPc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ocSxCEQygCjp; Thu, 24 Oct 2019 20:12:43 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 1F8DB437F6;
        Thu, 24 Oct 2019 20:12:41 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Oct 2019 20:12:39 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v6 06/30] PCI: hotplug: movable BARs: Recalculate all bridge windows during rescan
Date:   Thu, 24 Oct 2019 20:12:04 +0300
Message-ID: <20191024171228.877974-7-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024171228.877974-1-s.miroshnichenko@yadro.com>
References: <20191024171228.877974-1-s.miroshnichenko@yadro.com>
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
index 19bc50597d12..4a3f2b69285b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -280,6 +280,7 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 				struct list_head *realloc_head,
 				struct list_head *fail_head);
 bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
+void pci_bus_release_root_bridge_resources(struct pci_bus *bus);
 
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
 void pci_disable_bridge_window(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3d8c0f653378..d2dbec51c4df 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3200,6 +3200,25 @@ static void pci_bus_rescan_done(struct pci_bus *bus)
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
@@ -3221,8 +3240,11 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
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
index f2f02e6c9000..075e8185b936 100644
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
2.23.0

