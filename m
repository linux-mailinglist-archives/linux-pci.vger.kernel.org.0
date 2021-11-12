Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B028344EF66
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 23:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbhKLWiL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 17:38:11 -0500
Received: from inva020.nxp.com ([92.121.34.13]:57338 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235990AbhKLWh5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Nov 2021 17:37:57 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 80E751A2080;
        Fri, 12 Nov 2021 23:35:04 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4361E1A2077;
        Fri, 12 Nov 2021 23:35:04 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id B178840BF1;
        Fri, 12 Nov 2021 15:35:03 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 06/11] arm64: dts: ls1028a-rdb: reorder nodes to be alphabetic
Date:   Fri, 12 Nov 2021 16:34:52 -0600
Message-Id: <20211112223457.10599-7-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211112223457.10599-1-leoyang.li@nxp.com>
References: <20211112223457.10599-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Keep these overrides node in alphabetic order in order to prevent
unnoticed duplicated nodes.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 92 +++++++++----------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 49ec2821d15f..81d0f3ac27ec 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -102,6 +102,52 @@ can-transceiver {
 	};
 };
 
+&duart0 {
+	status = "okay";
+};
+
+&duart1 {
+	status = "okay";
+};
+
+&enetc_mdio_pf3 {
+	/* VSC8514 QSGMII quad PHY */
+	qsgmii_phy0: ethernet-phy@10 {
+		reg = <0x10>;
+	};
+
+	qsgmii_phy1: ethernet-phy@11 {
+		reg = <0x11>;
+	};
+
+	qsgmii_phy2: ethernet-phy@12 {
+		reg = <0x12>;
+	};
+
+	qsgmii_phy3: ethernet-phy@13 {
+		reg = <0x13>;
+	};
+};
+
+&enetc_port0 {
+	phy-handle = <&sgmii_phy0>;
+	phy-connection-type = "sgmii";
+	managed = "in-band-status";
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		sgmii_phy0: ethernet-phy@2 {
+			reg = <0x2>;
+		};
+	};
+};
+
+&enetc_port2 {
+	status = "okay";
+};
+
 &esdhc {
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
@@ -192,52 +238,6 @@ rtc@51 {
 	};
 };
 
-&duart0 {
-	status = "okay";
-};
-
-&duart1 {
-	status = "okay";
-};
-
-&enetc_mdio_pf3 {
-	/* VSC8514 QSGMII quad PHY */
-	qsgmii_phy0: ethernet-phy@10 {
-		reg = <0x10>;
-	};
-
-	qsgmii_phy1: ethernet-phy@11 {
-		reg = <0x11>;
-	};
-
-	qsgmii_phy2: ethernet-phy@12 {
-		reg = <0x12>;
-	};
-
-	qsgmii_phy3: ethernet-phy@13 {
-		reg = <0x13>;
-	};
-};
-
-&enetc_port0 {
-	phy-handle = <&sgmii_phy0>;
-	phy-connection-type = "sgmii";
-	managed = "in-band-status";
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		sgmii_phy0: ethernet-phy@2 {
-			reg = <0x2>;
-		};
-	};
-};
-
-&enetc_port2 {
-	status = "okay";
-};
-
 &mscc_felix {
 	status = "okay";
 };
-- 
2.25.1

