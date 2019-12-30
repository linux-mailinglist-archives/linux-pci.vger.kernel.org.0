Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 339EE12D001
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2019 13:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfL3Mbk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Dec 2019 07:31:40 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33384 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfL3Mbk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Dec 2019 07:31:40 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBUCVX4V065599;
        Mon, 30 Dec 2019 06:31:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577709093;
        bh=k383SgYvrZOses1OYvohCYRsQU04lSCHiU+tY0yKKY4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AuhWXSKYUSGLsCYxQN+EFlK4x2ymRRJCnbIM9lgGeQpEDmDVHmFu14kHL4OADOq90
         Ww7wUyEygN8XBWiHNrY70CQ8UrfSk4FrB1sy25lgFdE/aVrz0WDYBGAXIF2eR75w5I
         2uRvRAy40fq7MDjKW9CXOEI0hFmUkEcHomXe0xeg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBUCVX0I112470;
        Mon, 30 Dec 2019 06:31:33 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 30
 Dec 2019 06:31:33 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 30 Dec 2019 06:31:33 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBUCVEhS002491;
        Mon, 30 Dec 2019 06:31:31 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] misc: pci_endpoint_test: Use full pci-endpoint-test name in request irq
Date:   Mon, 30 Dec 2019 18:03:14 +0530
Message-ID: <20191230123315.31037-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230123315.31037-1-kishon@ti.com>
References: <20191230123315.31037-1-kishon@ti.com>
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
 drivers/misc/pci_endpoint_test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index b622e234f57c..dae450c1a653 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -108,6 +108,7 @@ struct pci_endpoint_test {
 	struct miscdevice miscdev;
 	enum pci_barno test_reg_bar;
 	size_t alignment;
+	const char *name;
 };
 
 struct pci_endpoint_test_data {
@@ -226,7 +227,7 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 	for (i = 0; i < test->num_irqs; i++) {
 		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
 				       pci_endpoint_test_irqhandler,
-				       IRQF_SHARED, DRV_MODULE_NAME, test);
+				       IRQF_SHARED, test->name, test);
 		if (err)
 			goto fail;
 	}
@@ -752,6 +753,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		dev_err(dev, "Failed to register device\n");
 		goto err_kfree_name;
 	}
+	test->name = kstrdup(name, GFP_KERNEL);
 
 	return 0;
 
@@ -792,6 +794,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 
 	misc_deregister(&test->miscdev);
 	kfree(misc_device->name);
+	kfree(test->name);
 	ida_simple_remove(&pci_endpoint_test_ida, id);
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (test->bar[bar])
-- 
2.17.1

