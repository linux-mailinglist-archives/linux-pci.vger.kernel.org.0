Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF911C17C1
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 16:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgEAO3E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 10:29:04 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:47048 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729631AbgEAO3D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 May 2020 10:29:03 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 7C74B30C069;
        Fri,  1 May 2020 07:28:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 7C74B30C069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1588343330;
        bh=+NXOKSqvwSz5PojqiSmDVNH1cnmOR0JuUEkzpZ7fLmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ts6yX0DneB1yQTiummj/fR/OJ+Hl7Uzqg6wVXFOUC2CwnyO9TE7aqXX9nWTT/xwvg
         XFnWv409a+XTafECceyR77ZepAVkx9e/xUBE6hkIxWsBBIf9JiHurbjxhoLsBZ5o/v
         Ns7j9acWe+KtROphHwVIkJsGgywg/+zAssu/Hwlo=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 53609140091;
        Fri,  1 May 2020 07:29:00 -0700 (PDT)
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
Subject: [PATCH v2 4/4] PCI: brcmstb: Disable L0s component of ASPM if requested
Date:   Fri,  1 May 2020 10:28:30 -0400
Message-Id: <20200501142831.35174-5-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200501142831.35174-1-james.quinlan@broadcom.com>
References: <20200501142831.35174-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

Some informal internal experiments has shown that the BrcmSTB ASPM L0s
savings may introduce an undesirable noise signal on some customers'
boards.  In addition, L0s was found lacking in realized power savings,
especially relative to the L1 ASPM component.  This is BrcmSTB's
experience and may not hold for others.  At any rate, if the
'aspm-no-l0s' property is present L0s will be disabled.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 5b0dec5971b8..73020b4ff090 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -41,6 +41,9 @@
 #define PCIE_RC_CFG_PRIV1_ID_VAL3			0x043c
 #define  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK	0xffffff
 
+#define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
+#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
+
 #define PCIE_RC_DL_MDIO_ADDR				0x1100
 #define PCIE_RC_DL_MDIO_WR_DATA				0x1104
 #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
@@ -693,7 +696,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	int num_out_wins = 0;
 	u16 nlw, cls, lnksta;
 	int i, ret;
-	u32 tmp;
+	u32 tmp, aspm_support;
 
 	/* Reset the bridge */
 	brcm_pcie_bridge_sw_init_set(pcie, 1);
@@ -803,6 +806,15 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		num_out_wins++;
 	}
 
+	/* Don't advertise L0s capability if 'aspm-no-l0s' */
+	aspm_support = PCIE_LINK_STATE_L1;
+	if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
+		aspm_support |= PCIE_LINK_STATE_L0S;
+	tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
+	u32p_replace_bits(&tmp, aspm_support,
+		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
+	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
+
 	/*
 	 * For config space accesses on the RC, show the right class for
 	 * a PCIe-PCIe bridge (the default setting is to be EP mode).
-- 
2.17.1

