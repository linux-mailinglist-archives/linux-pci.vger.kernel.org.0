Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BCF50B6EB
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 14:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447378AbiDVMMU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 08:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447361AbiDVMMM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 08:12:12 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DEC5674C;
        Fri, 22 Apr 2022 05:09:12 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id B1F8F240005;
        Fri, 22 Apr 2022 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650629351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9l0fpzW+GOBekslO/DSF/fbtC1vCLVpdy5BP8RZmKOg=;
        b=nHT/rNHy1RHPVZZacg5BfoAHTPqmn2AZxFR/4mCRGxCRqEUTqP1iE/IY88wHWZczY9n2Pc
        349p+1tkzFwdnWorA4a3X83QHV5C0kDQ+Xi7nSSbS0JB4F+hjbIeCmkNzCoLu2EnqXUVZG
        Wt+ABQA5afuAdFacRz0MzZjaU3PIw6kmbsR6ehHFNWpVYSySuIT41GHIrOl5+tn3r9Mz1w
        drUBhnZOT4z3ZhVkW9KZbH2/Nv88NineP4OD/N2NZMb0maB3zvG5z8KM9jN/kca7yDR6Hx
        fHx8QXRGryf/xDJnBHzf4o+VsCBKEHzs3vb00c7O7nbiudfZpOIPaF5AZB48nQ==
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
Subject: [PATCH v3 5/8] ARM: dts: r9a06g032: Add missing '#power-domain-cells'
Date:   Fri, 22 Apr 2022 14:08:47 +0200
Message-Id: <20220422120850.769480-6-herve.codina@bootlin.com>
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

Without '#power-domain-cells' property, power-domains cannot
be used. This property is noted required in the device-tree
binding.

Add '#power-domain-cells' as needed.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 636a6ab31c58..20286433d3c6 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -87,6 +87,7 @@ sysctrl: system-controller@4000c000 {
 			reg = <0x4000c000 0x1000>;
 			status = "okay";
 			#clock-cells = <1>;
+			#power-domain-cells = <0>;
 
 			clocks = <&ext_mclk>, <&ext_rtc_clk>,
 					<&ext_jtag_clk>, <&ext_rgmii_ref>;
-- 
2.35.1

