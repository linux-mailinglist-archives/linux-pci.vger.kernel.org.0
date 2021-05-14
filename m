Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5AC3804D0
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 10:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbhENIE2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 04:04:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233165AbhENIE1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 May 2021 04:04:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E8906144F;
        Fri, 14 May 2021 08:03:14 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 4/5] PCI: Add quirk for multifunction devices of LS7A
Date:   Fri, 14 May 2021 16:00:24 +0800
Message-Id: <20210514080025.1828197-5-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210514080025.1828197-1-chenhuacai@loongson.cn>
References: <20210514080025.1828197-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jianmin Lv <lvjianmin@loongson.cn>

In LS7A, multifunction device use same pci PIN and different
irq for different function, so fix it for standard pci PIN
usage.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/quirks.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 10b3b2057940..6ab4b3bba36b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -242,6 +242,23 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_LS7A_LPC, loongson_system_bus_quirk);
 
+static void loongson_pci_pin_quirk(struct pci_dev *dev)
+{
+	static const struct pci_device_id devids[] = {
+		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
+		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
+		{ PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
+		{ 0, },
+	};
+
+	if (pci_match_id(devids, dev)) {
+		u8 fun = dev->devfn & 7;
+
+		dev->pin = 1 + (fun & 3);
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_ANY_ID, loongson_pci_pin_quirk);
+
 static void loongson_mrrs_quirk(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
-- 
2.27.0

