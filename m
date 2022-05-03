Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CF05188AE
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 17:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbiECPjT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 11:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238652AbiECPiy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 11:38:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD6511C02;
        Tue,  3 May 2022 08:35:19 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kt3qK36r9z67ms2;
        Tue,  3 May 2022 23:32:13 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 3 May 2022 17:35:17 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 3 May 2022 16:35:16 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC PATCH 1/1] pcie/portdrv: Hack in DOE and CDAT support
Date:   Tue, 3 May 2022 16:34:49 +0100
Message-ID: <20220503153449.4088-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is very much a PoC for one potential way to support
CDAT on Switch Upstream Ports.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/Kconfig        |   5 ++
 drivers/pci/pcie/Makefile       |   1 +
 drivers/pci/pcie/cdat.c         | 127 ++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h      |   9 ++-
 drivers/pci/pcie/portdrv_core.c |  43 ++++++++++-
 drivers/pci/pcie/portdrv_pci.c  |   2 +
 6 files changed, 183 insertions(+), 4 deletions(-)
 create mode 100644 drivers/pci/pcie/cdat.c

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 788ac8df3f9d..7d90c05bf0ac 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -142,3 +142,8 @@ config PCIE_EDR
 	  the PCI Firmware Specification r3.2.  Enable this if you want to
 	  support hybrid DPC model which uses both firmware and OS to
 	  implement DPC.
+
+config PCIE_CDAT
+       bool "CDAT hacks"
+       help
+	It's a dirty hack.
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 5783a2f79e6a..4925394e8d4b 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
 obj-$(CONFIG_PCIE_EDR)		+= edr.o
