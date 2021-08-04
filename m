Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272A93E05D4
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 18:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbhHDQYG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 12:24:06 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3581 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbhHDQYG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 12:24:06 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gfxr86VKVz6GFTw;
        Thu,  5 Aug 2021 00:23:36 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 18:23:51 +0200
Received: from localhost.localdomain (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 17:23:51 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <keyrings@vger.kernel.org>, <dan.j.williams@intel.com>,
        Chris Browy <cbrowy@avery-design.com>, <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 4/4] cxl/pci: Add really basic CMA authentication support.
Date:   Thu, 5 Aug 2021 00:18:39 +0800
Message-ID: <20210804161839.3492053-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210804161839.3492053-1-Jonathan.Cameron@huawei.com>
References: <20210804161839.3492053-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is just for purposes of poking the CMA / SPDM code.
What exactly the model in the driver looks like is still to
be worked out.

Note the PROBE_FORCE_SYNCHRONOUS is a workaround to avoid warnings
about trying to load an additional crypto module whilst doing an
asychronous probe.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/Kconfig |  1 +
 drivers/cxl/mem.h   |  2 ++
 drivers/cxl/pci.c   | 13 ++++++++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index e2bca26eb879..c726cc9adddb 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -17,6 +17,7 @@ config CXL_MEM
 	tristate "CXL.mem: Memory Devices"
 	default CXL_BUS
 	select PCI_DOE
+	select PCI_CMA
 	help
 	  The CXL.mem protocol allows a device to act as a provider of
 	  "System RAM" and/or "Persistent Memory" that is fully coherent
diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index f626aa7eb389..cb8c2dfda277 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -57,6 +57,7 @@ struct cxl_memdev {
  * @pdev: The PCI device associated with this CXL device.
  * @cxlmd: Logical memory device chardev / interface
  * @table_doe: Data exchange object mailbox used to read tables
+ * @cma_doe: Component measurement and authentication mailbox
  * @regs: Parsed register blocks
  * @payload_size: Size of space for payload
  *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
@@ -73,6 +74,7 @@ struct cxl_mem {
 	struct cxl_memdev *cxlmd;
 
 	struct pci_doe *table_doe;
+	struct pci_doe *cma_doe;
 	struct cxl_regs regs;
 
 	size_t payload_size;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 471bddc9d167..e6ca84cc6fff 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -2,10 +2,12 @@
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 #include <uapi/linux/cxl_mem.h>
 #include <linux/security.h>
+#include <linux/pci-cma.h>
 #include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
 #include <linux/mutex.h>
+#include <linux/spdm.h>
 #include <linux/list.h>
 #include <linux/cdev.h>
 #include <linux/idr.h>
@@ -1723,6 +1725,7 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_memdev *cxlmd;
 	struct cxl_mem *cxlm;
+	struct spdm_state spdm_state;
 	int rc, irqs;
 
 	rc = pcim_enable_device(pdev);
@@ -1770,6 +1773,14 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	cxlm->table_doe = pci_doe_find(pdev, PCI_DVSEC_VENDOR_ID_CXL,
 				       CXL_DOE_PROTOCOL_TABLE_ACCESS);
 
+	cxlm->cma_doe = pci_doe_find(pdev, PCI_VENDOR_ID_PCI_SIG,
+				     PCI_DOE_PROTOCOL_CMA);
+
+	pci_cma_init(cxlm->cma_doe, &spdm_state);
+	rc = pci_cma_authenticate(&spdm_state);
+	if (rc)
+		return rc;
+
 	rc = cxl_mem_setup_regs(cxlm);
 	if (rc)
 		return rc;
@@ -1808,7 +1819,7 @@ static struct pci_driver cxl_mem_driver = {
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_mem_probe,
 	.driver	= {
-		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+		.probe_type	= PROBE_FORCE_SYNCHRONOUS,
 	},
 };
 
-- 
2.19.1

