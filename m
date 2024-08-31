Return-Path: <linux-pci+bounces-12548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0E5966F48
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 06:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1391C21AE9
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 04:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D838528F;
	Sat, 31 Aug 2024 04:17:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E1A13B2B1
	for <linux-pci@vger.kernel.org>; Sat, 31 Aug 2024 04:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725077869; cv=none; b=P1YcMmcuieO6q2vWrsD25h/bKeqBKnNYMXALBvQkA0xfOeADL+J4Or3yNsOe6U24OhCEhAW4cg0ifX6QYPFVwXh2aV6e3Iiy3LHbtNfcijIaGEJrd6pyP6NaK+8pZUo+dwUmPbtr5LdbPb+kk0NrkvT4KDrD/aD+qGoCJslip7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725077869; c=relaxed/simple;
	bh=SoDZnpZrEETM5H3yNco3WBJgEXL/2J6Cwm0uODe3PGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtTMkHy+XhWy+Tee0ga8gMbt1If2PQANmYnmAf/8vsSG7yx/bE+W8yvSWaoc1Af1HiUn0VKyDVzahDCJFFztew0HNjlnJXeQKZn6YYq+z8+06iqQIHHfruEjaAJw0Z+1kHAUImXzcyYo/ZR+w5NDZ4/sVex1bAeM85An+fpSN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WwhYw501Dz1S9Z9;
	Sat, 31 Aug 2024 12:17:24 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 1EAC11400D7;
	Sat, 31 Aug 2024 12:17:40 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 31 Aug
 2024 12:17:38 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>, <Jonathan.Cameron@Huawei.com>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH v3 1/6] PCI: kirin: Use helper function for_each_available_child_of_node_scoped()
Date: Sat, 31 Aug 2024 12:04:08 +0800
Message-ID: <20240831040413.126417-2-zhangzekun11@huawei.com>
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
Fix spelling error in commit message.

 drivers/pci/controller/dwc/pcie-kirin.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 0a29136491b8..e9bda1746ca5 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -452,7 +452,7 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 				    struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *child, *node = dev->of_node;
+	struct device_node *node = dev->of_node;
 	void __iomem *apb_base;
 	int ret;
 
@@ -477,17 +477,13 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 		return ret;
 
 	/* Parse OF children */
-	for_each_available_child_of_node(node, child) {
+	for_each_available_child_of_node_scoped(node, child) {
 		ret = kirin_pcie_parse_port(kirin_pcie, pdev, child);
 		if (ret)
-			goto put_node;
+			return ret;
 	}
 
 	return 0;
-
-put_node:
-	of_node_put(child);
-	return ret;
 }
 
 static void kirin_pcie_sideband_dbi_w_mode(struct kirin_pcie *kirin_pcie,
-- 
2.17.1


