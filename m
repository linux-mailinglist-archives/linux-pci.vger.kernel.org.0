Return-Path: <linux-pci+bounces-12480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF56965633
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 06:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0628F1F2490B
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 04:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAE3146D69;
	Fri, 30 Aug 2024 04:11:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A31422615
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 04:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724991113; cv=none; b=i4j8JQIiwRF4e75YzMB+6r3mqtvUZlcFW1LkdPw5DO3oxPZPHyR7+Jf0kdd4F5Wyw0XNG9nAH1L1JAW02U5FZkgu+l4oZ4tlpTBh1wIjjj4WSPL1r5RS3EPGp8bUYZXoJsaV5dt03kUc6q8CZGw/KkaNHkN8rF53CEM7tsne+Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724991113; c=relaxed/simple;
	bh=5ZKMl5sO6IGWVSJcI7zhHJVoGOUI5OFzQFFhapAiA5I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0w6LgZYClGJZJ5SXVZ9T1D/Elio8PHrUIVlpIO+nIGDYj0kEROu/fVgOoz9EeRBYNZUWCuUcZqKDtRDlDCcXmkoeprwsROugBos8waRXnf8/lwjvQ+VqjMk7MvWeSrTjAXSJOnsi1q8TvqF0ao/wOqGnVN+dK0RU6VrJf86Ews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Ww4Tf5YhWz1S9NJ;
	Fri, 30 Aug 2024 12:11:34 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id DE9E61402C6;
	Fri, 30 Aug 2024 12:11:48 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 12:11:47 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>, <Jonathan.Cameron@Huawei.com>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH v2 5/6] PCI: apple: Use helper function for_each_child_of_node_scoped()
Date: Fri, 30 Aug 2024 11:58:18 +0800
Message-ID: <20240830035819.13718-6-zhangzekun11@huawei.com>
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
call of_node_put() directly.  Let's simplify the code a bit with the
use of these functions.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2:
- Fix spelling error in commit message.

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


