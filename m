Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E94379197
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 16:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245475AbhEJO4N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 10:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241889AbhEJOz0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 10:55:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898B7C046857
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 07:15:17 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1lg6gi-0000Fk-Kl; Mon, 10 May 2021 16:15:12 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: [PATCH 6/7] dt-bindings: imx6q-pcie: add compatibles for i.MX8MM PCIe
Date:   Mon, 10 May 2021 16:15:08 +0200
Message-Id: <20210510141509.929120-6-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210510141509.929120-1-l.stach@pengutronix.de>
References: <20210510141509.929120-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::39
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This adds compatibles for both the PCIe host controller and PCIe
PHY found on the i.MX8MM SoC.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 3ebd8553a818..f1f5651031a5 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -10,6 +10,7 @@ Required properties:
 	- "fsl,imx6qp-pcie"
 	- "fsl,imx7d-pcie"
 	- "fsl,imx8mq-pcie"
+	- "fsl,imx8mm-pcie"
 - reg: base address and length of the PCIe controller
 - interrupts: A list of interrupt outputs of the controller. Must contain an
   entry for each entry in the interrupt-names property.
@@ -90,12 +91,13 @@ Example:
 		clock-names = "pcie", "pcie_bus", "pcie_phy";
 	};
 
-* Freescale i.MX7d PCIe PHY
+* Freescale i.MX PCIe PHY
 
-This is the PHY associated with the IMX7d PCIe controller.  It's looked up by
-the PCI-e controller via the fsl,imx7d-pcie-phy compatible.
+This is the PHY associated with the IMX PCIe controller.  It's looked up by
+the PCI-e controller via the compatible.
 
 Required properties:
 - compatible:
 	- "fsl,imx7d-pcie-phy"
+	- "fsl,imx8mm-pcie-phy"
 - reg: base address and length of the PCIe PHY controller
-- 
2.29.2

