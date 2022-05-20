Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0138052E92A
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 11:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347867AbiETJmz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 05:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347780AbiETJmp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 05:42:45 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDD3149AA1;
        Fri, 20 May 2022 02:42:33 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 5340E1C000E;
        Fri, 20 May 2022 09:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653039752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Psg+kgsloOBducf16xRoRX/ej6BEYer73yn3GaQ0wJU=;
        b=HU+QOG9KiXtb7LHsmePl4nSulWwQG9taejn6I4SqqkSiinP4e2vJmS9iRCCtLZFC9kncnr
        fNZ87F9HLjxaUaO+W+Rr/XFWUzen3FSb+oHewlv3+0bQkOuax9c54LVfuVANQAWUMFcM/2
        hjI3mDU9oZXZLL56Nb6IWVeD+8r49dC3LP3RGxg7JLXS26seDa1ODvivkVrga4TtmV1TUX
        ffCnk5ziJsNj89GDn27+hKwcvBemNUCQ6a5zM/VcMmT7ov5TGm8nBHiAXWHLRaJ0k6iIzb
        021sAlR+DoTUU/932vy+KqdjMI7wpyDe9VqlFA119M/waHOrsKj7TSjZ/lqfXg==
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
Subject: [PATCH v6 5/6] ARM: dts: r9a06g032: Add USB PHY DT support
Date:   Fri, 20 May 2022 11:41:54 +0200
Message-Id: <20220520094155.313784-6-herve.codina@bootlin.com>
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

Define the r9a06g032 generic part of the USB PHY device node.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 45944f849190..8cedc08ba3b9 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -255,4 +255,10 @@ timer {
 			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
 	};
+
+	usbphy: usb-phy {
+		#phy-cells = <0>;
+		compatible = "usb-nop-xceiv";
+		status = "disabled";
+	};
 };
-- 
2.35.1

