Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE32A4771F1
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 13:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbhLPMg7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Dec 2021 07:36:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39126 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbhLPMg5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Dec 2021 07:36:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8596EB8239A
        for <linux-pci@vger.kernel.org>; Thu, 16 Dec 2021 12:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C33C36AE3;
        Thu, 16 Dec 2021 12:36:53 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V11 5/6] PCI: Add quirk for LS7A to avoid reboot failure
Date:   Thu, 16 Dec 2021 20:31:53 +0800
Message-Id: <20211216123154.631895-6-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211216123154.631895-1-chenhuacai@loongson.cn>
References: <20211216123154.631895-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit cc27b735ad3a75574a ("PCI/portdrv: Turn off PCIe services during
shutdown") causes poweroff/reboot failure on systems with LS7A chipset.
We found that if we remove "pci_command &= ~PCI_COMMAND_MASTER;" in
do_pci_disable_device(), it can work well. The hardware engineer says
that the root cause is that CPU is still accessing PCIe devices while
poweroff/reboot, and if we disable the Bus Master Bit at this time, the
PCIe controller doesn't forward requests to downstream devices, and also
doesn't send TIMEOUT to CPU, which causes CPU wait forever (hardware
deadlock). This behavior is a PCIe protocol violation (Bus Master should
not be involved in CPU MMIO transactions), and it will be fixed in new
revisions of hardware (add timeout mechanism for CPU read request,
whether or not Bus Master bit is cleared).

On some x86 platforms, radeon/amdgpu devices can cause similar problems
[1][2]. Once before I wanted to make a single patch to solve "all of
these problems" together, but it seems unreasonable because maybe they
are not exactly the same problem. So, this patch just add a quirk for
LS7A to avoid clearing Bus Master bit in pcie_port_device_remove(), and
leave other platforms as is.

[1] https://bugs.freedesktop.org/show_bug.cgi?id=97980
[2] https://bugs.freedesktop.org/show_bug.cgi?id=98638

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/controller/pci-loongson.c | 20 ++++++++++++++++++++
 drivers/pci/pcie/portdrv_core.c       |  6 +++++-
 include/linux/pci.h                   |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 24463ad81bf7..5780b5db3dc1 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -88,6 +88,26 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_PCIE_PORT_2, loongson_mrrs_quirk);
 
+static void loongson_bmaster_quirk(struct pci_dev *pdev)
+{
+	/*
+	 * Some Loongson PCIe ports will cause CPU deadlock if disable
+	 * the Bus Master bit during poweroff/reboot.
+	 */
+	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
+
+	if (!bridge)
+		return;
+
+	bridge->no_dis_bmaster = 1;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_0, loongson_bmaster_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_1, loongson_bmaster_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_2, loongson_bmaster_quirk);
+
 static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
 {
 	struct pci_config_window *cfg;
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index bda630889f95..29294f6c885a 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -504,9 +504,13 @@ EXPORT_SYMBOL_GPL(pcie_port_find_device);
  */
 void pcie_port_device_remove(struct pci_dev *dev)
 {
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+
 	device_for_each_child(&dev->dev, NULL, remove_iter);
 	pci_free_irq_vectors(dev);
-	pci_disable_device(dev);
+
+	if (!bridge->no_dis_bmaster)
+		pci_disable_device(dev);
 }
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a2c33bacbf58..3831d11cb7da 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -558,6 +558,7 @@ struct pci_host_bridge {
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */
 	unsigned int	no_inc_mrrs:1;		/* No Increase MRRS */
+	unsigned int	no_dis_bmaster:1;	/* No Disable Bus Master */
 	unsigned int	native_aer:1;		/* OS may use PCIe AER */
 	unsigned int	native_pcie_hotplug:1;	/* OS may use PCIe hotplug */
 	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
-- 
2.27.0

