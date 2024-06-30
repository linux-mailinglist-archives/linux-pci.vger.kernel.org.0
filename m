Return-Path: <linux-pci+bounces-9475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE2391D3CD
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 22:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC121F2140F
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 20:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3639200C1;
	Sun, 30 Jun 2024 20:19:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908B92110F;
	Sun, 30 Jun 2024 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719778743; cv=none; b=k0N/rYnyzgRPU2+dkKL+/Bi2+/07t2xrRD70EpxlmqmTBTgOyDPWqTtgVQecYWjArAJFU0f073BAFoIvXrLl8/t49WeISmcPDmaCP+qP8qRCSBfcFTekpbguJXcpDFJnTj5cWc+RuLCz/N08LWHn1qaKD6YVN2Zp8LFHhgb6H68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719778743; c=relaxed/simple;
	bh=FvvzPKoAsgfdvQCSJ54W83CY9yKuGf7Co+pd3iM6dvs=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=HA9rDM2sEkGgPjirks2LSfpUqiSUMN5ah/s65wVIHch9wo4dUa/bpNlzh7QjIpIlKuR5HD5oLgzqxJoRU4fC8Jv7twlaHp9EpqBESS6T8tpCX14qIoW2VSRU+7tCcr2l8VXQGxUYCVUZxkq/peIIPE8Y3oceq/SwyBgNlMDTgt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 530D5101917A3;
	Sun, 30 Jun 2024 22:18:59 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 2161961DA805;
	Sun, 30 Jun 2024 22:18:59 +0200 (CEST)
X-Mailbox-Line: From 6d4361f13a942efc4b4d33d22e56b564c4362328 Mon Sep 17 00:00:00 2001
Message-ID: <6d4361f13a942efc4b4d33d22e56b564c4362328.1719771133.git.lukas@wunner.de>
In-Reply-To: <cover.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 30 Jun 2024 21:43:00 +0200
Subject: [PATCH v2 08/18] PCI/CMA: Authenticate devices on enumeration
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Cc: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair Francis <alistair.francis@wdc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, "Damien Le Moal" <dlemoal@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Component Measurement and Authentication (CMA, PCIe r6.2 sec 6.31)
allows for measurement and authentication of PCIe devices.  It is
based on the Security Protocol and Data Model specification (SPDM,
https://www.dmtf.org/dsp/DSP0274).

CMA-SPDM in turn forms the basis for Integrity and Data Encryption
(IDE, PCIe r6.2 sec 6.33) because the key material used by IDE is
transmitted over a CMA-SPDM session.

As a first step, authenticate CMA-capable devices on enumeration.
A subsequent commit will expose the result in sysfs.

When allocating SPDM session state with spdm_create(), the maximum SPDM
message length needs to be passed.  Make the PCI_DOE_MAX_LENGTH macro
public and calculate the maximum payload length from it.

Credits:  Jonathan wrote a proof-of-concept of this CMA implementation.
Lukas reworked it for upstream.  Wilfred contributed fixes for issues
discovered during testing.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-developed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Co-developed-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 MAINTAINERS             |   1 +
 drivers/pci/Kconfig     |  13 ++++++
 drivers/pci/Makefile    |   2 +
 drivers/pci/cma.c       | 100 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/doe.c       |   3 --
 drivers/pci/pci.h       |   8 ++++
 drivers/pci/probe.c     |   1 +
 drivers/pci/remove.c    |   1 +
 include/linux/pci-doe.h |   4 ++
 include/linux/pci.h     |   4 ++
 10 files changed, 134 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/cma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dbe16eea8818..9aad3350da16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20153,6 +20153,7 @@ L:	linux-cxl@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
+F:	drivers/pci/cma*
 F:	include/linux/spdm.h
 F:	lib/spdm/
 
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index d35001589d88..f656211d707a 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -121,6 +121,19 @@ config XEN_PCIDEV_FRONTEND
 config PCI_ATS
 	bool
 
+config PCI_CMA
+	bool "Component Measurement and Authentication (CMA-SPDM)"
+	select CRYPTO_ECDSA
+	select CRYPTO_RSA
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	select PCI_DOE
+	select SPDM
+	help
+	  Authenticate devices on enumeration per PCIe r6.2 sec 6.31.
+	  A PCI DOE mailbox is used as transport for DMTF SPDM based
+	  authentication, measurement and secure channel establishment.
+
 config PCI_DOE
 	bool
 
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 175302036890..6bcfeb698961 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -35,6 +35,8 @@ obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 
+obj-$(CONFIG_PCI_CMA)		+= cma.o
+
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
 
diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
new file mode 100644
index 000000000000..275338b95640
--- /dev/null
+++ b/drivers/pci/cma.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Component Measurement and Authentication (CMA-SPDM, PCIe r6.2 sec 6.31)
+ *
+ * Copyright (C) 2021 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ *
+ * Copyright (C) 2022-24 Intel Corporation
+ */
+
+#define dev_fmt(fmt) "CMA: " fmt
+
+#include <linux/pci.h>
+#include <linux/pci-doe.h>
+#include <linux/pm_runtime.h>
+#include <linux/spdm.h>
+
+#include "pci.h"
+
+/* Keyring that userspace can poke certs into */
+static struct key *pci_cma_keyring;
+
+#define PCI_DOE_FEATURE_CMA 1
+
+static ssize_t pci_doe_transport(void *priv, struct device *dev,
+				 const void *request, size_t request_sz,
+				 void *response, size_t response_sz)
+{
+	struct pci_doe_mb *doe = priv;
+	ssize_t rc;
+
+	/*
+	 * CMA-SPDM operation in non-D0 states is optional (PCIe r6.2
+	 * sec 6.31.3).  The spec does not define a way to determine
+	 * if it's supported, so resume to D0 unconditionally.
+	 */
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
+	rc = pci_doe(doe, PCI_VENDOR_ID_PCI_SIG, PCI_DOE_FEATURE_CMA,
+		     request, request_sz, response, response_sz);
+
+	pm_runtime_put(dev);
+
+	return rc;
+}
+
+void pci_cma_init(struct pci_dev *pdev)
+{
+	struct pci_doe_mb *doe;
+
+	if (IS_ERR(pci_cma_keyring))
+		return;
+
+	if (!pci_is_pcie(pdev))
+		return;
+
+	doe = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
+				   PCI_DOE_FEATURE_CMA);
+	if (!doe)
+		return;
+
+	pdev->spdm_state = spdm_create(&pdev->dev, pci_doe_transport, doe,
+				       PCI_DOE_MAX_PAYLOAD, pci_cma_keyring);
+	if (!pdev->spdm_state)
+		return;
+
+	/*
+	 * Keep spdm_state allocated even if initial authentication fails
+	 * to allow for provisioning of certificates and reauthentication.
+	 */
+	spdm_authenticate(pdev->spdm_state);
+}
+
+void pci_cma_destroy(struct pci_dev *pdev)
+{
+	if (!pdev->spdm_state)
+		return;
+
+	spdm_destroy(pdev->spdm_state);
+}
+
+__init static int pci_cma_keyring_init(void)
+{
+	pci_cma_keyring = keyring_alloc(".cma", KUIDT_INIT(0), KGIDT_INIT(0),
+					current_cred(),
+					(KEY_POS_ALL & ~KEY_POS_SETATTR) |
+					KEY_USR_VIEW | KEY_USR_READ |
+					KEY_USR_WRITE | KEY_USR_SEARCH,
+					KEY_ALLOC_NOT_IN_QUOTA |
+					KEY_ALLOC_SET_KEEP, NULL, NULL);
+	if (IS_ERR(pci_cma_keyring)) {
+		pr_err("PCI: Could not allocate .cma keyring\n");
+		return PTR_ERR(pci_cma_keyring);
+	}
+
+	return 0;
+}
+arch_initcall(pci_cma_keyring_init);
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 652d63df9d22..34bb8f232799 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -31,9 +31,6 @@
 #define PCI_DOE_FLAG_CANCEL	0
 #define PCI_DOE_FLAG_DEAD	1
 
