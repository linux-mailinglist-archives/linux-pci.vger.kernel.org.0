Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B9B622709
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 10:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiKIJcP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 04:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiKIJcM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 04:32:12 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03BD220DA;
        Wed,  9 Nov 2022 01:32:11 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N6fqj18HGzHvXn;
        Wed,  9 Nov 2022 17:31:45 +0800 (CST)
Received: from huawei.com (10.67.175.83) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 17:32:09 +0800
From:   ruanjinjie <ruanjinjie@huawei.com>
To:     <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <mani@kernel.org>,
        <kishon@kernel.org>, <bhelgaas@google.com>, <ntb@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH] NTB: EPF: fix possible memory leak in pci_vntb_probe()
Date:   Wed, 9 Nov 2022 17:28:52 +0800
Message-ID: <20221109092852.3549528-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.83]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As ntb_register_device() don't handle error of device_register(),
if ntb_register_device() returns error in pci_vntb_probe(), name of kobject
which is allocated in dev_set_name() called in device_add() is leaked.

As comment of device_add() says, it should call put_device() to drop the
reference count that was set in device_initialize()
when it fails, so the name can be freed in kobject_cleanup().

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 0ea85e1d292e..5aeb028281aa 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1266,6 +1266,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_register_dev:
+	put_device(&ndev->ntb.dev);
 	return -EINVAL;
 }
 
-- 
2.25.1

