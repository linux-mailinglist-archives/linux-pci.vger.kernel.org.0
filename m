Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5482514ADF
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 15:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376362AbiD2Npk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 09:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376314AbiD2Npb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 09:45:31 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BA7C8BD9;
        Fri, 29 Apr 2022 06:42:10 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id C36B11BF20A;
        Fri, 29 Apr 2022 13:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651239729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m2syZDhXMNfFFdbui/0S6GoKTUC26/S1VVnx+DdDmc4=;
        b=T3jCq6eRosujw4XJEcBPAwB1q0B329upoBfSs/97YpUdhPO0ezTT83fS3dcXRo7Sn669rL
        KAqSMeuJPGVSYuVehhUxE5xGeA1YcxlpWQAt0UNmbaRgH6hw9UGdfeFIZX1aaeUkFR/9a9
        ia9VqTbgNeYBu5bXld5e5EY/I0EQUp+dhXq0bQnsJJkyW8APdI5aFVpPxUfjCY/2tis4RT
        dUB8mNM0HkQJbYQVleRXY3DM6Mxn80bGaNTms714N8HizEqSIh5heP8LMEx/wvhc/gmVfr
        X9NS+1tRzmzXxyn1o11+XaxLfIuqlF4LOlauOPN2PaJWKXIrxx8tP1GAuZIFbA==
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
Subject: [PATCH v5 4/6] ARM: dts: r9a06g032: Add internal PCI bridge node
Date:   Fri, 29 Apr 2022 15:41:41 +0200
Message-Id: <20220429134143.628428-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429134143.628428-1-herve.codina@bootlin.com>
References: <20220429134143.628428-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the device node for the r9a06g032 internal PCI bridge device.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 20286433d3c6..45944f849190 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -94,6 +94,35 @@ sysctrl: system-controller@4000c000 {
 			clock-names = "mclk", "rtc", "jtag", "rgmii_ref_ext";
 		};
 
+		pci_usb: pci@40030000 {
+			compatible = "renesas,pci-r9a06g032", "renesas,pci-rzn1";
+			device_type = "pci";
+			clocks = <&sysctrl R9A06G032_HCLK_USBH>,
+				 <&sysctrl R9A06G032_HCLK_USBPM>,
+				 <&sysctrl R9A06G032_CLK_PCI_USB>;
+			clock-names = "hclkh", "hclkpm", "pciclk";
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

