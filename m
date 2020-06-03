Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1B21ED6B0
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 21:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgFCTV1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 15:21:27 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:43002 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726239AbgFCTV0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 15:21:26 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 2EFC430DEC4;
        Wed,  3 Jun 2020 12:21:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 2EFC430DEC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1591212085;
        bh=hcMFng61Xf+UhN2NiPz5gx2U/ueSlTd/rkIbspf5ZRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vChUOUDW0rjkAnV2KeLVICOpi7MpYJCVted/FVz8gRJJaRTOCDYPhc5scAZjsrPNX
         f5P3EDM51xuisIliQ3AO4fRQHF18Q50xvg8uxsjbQJAIq9f6EsZGuYx9beodzblYXh
         Nx8W3gw3jSEBVcRn8koT5s88N5bH7/G7OXGhCmxk=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 8DC11140069;
        Wed,  3 Jun 2020 12:21:23 -0700 (PDT)
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
Subject: [PATCH v3 06/13] PCI: brcmstb: Add bcm7278 PERST support
Date:   Wed,  3 Jun 2020 15:20:38 -0400
Message-Id: <20200603192058.35296-7-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603192058.35296-1-james.quinlan@broadcom.com>
References: <20200603192058.35296-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

The PERST bit was moved to a different register in 7278-type STB chips.  In
addition, the polarity of the bit was also changed; for other chips writing
a 1 specified assert; for 7278-type chips, writing a 0 specifies assert.

Signal-wise, PERST is an asserted-low signal.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index f444751e247c..0bcae9eba048 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -81,6 +81,7 @@
 
 #define PCIE_MISC_PCIE_CTRL				0x4064
 #define  PCIE_MISC_PCIE_CTRL_PCIE_L23_REQUEST_MASK	0x1
+#define PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_MASK		0x4
 
 #define PCIE_MISC_PCIE_STATUS				0x4068
 #define  PCIE_MISC_PCIE_STATUS_PCIE_PORT_MASK		0x80
@@ -686,9 +687,17 @@ static inline void brcm_pcie_perst_set(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp;
 
-	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
-	u32p_replace_bits(&tmp, val, PCIE_RGR1_SW_INIT_1_PERST_MASK);
-	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+	if (pcie->type == BCM7278) {
+		/* Perst bit has moved and assert value is 0 */
+		tmp = readl(pcie->base + PCIE_MISC_PCIE_CTRL);
+		u32p_replace_bits(&tmp,
+				  !val, PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_MASK);
+		writel(tmp, pcie->base +  PCIE_MISC_PCIE_CTRL);
+	} else {
+		tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+		u32p_replace_bits(&tmp, val, PCIE_RGR1_SW_INIT_1_PERST_MASK);
+		writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
+	}
 }
 
 static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
-- 
2.17.1

