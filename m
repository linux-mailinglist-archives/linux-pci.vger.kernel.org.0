Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E1E26457E
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 13:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgIJLvO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 07:51:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11782 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728350AbgIJLs4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Sep 2020 07:48:56 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B60049C957E8873C6616;
        Thu, 10 Sep 2020 19:48:48 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Sep 2020 19:48:42 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Dongdong Liu <liudongdong3@huawei.com>
Subject: [PATCH] PCI/LINK: Print IRQ number used by port
Date:   Thu, 10 Sep 2020 19:24:15 +0800
Message-ID: <1599737055-73624-1-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.78.228.23]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Print IRQ number used by PCIe Link Bandwidth Notification services port
as AER, PME and DPC does. It provides convenience to track PCIe BW notif
interrupts counts of certain port from /proc/interrupts.

The dmesg log is as below.
pcieport 0000:00:00.0: bw_notification: enabled with IRQ 1166

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 drivers/pci/pcie/bw_notification.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
index 77e6857..565d23c 100644
--- a/drivers/pci/pcie/bw_notification.c
+++ b/drivers/pci/pcie/bw_notification.c
@@ -14,6 +14,8 @@
  * and warns when links become degraded in operation.
  */
 
+#define dev_fmt(fmt) "bw_notification: " fmt
+
 #include "../pci.h"
 #include "portdrv.h"
 
@@ -97,6 +99,7 @@ static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
 		return ret;
 
 	pcie_enable_link_bandwidth_notification(srv->port);
+	pci_info(srv->port, "enabled with IRQ %d\n", srv->irq);
 
 	return 0;
 }
-- 
1.9.1

