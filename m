Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B33D5036FE
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 16:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiDPOHt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 10:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiDPOHs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 10:07:48 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC231836A
        for <linux-pci@vger.kernel.org>; Sat, 16 Apr 2022 07:05:13 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout4.routing.net (Postfix) with ESMTP id AEF821007A0;
        Sat, 16 Apr 2022 13:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1650117336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5P+kuagV6Z84gNo/RLW8HroxGzgqmpKqpzpblsOEYl4=;
        b=SAxjKjmrGjaI1uK2U/O/6+N2p68chmV2mmP0kNgXJkUHVP5KL3bknUE0AkqdNT+5e+l2kG
        XrqOi5Hjk5GehVDEX+/mX7WQqtUy9X+XoZEWVw1Si5Or1yjMXtD9besm0+TK6yIjW63ZJs
        MQmC1tcWWEXhAI7nih/OVDT1onLdqpg=
Received: from localhost.localdomain (fttx-pool-217.61.150.108.bambit.de [217.61.150.108])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 6ADE81006D1;
        Sat, 16 Apr 2022 13:55:35 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [RFC/RFT 4/6] PCI: rockchip-dwc: add pcie bifurcation
Date:   Sat, 16 Apr 2022 15:54:56 +0200
Message-Id: <20220416135458.104048-5-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416135458.104048-1-linux@fw-web.de>
References: <20220416135458.104048-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 81dc4821-c206-4329-8a32-b1fae495dacc
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

PCIe Lanes can be split to 2 slots with bifurcation.
Add support for this in existing pcie driver.

Co-developed-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 863374604fb1..1b0c2115b32e 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/phy/pcie.h>
 
 #include "pcie-designware.h"
 
@@ -59,6 +60,7 @@ struct rockchip_pcie {
 	struct regulator                *vpcie3v3;
 	struct irq_domain		*irq_domain;
 	raw_spinlock_t			irq_lock;
+	bool				bifurcation;
 };
 
 static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip,
@@ -273,6 +275,12 @@ static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
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
@@ -345,6 +353,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (device_property_read_bool(dev, "rockchip,bifurcation"))
+		rockchip->bifurcation = true;
+
 	ret = rockchip_pcie_phy_init(rockchip);
 	if (ret)
 		goto disable_regulator;
-- 
2.25.1

