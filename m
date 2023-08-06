Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D89E7713A7
	for <lists+linux-pci@lfdr.de>; Sun,  6 Aug 2023 06:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjHFEvc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Aug 2023 00:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHFEvb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Aug 2023 00:51:31 -0400
X-Greylist: delayed 396 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Aug 2023 21:51:29 PDT
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580321FDE
        for <linux-pci@vger.kernel.org>; Sat,  5 Aug 2023 21:51:29 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id BEBD3101E6AF3;
        Sun,  6 Aug 2023 06:44:50 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 6E611600586A;
        Sun,  6 Aug 2023 06:44:50 +0200 (CEST)
X-Mailbox-Line: From 385baf9dbfb6b65112803998dfc0cd6f84a5e6ba Mon Sep 17 00:00:00 2001
Message-Id: <385baf9dbfb6b65112803998dfc0cd6f84a5e6ba.1691296765.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 06 Aug 2023 06:44:50 +0200
Subject: [PATCH] PCI: brcmstb: Avoid downstream access during link training
To:     Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        Cyril Brulebois <kibi@debian.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Broadcom Set Top Box PCIe controller signals an Asynchronous SError
Interrupt and thus causes a kernel panic when non-posted transactions
time out.  This differs from most other PCIe controllers which return a
fabricated "all ones" response instead.

To avoid gratuitous kernel panics, the driver reads the link status from
a proprietary PCIE_MISC_PCIE_STATUS register and skips downstream
accesses if the link is down.

However the bits in the proprietary register may purport that the link
is up even though link training is still in progress (as indicated by
the Link Training bit in the Link Status register).

This has been observed with various PCIe switches attached to a BCM2711
(Raspberry Pi CM4):  The issue is most pronounced with the Pericom
PI7C9X2G404SV, but has also occasionally been witnessed with the Pericom
PI7C9X2G404SL and ASMedia ASM1184e.

Check the Link Training bit in addition to the PCIE_MISC_PCIE_STATUS
register before performing downstream accesses.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index f593a422bd63..b4abfced8e9b 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -679,8 +679,10 @@ static bool brcm_pcie_link_up(struct brcm_pcie *pcie)
 	u32 val = readl(pcie->base + PCIE_MISC_PCIE_STATUS);
 	u32 dla = FIELD_GET(PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_MASK, val);
 	u32 plu = FIELD_GET(PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK, val);
+	u16 lnksta = readw(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKSTA);
+	u16 lt = FIELD_GET(PCI_EXP_LNKSTA_LT, lnksta);
 
-	return dla && plu;
+	return dla && plu && !lt;
 }
 
 static void __iomem *brcm_pcie_map_bus(struct pci_bus *bus,
-- 
2.39.2

