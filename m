Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84233F1473
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 09:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhHSHlc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 03:41:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236542AbhHSHlb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Aug 2021 03:41:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3FCD61130;
        Thu, 19 Aug 2021 07:40:52 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] PCI: loongson: Use correct pci config access operations
Date:   Thu, 19 Aug 2021 15:40:20 +0800
Message-Id: <20210819074020.3451850-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Huacai Chen <chenhc@lemote.com>

LS2K/LS7A support 8/16/32-bits pci config access operations, so we can
safely use pci_generic_config_read()/pci_generic_config_write() instead
of pci_generic_config_read32()/pci_generic_config_write32().

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 drivers/pci/controller/pci-loongson.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 48169b1e3817..7140bdd04d35 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -159,8 +159,15 @@ static int loongson_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return val;
 }
 
-/* H/w only accept 32-bit PCI operations */
+/* LS2K/LS7A accept 8/16/32-bit PCI operations */
 static struct pci_ops loongson_pci_ops = {
+	.map_bus = pci_loongson_map_bus,
+	.read	= pci_generic_config_read,
+	.write	= pci_generic_config_write,
+};
+
+/* RS780/SR5690 only accept 32-bit PCI operations */
+static struct pci_ops loongson_pci_ops32 = {
 	.map_bus = pci_loongson_map_bus,
 	.read	= pci_generic_config_read32,
 	.write	= pci_generic_config_write32,
@@ -218,8 +225,11 @@ static int loongson_pci_probe(struct platform_device *pdev)
 	}
 
 	bridge->sysdata = priv;
-	bridge->ops = &loongson_pci_ops;
 	bridge->map_irq = loongson_map_irq;
+	if (!of_device_is_compatible(node, "loongson,rs780e-pci"))
+		bridge->ops = &loongson_pci_ops;
+	else
+		bridge->ops = &loongson_pci_ops32;
 
 	return pci_host_probe(bridge);
 }
-- 
2.27.0

