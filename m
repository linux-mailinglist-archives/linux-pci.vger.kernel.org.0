Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9799355323
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 14:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343701AbhDFMHF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 08:07:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15495 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343692AbhDFMHC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 08:07:02 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FF5mp4S8Zzrd7S;
        Tue,  6 Apr 2021 20:04:42 +0800 (CST)
Received: from mdc.localdomain (10.175.104.57) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 20:06:42 +0800
From:   Huang Guobin <huangguobin4@huawei.com>
To:     <huangguobin4@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] PCI: Use DEFINE_SPINLOCK() for spinlock
Date:   Tue, 6 Apr 2021 20:06:37 +0800
Message-ID: <1617710797-48903-1-git-send-email-huangguobin4@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Guobin Huang <huangguobin4@huawei.com>

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Guobin Huang <huangguobin4@huawei.com>
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
 
 

