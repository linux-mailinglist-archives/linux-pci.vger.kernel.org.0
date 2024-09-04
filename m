Return-Path: <linux-pci+bounces-12738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7A996B7F1
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 12:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EA9285421
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 10:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F14C1CF5C0;
	Wed,  4 Sep 2024 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="dqP4zkN4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135031547E0
	for <linux-pci@vger.kernel.org>; Wed,  4 Sep 2024 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444639; cv=none; b=tuRnF4fA/zn+uH7rOZk8WGU+npta14sMAgrbh9GkIgleLd8w1djiciDOtaePQPs6fqulAVLQKStu7KP1VbWJU0hJsQLvWNu48LRnLkWYi/hzmpwTNl6oNboAJerWiLO77YRh3oP8CMYBivOvXv1XbTr3HCvUSL3f2V44WwnEINk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444639; c=relaxed/simple;
	bh=ruXlYa2LFhYJ5y3GJeJvo8cnrcRFPe3pTkO5A1lOkZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oV59Q3MHmUsvRCC6wyFzbo42nXjE0pAF8oI1Gh4E56E4tx6k+MBPvP0wUcBwhYE52Jt9SkTRqD9o7cr0IXqo51qcUkeTKDIccmmrQrMEh8T+l/1MVLpD1gdO1BgnDUL1LfTq7mHux6v9rupOwFpvoGAIY6jbj9pwqDn2l136D3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=dqP4zkN4; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240904100025df4afb2d45de6b0504
        for <linux-pci@vger.kernel.org>;
        Wed, 04 Sep 2024 12:00:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nJ23+pLVcV1YLo+DOWiwMwlffZaSUayxfrEBlEY2X7Q=;
 b=dqP4zkN4JrdHhH1kfYOs+e10N+3AYUeKMvEA3j1QhsHEgLY1tK5Zq51hTq4oryFfG2VAr/
 1i0llKkvsIMNasRvZql/HSkV5Pt+mRuXfBz6/FnKC1BbY9zzibzfxP/EikCXSAIxGUzE+402
 TTqlILAlwzYRgPfEl6mfL0IsMFQRh187H+MKMxEe+sp6Bvho2sQHnIxFcyoDJT2lAt8JRNb4
 qohDJoHbVeMSEsPjQV4tDG3NCtA/I1bzGzxyjsuSlC46zqmq67qy8uKAa9bdXhcL5R2iR77E
 ssSxCsxDi4M0ip3Qsqb8qmsRtqUdEMlbLGzQ7Q/SijhV+iRiotXkENUg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v4 4/7] PCI: keystone: Add supported for PVU-based DMA isolation on AM654
Date: Wed,  4 Sep 2024 12:00:13 +0200
Message-ID: <361441d35d781b3c474b05921634bcae08d1a7b4.1725444016.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1725444016.git.jan.kiszka@siemens.com>
References: <cover.1725444016.git.jan.kiszka@siemens.com>
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


