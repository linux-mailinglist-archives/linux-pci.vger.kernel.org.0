Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37FBE46319
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 17:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfFNPlg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 11:41:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbfFNPlg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 11:41:36 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BDF8DA992A2F1DCED3A4;
        Fri, 14 Jun 2019 23:41:31 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 14 Jun 2019
 23:41:23 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kishon@ti.com>, <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] PCI: dwc: pci-dra7xx: Add missing include file
Date:   Fri, 14 Jun 2019 23:40:44 +0800
Message-ID: <20190614154044.4972-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix build error:

drivers/pci/controller/dwc/pci-dra7xx.c:
 In function dra7xx_pcie_probe:
drivers/pci/controller/dwc/pci-dra7xx.c:777:10:
 error: implicit declaration of function devm_gpiod_get_optional;
 did you mean devm_regulator_get_optional? [-Werror=implicit-function-declaration]

  reset = devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH);

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 419451e..4234ddb 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -26,6 +26,7 @@
 #include <linux/types.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/gpio/consumer.h>
 
 #include "../../pci.h"
 #include "pcie-designware.h"
-- 
2.7.4


