Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BCA26869F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 09:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgINH5T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 03:57:19 -0400
Received: from mail.loongson.cn ([114.242.206.163]:40826 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbgINH5S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 03:57:18 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz99IIl9fbiUVAA--.4831S2;
        Mon, 14 Sep 2020 15:56:56 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [RFC PATCH v3] PCI/portdrv: Only disable Bus Master on kexec reboot and connected PCI devices
Date:   Mon, 14 Sep 2020 15:56:55 +0800
Message-Id: <1600070215-3901-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxz99IIl9fbiUVAA--.4831S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1fKFyxGFyUCw1kZrykAFb_yoWrXw4rpa
        yUJF9FyrW0qry2gr43tFyUXa45JanFya4IyryxG343ur4xCFy0yrWxtFyavw1DJrZYvFy7
        JayDt3y8GFWUJF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfUYgAwDUUUU
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

When remove "pci_command &= ~PCI_COMMAND_MASTER;", it can work well when
shutdown or reboot.

As Oliver O'Halloran said, no need to call pci_disable_device() when
actually shutting down, but we should call pci_disable_device() before
handing over to the new kernel on kexec reboot, so we can do some
condition checks which are already executed afterwards by the function
pci_device_shutdown(), this is done by commit 4fc9bbf98fd6 ("PCI: Disable
Bus Master only on kexec reboot") and commit 6e0eda3c3898 ("PCI: Don't try
to disable Bus Master on disconnected PCI devices").

drivers/pci/pci-driver.c
static void pci_device_shutdown(struct device *dev)
{
 ...
        if (drv && drv->shutdown)
                drv->shutdown(pci_dev);

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

[   36.159446] Call Trace:
[   36.241688] [<ffffffff80211434>] show_stack+0x9c/0x130
[   36.326619] [<ffffffff80661b70>] dump_stack+0xb0/0xf0
[   36.410403] [<ffffffff806a8240>] pcie_portdrv_shutdown+0x18/0x78
[   36.495302] [<ffffffff8069c6b4>] pci_device_shutdown+0x44/0x90
[   36.580027] [<ffffffff807aac90>] device_shutdown+0x130/0x290
[   36.664486] [<ffffffff80265448>] kernel_power_off+0x38/0x80
[   36.748272] [<ffffffff80265634>] __do_sys_reboot+0x1a4/0x258
[   36.831985] [<ffffffff80218b90>] syscall_common+0x34/0x58

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

