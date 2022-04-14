Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DEA500756
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 09:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiDNHnu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 03:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbiDNHnh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 03:43:37 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA3E58801;
        Thu, 14 Apr 2022 00:40:55 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 4A0761C0002;
        Thu, 14 Apr 2022 07:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649922054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/HaP1IPsXOMTJDxi/2nGbwDNVZapKrfnOpUYaIlabXs=;
        b=pjtI2EnteulEn6PvCuscIMvp9IYAnzULmnwWB8Vowxa/qBhOBdzVK9ESvlaPL591E5pt6E
        CvTZtvvydWziOy1NJ+tglOi1WSPn6EAxPsDU+9Q4y50WiLGJ8TUXLNvrqq6G/WIiUmnJNQ
        w9PuvMr3a0qxVc/dNrQLfPtx7blx1b/aJUWt2cTlEsm84s16UwCTrTWgjMMLwJLlUnf3Ya
        qgGiM1SdpXjHut+h7uUT+vgCEV6hBOQEE6ihrtrQvq9R6gN1qlGR40BszSzZRE6MUSHAJw
        8w+/98NSV3UP4SMB93joDnMzdQV4IBLbylvBbfTNgoOYLYtAsRutUjLzYqnoRg==
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
Subject: [PATCH v2 8/8] ARM: dts: r9a06g032: Link the PCI USB devices to the USB PHY
Date:   Thu, 14 Apr 2022 09:40:11 +0200
Message-Id: <20220414074011.500533-9-herve.codina@bootlin.com>
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

Describe the PCI USB devices that are behind the PCI bridge, adding
necessary links to the USB PHY device.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 2f7236e3eff0..f0007b0447ca 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -244,6 +244,18 @@ pci_usb: pci@40030000 {
 			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH
 					 0x0800 0 0 1 &gic GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH
 					 0x1000 0 0 2 &gic GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+
+			usb@1,0 {
+				reg = <0x800 0 0 0 0>;
+				phys = <&usbphy 0>;
+				phy-names = "usb";
+			};
+
+			usb@2,0 {
+				reg = <0x1000 0 0 0 0>;
+				phys = <&usbphy 0>;
+				phy-names = "usb";
+			};
 		};
 	};
 
-- 
2.35.1

