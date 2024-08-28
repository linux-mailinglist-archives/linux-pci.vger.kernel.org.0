Return-Path: <linux-pci+bounces-12329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C3C9621CC
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 09:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B641C23C05
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 07:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F4F15B109;
	Wed, 28 Aug 2024 07:51:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C8A158A04
	for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831513; cv=none; b=Cpk1Y6je+zPN5UEiOAqQ8Hcm1Gqv8ktV1j2a3smipAol5Acl4M1HgaOjA5qDpuWHxCF57ccXjRwAl4sx58em8AQVO/m3HqIJWOgAgLPbmH/4hr3c2ehJTMpc2/uie6JR4nh0mAX6W9rCIsiIJn9cbQppqwKtXRvxZ8AzsSWMApw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831513; c=relaxed/simple;
	bh=s/RZ5Op0SHFsFAHxNX9PzxkEk5CdJXWmJoLNQUC8iYo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDhw3fMK4tvmhJOjoNh0adFMoyu7agH3gqvi6Xje1siUQXV+UH17/4dVEVEhaskI84E5dUM3DLlInk1PLKJ1U3Yys1NUNYIeE5POvxpCcrYagAwJcpNNYazvQqlCcP0uUbzoylwNVG0OtitRw/fZhWoKAUuwwDorz+2W75yOxb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WtxM82bMWzQqyv;
	Wed, 28 Aug 2024 15:47:00 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 06A4A14035E;
	Wed, 28 Aug 2024 15:51:50 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 15:51:48 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH 4/5] PCI: apple: Use helper function for_each_child_of_node_scoped()
Date: Wed, 28 Aug 2024 15:38:24 +0800
Message-ID: <20240828073825.43072-5-zhangzekun11@huawei.com>
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
call of_node_put() directly.  Let's simplify the code a bit with the
use of these functions.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/pci/controller/pcie-apple.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index fefab2758a06..f1bd20a64b67 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -764,7 +764,6 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
 	struct platform_device *platform = to_platform_device(dev);
-	struct device_node *of_port;
 	struct apple_pcie *pcie;
 	int ret;
 
@@ -787,11 +786,10 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 	if (ret)
 		return ret;
 
-	for_each_child_of_node(dev->of_node, of_port) {
+	for_each_child_of_node_scoped(dev->of_node, of_port) {
 		ret = apple_pcie_setup_port(pcie, of_port);
 		if (ret) {
 			dev_err(pcie->dev, "Port %pOF setup fail: %d\n", of_port, ret);
-			of_node_put(of_port);
 			return ret;
 		}
 	}
-- 
2.17.1


