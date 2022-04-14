Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37A350073B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 09:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbiDNHn1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 03:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbiDNHnO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 03:43:14 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3505714A;
        Thu, 14 Apr 2022 00:40:49 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 7BA071C0006;
        Thu, 14 Apr 2022 07:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649922048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XdDCShbbxhQ2SA9jviWD/+YRBhMlJkyJIZxBflXfYR0=;
        b=FLdKrGqHEkSb6QGT+rXqIUJJoDIxHeweM6Q/pByus+MXYtcHDIFqg2mjp9uUNQ93dPDVrR
        p0a1oF7qbtBRrqe3cbL6nFJyKRfJ9ayNy8geU4yuJ+6VumDc74uLGnUa84yRpIPYDn4vke
        SZGq+UOGZejnWpPW79zckaU9n5puyeuC4j2f11WITwC6W3bIADkaBtIWrfb7gWB4+LC+dk
        ZIbw7+UeSFDL9LSCFXZG7SC2lmDb8DWOgMbG4aGCb+9ALWHy2eVRqhBLB6ZzFqOBOD0h/r
        v+FP+aKD778FEfMD3vc+4J2LGBC0pxvk8uIa3O2RNOD/BDQEUwi4PWKWR+CoAg==
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
Subject: [PATCH v2 6/8] ARM: dts: r9a06g032: Add internal PCI bridge node
Date:   Thu, 14 Apr 2022 09:40:09 +0200
Message-Id: <20220414074011.500533-7-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414074011.500533-1-herve.codina@bootlin.com>
References: <20220414074011.500533-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the device node for the r9a06g032 internal PCI bridge device.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 636a6ab31c58..848dc034bb8c 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -211,6 +211,34 @@ gic: interrupt-controller@44101000 {
 			interrupts =
 				<GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
+
+		pci_usb: pci@40030000 {
+			compatible = "renesas,pci-r9a06g032", "renesas,pci-rzn1";
+			device_type = "pci";
+			clocks = <&sysctrl R9A06G032_HCLK_USBH>,
+				 <&sysctrl R9A06G032_HCLK_USBPM>,
+				 <&sysctrl R9A06G032_CLK_PCI_USB>;
+			clock-names = "hclk_usbh", "hclk_usbpm", "clk_pci_usb";
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
 	};
 
 	timer {
-- 
2.35.1

