Return-Path: <linux-pci+bounces-203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E54B7FB177
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 06:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFF81C20E20
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 05:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C082107B2;
	Tue, 28 Nov 2023 05:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SlHCrixe"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3FDDE;
	Mon, 27 Nov 2023 21:44:36 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AS5iQRj072810;
	Mon, 27 Nov 2023 23:44:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1701150266;
	bh=fbkuiSgCNDpWbASQgL29p346CS4aTmJI9c50yuRTTd0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SlHCrixe3nDdr/NeJITbDr8cdf794zOgh81Yi4P3W5UK0uNzLEhMagQwzwoRMKQqU
	 GW2XO461+rS5yIHUy0aTAM7ST+k1JVrYlmMsiP28hvNc8e/6Mj9L/HOsxkORoVPrrW
	 +10nmhSTJF98Jcnhp2IJFg4lN4t19SN4X2fhpV9g=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AS5iQci017538
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Nov 2023 23:44:26 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Nov 2023 23:44:26 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Nov 2023 23:44:26 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AS5i2uS096776;
	Mon, 27 Nov 2023 23:44:22 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <vigneshr@ti.com>, <tjoseph@cadence.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <r-gunasekaran@ti.com>, <danishanwar@ti.com>, <srk@ti.com>,
        <nm@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v13 4/5] PCI: j721e: Add PCIe 4x lane selection support
Date: Tue, 28 Nov 2023 11:14:01 +0530
Message-ID: <20231128054402.2155183-5-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128054402.2155183-1-s-vadapalli@ti.com>
References: <20231128054402.2155183-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Matt Ranostay <mranostay@ti.com>

Add support for setting of two-bit field that allows selection of 4x lane
PCIe which was previously limited to only 2x lanes.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Achal Verma <a-verma1@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 63c758b14314..645597856a1d 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -42,7 +42,6 @@ enum link_status {
 };
 
 #define J721E_MODE_RC			BIT(7)
-#define LANE_COUNT_MASK			BIT(8)
 #define LANE_COUNT(n)			((n) << 8)
 
 #define GENERATION_SEL_MASK		GENMASK(1, 0)
@@ -52,6 +51,7 @@ struct j721e_pcie {
 	struct clk		*refclk;
 	u32			mode;
 	u32			num_lanes;
+	u32			max_lanes;
 	void __iomem		*user_cfg_base;
 	void __iomem		*intd_cfg_base;
 	u32			linkdown_irq_regfield;
@@ -205,11 +205,15 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
 {
 	struct device *dev = pcie->cdns_pcie->dev;
 	u32 lanes = pcie->num_lanes;
+	u32 mask = BIT(8);
 	u32 val = 0;
 	int ret;
 
+	if (pcie->max_lanes == 4)
+		mask = GENMASK(9, 8);
+
 	val = LANE_COUNT(lanes - 1);
-	ret = regmap_update_bits(syscon, offset, LANE_COUNT_MASK, val);
+	ret = regmap_update_bits(syscon, offset, mask, val);
 	if (ret)
 		dev_err(dev, "failed to set link count\n");
 
@@ -441,7 +445,9 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		dev_warn(dev, "num-lanes property not provided or invalid, setting num-lanes to 1\n");
 		num_lanes = 1;
 	}
+
 	pcie->num_lanes = num_lanes;
+	pcie->max_lanes = data->max_lanes;
 
 	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)))
 		return -EINVAL;
-- 
2.34.1


