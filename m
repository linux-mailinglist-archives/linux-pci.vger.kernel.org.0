Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68111187D88
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 10:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgCQJ5i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 05:57:38 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34350 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCQJ5i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 05:57:38 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02H9vS90015504;
        Tue, 17 Mar 2020 04:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584439048;
        bh=lH9oH7vkXesfsfzSW1L5UeL1LpmPu3vlyhnO1W8hqnw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=D3wTDeVQNt9/UOpQ9qjjcRBFv1QrUiWZpuSs0W/89WKmtQNBIIYrIsc1/14XGrRVV
         6V9XSfM6k2gcfIeXcx1vFEMfDSB3C8YmoIViMSQFU7XDRntVmYZmoXNaNEftQRHjN7
         4eX3BW5NWAP9hsJFFjPN6kUK/CcmU2OiBZ/Euqes=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02H9vSnt034473
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Mar 2020 04:57:28 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Mar 2020 04:57:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Mar 2020 04:57:28 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02H9vIKT095155;
        Tue, 17 Mar 2020 04:57:25 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 2/5] misc: pci_endpoint_test: Add ioctl to clear IRQ
Date:   Tue, 17 Mar 2020 15:31:55 +0530
Message-ID: <20200317100158.4692-3-kishon@ti.com>
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

Add ioctl to clear IRQ which can be used to free the allocated
IRQ vectors and free the requested IRQ.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 10 ++++++++++
 include/uapi/linux/pcitest.h     |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index ca680635d7a9..bb8b94ac8d3b 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -652,6 +652,13 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 	return ret;
 }
 
+static bool pci_endpoint_test_clear_irq(struct pci_endpoint_test *test)
+{
+	pci_endpoint_test_release_irq(test);
+	pci_endpoint_test_free_irq_vectors(test);
+	return true;
+}
+
 static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 				      int req_irq_type)
 {
@@ -722,6 +729,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_GET_IRQTYPE:
 		ret = irq_type;
 		break;
+	case PCITEST_CLEAR_IRQ:
+		ret = pci_endpoint_test_clear_irq(test);
+		break;
 	}
 
 ret:
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index 8b868761f8b4..c3ab4c826297 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -19,6 +19,7 @@
 #define PCITEST_MSIX		_IOW('P', 0x7, int)
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
 #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
+#define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
 
 #define PCITEST_FLAGS_USE_DMA	0x00000001
 
-- 
2.17.1

