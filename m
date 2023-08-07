Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003267725F0
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 15:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjHGNhe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 09:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjHGNhd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 09:37:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93A6E5B
        for <linux-pci@vger.kernel.org>; Mon,  7 Aug 2023 06:37:31 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKHN9040SztRyP;
        Mon,  7 Aug 2023 21:34:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 21:37:27 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <alyssa@rosenzweig.io>, <maz@kernel.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <mahesh@linux.ibm.com>, <oohall@gmail.com>
CC:     <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
        <yangyingliang@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH 2/3] PCI/AER: Use pci_dev_id() to simplify the code
Date:   Mon, 7 Aug 2023 21:48:57 +0800
Message-ID: <20230807134858.116051-3-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230807134858.116051-1-wangxiongfeng2@huawei.com>
References: <20230807134858.116051-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI core API pci_dev_id() can be used to get the BDF number for a pci
device. We don't need to compose it mannually. Use pci_dev_id() to
simplify the code a little bit.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/pci/pcie/aer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f6c24ded134c..2bc03937452b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -712,7 +712,7 @@ static void __aer_print_error(struct pci_dev *dev,
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	int layer, agent;
-	int id = ((dev->bus->number << 8) | dev->devfn);
+	int id = pci_dev_id(dev);
 	const char *level;
 
 	if (!info->status) {
@@ -847,7 +847,7 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 	if ((PCI_BUS_NUM(e_info->id) != 0) &&
 	    !(dev->bus->bus_flags & PCI_BUS_FLAGS_NO_AERSID)) {
 		/* Device ID match? */
-		if (e_info->id == ((dev->bus->number << 8) | dev->devfn))
+		if (e_info->id == pci_dev_id(dev))
 			return true;
 
 		/* Continue id comparing if there is no multiple error */
-- 
2.20.1

