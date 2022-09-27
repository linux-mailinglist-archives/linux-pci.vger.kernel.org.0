Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0250E5EBE3B
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 11:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiI0JRS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 05:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiI0JQz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 05:16:55 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38469C88B3;
        Tue, 27 Sep 2022 02:16:39 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 264C41AF554;
        Tue, 27 Sep 2022 11:16:37 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D19541AF54D;
        Tue, 27 Sep 2022 11:16:36 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 63614181D0CB;
        Tue, 27 Sep 2022 17:16:34 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, kishon@ti.com,
        kw@linux.com, frank.li@nxp.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v4 09/14] arm64: dts: Add i.MX8MP PCIe EP support on EVK board
Date:   Tue, 27 Sep 2022 16:57:11 +0800
Message-Id: <1664269036-16142-10-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1664269036-16142-1-git-send-email-hongxing.zhu@nxp.com>
References: <1664269036-16142-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add i.MX8MP PCIe EP support on EVK board.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 9f1469db554d..6daaa5ddc6b6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -390,6 +390,19 @@ &pcie {
 	status = "okay";
 };
 
+&pcie_ep{
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie0>;
+	clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
+		 <&clk IMX8MP_CLK_PCIE_ROOT>,
+		 <&clk IMX8MP_CLK_HSIO_AXI>;
+	clock-names = "pcie", "pcie_aux", "pcie_bus";
+	assigned-clocks = <&clk IMX8MP_CLK_PCIE_AUX>;
+	assigned-clock-rates = <10000000>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_50M>;
+	status = "disabled";
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
-- 
2.25.1

