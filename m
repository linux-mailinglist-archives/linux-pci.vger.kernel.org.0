Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1F74CBF87
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 15:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiCCOHK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 09:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbiCCOHJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 09:07:09 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EB118C7BC;
        Thu,  3 Mar 2022 06:06:22 -0800 (PST)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K8Xmg5fZjz67lrx;
        Thu,  3 Mar 2022 22:04:51 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 15:06:03 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 14:06:02 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <keyrings@vger.kernel.org>, "Bjorn Helgaas" <bjorn@helgaas.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        <dan.j.williams@intel.com>
Subject: [RFC PATCH v2 14/14] cxl/pci: Add really basic CMA authentication support.
Date:   Thu, 3 Mar 2022 13:59:05 +0000
Message-ID: <20220303135905.10420-15-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220303135905.10420-1-Jonathan.Cameron@huawei.com>
References: <20220303135905.10420-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 drivers/cxl/Kconfig  |  1 +
 drivers/cxl/cxlmem.h |  2 ++
 drivers/cxl/pci.c    | 40 +++++++++++++++++++++++++++++++++++++++-
 lib/spdm.c           |  2 +-
 4 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 9d53720bea07..4dfd2c19b285 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -17,6 +17,7 @@ config CXL_MEM
 	tristate "CXL.mem: Memory Devices"
 	default CXL_BUS
 	select PCI_DOE_DRIVER
+	select PCI_CMA
 	help
 	  The CXL.mem protocol allows a device to act as a provider of
 	  "System RAM" and/or "Persistent Memory" that is fully coherent
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index b4209170f4ac..b69328118632 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -100,6 +100,7 @@ struct cxl_mbox_cmd {
  *
  * @dev: The device associated with this CXL state
  * @cdat_doe: Auxiliary DOE device capabile of reading CDAT
+ * @cma_doe: Component measurement and authentication mailbox
  * @regs: Parsed register blocks
  * @payload_size: Size of space for payload
  *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
@@ -132,6 +133,7 @@ struct cxl_dev_state {
 	struct device *dev;
 
 	struct pci_doe_dev *cdat_doe;
+	struct pci_doe_dev *cma_doe;
 	struct cxl_regs regs;
 
 	size_t payload_size;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index ed94a6bef2de..ad823eeaafd9 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1,9 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 #include <linux/io-64-nonatomic-lo-hi.h>
+//#include <uapi/linux/cxl_mem.h>
+#include <linux/security.h>
+#include <linux/pci-cma.h>
+//#include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
 #include <linux/mutex.h>
+#include <linux/spdm.h>
 #include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
@@ -494,6 +499,26 @@ static int cxl_match_cdat_doe_device(struct device *dev, const void *data)
 	return 0;
 }
 
+static int cxl_match_cma_doe_device(struct device *dev, const void *data)
+{
+	const struct cxl_dev_state *cxlds = data;
+	struct auxiliary_device *adev;
+	struct pci_doe_dev *doe_dev;
+
+	/* First determine if this auxiliary device belongs to the cxlds */
+	if (cxlds->dev != dev->parent)
+		return 0;
+
+	adev = to_auxiliary_dev(dev);
+	doe_dev = container_of(adev, struct pci_doe_dev, adev);
+
+	/* If it is one of ours check for the CMA protocol */
+	if (pci_doe_supports_prot(doe_dev, PCI_VENDOR_ID_PCI_SIG, 1)) //hack
+		return 1;
+
+	return 0;
+}
+
 static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
 {
 	struct device *dev = cxlds->dev;
@@ -519,6 +544,10 @@ static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
 		cxlds->cdat_doe = doe_dev;
 	}
 
+	adev = auxiliary_find_device(NULL, cxlds, &cxl_match_cma_doe_device);
+	if (adev)
+		cxlds->cma_doe = container_of(adev, struct pci_doe_dev, adev);
+
 	return 0;
 }
 
@@ -643,6 +672,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct cxl_register_map map;
 	struct cxl_memdev *cxlmd;
 	struct cxl_dev_state *cxlds;
+	struct spdm_state spdm_state;
 	int rc;
 
 	/*
@@ -670,6 +700,14 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cxl_initialize_cdat_callbacks(cxlds);
 
+	/* CMA is optional - policy control will be needed */
+	if (cxlds->cma_doe) {
+		pci_cma_init(cxlds->cma_doe, &spdm_state);
+		rc = pci_cma_authenticate(&spdm_state);
+		if (rc)
+			return rc;
+	}
+
 	rc = cxl_map_regs(cxlds, &map);
 	if (rc)
 		return rc;
@@ -712,7 +750,7 @@ static struct pci_driver cxl_pci_driver = {
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
 	.driver	= {
-		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+		.probe_type	= PROBE_FORCE_SYNCHRONOUS,
 	},
 };
 
diff --git a/lib/spdm.c b/lib/spdm.c
index 3ce2341647f8..84a2d7f3989e 100644
--- a/lib/spdm.c
+++ b/lib/spdm.c
@@ -921,7 +921,7 @@ static int spdm_get_certificate(struct spdm_state *spdm_state)
 				key_ref_to_ptr(key2)->payload.data[asym_auth];
 
 			key = find_asymmetric_key(spdm_state->root_keyring, sig->auth_ids[0],
-						  sig->auth_ids[1], false);
+						  sig->auth_ids[1], NULL, false);
 			if (IS_ERR(key)) {
 				dev_err(spdm_state->dev,
 					"Unable to retrieve signing certificate from _cma keyring\n");
-- 
2.32.0

