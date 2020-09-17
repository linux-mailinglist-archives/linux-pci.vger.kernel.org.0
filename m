Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29DA26D3FB
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 08:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgIQGzk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 02:55:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58792 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbgIQGzi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 02:55:38 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 02:55:36 EDT
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3711F80CEEBCA9F8F72E;
        Thu, 17 Sep 2020 14:55:34 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 14:55:25 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Liu Shixin" <liushixin2@huawei.com>
Subject: [PATCH -next] PCI: dwc: Remove set but not used variable
Date:   Thu, 17 Sep 2020 15:17:58 +0800
Message-ID: <20200917071758.1915565-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/pci/controller/dwc/pci-dra7xx.c: In function 'dra7xx_pcie_establish_link':
drivers/pci/controller/dwc/pci-dra7xx.c:142:6: warning: unused variable 'exp_cap_off'
[-Wunused-variable]

After 3af45d34d30c ("PCI: dwc: Centralize link gen setting"), variable 'exp_cap_off'
is never used. Remove it to avoid build warning.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 69cd43f74260..7bac7c54b2aa 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -139,7 +139,7 @@ static int dra7xx_pcie_establish_link(struct dw_pcie *pci)
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
 	struct device *dev = pci->dev;
 	u32 reg;
-	u32 exp_cap_off = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 
 	if (dw_pcie_link_up(pci)) {
 		dev_err(dev, "link is already up\n");
-- 
2.25.1

