Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176892B44F4
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 14:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgKPNrf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 08:47:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8093 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgKPNre (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 08:47:34 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CZVk81SnkzLncW;
        Mon, 16 Nov 2020 21:47:12 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 16 Nov 2020
 21:47:26 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <Jisheng.Zhang@synaptics.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: dwc: fix error return code in dw_pcie_host_init()
Date:   Mon, 16 Nov 2020 21:50:23 +0800
Message-ID: <20201116135023.57321-1-wanghai38@huawei.com>
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
 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 44c2a6572199..7b3c91c6ae02 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -395,6 +395,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			if (dma_mapping_error(pci->dev, pp->msi_data)) {
 				dev_err(pci->dev, "Failed to map MSI data\n");
 				pp->msi_data = 0;
+				ret = -ENOMEM;
 				goto err_free_msi;
 			}
 		} else {
-- 
2.17.1

