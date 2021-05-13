Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177DB37F759
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 14:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhEMME0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 08:04:26 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2061 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbhEMMEZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 08:04:25 -0400
Received: from dggeme759-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fgqv43424zWhxY;
        Thu, 13 May 2021 19:58:56 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 13 May 2021 20:03:13 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <p.zabel@pengutronix.de>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH] PCI: tegra: move to use request_irq by IRQF_NO_AUTOEN flag
Date:   Thu, 13 May 2021 20:03:14 +0800
Message-ID: <1620907394-55649-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

request_irq() after setting IRQ_NOAUTOEN as below
irq_set_status_flags(irq, IRQ_NOAUTOEN);
request_irq(dev, irq...);
can be replaced by request_irq() with IRQF_NO_AUTOEN flag.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index bafd2c6..7349926 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2021,14 +2021,13 @@ static int tegra_pcie_config_ep(struct tegra_pcie_dw *pcie,
 		return -ENOMEM;
 	}
 
-	irq_set_status_flags(pcie->pex_rst_irq, IRQ_NOAUTOEN);
-
 	pcie->ep_state = EP_STATE_DISABLED;
 
 	ret = devm_request_threaded_irq(dev, pcie->pex_rst_irq, NULL,
 					tegra_pcie_ep_pex_rst_irq,
 					IRQF_TRIGGER_RISING |
-					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					IRQF_TRIGGER_FALLING |
+					IRQF_ONESHOT | IRQF_NO_AUTOEN
 					name, (void *)pcie);
 	if (ret < 0) {
 		dev_err(dev, "Failed to request IRQ for PERST: %d\n", ret);
-- 
2.7.4

