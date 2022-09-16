Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328735BAEA9
	for <lists+linux-pci@lfdr.de>; Fri, 16 Sep 2022 15:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiIPN43 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 09:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiIPN42 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 09:56:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCE75584
        for <linux-pci@vger.kernel.org>; Fri, 16 Sep 2022 06:56:26 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MTb9c2FmjzmVPm;
        Fri, 16 Sep 2022 21:52:36 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 16 Sep 2022 21:56:24 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 16 Sep
 2022 21:56:24 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-pci@vger.kernel.org>
CC:     <bhelgaas@google.com>, <logang@deltatee.com>, <hch@lst.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] PCI/P2PDMA: Switch to use for_each_pci_dev() helper
Date:   Fri, 16 Sep 2022 22:03:29 +0800
Message-ID: <20220916140329.679633-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use for_each_pci_dev() instead of open-coding it.
No functional change.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/pci/p2pdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4496a7c5c478..88dc66ee1c46 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -649,7 +649,7 @@ struct pci_dev *pci_p2pmem_find_many(struct device **clients, int num_clients)
 	if (!closest_pdevs)
 		return NULL;
 
-	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev))) {
+	for_each_pci_dev(pdev) {
 		if (!pci_has_p2pmem(pdev))
 			continue;
 
-- 
2.25.1

