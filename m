Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE56434713B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 06:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhCXFsM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 01:48:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56238 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235286AbhCXFsE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Mar 2021 01:48:04 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C063C1A0E97;
        Wed, 24 Mar 2021 06:48:03 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9BAAB1A0A1D;
        Wed, 24 Mar 2021 06:47:58 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0599240307;
        Wed, 24 Mar 2021 06:47:51 +0100 (CET)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2 1/3] dt-bindings: imx6q-pcie: add one regulator used to power up pcie phy
Date:   Wed, 24 Mar 2021 13:34:17 +0800
Message-Id: <1616564059-8713-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616564059-8713-1-git-send-email-hongxing.zhu@nxp.com>
References: <1616564059-8713-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe PHY.
In default, the PCIE_VPH voltage is suggested to be 1.8v refer to data
sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic design,
the VREG_BYPASS bits of GPR registers should be cleared from default
value 1b'1 to 1b'0. Thus, the internal 3v3 to 1v8 translator would be
turned on.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index de4b2baf91e8..3248b7192ced 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -38,6 +38,12 @@ Optional properties:
   The regulator will be enabled when initializing the PCIe host and
   disabled either as part of the init process or when shutting down the
   host.
+- vph-supply: Should specify the regulator in charge of PCIe PHY power.
+  On i.MX8MQ, both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe
+  PHY. In default, the PCIE_VPH voltage is suggested to be 1.8v refer to data
+  sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic design, the
+  VREG_BYPASS bits of GPR registers should be cleared from default value 1b'1
+  to 1b'0.
 
 Additional required properties for imx6sx-pcie:
 - clock names: Must include the following additional entries:
-- 
2.17.1

