Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B264C554C
	for <lists+linux-pci@lfdr.de>; Sat, 26 Feb 2022 11:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiBZKxl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Feb 2022 05:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiBZKxj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Feb 2022 05:53:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7A4E3899
        for <linux-pci@vger.kernel.org>; Sat, 26 Feb 2022 02:53:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3036B80EB8
        for <linux-pci@vger.kernel.org>; Sat, 26 Feb 2022 10:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB66C340E8;
        Sat, 26 Feb 2022 10:52:59 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V12 5/6] PCI: Add quirk for LS7A to avoid reboot failure
Date:   Sat, 26 Feb 2022 18:47:30 +0800
Message-Id: <20220226104731.76776-6-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220226104731.76776-1-chenhuacai@loongson.cn>
References: <20220226104731.76776-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index ba182f9d5718..9f90619c4277 100644
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
index 604feeb84ee4..23f41e31a6c6 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -491,9 +491,13 @@ EXPORT_SYMBOL_GPL(pcie_port_find_device);
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
index 01a464eb640a..843c3977597f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -570,6 +570,7 @@ struct pci_host_bridge {
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */
 	unsigned int	no_inc_mrrs:1;		/* No Increase MRRS */
+	unsigned int	no_dis_bmaster:1;	/* No Disable Bus Master */
 	unsigned int	native_aer:1;		/* OS may use PCIe AER */
 	unsigned int	native_pcie_hotplug:1;	/* OS may use PCIe hotplug */
 	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
-- 
2.27.0

