Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DA56357BF
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 10:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbiKWJpw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 04:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238214AbiKWJpO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 04:45:14 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0810774A81
        for <linux-pci@vger.kernel.org>; Wed, 23 Nov 2022 01:42:52 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NHGPS55xCzRpQc
        for <linux-pci@vger.kernel.org>; Wed, 23 Nov 2022 17:42:20 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 17:42:50 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <bhelgaas@google.com>, <gregkh@suse.de>,
        <linux-pci@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH v2] PCI: cpqphp: Fix error handling in cpqhpc_init()
Date:   Wed, 23 Nov 2022 09:40:50 +0000
Message-ID: <20221123094050.11457-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The cpqhpc_init() returns the result of pci_register_driver() without
checking it, if pci_register_driver() failed, the debugfs created in
cpqhp_initialize_debugfs() is not removed, resulting the debugfs of
cpqhp can never be created later.

Fix by calling cpqhp_shutdown_debugfs() when pci_register_driver() failed.

Fixes: 9f3f4681291f ("[PATCH] PCI Hotplug: fix up the sysfs file in the compaq pci hotplug driver")
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
Changes in v2:
- change commit message format
- change to the suggested way of error handling
 drivers/pci/hotplug/cpqphp_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
index c94b40e64baf..928b141bbdc1 100644
--- a/drivers/pci/hotplug/cpqphp_core.c
+++ b/drivers/pci/hotplug/cpqphp_core.c
@@ -1387,8 +1387,11 @@ static int __init cpqhpc_init(void)
 	cpqhp_debug = debug;
 
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
-	cpqhp_initialize_debugfs();
 	result = pci_register_driver(&cpqhpc_driver);
+	if (result)
+		return result;
+
+	cpqhp_initialize_debugfs();
 	dbg("pci_register_driver = %d\n", result);
 	return result;
 }
-- 
2.17.1

