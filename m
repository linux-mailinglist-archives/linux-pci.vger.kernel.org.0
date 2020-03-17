Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE17187D91
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 10:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCQJ5u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 05:57:50 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45820 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgCQJ5t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 05:57:49 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02H9vctk102689;
        Tue, 17 Mar 2020 04:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584439058;
        bh=Qn54HiHLXxL4X4GP8bGGjKHr8oEaF9XMRKoZm8J/so4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=W98Mlig9Qp+9AaYGa8+VU/axZR3TVo4qCBRBNntMVNe8SS4yqz4qbbo907yhp/fir
         P0/BZcjXPLsUHhNa5X4gieTuvlj1SPdu/B6YHM/5prOthlMNGEqbBMdqrA+KJMLY5T
         X7xv/7RmT6HL2vjgCKCOa1n+8A2hJRoCUyYgigiM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02H9vcVl023169;
        Tue, 17 Mar 2020 04:57:38 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Mar 2020 04:57:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Mar 2020 04:57:37 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02H9vIKW095155;
        Tue, 17 Mar 2020 04:57:35 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 5/5] misc: pci_endpoint_test: Use full pci-endpoint-test name in request irq
Date:   Tue, 17 Mar 2020 15:31:58 +0530
Message-ID: <20200317100158.4692-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200317100158.4692-1-kishon@ti.com>
References: <20200317100158.4692-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use full pci-endpoint-test name in request irq, so that it's easy to
profile the device that actually raised the interrupt.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index ef21d2d2f8ae..bc3ae4a4fb5c 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -109,6 +109,7 @@ struct pci_endpoint_test {
 	struct miscdevice miscdev;
 	enum pci_barno test_reg_bar;
 	size_t alignment;
+	const char *name;
 };
 
 struct pci_endpoint_test_data {
@@ -227,7 +228,7 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 	for (i = 0; i < test->num_irqs; i++) {
 		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
 				       pci_endpoint_test_irqhandler,
-				       IRQF_SHARED, DRV_MODULE_NAME, test);
+				       IRQF_SHARED, test->name, test);
 		if (err)
 			goto fail;
 	}
@@ -807,9 +808,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	if (!pci_endpoint_test_alloc_irq_vectors(test, irq_type))
 		goto err_disable_irq;
 
-	if (!pci_endpoint_test_request_irq(test))
-		goto err_disable_irq;
-
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
 			base = pci_ioremap_bar(pdev, bar);
@@ -839,12 +837,21 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	}
 
 	snprintf(name, sizeof(name), DRV_MODULE_NAME ".%d", id);
+	test->name = kstrdup(name, GFP_KERNEL);
+	if (!test->name) {
+		err = -ENOMEM;
+		goto err_ida_remove;
+	}
+
+	if (!pci_endpoint_test_request_irq(test))
+		goto err_kfree_test_name;
+
 	misc_device = &test->miscdev;
 	misc_device->minor = MISC_DYNAMIC_MINOR;
 	misc_device->name = kstrdup(name, GFP_KERNEL);
 	if (!misc_device->name) {
 		err = -ENOMEM;
-		goto err_ida_remove;
+		goto err_release_irq;
 	}
 	misc_device->fops = &pci_endpoint_test_fops,
 
@@ -859,6 +866,12 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 err_kfree_name:
 	kfree(misc_device->name);
 
+err_release_irq:
+	pci_endpoint_test_release_irq(test);
+
+err_kfree_test_name:
+	kfree(test->name);
+
 err_ida_remove:
 	ida_simple_remove(&pci_endpoint_test_ida, id);
 
@@ -867,7 +880,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		if (test->bar[bar])
 			pci_iounmap(pdev, test->bar[bar]);
 	}
-	pci_endpoint_test_release_irq(test);
 
 err_disable_irq:
 	pci_endpoint_test_free_irq_vectors(test);
@@ -893,6 +905,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 
 	misc_deregister(&test->miscdev);
 	kfree(misc_device->name);
+	kfree(test->name);
 	ida_simple_remove(&pci_endpoint_test_ida, id);
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (test->bar[bar])
-- 
2.17.1