+obj-$(CONFIG_PCIE_CDAT)		+= cdat.o
diff --git a/drivers/pci/pcie/cdat.c b/drivers/pci/pcie/cdat.c
new file mode 100644
index 000000000000..04165c1b8174
--- /dev/null
+++ b/drivers/pci/pcie/cdat.c
@@ -0,0 +1,127 @@
+//HACK
+#include <linux/pci.h>
+#include <linux/pci-doe.h>
+#include "../../cxl/cxlpci.h"
+#include "../../cxl/cdat.h"
+#include "portdrv.h"
+
+struct cdat {
+	struct pci_doe_mb *doe_mb;
+	struct device *dev;
+};
+
+#define CDAT_DOE_REQ(entry_handle)					\
+	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
+		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
+	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_TABLE_TYPE,			\
+		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
+	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
+
+static void cdat_doe_task_complete(struct pci_doe_task *task)
+{
+	complete(task->private);
+}
+
+static int cdat_get_length(struct cdat *cdat, size_t *length)
+{
+	u32 cdat_request_pl = CDAT_DOE_REQ(0);
+	u32 cdat_response_pl[32];
+	DECLARE_COMPLETION_ONSTACK(c);
+	struct pci_doe_task task = {
+		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
+		.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
+		.request_pl = &cdat_request_pl,
+		.request_pl_sz = sizeof(cdat_request_pl),
+		.response_pl = cdat_response_pl,
+		.response_pl_sz = sizeof(cdat_response_pl),
+		.complete = cdat_doe_task_complete,
+		.private = &c,
+	};
+	int rc;
+
+	rc = pci_doe_submit_task(cdat->doe_mb, &task);
+	if (rc < 0) {
+		dev_err(cdat->dev, "DOE submit failed: %d", rc);
+		return rc;
+	}
+	wait_for_completion(&c);
+
+	if (task.rv < 1)
+		return -EIO;
+
+	*length = cdat_response_pl[1];
+	dev_info(cdat->dev, "CDAT length %lu\n", *length);
+
+	return 0;
+}
+
+static int cdat_probe(struct pcie_device *dev)
+{
+	struct device *device = &dev->device;
+	struct cdat *cdat;
+	u16 off;
+        size_t length;
+	int rc;
+
+	/* probably not necessary */
+	if ((pci_pcie_type(dev->port) != PCI_EXP_TYPE_UPSTREAM))
+		return -ENODEV;
+
+	cdat = devm_kzalloc(device, sizeof(*cdat), GFP_KERNEL);
+	if (!cdat)
+		return -ENOMEM;
+
+	cdat->dev = device;
+	/* Terrible though it is lets go find the cap again */
+	pci_doe_for_each_off(dev->port, off) {
+		bool supports_cdat;
+		struct pci_doe_mb *doe_mb;
+
+		doe_mb = pci_doe_create_mb(dev->port, off, true);
+		if (IS_ERR(doe_mb)) {
+			dev_err(device,
+				"Failed to create the DOE mailbox state machine\n");
+			continue;
+		}
+		supports_cdat = pci_doe_supports_prot(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
+						CXL_DOE_PROTOCOL_TABLE_ACCESS);
+		if (supports_cdat) {
+			cdat->doe_mb = doe_mb;
+			break;
+		}
+		pci_doe_destroy_mb(doe_mb);
+	}
+	if (!cdat->doe_mb)
+		return -ENODEV;
+
+	rc = cdat_get_length(cdat, &length);
+	if (rc) {
+		dev_err(device, "Failed to get cdat length\n");
+		return rc;
+	}
+	printk("CDAT length is %lu\n", length);
+	/* this is a PoC so that'll do for now */
+	dev_set_drvdata(device, cdat);
+	return 0;
+}
+
+static void cdat_remove(struct pcie_device *dev)
+{
+	/* Mess with driver remove later */
+	struct cdat *cdat = dev_get_drvdata(&dev->device);
+
+	pci_doe_destroy_mb(cdat->doe_mb);
+}
+
+static struct pcie_port_service_driver cdat_driver = {
+	.name = "cdat",
+	.port_type = PCIE_ANY_PORT, //fixme -upstream only
+	.service = PCIE_PORT_SERVICE_CDAT,
+	.probe = cdat_probe,
+	.remove = cdat_remove,
+};
+
+int __init pcie_cdat_init(void)
+{
+	return pcie_port_service_register(&cdat_driver);
+}
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 0ef4bf5f811d..d35b973f5b67 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -22,8 +22,10 @@
 #define PCIE_PORT_SERVICE_DPC		(1 << PCIE_PORT_SERVICE_DPC_SHIFT)
 #define PCIE_PORT_SERVICE_BWNOTIF_SHIFT	4	/* Bandwidth notification */
 #define PCIE_PORT_SERVICE_BWNOTIF	(1 << PCIE_PORT_SERVICE_BWNOTIF_SHIFT)
+#define PCIE_PORT_SERVICE_CDAT_SHIFT	5	/* CXL CDAT Table DOE */
+#define PCIE_PORT_SERVICE_CDAT		(1 << PCIE_PORT_SERVICE_CDAT_SHIFT)
 
-#define PCIE_PORT_DEVICE_MAXSERVICES   5
+#define PCIE_PORT_DEVICE_MAXSERVICES   6
 
 extern bool pcie_ports_dpc_native;
 
@@ -53,6 +55,11 @@ int pcie_dpc_init(void);
 static inline int pcie_dpc_init(void) { return 0; }
 #endif
 
+#ifdef CONFIG_PCIE_CDAT
+int pcie_cdat_init(void);
+#else
+static inline int pcie_cdat_init(void) { return 0; }
+#endif
 /* Port Type */
 #define PCIE_ANY_PORT			(~0)
 
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 604feeb84ee4..161545b30014 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -8,6 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/pm.h>
@@ -17,6 +18,7 @@
 #include <linux/aer.h>
 
 #include "../pci.h"
