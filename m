Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286D55A1036
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 14:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241535AbiHYMUN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 08:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239990AbiHYMUM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 08:20:12 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DFD5D0EB;
        Thu, 25 Aug 2022 05:20:09 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MD24z6kPfz1N7Rq;
        Thu, 25 Aug 2022 20:16:35 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 20:20:07 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 25 Aug
 2022 20:20:06 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <bhelgaas@google.com>
Subject: [PATCH -next 1/3] PCI: fix double put_device() in error case in pci_create_root_bus()
Date:   Thu, 25 Aug 2022 20:27:51 +0800
Message-ID: <20220825122753.1838930-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
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

If device_add() fails in pci_register_host_bridge(), the brigde device will
be put once, and it will be put again in error path of pci_create_root_bus().
Move the put_device() from pci_create_root_bus() to pci_register_host_bridge()
to fix this problem. And use device_unregister() instead of del_device() and
put_device().

Fixes: 9885440b16b8 ("PCI: Fix pci_host_bridge struct device release/free handling")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/pci/probe.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c5286b027f00..e500eb9d6468 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1027,7 +1027,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 
 unregister:
 	put_device(&bridge->dev);
-	device_del(&bridge->dev);
+	device_unregister(&bridge->dev);
 
 free:
 	kfree(bus);
@@ -3037,13 +3037,9 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 
 	error = pci_register_host_bridge(bridge);
 	if (error < 0)
-		goto err_out;
+		return NULL;
 
 	return bridge->bus;
-
-err_out:
-	put_device(&bridge->dev);
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(pci_create_root_bus);
 
-- 
2.25.1

