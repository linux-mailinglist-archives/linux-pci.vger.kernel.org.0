Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C2E1B7A1D
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 17:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgDXPjZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 11:39:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbgDXPjY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 11:39:24 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E8BF2168B;
        Fri, 24 Apr 2020 15:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587742764;
        bh=dkqvXTL9+Vx5TfVq+Qm+IxU+y+qPkG/crH1tOtt/POg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aIWv5h64+oCiCv3jcQR3ilzhnB/bU+2LpUy1mqatddfn0yavcIqhoMgGM1rVTpgaD
         gBMFWLlqMiNx/gKuRaF3ndNPkKVyhLV604cZhnHBp3dqaL8Cedn126+8IgcxkhtED/
         RBzHfUEqjSsLBAIcZOcPnvHArubjZtg4BWzSfM/4=
Received: by pali.im (Postfix)
        id 670EAA47; Fri, 24 Apr 2020 17:39:22 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v3 11/12] arm64: dts: marvell: armada-37xx: Move PCIe comphy handle property
Date:   Fri, 24 Apr 2020 17:38:57 +0200
Message-Id: <20200424153858.29744-12-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424153858.29744-1-pali@kernel.org>
References: <20200424153858.29744-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Behún <marek.behun@nic.cz>

Move the comphy handle property of the PCIe node from board specific
device tree files (EspressoBin and Turris Mox) to the generic
armada-37xx.dtsi.

This is correct since this is the only possible PCIe PHY configuration
on Armada 37xx, so when PCIe is enabled on any board, this handle is
correct.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi | 1 -
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts   | 1 -
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi             | 1 +
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index c92ad664cb0e..b97218c72727 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -44,7 +44,6 @@
 /* J9 */
 &pcie0 {
 	status = "okay";
-	phys = <&comphy1 0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
 	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index e496bd9d4737..15c1cf5c5b69 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -134,7 +134,6 @@
 	status = "okay";
 	max-link-speed = <2>;
 	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_LOW>;
-	phys = <&comphy1 0>;
 
 	/* enabled by U-Boot if PCIe module is present */
 	status = "disabled";
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 7909c146eabf..5aaad64a793d 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -493,6 +493,7 @@
 					<0 0 0 2 &pcie_intc 1>,
 					<0 0 0 3 &pcie_intc 2>,
 					<0 0 0 4 &pcie_intc 3>;
+			phys = <&comphy1 0>;
 			pcie_intc: interrupt-controller {
 				interrupt-controller;
 				#interrupt-cells = <1>;
-- 
2.20.1

