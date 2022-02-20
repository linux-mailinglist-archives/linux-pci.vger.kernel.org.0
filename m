Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF1F4BD107
	for <lists+linux-pci@lfdr.de>; Sun, 20 Feb 2022 20:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244643AbiBTTev (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Feb 2022 14:34:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244650AbiBTTeu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Feb 2022 14:34:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEBB4507B
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 11:34:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05E20B80DB9
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 19:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6531C340F4;
        Sun, 20 Feb 2022 19:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645385666;
        bh=ZNWNaU1yRufcytNamVc+70zVVNq3PoXY1dd+WKgLIuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYJaGg73fRGiqpvX5lSI3V4QhHPb4EVATJbJzzfNqXicLSbxTVX2iE+fH3aWcTK/Y
         qAG3LXZ0j/UMJvV7o8uWftpxcmR8EcmzMX+1Xx1i6J/tBLkYtyoHpgG7hgt5DWG+ZO
         UZ+VLZMehsy6j+03awhVro24RDiKcGofnaOx4T8H24K67MJsZFDJ+gS/K/BJsE26x6
         WUMK5D3TmN8xHlInnG7Xpl3UEY00kRDgTeGmSbQNJi5e5WbJiBShpNQcx0SdHwFF9Y
         UEcZzuDNhbvPdGEnIdjTehZEjCa+44iWU8VBFNG29htiTNfw29+1egW2dsEQoHLzoJ
         sbwcE16TSbvEw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 15/18] arm64: dts: marvell: armada-37xx: Add clock to PCIe node
Date:   Sun, 20 Feb 2022 20:33:43 +0100
Message-Id: <20220220193346.23789-16-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220193346.23789-1-kabel@kernel.org>
References: <20220220193346.23789-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The clock binding documents PCIe clock for a long time already. Add
clock phande into the PCIe node.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 673f4906eef9..c0de8d10e58c 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -489,6 +489,7 @@ pcie0: pcie@d0070000 {
 			bus-range = <0x00 0xff>;
 			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 			#interrupt-cells = <1>;
+			clocks = <&sb_periph_clk 13>;
 			msi-parent = <&pcie0>;
 			msi-controller;
 			/*
-- 
2.34.1

