Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B637725F2
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 15:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjHGNhf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 09:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjHGNhd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 09:37:33 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CE91B3
        for <linux-pci@vger.kernel.org>; Mon,  7 Aug 2023 06:37:31 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RKHQp6xBPz1K9KX;
        Mon,  7 Aug 2023 21:36:18 +0800 (CST)
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
Subject: [PATCH 1/3] PCI: apple: use pci_dev_id() to simplify the code
Date:   Mon, 7 Aug 2023 21:48:56 +0800
Message-ID: <20230807134858.116051-2-wangxiongfeng2@huawei.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI core API pci_dev_id() can be used to get the BDF number for a pci
device. We don't need to compose it mannually using PCI_DEVID(). Use
pci_dev_id() to simplify the code a little bit.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/pci/controller/pcie-apple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 66f37e403a09..2abca318e22a 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -670,7 +670,7 @@ static struct apple_pcie_port *apple_pcie_get_port(struct pci_dev *pdev)
 static int apple_pcie_add_device(struct apple_pcie_port *port,
 				 struct pci_dev *pdev)
 {
-	u32 sid, rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
+	u32 sid, rid = pci_dev_id(pdev);
 	int idx, err;
 
 	dev_dbg(&pdev->dev, "added to bus %s, index %d\n",
@@ -701,7 +701,7 @@ static int apple_pcie_add_device(struct apple_pcie_port *port,
 static void apple_pcie_release_device(struct apple_pcie_port *port,
 				      struct pci_dev *pdev)
 {
-	u32 rid = PCI_DEVID(pdev->bus->number, pdev->devfn);
+	u32 rid = pci_dev_id(pdev);
 	int idx;
 
 	mutex_lock(&port->pcie->lock);
-- 
2.20.1

