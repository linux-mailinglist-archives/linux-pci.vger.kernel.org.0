Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EF441CAC1
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 18:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346171AbhI2Q6i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 12:58:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346197AbhI2Q6e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 12:58:34 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1732613D1;
        Wed, 29 Sep 2021 16:56:53 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mVcbi-00DmcL-Vd; Wed, 29 Sep 2021 17:38:59 +0100
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
Subject: [PATCH v5 13/14] arm64: dts: apple: t8103: Add root port interrupt routing
Date:   Wed, 29 Sep 2021 17:38:46 +0100
Message-Id: <20210929163847.2807812-14-maz@kernel.org>
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

Add the interrupt-map properties that are required for INTx
signalling.

Tested-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 33 +++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 2eae6752375f..e6263c711c18 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -274,7 +274,7 @@ pcie0: pcie@690000000 {
 			pinctrl-0 = <&pcie_pins>;
 			pinctrl-names = "default";
 
-			pci@0,0 {
+			port00: pci@0,0 {
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				reset-gpios = <&pinctrl_ap 152 0>;
@@ -283,9 +283,18 @@ pci@0,0 {
 				#address-cells = <3>;
 				#size-cells = <2>;
 				ranges;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &port00 0 0 0 0>,
+						<0 0 0 2 &port00 0 0 0 1>,
+						<0 0 0 3 &port00 0 0 0 2>,
+						<0 0 0 4 &port00 0 0 0 3>;
 			};
 
-			pci@1,0 {
+			port01: pci@1,0 {
 				device_type = "pci";
 				reg = <0x800 0x0 0x0 0x0 0x0>;
 				reset-gpios = <&pinctrl_ap 153 0>;
@@ -294,9 +303,18 @@ pci@1,0 {
 				#address-cells = <3>;
 				#size-cells = <2>;
 				ranges;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &port01 0 0 0 0>,
+						<0 0 0 2 &port01 0 0 0 1>,
+						<0 0 0 3 &port01 0 0 0 2>,
+						<0 0 0 4 &port01 0 0 0 3>;
 			};
 
-			pci@2,0 {
+			port02: pci@2,0 {
 				device_type = "pci";
 				reg = <0x1000 0x0 0x0 0x0 0x0>;
 				reset-gpios = <&pinctrl_ap 33 0>;
@@ -305,6 +323,15 @@ pci@2,0 {
 				#address-cells = <3>;
 				#size-cells = <2>;
 				ranges;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &port02 0 0 0 0>,
+						<0 0 0 2 &port02 0 0 0 1>,
+						<0 0 0 3 &port02 0 0 0 2>,
+						<0 0 0 4 &port02 0 0 0 3>;
 			};
 		};
 	};
-- 
2.30.2

