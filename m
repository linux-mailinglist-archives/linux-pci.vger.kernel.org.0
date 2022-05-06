Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E137D51D979
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 15:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441853AbiEFNpE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 09:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441828AbiEFNoc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 09:44:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F381E3E6;
        Fri,  6 May 2022 06:40:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4519BB835D9;
        Fri,  6 May 2022 13:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB000C385A8;
        Fri,  6 May 2022 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651844445;
        bh=p/76Cpg7L+kE6nwIYR/gHuuS0bPxpwnMHjpNEqVNkzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LczEYx8x0TMX6svTAyzcQMwLj7PeeRpzOIgynCV5Mw5U5ep2b6b+SawhZLtbCDvSq
         SUfNovmyWFH/IuyQgLwUVbkyGwXxU0KfDF45AHnduAKPomO29xmfSUjMZHy8PniByK
         9onf0qbeJRuvPrCGopPgZhREEzUYdtTsaU+tH8fx/YupxfNVv3mSoOpQ1GGn8dA+1H
         JJrK9faX78T9cI8m20sce9QPhDq4IjidD1JR7dFyaJMIhFr++2WHhmkDSnzFUEWvke
         OYCny7LIgxweQXfuaAL1wqhzJDX8rF6jT74IqaJXW6C5AxqHolNIK/m/SZyJl84UR4
         9i0l9U+DgCzXw==
Received: by pali.im (Postfix)
        id 067A713DC; Fri,  6 May 2022 15:40:42 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/6] ARM: dts: armada-385.dtsi: Add definitions for PCIe summary interrupts
Date:   Fri,  6 May 2022 15:40:29 +0200
Message-Id: <20220506134029.21470-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220506134029.21470-1-pali@kernel.org>
References: <20220506134029.21470-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe summary interrupt is reported by MPIC SoC Error IRQ controller.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/armada-385.dtsi | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/armada-385.dtsi
index 83392b92dae2..b8219c13c93b 100644
--- a/arch/arm/boot/dts/armada-385.dtsi
+++ b/arch/arm/boot/dts/armada-385.dtsi
@@ -69,8 +69,9 @@
 				reg = <0x0800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
-				interrupt-names = "intx";
-				interrupts-extended = <&gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "intx", "summary";
+				interrupts-extended = <&gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+						      <&soc_err 4>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
 					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
@@ -97,8 +98,9 @@
 				reg = <0x1000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
-				interrupt-names = "intx";
-				interrupts-extended = <&gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "intx", "summary";
+				interrupts-extended = <&gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+						      <&soc_err 5>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
 					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
@@ -125,8 +127,9 @@
 				reg = <0x1800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
-				interrupt-names = "intx";
-				interrupts-extended = <&gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "intx", "summary";
+				interrupts-extended = <&gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+						      <&soc_err 15>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
 					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
@@ -156,8 +159,9 @@
 				reg = <0x2000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
-				interrupt-names = "intx";
-				interrupts-extended = <&gic GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "intx", "summary";
+				interrupts-extended = <&gic GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+						      <&soc_err 16>;
 				#interrupt-cells = <1>;
 				ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
 					  0x81000000 0 0 0x81000000 0x4 0 1 0>;
-- 
2.20.1

