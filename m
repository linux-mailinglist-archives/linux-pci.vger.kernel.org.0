Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E01B60243B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Oct 2022 08:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJRGTF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Oct 2022 02:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJRGTE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Oct 2022 02:19:04 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98170A50D2
        for <linux-pci@vger.kernel.org>; Mon, 17 Oct 2022 23:19:03 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ms3V340BPz1P74h
        for <linux-pci@vger.kernel.org>; Tue, 18 Oct 2022 14:14:19 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 14:18:35 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 14:18:34 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-pci@vger.kernel.org>
CC:     <bhelgaas@google.com>, <yangyingliang@huawei.com>
Subject: [PATCH] PCI: fix possible memory leak in error case in pci_register_host_bridge()
Date:   Tue, 18 Oct 2022 14:17:46 +0800
Message-ID: <20221018061746.2392717-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If device_register() fails in pci_register_host_bridge(), the refcount
of bus device is leaked, so device name that set by dev_set_name() can
not be freed. Fix this by calling put_device() when device_register()
fails, so the device name will be freed in kobject_cleanup().

The 'bus' is freed in release_pcibus_dev(), so set it to NULL to avoid
double free.

The refcount of bridge device is decreased in release_pcibus_dev(), so
remove the put_device() in error path and change error label name.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/pci/probe.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f61754d76aa7..03b926d7c7ec 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -946,8 +946,11 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	name = dev_name(&bus->dev);
 
 	err = device_register(&bus->dev);
-	if (err)
-		goto unregister;
+	if (err) {
+		put_device(&bus->dev);
+		bus = NULL;
+		goto del_device;
+	}
 
 	pcibios_add_bus(bus);
 
@@ -1023,8 +1026,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 
 	return 0;
 
-unregister:
-	put_device(&bridge->dev);
+del_device:
 	device_del(&bridge->dev);
 
 free:
-- 
2.25.1

