Return-Path: <linux-pci+bounces-12211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E0795F896
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 19:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38FD01F23759
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 17:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C4019995D;
	Mon, 26 Aug 2024 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="dJkgaW0P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1B41991CD
	for <linux-pci@vger.kernel.org>; Mon, 26 Aug 2024 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724694982; cv=none; b=qPZsKbvRIDP8LCsUdhEf9p1ZdzpZn+XDAkiLr8CBMUw0POY2zq33OEsd2Pc6ys7URlE/2o/+2DEO2isrMMq/JyU5KBXwgVTOYUbWtPM6UG/dEGN44he+JFfUWBqPcR8IP+hWk/AZVuXLnFRu5vCkyJcWlYUOa19qHu6x2f6DoRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724694982; c=relaxed/simple;
	bh=ruXlYa2LFhYJ5y3GJeJvo8cnrcRFPe3pTkO5A1lOkZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QktAVQYSPaTY1LjYudBT7G9XgowZMSo7chfH/xR5v4kaWWmDZ7DFyjge1tc+UG/5XdRgUUsZlqWZWKHpWwwvkP0V97EnDL75NxE4WjZoXT8hHWrhM4suDSwu0G+4K8Uq8X/NxY1avgV1ROZ07fOOHb7rWhRTnlVAYqjaqo5KKFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=dJkgaW0P; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240826175613235609e065d7866486
        for <linux-pci@vger.kernel.org>;
        Mon, 26 Aug 2024 19:56:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nJ23+pLVcV1YLo+DOWiwMwlffZaSUayxfrEBlEY2X7Q=;
 b=dJkgaW0PBZXN/y8k+iuFJc0yTOju9G/gxH7wkruIh2Ga3nV6YvwGcEeblSIBw280kpbDtX
 FGbP3hQ5DGgawv1OklhtQiA3drCIk6WxbW0ITbCvQVo9aUhBgAF4knwd+eqm9eb1etnZPeNg
 tSdjibjht/bCHkE8Iylh2b95n4gqI5qHcUhafqGAXijt/SB1EhwM7e+6da6X1A8c1DnjRkZR
 2u7FoOtvHj5mIdx7GNANFUzjmlvy1vEcLu5YeIyFlPnDJndYkPjOU0bcR0CI8g/Ze0KnCzo6
 NxfczY11O0Fe1P4r+k+SCjp9A/bw4Z8jC50F8cw68s8zFyVwDQ2FOdvg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 4/5] PCI: keystone: Add supported for PVU-based DMA isolation on AM654
Date: Mon, 26 Aug 2024 19:56:08 +0200
Message-ID: <3a41969d3f3af044fbde04c9314e9644c833451c.1724694969.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1724694969.git.jan.kiszka@siemens.com>
References: <cover.1724694969.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

The AM654 lacks an IOMMU, thus does not support isolating DMA requests
from untrusted PCI devices to selected memory regions this way. Use
static PVU-based protection instead.

For this, we use the availability of restricted-dma-pool memory regions
as trigger and register those as valid DMA targets with the PVU. In
addition, we need to enable the mapping of requester IDs to VirtIDs in
the PCI RC. We only use a single VirtID so far, catching all devices.
This may be extended later on.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: "Krzysztof Wilczyński" <kw@linux.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-keystone.c | 101 ++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 2219b1a866fa..96b871656da4 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -19,6 +19,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/msi.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
@@ -26,6 +27,7 @@
 #include <linux/regmap.h>
 #include <linux/resource.h>
 #include <linux/signal.h>
+#include <linux/ti-pvu.h>
 
 #include "../../pci.h"
 #include "pcie-designware.h"
@@ -111,6 +113,16 @@
 
 #define PCI_DEVICE_ID_TI_AM654X		0xb00c
 
