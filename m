Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB3145E967
	for <lists+linux-pci@lfdr.de>; Fri, 26 Nov 2021 09:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359557AbhKZIgx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 03:36:53 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44708 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345287AbhKZIex (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 03:34:53 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AQ8VWCK056227;
        Fri, 26 Nov 2021 02:31:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637915492;
        bh=6cp3cE045NEnUdKoUZx9YiwkO99QWOlvA+gPGFnlUYo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=g+O5mEwR+TJ5HqCXIjyxOilz7rVTabSeSAAY3X6DyeOkkKiWtFNf17jxtqfHVQ298
         Fme0w8KKmzbkm/DT8HVNDG3zTjSRUhmKsBiAj7JADbWLfA8y2VWQ1zG5Bzmar4CK9Z
         OhYzErdCsSML+bWm0EXBs36KHZcZl7J0RdYi++Zo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AQ8VWhT035283
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Nov 2021 02:31:32 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 26
 Nov 2021 02:31:31 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 26 Nov 2021 02:31:31 -0600
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AQ8VKEm127547;
        Fri, 26 Nov 2021 02:31:28 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 2/5] PCI: keystone: Use phandle argument from "ti,syscon-pcie-id"/"ti,syscon-pcie-mode"
Date:   Fri, 26 Nov 2021 14:01:16 +0530
Message-ID: <20211126083119.16570-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211126083119.16570-1-kishon@ti.com>
References: <20211126083119.16570-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Get "syscon" pcie_mode and pcie_id offset from the argument of
"ti,syscon-pcie-id" and "ti,syscon-pcie-mode" phandle respectively.
Previously a subnode to "syscon" node was added which has the
exact memory mapped address of pcie_mode and pcie_id but now the
offset of pcie_mode and pcie_id within "syscon" is now being passed
as argument to "ti,syscon-pcie-id" and "ti,syscon-pcie-mode" phandle.

If the offset is not provided in "ti,syscon-pcie-id"/"ti,syscon-pcie-mode",
the full memory mapped address of pcie_ctrl is used in order to maintain
old DT compatibility.

Similar change for J721E is as discussed in [1]

[1] -> http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 27 ++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 865258d8c53c..13f03a97714c 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -775,12 +775,19 @@ static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
+	struct of_phandle_args args;
+	unsigned int offset = 0;
 
 	devctrl_regs = syscon_regmap_lookup_by_phandle(np, "ti,syscon-pcie-id");
 	if (IS_ERR(devctrl_regs))
 		return PTR_ERR(devctrl_regs);
 
-	ret = regmap_read(devctrl_regs, 0, &id);
+	/* Do not error out to maintain old DT compatibility */
+	ret = of_parse_phandle_with_fixed_args(np, "ti,syscon-pcie-id", 1, 0, &args);
+	if (!ret)
+		offset = args.args[0];
+
+	ret = regmap_read(devctrl_regs, offset, &id);
 	if (ret)
 		return ret;
 
@@ -989,6 +996,8 @@ static int ks_pcie_enable_phy(struct keystone_pcie *ks_pcie)
 static int ks_pcie_set_mode(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
+	struct of_phandle_args args;
+	unsigned int offset = 0;
 	struct regmap *syscon;
 	u32 val;
 	u32 mask;
@@ -998,10 +1007,15 @@ static int ks_pcie_set_mode(struct device *dev)
 	if (IS_ERR(syscon))
 		return 0;
 
+	/* Do not error out to maintain old DT compatibility */
+	ret = of_parse_phandle_with_fixed_args(np, "ti,syscon-pcie-mode", 1, 0, &args);
+	if (!ret)
+		offset = args.args[0];
+
 	mask = KS_PCIE_DEV_TYPE_MASK | KS_PCIE_SYSCLOCKOUTEN;
 	val = KS_PCIE_DEV_TYPE(RC) | KS_PCIE_SYSCLOCKOUTEN;
 
-	ret = regmap_update_bits(syscon, 0, mask, val);
+	ret = regmap_update_bits(syscon, offset, mask, val);
 	if (ret) {
 		dev_err(dev, "failed to set pcie mode\n");
 		return ret;
@@ -1014,6 +1028,8 @@ static int ks_pcie_am654_set_mode(struct device *dev,
 				  enum dw_pcie_device_mode mode)
 {
 	struct device_node *np = dev->of_node;
+	struct of_phandle_args args;
+	unsigned int offset = 0;
 	struct regmap *syscon;
 	u32 val;
 	u32 mask;
@@ -1023,6 +1039,11 @@ static int ks_pcie_am654_set_mode(struct device *dev,
 	if (IS_ERR(syscon))
 		return 0;
 
+	/* Do not error out to maintain old DT compatibility */
+	ret = of_parse_phandle_with_fixed_args(np, "ti,syscon-pcie-mode", 1, 0, &args);
+	if (!ret)
+		offset = args.args[0];
+
 	mask = AM654_PCIE_DEV_TYPE_MASK;
 
 	switch (mode) {
@@ -1037,7 +1058,7 @@ static int ks_pcie_am654_set_mode(struct device *dev,
 		return -EINVAL;
 	}
 
-	ret = regmap_update_bits(syscon, 0, mask, val);
+	ret = regmap_update_bits(syscon, offset, mask, val);
 	if (ret) {
 		dev_err(dev, "failed to set pcie mode\n");
 		return ret;
-- 
2.17.1

