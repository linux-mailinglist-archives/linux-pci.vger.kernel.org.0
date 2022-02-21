Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D934BD658
	for <lists+linux-pci@lfdr.de>; Mon, 21 Feb 2022 07:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345493AbiBUGo0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Feb 2022 01:44:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345492AbiBUGoT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Feb 2022 01:44:19 -0500
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554063B3C7;
        Sun, 20 Feb 2022 22:42:17 -0800 (PST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AA082200500;
        Mon, 21 Feb 2022 07:42:15 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 725672001A3;
        Mon, 21 Feb 2022 07:42:15 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 56982183ACDE;
        Mon, 21 Feb 2022 14:42:14 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v4 1/2] ARM: dts: imx6qp-sabresd: Enable PCIe support
Date:   Mon, 21 Feb 2022 14:33:56 +0800
Message-Id: <1645425237-4071-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the i.MX6QP sabresd board(sch-28857) design, one external oscillator
is powered up by vgen3 and used as the PCIe reference clock source by
the endpoint device.

If RC uses this oscillator as reference clock too, PLL6(ENET PLL) would
has to be in bypass mode, and ENET clocks would be messed up.

To keep things simple, let RC use the internal PLL as reference clock
and set vgen3 always on to enable the external oscillator for endpoint
device on i.MX6QP sabresd board.

NOTE: This reference clock setup is used to pass the GEN2 TX compliance
tests, and isn't recommended as a setup in the end-user design.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm/boot/dts/imx6qp-sabresd.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qp-sabresd.dts b/arch/arm/boot/dts/imx6qp-sabresd.dts
index 480e73183f6b..f69eec18d865 100644
--- a/arch/arm/boot/dts/imx6qp-sabresd.dts
+++ b/arch/arm/boot/dts/imx6qp-sabresd.dts
@@ -50,8 +50,12 @@ MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x17059
 	};
 };
 
+&vgen3_reg {
+	regulator-always-on;
+};
+
 &pcie {
-	status = "disabled";
+	status = "okay";
 };
 
 &sata {
-- 
2.25.1

