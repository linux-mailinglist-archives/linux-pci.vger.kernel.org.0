Return-Path: <linux-pci+bounces-12327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610129621CA
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 09:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E841F24C56
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 07:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650B015B0E4;
	Wed, 28 Aug 2024 07:51:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2271552EB
	for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 07:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831512; cv=none; b=LeroYcYKungpN899FtJ+MwzfCtrAJz1ZAQgXjW2HAU+Zuh0ul0TEHpNyZqYAue/BaoQk24XCnptxIc5P8F5LrYYdZQBRgGcNcTY9nhBGeS0YyHxyGO7oNqU+S/f5D82AYOWz/3Fp7uPtTAPLXYumVuoTg1KuJtP+x+xKV/dKh9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831512; c=relaxed/simple;
	bh=Nftnqekf4BKkmnvCsFvjvPT5ViVvEdvBKoMh7tkLcrg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcF2p+O9dTpyYc8SHVE5EtEDgTnmHXtSLil6g4AagtFwqfhowmJtV6UQHirkYVRv88V6rq67ds6w0EW+tp6+qZxmJRE3e3n9by2de3MrBU7/g87KOtAQbu83k7sEo8h+kC56Gg7VYViRHyNtRwyTZqZZMe74K7L1UTeKmQ6BaCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtxQj5jS7zpTtB;
	Wed, 28 Aug 2024 15:50:05 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 9AE67180AE6;
	Wed, 28 Aug 2024 15:51:47 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 15:51:46 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH 2/5] PCI: mediatek: Use helper function for_each_available_child_of_node_scoped()
Date: Wed, 28 Aug 2024 15:38:22 +0800
Message-ID: <20240828073825.43072-3-zhangzekun11@huawei.com>
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

for_each_available_child_of_node_scoped() provides a scope-based cleanup
functinality to put the device_node automatically, and we don't need to
call of_node_put() directly.  Let's simplify the code a bit with the use
of these functions.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/pci/controller/pcie-mediatek.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 9be3cebd862e..d14e8d151c08 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -1042,24 +1042,24 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
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
 			if (err < 0) {
 				dev_err(dev, "failed to get devfn: %d\n", err);
-				goto error_put_node;
+				return err;
 			}
 
 			slot = PCI_SLOT(err);
 
 			err = mtk_pcie_parse_port(pcie, child, slot);
 			if (err)
-				goto error_put_node;
+				return err;
 		}
 	} else {
 		err = mtk_pcie_parse_port(pcie, node, slot);
@@ -1080,9 +1080,6 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 		mtk_pcie_subsys_powerdown(pcie);
 
 	return 0;
-error_put_node:
-	of_node_put(child);
-	return err;
 }
 
 static int mtk_pcie_probe(struct platform_device *pdev)
-- 
2.17.1


