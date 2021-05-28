Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3313D393D94
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 09:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbhE1HRG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 03:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234228AbhE1HRG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 May 2021 03:17:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B9C86100B;
        Fri, 28 May 2021 07:15:30 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 3/4] PCI: Improve the MRRS quirk for LS7A
Date:   Fri, 28 May 2021 15:15:02 +0800
Message-Id: <20210528071503.1444680-4-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528071503.1444680-1-chenhuacai@loongson.cn>
References: <20210528071503.1444680-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In new revision of LS7A, some PCIe ports support larger value than 256,
but their maximum supported MRRS values are not detectable. Moreover,
the current loongson_mrrs_quirk() cannot avoid devices increasing its
MRRS after pci_enable_device(). So the only possible way is configure
MRRS of all devices in BIOS, and add a PCI device flag (PCI_DEV_FLAGS_
NO_INCREASE_MRRS) to stop the increasing MRRS operations.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/pci.c    | 5 +++++
 drivers/pci/quirks.c | 6 ++++++
 include/linux/pci.h  | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b717680377a9..6f0d2f5b6f30 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5802,6 +5802,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 
 	v = (ffs(rq) - 8) << 12;
 
+	if (dev->dev_flags & PCI_DEV_FLAGS_NO_INCREASE_MRRS) {
+		if (rq > pcie_get_readrq(dev))
+			return -EINVAL;
+	}
+
 	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
 						  PCI_EXP_DEVCTL_READRQ, v);
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 66e4bea69431..10b3b2057940 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -264,6 +264,12 @@ static void loongson_mrrs_quirk(struct pci_dev *dev)
 		 * any devices attached under these ports.
 		 */
 		if (pci_match_id(bridge_devids, bridge)) {
+			dev->dev_flags |= PCI_DEV_FLAGS_NO_INCREASE_MRRS;
+
+			if (pcie_bus_config == PCIE_BUS_DEFAULT ||
+			    pcie_bus_config == PCIE_BUS_TUNE_OFF)
+				break;
+
 			if (pcie_get_readrq(dev) > 256) {
 				pci_info(dev, "limiting MRRS to 256\n");
 				pcie_set_readrq(dev, 256);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c20211e59a57..7fb2072a83b8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -227,6 +227,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
 	/* Don't use Relaxed Ordering for TLPs directed at this device */
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
+	/* Don't increase BIOS's MRRS configuration */
+	PCI_DEV_FLAGS_NO_INCREASE_MRRS = (__force pci_dev_flags_t) (1 << 12),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.27.0

