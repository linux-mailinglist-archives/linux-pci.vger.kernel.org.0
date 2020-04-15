Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0FC1A963C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 10:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635899AbgDOIXi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Apr 2020 04:23:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59730 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2635882AbgDOIXg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Apr 2020 04:23:36 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E105FAA5669E20D52871;
        Wed, 15 Apr 2020 16:23:34 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Apr 2020
 16:23:26 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <amurray@thegoodpenguin.co.uk>,
        <bhelgaas@google.com>, <p.zabel@pengutronix.de>,
        <gustavo.pimentel@synopsys.com>, <yanaijie@huawei.com>,
        <andriy.shevchenko@intel.com>, <eswara.kota@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] PCI: dwc: intel: make intel_pcie_cpu_addr() static
Date:   Wed, 15 Apr 2020 16:49:53 +0800
Message-ID: <20200415084953.6533-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix the following sparse warning:

drivers/pci/controller/dwc/pcie-intel-gw.c:456:5: warning: symbol
'intel_pcie_cpu_addr' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index fc2a12212dec..2d8dbb318087 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -453,7 +453,7 @@ static int intel_pcie_msi_init(struct pcie_port *pp)
 	return 0;
 }
 
-u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
+static u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
 {
 	return cpu_addr + BUS_IATU_OFFSET;
 }
-- 
2.21.1

