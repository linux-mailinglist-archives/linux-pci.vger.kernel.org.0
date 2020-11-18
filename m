Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA5D2B76C4
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 08:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgKRHRf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 02:17:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgKRHRf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 02:17:35 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 214002223D;
        Wed, 18 Nov 2020 07:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605683854;
        bh=VyAejFb2EqXRXHkA5q6udJdyr3L4QQLG2oyoewoKR0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KsaRGMUQauyvl8NNreR0qukDZHZi99mssukp+kYZvXjxs+v7NIas1XTsqui98laES
         Cff1S6602tqQr1yzKztvxwGLpvSkewlalseP+ElbPahDFx84M4lFQ8uVTRQsZpW/U+
         jIH0fVYL/mZ9K+LwYNB9trFynqI6YA6VYk+FYmKk=
Received: by wens.tw (Postfix, from userid 1000)
        id 982CE5FD44; Wed, 18 Nov 2020 15:17:31 +0800 (CST)
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
Subject: [PATCH v2 3/4] arm64: dts: rockchip: nanopi4: Move ep-gpios property to nanopc-t4
Date:   Wed, 18 Nov 2020 15:17:23 +0800
Message-Id: <20201118071724.4866-4-wens@kernel.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201118071724.4866-1-wens@kernel.org>
References: <20201118071724.4866-1-wens@kernel.org>
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
2.29.1

