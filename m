Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2CE792894
	for <lists+linux-pci@lfdr.de>; Tue,  5 Sep 2023 18:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjIEQXV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 12:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354453AbjIELsh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2023 07:48:37 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5020B1AD;
        Tue,  5 Sep 2023 04:48:32 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 385BmMkh103769;
        Tue, 5 Sep 2023 06:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693914502;
        bh=/iPn0yREcHMFWliXICPndWnFxV56aW4OXQpn08OE5mY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DXB+AQ9akhiFeX9N1vc5Jl4qDySFY6M0rguw7ZRGEGgenpYHdwC5lj16fZxp9UiZ7
         huSvmPmwCVU6rSIlJwIPPCCsbn4daZ9f2C5pMgddxzYSr5kYLljjjEyvCUZfLf0LiL
         XVIRKmEs7D5g12taU7/8Hv7wMXS2+FaRU4T2x64s=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 385BmMQE054158
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Sep 2023 06:48:22 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Sep 2023 06:48:20 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Sep 2023 06:48:21 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 385BmKNJ046722;
        Tue, 5 Sep 2023 06:48:20 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
Subject: [RFC PATCH 2/2] pci: j721e: Enable reference clock output from serdes
Date:   Tue, 5 Sep 2023 17:18:16 +0530
Message-ID: <20230905114816.2993628-3-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230905114816.2993628-1-a-verma1@ti.com>
References: <20230905114816.2993628-1-a-verma1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe1 in J7AHP EVM has EP side connector reference clock connection from
serdes named SOC_SERDES0_REFCLK(PCIE_REFCLK_OUT) unlike PCIe0 which has
reference clock connection from on-board serdes. To enable this reference
clock out, ACSPCIE clock buffer pads have to be enabled.

This change enables ACSPCIE clock buffer pads and select clock source for
reference clock output.

Signed-off-by: Achal Verma <a-verma1@ti.com>
---
 .../pci/controller/cadence/pci-j721e-host.c   | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e-host.c b/drivers/pci/controller/cadence/pci-j721e-host.c
index af47aa090159..106472920f68 100644
--- a/drivers/pci/controller/cadence/pci-j721e-host.c
+++ b/drivers/pci/controller/cadence/pci-j721e-host.c
@@ -10,10 +10,21 @@
 #include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/of_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include "pcie-cadence.h"
 #include "pci-j721e.h"
 
+#define CTRL_MMR_LOCK2_MASK		0xFFFFFFFF
+#define CTRL_MMR_LOCK2_KICK0_UNLOCK_VAL	0x68EF3490
+#define CTRL_MMR_LOCK2_KICK1_UNLOCK_VAL	0xD172BC5A
+#define CTRL_MMR_LOCK_KICK_LOCK_VAL	0xFFFFFFFF
+#define CTRL_MMR_ACSPCIE_PAD_MASK	0xFFFFFFFF
+#define CTRL_MMR_ACSPCIE_PAD_EN		0x01000000
+#define PCIE_REFCLK_CLKSEL_OUT_EN	BIT(8)
+#define PCIE_REFCLK_CLKSEL_MASK	GENMASK(1, 0)
+
 static int cdns_ti_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 				    int where, int size, u32 *value)
 {
@@ -79,6 +90,84 @@ static const struct of_device_id of_j721e_pcie_host_match[] = {
 };
 MODULE_DEVICE_TABLE(of, of_j721e_pcie_host_match);
 
+static int j721e_enable_acspcie(struct j721e_pcie *pcie)
+{
+	struct device *dev = pcie->cdns_pcie->dev;
+	struct device_node *node = dev->of_node;
+	struct of_phandle_args args;
+	unsigned int lock2_kick0_offset, lock2_kick1_offset;
+	unsigned int acspcie_pad_offset, refclk_clksel_offset;
+	unsigned int refclk_clksel_source;
+	struct regmap *syscon;
+	u32 val = 0, mask = 0;
+	int ret;
+
+	/*
+	 * If property ti,syscon-pcie-refclk-out exists, believe PCIe connector
+	 * requires PCIe ref clock from Serdes, so enable ACSPCIE pads and mux
+	 * to source out PCIe ref clock else ref clock has to be supplied from
+	 * on-board clock generator.
+	 */
+	syscon = syscon_regmap_lookup_by_phandle(node, "ti,syscon-pcie-refclk-out");
+	if (IS_ERR(syscon))
+		return 0;
+
+	ret = of_parse_phandle_with_fixed_args(node, "ti,syscon-pcie-refclk-out", 5,
+						0, &args);
+	if (ret) {
+		dev_err(dev, "Failed to read ti,syscon-pcie-refclk-out property\n");
+		return ret;
+	}
+
+	lock2_kick0_offset = args.args[0];
+	lock2_kick1_offset = args.args[1];
+	acspcie_pad_offset = args.args[2];
+	refclk_clksel_offset = args.args[3];
+	refclk_clksel_source = args.args[4];
+
+	/* Un-lock Partition 2 : 8000h to 9FFFh */
+	mask = CTRL_MMR_LOCK2_MASK;
+	val = CTRL_MMR_LOCK2_KICK0_UNLOCK_VAL;
+	ret = regmap_update_bits(syscon, lock2_kick0_offset, mask, val);
+	if (ret)
+		goto err;
+
+	val = CTRL_MMR_LOCK2_KICK1_UNLOCK_VAL;
+	ret = regmap_update_bits(syscon, lock2_kick1_offset, mask, val);
+	if (ret)
+		goto err;
+
+	/* Enable ACSPCIe PADS  */
+	mask = CTRL_MMR_ACSPCIE_PAD_MASK;
+	val = CTRL_MMR_ACSPCIE_PAD_EN;
+	ret = regmap_update_bits(syscon, acspcie_pad_offset, mask, val);
+	if (ret)
+		goto err;
+
+	/* PCIE_REFCLKx_CLKSEL : EN + ref_clk_source */
+	mask = PCIE_REFCLK_CLKSEL_OUT_EN | PCIE_REFCLK_CLKSEL_MASK;
+	val = PCIE_REFCLK_CLKSEL_OUT_EN | refclk_clksel_source;
+	ret = regmap_update_bits(syscon, refclk_clksel_offset, mask, val);
+	if (ret)
+		goto err;
+
+	/* Re-lock Partition 2 : 8000h to 9FFFh */
+	mask = CTRL_MMR_LOCK_KICK_LOCK_VAL;
+	val = CTRL_MMR_LOCK_KICK_LOCK_VAL;
+	ret = regmap_update_bits(syscon, lock2_kick0_offset, mask, val);
+	if (ret)
+		goto err;
+
+	ret = regmap_update_bits(syscon, lock2_kick1_offset, mask, val);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	dev_err(dev, "Failed to enable ref clock out\n");
+	return ret;
+}
+
 static int j721e_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -121,6 +210,13 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Enable ACSPCIe clock buffer to source out reference clock for EP
+	 */
+	ret = j721e_enable_acspcie(pcie);
+	if (ret < 0)
+		return ret;
+
 	pcie->perst_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(pcie->perst_gpiod)) {
 		ret = PTR_ERR(pcie->perst_gpiod);
-- 
2.25.1

