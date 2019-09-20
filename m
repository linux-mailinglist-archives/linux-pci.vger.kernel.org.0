Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCC2B8903
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2019 03:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390808AbfITBuW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Sep 2019 21:50:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46972 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390286AbfITBuW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Sep 2019 21:50:22 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 050E4FDE5DA791F94F33;
        Fri, 20 Sep 2019 09:50:21 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 20 Sep 2019
 09:50:14 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <vidyas@nvidia.com>,
        <yuehaibing@huawei.com>, <treding@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] PCI: tegra: Add missing include file
Date:   Fri, 20 Sep 2019 09:48:07 +0800
Message-ID: <20190920014807.38288-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
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
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 09ed8e4..b219d3b2 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -28,6 +28,7 @@
 #include <linux/reset.h>
 #include <linux/resource.h>
 #include <linux/types.h>
+#include <linux/pinctrl/consumer.h>
 #include "pcie-designware.h"
 #include <soc/tegra/bpmp.h>
 #include <soc/tegra/bpmp-abi.h>
-- 
2.7.4


