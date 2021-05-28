Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80BC393D95
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 09:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhE1HSA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 03:18:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235341AbhE1HR7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 May 2021 03:17:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9537B61184;
        Fri, 28 May 2021 07:15:43 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 4/4] PCI: Add quirk for multifunction devices of LS7A
Date:   Fri, 28 May 2021 15:15:03 +0800
Message-Id: <20210528071503.1444680-5-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528071503.1444680-1-chenhuacai@loongson.cn>
References: <20210528071503.1444680-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jianmin Lv <lvjianmin@loongson.cn>

In LS7A, multifunction device use same PCI PIN (because the PIN register
report the same INTx value to each function) but we need different IRQ
for different functions, so add a quirk to fix it for standard PCI PIN
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
@@ -242,6 +242,14 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_LS7A_LPC, loongson_system_bus_quirk);
 
+static void loongson_pci_pin_quirk(struct pci_dev *dev)
+{
+	dev->pin = 1 + (PCI_FUNC(dev->devfn) & 3);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_0, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_1, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_PCIE_PORT_2, loongson_pci_pin_quirk);
+
 static void loongson_mrrs_quirk(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
-- 
2.27.0

