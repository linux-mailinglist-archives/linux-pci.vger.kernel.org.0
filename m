Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AB64771EE
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 13:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbhLPMfd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Dec 2021 07:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236577AbhLPMfc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Dec 2021 07:35:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8898C061574
        for <linux-pci@vger.kernel.org>; Thu, 16 Dec 2021 04:35:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F5FBB823C3
        for <linux-pci@vger.kernel.org>; Thu, 16 Dec 2021 12:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAE5C36AE3;
        Thu, 16 Dec 2021 12:35:27 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V11 3/6] PCI: loongson: Don't access unexisting devices
Date:   Thu, 16 Dec 2021 20:31:51 +0800
Message-Id: <20211216123154.631895-4-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211216123154.631895-1-chenhuacai@loongson.cn>
References: <20211216123154.631895-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On LS2K/LS7A, some unexisting devices don't return 0xffffffff when
scanning. This is a hardware flaw but we can only avoid it by software
now.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/controller/pci-loongson.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 164c0f6e419f..eb069deffc3c 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -138,6 +138,8 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
 			       int where)
 {
 	unsigned char busnum = bus->number;
+	unsigned int device = PCI_SLOT(devfn);
+	unsigned int function = PCI_FUNC(devfn);
 	struct loongson_pci *priv = pci_bus_to_loongson_pci(bus);
 
 	if (pci_is_root_bus(bus))
@@ -147,9 +149,12 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
 	 * Do not read more than one device on the bus other than
 	 * the host bus. For our hardware the root bus is always bus 0.
 	 */
-	if (priv->data->flags & FLAG_DEV_FIX &&
-			busnum != 0 && PCI_SLOT(devfn) > 0)
-		return NULL;
+	if (priv->data->flags & FLAG_DEV_FIX) {
+		if ((busnum != 0) && (device > 0))
+			return NULL;
+		if ((busnum == 0) && (device >= 9 && device <= 20 && function > 0))
+			return NULL;
+	}
 
 	/* CFG0 can only access standard space */
 	if (where < PCI_CFG_SPACE_SIZE && priv->cfg0_base)
-- 
2.27.0

