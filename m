Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E7C41CABD
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 18:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344802AbhI2Q6d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 12:58:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346167AbhI2Q6d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 12:58:33 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB37761425;
        Wed, 29 Sep 2021 16:56:51 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mVcbi-00DmcL-KS; Wed, 29 Sep 2021 17:38:58 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Joerg Roedel <joro@8bytes.org>, kernel-team@android.com
Subject: [PATCH v5 12/14] arm64: dts: apple: t8103: Add PCIe DARTs
Date:   Wed, 29 Sep 2021 17:38:45 +0100
Message-Id: <20210929163847.2807812-13-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929163847.2807812-1-maz@kernel.org>
References: <20210929163847.2807812-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com, kw@linux.com, alyssa@rosenzweig.io, stan@corellium.com, kettenis@openbsd.org, sven@svenpeter.dev, marcan@marcan.st, Robin.Murphy@arm.com, joey.gouly@arm.com, joro@8bytes.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe on the Apple M1 (aka t8103) requires the use of IOMMUs (aka
DARTs). Add the three instances that deal with the internal PCIe
ports and route each port's traffic through its DART.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 10956859b4bb..2eae6752375f 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -215,6 +215,30 @@ pinctrl_smc: pinctrl@23e820000 {
 				     <AIC_IRQ 397 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pcie0_dart_0: dart@681008000 {
+			compatible = "apple,t8103-dart";
+			reg = <0x6 0x81008000 0x0 0x4000>;
+			#iommu-cells = <1>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 696 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pcie0_dart_1: dart@682008000 {
+			compatible = "apple,t8103-dart";
+			reg = <0x6 0x82008000 0x0 0x4000>;
+			#iommu-cells = <1>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 699 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pcie0_dart_2: dart@683008000 {
+			compatible = "apple,t8103-dart";
+			reg = <0x6 0x83008000 0x0 0x4000>;
+			#iommu-cells = <1>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 702 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		pcie0: pcie@690000000 {
 			compatible = "apple,t8103-pcie", "apple,pcie";
 			device_type = "pci";
@@ -235,6 +259,12 @@ pcie0: pcie@690000000 {
 			msi-parent = <&pcie0>;
 			msi-ranges = <&aic AIC_IRQ 704 IRQ_TYPE_EDGE_RISING 32>;
 
+
+			iommu-map = <0x100 &pcie0_dart_0 1 1>,
+				    <0x200 &pcie0_dart_1 1 1>,
+				    <0x300 &pcie0_dart_2 1 1>;
+			iommu-map-mask = <0xff00>;
+
 			bus-range = <0 3>;
 			#address-cells = <3>;
 			#size-cells = <2>;
-- 
2.30.2

