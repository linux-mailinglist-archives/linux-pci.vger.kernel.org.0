Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854BE37265A
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 09:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhEDHMN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 03:12:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:18341 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhEDHMN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 May 2021 03:12:13 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FZ9tM3QQMzCqjG;
        Tue,  4 May 2021 15:08:43 +0800 (CST)
Received: from huawei.com (10.175.100.227) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Tue, 4 May 2021
 15:11:08 +0800
From:   Tang Yizhou <tangyizhou@huawei.com>
To:     <jianjun.wang@mediatek.com>, <lorenzo.pieralisi@arm.com>,
        <ryder.lee@mediatek.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <tangyizhou@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] PCI: mediatek-gen3: Add missing MODULE_DEVICE_TABLE
Date:   Tue, 4 May 2021 15:28:38 +0800
Message-ID: <20210504072838.20093-1-tangyizhou@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.100.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 3c5b97716d40..f3aeb8d4eaca 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1012,6 +1012,7 @@ static const struct of_device_id mtk_pcie_of_match[] = {
 	{ .compatible = "mediatek,mt8192-pcie" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, mtk_pcie_of_match);
 
 static struct platform_driver mtk_pcie_driver = {
 	.probe = mtk_pcie_probe,
-- 
2.22.0

