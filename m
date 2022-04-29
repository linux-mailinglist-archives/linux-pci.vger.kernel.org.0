Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49925514AE7
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 15:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376366AbiD2Np7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 09:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376406AbiD2Npl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 09:45:41 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7420DCD32B;
        Fri, 29 Apr 2022 06:42:17 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id BDF3E1BF214;
        Fri, 29 Apr 2022 13:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651239736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3sbzBzsCcC7x9s3vXEvDzSjrA2nDIAK9IYFPPKABIDw=;
        b=VgmmLpFKEBOrCWjhyHy1u93i2hwuJ9+LJaKQYruUNJ68ZywpJL3NzYzwR8c/vK1ug69DyA
        +cYiBTNzMOsBkjxiLEHs5dYd8A6B3j8+s8RaZTRHYOZYsPfo6lAPnPhE/LNt8wI7ZzPyiD
        nZEVzwb/0ULVSiY7mp+LbA9QH75aoiDC6aH+GE8urnSufnCi1O8izetwLt/nWdnvoV9me1
        JsU2hi6Jj/plNBijhZoD/E41HK8RGpVTU+JaQoyAqepmYQnYfvuH/cm8O9UFqgBG1jOTRH
        RnI42ewV4JIwdMFp2bg/0FqDLz8swiIHWw4JK2kl0XTqcuCqpmyj6xHvOjI17A==
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
Subject: [PATCH v5 6/6] ARM: dts: r9a06g032: Link the PCI USB devices to the USB PHY
Date:   Fri, 29 Apr 2022 15:41:43 +0200
Message-Id: <20220429134143.628428-8-herve.codina@bootlin.com>
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

Describe the PCI USB devices that are behind the PCI bridge, adding
necessary links to the USB PHY device.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 8cedc08ba3b9..db1e35381d9b 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -121,6 +121,18 @@ pci_usb: pci@40030000 {
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

