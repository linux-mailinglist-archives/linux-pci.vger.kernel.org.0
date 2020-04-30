Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0935B1C0582
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 21:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgD3TA4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 15:00:56 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:56066 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726346AbgD3TAx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 15:00:53 -0400
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Apr 2020 15:00:52 EDT
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 67CBD30C0C7;
        Thu, 30 Apr 2020 11:55:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 67CBD30C0C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1588272931;
        bh=CCuZ5sgSNCjCfw59P5WerFNtMeSC3recQoakjLMrWEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=slgm+6f+5wLO+mcNnTAIGmgDbnnPEPI3PL5el1hU5F8aHaMkWZ3TpacglHsYToRrL
         oObmoc9tRxXM1KsN+X3xY2E5FrRsocrcVk0goZExKpdzv+aathwvujHmwDlFc0Eefh
         /vjhqv7ExtsSmDDiSjpXwT+dhqMk/QvUmXFM2RRM=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 0BF9E14008B;
        Thu, 30 Apr 2020 11:55:37 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     james.quinlan@broadcom.com
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND
        ENDPOINT DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/5] PCI: brcmstb: enable CRS
Date:   Thu, 30 Apr 2020 14:55:20 -0400
Message-Id: <20200430185522.4116-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430185522.4116-1-james.quinlan@broadcom.com>
References: <20200430185522.4116-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

Configuration Retry Request Status is off by default on this
PCIe controller.  Turn it on.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 5b0dec5971b8..2bc913c0262c 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -34,6 +34,9 @@
 #define BRCM_PCIE_CAP_REGS				0x00ac
 
 /* Broadcom STB PCIe Register Offsets */
+#define PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL			0x00c8
+#define  PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL_RC_CRS_EN_MASK	0x10
+
 #define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1				0x0188
 #define  PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK	0xc
 #define  PCIE_RC_CFG_VENDOR_SPCIFIC_REG1_LITTLE_ENDIAN			0x0
@@ -827,6 +830,12 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		 pci_speed_string(pcie_link_speed[cls]), nlw,
 		 ssc_good ? "(SSC)" : "(!SSC)");
 
+	/* Enable configuration request retry (CRS) */
+	tmp = readl(base + PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL);
+	u32p_replace_bits(&tmp, 1,
+			  PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL_RC_CRS_EN_MASK);
+	writel(tmp, base + PCIE_RC_CFG_PCIE_ROOT_CAP_CONTROL);
+
 	/* PCIe->SCB endian mode for BAR */
 	tmp = readl(base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
 	u32p_replace_bits(&tmp, PCIE_RC_CFG_VENDOR_SPCIFIC_REG1_LITTLE_ENDIAN,
-- 
2.17.1

