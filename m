Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717933BCAF0
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 12:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhGFKxt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 06:53:49 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54472 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhGFKxt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jul 2021 06:53:49 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 166AoxqR120294;
        Tue, 6 Jul 2021 05:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1625568659;
        bh=J49vfWzT3jgaISF6FLeuW0Uwzh22n7B1mHounVkrx44=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QRtDLKY+9pv0+c1LStJ41DLBbvBRvLgx33LT6rHrk6+D08jWL42A31fg8pZTU1FRp
         C1pDoj67iYKP+KuM+5uG/ghlC8fHneDKJn02tmnn2jcQ6LlUiiCJrW9HeWmXp48lSf
         n7cwPozDyNe3Ozj1lBLHB3H/oUfHbMPWxbib6ajY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 166Aox1x087000
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jul 2021 05:50:59 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 6 Jul
 2021 05:50:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 6 Jul 2021 05:50:59 -0500
Received: from a0393678-ssd.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 166Aoar5015822;
        Tue, 6 Jul 2021 05:50:55 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Nadeem Athani <nadeem@cadence.com>
Subject: [PATCH 4/5] misc: pci_endpoint_test: Do not request or allocate IRQs in probe
Date:   Tue, 6 Jul 2021 16:20:34 +0530
Message-ID: <20210706105035.9915-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210706105035.9915-1-kishon@ti.com>
References: <20210706105035.9915-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allocation of IRQ vectors and requesting IRQ is done as part of
PCITEST_SET_IRQTYPE. Do not request or allocate IRQs in probe for
AM654 and J721E so that the user space test script has better control
of the devices for which the IRQs are configured. Since certain user
space scripts could rely on allocation of IRQ vectors during probe,
remove allocation of IRQs only for TI's K3 platform.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index c7ee34013485..9740f2a0e7cd 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -79,6 +79,9 @@
 #define PCI_DEVICE_ID_RENESAS_R8A774C0		0x002d
 #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
 
+#define is_j721e_pci_dev(pdev)         \
+		((pdev)->device == PCI_DEVICE_ID_TI_J721E)
+
 static DEFINE_IDA(pci_endpoint_test_ida);
 
 #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
@@ -810,9 +813,11 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	if (!pci_endpoint_test_alloc_irq_vectors(test, irq_type)) {
-		err = -EINVAL;
-		goto err_disable_irq;
+	if (!(is_am654_pci_dev(pdev) || is_j721e_pci_dev(pdev))) {
+		if (!pci_endpoint_test_alloc_irq_vectors(test, irq_type)) {
+			err = -EINVAL;
+			goto err_disable_irq;
+		}
 	}
 
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
@@ -850,9 +855,11 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		goto err_ida_remove;
 	}
 
-	if (!pci_endpoint_test_request_irq(test)) {
-		err = -EINVAL;
-		goto err_kfree_test_name;
+	if (!(is_am654_pci_dev(pdev) || is_j721e_pci_dev(pdev))) {
+		if (!pci_endpoint_test_request_irq(test)) {
+			err = -EINVAL;
+			goto err_kfree_test_name;
+		}
 	}
 
 	misc_device = &test->miscdev;
-- 
2.17.1

