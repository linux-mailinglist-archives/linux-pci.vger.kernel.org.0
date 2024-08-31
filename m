Return-Path: <linux-pci+bounces-12545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22407966F45
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 06:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6FA1F23A18
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 04:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5048225DA;
	Sat, 31 Aug 2024 04:17:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD50E13958C
	for <linux-pci@vger.kernel.org>; Sat, 31 Aug 2024 04:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725077866; cv=none; b=kKKPfNmuRZRxZ/0w6nZ4TMAOdRYZGZPUtz+9hLNFgsYSSHP/JTUVknqUA1GvmGaiDq4P6utQDlrxoOXluLTocvvWklXw3ur6XAuWECMwogqTCfn6jdmJ70XGLWVGkT4kax3WK3oq2Zf7OvNq4aAkZrm+8F5aYHy4NRB8zJBC8pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725077866; c=relaxed/simple;
	bh=HvM5+IHzUhJCsL1YaLw+A52Oj3dNsCeQkbzL0Gli1YQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvSRtCSF3XDKPavr9vezCdWN7twSx3WcMegJq6SdMsksTF4NF5iOcdyNDF7p9RD10V1jcCZmIrF+H4ipUjwX82M+ZLN7rZqHEEHl7dcILMQShoOTbhdY/uzK07Pn/FSNCjYR4rbz+rwpoi82jqOUQf1nEyHRqetLBsUuiN/BRsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WwhWs1TbKzgYj7;
	Sat, 31 Aug 2024 12:15:37 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 63D081800CF;
	Sat, 31 Aug 2024 12:17:42 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 31 Aug
 2024 12:17:41 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>, <Jonathan.Cameron@Huawei.com>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH v3 3/6] PCI: mediatek: Use helper function for_each_available_child_of_node_scoped()
Date: Sat, 31 Aug 2024 12:04:10 +0800
Message-ID: <20240831040413.126417-4-zhangzekun11@huawei.com>
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

for_each_available_child_of_node_scoped() provides a scope-based cleanup
functionality to put the device_node automatically, and we don't need to
call of_node_put() directly.  Let's simplify the code a bit with the use
of these functions.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2:
- Use dev_err_probe() to simplify code.
- Fix spelling error in commit message.

 drivers/pci/controller/pcie-mediatek.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 9be3cebd862e..0457b9d0ad8b 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -1042,24 +1042,22 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
 static int mtk_pcie_setup(struct mtk_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
-	struct device_node *node = dev->of_node, *child;
+	struct device_node *node = dev->of_node;
 	struct mtk_pcie_port *port, *tmp;
 	int err, slot;
 
 	slot = of_get_pci_domain_nr(dev->of_node);
 	if (slot < 0) {
-		for_each_available_child_of_node(node, child) {
+		for_each_available_child_of_node_scoped(node, child) {
 			err = of_pci_get_devfn(child);
-			if (err < 0) {
-				dev_err(dev, "failed to get devfn: %d\n", err);
-				goto error_put_node;
-			}
+			if (err < 0)
+				return dev_err_probe(dev, err, "failed to get devfn\n");
 
 			slot = PCI_SLOT(err);
 
 			err = mtk_pcie_parse_port(pcie, child, slot);
 			if (err)
-				goto error_put_node;
+				return err;
 		}
 	} else {
 		err = mtk_pcie_parse_port(pcie, node, slot);
@@ -1080,9 +1078,6 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 		mtk_pcie_subsys_powerdown(pcie);
 
 	return 0;
-error_put_node:
-	of_node_put(child);
-	return err;
 }
 
 static int mtk_pcie_probe(struct platform_device *pdev)
-- 
2.17.1


