Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3AF41745F8
	for <lists+linux-pci@lfdr.de>; Sat, 29 Feb 2020 10:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgB2JuQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Feb 2020 04:50:16 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726695AbgB2JuQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 29 Feb 2020 04:50:16 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6E8D6451FA588A61E440;
        Sat, 29 Feb 2020 17:50:12 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sat, 29 Feb 2020 17:50:06 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>, <huangdaode@huawei.com>
Subject: [PATCH] PCI: Rename is_probed of struct pci_dev to correctly match its function
Date:   Sat, 29 Feb 2020 17:46:32 +0800
Message-ID: <1582969592-56621-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Member is_probed in struct pci_dev indicates whether a pci device is in a
probing process. Rename it to is_probing to match its function as well as
the comments. Rename pci_physfn_is_probed() to pci_physfn_is_probing()
for the same purpose. No functional change.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/pci-driver.c | 10 +++++-----
 include/linux/pci.h      |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 0454ca0..56179ce 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -320,10 +320,10 @@ static long local_pci_probe(void *_ddi)
 	return 0;
 }
 
-static bool pci_physfn_is_probed(struct pci_dev *dev)
+static bool pci_physfn_is_probing(struct pci_dev *dev)
 {
 #ifdef CONFIG_PCI_IOV
-	return dev->is_virtfn && dev->physfn->is_probed;
+	return dev->is_virtfn && dev->physfn->is_probing;
 #else
 	return false;
 #endif
@@ -341,7 +341,7 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	 * on the right node.
 	 */
 	node = dev_to_node(&dev->dev);
-	dev->is_probed = 1;
+	dev->is_probing = 1;
 
 	cpu_hotplug_disable();
 
@@ -350,7 +350,7 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	 * device is probed from work_on_cpu() of the Physical device.
 	 */
 	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
-	    pci_physfn_is_probed(dev))
+	    pci_physfn_is_probing(dev))
 		cpu = nr_cpu_ids;
 	else
 		cpu = cpumask_any_and(cpumask_of_node(node), cpu_online_mask);
@@ -360,7 +360,7 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	else
 		error = local_pci_probe(&ddi);
 
-	dev->is_probed = 0;
+	dev->is_probing = 0;
 	cpu_hotplug_enable();
 	return error;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3840a54..1c31dd2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -419,7 +419,7 @@ struct pci_dev {
 	unsigned int	io_window_1k:1;		/* Intel bridge 1K I/O windows */
 	unsigned int	irq_managed:1;
 	unsigned int	non_compliant_bars:1;	/* Broken BARs; ignore them */
-	unsigned int	is_probed:1;		/* Device probing in progress */
+	unsigned int	is_probing:1;		/* Device probing in progress */
 	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
 	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
 	pci_dev_flags_t dev_flags;
-- 
2.8.1

