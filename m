Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B4745AACB
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 19:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239652AbhKWSJv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 13:09:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239629AbhKWSJu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Nov 2021 13:09:50 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69E5F60FC2;
        Tue, 23 Nov 2021 18:06:42 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mpaBk-007LjH-L4; Tue, 23 Nov 2021 18:06:40 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Luca Ceresoli <luca@lucaceresoli.net>, kernel-team@android.com
Subject: [PATCH v3 2/3] arm64: dts: apple: t8103: Fix PCIe #PERST polarity
Date:   Tue, 23 Nov 2021 18:06:35 +0000
Message-Id: <20211123180636.80558-3-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123180636.80558-1-maz@kernel.org>
References: <20211123180636.80558-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, pali@kernel.org, alyssa@rosenzweig.io, lorenzo.pieralisi@arm.com, bhelgaas@google.com, mark.kettenis@xs4all.nl, luca@lucaceresoli.net, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As the name indicates, #PERST is active low. So fix the DT description
to match the HW behaviour.

Fixes: ff2a8d91d80c ("arm64: apple: Add PCIe node")
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index fc8b2bb06ffe..e22c9433d5e0 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -7,6 +7,7 @@
  * Copyright The Asahi Linux Contributors
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/apple-aic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/apple.h>
@@ -281,7 +282,7 @@ pcie0: pcie@690000000 {
 			port00: pci@0,0 {
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
-				reset-gpios = <&pinctrl_ap 152 0>;
+				reset-gpios = <&pinctrl_ap 152 GPIO_ACTIVE_LOW>;
 				max-link-speed = <2>;
 
 				#address-cells = <3>;
@@ -301,7 +302,7 @@ port00: pci@0,0 {
 			port01: pci@1,0 {
 				device_type = "pci";
 				reg = <0x800 0x0 0x0 0x0 0x0>;
-				reset-gpios = <&pinctrl_ap 153 0>;
+				reset-gpios = <&pinctrl_ap 153 GPIO_ACTIVE_LOW>;
 				max-link-speed = <2>;
 
 				#address-cells = <3>;
@@ -321,7 +322,7 @@ port01: pci@1,0 {
 			port02: pci@2,0 {
 				device_type = "pci";
 				reg = <0x1000 0x0 0x0 0x0 0x0>;
-				reset-gpios = <&pinctrl_ap 33 0>;
+				reset-gpios = <&pinctrl_ap 33 GPIO_ACTIVE_LOW>;
 				max-link-speed = <1>;
 
 				#address-cells = <3>;
-- 
2.30.2

