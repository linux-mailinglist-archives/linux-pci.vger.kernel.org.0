Return-Path: <linux-pci+bounces-12326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E14BF9621C9
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 09:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2EB1F21B99
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 07:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D75A15A86A;
	Wed, 28 Aug 2024 07:51:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9CD158A04
	for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831511; cv=none; b=V5ta7pm9OwH2pFMhYyRHe4uifOlBVKoe7dowubIhuRZV+dG9n3zsH2udQa/oHMHRcjD9OvqbjoOBVeKBUoBIEiVWgxHuPSwZvt6fXrpZPqnY9U/bHWuA3Jm9R8KFw/6vHc6sxeGb7i1Cea9Nh7rk5i8vfHTTl2KHtj6aIQ9gqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831511; c=relaxed/simple;
	bh=kgj8GVDnZlWVRCPTBuTw0brAryjVz+5O8NGArmuU4Uw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qAhVOdkphjJsO04p/JyuykHTbTfchWXsJ9ojFH2wIz+CYoBUrMngPPG0hsnhOf+EmCQQE7GEvyAK3Wy2V+DOj/awdqNQuzoFJyF2CrOXJaUMuWSA0lBwJBHxY3OFhdluZVmHWZLBadOU1I8dTuvw3Zzp5umvuzWfMoy8CZFGStc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WtxS41lJ2zyR4Y;
	Wed, 28 Aug 2024 15:51:16 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D30918007C;
	Wed, 28 Aug 2024 15:51:46 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 15:51:45 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH 1/5] PCI: kirin: Use helper function for_each_available_child_of_node_scoped()
Date: Wed, 28 Aug 2024 15:38:21 +0800
Message-ID: <20240828073825.43072-2-zhangzekun11@huawei.com>
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


