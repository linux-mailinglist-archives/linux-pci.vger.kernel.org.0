Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E8F50FEF0
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 15:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350902AbiDZNZQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Apr 2022 09:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350895AbiDZNZO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2022 09:25:14 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4D714DEA4;
        Tue, 26 Apr 2022 06:22:06 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout3.routing.net (Postfix) with ESMTP id E0502603D5;
        Tue, 26 Apr 2022 13:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1650979324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EP/4HyFu5fE1FWV2bSGg4OigpJgql6J8UxiMncmb55g=;
        b=b2J8CHK05TJhuJsV1YzrcrVB5YFprHk1U3MaIj3KXtDmKaiPtj4Cxh3CMlkhrIx2xjGDkd
        AXx1hkjRIJzg9O+VGS1KhBsQT+u6ABRlnPquNcbxFXrtOro1Rk821cy7f84QKB9yq6Koxu
        z4foqaWiIOmwAYr3o+bvW8uaIqmIt4c=
Received: from localhost.localdomain (fttx-pool-80.245.77.37.bambit.de [80.245.77.37])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id B5570401C9;
        Tue, 26 Apr 2022 13:22:03 +0000 (UTC)
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
Subject: [RFC/RFT v2 10/11] PCI: rockchip: add a lane-map to rockchip pcie driver
Date:   Tue, 26 Apr 2022 15:21:38 +0200
Message-Id: <20220426132139.26761-11-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426132139.26761-1-linux@fw-web.de>
References: <20220426132139.26761-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: b94f3b49-ffe6-4505-9833-b0b59dbfd0ed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add a basic lane-map to define which PCIe lanes should be
used with this controller.

Rockchip driver uses this for bifurcation (true/false) based
on lanes should be splitted across controllers or not.

On rk3568 there are 2 PCIe Controllers which share PCIe lanes.

pcie3x1: pcie@fe270000 //lane1 when using 1+1
pcie3x2: pcie@fe280000 //lane0 when using 1+1

This ends up in one Controller (pcie3x1) uses lane-map = <0 1>; and
the other lane-map = <1 0>; (pcie3x2)

This means there are 2 lanes (count of numbers), one (by position)
is mapped to the first controller, the other one is used on the other
controller.

In this driver the lane-map is simply converted to the bifurcation
bool instead of direct mapping a specific lane to a controller.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v2:
- new patch
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 79e909df241c..21cb697a5be1 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -60,6 +60,7 @@ struct rockchip_pcie {
 	struct regulator                *vpcie3v3;
 	struct irq_domain		*irq_domain;
 	bool				bifurcation;
+	u32				lane_map[2];
 };
 
 static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip,
@@ -293,8 +294,10 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rockchip_pcie *rockchip;
+	unsigned int lanecnt = 0;
 	struct pcie_port *pp;
 	int ret;
+	int len;
 
 	rockchip = devm_kzalloc(dev, sizeof(*rockchip), GFP_KERNEL);
 	if (!rockchip)
@@ -327,8 +330,16 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (device_property_read_bool(dev, "bifurcation"))
-		rockchip->bifurcation = true;
+	len = of_property_read_variable_u32_array(dev->of_node, "lane-map", rockchip->lane_map,
+						  2, ARRAY_SIZE(rockchip->lane_map));
+
+	for (int i = 0; i < len; i++)
+		if (rockchip->lane_map[i])
+			lanecnt++;
+
+	rockchip->bifurcation = ((lanecnt > 0) && (lanecnt != len));
+
+	dev_info(dev, "bifurcation: %s\n", rockchip->bifurcation ? "true" : "false");
 
 	ret = rockchip_pcie_phy_init(rockchip);
 	if (ret)
-- 
2.25.1

