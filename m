Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054232724B8
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 15:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgIUNKn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 09:10:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727386AbgIUNKm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Sep 2020 09:10:42 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 009869A76134ABAF83D4;
        Mon, 21 Sep 2020 21:10:37 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:10:29 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] PCI: cadence: simplify the return expression of cdns_pcie_host_init_address_translation()
Date:   Mon, 21 Sep 2020 21:10:53 +0800
Message-ID: <20200921131053.92752-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 4550e0d46..811c1cb2e 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -337,7 +337,7 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 	struct resource_entry *entry;
 	u64 cpu_addr = cfg_res->start;
 	u32 addr0, addr1, desc1;
-	int r, err, busnr = 0;
+	int r, busnr = 0;
 
 	entry = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
 	if (entry)
@@ -383,11 +383,7 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 		r++;
 	}
 
-	err = cdns_pcie_host_map_dma_ranges(rc);
-	if (err)
-		return err;
-
-	return 0;
+	return cdns_pcie_host_map_dma_ranges(rc);
 }
 
 static int cdns_pcie_host_init(struct device *dev,
-- 
2.23.0

