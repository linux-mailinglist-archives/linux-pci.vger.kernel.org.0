Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CDA2CE8E0
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 08:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgLDHxb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 02:53:31 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36700 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgLDHxb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Dec 2020 02:53:31 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B47qWpc081729;
        Fri, 4 Dec 2020 01:52:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607068352;
        bh=Dvc7KcefiCb7PBlxUNtWkFXErE0HJTFuqI/Pj5OA+TY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qLEVkXzBHUbog4zDi8ggltskgQAyRrPp21Ljoh10fNbuko0gkBSmp/3FOs38senDJ
         aDhd7pVzKSQWStB9gVhV9Jn8r6Xdug0Z9E9CFElffpZjsP2iVLsujHenMK48hGI0Hz
         6m2m+07wk2h/+Y8fQtiB/wn085+HSfsffH/ZbvKA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B47qWtt091160
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Dec 2020 01:52:32 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 4 Dec
 2020 01:52:31 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 4 Dec 2020 01:52:31 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B47pL6u031834;
        Fri, 4 Dec 2020 01:52:12 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v2 2/3] PCI: j721e: Get offset within "syscon" from "ti,syscon-pcie-ctrl" phandle arg
Date:   Fri, 4 Dec 2020 13:21:16 +0530
Message-ID: <20201204075117.10430-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201204075117.10430-1-kishon@ti.com>
References: <20201204075117.10430-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Get "syscon" pcie_ctrl offset from the argument of "ti,syscon-pcie-ctrl"
phandle. Previously a subnode to "syscon" node was added which has the
exact memory mapped address of pcie_ctrl but now the offset of pcie_ctrl
within "syscon" is now being passed as argument to "ti,syscon-pcie-ctrl"
phandle.

If the offset is not provided in "ti,syscon-pcie-ctrl", the
full memory mapped address of pcie_ctrl is used in order to maintain old
DT compatibility.

This change is as discussed in [1]

[1] -> http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 28 +++++++++++++++-------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 586b9d69fa5e..dac1ac8a7615 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -12,6 +12,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/mfd/syscon.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/pci.h>
@@ -153,7 +154,8 @@ static const struct cdns_pcie_ops j721e_pcie_ops = {
 	.link_up = j721e_pcie_link_up,
 };
 
-static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon)
+static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
+			       unsigned int offset)
 {
 	struct device *dev = pcie->dev;
 	u32 mask = J721E_MODE_RC;
@@ -164,7 +166,7 @@ static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon)
 	if (mode == PCI_MODE_RC)
 		val = J721E_MODE_RC;
 
-	ret = regmap_update_bits(syscon, 0, mask, val);
+	ret = regmap_update_bits(syscon, offset, mask, val);
 	if (ret)
 		dev_err(dev, "failed to set pcie mode\n");
 
@@ -172,7 +174,7 @@ static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon)
 }
 
 static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
-				     struct regmap *syscon)
+				     struct regmap *syscon, unsigned int offset)
 {
 	struct device *dev = pcie->dev;
 	struct device_node *np = dev->of_node;
@@ -185,7 +187,7 @@ static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
 		link_speed = 2;
 
 	val = link_speed - 1;
-	ret = regmap_update_bits(syscon, 0, GENERATION_SEL_MASK, val);
+	ret = regmap_update_bits(syscon, offset, GENERATION_SEL_MASK, val);
 	if (ret)
 		dev_err(dev, "failed to set link speed\n");
 
@@ -193,7 +195,7 @@ static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
 }
 
 static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
-				     struct regmap *syscon)
+				     struct regmap *syscon, unsigned int offset)
 {
 	struct device *dev = pcie->dev;
 	u32 lanes = pcie->num_lanes;
@@ -201,7 +203,7 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
 	int ret;
 
 	val = LANE_COUNT(lanes - 1);
-	ret = regmap_update_bits(syscon, 0, LANE_COUNT_MASK, val);
+	ret = regmap_update_bits(syscon, offset, LANE_COUNT_MASK, val);
 	if (ret)
 		dev_err(dev, "failed to set link count\n");
 
@@ -212,6 +214,8 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct device_node *node = dev->of_node;
+	struct of_phandle_args args;
+	unsigned int offset = 0;
 	struct regmap *syscon;
 	int ret;
 
@@ -221,19 +225,25 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 		return PTR_ERR(syscon);
 	}
 
-	ret = j721e_pcie_set_mode(pcie, syscon);
+	/* Do not error out to maintain old DT compatibility */
+	ret = of_parse_phandle_with_fixed_args(node, "ti,syscon-pcie-ctrl", 1,
+					       0, &args);
+	if (!ret)
+		offset = args.args[0];
+
+	ret = j721e_pcie_set_mode(pcie, syscon, offset);
 	if (ret < 0) {
 		dev_err(dev, "Failed to set pci mode\n");
 		return ret;
 	}
 
-	ret = j721e_pcie_set_link_speed(pcie, syscon);
+	ret = j721e_pcie_set_link_speed(pcie, syscon, offset);
 	if (ret < 0) {
 		dev_err(dev, "Failed to set link speed\n");
 		return ret;
 	}
 
-	ret = j721e_pcie_set_lane_count(pcie, syscon);
+	ret = j721e_pcie_set_lane_count(pcie, syscon, offset);
 	if (ret < 0) {
 		dev_err(dev, "Failed to set num-lanes\n");
 		return ret;
-- 
2.17.1

