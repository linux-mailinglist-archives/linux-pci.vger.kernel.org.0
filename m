Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBB22B3E07
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 08:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgKPHyw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 02:54:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbgKPHyv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Nov 2020 02:54:51 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 985612227F;
        Mon, 16 Nov 2020 07:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605513290;
        bh=OwKfTuKSKYuNfz4bpxDopuSuiAxbNH8GnCNtt3jnfq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SV4UAqJ3/GvudI4C/bJtccFBLeCbmt5tfhhoqzeIjrhMCFWXJeSa5bncjlXDA50Tn
         uUglydtauKc3wdHaHZ1Nkgf9OwRKvxJZim3ymWdDDmd5O3tQn8bilD6t4bRyj9CqOc
         W/SAAPttiWDEE6K6yeFJnDnePqtrALkukAaNWitw=
Received: by wens.tw (Postfix, from userid 1000)
        id BF4845FD7E; Mon, 16 Nov 2020 15:54:47 +0800 (CST)
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
Subject: [PATCH 1/4] PCI: rockchip: make ep_gpio optional
Date:   Mon, 16 Nov 2020 15:52:12 +0800
Message-Id: <20201116075215.15303-2-wens@kernel.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201116075215.15303-1-wens@kernel.org>
References: <20201116075215.15303-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The Rockchip PCIe controller DT binding clearly states that ep-gpios is
an optional property. And indeed there are boards that don't require it.

Make the driver follow the binding by using devm_gpiod_get_optional()
instead of devm_gpiod_get().

Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support")
Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC driver")
Fixes: 964bac9455be ("PCI: rockchip: Split out rockchip_pcie_parse_dt() to parse DT")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/pci/controller/pcie-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 904dec0d3a88..c95950e9004f 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -118,7 +118,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 	}
 
 	if (rockchip->is_rc) {
-		rockchip->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
+		rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep", GPIOD_OUT_HIGH);
 		if (IS_ERR(rockchip->ep_gpio)) {
 			dev_err(dev, "missing ep-gpios property in node\n");
 			return PTR_ERR(rockchip->ep_gpio);
-- 
2.29.1

