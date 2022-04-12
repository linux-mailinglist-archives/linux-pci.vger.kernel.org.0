Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B054FDD44
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 13:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbiDLLCR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 07:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240019AbiDLLAg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 07:00:36 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A52190FCF;
        Tue, 12 Apr 2022 02:51:02 -0700 (PDT)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 9803ACE944;
        Tue, 12 Apr 2022 09:41:49 +0000 (UTC)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 394B14000C;
        Tue, 12 Apr 2022 09:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649756469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B8CDPPUOPXF9Ae/2eM03+qKM9N1UneWOPC2xfFm8SEc=;
        b=G1P5G7Kq8YBZ/FoftXUVyLLB1A/8NyK9XCOGbGno9tjhtntJY/26ecGVLPfCM/WucLGGPB
        hOar6H5tHnyUt8VKOxl4hYsJBPhtEbZW0AFQQo2l9fC3UUYyIb/GApnwC9R60gbTBgGRQL
        aNPhYjzQPGa7ZnFVdrKv/UFYfZWL+dBPVYlYYLwXqIG/3VKfmITfbAPoLznduh/lPvMFKO
        m+Rd1QpPal7nd0sWUX2zukgyFy3CtxcqKpBy7mUcn2Cd44jIT1Vg+7RrL0fUteP8x2b95E
        dKEz6/pV2QT5dyDAQVj6q+yjCo7EvHhLNtGNVthigCTYYwE5hylzqr1ebSo87g==
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
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 6/6] ARM: dts: r9a06g032: Link the PCI USB devices to the USB PHY
Date:   Tue, 12 Apr 2022 11:40:29 +0200
Message-Id: <20220412094029.287562-7-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412094029.287562-1-herve.codina@bootlin.com>
References: <20220412094029.287562-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index c9336dc4888a..75e45fd6bedb 100644
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

