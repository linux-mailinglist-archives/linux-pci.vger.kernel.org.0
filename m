Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FBD65BB49
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 08:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjACHem (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 02:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjACHel (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 02:34:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8606DEDF
        for <linux-pci@vger.kernel.org>; Mon,  2 Jan 2023 23:34:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57668B80E14
        for <linux-pci@vger.kernel.org>; Tue,  3 Jan 2023 07:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C75C433D2;
        Tue,  3 Jan 2023 07:34:35 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 2/2] PCI: Add quirk for LS7A to avoid reboot failure
Date:   Tue,  3 Jan 2023 15:34:01 +0800
Message-Id: <20230103073401.1256736-3-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230103073401.1256736-1-chenhuacai@loongson.cn>
References: <20230103073401.1256736-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

cc27b735ad3a7557 ("PCI/portdrv: Turn off PCIe services during shutdown")
causes poweroff/reboot failure on systems with LS7A chipset. We found
that if we remove "pci_command &= ~PCI_COMMAND_MASTER" in do_pci_disable
_device(), it can work well. The hardware engineer says that the root
cause is that CPU is still accessing PCIe devices while poweroff/reboot,
and if we disable the Bus Master Bit at this time, the PCIe controller
doesn't forward requests to downstream devices, and also does not send
TIMEOUT to CPU, which causes CPU wait forever (hardware deadlock). This
behavior is a PCIe protocol violation (Bus Master should not be involved
in CPU MMIO transactions), and it will be fixed in new revisions of
hardware (add timeout mechanism for CPU read request, whether or not Bus
Master bit is cleared).

On some x86 platforms, radeon/amdgpu devices can cause similar problems
[1][2]. Once before I wanted to make a single patch to solve "all of
these problems" together, but it seems unreasonable because maybe they
are not exactly the same problem. So, this patch add a new function
pcie_portdrv_shutdown(), a slight modified copy of pcie_portdrv_remove()
dedicated for the shutdown path, and then add a quirk just for LS7A to
avoid clearing Bus Master bit in pcie_portdrv_shutdown(). Leave other
platforms behave as before.

[1] https://bugs.freedesktop.org/show_bug.cgi?id=97980
[2] https://bugs.freedesktop.org/show_bug.cgi?id=98638

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/controller/pci-loongson.c | 17 +++++++++++++++++
 drivers/pci/pcie/portdrv.c            | 21 +++++++++++++++++++--
 include/linux/pci.h                   |  1 +
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 759ec211c17b..641308ba4126 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -93,6 +93,23 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
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
+	bridge->no_dis_bmaster = 1;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_0, loongson_bmaster_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_1, loongson_bmaster_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_2, loongson_bmaster_quirk);
+
 static void loongson_pci_pin_quirk(struct pci_dev *pdev)
 {
 	pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 2cc2e60bcb39..96f45c444422 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -501,7 +501,6 @@ static void pcie_port_device_remove(struct pci_dev *dev)
 {
 	device_for_each_child(&dev->dev, NULL, remove_iter);
 	pci_free_irq_vectors(dev);
-	pci_disable_device(dev);
 }
 
 /**
@@ -727,6 +726,24 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 	}
 
 	pcie_port_device_remove(dev);
+
+	pci_disable_device(dev);
+}
+
+static void pcie_portdrv_shutdown(struct pci_dev *dev)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+
+	if (pci_bridge_d3_possible(dev)) {
+		pm_runtime_forbid(&dev->dev);
+		pm_runtime_get_noresume(&dev->dev);
+		pm_runtime_dont_use_autosuspend(&dev->dev);
+	}
+
+	pcie_port_device_remove(dev);
+
+	if (!bridge->no_dis_bmaster)
+		pci_disable_device(dev);
 }
 
 static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
@@ -777,7 +794,7 @@ static struct pci_driver pcie_portdriver = {
 
 	.probe		= pcie_portdrv_probe,
 	.remove		= pcie_portdrv_remove,
-	.shutdown	= pcie_portdrv_remove,
+	.shutdown	= pcie_portdrv_shutdown,
 
 	.err_handler	= &pcie_portdrv_err_handler,
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3df2049ec4a8..a64dbcb89231 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -573,6 +573,7 @@ struct pci_host_bridge {
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
 	unsigned int	no_ext_tags:1;		/* No Extended Tags */
 	unsigned int	no_inc_mrrs:1;		/* No Increase MRRS */
+	unsigned int	no_dis_bmaster:1;	/* No Disable Bus Master */
 	unsigned int	native_aer:1;		/* OS may use PCIe AER */
 	unsigned int	native_pcie_hotplug:1;	/* OS may use PCIe hotplug */
 	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
-- 
2.31.1

