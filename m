Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D227597D82
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 06:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242955AbiHREcr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 00:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241247AbiHREcr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 00:32:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A51A3D47;
        Wed, 17 Aug 2022 21:32:45 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M7X26562pzXdhY;
        Thu, 18 Aug 2022 12:28:30 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 12:32:43 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 18 Aug
 2022 12:32:42 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <bhelgaas@google.com>
Subject: [PATCH -next] PCI: switch to use pci_info()
Date:   Thu, 18 Aug 2022 12:40:51 +0800
Message-ID: <20220818044051.814538-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Commit 7506dc798993 ("PCI: Add wrappers for dev_printk()") introduce
pci_info() helper. Switch to use pci_info() to simplify the code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f2430da8a30b..e1572d41aa6d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1454,7 +1454,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		    (child->number > bus->busn_res.end) ||
 		    (child->number < bus->number) ||
 		    (child->busn_res.end < bus->number)) {
-			dev_info(&dev->dev, "devices behind bridge are unusable because %pR cannot be assigned for them\n",
+			pci_info(dev, "devices behind bridge are unusable because %pR cannot be assigned for them\n",
 				 &child->busn_res);
 			break;
 		}
-- 
2.25.1

