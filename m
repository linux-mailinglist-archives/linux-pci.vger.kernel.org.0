Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA3E112CFFC
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2019 13:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfL3Mba (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Dec 2019 07:31:30 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33346 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfL3Mba (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Dec 2019 07:31:30 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBUCVKVb065543;
        Mon, 30 Dec 2019 06:31:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577709080;
        bh=iUve48Cr1mGxUmUX5fWUT0DFtlcnvm91lMesp5aocLw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yU60qJ+OIQFQqXY4q8e2wbNPg+5CyuP09EDbaTnR7667eNGgKuqePveRM8LnRRXWp
         L8nQgAD4FPRVvo2utlq42cFpQP5/6m8Z18t47uBVHIpdEqsfuaqLIVxz5grcLl3Y43
         7TK9AC1VOFbyuB3ShAJmUUgIa0V5SFmUooiDBpFY=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBUCVKvg112284;
        Mon, 30 Dec 2019 06:31:20 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 30
 Dec 2019 06:31:20 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 30 Dec 2019 06:31:20 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBUCVEhN002491;
        Mon, 30 Dec 2019 06:31:18 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] misc: pci_endpoint_test: Avoid using module parameter to determine irqtype
Date:   Mon, 30 Dec 2019 18:03:09 +0530
Message-ID: <20191230123315.31037-2-kishon@ti.com>
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

commit e03327122e2c8e6ae4565ef ("pci_endpoint_test: Add 2 ioctl
commands") uses module parameter in pci_endpoint_test_set_irq()
'irqtype' to check if irq vectors of a particular type is already
allocated. However with multi-function devices, irqtype will not
correctly reflect the irq type of the PCI device. Fix it here by
adding 'irqtype' for each PCI device to show the irq type of a
particular PCI device.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 215f9b8432a3..743ff4dcb3f0 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -99,6 +99,7 @@ struct pci_endpoint_test {
 	struct completion irq_raised;
 	int		last_irq;
 	int		num_irqs;
+	int		irq_type;
 	/* mutex to protect the ioctls */
 	struct mutex	mutex;
 	struct miscdevice miscdev;
@@ -158,6 +159,7 @@ static void pci_endpoint_test_free_irq_vectors(struct pci_endpoint_test *test)
 	struct pci_dev *pdev = test->pdev;
 
 	pci_free_irq_vectors(pdev);
+	test->irq_type = IRQ_TYPE_UNDEFINED;
 }
 
 static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
@@ -192,6 +194,8 @@ static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
 		irq = 0;
 		res = false;
 	}
+
+	test->irq_type = type;
 	test->num_irqs = irq;
 
 	return res;
@@ -331,6 +335,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	dma_addr_t orig_dst_phys_addr;
 	size_t offset;
 	size_t alignment = test->alignment;
+	int irq_type = test->irq_type;
 	u32 src_crc32;
 	u32 dst_crc32;
 
@@ -427,6 +432,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 	dma_addr_t orig_phys_addr;
 	size_t offset;
 	size_t alignment = test->alignment;
+	int irq_type = test->irq_type;
 	u32 crc32;
 
 	if (size > SIZE_MAX - alignment)
@@ -495,6 +501,7 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 	dma_addr_t orig_phys_addr;
 	size_t offset;
 	size_t alignment = test->alignment;
+	int irq_type = test->irq_type;
 	u32 crc32;
 
 	if (size > SIZE_MAX - alignment)
@@ -556,7 +563,7 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 		return false;
 	}
 
-	if (irq_type == req_irq_type)
+	if (test->irq_type == req_irq_type)
 		return true;
 
 	pci_endpoint_test_release_irq(test);
@@ -568,12 +575,10 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	if (!pci_endpoint_test_request_irq(test))
 		goto err;
 
-	irq_type = req_irq_type;
 	return true;
 
 err:
 	pci_endpoint_test_free_irq_vectors(test);
-	irq_type = IRQ_TYPE_UNDEFINED;
 	return false;
 }
 
@@ -653,6 +658,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	test->test_reg_bar = 0;
 	test->alignment = 0;
 	test->pdev = pdev;
+	test->irq_type = IRQ_TYPE_UNDEFINED;
 
 	if (no_msi)
 		irq_type = IRQ_TYPE_LEGACY;
-- 
2.17.1

