Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50E01B8E9C
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2019 12:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbfITKqV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Sep 2019 06:46:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732138AbfITKqV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Sep 2019 06:46:21 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EDE72A0D9F2F7E1AE577;
        Fri, 20 Sep 2019 18:46:18 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 20 Sep 2019
 18:46:12 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <vidyas@nvidia.com>,
        <yuehaibing@huawei.com>, <treding@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next] PCI: tegra: Add missing include file
Date:   Fri, 20 Sep 2019 18:39:25 +0800
Message-ID: <20190920103925.34404-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190920014807.38288-1-yuehaibing@huawei.com>
References: <20190920014807.38288-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix build error without CONFIG_PINCTRL

drivers/pci/controller/dwc/pcie-tegra194.c: In function tegra_pcie_config_rp:
drivers/pci/controller/dwc/pcie-tegra194.c:1394:8: error: implicit declaration of function pinctrl_pm_select_default_state;
 did you mean prandom_seed_full_state? [-Werror=implicit-function-declaration]
  ret = pinctrl_pm_select_default_state(dev);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        prandom_seed_full_state

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: ab2a50e7602b ("PCI: tegra: Add support to configure sideband pins")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
---
v2: keep alphabetical order
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 09ed8e4..f89f5ac 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -22,6 +22,7 @@
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
-- 
2.7.4


