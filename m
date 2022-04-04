Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDFC4F0F59
	for <lists+linux-pci@lfdr.de>; Mon,  4 Apr 2022 08:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343643AbiDDG1n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Apr 2022 02:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiDDG1m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2022 02:27:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFA81D0E3;
        Sun,  3 Apr 2022 23:25:46 -0700 (PDT)
Received: from canpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KX13f663qz1HBNx;
        Mon,  4 Apr 2022 14:25:18 +0800 (CST)
Received: from localhost (10.174.151.254) by canpemm500001.china.huawei.com
 (7.192.104.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 14:25:42 +0800
From:   Jay Zhou <jianjay.zhou@huawei.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>, <alex.williamson@redhat.com>
CC:     <weidong.huang@huawei.com>, <jianjay.zhou@huawei.com>
Subject: [PATCH] pci: avoid dead lock between device reset and sriov disable
Date:   Mon, 4 Apr 2022 14:25:39 +0800
Message-ID: <20220404062539.1710-1-jianjay.zhou@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.254]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500001.china.huawei.com (7.192.104.163)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Call trace of PF SRIOV disable:
sriov_numvfs_store
  device_lock <----------------- (1) get the device lock
    ->sriov_configure # e.g. vfio_pci_sriov_configure
      sriov_disable
        pci_cfg_access_lock <--- (4) wait dev->block_cfg_access to be 0

Call trace of PF reset:
reset_store
  pci_reset_function
    pci_dev_lock
      pci_cfg_access_lock <----- (2) set dev->block_cfg_access = 1
      device_lock <------------- (3) want to get the device lock

These two oprations would wait for each other forever if the
code execution sequence is (1)(2)(3)(4).

Let's get the device lock and then the config access lock in
pci_dev_lock().

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 drivers/pci/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9ecce435fb3f..61a6db1d21f6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5103,19 +5103,19 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 
 void pci_dev_lock(struct pci_dev *dev)
 {
-	pci_cfg_access_lock(dev);
 	/* block PM suspend, driver probe, etc. */
 	device_lock(&dev->dev);
+	pci_cfg_access_lock(dev);
 }
 EXPORT_SYMBOL_GPL(pci_dev_lock);
 
 /* Return 1 on successful lock, 0 on contention */
 int pci_dev_trylock(struct pci_dev *dev)
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
@@ -5124,8 +5124,8 @@ EXPORT_SYMBOL_GPL(pci_dev_trylock);
 
 void pci_dev_unlock(struct pci_dev *dev)
 {
-	device_unlock(&dev->dev);
 	pci_cfg_access_unlock(dev);
+	device_unlock(&dev->dev);
 }
 EXPORT_SYMBOL_GPL(pci_dev_unlock);
 
-- 
2.27.0

