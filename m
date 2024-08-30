Return-Path: <linux-pci+bounces-12481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C52F965634
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 06:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7BA282D0A
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 04:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8359014831C;
	Fri, 30 Aug 2024 04:11:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C42114A603
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 04:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724991114; cv=none; b=YOiA0v0wgvT0wvLJFoLJLTSYJ8iS4VAbNU1d7Et64iv8+xFuE629OOrL3etM1eP5IhQTHZRd6gYX/CiLd4GuEu+Ajl0rq3xr3DBy2qM+ET9qLnnT8K2fW3tWPYXU+A/lDQ6OsPqndYevocZCIru/7PEC+7dzgMByhyn4en88Y9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724991114; c=relaxed/simple;
	bh=/bPJADL8ENVgMa0jR3/Q8ShiF8ld7+yblGtJm9+3JXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHXzdrX6lSqJLndAWFG7pl7b2cCFmolCCaWUzZkNe05GNehN6X1e2uKArbatPsU21JkcwrA3gQnz7nPyO2kCvXbrnVH7hN85PBQ1lTxKsXf+X54PzsopnK42Otj/h9THnc2FVI1NQO0mKLIMf9z3wrWus1K0zha96EeiGLNEMkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ww4NL3S9KzQrB8;
	Fri, 30 Aug 2024 12:06:58 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C4B01401F3;
	Fri, 30 Aug 2024 12:11:50 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 12:11:48 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>, <Jonathan.Cameron@Huawei.com>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH v2 6/6] PCI: tegra: Use helper function for_each_child_of_node_scoped()
Date: Fri, 30 Aug 2024 11:58:19 +0800
Message-ID: <20240830035819.13718-7-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240830035819.13718-1-zhangzekun11@huawei.com>
References: <20240830035819.13718-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf500003.china.huawei.com (7.202.181.241)

for_each_child_of_node_scoped() provides a scope-based cleanup
functionality to put the device_node automatically, and we don't need to
call of_node_put() directly.  Let's simplify the code a bit with the use
of these functions.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
v2:
- Use dev_err_probe() to simplify code.
- Fix spelling error in commit message.

 drivers/pci/controller/pci-tegra.c | 74 ++++++++++--------------------
 1 file changed, 23 insertions(+), 51 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index d7517c3976e7..94a768a4616d 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2106,47 +2106,36 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
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
 		char *label;
 
 		err = of_pci_get_devfn(port);
-		if (err < 0) {
-			dev_err(dev, "failed to parse address: %d\n", err);
-			goto err_node_put;
-		}
+		if (err < 0)
+			return dev_err_probe(dev, err, "failed to parse address\n");
 
 		index = PCI_SLOT(err);
 
-		if (index < 1 || index > soc->num_ports) {
-			dev_err(dev, "invalid port number: %d\n", index);
-			err = -EINVAL;
-			goto err_node_put;
-		}
+		if (index < 1 || index > soc->num_ports)
+			return dev_err_probe(dev, -EINVAL, "invalid port number: %d\n", index);
 
 		index--;
 
 		err = of_property_read_u32(port, "nvidia,num-lanes", &value);
-		if (err < 0) {
-			dev_err(dev, "failed to parse # of lanes: %d\n",
-				err);
-			goto err_node_put;
-		}
+		if (err < 0)
+			return dev_err_probe(dev, err, "failed to parse # of lanes\n");
 
-		if (value > 16) {
-			dev_err(dev, "invalid # of lanes: %u\n", value);
-			err = -EINVAL;
-			goto err_node_put;
-		}
+		if (value > 16)
+			return dev_err_probe(dev, -EINVAL, "invalid # of lanes: %u\n", value);
 
 		lanes |= value << (index << 3);
 
@@ -2159,16 +2148,12 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		lane += value;
 
 		rp = devm_kzalloc(dev, sizeof(*rp), GFP_KERNEL);
-		if (!rp) {
-			err = -ENOMEM;
-			goto err_node_put;
-		}
+		if (!rp)
+			return -ENOMEM;
 
 		err = of_address_to_resource(port, 0, &rp->regs);
-		if (err < 0) {
-			dev_err(dev, "failed to parse address: %d\n", err);
-			goto err_node_put;
-		}
+		if (err < 0)
+			return dev_err_probe(dev, err, "failed to parse address\n");
 
 		INIT_LIST_HEAD(&rp->list);
 		rp->index = index;
@@ -2177,16 +2162,12 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
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
@@ -2201,32 +2182,23 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		if (IS_ERR(rp->reset_gpio)) {
 			if (PTR_ERR(rp->reset_gpio) == -ENOENT) {
 				rp->reset_gpio = NULL;
-			} else {
-				dev_err(dev, "failed to get reset GPIO: %ld\n",
-					PTR_ERR(rp->reset_gpio));
-				err = PTR_ERR(rp->reset_gpio);
-				goto err_node_put;
-			}
+			} else
+				return dev_err_probe(dev, PTR_ERR(rp->reset_gpio),
+						     "failed to get reset GPIO\n");
 		}
 
 		list_add_tail(&rp->list, &pcie->ports);
 	}
 
 	err = tegra_pcie_get_xbar_config(pcie, lanes, &pcie->xbar_config);
-	if (err < 0) {
-		dev_err(dev, "invalid lane configuration\n");
-		return err;
-	}
+	if (err < 0)
+		return dev_err_probe(dev, err, "invalid lane configuration\n");
 
 	err = tegra_pcie_get_regulators(pcie, mask);
 	if (err < 0)
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