-/* Max data object length is 2^18 dwords */
-#define PCI_DOE_MAX_LENGTH	(1 << 18)
-
 /**
  * struct pci_doe_mb - State for a single DOE mailbox
  *
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fd44565c4756..fc90845caf83 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -333,6 +333,14 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
 static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #endif
 
+#ifdef CONFIG_PCI_CMA
+void pci_cma_init(struct pci_dev *pdev);
+void pci_cma_destroy(struct pci_dev *pdev);
+#else
+static inline void pci_cma_init(struct pci_dev *pdev) { }
+static inline void pci_cma_destroy(struct pci_dev *pdev) { }
+#endif
+
 /**
  * pci_dev_set_io_state - Set the new error state if possible.
  *
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8e696e547565..5297f9a08ca2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2484,6 +2484,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_dpc_init(dev);		/* Downstream Port Containment */
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
 	pci_doe_init(dev);		/* Data Object Exchange */
+	pci_cma_init(dev);		/* Component Measurement & Auth */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d749ea8250d6..f009ac578997 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -39,6 +39,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	list_del(&dev->bus_list);
 	up_write(&pci_bus_sem);
 
+	pci_cma_destroy(dev);
 	pci_doe_destroy(dev);
 	pcie_aspm_exit_link_state(dev);
 	pci_bridge_d3_update(dev);
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index 1f14aed4354b..0d3d7656c456 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -15,6 +15,10 @@
 
 struct pci_doe_mb;
 
+/* Max data object length is 2^18 dwords (including 2 dwords for header) */
+#define PCI_DOE_MAX_LENGTH	(1 << 18)
+#define PCI_DOE_MAX_PAYLOAD	((PCI_DOE_MAX_LENGTH - 2) * sizeof(u32))
+
 struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
 					u8 type);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fb004fd4e889..cb2a0be57196 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -39,6 +39,7 @@
 #include <linux/io.h>
 #include <linux/resource_ext.h>
 #include <linux/msi_api.h>
+#include <linux/spdm.h>
 #include <uapi/linux/pci.h>
 
 #include <linux/pci_ids.h>
@@ -517,6 +518,9 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_DOE
 	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
+#endif
+#ifdef CONFIG_PCI_CMA
+	struct spdm_state *spdm_state;	/* Security Protocol and Data Model */
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
-- 
2.43.0


