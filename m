Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376CC34E310
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 10:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhC3IWn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 04:22:43 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39910 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231194AbhC3IW1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Mar 2021 04:22:27 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C827202FF2;
        Tue, 30 Mar 2021 10:22:26 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E8126202FF8;
        Tue, 30 Mar 2021 10:22:20 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B308E402B0;
        Tue, 30 Mar 2021 10:22:14 +0200 (CEST)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [RESEND v4 1/2] dt-bindings: imx6q-pcie: add one regulator used to power up pcie phy
Date:   Tue, 30 Mar 2021 16:08:20 +0800
Message-Id: <1617091701-6444-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617091701-6444-1-git-send-email-hongxing.zhu@nxp.com>
References: <1617091701-6444-1-git-send-email-hongxing.zhu@nxp.com>
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
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index de4b2baf91e8..d8971ab99274 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -38,6 +38,9 @@ Optional properties:
   The regulator will be enabled when initializing the PCIe host and
   disabled either as part of the init process or when shutting down the
   host.
+- vph-supply: Should specify the regulator in charge of VPH one of the three
+  PCIe PHY powers. This regulator can be supplied by both 1.8v and 3.3v voltage
+  supplies.
 
 Additional required properties for imx6sx-pcie:
 - clock names: Must include the following additional entries:
-- 
2.17.1

