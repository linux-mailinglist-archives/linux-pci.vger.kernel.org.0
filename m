Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1791003A5
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 12:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfKRLSO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 06:18:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7133 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbfKRLSO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 06:18:14 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 76FA1B027C2DF58F8C9A;
        Mon, 18 Nov 2019 19:18:11 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 18 Nov 2019
 19:18:05 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <yue.wang@Amlogic.com>, <lorenzo.pieralisi@arm.com>,
        <andrew.murray@arm.com>, <bhelgaas@google.com>,
        <khilman@baylibre.com>, <linux-pci@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] PCI: amlogic: Use PTR_ERR_OR_ZERO() to simplify code
Date:   Mon, 18 Nov 2019 19:25:29 +0800
Message-ID: <1574076329-48893-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes coccicheck warning:

drivers/pci/controller/dwc/pci-meson.c:300:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 3772b02..38902a6 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -297,10 +297,7 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
 		return PTR_ERR(res->general_clk);

 	res->clk = meson_pcie_probe_clock(dev, "pclk", 0);
-	if (IS_ERR(res->clk))
-		return PTR_ERR(res->clk);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(res->clk);
 }

 static inline void meson_elb_writel(struct meson_pcie *mp, u32 val, u32 reg)
--
2.7.4

