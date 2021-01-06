Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F19D2EBF2C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jan 2021 14:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbhAFNrJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jan 2021 08:47:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbhAFNrH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Jan 2021 08:47:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A13AC23122;
        Wed,  6 Jan 2021 13:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609940786;
        bh=XD4KOQ/rP8RIBZGRRQa+2iWBuRRUBOqeoHg48inz8OI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tlr6Pvqxj2kK3acALn0W8ypJ/FllP+6V+SUZmRRWiqCXfTUo2U3mO6adiM8P407U+
         1fILbXiuAcbPUSA8YTd6CWZaOlpfGyKSHQDlfP07QDT8ovvvClL/8GEcFDt6bGHIeo
         gY3OQzHpscGdiFHExP/dgLbqTNpTcdLbEfkg8x5y9nmtcuI/xbnU2SEdx0lhpuCnRs
         fn+fmr1kTu+xYNn1jGcDZRcuPdgJ3ogSqHAMgVjx5v/Y3JWrQrx3nwn9E1niBBrIJN
         GuJ2Ly+3SSqlHBCkhPevfflVNEbwrn+DHJ9jsEKJIu1EvvOvWWj3ly6cxgQfGk+0pd
         pI9RqsZiMqxZg==
Received: by wens.tw (Postfix, from userid 1000)
        id 5C1C55F7EF; Wed,  6 Jan 2021 21:46:24 +0800 (CST)
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
Subject: [PATCH v3 1/4] PCI: rockchip: Make 'ep-gpios' DT property optional
Date:   Wed,  6 Jan 2021 21:46:14 +0800
Message-Id: <20210106134617.391-2-wens@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106134617.391-1-wens@kernel.org>
References: <20210106134617.391-1-wens@kernel.org>
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
Heiko, I dropped you reviewed-by due to the error message change

Changes since v2:
  - Fix error message for failed GPIO

Changes since v1:
  - Rewrite subject to match existing convention and reference
    'ep-gpios' DT property instead of the 'ep_gpio' field
---
 drivers/pci/controller/pcie-rockchip.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 904dec0d3a88..90c957e3bc73 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -118,9 +118,10 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 	}
 
 	if (rockchip->is_rc) {
-		rockchip->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
+		rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep", GPIOD_OUT_HIGH);
 		if (IS_ERR(rockchip->ep_gpio)) {
-			dev_err(dev, "missing ep-gpios property in node\n");
+			dev_err_probe(dev, PTR_ERR(rockchip->ep_gpio),
+				      "failed to get ep GPIO\n");
 			return PTR_ERR(rockchip->ep_gpio);
 		}
 	}
-- 
2.29.2

