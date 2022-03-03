Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540CB4CBF84
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 15:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiCCOGW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 09:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiCCOGU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 09:06:20 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF6038BF1;
        Thu,  3 Mar 2022 06:05:35 -0800 (PST)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K8Xm24fGFz67xg5;
        Thu,  3 Mar 2022 22:04:18 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 3 Mar 2022 15:05:33 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 14:05:32 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <keyrings@vger.kernel.org>, "Bjorn Helgaas" <bjorn@helgaas.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        <dan.j.williams@intel.com>
Subject: [RFC PATCH v2 13/14] PCI/CMA: Initial support for Component Measurement and Authentication ECN
Date:   Thu, 3 Mar 2022 13:59:04 +0000
Message-ID: <20220303135905.10420-14-Jonathan.Cameron@huawei.com>
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

This currently very much a PoC.  Currently the SPDM library only provides
a single function to allow a challenge / authentication of the PCI EP.

SPDM exchanges must occur in one of a small set of valid squences over
which the message digest used in authentication is built up.
Placing that complexity in the SPDM library seems like a good way
to enforce that logic, without having to do it for each transport.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/Kconfig     |   9 ++++
 drivers/pci/Makefile    |   2 +
 drivers/pci/cma.c       | 105 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-cma.h |  19 ++++++++
 4 files changed, 135 insertions(+)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 8b9b3341b553..3a6c4affe81f 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -128,6 +128,15 @@ config PCI_DOE_DRIVER
 	  number of different protocols.  DOE is defined in the Data Object
 	  Exchange ECN to the PCIe r5.0 spec.
 
+config PCI_CMA
+	tristate "PCI Component Measurement and Authentication"
+	select PCI_DOE
+	select ASN1_ENCODER
+	select SPDM
+	help
+	  This enables library support for the PCI Component Measurement and
+	  Authentication ECN. This uses DMTF SPDM 1.1
+
 config PCI_ATS
 	bool
 
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 0a15f36e97f4..991d4186a01b 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -30,9 +30,11 @@ obj-$(CONFIG_PCI_PF_STUB)	+= pci-pf-stub.o
 obj-$(CONFIG_PCI_ECAM)		+= ecam.o
 obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
 obj-$(CONFIG_PCI_DOE_DRIVER)	+= pci-doe.o
+obj-$(CONFIG_PCI_CMA)		+= pci-cma.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 
 pci-doe-y := doe.o
+pci-cma-y := cma.o
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
new file mode 100644
index 000000000000..7a14a3365300
--- /dev/null
+++ b/drivers/pci/cma.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Component Measurement and Authentication was added as an ECN to the
+ * PCIe r5.0 spec.
+ *
+ * Copyright (C) 2021 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci-cma.h>
+#include <linux/pci-doe.h>
+#include <linux/spdm.h>
+
+#define PCI_DOE_PROTOCOL_CMA 1
+/* Keyring that userspace can poke certs into */
+static struct key *cma_keyring;
+
+static int cma_spdm_ex(void *priv, struct spdm_exchange *spdm_ex)
+{
+	size_t request_padded_sz, response_padded_sz;
+	struct pci_doe_exchange ex = {
+		.prot = {
+			.vid = PCI_VENDOR_ID_PCI_SIG,
+			.type = PCI_DOE_PROTOCOL_CMA,
+		},
+	};
+	struct pci_doe_dev *doe_dev = priv;
+	int rc;
+
+	/* DOE requires that response and request are padded to a multiple of 4 bytes */
+	request_padded_sz = ALIGN(spdm_ex->request_pl_sz, sizeof(u32));
+	if (request_padded_sz != spdm_ex->request_pl_sz) {
+		ex.request_pl = kzalloc(request_padded_sz, GFP_KERNEL);
+		if (!ex.request_pl)
+			return -ENOMEM;
+		memcpy(ex.request_pl, spdm_ex->request_pl, spdm_ex->request_pl_sz);
+		ex.request_pl_sz = request_padded_sz;
+	} else {
+		ex.request_pl = (u32 *)spdm_ex->request_pl;
+		ex.request_pl_sz = spdm_ex->request_pl_sz;
+	}
+
+	response_padded_sz = ALIGN(spdm_ex->response_pl_sz, sizeof(u32));
+	if (response_padded_sz != spdm_ex->response_pl_sz) {
+		ex.response_pl = kzalloc(response_padded_sz, GFP_KERNEL);
+		if (!ex.response_pl) {
+			rc = -ENOMEM;
+			goto err_free_req;
+		}
+		ex.response_pl_sz = response_padded_sz;
+	} else {
+		ex.response_pl = (u32 *)spdm_ex->response_pl;
+		ex.response_pl_sz = spdm_ex->response_pl_sz;
+	}
+
+	rc = pci_doe_exchange_sync(doe_dev, &ex);
+	if (rc < 0)
+		goto err_free_rsp;
+
+	if (response_padded_sz != spdm_ex->response_pl_sz)
+		memcpy(spdm_ex->response_pl, ex.response_pl, spdm_ex->response_pl_sz);
+
+err_free_rsp:
+	if (response_padded_sz != spdm_ex->response_pl_sz)
+		kfree(ex.response_pl);
+err_free_req:
+	if (request_padded_sz != spdm_ex->request_pl_sz)
+		kfree(ex.request_pl);
+
+	return rc;
+}
+
+void pci_cma_init(struct pci_doe_dev *doe_dev, struct spdm_state *spdm_state)
+{
+	memset(spdm_state, 0, sizeof(*spdm_state));
+	spdm_state->transport_ex = cma_spdm_ex;
+	spdm_state->transport_priv = doe_dev;
+	spdm_state->dev = &doe_dev->pdev->dev;
+	spdm_state->root_keyring = cma_keyring;
+}
+EXPORT_SYMBOL_GPL(pci_cma_init);
+
+int pci_cma_authenticate(struct spdm_state *spdm_state)
+{
+	return spdm_authenticate(spdm_state);
+}
+EXPORT_SYMBOL_GPL(pci_cma_authenticate);
+
+__init static int cma_keyring_init(void)
+{
+	cma_keyring = keyring_alloc("_cma",
+				    KUIDT_INIT(0), KGIDT_INIT(0),
+				    current_cred(),
+				    (KEY_POS_ALL & ~KEY_POS_SETATTR) |
+				    KEY_USR_VIEW | KEY_USR_READ | KEY_USR_WRITE | KEY_USR_SEARCH,
+				    KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_SET_KEEP, NULL, NULL);
+	if (IS_ERR(cma_keyring))
+		pr_err("Could not allocate cma keyring\n");
+
+	return 0;
+}
+device_initcall(cma_keyring_init);
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/pci-cma.h b/include/linux/pci-cma.h
new file mode 100644
index 000000000000..3790e532cd38
--- /dev/null
+++ b/include/linux/pci-cma.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Component Measurement and Authentication was added as an ECN to the
+ * PCIe r5.0 spec.
+ *
+ * Copyright (C) 2021 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ */
+
+#ifndef _PCI_CMA_H_
+#define _PCI_CMA_H_
+struct pci_doe_dev;
+struct spdm_state;
+
+void pci_cma_init(struct pci_doe_dev *doe_dev, struct spdm_state *spdm_state);
+
+int pci_cma_authenticate(struct spdm_state *spdm_state);
+
+#endif
-- 
2.32.0

