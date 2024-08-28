Return-Path: <linux-pci+bounces-12330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3F59621CD
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 09:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FF42866EB
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 07:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E62F158A04;
	Wed, 28 Aug 2024 07:51:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E9B1487FE
	for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 07:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831516; cv=none; b=DknzShx4EDL9V31U5oTj752gMwpBoiCfalw7LfVWuZNqGeYew8eqs4Y5RFoIGX8gTDO4LvE1MSa/k+aE0CEw61/kxwA4fa74KaWyZiZZs53WB9DHfpOW9q2hHIrnjUQQ8tozW2XQqIB63F8DrRKpCsfnv+2bE+MZ6Ln0L6Jv+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831516; c=relaxed/simple;
	bh=QDNIpKluA/Hn6IwbVvn3bv6YH1aHA8guIHFxWtIplno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmBIAmCTy4U69NMT5MUO/9K0LIo0fmPHPaOVfm6n9EQlNDLvpbAgQwOiGF+Oz2VPiTS+o6KcBXr812TJ3NOgwD5KUsn4a8uZsy+0efA4JONjYVzFXJq9e4NDxbp8v3vOIVxWFSP2TyEXRGpUvPQzOjlAVz5FqcRewr6vkGOFw6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WtxRq1JRyz16PbW;
	Wed, 28 Aug 2024 15:51:03 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FC75180105;
	Wed, 28 Aug 2024 15:51:51 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 15:51:49 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH 5/5] PCI: tegra: Use helper function for_each_child_of_node_scoped()
Date: Wed, 28 Aug 2024 15:38:25 +0800
Message-ID: <20240828073825.43072-6-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240828073825.43072-1-zhangzekun11@huawei.com>
References: <20240828073825.43072-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500003.china.huawei.com (7.202.181.241)

for_each_child_of_node_scoped() provides a scope-based cleanup
functinality to put the device_node automatically, and we don't need to
call of_node_put() directly.  Let's simplify the code a bit with the use
of these functions.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/pci/controller/pci-tegra.c | 41 ++++++++++--------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index d7517c3976e7..f1214b3374da 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2106,14 +2106,14 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
 static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
-	struct device_node *np = dev->of_node, *port;
+	struct device_node *np = dev->of_node;
 	const struct tegra_pcie_soc *soc = pcie->soc;
 	u32 lanes = 0, mask = 0;
 	unsigned int lane = 0;
 	int err;
 
 	/* parse root ports */
-	for_each_child_of_node(np, port) {
+	for_each_child_of_node_scoped(np, port) {
 		struct tegra_pcie_port *rp;
 		unsigned int index;
 		u32 value;
@@ -2122,15 +2122,14 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		err = of_pci_get_devfn(port);
 		if (err < 0) {
 			dev_err(dev, "failed to parse address: %d\n", err);
-			goto err_node_put;
+			return err;
 		}
 
 		index = PCI_SLOT(err);
 
 		if (index < 1 || index > soc->num_ports) {
 			dev_err(dev, "invalid port number: %d\n", index);
-			err = -EINVAL;
-			goto err_node_put;
+			return -EINVAL;
 		}
 
 		index--;
@@ -2139,13 +2138,12 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		if (err < 0) {
 			dev_err(dev, "failed to parse # of lanes: %d\n",
 				err);
-			goto err_node_put;
+			return err;
 		}
 
 		if (value > 16) {
 			dev_err(dev, "invalid # of lanes: %u\n", value);
-			err = -EINVAL;
-			goto err_node_put;
+			return -EINVAL;
 		}
 
 		lanes |= value << (index << 3);
@@ -2159,15 +2157,13 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		lane += value;
 
 		rp = devm_kzalloc(dev, sizeof(*rp), GFP_KERNEL);
-		if (!rp) {
-			err = -ENOMEM;
-			goto err_node_put;
-		}
+		if (!rp)
+			return -ENOMEM;
 
 		err = of_address_to_resource(port, 0, &rp->regs);
 		if (err < 0) {
 			dev_err(dev, "failed to parse address: %d\n", err);
-			goto err_node_put;
+			return err;
 		}
 
 		INIT_LIST_HEAD(&rp->list);
@@ -2177,16 +2173,12 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		rp->np = port;
 
 		rp->base = devm_pci_remap_cfg_resource(dev, &rp->regs);
-		if (IS_ERR(rp->base)) {
-			err = PTR_ERR(rp->base);
-			goto err_node_put;
-		}
+		if (IS_ERR(rp->base))
+			return PTR_ERR(rp->base);
 
 		label = devm_kasprintf(dev, GFP_KERNEL, "pex-reset-%u", index);
-		if (!label) {
-			err = -ENOMEM;
-			goto err_node_put;
-		}
+		if (!label)
+			return -ENOMEM;
 
 		/*
 		 * Returns -ENOENT if reset-gpios property is not populated
@@ -2204,8 +2196,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 			} else {
 				dev_err(dev, "failed to get reset GPIO: %ld\n",
 					PTR_ERR(rp->reset_gpio));
-				err = PTR_ERR(rp->reset_gpio);
-				goto err_node_put;
+				return PTR_ERR(rp->reset_gpio);
 			}
 		}
 
@@ -2223,10 +2214,6 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		return err;
 
 	return 0;
-
-err_node_put:
-	of_node_put(port);
-	return err;
 }
 
 /*
-- 
2.17.1


