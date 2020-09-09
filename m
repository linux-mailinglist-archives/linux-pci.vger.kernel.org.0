Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A45263379
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 19:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbgIIPpU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 11:45:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11325 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730450AbgIIPpS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Sep 2020 11:45:18 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 83E9722A8BAE0B106767;
        Wed,  9 Sep 2020 21:42:51 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:42:44 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] PCI: dwc: unexport dw_pcie_link_set_max_speed
Date:   Wed, 9 Sep 2020 21:42:34 +0800
Message-ID: <20200909134234.31204-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This function has been made static, which causes warning:

WARNING: modpost: "dw_pcie_link_set_max_speed" [vmlinux] is a static EXPORT_SYMBOL_GPL

Fixes: 3af45d34d30c ("PCI: dwc: Centralize link gen setting")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 4d105efb5722..3c3a4d1dbc0b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -508,7 +508,6 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | link_speed);
 
 }
-EXPORT_SYMBOL_GPL(dw_pcie_link_set_max_speed);
 
 static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
 {
-- 
2.17.1


