Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341A925BE1B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 11:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgICJJN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 05:09:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10807 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726109AbgICJJM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Sep 2020 05:09:12 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 747EB56EFF00A9C363B0;
        Thu,  3 Sep 2020 17:09:09 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Sep 2020 17:09:01 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>
CC:     <xuwei5@hisilicon.com>, <linuxarm@huawei.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <john.garry@huawei.com>,
        <salil.mehta@huawei.com>, <shiju.jose@huawei.com>,
        <jinying@hisilicon.com>, <zhangyi.ac@huawei.com>,
        <liguozhu@hisilicon.com>, <tangkunshan@huawei.com>,
        <huangdaode@hisilicon.com>, Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: exynos: simplify with PTR_ERR_OR_ZERO
Date:   Thu, 3 Sep 2020 17:05:16 +0800
Message-ID: <1599123916-65530-1-git-send-email-xuwei5@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use PTR_ERR_OR_ZERO to make the code a little bit simpler.
This code was detected with the help of Coccinelle.

Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 8d82c43..f59f027 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -90,10 +90,7 @@ static int exynos5440_pcie_get_mem_resources(struct platform_device *pdev,
 		return -ENOMEM;
 
 	ep->mem_res->elbi_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(ep->mem_res->elbi_base))
-		return PTR_ERR(ep->mem_res->elbi_base);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(ep->mem_res->elbi_base);
 }
 
 static int exynos5440_pcie_get_clk_resources(struct exynos_pcie *ep)
-- 
2.8.1

