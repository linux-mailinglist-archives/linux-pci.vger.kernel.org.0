Return-Path: <linux-pci+bounces-12547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719AD966F47
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 06:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D2E1F236EA
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 04:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE683139CFE;
	Sat, 31 Aug 2024 04:17:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB61B3611B
	for <linux-pci@vger.kernel.org>; Sat, 31 Aug 2024 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725077867; cv=none; b=JaOc+CB682v9vFug5WYTGWowQKdo5byyN5exucouLSOgBrLa2wgNT7k/xHvqT3XLQgGi9unRv7awt2xxsH1zF/hMZR5CeX7A5FHtDigK5WMF1LmTO9M/qg+aWa5N8luXXwkxMT+5e244AhJ7qavOpPjeUZKehEuU3twQpZ+kxtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725077867; c=relaxed/simple;
	bh=49Ow1kO12qALPYi7338X/bYneYFnzwYtQr6Fsm4oHQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrDPvioha1jBKIHFyAZEAyLg6niLjIzuAaYdevyEHyxfwgeeKwOMTCyT3Wj4hw+D/tJkzpQAjPtqEyTVM631C6O8rmZSZ5dTLfzR4MAC4USl0Hx3gat5uE6ZtSUVmWhZ8GNpn8nJnr6DOCqsTPORrqdQ0yPI0E9Qj3qPwFyxqYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WwhZ050npz2CpHq;
	Sat, 31 Aug 2024 12:17:28 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 847D4180043;
	Sat, 31 Aug 2024 12:17:43 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 31 Aug
 2024 12:17:42 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>, <Jonathan.Cameron@Huawei.com>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH v3 4/6] PCI: mt7621: Use helper function for_each_available_child_of_node_scoped()
Date: Sat, 31 Aug 2024 12:04:11 +0800
Message-ID: <20240831040413.126417-5-zhangzekun11@huawei.com>
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
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v3: Fix spelling error in commit message.

v2: Use dev_perr_probe to simplify code.

 drivers/pci/controller/pcie-mt7621.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index 9b4754a45515..354d401428f0 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -258,30 +258,25 @@ static int mt7621_pcie_parse_dt(struct mt7621_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	struct device_node *node = dev->of_node, *child;
+	struct device_node *node = dev->of_node;
 	int err;
 
 	pcie->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pcie->base))
 		return PTR_ERR(pcie->base);
 
-	for_each_available_child_of_node(node, child) {
+	for_each_available_child_of_node_scoped(node, child) {
 		int slot;
 
 		err = of_pci_get_devfn(child);
-		if (err < 0) {
-			of_node_put(child);
-			dev_err(dev, "failed to parse devfn: %d\n", err);
-			return err;
-		}
+		if (err < 0)
+			return dev_err_probe(dev, err, "failed to parse devfn\n");
 
 		slot = PCI_SLOT(err);
 
 		err = mt7621_pcie_parse_port(pcie, child, slot);
-		if (err) {
-			of_node_put(child);
+		if (err)
 			return err;
-		}
 	}
 
 	return 0;
-- 
2.17.1


