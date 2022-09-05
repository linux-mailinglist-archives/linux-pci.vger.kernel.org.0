Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FB25AD476
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 16:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbiIEOCP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 10:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiIEOCO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 10:02:14 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F01EAEE3D;
        Mon,  5 Sep 2022 07:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Pi1na
        IghCtZpY2AFv6eJH51PFyGAYP4iWrNPySGgJsk=; b=fuPr5/wN6PDmBtr1p1nKV
        ElI+lP7U+R2s+smwa1Uqls4quD28z0ync5YLSRVCZrD9EFz96qGzOAmp2o8qUo02
        JMEM2tndc9TXqZ9XistwYagF90TPscWsvl1fP7WEXB6+49XGInuTAL+rag9v6pQ5
        j9vvrqIlsBfbscTYJbMmAM=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown [1.203.67.201])
        by smtp11 (Coremail) with SMTP id D8CowAAnPcFDARZj8ytLAA--.15537S4;
        Mon, 05 Sep 2022 22:02:03 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] pci: cleanup coding styling in pci-driver.c
Date:   Mon,  5 Sep 2022 22:01:36 +0800
Message-Id: <20220905140136.25066-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowAAnPcFDARZj8ytLAA--.15537S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFW8ZrWxJr1xKr4ktFykAFb_yoW8uw45pF
        Z3JayYkrW8JF47Xr4DtF4DAFyrAws2gayfKrWxGw1SgFsIyryDtF1rJFyYva4rArWkur47
        t3WDtr4I9a10qr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pERp9iUUUUU=
X-Originating-IP: [1.203.67.201]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/1tbishtzF1UMWRFl+wAAsC
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 drivers/pci/pci-driver.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 49238ddd39ee..bba486f5e5fe 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -204,6 +204,7 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 
 	if (fields != 7) {
 		struct pci_dev *pdev = kzalloc(sizeof(*pdev), GFP_KERNEL);
+
 		if (!pdev)
 			return -ENOMEM;
 
@@ -222,8 +223,8 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 			return retval;
 	}
 
-	/* Only accept driver_data values that match an existing id_table
-	   entry */
+	/* Only accept driver_data values that match an existing id_table entry
+	 */
 	if (ids) {
 		retval = -EINVAL;
 		while (ids->vendor || ids->subvendor || ids->class_mask) {
@@ -272,6 +273,7 @@ static ssize_t remove_id_store(struct device_driver *driver, const char *buf,
 	spin_lock(&pdrv->dynids.lock);
 	list_for_each_entry_safe(dynid, n, &pdrv->dynids.list, node) {
 		struct pci_device_id *id = &dynid->id;
+
 		if ((id->vendor == vendor) &&
 		    (id->device == device) &&
 		    (subvendor == PCI_ANY_ID || id->subvendor == subvendor) &&
@@ -537,6 +539,7 @@ static int pci_restore_standard_config(struct pci_dev *pci_dev)
 
 	if (pci_dev->current_state != PCI_D0) {
 		int error = pci_set_power_state(pci_dev, PCI_D0);
+
 		if (error)
 			return error;
 	}
@@ -705,6 +708,7 @@ static int pci_pm_prepare(struct device *dev)
 
 	if (pm && pm->prepare) {
 		int error = pm->prepare(dev);
+
 		if (error < 0)
 			return error;
 
@@ -1364,7 +1368,7 @@ static int pci_pm_runtime_idle(struct device *dev)
 		return 0;
 
 	if (!pm)
-		return -ENOSYS;
+		return -ENODEV;
 
 	if (pm->runtime_idle)
 		return pm->runtime_idle(dev);
@@ -1471,6 +1475,7 @@ struct pci_driver *pci_dev_driver(const struct pci_dev *dev)
 		return dev->driver;
 	else {
 		int i;
+
 		for (i = 0; i <= PCI_ROM_RESOURCE; i++)
 			if (dev->resource[i].flags & IORESOURCE_BUSY)
 				return &pci_compat_driver;

base-commit: e47eb90a0a9ae20b82635b9b99a8d0979b757ad8
-- 
2.34.1

