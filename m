Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8FE50B6F4
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 14:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447403AbiDVMMW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 08:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447365AbiDVMMM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 08:12:12 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188BA56758;
        Fri, 22 Apr 2022 05:09:14 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 3FBE824000E;
        Fri, 22 Apr 2022 12:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650629353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QuYQWFbufH5yU6S93NHtWSTqJzRsUE1RxETOR78kCLE=;
        b=nwDgj1UcMv+++I3CF/L2kzjJK2U+3Nj+/TZlNH8MVAdYSHceiae0SfH6XIh62vFHd3V9w8
        0B4mQmFFiPzpjrQC+O1YSY/piHu4xOAaUS38B7/NgNsYJYlxrEqcIYwUIX3rNSsMvGEJxU
        4BNBCFG5TNOM5cFmBjortKWC1bzh7RNCraYLV9omEJWoyXrJ4PixyxNafOHWZsBFhbiwGy
        81BJjNV2bWNrylOJ4usBmmO+cs/6uIxSO6atqeQk6fqq7llaxtoi1/GwazyyU++6xqDDUj
        ig5St6N4+N5awkl9p8Lud5rlvCrtLkppQ4qFfC+SGtBl/Nt6peQeiQYibCW8hg==
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
Subject: [PATCH v3 6/8] ARM: dts: r9a06g032: Add internal PCI bridge node
Date:   Fri, 22 Apr 2022 14:08:48 +0200
Message-Id: <20220422120850.769480-7-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422120850.769480-1-herve.codina@bootlin.com>
References: <20220422120850.769480-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 20286433d3c6..33581f0c55c4 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -212,6 +212,35 @@ gic: interrupt-controller@44101000 {
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
 	};
 
 	timer {
-- 
2.35.1

