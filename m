Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C456348C00
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 09:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhCYI67 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 04:58:59 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36674 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229670AbhCYI6i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Mar 2021 04:58:38 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DB42420303E;
        Thu, 25 Mar 2021 09:58:32 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BE173203044;
        Thu, 25 Mar 2021 09:58:27 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F3459402AC;
        Thu, 25 Mar 2021 09:58:20 +0100 (CET)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 2/3] arm64: dts: imx8mq-evk: add one regulator used to power up pcie phy
Date:   Thu, 25 Mar 2021 16:44:41 +0800
Message-Id: <1616661882-26487-3-git-send-email-hongxing.zhu@nxp.com>
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
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 85b045253a0e..4d2035e3dd7c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -318,6 +318,7 @@
 		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
 		 <&pcie0_refclk>;
 	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
+	vph-supply = <&vgen5_reg>;
 	status = "okay";
 };
 
-- 
2.17.1