+#include "../../cxl/cxlpci.h"
 #include "portdrv.h"
 
 struct portdrv_service_data {
@@ -43,10 +45,12 @@ static void release_pcie_device(struct device *dev)
  * required to accommodate the largest Message Number.
  */
 static int pcie_message_numbers(struct pci_dev *dev, int mask,
-				u32 *pme, u32 *aer, u32 *dpc)
+				u32 *pme, u32 *aer, u32 *dpc, u32 *cdat)
 {
 	u32 nvec = 0, pos;
+	u16 off = 0;
 	u16 reg16;
+	u32 reg32;
 
 	/*
 	 * The Interrupt Message Number indicates which vector is used, i.e.,
@@ -86,6 +90,18 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
 		}
 	}
 
+#ifdef CONFIG_PCIE_CDAT
+	pci_doe_for_each_off(dev, off) {
+		pci_read_config_dword(dev, off + PCI_DOE_CAP, &reg32);
+
+		if (!FIELD_GET(PCI_DOE_CAP_INT, reg32))
+			return -EOPNOTSUPP;
+
+		*cdat = FIELD_GET(PCI_DOE_CAP_IRQ, reg32);
+		nvec = max(nvec, *cdat + 1);
+	}
+#endif
+
 	return nvec;
 }
 
@@ -101,7 +117,7 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
 static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 {
 	int nr_entries, nvec, pcie_irq;
-	u32 pme = 0, aer = 0, dpc = 0;
+	u32 pme = 0, aer = 0, dpc = 0, cdat = 0;
 
 	/* Allocate the maximum possible number of MSI/MSI-X vectors */
 	nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSI_ENTRIES,
@@ -110,7 +126,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 		return nr_entries;
 
 	/* See how many and which Interrupt Message Numbers we actually use */
-	nvec = pcie_message_numbers(dev, mask, &pme, &aer, &dpc);
+	nvec = pcie_message_numbers(dev, mask, &pme, &aer, &dpc, &cdat);
 	if (nvec > nr_entries) {
 		pci_free_irq_vectors(dev);
 		return -EIO;
@@ -151,6 +167,9 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 	if (mask & PCIE_PORT_SERVICE_DPC)
 		irqs[PCIE_PORT_SERVICE_DPC_SHIFT] = pci_irq_vector(dev, dpc);
 
+	if (mask & PCIE_PORT_SERVICE_CDAT)
+		irqs[PCIE_PORT_SERVICE_CDAT_SHIFT] = pci_irq_vector(dev, cdat);
+
 	return 0;
 }
 
@@ -207,6 +226,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	int services = 0;
+	u16 off = 0;
 
 	if (dev->is_hotplug_bridge &&
 	    (pcie_ports_native || host->native_pcie_hotplug)) {
@@ -264,6 +284,23 @@ static int get_port_device_capability(struct pci_dev *dev)
 		if (linkcap & PCI_EXP_LNKCAP_LBNC)
 			services |= PCIE_PORT_SERVICE_BWNOTIF;
 	}
+	/* Run the DOE in poll mode to query protocol */
+	pci_doe_for_each_off(dev, off) {
+		bool supports_cdat;
+		struct pci_doe_mb *doe_mb;
+
+		doe_mb = pci_doe_create_mb(dev, off, false);
+		if (IS_ERR(doe_mb)) {
+			pci_err(dev, "Failed to create the DOE mailbox state machine\n");
+			continue;
+		}
+		supports_cdat = pci_doe_supports_prot(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
+						      CXL_DOE_PROTOCOL_TABLE_ACCESS);
+		pci_doe_destroy_mb(doe_mb);
+		if (supports_cdat) {
+			services |= PCIE_PORT_SERVICE_CDAT;
+		}
+	}
 
 	return services;
 }
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 4b8801656ffb..b4ec0cab7eb9 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/pm.h>
@@ -235,6 +236,7 @@ static void __init pcie_init_services(void)
 	pcie_pme_init();
 	pcie_dpc_init();
 	pcie_hp_init();
+	pcie_cdat_init();
 }
 
 static int __init pcie_portdrv_init(void)
-- 
2.32.0

