Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5569A4BFD91
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 16:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiBVPwU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 10:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbiBVPwT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 10:52:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998764AE3A;
        Tue, 22 Feb 2022 07:51:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1B07B81B2C;
        Tue, 22 Feb 2022 15:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364D8C340F4;
        Tue, 22 Feb 2022 15:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645545107;
        bh=bzOLRQlMPpfRSbNO1rgcgvpdO6Mv6RUywr/sT3LqJBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ne1DnOQcXG9czcWtxmIwnZW1+8aQlrr+Iu0r2kBhk6X+0+1TkQHz5yE+lhM8pDFlL
         EV65UreD2V/AwY79OYCeRVmc7OiYp1b1XTLeqvF1rSJ8wTVtpF5Cxz6ZpwqXIfalGL
         tppxD6kNBVGUbN5GU9o2Js/5EyHI1zcdUGSwR3lMyJXUv3ixLiC5D1JcGrFRUAYY8P
         NaIqFtXQnzANtgrJUd37URu5cQ7/uBSQwbNNlPN+yuCRKwu/tz1H33p19OEKemM1oI
         S4Fwe3brmI5X8+zF3MgIm9lA5fYLqrjRebzWYLlycfyKH+Ehq6vdkZCNMzawI2++Mz
         cj0j//vYmESHg==
Received: by pali.im (Postfix)
        id E0027FDB; Tue, 22 Feb 2022 16:51:46 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 12/12] ARM: dts: armada-385.dtsi: Add definitions for PCIe legacy INTx interrupts
Date:   Tue, 22 Feb 2022 16:50:30 +0100
Message-Id: <20220222155030.988-13-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220222155030.988-1-pali@kernel.org>
References: <20220222155030.988-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With this change legacy INTA, INTB, INTC and INTD interrupts are reported
separately and not mixed into one Linux virq source anymore.

Signed-off-by: Pali Rohár <pali@kernel.org>
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Tested-by: Luis Mendes <luis.p.mendes@gmail.com>
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

