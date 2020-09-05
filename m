Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F268B25E687
	for <lists+linux-pci@lfdr.de>; Sat,  5 Sep 2020 10:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgIEIdk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Sep 2020 04:33:40 -0400
Received: from mail.loongson.cn ([114.242.206.163]:49066 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbgIEIdk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Sep 2020 04:33:40 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxv99XTVNfeyMRAA--.623S2;
        Sat, 05 Sep 2020 16:33:29 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [RFC PATCH] PCI/portdrv: No need to call pci_disable_device() during shutdown
Date:   Sat,  5 Sep 2020 16:33:26 +0800
Message-Id: <1599294806-13889-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxv99XTVNfeyMRAA--.623S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KryDZr4UJr18Gr1xCryUZFb_yoW8CF47pF
        WUGasIkry0qry7Xr43ta47ZFy5XFnFy3409rWxGw43Wrs7Aa48Ar43JF90vrn5X3ykXFy3
        Gr95JFy8CFWDJF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
        GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjxR65UUUU
        U==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After commit 745be2e700cd ("PCIe: portdrv: call pci_disable_device
during remove") and commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe
services during shutdown"), it also calls pci_disable_device() during
shutdown, this seems unnecessary, so just remove it.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/pci/pcie/portdrv_core.c |  1 -
 drivers/pci/pcie/portdrv_pci.c  | 14 +++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 50a9522..1991aca 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -491,7 +491,6 @@ void pcie_port_device_remove(struct pci_dev *dev)
 {
 	device_for_each_child(&dev->dev, NULL, remove_iter);
 	pci_free_irq_vectors(dev);
-	pci_disable_device(dev);
 }
 
 /**
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 3a3ce40..cab37a8 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -143,6 +143,18 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 	}
 
 	pcie_port_device_remove(dev);
+	pci_disable_device(dev);
+}
+
+static void pcie_portdrv_shutdown(struct pci_dev *dev)
+{
+	if (pci_bridge_d3_possible(dev)) {
+		pm_runtime_forbid(&dev->dev);
+		pm_runtime_get_noresume(&dev->dev);
+		pm_runtime_dont_use_autosuspend(&dev->dev);
+	}
+
+	pcie_port_device_remove(dev);
 }
 
 static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
@@ -211,7 +223,7 @@ static struct pci_driver pcie_portdriver = {
 
 	.probe		= pcie_portdrv_probe,
 	.remove		= pcie_portdrv_remove,
-	.shutdown	= pcie_portdrv_remove,
+	.shutdown	= pcie_portdrv_shutdown,
 
 	.err_handler	= &pcie_portdrv_err_handler,
 
-- 
2.1.0

