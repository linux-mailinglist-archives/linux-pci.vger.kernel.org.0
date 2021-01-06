Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1182EBF23
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jan 2021 14:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbhAFNrI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jan 2021 08:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:50868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbhAFNrH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Jan 2021 08:47:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A26F023123;
        Wed,  6 Jan 2021 13:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609940786;
        bh=SGnWKlQo06sg8d+NDOQwaMUesF8OTKiZdb/fFObVA5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ncJTmZ21DQmGZsn4m+g3wTzkU5pB0741DgOAbJxi8KRI0IPZa5BOO73Zf592/XHhQ
         23mN9j9jeFLsNrzneQxFsiwg5taj9LMX1swVTQUZzF5YiXWb3HWjMsVOPMYgBfZo8I
         NUDqkp4rCJdoRIAjrYV/xV6gMxWOLuQmI/ipA/oj0fexSHStn9Mq0x6LLWaK2dMQ+1
         qlNiQ8fZYgo6lxqNdQ13nrvCGtyK/81/1Q2Cd6KpXfQhndh9DJKZvltSAIyyzbJRjU
         RejZTASXj+uxUYzESWxnp65mpMIfaTCeza3g2e8pm23DyeijiJrxbscHHAh44xSj+1
         idQFq5JMv6/vw==
Received: by wens.tw (Postfix, from userid 1000)
        id 6C4CA5FBCB; Wed,  6 Jan 2021 21:46:24 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, Robin Murphy <robin.murphy@arm.com>,
        Johan Jonker <jbx6244@gmail.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 3/4] arm64: dts: rockchip: nanopi4: Move ep-gpios property to nanopc-t4
Date:   Wed,  6 Jan 2021 21:46:16 +0800
Message-Id: <20210106134617.391-4-wens@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106134617.391-1-wens@kernel.org>
References: <20210106134617.391-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Only the NanoPC T4 hs the PCIe reset pin routed to the SoC. For the
NanoPi M4 family, no such signal is routed to the expansion header on
the base board.

As the schematics for the expansion board were not released, it is
unclear how this is handled, but the likely answer is that the signal
is always pulled high.

Move the ep-gpios property from the common nanopi4.dtsi file to the
board level nanopc-t4.dts file. This makes the nanopi-m4 lack ep-gpios,
matching the board design.

A companion patch "PCI: rockchip: make ep_gpio optional" for the Linux
driver is required, as the driver currently requires the property to be
present.

Fixes: e7a095908227 ("arm64: dts: rockchip: Add devicetree for NanoPC-T4")
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts | 1 +
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi  | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
index e0d75617bb7e..452728b82e42 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
@@ -95,6 +95,7 @@ map3 {
 };
 
 &pcie0 {
+	ep-gpios = <&gpio2 RK_PA4 GPIO_ACTIVE_HIGH>;
 	num-lanes = <4>;
 	vpcie3v3-supply = <&vcc3v3_sys>;
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index 76a8b40a93c6..48ed4aaa37f3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -504,7 +504,6 @@ &pcie_phy {
 };
 
 &pcie0 {
-	ep-gpios = <&gpio2 RK_PA4 GPIO_ACTIVE_HIGH>;
 	max-link-speed = <2>;
 	num-lanes = <2>;
 	vpcie0v9-supply = <&vcca0v9_s3>;
-- 
2.29.2

