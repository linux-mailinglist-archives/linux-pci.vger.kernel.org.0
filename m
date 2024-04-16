Return-Path: <linux-pci+bounces-6313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA268A6A80
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 14:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AF3DB213CE
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 12:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E7C129A7C;
	Tue, 16 Apr 2024 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rW/qkeIY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF85D1DFEF;
	Tue, 16 Apr 2024 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269736; cv=none; b=KnOo56swCKDXxbE/vaUfGYkddNtt/wySK92J87mU0VZWTK3YeF26KEcIFH7WB2NNUtdFOrkoupxqsg3rtJ+rQUugfJBwPqpwSkKZC8Zm7JJbqD1SHQjw5/aF5CnkVbigIQKC3s3vJu0BufXJt2/sEAS1nBZaNmNhjn6PVJc0RSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269736; c=relaxed/simple;
	bh=SsSBFhRirmI4fPYdokVk1LbHjQvwbxzXq61XZknFRl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CWbPgfLTiKZ0IRHax8/oiYTUQvyzsKnGBKbCrAvkjkYK5S6f3DSKonLJxLja1dWOuhcR5kDE1L9mKFEVSfxsAUD6gkgd/uF0SwJw56KfTCY8db3KpB7+4snb9PJiVFEpLk6QBsv5szeuOs7G2XNhUREu4GecOvnn3rESbNxBEGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rW/qkeIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF6EC113CE;
	Tue, 16 Apr 2024 12:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713269734;
	bh=SsSBFhRirmI4fPYdokVk1LbHjQvwbxzXq61XZknFRl4=;
	h=From:To:Cc:Subject:Date:From;
	b=rW/qkeIYdk4GTSCDEQHobkSF5Vf+gaHeeRnF3VEkeYxMNY/eLOglalPQaFBUJ6ntO
	 ZBcJBTjzVMTylUl6aQl16KBW56ZEdm2s3GNN9oJWoR1z7jrO9ldQ+fkuVD2fp3nnFJ
	 3z2CrmKW9SqRsPMNs/WXCvDSFNQoVZU9z2/u7N80NPESk3GuUKXobgGDWvGN+cyIko
	 PoxmUiwy1dzXGL0JdwHNRWMVwEKRAmAYv1HLdmdqkL4+hQmY2KwU67LcvSyZC7dp6k
	 oc5FRLpGJu/cgWedpgFsNE8AEEkrUyy+GUbujdt/q0SqGhIq5mYBxzOKAh0L9HZ/2M
	 +Y18nNUTczMrQ==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Simon Xue <xxm@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	stable@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2] PCI: dw-rockchip: Fix GPIO initialization flag
Date: Tue, 16 Apr 2024 14:15:22 +0200
Message-ID: <20240416121522.269972-1-cassel@kernel.org>
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

This extra, very short, PERST assertion + deassertion has been reported
to cause issues with certain WLAN controllers, e.g. RTL8822CE.

Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: stable@vger.kernel.org	# 5.15+
---
Changes since V1:
-Picked up tags.
-CC stable.
-Clarified commit message.

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


