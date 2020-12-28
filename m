Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55CC2E3B84
	for <lists+linux-pci@lfdr.de>; Mon, 28 Dec 2020 14:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406429AbgL1Nuz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Dec 2020 08:50:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9694 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404961AbgL1Nuz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Dec 2020 08:50:55 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D4Jn16RWXzkxTC;
        Mon, 28 Dec 2020 21:49:09 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Mon, 28 Dec 2020 21:49:59 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>, Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] pci: hotplug: Use DEFINE_SPINLOCK() for spinlock
Date:   Mon, 28 Dec 2020 21:50:38 +0800
Message-ID: <20201228135038.28401-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/pci/hotplug/cpqphp_nvram.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_nvram.c b/drivers/pci/hotplug/cpqphp_nvram.c
index 00cd2b43364f..7a65d427ac11 100644
--- a/drivers/pci/hotplug/cpqphp_nvram.c
+++ b/drivers/pci/hotplug/cpqphp_nvram.c
@@ -80,7 +80,7 @@ static u8 evbuffer[1024];
 static void __iomem *compaq_int15_entry_point;
 
 /* lock for ordering int15_bios_call() */
-static spinlock_t int15_lock;
+static DEFINE_SPINLOCK(int15_lock);
 
 
 /* This is a series of function that deals with
@@ -415,9 +415,6 @@ void compaq_nvram_init(void __iomem *rom_start)
 		compaq_int15_entry_point = (rom_start + ROM_INT15_PHY_ADDR - ROM_PHY_ADDR);
 
 	dbg("int15 entry  = %p\n", compaq_int15_entry_point);
-
-	/* initialize our int15 lock */
-	spin_lock_init(&int15_lock);
 }
 
 
-- 
2.22.0

