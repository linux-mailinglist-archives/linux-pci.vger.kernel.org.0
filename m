Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E4925094E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Aug 2020 21:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgHXTav (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Aug 2020 15:30:51 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:43024 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726894AbgHXTau (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Aug 2020 15:30:50 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 36B6C30C0B6;
        Mon, 24 Aug 2020 12:27:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 36B6C30C0B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1598297279;
        bh=hGT+qFRoUyla92DkyYHX4RE1Xjc1YUxnxYWqnDOPcxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ajgv5Sjy6JkUJhLeV73afTT4mZwixaAT4ve7n3YsqB7cRoUcJHQgNM/j9rSaLCHob
         4RSPXNmSAoR+gHgyrw9uVEGGwWTVdUb2dTG4zKA4GQ1CT8NH5sYJ2ze3HVlV5d7aZn
         76/l+s4DNadBDzJsOV9Tr0Tt9ZaaFlzXu5oy9YCk=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id A641A14008F;
        Mon, 24 Aug 2020 12:30:47 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v11 05/11] PCI: brcmstb: Add bcm7278 PERST# support
Date:   Mon, 24 Aug 2020 15:30:18 -0400
Message-Id: <20200824193036.6033-6-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824193036.6033-1-james.quinlan@broadcom.com>
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

The PERST# bit was moved to a different register in 7278-type STB chips.
In addition, the polarity of the bit was also changed; for other chips
writing a 1 specified assert; for 7278-type chips, writing a 0 specifies
assert.

Of course, PERST# is a PCIe asserted-low signal.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 3d588ab7a6dd..acf2239b0251 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -83,6 +83,7 @@
 
 #define PCIE_MISC_PCIE_CTRL				0x4064
 #define  PCIE_MISC_PCIE_CTRL_PCIE_L23_REQUEST_MASK	0x1
+#define PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_MASK		0x4
 
 #define PCIE_MISC_PCIE_STATUS				0x4068
 #define  PCIE_MISC_PCIE_STATUS_PCIE_PORT_MASK		0x80
@@ -684,9 +685,16 @@ static inline void brcm_pcie_perst_set(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp;
 
-	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
-	u32p_replace_bits(&tmp, val, PCIE_RGR1_SW_INIT_1_PERST_MASK);
-	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+	if (pcie->type == BCM7278) {
+		/* Perst bit has moved and assert value is 0 */
+		tmp = readl(pcie->base + PCIE_MISC_PCIE_CTRL);
+		u32p_replace_bits(&tmp, !val, PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_MASK);
+		writel(tmp, pcie->base +  PCIE_MISC_PCIE_CTRL);
+	} else {
+		tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+		u32p_replace_bits(&tmp, val, PCIE_RGR1_SW_INIT_1_PERST_MASK);
+		writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+	}
 }
 
 static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
@@ -771,7 +779,10 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 
 	/* Reset the bridge */
 	brcm_pcie_bridge_sw_init_set(pcie, 1);
-	brcm_pcie_perst_set(pcie, 1);
+
+	/* BCM7278 fails when PERST# is set here */
+	if (pcie->type != BCM7278)
+		brcm_pcie_perst_set(pcie, 1);
 
 	usleep_range(100, 200);
 
-- 
2.17.1

