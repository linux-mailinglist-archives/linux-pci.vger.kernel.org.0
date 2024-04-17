Return-Path: <linux-pci+bounces-6365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C828A8911
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 18:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B0C1C2219C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 16:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0018E146A73;
	Wed, 17 Apr 2024 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBwFRqeM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA70E12C819;
	Wed, 17 Apr 2024 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372154; cv=none; b=CAvLZpTks2H+PDWuUJzh9ZQhjzQfeWmRd4jTVk704o6he11dZ7hpnz2xRzpknhEnnBRPuMbDvrAfDI+SSWvDE+d1KLSeZqW4kZNEspZVoiZOAUmCWZhwffnhJD2fhE2VpY5my3RucGwAPnzS+l9GCT7NBn1F2+6d/w6Qd/G/RGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372154; c=relaxed/simple;
	bh=bFAV0Ws7047o+4oNJQ9VEZqnv8b/ertE1ngvFBcZ5F8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=poCi3OqVVl4u+eU7OI4/As9C+gLtgXCqUdgVbU2t24E8549vg3k6EnZJyhxxUUanoqXaK2D8u+gChwrzzQiqJkdUYz7P8979cryJK/b1hN2zjhlikUhAnJmJD8E2J3hbrQ2q7yiXl9vweRZ7C54IvhSDs7aHx73dLwJLWtN6imA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBwFRqeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E26C072AA;
	Wed, 17 Apr 2024 16:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713372154;
	bh=bFAV0Ws7047o+4oNJQ9VEZqnv8b/ertE1ngvFBcZ5F8=;
	h=From:To:Cc:Subject:Date:From;
	b=TBwFRqeMg7Ol1u9QdhO34wpSKv7pLxDHJHtAELzYbIp83gCMM9ocBL3jxlaZifLtN
	 mUNC+O9HXbY3nBTWFp1nmnJkNCkRxNL6a5iTVdaiO0W6sYUDAuew/kiccCdkyRmMo7
	 p/V2C5FywN04TaQ0w68KK8UtdFIOPx80cYut1oIZw2k0idf1YCOjEmqNrHYtzsu69r
	 wni2xPLCvJ50i+pU5Aa1GMz0sofNT/2YPMiM202+aQKPCcQ2s3TrK2Nwh5RhQ2rDuW
	 mqIexugp3M8ScTz+p8mKODdGF074M0Tp1wU1YFKb5VkaYgYSg6W1RSgmlPwMzQ5JrM
	 JyA4K+jf2g8eQ==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Simon Xue <xxm@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	stable@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v3] PCI: dw-rockchip: Fix initial PERST# GPIO value
Date: Wed, 17 Apr 2024 18:42:26 +0200
Message-ID: <20240417164227.398901-1-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PERST# is active low according to the PCIe specification.

However, the existing pcie-dw-rockchip.c driver does:
gpiod_set_value(..., 0); msleep(100); gpiod_set_value(..., 1);
When asserting + deasserting PERST#.

This is of course wrong, but because all the device trees for this
compatible string have also incorrectly marked this GPIO as ACTIVE_HIGH:
$ git grep -B 10 reset-gpios arch/arm64/boot/dts/rockchip/rk3568*
$ git grep -B 10 reset-gpios arch/arm64/boot/dts/rockchip/rk3588*

The actual toggling of PERST# is correct.
(And we cannot change it anyway, since that would break device tree
compatibility.)

However, this driver does request the GPIO to be initialized as
GPIOD_OUT_HIGH, which does cause a silly sequence where PERST# gets
toggled back and forth for no good reason.

Fix this by requesting the GPIO to be initialized as GPIOD_OUT_LOW
(which for this driver means PERST# asserted).

This will avoid an unnecessary signal change where PERST# gets deasserted
(by devm_gpiod_get_optional()) and then gets asserted
(by rockchip_pcie_start_link()) just a few instructions later.

Before patch, debug prints on EP side, when booting RC:
[  845.606810] pci: PERST# asserted by host!
[  852.483985] pci: PERST# de-asserted by host!
[  852.503041] pci: PERST# asserted by host!
[  852.610318] pci: PERST# de-asserted by host!

After patch, debug prints on EP side, when booting RC:
[  125.107921] pci: PERST# asserted by host!
[  132.111429] pci: PERST# de-asserted by host!

This extra, very short, PERST# assertion + deassertion has been reported
to cause issues with certain WLAN controllers, e.g. RTL8822CE.

Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: stable@vger.kernel.org	# 5.15+
---
Changes since v2:
-Picked up tag from Heiko.
-Change subject (Bjorn).
-s/PERST/PERST#/ (Bjorn).

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index d6842141d384..a909e42b4273 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -240,7 +240,7 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
 		return PTR_ERR(rockchip->apb_base);
 
 	rockchip->rst_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
-						     GPIOD_OUT_HIGH);
+						     GPIOD_OUT_LOW);
 	if (IS_ERR(rockchip->rst_gpio))
 		return PTR_ERR(rockchip->rst_gpio);
 
-- 
2.44.0


