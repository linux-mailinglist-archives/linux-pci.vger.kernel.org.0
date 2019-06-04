Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6EDB34872
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 15:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfFDNUS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 09:20:18 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35648 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfFDNUR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 09:20:17 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x54DJLQF092301;
        Tue, 4 Jun 2019 08:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559654361;
        bh=wpR76pUQZD8qw+8R4/pRwOkQY9ta5s2pKOPuv5GPy44=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gQFje2xLV6IMR3s1mQL6R8PIVlNv//UIzSUzajaVG+d2jd1GH1XFlYZVEW+KPGA/s
         aACev+SCMDgAv7roiJxX92r9dpX0CyGcgKW8yfLIq/jgxvXnrnwwD/cEMvZh1e3DrU
         6S1frA2Wewxa2WnxVF+7qAtUZUxam6eAunZ2d4z0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x54DJLtD054916
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 08:19:21 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 08:19:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 08:19:20 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x54DGdGi098972;
        Tue, 4 Jun 2019 08:19:15 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 28/30] misc: pci_endpoint_test: Avoid using module parameter to determine irqtype
Date:   Tue, 4 Jun 2019 18:45:14 +0530
Message-ID: <20190604131516.13596-29-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
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
adding 'irqtype' for each PCI device to shows the irq type of that
particular PCI device.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 98a60f4d45a1..632c76e33e4e 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -110,6 +110,7 @@ struct pci_endpoint_test {
 	struct completion irq_raised;
 	int		last_irq;
 	int		num_irqs;
+	int		irq_type;
 	/* mutex to protect the ioctls */
 	struct mutex	mutex;
 	struct miscdevice miscdev;
@@ -169,6 +170,7 @@ static void pci_endpoint_test_free_irq_vectors(struct pci_endpoint_test *test)
 	struct pci_dev *pdev = test->pdev;
 
 	pci_free_irq_vectors(pdev);
+	test->irq_type = IRQ_TYPE_UNDEFINED;
 }
 
 static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
@@ -203,6 +205,8 @@ static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
 		irq = 0;
 		res = false;
 	}
+
+	test->irq_type = type;
 	test->num_irqs = irq;
 
 	return res;
@@ -342,6 +346,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	dma_addr_t orig_dst_phys_addr;
 	size_t offset;
 	size_t alignment = test->alignment;
+	int irq_type = test->irq_type;
 	u32 src_crc32;
 	u32 dst_crc32;
 
@@ -438,6 +443,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 	dma_addr_t orig_phys_addr;
 	size_t offset;
 	size_t alignment = test->alignment;
+	int irq_type = test->irq_type;
 	u32 crc32;
 
 	if (size > SIZE_MAX - alignment)
@@ -506,6 +512,7 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 	dma_addr_t orig_phys_addr;
 	size_t offset;
 	size_t alignment = test->alignment;
+	int irq_type = test->irq_type;
 	u32 crc32;
 
 	if (size > SIZE_MAX - alignment)
@@ -567,7 +574,7 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 		return false;
 	}
 
-	if (irq_type == req_irq_type)
+	if (test->irq_type == req_irq_type)
 		return true;
 
 	pci_endpoint_test_release_irq(test);
@@ -579,12 +586,10 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	if (!pci_endpoint_test_request_irq(test))
 		goto err;
 
-	irq_type = req_irq_type;
 	return true;
 
 err:
 	pci_endpoint_test_free_irq_vectors(test);
-	irq_type = IRQ_TYPE_UNDEFINED;
 	return false;
 }
 
-- 
2.17.1

