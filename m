Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F54648C702
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 16:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354536AbiALPSw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 10:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354525AbiALPSs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 10:18:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F138AC06173F;
        Wed, 12 Jan 2022 07:18:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1737B81F18;
        Wed, 12 Jan 2022 15:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F1DC36AF3;
        Wed, 12 Jan 2022 15:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642000725;
        bh=jtnXy/0wJdPoAj9Kl/G+9fKg5jNFoqP7I41ddO0yJHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ENeH389Z3K9A22RNGYp0xhpNB+lzR0N6Meuhn18YBeBmJBdwailmJJISl2GMjmBLa
         zYvFbJwW5JrXVjEXUfgET8EBieYAPDs2OGFz75oBEo9CyHrtpk0pUT/Pcri++gGsDS
         FWLCmXEdIBd5O0dey2SBurbA0QF04b6BCKhDdj1RPQaTVTv53HspBi8qd0vWLfeTq6
         EW9Fmi7g1bTf00urjsEO+gzPnlX4otXCtITP4DNZ4x2q7NLYZxlxKO1hG2TkN2dtIp
         c4fEKbw4MF3OyUJ2fDXjxKd5iHGZMOFnTF+hm1+ira9pxBRJ4ncQ2QSMd5qdeDaZWM
         xzQS8flUpmEqA==
Received: by pali.im (Postfix)
        id E28D2768; Wed, 12 Jan 2022 16:18:44 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 11/11] ARM: dts: armada-385.dtsi: Add definitions for PCIe legacy INTx interrupts
Date:   Wed, 12 Jan 2022 16:18:14 +0100
Message-Id: <20220112151814.24361-12-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220112151814.24361-1-pali@kernel.org>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220112151814.24361-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With this change legacy INTA, INTB, INTC and INTD interrupts are reported
separately and not mixed into one Linux virq source anymore.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/armada-385.dtsi | 52 ++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/armada-385.dtsi
index f0022d10c715..83392b92dae2 100644
--- a/arch/arm/boot/dts/armada-385.dtsi
+++ b/arch/arm/boot/dts/armada-385.dtsi
@@ -69,16 +69,25 @@
 				reg = <0x0800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
+				interrupt-names = "intx";
+				interrupts-extended = <&gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
 					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie1_intc 0>,
+						<0 0 0 2 &pcie1_intc 1>,
+						<0 0 0 3 &pcie1_intc 2>,
+						<0 0 0 4 &pcie1_intc 3>;
 				marvell,pcie-port = <0>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 8>;
 				status = "disabled";
+				pcie1_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 
 			/* x1 port */
@@ -88,16 +97,25 @@
 				reg = <0x1000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
+				interrupt-names = "intx";
+				interrupts-extended = <&gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
 					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie2_intc 0>,
+						<0 0 0 2 &pcie2_intc 1>,
+						<0 0 0 3 &pcie2_intc 2>,
+						<0 0 0 4 &pcie2_intc 3>;
 				marvell,pcie-port = <1>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 5>;
 				status = "disabled";
+				pcie2_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 
 			/* x1 port */
@@ -107,16 +125,25 @@
 				reg = <0x1800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
+				interrupt-names = "intx";
+				interrupts-extended = <&gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
 					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie3_intc 0>,
+						<0 0 0 2 &pcie3_intc 1>,
+						<0 0 0 3 &pcie3_intc 2>,
+						<0 0 0 4 &pcie3_intc 3>;
 				marvell,pcie-port = <2>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 6>;
 				status = "disabled";
+				pcie3_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 
 			/*
@@ -129,16 +156,25 @@
 				reg = <0x2000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
+				interrupt-names = "intx";
+				interrupts-extended = <&gic GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
 					  0x81000000 0 0 0x81000000 0x4 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &gic GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie4_intc 0>,
+						<0 0 0 2 &pcie4_intc 1>,
+						<0 0 0 3 &pcie4_intc 2>,
+						<0 0 0 4 &pcie4_intc 3>;
 				marvell,pcie-port = <3>;
 				marvell,pcie-lane = <0>;
 				clocks = <&gateclk 7>;
 				status = "disabled";
+				pcie4_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 		};
 	};
-- 
2.20.1

