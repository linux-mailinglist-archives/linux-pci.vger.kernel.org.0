Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147211003B8
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 12:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfKRLXc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 06:23:32 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6248 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726461AbfKRLXc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 06:23:32 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9D73AEFBDD49EEAC3445;
        Mon, 18 Nov 2019 19:23:29 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 18 Nov 2019
 19:23:23 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] PCI: kirin: Use PTR_ERR_OR_ZERO() to simplify code
Date:   Mon, 18 Nov 2019 19:30:46 +0800
Message-ID: <1574076646-51621-1-git-send-email-zhengbin13@huawei.com>
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

drivers/pci/controller/dwc/pcie-kirin.c:141:1-3: WARNING: PTR_ERR_OR_ZERO can be used
drivers/pci/controller/dwc/pcie-kirin.c:177:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index c19617a..5b2131f 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -138,10 +138,7 @@ static long kirin_pcie_get_clk(struct kirin_pcie *kirin_pcie,
 		return PTR_ERR(kirin_pcie->apb_sys_clk);

 	kirin_pcie->pcie_aclk = devm_clk_get(dev, "pcie_aclk");
-	if (IS_ERR(kirin_pcie->pcie_aclk))
-		return PTR_ERR(kirin_pcie->pcie_aclk);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(kirin_pcie->pcie_aclk);
 }

 static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
--
2.7.4

