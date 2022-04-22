Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D4A50B6E5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 14:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447409AbiDVMM0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 08:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447352AbiDVMMT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 08:12:19 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D0556748;
        Fri, 22 Apr 2022 05:09:17 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 917A324000D;
        Fri, 22 Apr 2022 12:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650629356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XbK44txh6IJgMhR0iqajJG2j4qqD92+Fo56+QPX8QcE=;
        b=KECf+/7Wd1/QIsrDcWeboFzTAPhA3ftm+NTasE4Z5fSj6+sINRsYvSrGWR6RixDs8/XM70
        3IaF5z9Oufi02jpY30BefsYFEfIBgCuUoL2gp80ome4RqOAM71HSc6YC4m+uT5t8gtHReH
        2hEPq4n/zzQSUQXvKglbpa0RDf4N/DN9o0ND4h1eCw0Bm4hKTcqyNtJTchjG0WP3mJOPAK
        c8A2dpMQzklTBaGb2ULx/WqaN8BEHHBrDe6aJLpBXuF64LoyUsdAgD/EMiOI+QCjbgdAPT
        OlmD0eRyytrjYmf4cy9KGUWe9TsVuDCxMAS3KaFAsuf6fPJ+imNJGBkksEc7+w==
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
Subject: [PATCH v3 7/8] ARM: dts: r9a06g032: Add USB PHY DT support
Date:   Fri, 22 Apr 2022 14:08:49 +0200
Message-Id: <20220422120850.769480-8-herve.codina@bootlin.com>
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

Define the r9a06g032 generic part of the USB PHY device node.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 33581f0c55c4..58af07eb75c9 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -59,6 +59,12 @@ ext_rtc_clk: extrtcclk {
 		clock-frequency = <0>;
 	};
 
+	usbphy: usbphy {
+		#phy-cells = <0>;
+		compatible = "usb-nop-xceiv";
+		status = "disabled";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.35.1

