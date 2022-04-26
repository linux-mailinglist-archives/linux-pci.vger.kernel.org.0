Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B9E50FEEF
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 15:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350884AbiDZNZP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Apr 2022 09:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350864AbiDZNZK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2022 09:25:10 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5B714B644;
        Tue, 26 Apr 2022 06:22:02 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout2.routing.net (Postfix) with ESMTP id BD83960524;
        Tue, 26 Apr 2022 13:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1650979320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NbsPLOQv/aOSQhJqaMOaTJWV5WJaJFEJWdIHjZJE2yk=;
        b=JB8STSEy48bhKqCXcnF4CnGccg53Kxy6tE9rGSpP148bA235amDWQN9veU8+Bq06BVvvwu
        F2VZBOFu8QaN6LqHMUcuNI6OW1p6sUZSpKrzu2zH9h2yMp4mgNhRJyXfoMYSsTUZCLw63c
        DUWe2KBOj5VUkg9MEq8RjKb3ClNGbNE=
Received: from localhost.localdomain (fttx-pool-80.245.77.37.bambit.de [80.245.77.37])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id B73144059D;
        Tue, 26 Apr 2022 13:21:59 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [RFC/RFT v2 06/11] PCI: rockchip-dwc: add PCIe bifurcation
Date:   Tue, 26 Apr 2022 15:21:34 +0200
Message-Id: <20220426132139.26761-7-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426132139.26761-1-linux@fw-web.de>
References: <20220426132139.26761-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 4395d81b-c371-47ff-a8b0-3ecb543b8d9b
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

PCIe Lanes can be split to 2 slots with bifurcation.
Add support for this in existing PCIe driver that can be enabled
by new "bifurcation" devicetree property.

Co-developed-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

---
changes in v2:
- change rockchip,bifurcation to vendor unspecific bifurcation
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index b00832d653ea..79e909df241c 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/phy/pcie.h>
 
 #include "pcie-designware.h"
 
@@ -58,6 +59,7 @@ struct rockchip_pcie {
 	struct gpio_desc		*rst_gpio;
 	struct regulator                *vpcie3v3;
 	struct irq_domain		*irq_domain;
+	bool				bifurcation;
 };
 
 static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip,
@@ -259,6 +261,12 @@ static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
 		return dev_err_probe(dev, PTR_ERR(rockchip->phy),
 				     "missing PHY\n");
 
+	if (rockchip->bifurcation) {
+		ret = phy_set_mode_ext(rockchip->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_BIFURCATION);
+		if (ret)
+			return ret;
+	}
+
 	ret = phy_init(rockchip->phy);
 	if (ret < 0)
 		return ret;
@@ -319,6 +327,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (device_property_read_bool(dev, "bifurcation"))
+		rockchip->bifurcation = true;
+
 	ret = rockchip_pcie_phy_init(rockchip);
 	if (ret)
 		goto disable_regulator;
-- 
2.25.1

