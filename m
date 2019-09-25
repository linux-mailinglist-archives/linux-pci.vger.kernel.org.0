Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9F6FBDFBC
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2019 16:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407518AbfIYONL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Sep 2019 10:13:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406676AbfIYONL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Sep 2019 10:13:11 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EDCBBD5EB6873397190D;
        Wed, 25 Sep 2019 22:13:08 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Wed, 25 Sep 2019 22:12:59 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Subject: [PATCH] PCI: mobiveil: Fix csr_read/write build issue
Date:   Wed, 25 Sep 2019 22:21:21 +0800
Message-ID: <20190925142121.56607-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The riscv has csr_read/write macro, see arch/riscv/include/asm/csr.h,
the same function naming will cause build error, rename them to
__csr_read/write to fix it.

drivers/pci/controller/pcie-mobiveil.c:238:69: error: macro "csr_read" passed 3 arguments, but takes just 1
 static u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)

drivers/pci/controller/pcie-mobiveil.c:253:80: error: macro "csr_write" passed 4 arguments, but takes just 2
 static void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)

Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Minghuan Lian <Minghuan.Lian@nxp.com>
Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Fixes: bcbe0d9a8d93 ("PCI: mobiveil: Unify register accessors")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/pci/controller/pcie-mobiveil.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index a45a6447b01d..7ba1138c3667 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -235,7 +235,7 @@ static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val)
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
+static u32 __csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
 {
 	void *addr;
 	u32 val;
@@ -250,7 +250,7 @@ static u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
 	return val;
 }
 
-static void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)
+static void __csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)
 {
 	void *addr;
 	int ret;
@@ -264,12 +264,12 @@ static void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)
 
 static u32 csr_readl(struct mobiveil_pcie *pcie, u32 off)
 {
-	return csr_read(pcie, off, 0x4);
+	return __csr_read(pcie, off, 0x4);
 }
 
 static void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)
 {
-	csr_write(pcie, val, off, 0x4);
+	__csr_write(pcie, val, off, 0x4);
 }
 
 static bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
-- 
2.20.1

