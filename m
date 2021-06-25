Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C923B4091
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 11:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhFYJeF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 05:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230523AbhFYJeE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jun 2021 05:34:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92CAD61427;
        Fri, 25 Jun 2021 09:31:42 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V3 3/4] PCI: Improve the MRRS quirk for LS7A
Date:   Fri, 25 Jun 2021 17:30:29 +0800
Message-Id: <20210625093030.3698570-4-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210625093030.3698570-1-chenhuacai@loongson.cn>
References: <20210625093030.3698570-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In new revision of LS7A, some PCIe ports support larger value than 256,
but their maximum supported MRRS values are not detectable. Moreover,
the current loongson_mrrs_quirk() cannot avoid devices increasing its
MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
will actually set a big value in its driver. So the only possible way is
configure MRRS of all devices in BIOS, and add a PCI device flag (i.e.,
PCI_DEV_FLAGS_NO_INCREASE_MRRS) to stop the increasing MRRS operations.

However, according to PCIe Spec, it is legal for an OS to program any
value for MRRS, and it is also legal for an endpoint to generate a Read
Request with any size up to its MRRS. As the hardware engineers says,
the root cause here is LS7A doesn't break up large read requests (Yes,
that is a problem in the LS7A design).

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/pci.c    | 5 +++++
 drivers/pci/quirks.c | 8 +++++++-
 include/linux/pci.h  | 2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

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
index dee4798a49fc..8284480dc7e4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -263,7 +263,13 @@ static void loongson_mrrs_quirk(struct pci_dev *dev)
 		 * anything larger than this. So force this limit on
 		 * any devices attached under these ports.
 		 */
-		if (pci_match_id(bridge_devids, bridge)) {
+		if (bridge && pci_match_id(bridge_devids, bridge)) {
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
index 24306504226a..5e0ec3e4318b 100644
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

