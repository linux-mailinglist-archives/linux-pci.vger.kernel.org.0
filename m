Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D003513808
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 17:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349016AbiD1PUS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 11:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349000AbiD1PUQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 11:20:16 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD3FAFB1C;
        Thu, 28 Apr 2022 08:16:50 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 7640CE0002;
        Thu, 28 Apr 2022 15:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651159009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d9l6NQQrahvpT9nXUxyuFVP26OC7kXj+zx7LJhpUN3Q=;
        b=eNHlQn8CqcpNqId+Y70BJRaVQ9Ez+JIQJTSD1jOm9HDq5O+tYejoW8IbkzbGbZ5aZN1XnW
        JMk6HqSwWLGKMqdVJJ/2Db0eLkcBV0d/Edlprg66Rlgll1LUzFd8bWbBZ5oUGUaTQvtvqW
        ebp+YbYaNpiABYKmT9xa3KLCTEA5K2KiBtx1rVoiXjYwsGeelosARrwa/+IAtYoDP9gQKj
        2O0JE86VL7EoJzHVKpL9iJUpMf0p7JB3dcC6Zq16Ad2yxMTqmZoW3WG1zA/EJ+E5L6s8XC
        Fw+WTiFqzz4cHoMgn49LABI9737QH38dlZPOHmH9CqnPE31WU41MGvG3zOMG5Q==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v4 4/6] ARM: dts: r9a06g032: Add internal PCI bridge node
Date:   Thu, 28 Apr 2022 17:16:28 +0200
Message-Id: <20220428151630.586009-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428151630.586009-1-herve.codina@bootlin.com>
References: <20220428151630.586009-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the device node for the r9a06g032 internal PCI bridge device.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 636a6ab31c58..a11a50426a8e 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -93,6 +93,35 @@ sysctrl: system-controller@4000c000 {
 			clock-names = "mclk", "rtc", "jtag", "rgmii_ref_ext";
 		};
 
+		pci_usb: pci@40030000 {
+			compatible = "renesas,pci-r9a06g032", "renesas,pci-rzn1";
+			device_type = "pci";
+			clocks = <&sysctrl R9A06G032_HCLK_USBH>,
+				 <&sysctrl R9A06G032_HCLK_USBPM>,
+				 <&sysctrl R9A06G032_CLK_PCI_USB>;
+			clock-names = "usb_hclkh", "usb_hclkpm", "usb_pciclk";
+			power-domains = <&sysctrl>;
+			reg = <0x40030000 0xc00>,
+			      <0x40020000 0x1100>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+
+			bus-range = <0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges = <0x02000000 0 0x40020000 0x40020000 0 0x00010000>;
+			/* Should map all possible DDR as inbound ranges, but
+			 * the IP only supports a 256MB, 512MB, or 1GB window.
+			 * flags, PCI addr (64-bit), CPU addr, PCI size (64-bit)
+			 */
+			dma-ranges = <0x42000000 0 0x80000000 0x80000000 0 0x40000000>;
+			interrupt-map-mask = <0xf800 0 0 0x7>;
+			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH
+					 0x0800 0 0 1 &gic GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH
+					 0x1000 0 0 2 &gic GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		uart0: serial@40060000 {
 			compatible = "renesas,r9a06g032-uart", "renesas,rzn1-uart", "snps,dw-apb-uart";
 			reg = <0x40060000 0x400>;
-- 
2.35.1

