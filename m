Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A4B1AACE2
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 18:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410162AbgDOQEF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Apr 2020 12:04:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410156AbgDOQED (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Apr 2020 12:04:03 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69D052168B;
        Wed, 15 Apr 2020 16:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586966643;
        bh=rKE2/SNooMgmHtR2VsNRzQH+yzWux+/fvjH+XskA6QQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Mfp0DqsTp7bB3i6hNSeX4j/pQrPGx7wb7QpBZpIuLStNEFqquwdbDr0pFE/ZFYmF
         JTQR+JC4ZD7f0k4POGwbDcfQcw/7T3r2FwOq42P9sa0ODFcE7jTrcM5TsuRGpZ3uf6
         DoU69uPWYzbDft8cDwb8Pl7gHOhTOXM7l0KME+PM=
Received: by pali.im (Postfix)
        id 8CD529CC; Wed, 15 Apr 2020 18:04:01 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 7/8] dts: aardvark: Route pcie reset pin to gpio function and define reset-gpios for pcie
Date:   Wed, 15 Apr 2020 18:03:47 +0200
Message-Id: <20200415160348.1146-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415160054.951-1-pali@kernel.org>
References: <20200415160054.951-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Marvell version of u-boot for Espressobin set pcie reset pin to gpio and
toggle it when initializing u-boot aardvark driver.

To not depend on bootloader version and state of Espressobin HW, route pcie
reset pin to gpio function and define reset-gpios also in kernel. So pcie
aardvark driver can trigger needed reset.

Turris MOX dts file has already defined reset-gpios and configured pcie
reset pin to gpio function, so unify Espressobin and Turris MOX dts files.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi | 1 +
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts   | 4 ----
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi             | 2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index 6705618162d5..8ad4dce280c3 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -48,6 +48,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
 	max-link-speed = <2>;
+	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_LOW>;
 };
 
 /* J6 */
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index bb42d1e6a4e9..e496bd9d4737 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -128,10 +128,6 @@
 	};
 };
 
-&pcie_reset_pins {
-	function = "gpio";
-};
-
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 000c135e39b7..7909c146eabf 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -317,7 +317,7 @@
 
 				pcie_reset_pins: pcie-reset-pins {
 					groups = "pcie1";
-					function = "pcie";
+					function = "gpio";
 				};
 
 				pcie_clkreq_pins: pcie-clkreq-pins {
-- 
2.20.1

