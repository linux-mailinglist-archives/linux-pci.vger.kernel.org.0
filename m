Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DCB625CFE
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbiKKO1f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiKKO1b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:27:31 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D96B1BA;
        Fri, 11 Nov 2022 06:27:29 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N81Cj0yfKzbng6;
        Fri, 11 Nov 2022 22:23:45 +0800 (CST)
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 22:27:27 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jianjay.zhou@huawei.com>, <zhuangshengen@huawei.com>,
        <arei.gonglei@huawei.com>, <yechuan@huawei.com>,
        <huangzhichao@huawei.com>, <xiehong@huawei.com>,
        Longpeng <longpeng2@huawei.com>
Subject: [RFC 2/4] pci/sriov: add vf_bitmap to mark the vf id allocation
Date:   Fri, 11 Nov 2022 22:27:20 +0800
Message-ID: <20221111142722.1172-3-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <20221111142722.1172-1-longpeng2@huawei.com>
References: <20221111142722.1172-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi100025.china.huawei.com (7.221.188.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Longpeng <longpeng2@huawei.com>

Add a bitmap to mark the vf id allocation, the can be use to
avoid the repeated allocations.

Signed-off-by: Longpeng <longpeng2@huawei.com>
---
 drivers/pci/iov.c | 13 +++++++++++++
 drivers/pci/pci.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 3b441cd92960..886489aae0de 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -341,6 +341,8 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 
 	pci_bus_add_device(virtfn);
 
+	__set_bit(id, iov->vf_bitmap);
+
 	return 0;
 
 failed1:
@@ -357,6 +359,7 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, int id)
 {
 	char buf[VIRTFN_ID_LEN];
 	struct pci_dev *virtfn;
+	struct pci_sriov *iov;
 
 	virtfn = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus),
 					     pci_iov_virtfn_bus(dev, id),
@@ -364,6 +367,9 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, int id)
 	if (!virtfn)
 		return;
 
+	iov = pci_physfn(dev)->sriov;
+	__clear_bit(id, iov->vf_bitmap);
+
 	sprintf(buf, "virtfn%u", id);
 	sysfs_remove_link(&dev->dev.kobj, buf);
 	/*
@@ -791,6 +797,11 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	if (!iov)
 		return -ENOMEM;
 
+	rc = -ENOMEM;
+	iov->vf_bitmap = bitmap_zalloc(total, GFP_KERNEL);
+	if (!iov->vf_bitmap)
+		goto free_iov;
+
 	nres = 0;
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = &dev->resource[i + PCI_IOV_RESOURCES];
@@ -853,6 +864,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 		res->flags = 0;
 	}
 
+free_iov:
 	kfree(iov);
 	return rc;
 }
@@ -864,6 +876,7 @@ static void sriov_release(struct pci_dev *dev)
 	if (dev != dev->sriov->dev)
 		pci_dev_put(dev->sriov->dev);
 
+	bitmap_free(dev->sriov->vf_bitmap);
 	kfree(dev->sriov);
 	dev->sriov = NULL;
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b1ebb7ab8805..a76d4ff83886 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -301,6 +301,7 @@ struct pci_sriov {
 	u16		subsystem_device; /* VF subsystem device */
 	resource_size_t	barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
 	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
+	unsigned long   *vf_bitmap;     /* Allocated VFs */
 };
 
 /**
-- 
2.23.0

