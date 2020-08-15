Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BD824541B
	for <lists+linux-pci@lfdr.de>; Sun, 16 Aug 2020 00:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgHOWMV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Aug 2020 18:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbgHOWK2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:28 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDA6D20773;
        Sat, 15 Aug 2020 12:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597495886;
        bh=dwHjwC8GiChPu67IbBCb6Ypn7HuxNZ4cqMQsl04lslg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/R4wtUnbTIYAx3BaALrwOrakrpNSuLBsmGVH2WZFIO6EmqnHDgxBjPSx5cu6vn0F
         D4GqHDerBcH7cE1HSubCkreBnggluVbZCvEVAjCaAePCbi5PPdEbJ7tNlgeDs4UEsT
         7+bplO4I190caNSk7lhZGj2Zv6aWWl1GiJsFNcgU=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k6vee-002Kds-BL; Sat, 15 Aug 2020 13:51:24 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, kernel-team@android.com
Subject: [PATCH 2/2] arm64: dts: rockchip: Fix PCIe DT properties
Date:   Sat, 15 Aug 2020 13:51:12 +0100
Message-Id: <20200815125112.462652-3-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200815125112.462652-1-maz@kernel.org>
References: <20200815125112.462652-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com, heiko@sntech.de, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It recently became apparent that the lack of a 'device_type = "pci"'
in the PCIe root complex node for rk3399 is a violation of the PCI
binding, as documented in IEEE Std 1275-1994. Changes to the kernel's
parsing of the DT made such violation fatal, as drivers cannot
probe the controller anymore.

Add the missing property makes the PCIe node compliant. While we
are at it, drop the pointless linux,pci-domain property, which only
makes sense when there are multiple host bridges.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index ada724b12f01..a80fc4d563b5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -231,6 +231,7 @@ pcie0: pcie@f8000000 {
 		reg = <0x0 0xf8000000 0x0 0x2000000>,
 		      <0x0 0xfd000000 0x0 0x1000000>;
 		reg-names = "axi-base", "apb-base";
+		device_type = "pci";
 		#address-cells = <3>;
 		#size-cells = <2>;
 		#interrupt-cells = <1>;
@@ -249,7 +250,6 @@ pcie0: pcie@f8000000 {
 				<0 0 0 2 &pcie0_intc 1>,
 				<0 0 0 3 &pcie0_intc 2>,
 				<0 0 0 4 &pcie0_intc 3>;
-		linux,pci-domain = <0>;
 		max-link-speed = <1>;
 		msi-map = <0x0 &its 0x0 0x1000>;
 		phys = <&pcie_phy 0>, <&pcie_phy 1>,
-- 
2.27.0

