Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87DD39B02A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 04:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhFDCHU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 22:07:20 -0400
Received: from inva021.nxp.com ([92.121.34.21]:52330 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhFDCHT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 22:07:19 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 44CCA2039B1;
        Fri,  4 Jun 2021 04:05:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva021.eu-rdc02.nxp.com 44CCA2039B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
        s=nselector4; t=1622772333;
        bh=21r/3Ha2KwM1oZ30mKtfCuC/zWbmRZbOa780Bt3dfZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NqThJn3XTrbT9UaJz7dLR2kT4fegU5LosEuvuXLZ52MgzwEzBbZZFMCz+SrN0dZFE
         Tgsgzt59A8DY9JJG3r93Ri4mdObi5pTuxSp2Ap3ScP8Jd8I7XLWG/ubyvlAXcFaTzI
         4APEgZ07ftvsHU+eYHD8594bPwqhGcVl4cij8wUFErkBdN00bJWFxGzbE3lsej+lEw
         2WcUYha3QbZ3j4i7cWtQFCWu8aGXQI6dfGjN4fZ63l+RnsazEkcqmnz9NCLtOOVhtc
         iejB/lefhIGUKbR2Ifq278o2i11pmq+lfzbZIJidDVwDOxqWYa//iKGLjxU74Az1Ib
         4ItAdg7eDa7og==
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C9E852039B2;
        Fri,  4 Jun 2021 04:05:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva021.eu-rdc02.nxp.com C9E852039B2
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3DEB9402F1;
        Fri,  4 Jun 2021 10:05:21 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [RESEND, V5 1/2] dt-bindings: imx6q-pcie: Add "vph-supply" for PHY supply voltage
Date:   Fri,  4 Jun 2021 09:47:48 +0800
Message-Id: <1622771269-13844-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622771269-13844-1-git-send-email-hongxing.zhu@nxp.com>
References: <1622771269-13844-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The i.MX8MQ PCIe PHY can use either a 1.8V or a 3.3V power supply.
Add a "vph-supply" property to indicate which regulator supplies
power for the PHY.

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

