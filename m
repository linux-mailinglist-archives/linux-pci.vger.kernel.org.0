Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8632FF023
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 17:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387816AbhAUQYP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 11:24:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387763AbhAUQYM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jan 2021 11:24:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DC1C21919;
        Thu, 21 Jan 2021 16:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611246211;
        bh=TxPC2i3KodVBMcUvSfNNM7XR6HBVjld0zlamfiLWJnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=suZIrn0sZe9LWunctXBnZBJmxA9qNDHr7PBhkgdM2BMTFF9PdaFlY0qzKOPauf8Xu
         9njbqikLLV3m4lsOwd7Kh3ZkqV6Wzf1JgshZKHCYOwTId/beAo3hD5Tt3AiQN6LFZ5
         WUzy0Y/yQy1ImySW9zo+n+QT8HoWY8UsZeofDCITrYL8cwO3yLzlafqlN6CNhUUPEG
         mWQOxKvlOk+DcrB5gt+PECxEWZP9UAIfUTULp6MuhXWZfe0T0SYoSK19Fy2HKshkMK
         UM4SxLGzimyEzj38vvF0SQSTGoLOkS6nFjLHPpWDBwykHBVUJ/J9wQdCTxXgImfO6j
         l6tau4ERZezLQ==
Received: by wens.tw (Postfix, from userid 1000)
        id 9F07D5FBD6; Fri, 22 Jan 2021 00:23:28 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Johan Jonker <jbx6244@gmail.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 1/4] PCI: rockchip: Make 'ep-gpios' DT property optional
Date:   Fri, 22 Jan 2021 00:23:18 +0800
Message-Id: <20210121162321.4538-2-wens@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121162321.4538-1-wens@kernel.org>
References: <20210121162321.4538-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The Rockchip PCIe controller DT binding clearly states that 'ep-gpios' is
an optional property. And indeed there are boards that don't require it.

Make the driver follow the binding by using devm_gpiod_get_optional()
instead of devm_gpiod_get().

Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support")
Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC driver")
Fixes: 964bac9455be ("PCI: rockchip: Split out rockchip_pcie_parse_dt() to parse DT")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Changes since v3:
  - Directly return dev_err_probe() instead of having a separate return
    statement

Changes since v2:
  - Fix error message for failed GPIO

Changes since v1:
  - Rewrite subject to match existing convention and reference
    'ep-gpios' DT property instead of the 'ep_gpio' field
---
 drivers/pci/controller/pcie-rockchip.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 904dec0d3a88..a2ad0b7614a4 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -118,11 +118,10 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 	}
 
 	if (rockchip->is_rc) {
-		rockchip->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
-		if (IS_ERR(rockchip->ep_gpio)) {
-			dev_err(dev, "missing ep-gpios property in node\n");
-			return PTR_ERR(rockchip->ep_gpio);
-		}
+		rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep", GPIOD_OUT_HIGH);
+		if (IS_ERR(rockchip->ep_gpio))
+			return dev_err_probe(dev, PTR_ERR(rockchip->ep_gpio),
+					     "failed to get ep GPIO\n");
 	}
 
 	rockchip->aclk_pcie = devm_clk_get(dev, "aclk");
-- 
2.29.2

