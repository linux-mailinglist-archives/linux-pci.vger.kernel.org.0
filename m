Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874FA46B271
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 06:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhLGFjA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 00:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbhLGFi6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 00:38:58 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76156C061746;
        Mon,  6 Dec 2021 21:35:28 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 865B94218A;
        Tue,  7 Dec 2021 05:35:24 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Marc Zyngier <maz@kernel.org>, Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [PATCH] arm64: dts: apple: t8103: Remove PCIe max-link-speed properties
Date:   Tue,  7 Dec 2021 14:34:58 +0900
Message-Id: <20211207053458.17777-1-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The driver doesn't support these, they shouldn't be in the SoC include
anyway, and we're now configuring this in the bootloader instead. This
also solves the j274 1G/10G Ethernet variant discrepancy, since that
will now be configured properly based on the dynamic ADT property.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 15ee8c8c5fa0..8d1628e0b0c7 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -412,7 +412,6 @@ port00: pci@0,0 {
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				reset-gpios = <&pinctrl_ap 152 0>;
-				max-link-speed = <2>;
 
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -432,7 +431,6 @@ port01: pci@1,0 {
 				device_type = "pci";
 				reg = <0x800 0x0 0x0 0x0 0x0>;
 				reset-gpios = <&pinctrl_ap 153 0>;
-				max-link-speed = <2>;
 
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -452,7 +450,6 @@ port02: pci@2,0 {
 				device_type = "pci";
 				reg = <0x1000 0x0 0x0 0x0 0x0>;
 				reset-gpios = <&pinctrl_ap 33 0>;
-				max-link-speed = <1>;
 
 				#address-cells = <3>;
 				#size-cells = <2>;
-- 
2.33.0

