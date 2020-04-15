Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3C41AACBD
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 18:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415148AbgDOQBc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Apr 2020 12:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415142AbgDOQB0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Apr 2020 12:01:26 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECE3D208FE;
        Wed, 15 Apr 2020 16:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586966486;
        bh=Whr+LkPvddPEdlzax+7iuEmKEeTaxYdFoa0JhjAYMp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I+6fg/CJTctkQzt5X9MhH3chom+dZFcBbS3wXE82ZJD9pbWepWuch9jt7R1BpISBE
         2f0wyE+t78HFjA2s5qxZAyXjFiyaLADrDwiy7r2vPTIFfIMrmrG+cj2fWNrXw+qXuo
         xEw9Ez+PiABBxv8f10yKG5VcEFDyL0isUG/kp4cQ=
Received: by pali.im (Postfix)
        id 4FA4958E; Wed, 15 Apr 2020 18:01:24 +0200 (CEST)
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
Subject: [PATCH 2/8] dts: espressobin: Define max-link-speed for pcie0
Date:   Wed, 15 Apr 2020 18:00:48 +0200
Message-Id: <20200415160054.951-3-pali@kernel.org>
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

Previously aardvark PCI controller set speed to gen2. Now it reads speed
from Device Tree and as default use maximal possible speed which is gen3.

Because Espressobin has advertised only PCI Express 2.0 capability and
previous value was gen2, define max-link-speed to 2, so there would not be
any configuration change.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index 42e992f9c8a5..6705618162d5 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -47,6 +47,7 @@
 	phys = <&comphy1 0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
+	max-link-speed = <2>;
 };
 
 /* J6 */
-- 
2.20.1

