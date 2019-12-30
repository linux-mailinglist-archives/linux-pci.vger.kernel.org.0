Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF4712D005
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2019 13:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfL3Mbe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Dec 2019 07:31:34 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33356 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfL3Mbd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Dec 2019 07:31:33 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBUCVPkP065568;
        Mon, 30 Dec 2019 06:31:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577709085;
        bh=eVSu50PxyoLGzegmTZuXEW04AZFEHqRmr98LURXjQNY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qFBXc9AdPWjfNlmQd7TksEm3UjqRHjuaNum+wmdlzPrC9CgXBvVNcNVK2Iz3P7HTB
         jn8BhmLHx1pIYpsK8d1E1CtM95YCMEszaLNOaf3aq8H7a8JwuLWbDgpHPX7vSc7OeT
         bHaFnMLOp7hbPJ2XEQWT1Hr1Y4sscqO9orH9QosU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBUCVPHx095049
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Dec 2019 06:31:25 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 30
 Dec 2019 06:31:25 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 30 Dec 2019 06:31:25 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBUCVEhP002491;
        Mon, 30 Dec 2019 06:31:23 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] misc: pci_endpoint_test: Add ioctl to clear IRQ
Date:   Mon, 30 Dec 2019 18:03:11 +0530
Message-ID: <20191230123315.31037-4-kishon@ti.com>
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

Add ioctl to clear IRQ which can be used to free the allocated
IRQ vectors and free the requested IRQ.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/pci_endpoint_test.c | 10 ++++++++++
 include/uapi/linux/pcitest.h     |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 04505890eae9..861b3d0cea19 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -555,6 +555,13 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
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
@@ -625,6 +632,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_GET_IRQTYPE:
 		ret = irq_type;
 		break;
+	case PCITEST_CLEAR_IRQ:
+		ret = pci_endpoint_test_clear_irq(test);
+		break;
 	}
 
 ret:
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index cbf422e56696..c6d3076fa732 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -19,5 +19,6 @@
 #define PCITEST_MSIX		_IOW('P', 0x7, int)
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
 #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
+#define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
 
 #endif /* __UAPI_LINUX_PCITEST_H */
-- 
2.17.1

