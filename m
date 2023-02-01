Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314A6685E7D
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 05:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBAEbT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 23:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjBAEbP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 23:31:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E121564B1
        for <linux-pci@vger.kernel.org>; Tue, 31 Jan 2023 20:31:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E75360E26
        for <linux-pci@vger.kernel.org>; Wed,  1 Feb 2023 04:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6F5C433D2;
        Wed,  1 Feb 2023 04:31:09 +0000 (UTC)
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
Subject: [PATCH V4 1/2] PCI: Omit pci_disable_device() in .shutdown()
Date:   Wed,  1 Feb 2023 12:30:17 +0800
Message-Id: <20230201043018.778499-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230201043018.778499-1-chenhuacai@loongson.cn>
References: <20230201043018.778499-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch has a long story.

After cc27b735ad3a7557 ("PCI/portdrv: Turn off PCIe services during
shutdown") we observe poweroff/reboot failures on systems with LS7A
chipset.

We found that if we remove "pci_command &= ~PCI_COMMAND_MASTER" in
do_pci_disable_device(), it can work well. The hardware engineer says
that the root cause is that CPU is still accessing PCIe devices while
poweroff/reboot, and if we disable the Bus Master Bit at this time, the
PCIe controller doesn't forward requests to downstream devices, and also
does not send TIMEOUT to CPU, which causes CPU wait forever (hardware
deadlock).

To be clear, the sequence is like this:

  - CPU issues MMIO read to device below Root Port

  - LS7A Root Port fails to forward transaction to secondary bus
    because of LS7A Bus Master defect

  - CPU hangs waiting for response to MMIO read

Then how is userspace able to use a device after the device is removed?

To give more details, let's take the graphics driver (e.g. amdgpu) as
an example. The userspace programs call printf() to display "shutting
down xxx service" during shutdown/reboot, or the kernel calls printk()
to display something during shutdown/reboot. These can happen at any
time, even after we call pcie_port_device_remove() to disable the pcie
port on the graphic card.

The call stack is: printk() --> call_console_drivers() --> con->write()
--> vt_console_print() --> fbcon_putcs()

This scenario happens because userspace programs (or the kernel itself)
don't know whether a device is 'usable', they just use it, at any time.

This hardware behavior is a PCIe protocol violation (Bus Master should
not be involved in CPU MMIO transactions), and it will be fixed in new
revisions of hardware (add timeout mechanism for CPU read request,
whether or not Bus Master bit is cleared).

On some x86 platforms, radeon/amdgpu devices can cause similar problems
[1][2].

Once before I add a quirk to solve the LS7A problem but looks ugly.
After long time discussions, Bjorn Helgaas suggest simply remove the
pci_disable_device() in pcie_portdrv_shutdown() and this patch do it
exactly.

[1] https://bugs.freedesktop.org/show_bug.cgi?id=97980
[2] https://bugs.freedesktop.org/show_bug.cgi?id=98638

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/pcie/portdrv.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 2cc2e60bcb39..46fad0d813b2 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -501,7 +501,6 @@ static void pcie_port_device_remove(struct pci_dev *dev)
 {
 	device_for_each_child(&dev->dev, NULL, remove_iter);
 	pci_free_irq_vectors(dev);
-	pci_disable_device(dev);
 }
 
 /**
@@ -727,6 +726,19 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 	}
 
 	pcie_port_device_remove(dev);
+
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
@@ -777,7 +789,7 @@ static struct pci_driver pcie_portdriver = {
 
 	.probe		= pcie_portdrv_probe,
 	.remove		= pcie_portdrv_remove,
-	.shutdown	= pcie_portdrv_remove,
+	.shutdown	= pcie_portdrv_shutdown,
 
 	.err_handler	= &pcie_portdrv_err_handler,
 
-- 
2.39.0

