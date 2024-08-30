Return-Path: <linux-pci+bounces-12477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA6F965630
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 06:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0D61C21948
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 04:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A54481AB;
	Fri, 30 Aug 2024 04:11:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC1413E022
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 04:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724991109; cv=none; b=g9tSE7zNLbKAnLQJt3E94jngU3VL4p4mNoZQ9cAJdZABsR4RTtHJ72L1QK6toNL4BU/Db25kxt7UnfdzMmMibYa3CRuRmqdPAj8H+GrvCZWa4O1xLBYssjACJjZhLSrVE94+XVN38R4pDY4iiVom/nNqc9rv4xH8xuBPzfJwRxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724991109; c=relaxed/simple;
	bh=OhtXePJGXOjNU9M11aCMDQDhQIb3hu+fHQlKOCoAKl4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uUcKJ1ZUS5ozDmZR5UdOZLwYDDKRFIVtll1vbTVhlZf0gHWX5+y1ODBfRhV4kNMNtHBgVKXau3220akJkf0r4Es+uYOv9rg1NR6vMDSYyue+tqUo1IaqNrF0r8pshjRKsl3J7C7MlyZOKmYS5eVI7MSZGqt+ChQXOgRgxWEgOQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ww4NF6vMtz20n86;
	Fri, 30 Aug 2024 12:06:53 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 392531A016C;
	Fri, 30 Aug 2024 12:11:45 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 12:11:43 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>, <Jonathan.Cameron@Huawei.com>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH v2 2/6] PCI: kirin: Tidy up _probe() related function with dev_err_probe()
Date: Fri, 30 Aug 2024 11:58:15 +0800
Message-ID: <20240830035819.13718-3-zhangzekun11@huawei.com>
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

The combination of dev_err() and the returned error code could be
replaced by dev_err_probe() in driver's probe function. Let's,
converting to dev_err_probe() to make code more simple.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 36 +++++++++----------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index e9bda1746ca5..fc0a71575085 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -216,10 +216,8 @@ static int hi3660_pcie_phy_start(struct hi3660_pcie_phy *phy)
 
 	usleep_range(PIPE_CLK_WAIT_MIN, PIPE_CLK_WAIT_MAX);
 	reg_val = kirin_apb_phy_readl(phy, PCIE_APB_PHY_STATUS0);
-	if (reg_val & PIPE_CLK_STABLE) {
-		dev_err(dev, "PIPE clk is not stable\n");
-		return -EINVAL;
-	}
+	if (reg_val & PIPE_CLK_STABLE)
+		return dev_err_probe(dev, -EINVAL, "PIPE clk is not stable\n");
 
 	return 0;
 }
@@ -371,10 +369,8 @@ static int kirin_pcie_get_gpio_enable(struct kirin_pcie *pcie,
 	if (ret < 0)
 		return 0;
 
-	if (ret > MAX_PCI_SLOTS) {
-		dev_err(dev, "Too many GPIO clock requests!\n");
-		return -EINVAL;
-	}
+	if (ret > MAX_PCI_SLOTS)
+		return dev_err_probe(dev, -EINVAL, "Too many GPIO clock requests!\n");
 
 	pcie->n_gpio_clkreq = ret;
 
@@ -421,16 +417,12 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
 			}
 
 			pcie->num_slots++;
-			if (pcie->num_slots > MAX_PCI_SLOTS) {
-				dev_err(dev, "Too many PCI slots!\n");
-				return -EINVAL;
-			}
+			if (pcie->num_slots > MAX_PCI_SLOTS)
+				return dev_err_probe(dev, -EINVAL, "Too many PCI slots!\n");
 
 			ret = of_pci_get_devfn(child);
-			if (ret < 0) {
-				dev_err(dev, "failed to parse devfn: %d\n", ret);
-				return ret;
-			}
+			if (ret < 0)
+				return dev_err_probe(dev, ret, "failed to parse devfn\n");
 
 			slot = PCI_SLOT(ret);
 
@@ -725,16 +717,12 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie *pci;
 	int ret;
 
-	if (!dev->of_node) {
-		dev_err(dev, "NULL node\n");
-		return -EINVAL;
-	}
+	if (!dev->of_node)
+		return dev_err_probe(dev, -EINVAL, "NULL node\n");
 
 	data = of_device_get_match_data(dev);
-	if (!data) {
-		dev_err(dev, "OF data missing\n");
-		return -EINVAL;
-	}
+	if (!data)
+		return dev_err_probe(dev, -EINVAL, "OF data missing\n");
 
 	kirin_pcie = devm_kzalloc(dev, sizeof(struct kirin_pcie), GFP_KERNEL);
 	if (!kirin_pcie)
-- 
2.17.1


