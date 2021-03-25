Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3179A348BFC
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 09:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCYI66 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 04:58:58 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56962 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229664AbhCYI6c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Mar 2021 04:58:32 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F0A361A313C;
        Thu, 25 Mar 2021 09:58:30 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DED021A3145;
        Thu, 25 Mar 2021 09:58:25 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6C30C402A2;
        Thu, 25 Mar 2021 09:58:19 +0100 (CET)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 1/3] dt-bindings: imx6q-pcie: add one regulator used to power up pcie phy
Date:   Thu, 25 Mar 2021 16:44:40 +0800
Message-Id: <1616661882-26487-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616661882-26487-1-git-send-email-hongxing.zhu@nxp.com>
References: <1616661882-26487-1-git-send-email-hongxing.zhu@nxp.com>
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
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index de4b2baf91e8..e6d1886144ce 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -38,6 +38,9 @@ Optional properties:
   The regulator will be enabled when initializing the PCIe host and
   disabled either as part of the init process or when shutting down the
   host.
+- vph-supply: Should specify the regulator in charge of VPH one of the three
+  PCIe PHY powers. This regulator can be supplied by both 1.8v and 3.3v voltage
+  supplies. Might be used to distinguish different HW board designs.
 
 Additional required properties for imx6sx-pcie:
 - clock names: Must include the following additional entries:
-- 
2.17.1

