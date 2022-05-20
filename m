Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9C952E922
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 11:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347844AbiETJmy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 05:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347822AbiETJmp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 05:42:45 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3871498EC;
        Fri, 20 May 2022 02:42:30 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 491A11C0009;
        Fri, 20 May 2022 09:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653039749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m2syZDhXMNfFFdbui/0S6GoKTUC26/S1VVnx+DdDmc4=;
        b=hDI9q5RqLcRMF8LHFZG4HuGcYkF0PtBmbohtsdG5azoefpgEoDzGQMn7GWynqA6nYlKz7j
        J1SiUVk9nGkSdoOtX3DExanNsFe/r4bAKa6IoLwAnbINUlYzcixeMmT/RF8VbcPOfvhGUD
        +3C7s3gakdl0kcMBZ6OsxWnOY3605X25iNk9OsPCKvVZawadQ+fgZKLWAjgAMzAKWa4WoL
        ovkGawphsqtbjDtSxzamGdX9D5I5ctIQDtu5dV2OJwhfvf4kPrROYUkPxUdGE5+xgsT2JJ
        IuG24Nl1ntOV7EqlGcry8DnWbjiKWUsYSi1OUsDe12YiamENkMkJSZms2USuvg==
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
Subject: [PATCH v6 4/6] ARM: dts: r9a06g032: Add internal PCI bridge node
Date:   Fri, 20 May 2022 11:41:53 +0200
Message-Id: <20220520094155.313784-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520094155.313784-1-herve.codina@bootlin.com>
References: <20220520094155.313784-1-herve.codina@bootlin.com>
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

