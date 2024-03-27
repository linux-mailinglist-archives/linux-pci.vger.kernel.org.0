Return-Path: <linux-pci+bounces-5267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3848E88E945
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 16:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D601C305C4
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 15:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180F5130A6A;
	Wed, 27 Mar 2024 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NloO5XQe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A4112EBD9
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553153; cv=none; b=L5YFakSp5eyVcJalY/tINgS5ZNOwxPMrLJmj6a4BKcn3n3fl5Fo98OWsTvgk+wd/ElWqvJAEXi9gCiEhrH12DAK3Q0faVfrfPws2WfkX44fT4C2HFOazsjMrWhRwRvhNMuz/5Ef6Wrh7+XlgW2j/Iq+nccBtbdGMGa2w1zVlon0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553153; c=relaxed/simple;
	bh=dGmNJUYMEAgIGXcXDQuvxQkj9FZH9bA/obVm82Yz5Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rCOTE0ZLvmVk/fWDjXfdFeBXRHVXmgrCYv9zwvelxWlD5LGNfZkIVB/F1Swcpt2f7m7ekAgnRBa5iWHwDMPMugO8SRUzTzwTtUkEGSVQTzUpThNABCH/Hyu9VZIFY6iwNACMvWUezVBBtsZ78pMS/Nk3QH6E/l7+rTebRAzC6DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NloO5XQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475ACC433F1;
	Wed, 27 Mar 2024 15:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711553152;
	bh=dGmNJUYMEAgIGXcXDQuvxQkj9FZH9bA/obVm82Yz5Qc=;
	h=From:To:Cc:Subject:Date:From;
	b=NloO5XQeL2rnPrSX7ywh3J2UFHPlPxcas9SPK+F68lvzqVQhX6nd2yL1Pj73EVTEf
	 R6INpv0kc3AFTSMR2N1MT8h+GBNdf+qY7cGujbleXHax+CQBvP/Fb9P3xtoHXnVLbh
	 BiiheD47m9UUeKPpb3poVHnGiAZx+XApXqatIHTSTrkdWa6dSLFk0H0zBQEZEcIeFr
	 9XgdjUX18J+1nIDAMqQr4oC8FxvAfVPMqKPScqrmgTecWvEB7KE3v7Ye6RCeVCv1gc
	 Os6OL6XjGL8A/UiDD1gOecufZaJfxZZ9UcyU4sYuAYYo7Z3bt9v2fCWcUDubDMGMrv
	 aQ1PO0tiQs9dQ==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH] PCI: dw-rockchip: Fix GPIO initialization flag
Date: Wed, 27 Mar 2024 16:25:31 +0100
Message-ID: <20240327152531.814392-1-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PERST is active low according to the PCIe specification.

However, the existing pcie-dw-rockchip.c driver does:
gpiod_set_value(..., 0); msleep(100); gpiod_set_value(..., 1);
When asserting + deasserting PERST.

This is of course wrong, but because all the device trees for this
compatible string have also incorrectly marked this GPIO as ACTIVE_HIGH:
$ git grep -B 10 reset-gpios arch/arm64/boot/dts/rockchip/rk3568*
$ git grep -B 10 reset-gpios arch/arm64/boot/dts/rockchip/rk3588*

The actual toggling of PERST is correct.
(And we cannot change it anyway, since that would break device tree
compatibility.)

However, this driver does request the GPIO to be initialized as
GPIOD_OUT_HIGH, which does cause a silly sequence where PERST gets
toggled back and forth for no good reason.

Fix this by requesting the GPIO to be initialized as GPIOD_OUT_LOW
(which for this driver means PERST asserted).

This will avoid an unnecessary signal change where PERST gets deasserted
(by devm_gpiod_get_optional()) and then gets asserted
(by rockchip_pcie_start_link()) just a few instructions later.

Before patch, debug prints on EP side, when booting RC:
[  845.606810] pci: PERST asserted by host!
[  852.483985] pci: PERST de-asserted by host!
[  852.503041] pci: PERST asserted by host!
[  852.610318] pci: PERST de-asserted by host!

After patch, debug prints on EP side, when booting RC:
[  125.107921] pci: PERST asserted by host!
[  132.111429] pci: PERST de-asserted by host!

Without this change, there is no guarantee that PERST will be asserted
while the core is performing a fundamental reset.
(E.g. if the bootloader would leave PERST deasserted.)

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
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


