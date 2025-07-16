Return-Path: <linux-pci+bounces-32228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 601F4B06D5F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 07:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D19A500F6F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 05:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268412E8896;
	Wed, 16 Jul 2025 05:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b="D03BeeBD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540112E88AF
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 05:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752644456; cv=none; b=txGzL8ANXizAXfB1Dum1B0rV0QJI6jP757kD0yd0C8ombX/MjR+MSc1QRGb/+6RUgVwi4CnVJ4pX0DHvwDQAugsV69CjIgIkGHOPFVJSP/KbQbc/3XTDLECzXpeebEmwL0nrjCbjUZpshOgcVAG6O2DpeBXct5Veso6ckcJP4r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752644456; c=relaxed/simple;
	bh=ABVyHhl5r1xwDIC8WIncdh/ntwwyuzGVNYfIZxOUv4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hRIYdZI8/y6OsIKxcDZh1sVnCmVOzmeyeWUOXXFlChPLXYQ8D+XgbLNLBXCny4MiAvGEDYeQYGc4Ae3mgSWU8pqlwH2eE8kBbFePRk1UkpNwidpLwfOznw4t7rLVXUJ2Zn8d0youFESQFdWz5LisoN0QTY+zjhi+TKuRF9SH0SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b=D03BeeBD; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250716054051e899beffc3d67cb9d9
        for <linux-pci@vger.kernel.org>;
        Wed, 16 Jul 2025 07:40:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=R2q3vmvSPY6bztzupG4FTBbtoFsGOYfbQq9ejBnjuc4=;
 b=D03BeeBDQTouWYfcxapm2fEWxOqXcPzaMkhpfictr/048O+LnELmZ0XLakD9TIMqcfz4+C
 QY8l2wecWQyKc4ov+W0yohZuCnf70OcDeEgFJFhbt3+q4WqiCqf/YOlMI2p9AHTRfXiw2hH3
 YQUZ30oZ95dEOpUmH2gAqTv+yjZ/9ElRBk3mo8sjCTVFudmWdrtDG44ms651n9rvS98j+F65
 SEbBvyRoo2Pbg904PRvBWdkJfICt7JPmTn0A/O5xlzlwD0zVufw5ql6Zek+53ulfurwDwqPD
 udasAE/KlN/RkaT0ZgraUFPsqlmgH9JKKj5UCZ8R9hiDui8xGnhA1AEA==;
From: huaqian.li@siemens.com
To: s-vadapalli@ti.com
Cc: baocheng.su@siemens.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	diogo.ivo@siemens.com,
	helgaas@kernel.org,
	huaqian.li@siemens.com,
	jan.kiszka@siemens.com,
	kristo@kernel.org,
	krzk+dt@kernel.org,
	kw@linux.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	nm@ti.com,
	robh@kernel.org,
	ssantosh@kernel.org,
	vigneshr@ti.com
Subject: [PATCH v9 (RESEND) 4/7] PCI: keystone: Add support for PVU-based DMA isolation on AM654
Date: Wed, 16 Jul 2025 13:39:47 +0800
Message-Id: <20250716053950.199079-5-huaqian.li@siemens.com>
In-Reply-To: <20250716053950.199079-1-huaqian.li@siemens.com>
References: <e21c6ead-2bcb-422b-a1b9-eb9dd63b7dc7@ti.com>
 <20250716053950.199079-1-huaqian.li@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

The AM654 lacks an IOMMU, thus does not support isolating DMA requests
from untrusted PCI devices to selected memory regions this way. Use
static PVU-based protection instead. The PVU, when enabled, will only
accept DMA requests that address previously configured regions.

Use the availability of a restricted-dma-pool memory region as trigger
and register it as valid DMA target with the PVU. In addition, enable
the mapping of requester IDs to VirtIDs in the PCI RC. Use only a single
VirtID so far, catching all devices.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 106 ++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 2b2632e513b5..fbf1bf43b7ca 100644
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
@@ -1136,6 +1148,94 @@ static const struct of_device_id ks_pcie_of_match[] = {
 	{ },
 };
 
+static int ks_init_vmap(struct platform_device *pdev, const char *vmap_name)
+{
+	struct resource *res;
+	void __iomem *base;
+	u32 val;
+
+	if (!IS_ENABLED(CONFIG_TI_PVU))
+		return 0;
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
+	if (!IS_ENABLED(CONFIG_TI_PVU))
+		return 0;
+
+	/* Only process the first restricted DMA pool, more are not allowed */
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
+	if (!IS_ENABLED(CONFIG_TI_PVU))
+		return;
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
+
 static int ks_pcie_probe(struct platform_device *pdev)
 {
 	const struct dw_pcie_host_ops *host_ops;
@@ -1284,6 +1384,10 @@ static int ks_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_get_sync;
 
+	ret = ks_init_restricted_dma(pdev);
+	if (ret < 0)
+		goto err_get_sync;
+
 	switch (mode) {
 	case DW_PCIE_RC_TYPE:
 		if (!IS_ENABLED(CONFIG_PCI_KEYSTONE_HOST)) {
@@ -1365,6 +1469,8 @@ static void ks_pcie_remove(struct platform_device *pdev)
 	int num_lanes = ks_pcie->num_lanes;
 	struct device *dev = &pdev->dev;
 
+	ks_release_restricted_dma(pdev);
+
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
-- 
2.34.1


