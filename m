Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDF65A1039
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 14:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241541AbiHYMUP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 08:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241529AbiHYMUN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 08:20:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B244D5FF69;
        Thu, 25 Aug 2022 05:20:09 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MD26M2TsWzmV7n;
        Thu, 25 Aug 2022 20:17:47 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 20:20:07 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 25 Aug
 2022 20:20:07 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <bhelgaas@google.com>
Subject: [PATCH -next 2/3] PCI: fix possible memory leak in error case in pci_register_host_bridge()
Date:   Thu, 25 Aug 2022 20:27:52 +0800
Message-ID: <20220825122753.1838930-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220825122753.1838930-1-yangyingliang@huawei.com>
References: <20220825122753.1838930-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If device_register() fails in pci_register_host_bridge(), the refcount
of bus device is leaked, so device name that set by dev_set_name() can
not be freed. Fix this by calling put_device() when device_register()
fails, so the device name will be freed in kobject_cleanup().

Fixes: 37d6a0a6f470 ("PCI: Add pci_register_host_bridge() interface")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/pci/probe.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e500eb9d6468..292d9da146ce 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -948,8 +948,17 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	name = dev_name(&bus->dev);
 
 	err = device_register(&bus->dev);
-	if (err)
-		goto unregister;
+	if (err) {
+		/*
+		 * release_pcibus_dev() will decrease the refcount of bridge
+		 * device and free the memory of bus.
+		 * The memory of bus device name will be freed when the refcount
+		 * get to zero.
+		 */
+		put_device(&bus->dev);
+		device_unregister(&bridge->dev);
+		return err;
+	}
 
 	pcibios_add_bus(bus);
 
@@ -1025,10 +1034,6 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 
 	return 0;
 
-unregister:
-	put_device(&bridge->dev);
-	device_unregister(&bridge->dev);
-
 free:
 	kfree(bus);
 	return err;
-- 
2.25.1

