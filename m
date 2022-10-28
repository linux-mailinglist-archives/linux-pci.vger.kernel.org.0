Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90436108A4
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 05:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiJ1DSp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 23:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbiJ1DSK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 23:18:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3101DA8CFB
        for <linux-pci@vger.kernel.org>; Thu, 27 Oct 2022 20:18:09 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mz70S18G1zmVcy;
        Fri, 28 Oct 2022 11:13:12 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 11:18:04 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 11:18:03 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-pci@vger.kernel.org>
CC:     <yinghai@kernel.org>, <bhelgaas@google.com>,
        <rafael.j.wysocki@intel.com>, <yangyingliang@huawei.com>
Subject: [PATCH] PCI: fix handle error case in pci_alloc_child_bus()
Date:   Fri, 28 Oct 2022 11:17:09 +0800
Message-ID: <20221028031709.3120927-1-yangyingliang@huawei.com>
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

If device_register() returns error in pci_alloc_child_bus(), but it's not
handled, the 'bridge->subordinate' points a bus that is not registered,
it will lead kernel crash because of trying to delete unregistered device
in pci_remove_bus_device().

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000108
CPU: 48 PID: 38377 Comm: bash Kdump: loaded Tainted: G        W          6.1.0-rc1+ #172
Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.58 10/24/2018
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : device_del+0x54/0x3d0
lr : device_del+0x37c/0x3d0
Call trace:
 device_del+0x54/0x3d0
 device_unregister+0x24/0x78
 pci_remove_bus+0x90/0xa0
 pci_remove_bus_device+0x128/0x138
 pci_stop_and_remove_bus_device_locked+0x2c/0x40
 remove_store+0xa4/0xb

Beside, the 'child' allocated by pci_alloc_bus() and the name allocated by
dev_set_name() need be freed, and also the refcount of bridge and of_node
which is get in pci_alloc_child_bus() need be put.

Fix these by setting 'bridge->subordinate' to NULL and calling put_device(),
if device_register() returns error, and return NULL in pci_alloc_child_bus().

Fixes: 4f535093cf8f ("PCI: Put pci_dev in device tree as early as possible")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/pci/probe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 792dfee9cfd7..afd564f49f06 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1139,7 +1139,11 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 add_dev:
 	pci_set_bus_msi_domain(child);
 	ret = device_register(&child->dev);
-	WARN_ON(ret < 0);
+	if (WARN_ON(ret < 0)) {
+		bridge->subordinate = NULL;
+		put_device(&child->dev);
+		return NULL;
+	}
 
 	pcibios_add_bus(child);
 
-- 
2.25.1

