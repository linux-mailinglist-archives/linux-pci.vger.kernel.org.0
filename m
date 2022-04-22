Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEB850B6F1
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 14:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447422AbiDVMM2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 08:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447376AbiDVMMU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 08:12:20 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6D156764;
        Fri, 22 Apr 2022 05:09:19 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 26BAA240008;
        Fri, 22 Apr 2022 12:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650629358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eAmUY6poiqDINT9jc4YZdKTXBn0uAtKS+NvA7rwB+54=;
        b=Z0EW5dCQBO22vHZW458iiLO0S0MdG8ZN4GIV0lExa601vVH9/ukxpHAh3umnFRV1l6KGk9
        x/PxtEGspIXKgKcS5hC/tyGXAGr37IblUqTRu8Pjvgc9D1Es30PZ5kE8N3P4Hs/W5FvnjP
        or83R5yOpRzNlJ/mSBSA23jACwtVYdQE2ZNrqAuUsmdPloHB2Jn9/VZg5cf0Ozk3dwTHIa
        iAf1ZV0bY/EHU3XlS+oT9aABtXo/2AS4PwTrX7LytkErOPAgj5RyIhsSiDeJ8x35HmkagU
        6Uchj8i62D3uzAumFl61Q7HAEtGkRS6uPl9AjsJSyuxFhn8SBf7aJ/NfNFOLUA==
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
Subject: [PATCH v3 8/8] ARM: dts: r9a06g032: Link the PCI USB devices to the USB PHY
Date:   Fri, 22 Apr 2022 14:08:50 +0200
Message-Id: <20220422120850.769480-9-herve.codina@bootlin.com>
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

Describe the PCI USB devices that are behind the PCI bridge, adding
necessary links to the USB PHY device.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 58af07eb75c9..8dc50c09ac65 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -246,6 +246,18 @@ pci_usb: pci@40030000 {
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
 	};
 
-- 
2.35.1

