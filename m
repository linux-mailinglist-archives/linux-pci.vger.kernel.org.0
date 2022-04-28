Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5EF51380C
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 17:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349055AbiD1PU2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 11:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349053AbiD1PUT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 11:20:19 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19F2AFB14;
        Thu, 28 Apr 2022 08:16:57 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 93BDBE000C;
        Thu, 28 Apr 2022 15:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651159015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w3pZXXCT/j4+InWfaqZPrceul+QrUJYTf2Df3YfgcaE=;
        b=hwVY5M8wOr6LJCQF2rxtRmcJgj5iKEMK+6h17lKN1X6DCJI0SIk/Np22kT2dBylap/oShf
        hv94r/4QyLkPrIylFhFEaYtZKE7tsSYeXNe2QZMKKX2Gfdb2EMXe4hPtvxriu2x2UZuTXR
        q1X8ovKeFuqb2h2F+Pz6eX+zgQO50uNe/Sg4ipjsmsuRaE/bKRE+lKeK6jePQafbEWHugt
        KpW8VoFQ2TSyVeJaz9JqcFx4KZNKpXClcaJ69vk/isZbNipulUSy3Y9wfG/MqXVzMW8eeU
        kf0CTEC+XN3IGXDBA+ezszKj9w4W7PlVDXqXmj8w84X8PAtxJEoGbDxBORHeQA==
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
Subject: [PATCH v4 6/6] ARM: dts: r9a06g032: Link the PCI USB devices to the USB PHY
Date:   Thu, 28 Apr 2022 17:16:30 +0200
Message-Id: <20220428151630.586009-7-herve.codina@bootlin.com>
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

Describe the PCI USB devices that are behind the PCI bridge, adding
necessary links to the USB PHY device.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index dd4b1ddd3601..ad04093b01f4 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -120,6 +120,18 @@ pci_usb: pci@40030000 {
 			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH
 					 0x0800 0 0 1 &gic GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH
 					 0x1000 0 0 2 &gic GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+
+			usb@1,0 {
+				reg = <0x800 0 0 0 0>;
+				phys = <&usbphy>;
+				phy-names = "usb";
+			};
+
+			usb@2,0 {
+				reg = <0x1000 0 0 0 0>;
+				phys = <&usbphy>;
+				phy-names = "usb";
+			};
 		};
 
 		uart0: serial@40060000 {
-- 
2.35.1

