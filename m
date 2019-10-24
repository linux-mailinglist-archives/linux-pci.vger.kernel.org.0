Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA48E3986
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439949AbfJXRMz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:12:55 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:48808 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436722AbfJXRMz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:12:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id A7F04437FA;
        Thu, 24 Oct 2019 17:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1571937173; x=1573751574; bh=ya0D1NvqP3VkEc07oDTPqDYb0LTTnM15hzZ
        ylBEZsAk=; b=meqQK560YlC9XXFWv+fYtrLniqqpbvTB6pKOW7WM3qiKUchzQsV
        UOaBWGG5OgO93gzOb+/z49ZFBQX8mz/+p4FFA4Hj2Cl5wVw5iMW5w54EA19FcP8K
        ypoupb2/6NnbHV6I3VCaIu7wqBK2hE41LhvquPGmb/CUaUpHJbaBNJO4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OMihRmz64bwt; Thu, 24 Oct 2019 20:12:53 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id EFC6443E08;
        Thu, 24 Oct 2019 20:12:43 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Oct 2019 20:12:43 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Sam Bobroff <sbobroff@linux.ibm.com>
Subject: [PATCH v6 23/30] powerpc/pci: hotplug: Add support for movable BARs
Date:   Thu, 24 Oct 2019 20:12:21 +0300
Message-ID: <20191024171228.877974-24-s.miroshnichenko@yadro.com>
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

Add pcibios_root_bus_rescan_prepare()/_done() hooks for the powerpc, so it
can reassign the PE numbers (which depend on BAR sizes and locations) and
update the EEH address cache during a PCI rescan.

New PE numbers are assigned during pci_setup_bridges(root) after the rescan
is done.

CC: Oliver O'Halloran <oohall@gmail.com>
CC: Sam Bobroff <sbobroff@linux.ibm.com>
Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/kernel/pci-hotplug.c | 43 +++++++++++++++++++++++++++++++
 drivers/pci/probe.c               | 10 +++++++
 include/linux/pci.h               |  3 +++
 3 files changed, 56 insertions(+)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index fc62c4bc47b1..42847f5b0f08 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -16,6 +16,7 @@
 #include <asm/ppc-pci.h>
 #include <asm/firmware.h>
 #include <asm/eeh.h>
+#include <asm/iommu.h>
 
 static struct pci_bus *find_bus_among_children(struct pci_bus *bus,
 					       struct device_node *dn)
@@ -151,3 +152,45 @@ void pci_hp_add_devices(struct pci_bus *bus)
 	pcibios_finish_adding_to_bus(bus);
 }
 EXPORT_SYMBOL_GPL(pci_hp_add_devices);
+
+static void pci_hp_bus_rescan_prepare(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *child = dev->subordinate;
+
+		if (child)
+			pci_hp_bus_rescan_prepare(child);
+
+		iommu_del_device(&dev->dev);
+	}
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		pcibios_release_device(dev);
+	}
+}
+
+static void pci_hp_bus_rescan_done(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *child = dev->subordinate;
+
+		pcibios_bus_add_device(dev);
+
+		if (child)
+			pci_hp_bus_rescan_done(child);
+	}
+}
+
+void pcibios_root_bus_rescan_prepare(struct pci_bus *root)
+{
+	pci_hp_bus_rescan_prepare(root);
+}
+
+void pcibios_root_bus_rescan_done(struct pci_bus *root)
+{
+	pci_hp_bus_rescan_done(root);
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 73452aa81417..539f5d39bb6d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3235,6 +3235,14 @@ static void pci_bus_rescan_done(struct pci_bus *bus)
 		pci_config_pm_runtime_put(bus->self);
 }
 
+void __weak pcibios_root_bus_rescan_prepare(struct pci_bus *root)
+{
+}
+
+void __weak pcibios_root_bus_rescan_done(struct pci_bus *root)
+{
+}
+
 static void pci_setup_bridges(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
@@ -3430,6 +3438,7 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 		root = root->parent;
 
 	if (pci_can_move_bars) {
+		pcibios_root_bus_rescan_prepare(root);
 		pci_bus_rescan_prepare(root);
 		pci_bus_update_immovable_range(root);
 		pci_bus_release_root_bridge_resources(root);
@@ -3440,6 +3449,7 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 
 		pci_setup_bridges(root);
 		pci_bus_rescan_done(root);
+		pcibios_root_bus_rescan_done(root);
 	} else {
 		max = pci_scan_child_bus(bus);
 		pci_assign_unassigned_bus_resources(bus);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e1edcb3fad31..b5821134bdae 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1275,6 +1275,9 @@ unsigned int pci_rescan_bus(struct pci_bus *bus);
 void pci_lock_rescan_remove(void);
 void pci_unlock_rescan_remove(void);
 
+void pcibios_root_bus_rescan_prepare(struct pci_bus *root);
+void pcibios_root_bus_rescan_done(struct pci_bus *root);
+
 /* Vital Product Data routines */
 ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
 ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
-- 
2.23.0

