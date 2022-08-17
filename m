Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4755979F0
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 01:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242016AbiHQXDk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 19:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiHQXDj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 19:03:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED94A5708;
        Wed, 17 Aug 2022 16:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FE4C60F60;
        Wed, 17 Aug 2022 23:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A846DC43470;
        Wed, 17 Aug 2022 23:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660777415;
        bh=KZLubd2ER143QJviW3BMyWdDW8TOYgbY/8Bd6Py8KhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DVauo0+sNwDDiDjJkbu0qgyk4GO5MzrJwxg5Wh85uF4lhGNiMGNXkaUBqqL48N8yN
         a9E1iYxbHChar95PxG+i/BnKheJ4tr9fvbkqGTzIGEOTf55c1r9xm8Ij4d1i2AMDJ4
         tX2JFDCxsxqmLQB56mBzT1sIWS941fVg3Gtmkh7cOYzHFCXH904N3Hghkh1VoVpkkj
         aiiNZ+H3z8uI/4yAPGNoOfnMxOii/CdbZbLsAuB+Iep51MbbH3p6w+Fng/PVvI9mhc
         Hu3oKJNKnG4tbLwpvTceXHSTKAFfMPBopQ+Pwvs3ygTaSUkZoLEK+GJdcge9QxOH1v
         OyBA6GmI+4pqw==
Received: by pali.im (Postfix)
        id 6267977A; Thu, 18 Aug 2022 01:03:35 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] ARM: dts: dove: Add definitions for PCIe error interrupts
Date:   Thu, 18 Aug 2022 01:00:36 +0200
Message-Id: <20220817230036.817-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220817230036.817-1-pali@kernel.org>
References: <20220817230036.817-1-pali@kernel.org>
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

First PCIe controller on Dove SoC reports error interrupt via IRQ 15
and second PCIe controller via IRQ 17.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/dove.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 70d45d2b1258..9aee3cfd3e98 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -122,8 +122,8 @@
 				bus-range = <0x00 0xff>;
 
 				#interrupt-cells = <1>;
-				interrupt-names = "intx";
-				interrupts = <16>;
+				interrupt-names = "intx", "error";
+				interrupts = <16>, <15>;
 				interrupt-map-mask = <0 0 0 7>;
 				interrupt-map = <0 0 0 1 &pcie0_intc 0>,
 						<0 0 0 2 &pcie0_intc 1>,
@@ -151,8 +151,8 @@
 				bus-range = <0x00 0xff>;
 
 				#interrupt-cells = <1>;
-				interrupt-names = "intx";
-				interrupts = <18>;
+				interrupt-names = "intx", "error";
+				interrupts = <18>, <17>;
 				interrupt-map-mask = <0 0 0 7>;
 				interrupt-map = <0 0 0 1 &pcie1_intc 0>,
 						<0 0 0 2 &pcie1_intc 1>,
-- 
2.20.1

