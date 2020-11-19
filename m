Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28AE92B92F7
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 14:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgKSM5r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 07:57:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8122 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgKSM5r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2020 07:57:47 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CcKTH03pJzLqKp;
        Thu, 19 Nov 2020 20:57:23 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Nov 2020 20:57:37 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <kishon@ti.com>, <lorenzo.pieralisi@arm.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <gustavo.pimentel@synopsys.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH] misc: pci_endpoint_test: fix return value of error branch
Date:   Thu, 19 Nov 2020 20:49:18 +0800
Message-ID: <1605790158-6780-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We return 'err' in the error branch, but this variable may be set as
zero before. Fix it by setting 'err' as a negative value before we
goto the error label.

Fixes: e03327122e2c ("pci_endpoint_test: Add 2 ioctl commands")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/misc/pci_endpoint_test.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 146ca6f..d384473 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -811,8 +811,10 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	if (!pci_endpoint_test_alloc_irq_vectors(test, irq_type))
+	if (!pci_endpoint_test_alloc_irq_vectors(test, irq_type)) {
+		err = -EINVAL;
 		goto err_disable_irq;
+	}
 
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
@@ -849,8 +851,10 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		goto err_ida_remove;
 	}
 
-	if (!pci_endpoint_test_request_irq(test))
+	if (!pci_endpoint_test_request_irq(test)) {
+		err = -EINVAL;
 		goto err_kfree_test_name;
+	}
 
 	misc_device = &test->miscdev;
 	misc_device->minor = MISC_DYNAMIC_MINOR;
-- 
1.7.12.4

