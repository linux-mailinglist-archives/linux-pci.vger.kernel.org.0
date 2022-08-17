Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483F35979E8
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 01:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242071AbiHQXDk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 19:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239287AbiHQXDj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 19:03:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000CBA598A;
        Wed, 17 Aug 2022 16:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64EF0B81FCE;
        Wed, 17 Aug 2022 23:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA13DC433C1;
        Wed, 17 Aug 2022 23:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660777415;
        bh=JELlqfEhsdApV8P72cKb67VDmduJhfcW++RF8mpUbiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S2LTdRPtqZMQj0xPZD/ddzoBoQJv6vtfDtwaHFOZgcrj31nsv20UeerQ0tU1dwdKv
         r7b5TcACIXKklUWL73+X80ihZuriqjo8OX5AdQuH1aQ5VqJd1d5frikQ9V4tmG8JBZ
         htDilh7cyogNHsykKf0/IqlbpSmUJ/UQS7NrOhqfzyY/1GWJPRjHvEAWFyzSVSjQ2a
         beKLFVYrtcHpT/ovj/kQ3rL5q/9QUpxV/h0dF+yjLLXGbJqc4oHI9WuP1kCiL3VtfX
         Q/kSq2ZYCujHXAVLBsrVzbozxowoHW35pZg6Wuj7isMmWQBXX2fRbTTLQKO/r9yrgb
         EVEADnwAiLjyw==
Received: by pali.im (Postfix)
        id 62C1827E1; Thu, 18 Aug 2022 01:03:34 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] ARM: dts: kirkwood: Add definitions for PCIe error interrupts
Date:   Thu, 18 Aug 2022 01:00:35 +0200
Message-Id: <20220817230036.817-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220817230036.817-1-pali@kernel.org>
References: <20220817230036.817-1-pali@kernel.org>
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

First PCIe controller on Kirkwood SoC reports error interrupt via IRQ 44
and second PCIe controller via IRQ 45.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/kirkwood-6192.dtsi     | 4 ++--
 arch/arm/boot/dts/kirkwood-6281.dtsi     | 4 ++--
 arch/arm/boot/dts/kirkwood-6282.dtsi     | 8 ++++----
 arch/arm/boot/dts/kirkwood-98dx4122.dtsi | 4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-6192.dtsi b/arch/arm/boot/dts/kirkwood-6192.dtsi
index 07f4f7f98c0c..705c0d7effed 100644
--- a/arch/arm/boot/dts/kirkwood-6192.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6192.dtsi
@@ -26,8 +26,8 @@
 				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
 					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-names = "intx";
-				interrupts = <9>;
+				interrupt-names = "intx", "error";
+				interrupts = <9>, <44>;
 				interrupt-map-mask = <0 0 0 7>;
 				interrupt-map = <0 0 0 1 &pcie_intc 0>,
 						<0 0 0 2 &pcie_intc 1>,
diff --git a/arch/arm/boot/dts/kirkwood-6281.dtsi b/arch/arm/boot/dts/kirkwood-6281.dtsi
index d08a9a5ecc26..8e311165fd13 100644
--- a/arch/arm/boot/dts/kirkwood-6281.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6281.dtsi
@@ -26,8 +26,8 @@
 				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
 					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-names = "intx";
-				interrupts = <9>;
+				interrupt-names = "intx", "error";
+				interrupts = <9>, <44>;
 				interrupt-map-mask = <0 0 0 7>;
 				interrupt-map = <0 0 0 1 &pcie_intc 0>,
 						<0 0 0 2 &pcie_intc 1>,
diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index 2eea5b304f47..e33723160ce7 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -30,8 +30,8 @@
 				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
 					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-names = "intx";
-				interrupts = <9>;
+				interrupt-names = "intx", "error";
+				interrupts = <9>, <44>;
 				interrupt-map-mask = <0 0 0 7>;
 				interrupt-map = <0 0 0 1 &pcie0_intc 0>,
 						<0 0 0 2 &pcie0_intc 1>,
@@ -58,8 +58,8 @@
 				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
 					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-names = "intx";
-				interrupts = <10>;
+				interrupt-names = "intx", "error";
+				interrupts = <10>, <45>;
 				interrupt-map-mask = <0 0 0 7>;
 				interrupt-map = <0 0 0 1 &pcie1_intc 0>,
 						<0 0 0 2 &pcie1_intc 1>,
diff --git a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
index 070bc13242b8..c3469a2fc58a 100644
--- a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
+++ b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
@@ -26,8 +26,8 @@
 				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
 					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
 				bus-range = <0x00 0xff>;
-				interrupt-names = "intx";
-				interrupts = <9>;
+				interrupt-names = "intx", "error";
+				interrupts = <9>, <44>;
 				interrupt-map-mask = <0 0 0 7>;
 				interrupt-map = <0 0 0 1 &pcie_intc 0>,
 						<0 0 0 2 &pcie_intc 1>,
-- 
2.20.1

