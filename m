Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8A7152826
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2020 10:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgBEJWF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Feb 2020 04:22:05 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45228 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728035AbgBEJWF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Feb 2020 04:22:05 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0F697B646FFE7539EDF6;
        Wed,  5 Feb 2020 17:22:04 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Wed, 5 Feb 2020 17:21:56 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>, <huangdaode@huawei.com>
Subject: [PATCH 1/2] PCI: Change lock order in pci_dev_lock()
Date:   Wed, 5 Feb 2020 17:18:03 +0800
Message-ID: <1580894283-20790-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In pci_dev_lock(), we hold pci_lock for configuration access first,
then is device_lock. But in sriov enable routine, we hold device_lock
first and pci_lock subsequently. The inconsistent lock order  will have
potential deadlock problem.

In pci_dev_lock():
pci_dev_lock()
	pci_cfg_access_lock()
	device_lock()

When adding VF by sysfs:
sriov_numvfs_store()
	device_lock()
		...
		sriov_enable()
			pci_cfg_access_lock()

Adjust the lock order in pci_dev_lock(), pci_dev_trylock() and
pci_dev_unlock() to avoid potential deadlock condition.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/pci.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e87196c..78c99ef 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4876,18 +4876,19 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
 
 static void pci_dev_lock(struct pci_dev *dev)
 {
-	pci_cfg_access_lock(dev);
 	/* block PM suspend, driver probe, etc. */
 	device_lock(&dev->dev);
+
+	pci_cfg_access_lock(dev);
 }
 
 /* Return 1 on successful lock, 0 on contention */
 static int pci_dev_trylock(struct pci_dev *dev)
 {
-	if (pci_cfg_access_trylock(dev)) {
-		if (device_trylock(&dev->dev))
+	if (device_trylock(&dev->dev)) {
+		if (pci_cfg_access_trylock(dev))
 			return 1;
-		pci_cfg_access_unlock(dev);
+		device_unlock(&dev->dev);
 	}
 
 	return 0;
@@ -4895,8 +4896,8 @@ static int pci_dev_trylock(struct pci_dev *dev)
 
 static void pci_dev_unlock(struct pci_dev *dev)
 {
-	device_unlock(&dev->dev);
 	pci_cfg_access_unlock(dev);
+	device_unlock(&dev->dev);
 }
 
 static void pci_dev_save_and_disable(struct pci_dev *dev)
-- 
2.8.1

