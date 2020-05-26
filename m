Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0D71E2CE5
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 21:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392378AbgEZTSP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 15:18:15 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:46288 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404316AbgEZTNr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 15:13:47 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id E374030D776;
        Tue, 26 May 2020 12:13:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com E374030D776
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1590520425;
        bh=DqJ1lrPkpo+wwETwincyBoAPTwPAXLpwicYuxaLaS7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aMUmiQRo6EHGBqbE6K3jxjg9XXY+8oBGsC2rf9B6m2zdGmpZW/0Xu3gLD7HDyL+YF
         2cZQ4mvyxbd/g2Mfj17XlhByKISqi11ZdYXVCJR8nwElmyEDVaCd2pWfRGF2PMrW8o
         HUdSdKyGDrytbkbQaCBB8unpYA+G0OuXm2Prp2yg=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 6526E14008D;
        Tue, 26 May 2020 12:13:44 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
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
Subject: [PATCH v2 13/14] PCI: brcmstb: Set bus max burst size by chip type
Date:   Tue, 26 May 2020 15:12:52 -0400
Message-Id: <20200526191303.1492-14-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526191303.1492-1-james.quinlan@broadcom.com>
References: <20200526191303.1492-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

The proper value of the parameter SCB_MAX_BURST_SIZE varies per chip.  The
2711 family requires 128B whereas other devices can employ 512.  The
assignment is complicated by the fact that the values for this two-bit
field have different meanings;

  Value   Type_Generic    Type_7278

     00       Reserved         128B
     01           128B         256B
     10           256B         512B
     11           512B     Reserved

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9930419e3ac2..131cf0a51398 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -53,7 +53,7 @@
 #define  PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK		0x1000
 #define  PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK	0x2000
 #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK	0x300000
-#define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_128		0x0
+
 #define  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK		0xf8000000
 #define  PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK		0x07c00000
 #define  PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK		0x0000001f
@@ -848,7 +848,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	int num_out_wins = 0;
 	u16 nlw, cls, lnksta;
 	int i, ret, memc;
-	u32 tmp, aspm_support;
+	u32 tmp, burst, aspm_support;
 
 	/* Reset the bridge */
 	brcm_pcie_bridge_sw_init_set(pcie, 1);
@@ -864,10 +864,22 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	/* Wait for SerDes to be stable */
 	usleep_range(100, 200);
 
+	/*
+	 * SCB_MAX_BURST_SIZE is a two bit field.  For GENERIC chips it
+	 * is encoded as 0=128, 1=256, 2=512, 3=Rsvd, for BCM7278 it
+	 * is encoded as 0=Rsvd, 1=128, 2=256, 3=512.
+	 */
+	if (pcie->type == BCM2711)
+		burst = 0x0; /* 128B */
+	else if (pcie->type == BCM7278)
+		burst = 0x3; /* 512 bytes */
+	else
+		burst = 0x2; /* 512 bytes */
+
 	/* Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN */
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK);
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK);
-	u32p_replace_bits(&tmp, PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_128,
+	u32p_replace_bits(&tmp, burst,
 			  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK);
 	writel(tmp, base + PCIE_MISC_MISC_CTRL);
 
-- 
2.17.1

