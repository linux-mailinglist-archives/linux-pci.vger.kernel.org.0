Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD001EBCB2
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 15:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgFBNKt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 09:10:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40342 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgFBNKt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jun 2020 09:10:49 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A47F8BF05A7B39E22515;
        Tue,  2 Jun 2020 21:10:44 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 2 Jun 2020
 21:10:36 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <hayashi.kunihiko@socionext.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] PCI: uniphier: Fix Kconfig warning
Date:   Tue, 2 Jun 2020 21:10:33 +0800
Message-ID: <20200602131033.41780-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

WARNING: unmet direct dependencies detected for PCIE_DW_EP
  Depends on [n]: PCI [=y] && PCI_ENDPOINT [=n]
  Selected by [y]:
  - PCIE_UNIPHIER_EP [=y] && PCI [=y] && (ARCH_UNIPHIER || COMPILE_TEST [=y]) && OF [=y] && HAS_IOMEM [=y]

Add missing dependency to fix this.

Fixes: 006564dee825 ("PCI: uniphier: Add Socionext UniPhier Pro5 PCIe endpoint controller driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pci/controller/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 43a29f7a4501..044a3761c44f 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -293,6 +293,7 @@ config PCIE_UNIPHIER_EP
 	bool "Socionext UniPhier PCIe endpoint controllers"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
 	depends on OF && HAS_IOMEM
+	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	help
 	  Say Y here if you want PCIe endpoint controller support on
-- 
2.17.1


