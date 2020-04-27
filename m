Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35EB1BAC6F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 20:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgD0SYT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 14:24:19 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:53000 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbgD0SYT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 14:24:19 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 778134C855;
        Mon, 27 Apr 2020 18:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1588011855; x=1589826256; bh=zXK6593vRwJaMb5TJmwihGWxT6oOmCZd4hU
        6lDP62T0=; b=p8DoLrcOnz5GcaVkU0VvDcFP0OCaD/EzH75mBaFqjQpixmp+rSw
        EYITbZoheyyYoVF22Pz5bEbL/W0LuZNUUhkTnINxddivOhT+7i67G7OSaL1TStnF
        P75GSiz9Jc9QJRmxdnAnsR5b2MDoYL9GuZD5bfsGRcHWlNmxfKW9YB1Q=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5UKEFRFezleC; Mon, 27 Apr 2020 21:24:15 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id A7CF74C83D;
        Mon, 27 Apr 2020 21:24:11 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 27
 Apr 2020 21:24:11 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v8 06/24] PCI: hotplug: Recalculate every bridge window during rescan
Date:   Mon, 27 Apr 2020 21:23:40 +0300
Message-ID: <20200427182358.2067702-7-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
References: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
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
release all bridge windows and recalculate them from scratch, taking into
account all kinds of BARs: fixed, movable, new.

Comparing to simply trying to expand bridge windows, this also employs the
PCI ability to shuffle BARs within a bridge, increasing the chances to find
a memory space to fit BARs of newly hot-added devices, especially if no (or
not enough) gaps were reserved by the BIOS/bootloader/firmware.

The last step of writing the recalculated windows to the bridges is done by
the new pci_setup_bridges() function.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.h       |  1 +
 drivers/pci/probe.c     | 22 ++++++++++++++++++++++
 drivers/pci/setup-bus.c |  9 +++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 25e49c5b998b..c7d3c022bf35 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -286,6 +286,7 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 				struct list_head *realloc_head,
 				struct list_head *fail_head);
 bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
+void pci_bus_release_root_bridge_resources(struct pci_bus *bus);
 
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
 void pci_disable_bridge_window(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1ac08b64ce83..5baad5325b16 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3250,6 +3250,25 @@ static void pci_bus_rescan_done(struct pci_bus *bus)
 	}
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
@@ -3271,8 +3290,11 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
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
index ffa81949a75f..00bdbc0ea817 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1663,6 +1663,15 @@ static void pci_bus_release_bridge_resources(struct pci_bus *bus,
 		pci_bridge_release_resources(bus, type);
 }
 
+void pci_bus_release_root_bridge_resources(struct pci_bus *root_bus)
+{
+	pci_bus_release_bridge_resources(root_bus, IORESOURCE_IO, whole_subtree);
+	pci_bus_release_bridge_resources(root_bus, IORESOURCE_MEM, whole_subtree);
+	pci_bus_release_bridge_resources(root_bus,
+					 IORESOURCE_MEM_64 | IORESOURCE_PREFETCH,
+					 whole_subtree);
+}
+
 static void pci_bus_dump_res(struct pci_bus *bus)
 {
 	struct resource *res;
-- 
2.24.1