+#define KS_PCI_VIRTID			0
+
+#define PCIE_VMAP_xP_CTRL		0x0
+#define PCIE_VMAP_xP_REQID		0x4
+#define PCIE_VMAP_xP_VIRTID		0x8
+
+#define PCIE_VMAP_xP_CTRL_EN		BIT(0)
+
+#define PCIE_VMAP_xP_VIRTID_VID_MASK	0xfff
+
 struct ks_pcie_of_data {
 	enum dw_pcie_device_mode mode;
 	const struct dw_pcie_host_ops *host_ops;
@@ -1125,6 +1137,89 @@ static const struct of_device_id ks_pcie_of_match[] = {
 	{ },
 };
 
+#ifdef CONFIG_TI_PVU
+static const char *ks_vmap_res[] = {"vmap_lp", "vmap_hp"};
+
+static int ks_init_restricted_dma(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct of_phandle_iterator it;
+	bool init_vmap = false;
+	struct resource phys;
+	struct resource *res;
+	void __iomem *base;
+	unsigned int n;
+	u32 val;
+	int err;
+
+	of_for_each_phandle(&it, err, dev->of_node, "memory-region",
+			    NULL, 0) {
+		if (!of_device_is_compatible(it.node, "restricted-dma-pool"))
+			continue;
+
+		err = of_address_to_resource(it.node, 0, &phys);
+		if (err < 0) {
+			dev_err(dev, "failed to parse memory region %pOF: %d\n",
+				it.node, err);
+			continue;
+		}
+
+		err = ti_pvu_create_region(KS_PCI_VIRTID, &phys);
+		if (err < 0)
+			return err;
+
+		init_vmap = true;
+	}
+
+	if (init_vmap) {
+		for (n = 0; n < ARRAY_SIZE(ks_vmap_res); n++) {
+			res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+							   ks_vmap_res[n]);
+			base = devm_pci_remap_cfg_resource(dev, res);
+			if (IS_ERR(base))
+				return PTR_ERR(base);
+
+			writel(0, base + PCIE_VMAP_xP_REQID);
+
+			val = readl(base + PCIE_VMAP_xP_VIRTID);
+			val &= ~PCIE_VMAP_xP_VIRTID_VID_MASK;
+			val |= KS_PCI_VIRTID;
+			writel(val, base + PCIE_VMAP_xP_VIRTID);
+
+			val = readl(base + PCIE_VMAP_xP_CTRL);
+			val |= PCIE_VMAP_xP_CTRL_EN;
+			writel(val, base + PCIE_VMAP_xP_CTRL);
+		}
+	}
+
+	return 0;
+}
+
+static void ks_release_restricted_dma(struct platform_device *pdev)
+{
+	struct of_phandle_iterator it;
+	struct resource phys;
+	int err;
+
+	of_for_each_phandle(&it, err, pdev->dev.of_node, "memory-region",
+			    NULL, 0) {
+		if (of_device_is_compatible(it.node, "restricted-dma-pool") &&
+		    of_address_to_resource(it.node, 0, &phys) == 0)
+			ti_pvu_remove_region(KS_PCI_VIRTID, &phys);
+
+	}
+}
+#else
+static inline int ks_init_restricted_dma(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static inline void ks_release_restricted_dma(struct platform_device *pdev)
+{
+}
+#endif
+
 static int ks_pcie_probe(struct platform_device *pdev)
 {
 	const struct dw_pcie_host_ops *host_ops;
@@ -1273,6 +1368,10 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_get_sync;
 
+	ret = ks_init_restricted_dma(pdev);
+	if (ret < 0)
+		goto err_get_sync;
+
 	switch (mode) {
 	case DW_PCIE_RC_TYPE:
 		if (!IS_ENABLED(CONFIG_PCI_KEYSTONE_HOST)) {
@@ -1354,6 +1453,8 @@ static void ks_pcie_remove(struct platform_device *pdev)
 	int num_lanes = ks_pcie->num_lanes;
 	struct device *dev = &pdev->dev;
 
+	ks_release_restricted_dma(pdev);
+
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
-- 
2.43.0


