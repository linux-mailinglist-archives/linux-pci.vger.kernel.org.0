Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6F235C676
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 14:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbhDLMlv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 08:41:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241214AbhDLMls (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Apr 2021 08:41:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36F7B61027;
        Mon, 12 Apr 2021 12:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618231290;
        bh=YoBNM0KK19yBjUA1qlzbhAxnoNZZQ7sS/n3u78ikZp0=;
        h=From:To:Cc:Subject:Date:From;
        b=Yml25TxioqYez+uY+20afQzLsEqRkAB4h4AN71BcxIvosxAidQlMAzXWp160/XLRX
         QWJvrvkQyzv7ViamRKfCecbXMBD2+pJI9m+162cTsXLvfOYn8agY4r8ElKOvr5REdT
         NNG+kyWNRyFVXeW2NyAyOs5KLiYVvXI44qvNZlEa/dbLzbchTd9Qzgi5+CAkJMfcio
         bNqHlNreAjz3ubfAsB9oCqQxuJ08jzXJhhWoX2EaEf41NijQeCbqhjk3HB+qq7QnsV
         InJ5cjYi/4Ef9Fisy2oluXaqF7gR5G3aypLbHL/Ts2llPjiTKGuRytiJ9o/l/54JHm
         Wo2w5skXiTbKA==
Received: by pali.im (Postfix)
        id 160A7687; Mon, 12 Apr 2021 14:41:28 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH] arm64: dts: marvell: armada-37xx: Set linux,pci-domain to zero
Date:   Mon, 12 Apr 2021 14:39:36 +0200
Message-Id: <20210412123936.25555-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit 526a76991b7b ("PCI: aardvark: Implement driver 'remove'
function and allow to build it as module") PCIe controller driver for
Armada 37xx can be dynamically loaded and unloaded at runtime. Also driver
allows dynamic binding and unbinding of PCIe controller device.

Kernel PCI subsystem assigns by default dynamically allocated PCI domain
number (starting from zero) for this PCIe controller every time when device
is bound. So PCI domain changes after every unbind / bind operation.

Alternative way for assigning PCI domain number is to use static allocated
numbers defined in Device Tree. This option has requirement that every PCI
controller in system must have defined PCI bus number in Device Tree.

Armada 37xx has only one PCIe controller, so assign for it PCI domain 0 in
Device Tree.

After this change PCI domain on Armada 37xx is always zero, even after
repeated unbind and bind operations.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 526a76991b7b ("PCI: aardvark: Implement driver 'remove' function and allow to build it as module")
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 7a2df148c6a3..f02058ef5364 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -495,6 +495,7 @@
 					<0 0 0 2 &pcie_intc 1>,
 					<0 0 0 3 &pcie_intc 2>,
 					<0 0 0 4 &pcie_intc 3>;
+			linux,pci-domain = <0>;
 			max-link-speed = <2>;
 			phys = <&comphy1 0>;
 			pcie_intc: interrupt-controller {
-- 
2.20.1

