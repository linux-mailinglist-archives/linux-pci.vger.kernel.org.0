Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AE6452D8D
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 10:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhKPJMK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 04:12:10 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:15825 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbhKPJMJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Nov 2021 04:12:09 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HtgGT3hNbz918F;
        Tue, 16 Nov 2021 17:08:49 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Tue, 16 Nov 2021 17:09:09 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggema772-chm.china.huawei.com (10.1.198.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Tue, 16 Nov 2021 17:09:09 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>, <daniel.thompson@linaro.org>,
        <joro@8bytes.org>, <john.garry@huawei.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>
CC:     <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>, <song.bao.hua@hisilicon.com>
Subject: [PATCH v2 1/6] iommu: Export iommu_{get,put}_resv_regions()
Date:   Tue, 16 Nov 2021 17:06:20 +0800
Message-ID: <20211116090625.53702-2-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211116090625.53702-1-yangyicong@hisilicon.com>
References: <20211116090625.53702-1-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Export iommu_{get,put}_resv_regions() to the modules so that the driver
can retrieve and use the reserved regions of the device.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/iommu/iommu.c | 2 ++
 include/linux/iommu.h | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index dd7863e453a5..e96711eee965 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2792,6 +2792,7 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 	if (ops && ops->get_resv_regions)
 		ops->get_resv_regions(dev, list);
 }
+EXPORT_SYMBOL_GPL(iommu_get_resv_regions);
 
 void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 {
@@ -2800,6 +2801,7 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 	if (ops && ops->put_resv_regions)
 		ops->put_resv_regions(dev, list);
 }
+EXPORT_SYMBOL_GPL(iommu_put_resv_regions);
 
 /**
  * generic_iommu_put_resv_regions - Reserved region driver helper
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d2f3435e7d17..1b7b0f370e28 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -450,8 +450,8 @@ extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t io
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
 			iommu_fault_handler_t handler, void *token);
 
-extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
-extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
+void iommu_get_resv_regions(struct device *dev, struct list_head *list);
+void iommu_put_resv_regions(struct device *dev, struct list_head *list);
 extern void generic_iommu_put_resv_regions(struct device *dev,
 					   struct list_head *list);
 extern void iommu_set_default_passthrough(bool cmd_line);
-- 
2.33.0

