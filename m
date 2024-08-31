Return-Path: <linux-pci+bounces-12549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 157B3966F49
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 06:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3775A1C21B4C
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 04:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6AF13A895;
	Sat, 31 Aug 2024 04:17:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B71113B2B0
	for <linux-pci@vger.kernel.org>; Sat, 31 Aug 2024 04:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725077870; cv=none; b=r+OeytvCcX8jCOX6SywQ9MeXQzmtyExTNIOS/iV7ZU6iK/sQSeFnnTxfTxuIwcJt6stZxHBYlUIH7NeU2LLDxzfYB/ZQOoBFPSojVz1/JJiOPYTjYSBRUyvl+5E5sJXEz79fgzKXEWipuhERIC/4piB1duvSDD+CU2PwOAVErqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725077870; c=relaxed/simple;
	bh=BCQMAisf8tgMiDwIcul2w7DgJKEpc+qp2vYm0GXlIaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uu1UOKypUWcdzudIC7LNZMVLgpiV7mU+rk16yjjXJf0ZJHQj24JuMW/Opctaa/s2BdrKKB3yYzBPqsPMJ8JyuM9bsYQgzycB4p8wJXGNRecsIsr0kKDIqzcHew6aaFExKu/LL2Eoy+CJQisXwtDHt4gyB4XYhZ83dByVqO6bLJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WwhZ30NStz2CpHr;
	Sat, 31 Aug 2024 12:17:31 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id D9871140158;
	Sat, 31 Aug 2024 12:17:45 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 31 Aug
 2024 12:17:44 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>, <Jonathan.Cameron@Huawei.com>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH v3 6/6] PCI: tegra: Use helper function for_each_child_of_node_scoped()
Date: Sat, 31 Aug 2024 12:04:13 +0800
Message-ID: <20240831040413.126417-7-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240831040413.126417-1-zhangzekun11@huawei.com>
References: <20240831040413.126417-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf500003.china.huawei.com (7.202.181.241)

for_each_child_of_node_scoped() provides a scope-based cleanup
functionality to put the device_node automatically, and we don't need to
call of_node_put() directly.  Let's simplify the code a bit with the use
of these functions.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2:
- Use dev_err_probe() to simplify code.
- Fix spelling error in commit message.

v3: Wrap the line which is too long.

 drivers/pci/controller/pci-tegra.c | 80 +++++++++++-------------------
 1 file changed, 28 insertions(+), 52 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index d7517c3976e7..d2f29b87ffa5 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2106,47 +2106,39 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
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
+			return dev_err_probe(dev, -EINVAL,
+					     "invalid port number: %d\n", index);
 
 		index--;
 
 		err = of_property_read_u32(port, "nvidia,num-lanes", &value);
-		if (err < 0) {
-			dev_err(dev, "failed to parse # of lanes: %d\n",
-				err);
-			goto err_node_put;
-		}
+		if (err < 0)
+			return dev_err_probe(dev, err,
+					     "failed to parse # of lanes\n");
 
-		if (value > 16) {
-			dev_err(dev, "invalid # of lanes: %u\n", value);
-			err = -EINVAL;
-			goto err_node_put;
-		}
+		if (value > 16)
+			return dev_err_probe(dev, -EINVAL,
+					     "invalid # of lanes: %u\n", value);
 
 		lanes |= value << (index << 3);
 
@@ -2159,16 +2151,12 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
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
@@ -2177,16 +2165,12 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
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
@@ -2199,34 +2183,26 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 						       GPIOD_OUT_LOW,
 						       label);
 		if (IS_ERR(rp->reset_gpio)) {
-			if (PTR_ERR(rp->reset_gpio) == -ENOENT) {
+			if (PTR_ERR(rp->reset_gpio) == -ENOENT)
 				rp->reset_gpio = NULL;
-			} else {
-				dev_err(dev, "failed to get reset GPIO: %ld\n",
-					PTR_ERR(rp->reset_gpio));
-				err = PTR_ERR(rp->reset_gpio);
-				goto err_node_put;
-			}
+			else
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
+		return dev_err_probe(dev, err,
+				     "invalid lane configuration\n");
 
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


