Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA496633983
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 11:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiKVKPt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 05:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiKVKPs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 05:15:48 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682BA391E3
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2022 02:15:46 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NGg9m69rpzHw5h
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2022 18:15:08 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 22 Nov
 2022 18:15:44 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <bhelgaas@google.com>, <gregkh@suse.de>,
        <linux-pci@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH] PCI: cpqphp: Fix error handling in cpqhpc_init()
Date:   Tue, 22 Nov 2022 10:13:46 +0000
Message-ID: <20221122101346.80461-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 drivers/pci/hotplug/cpqphp_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
index c94b40e64baf..c47981ef92ea 100644
--- a/drivers/pci/hotplug/cpqphp_core.c
+++ b/drivers/pci/hotplug/cpqphp_core.c
@@ -1389,6 +1389,8 @@ static int __init cpqhpc_init(void)
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 	cpqhp_initialize_debugfs();
 	result = pci_register_driver(&cpqhpc_driver);
+	if (result)
+		cpqhp_shutdown_debugfs();
 	dbg("pci_register_driver = %d\n", result);
 	return result;
 }
-- 
2.17.1

