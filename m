Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB38263B00
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 04:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbgIJB60 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 21:58:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38792 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729717AbgIJBmA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Sep 2020 21:42:00 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1F70173F049F34145939;
        Thu, 10 Sep 2020 09:41:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Sep 2020 09:41:46 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] PCI: dwc: Do not export local function dw_pcie_link_set_max_speed
Date:   Thu, 10 Sep 2020 09:39:26 +0800
Message-ID: <1599701966-38778-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

WARNING: modpost: "dw_pcie_link_set_max_speed" [vmlinux] is a static
EXPORT_SYMBOL_GPL
Fixes: 3af45d34d30c ("PCI: dwc: Centralize link gen setting")

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 1 -
 mm/madvise.c                                 | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 4d105ef..3c3a4d1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -508,7 +508,6 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
 	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | link_speed);
 
 }
-EXPORT_SYMBOL_GPL(dw_pcie_link_set_max_speed);
 
 static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
 {
diff --git a/mm/madvise.c b/mm/madvise.c
index c5acc2b..8c175f9 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -30,7 +30,6 @@
 #include <linux/swapops.h>
 #include <linux/shmem_fs.h>
 #include <linux/mmu_notifier.h>
-#include <linux/sched/mm.h>
 
 #include <asm/tlb.h>
 
-- 
2.7.4

