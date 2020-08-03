Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75AD23ADB9
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 21:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgHCTqH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 15:46:07 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:40284 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728640AbgHCTqH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 15:46:07 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 404EB30C15C;
        Mon,  3 Aug 2020 12:44:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 404EB30C15C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1596483879;
        bh=0pbsZJHt8PrYz6kk76ioSuoVr1DDPrLcVoKGojidwig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dr/cHCEmybu9oJWKi8Y5eDK2r5IH+A+ZsemJef25SLQ5w4iPS0GTgKsqrohmru5js
         GGZj5ncPGp28Gcjf3Kt/B/I6zZE7xhuPQolFcGmYz4dFaaNuJ94RRgccd7gsHJLqZA
         4uWfRoDC5q0KX5covHdOku7pw7qXNOwCfLgdMWv4=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 8BAA3140069;
        Mon,  3 Aug 2020 12:46:04 -0700 (PDT)
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
Subject: [PATCH v10 10/11] PCI: brcmstb: Set bus max burst size by chip type
Date:   Mon,  3 Aug 2020 15:45:15 -0400
Message-Id: <20200803194529.32357-11-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200803194529.32357-1-james.quinlan@broadcom.com>
References: <20200803194529.32357-1-james.quinlan@broadcom.com>
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
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 03c771e8b92f..acde92d595e5 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -55,7 +55,7 @@
 #define  PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK		0x1000
 #define  PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK	0x2000
 #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK	0x300000
-#define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_128		0x0
+
 #define  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK		0xf8000000
 #define  PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK		0x07c00000
 #define  PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK		0x0000001f
@@ -847,7 +847,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	int num_out_wins = 0;
 	u16 nlw, cls, lnksta;
 	int i, ret, memc;
-	u32 tmp, aspm_support;
+	u32 tmp, burst, aspm_support;
 
 	/* Reset the bridge */
 	brcm_pcie_bridge_sw_init_set(pcie, 1);
@@ -867,11 +867,22 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
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
-			  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK);
+	u32p_replace_bits(&tmp, burst, PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK);
 	writel(tmp, base + PCIE_MISC_MISC_CTRL);
 
 	ret = brcm_pcie_get_rc_bar2_size_and_offset(pcie, &rc_bar2_size,
-- 
2.17.1

