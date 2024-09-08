Return-Path: <linux-pci+bounces-12933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFE0970906
	for <lists+linux-pci@lfdr.de>; Sun,  8 Sep 2024 19:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B55A1F216ED
	for <lists+linux-pci@lfdr.de>; Sun,  8 Sep 2024 17:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C5917622F;
	Sun,  8 Sep 2024 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Se9f3aHb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7009176ABB
	for <linux-pci@vger.kernel.org>; Sun,  8 Sep 2024 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725816769; cv=none; b=e3VDodHSj2XRHdQk+c4Ha3GKFVu21L5InTgR5EyjUZG77SZi1etSCove2fft0Cpu7QGrazC5+1lptlTdMW9bSzEnQZd6abIW/cvlEoPPOGrqQFyxv5+TZPXE7wnf17br6atlkb7rcokg1VXXRfzKlPq++kxWp2e4UHhW8PJn1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725816769; c=relaxed/simple;
	bh=jvaPt0+IphYXMI1rF9+cVjsVdNcsqc5xkrDGtcZ9a9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XzJL8HNUpw4TuOozw7VFlKH8UJDKEtfiFEKQapk5Q5pFpeQR+KDf209fBO1Keq8/zlD02Z01DHXh4OJGRpJYpVM1thY3JLa1PH2P5EzmVMUFy995V79ryh59+fl9tt65SKnj+XsOUiTOmQsXZMvD0BgzQwLytniHBnPHdmmRW4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Se9f3aHb; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240908173237a38039a0b3dbaf0b0b
        for <linux-pci@vger.kernel.org>;
        Sun, 08 Sep 2024 19:32:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=zzmLaklWQjTzvGkzTiEWxr4awCiJVS73Qbgs4hUWCQY=;
 b=Se9f3aHbVBQ4nMf9QmlVTFYHdjadSLlSGsw4gmKzC4r+XbKqVB79fuTDJgk71/sPVjuwu8
 kOueI1r1zrPAFzgmDxSmpIrhr3SfgTU+H9WcczjkrHi7qNApc3dZy9QvAF4L9OaOqJs1s59b
 9COzreGoRlsADnozhgd6sH0puC46QewyO+EYXdlmqtqfTJvf2gZRyS8v+P1H4/Xfa/kzDUP5
 eLx2Fu5a3vxpHMvuZboEU1si8meFXOSHlZt6bK96fONAIZ3fkwrOZgyUn8l1RyMG8ANnhdpu
 LqKRuGrZSVMy7kmCF1Nw9OGxJXox+f6Q7eXZxxrVy2SM/BtUpdmDsbNw==;
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
Subject: [PATCH v5 4/7] PCI: keystone: Add support for PVU-based DMA isolation on AM654
Date: Sun,  8 Sep 2024 19:32:30 +0200
Message-ID: <cab4533870ebfc0a55eec7c3222623e214d137e5.1725816753.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1725816753.git.jan.kiszka@siemens.com>
References: <cover.1725816753.git.jan.kiszka@siemens.com>
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
static PVU-based protection instead. The PVU, when enabled, will only
accept DMA requests that address previously configured regions.

Use the availability of a restricted-dma-pool memory region as trigger
and register it as valid DMA target with the PVU. In addition, enable
the mapping of requester IDs to VirtIDs in the PCI RC. Use only a single
VirtID so far, catching all devices. This may be extended later on.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: "Krzysztof Wilczyński" <kw@linux.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-keystone.c | 108 ++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 2219b1a866fa..a5954cae6d5d 100644
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
@@ -1125,6 +1137,96 @@ static const struct of_device_id ks_pcie_of_match[] = {
 	{ },
 };
 
+#ifdef CONFIG_TI_PVU
+static int ks_init_vmap(struct platform_device *pdev, const char *vmap_name)
+{
+	struct resource *res;
+	void __iomem *base;
+	u32 val;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, vmap_name);
+	base = devm_pci_remap_cfg_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	writel(0, base + PCIE_VMAP_xP_REQID);
+
+	val = readl(base + PCIE_VMAP_xP_VIRTID);
+	val &= ~PCIE_VMAP_xP_VIRTID_VID_MASK;
+	val |= KS_PCI_VIRTID;
+	writel(val, base + PCIE_VMAP_xP_VIRTID);
+
+	val = readl(base + PCIE_VMAP_xP_CTRL);
+	val |= PCIE_VMAP_xP_CTRL_EN;
+	writel(val, base + PCIE_VMAP_xP_CTRL);
+
+	return 0;
+}
+
+static int ks_init_restricted_dma(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct of_phandle_iterator it;
+	struct resource phys;
+	int err;
+
+	/* Only process the first restricted dma pool, more are not allowed */
+	of_for_each_phandle(&it, err, dev->of_node, "memory-region",
+			    NULL, 0) {
+		if (of_device_is_compatible(it.node, "restricted-dma-pool"))
+			break;
+	}
+	if (err)
+		return err == -ENOENT ? 0 : err;
+
+	err = of_address_to_resource(it.node, 0, &phys);
+	if (err < 0) {
+		dev_err(dev, "failed to parse memory region %pOF: %d\n",
+			it.node, err);
+		return 0;
+	}
+
+	/* Map all incoming requests on low and high prio port to virtID 0 */
+	err = ks_init_vmap(pdev, "vmap_lp");
+	if (err)
+		return err;
+	err = ks_init_vmap(pdev, "vmap_hp");
+	if (err)
+		return err;
+
+	/*
+	 * Enforce DMA pool usage with the help of the PVU.
+	 * Any request outside will be dropped and raise an error at the PVU.
+	 */
+	return ti_pvu_create_region(KS_PCI_VIRTID, &phys);
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
+		    of_address_to_resource(it.node, 0, &phys) == 0) {
+			ti_pvu_remove_region(KS_PCI_VIRTID, &phys);
+			break;
+		}
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
@@ -1273,6 +1375,10 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_get_sync;
 
+	ret = ks_init_restricted_dma(pdev);
+	if (ret < 0)
+		goto err_get_sync;
+
 	switch (mode) {
 	case DW_PCIE_RC_TYPE:
 		if (!IS_ENABLED(CONFIG_PCI_KEYSTONE_HOST)) {
@@ -1354,6 +1460,8 @@ static void ks_pcie_remove(struct platform_device *pdev)
 	int num_lanes = ks_pcie->num_lanes;
 	struct device *dev = &pdev->dev;
 
+	ks_release_restricted_dma(pdev);
+
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
-- 
2.43.0


