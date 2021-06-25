Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD303B4088
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 11:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFYJdG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 05:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230461AbhFYJdF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jun 2021 05:33:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1335961409;
        Fri, 25 Jun 2021 09:30:42 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Sinan Kaya <okaya@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH V3 1/4] PCI/portdrv: Don't disable device during shutdown
Date:   Fri, 25 Jun 2021 17:30:27 +0800
Message-Id: <20210625093030.3698570-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210625093030.3698570-1-chenhuacai@loongson.cn>
References: <20210625093030.3698570-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use separate remove()/shutdown() callback, and don't disable PCI device
during shutdown. This can avoid some poweroff/reboot failures.

The poweroff/reboot failures could easily be reproduced on Loongson
platforms. I think this is not a Loongson-specific problem, instead, is
a problem related to some specific PCI hosts. On some x86 platforms,
radeon/amdgpu devices can cause the same problem [1][2], and commit
faefba95c9e8ca3a ("drm/amdgpu: just suspend the hw on pci shutdown")
can resolve it.

As Tiezhu said, this occasionally shutdown or reboot failure is due to
clear PCI_COMMAND_MASTER on the device in do_pci_disable_device() [3].

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
shutdown or reboot. The root cause on Loongson platform is that CPU is
still writing data to framebuffer while poweroff/reboot, and if we clear
Bus Master Bit at this time, CPU will wait ack from device, but never
return, so a hardware deadlock happens.

Radeon driver is more difficult than amdgpu due to its confusing symbol
names, and I have maintained an out-of-tree patch for a long time [4].
Recently, we found more and more devices can cause the same problem, and
it is very difficult to modify all problematic drivers as radeon/amdgpu
does (the .shutdown callback should make sure there is no DMA activity).
So, I think modify the PCIe port driver is a simple and effective way.
Because there is no poweroff/reboot problems before cc27b735ad3a75574a6a
("PCI/portdrv: Turn off PCIe services during shutdown"). And as early
discussed, kexec can still work fine after this patch [5].

[1] https://bugs.freedesktop.org/show_bug.cgi?id=97980
[2] https://bugs.freedesktop.org/show_bug.cgi?id=98638
[3] https://lore.kernel.org/patchwork/patch/1305067/
[4] https://github.com/chenhuacai/linux/commit/8da06f9b669831829416a3e9f4d1c57f217a42f0
[5] http://patchwork.ozlabs.org/project/linux-pci/patch/1600680138-10949-1-git-send-email-chenhc@lemote.com/

Cc: Sinan Kaya <okaya@kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/pci/pcie/portdrv.h      |  2 +-
 drivers/pci/pcie/portdrv_core.c |  6 ++++--
 drivers/pci/pcie/portdrv_pci.c  | 15 +++++++++++++--
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 2ff5724b8f13..358d7281f6e8 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -117,7 +117,7 @@ int pcie_port_device_resume(struct device *dev);
 int pcie_port_device_runtime_suspend(struct device *dev);
 int pcie_port_device_runtime_resume(struct device *dev);
 #endif
-void pcie_port_device_remove(struct pci_dev *dev);
+void pcie_port_device_remove(struct pci_dev *dev, bool disable);
 int __must_check pcie_port_bus_register(void);
 void pcie_port_bus_unregister(void);
 
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e1fed6649c41..98c0a99a41d6 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -484,11 +484,13 @@ EXPORT_SYMBOL_GPL(pcie_port_find_device);
  * Remove PCI Express port service devices associated with given port and
  * disable MSI-X or MSI for the port.
  */
-void pcie_port_device_remove(struct pci_dev *dev)
+void pcie_port_device_remove(struct pci_dev *dev, bool disable)
 {
 	device_for_each_child(&dev->dev, NULL, remove_iter);
 	pci_free_irq_vectors(dev);
-	pci_disable_device(dev);
+
+	if (disable)
+		pci_disable_device(dev);
 }
 
 /**
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index c7ff1eea225a..562fbf3c1ea9 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -147,7 +147,18 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 		pm_runtime_dont_use_autosuspend(&dev->dev);
 	}
 
-	pcie_port_device_remove(dev);
+	pcie_port_device_remove(dev, true);
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
+	pcie_port_device_remove(dev, false);
 }
 
 static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
@@ -219,7 +230,7 @@ static struct pci_driver pcie_portdriver = {
 
 	.probe		= pcie_portdrv_probe,
 	.remove		= pcie_portdrv_remove,
-	.shutdown	= pcie_portdrv_remove,
+	.shutdown	= pcie_portdrv_shutdown,
 
 	.err_handler	= &pcie_portdrv_err_handler,
 
-- 
2.27.0

