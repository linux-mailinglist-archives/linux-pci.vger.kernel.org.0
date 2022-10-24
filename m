Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14198609C92
	for <lists+linux-pci@lfdr.de>; Mon, 24 Oct 2022 10:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiJXI23 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 04:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiJXI2D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 04:28:03 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542CB4E613;
        Mon, 24 Oct 2022 01:27:52 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 148E4220EAE;
        Mon, 24 Oct 2022 10:27:16 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D89AA220E59;
        Mon, 24 Oct 2022 10:27:15 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 704241834868;
        Mon, 24 Oct 2022 16:27:14 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, kishon@ti.com,
        kw@linux.com, frank.li@nxp.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [RESEND v4 08/14] arm64: dts: Add i.MX8MP PCIe EP support
Date:   Mon, 24 Oct 2022 16:06:37 +0800
Message-Id: <1666598803-1912-9-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1666598803-1912-1-git-send-email-hongxing.zhu@nxp.com>
References: <1666598803-1912-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add i.MX8MP PCIe EP support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index bb916a0948a8..53d376e14b88 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1192,6 +1192,25 @@ pcie: pcie@33800000 {
 			status = "disabled";
 		};
 
+		pcie_ep: pcie_ep@33800000 {
+			compatible = "fsl,imx8mp-pcie-ep";
+			reg = <0x33800000 0x000400000>, <0x18000000 0x08000000>;
+			reg-names = "regs", "addr_space";
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>; /* eDMA */
+			interrupt-names = "dma";
+			fsl,max-link-speed = <3>;
+			power-domains = <&hsio_blk_ctrl IMX8MP_HSIOBLK_PD_PCIE>;
+			resets = <&src IMX8MP_RESET_PCIE_CTRL_APPS_EN>,
+				 <&src IMX8MP_RESET_PCIE_CTRL_APPS_TURNOFF>;
+			reset-names = "apps", "turnoff";
+			phys = <&pcie_phy>;
+			phy-names = "pcie-phy";
+			num-ib-windows = <4>;
+			num-ob-windows = <4>;
+			status = "disabled";
+		};
+
 		gpu3d: gpu@38000000 {
 			compatible = "vivante,gc";
 			reg = <0x38000000 0x8000>;
-- 
2.25.1

