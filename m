Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0779A4552AA
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 03:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242522AbhKRCYs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 21:24:48 -0500
Received: from inva021.nxp.com ([92.121.34.21]:46336 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242509AbhKRCYp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Nov 2021 21:24:45 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E550020228A;
        Thu, 18 Nov 2021 03:21:42 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AAD1D2031AC;
        Thu, 18 Nov 2021 03:21:42 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AD112183AD05;
        Thu, 18 Nov 2021 10:21:40 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, galak@kernel.crashing.org, shawnguo@kernel.org
Cc:     hongxing.zhu@nxp.com, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v6 3/8] dt-bindings: imx6q-pcie: Add PHY phandles and name properties
Date:   Thu, 18 Nov 2021 09:54:44 +0800
Message-Id: <1637200489-11855-4-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637200489-11855-1-git-send-email-hongxing.zhu@nxp.com>
References: <1637200489-11855-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

i.MX8MM PCIe has the PHY. Add a PHY phandle and name properties
in the binding document.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Tim Harvey <tharvey@gateworks.com>
Tested-by: Tim Harvey <tharvey@gateworks.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index acea1cd444fd..643a6333b07b 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -127,6 +127,12 @@ properties:
     enum: [1, 2, 3, 4]
     default: 1
 
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: pcie-phy
+
   reset-gpio:
     description: Should specify the GPIO for controlling the PCI bus device
       reset signal. It's not polarity aware and defaults to active-low reset
-- 
2.25.1

