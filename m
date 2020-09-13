Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604DF268129
	for <lists+linux-pci@lfdr.de>; Sun, 13 Sep 2020 22:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgIMU30 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Sep 2020 16:29:26 -0400
Received: from mail.loongson.cn ([114.242.206.163]:43988 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbgIMU3Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 13 Sep 2020 16:29:24 -0400
Received: from linux.localdomain (unknown [117.136.50.205])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx78cQgV5fOgYVAA--.4954S2;
        Mon, 14 Sep 2020 04:29:07 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Konstantin Khlebnikov <khlebnikov@openvz.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Lukas Wunner <lukas@wunner.de>, oohall@gmail.com,
        rafael.j.wysocki@intel.com, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2] PCI/portdrv: Only disable Bus Master on kexec reboot and connected PCI devices
Date:   Mon, 14 Sep 2020 04:29:10 +0800
Message-Id: <1600028950-10644-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9Dx78cQgV5fOgYVAA--.4954S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1fKFyxGFyUCF4xKF4xXrb_yoWrGw43pF
        WDGFZayrWFqFy2gw43ZFyxZa45JanFy348tryxG343Wr4fAFy8trWftF90va4kXrZYvFy7
        JFZxt348GFWUJF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
        4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
        XdbUUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After commit 745be2e700cd ("PCIe: portdrv: call pci_disable_device
during remove") and commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe
services during shutdown"), it also calls pci_disable_device() during
shutdown, this leads to shutdown or reboot failure occasionally due to
clear PCI_COMMAND_MASTER on the device in do_pci_disable_device().

drivers/pci/pci.c
static void do_pci_disable_device(struct pci_dev *dev)
{
        u16 pci_command;

        pci_read_config_word(dev, PCI_COMMAND, &pci_command);
        if (pci_command & PCI_COMMAND_MASTER) {
                pci_command &= ~PCI_COMMAND_MASTER;
                pci_write_config_word(dev, PCI_COMMAND, pci_command);
        }

        pcibios_disable_device(dev);
}

When remove "pci_command &= ~PCI_COMMAND_MASTER;", it can work well.

As Oliver O'Halloran said, no need to call pci_disable_device() when
actually shutting down, but we should call pci_disable_device() before
handing over to the new kernel on kexec reboot, so we can do some
condition checks which are similar with pci_device_shutdown(), this is
done by commit 4fc9bbf98fd6 ("PCI: Disable Bus Master only on kexec
reboot") and commit 6e0eda3c3898 ("PCI: Don't try to disable Bus Master
on disconnected PCI devices").

drivers/pci/pci-driver.c
static void pci_device_shutdown(struct device *dev)
{
...

        /*
         * If this is a kexec reboot, turn off Bus Master bit on the
         * device to tell it to not continue to do DMA. Don't touch
         * devices in D3cold or unknown states.
         * If it is not a kexec reboot, firmware will hit the PCI
         * devices with big hammer and stop their DMA any way.
         */
        if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
                pci_clear_master(pci_dev);
}

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/pci/pcie/portdrv_core.c |  1 -
 drivers/pci/pcie/portdrv_pci.c  | 25 ++++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

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
index 3a3ce40..ce89a9e8 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/aer.h>
 #include <linux/dmi.h>
+#include <linux/kexec.h>
 
 #include "../pci.h"
 #include "portdrv.h"
@@ -143,6 +144,28 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
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
+
+	/*
+	 * If this is a kexec reboot, turn off Bus Master bit on the
+	 * device to tell it to not continue to do DMA. Don't touch
+	 * devices in D3cold or unknown states.
+	 * If it is not a kexec reboot, firmware will hit the PCI
+	 * devices with big hammer and stop their DMA any way.
+	 */
+	if (kexec_in_progress && (dev->current_state <= PCI_D3hot))
+		pci_disable_device(dev);
 }
 
 static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
@@ -211,7 +234,7 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
 
 	.probe		= pcie_portdrv_probe,
 	.remove		= pcie_portdrv_remove,
-	.shutdown	= pcie_portdrv_remove,
+	.shutdown	= pcie_portdrv_shutdown,
 
 	.err_handler	= &pcie_portdrv_err_handler,
 
-- 
1.8.3.1

