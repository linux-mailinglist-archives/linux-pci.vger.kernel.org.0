Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 281989DE36
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 08:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfH0Gqn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 02:46:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5662 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbfH0Gqn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 02:46:43 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EF80199B740A55BD5CC6;
        Tue, 27 Aug 2019 14:46:39 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Tue, 27 Aug 2019 14:46:30 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <bhelgaas@google.com>, <lukas@wunner.de>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>, <huawei.libin@huawei.com>,
        <guohanjun@huawei.com>
Subject: [PATCH] pci: get pm runtime ref before resetting bus
Date:   Tue, 27 Aug 2019 14:43:36 +0800
Message-ID: <1566888216-8810-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When I inject a PCIE Fatal error into a mellanox netdevice, 'dmesg' shows
the device is recovered successfully, but 'lspci' didn't show the
device. I checked the configuration space of the slot where the netdevice
is inserted and found out the bit 'PCI_BRIDGE_CTL_BUS_RESET' is set.
Later, I found out it is because this bit is saved in
'saved_config_space' of 'struct pci_dev' when 'pci_pm_runtime_suspend()'
is called. And 'PCI_BRIDGE_CTL_BUS_RESET' is set every time we restore
the configuration sapce.

This patch use 'pm_runtime_get' to avoid saving the configuration space
of the bridge when the bus is being reset.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/pci/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9cae66c..0079f0a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4546,6 +4546,9 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	u16 ctrl;
 
+	/* avoid wrongly saving 'PCI_BRIDGE_CTL_BUS_RESET' */
+	pm_runtime_get(&dev->dev);
+
 	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &ctrl);
 	ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
@@ -4567,6 +4570,8 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
 	 * but we don't make use of them yet.
 	 */
 	ssleep(1);
+
+	pm_runtime_put(&dev->dev);
 }
 
 void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
-- 
1.7.12.4

