Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215002B59C9
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 07:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgKQGix (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 01:38:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8102 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQGix (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 01:38:53 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CZx92514GzLnW8;
        Tue, 17 Nov 2020 14:38:30 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Tue, 17 Nov 2020
 14:38:46 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <Jisheng.Zhang@synaptics.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] PCI: dwc: fix error return code in dw_pcie_host_init()
Date:   Tue, 17 Nov 2020 14:41:42 +0800
Message-ID: <20201117064142.32903-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 07940c369a6b ("PCI: dwc: Fix MSI page leakage in suspend/resume")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
v1->v2: just add 'ret = xxx'
 drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 44c2a6572199..42d8116a4a00 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -392,7 +392,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 						      sizeof(pp->msi_msg),
 						      DMA_FROM_DEVICE,
 						      DMA_ATTR_SKIP_CPU_SYNC);
-			if (dma_mapping_error(pci->dev, pp->msi_data)) {
+			ret = dma_mapping_error(pci->dev, pp->msi_data);
+			if (ret) {
 				dev_err(pci->dev, "Failed to map MSI data\n");
 				pp->msi_data = 0;
 				goto err_free_msi;
-- 
2.17.1

