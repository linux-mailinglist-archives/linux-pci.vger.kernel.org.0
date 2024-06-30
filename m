Return-Path: <linux-pci+bounces-9478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C233491D3DB
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 22:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32A9281580
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2024 20:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3087612C49C;
	Sun, 30 Jun 2024 20:23:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A862110F;
	Sun, 30 Jun 2024 20:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719779018; cv=none; b=X+q5P1uPolwKW0J1lubR7GDlC36O6IYiWY8y+/KrKkWnar/e7khpEsRnqILBe/GZBNuDes4G8aXyHMVZK/2m0G5kS9F/XgOv9WfJrp1E2Vc24Qjd5SsgRWhIKfJpP9VRWy6VNjibMVH49E//UnCEq/lqepVNTnyctuDYjn8mhI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719779018; c=relaxed/simple;
	bh=adaBwONq6h6/HgnZbBLEuVr5fIzHJ/A/p0UswP8pnK4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=NLLQZCQsWjmTx3yMO1FS/PyDr0LX6oC3xUe+IwziQMQTvUX/GFDlbWnLOCBlYC9hXUfW4Pu2y8omJUX1F7j3rWKBnmlZO+OqtShcXtJvQ8lordAUT5Uk/GBvZV5ZfWV8WrMpGitQMeuDU7wOGIq5kHuK2Y2DonpXyOoFC+TYIQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 76A8C10190FA3;
	Sun, 30 Jun 2024 22:23:34 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 4C5F161DA805;
	Sun, 30 Jun 2024 22:23:34 +0200 (CEST)
X-Mailbox-Line: From 8851c4d4c829dd6608f15244954e3fbe9995908b Mon Sep 17 00:00:00 2001
Message-ID: <8851c4d4c829dd6608f15244954e3fbe9995908b.1719771133.git.lukas@wunner.de>
In-Reply-To: <cover.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 30 Jun 2024 21:46:00 +0200
Subject: [PATCH v2 11/18] PCI/CMA: Expose in sysfs whether devices are
 authenticated
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>, <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Cc: <linuxarm@huawei.com>, David Box <david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair Francis <alistair.francis@wdc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, "Damien Le Moal" <dlemoal@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>, Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>, Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The PCI core has just been amended to authenticate CMA-capable devices
on enumeration and store the result in an "authenticated" bit in struct
pci_dev->spdm_state.

Expose the bit to user space through an eponymous sysfs attribute.

Allow user space to trigger reauthentication (e.g. after it has updated
the CMA keyring) by writing to the sysfs attribute.

Implement the attribute in the SPDM library so that other bus types
besides PCI may take advantage of it.  They just need to add
spdm_attr_group to the attribute groups of their devices and amend the
dev_to_spdm_state() helper which retrieves the spdm_state for a given
device.

The helper may return an ERR_PTR if it couldn't be determined whether
SPDM is supported by the device.  The sysfs attribute is visible in that
case but returns an error on access.  This prevents downgrade attacks
where an attacker disturbs memory allocation or DOE communication
in order to create the appearance that SPDM is unsupported.

Subject to further discussion, a future commit might add a user-defined
policy to forbid driver binding to devices which failed authentication,
similar to the "authorized" attribute for USB.

Alternatively, authentication success might be signaled to user space
through a uevent, whereupon it may bind a (blacklisted) driver.
A uevent signaling authentication failure might similarly cause user
space to unbind or outright remove the potentially malicious device.

Traffic from devices which failed authentication could also be filtered
through ACS I/O Request Blocking Enable (PCIe r6.2 sec 7.7.11.3) or
through Link Disable (PCIe r6.2 sec 7.5.3.7).  Unlike an IOMMU, that
will not only protect the host, but also prevent malicious peer-to-peer
traffic to other devices.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 Documentation/ABI/testing/sysfs-devices-spdm | 31 +++++++
 MAINTAINERS                                  |  1 +
 drivers/pci/cma.c                            | 12 ++-
 drivers/pci/doe.c                            |  2 +
 drivers/pci/pci-sysfs.c                      |  3 +
 drivers/pci/pci.h                            |  5 ++
 include/linux/pci.h                          | 12 +++
 include/linux/spdm.h                         |  2 +
 lib/spdm/Makefile                            |  1 +
 lib/spdm/req-sysfs.c                         | 95 ++++++++++++++++++++
 lib/spdm/spdm.h                              |  1 +
 11 files changed, 161 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-spdm
 create mode 100644 lib/spdm/req-sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-devices-spdm b/Documentation/ABI/testing/sysfs-devices-spdm
new file mode 100644
index 000000000000..2d6e5d513231
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-spdm
@@ -0,0 +1,31 @@
+What:		/sys/devices/.../authenticated
+Date:		June 2024
+Contact:	Lukas Wunner <lukas@wunner.de>
+Description:
+		This file contains 1 if the device authenticated successfully
+		with SPDM (Security Protocol and Data Model).  It contains 0 if
+		the device failed authentication (and may thus be malicious).
+
+		Writing "re" to this file causes reauthentication.
+		That may be opportune after updating the device keyring.
+		The device keyring of the PCI bus is named ".cma"
+		(Component Measurement and Authentication).
+
+		Reauthentication may also be necessary after device identity
+		has mutated, e.g. after downloading firmware to an FPGA device.
+
+		The file is not visible if authentication is unsupported
+		by the device.
+
+		If the kernel could not determine whether authentication is
+		supported because memory was low or communication with the
+		device was not working, the file is visible but accessing it
+		fails with error code ENOTTY.
+
+		This prevents downgrade attacks where an attacker consumes
+		memory or disturbs communication in order to create the
+		appearance that a device does not support authentication.
+
+		The reason why authentication support could not be determined
+		is apparent from "dmesg".  To re-probe authentication support
+		of PCI devices, exercise the "remove" and "rescan" attributes.
diff --git a/MAINTAINERS b/MAINTAINERS
index 9aad3350da16..1ed5817e698c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20153,6 +20153,7 @@ L:	linux-cxl@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
+F:	Documentation/ABI/testing/sysfs-devices-spdm
 F:	drivers/pci/cma*
 F:	include/linux/spdm.h
 F:	lib/spdm/
diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
index f2c435b04b92..59558714f143 100644
--- a/drivers/pci/cma.c
+++ b/drivers/pci/cma.c
@@ -171,8 +171,10 @@ void pci_cma_init(struct pci_dev *pdev)
 {
 	struct pci_doe_mb *doe;
 
-	if (IS_ERR(pci_cma_keyring))
+	if (IS_ERR(pci_cma_keyring)) {
+		pdev->spdm_state = ERR_PTR(-ENOTTY);
 		return;
+	}
 
 	if (!pci_is_pcie(pdev))
 		return;
@@ -185,8 +187,10 @@ void pci_cma_init(struct pci_dev *pdev)
 	pdev->spdm_state = spdm_create(&pdev->dev, pci_doe_transport, doe,
 				       PCI_DOE_MAX_PAYLOAD, pci_cma_keyring,
 				       pci_cma_validate);
-	if (!pdev->spdm_state)
+	if (!pdev->spdm_state) {
+		pdev->spdm_state = ERR_PTR(-ENOTTY);
 		return;
+	}
 
 	/*
 	 * Keep spdm_state allocated even if initial authentication fails
@@ -204,7 +208,7 @@ void pci_cma_init(struct pci_dev *pdev)
  */
 void pci_cma_reauthenticate(struct pci_dev *pdev)
 {
-	if (!pdev->spdm_state)
+	if (IS_ERR_OR_NULL(pdev->spdm_state))
 		return;
 
 	spdm_authenticate(pdev->spdm_state);
@@ -212,7 +216,7 @@ void pci_cma_reauthenticate(struct pci_dev *pdev)
 
 void pci_cma_destroy(struct pci_dev *pdev)
 {
-	if (!pdev->spdm_state)
+	if (IS_ERR_OR_NULL(pdev->spdm_state))
 		return;
 
 	spdm_destroy(pdev->spdm_state);
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 34bb8f232799..0f94c4ed719e 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -694,6 +694,7 @@ void pci_doe_init(struct pci_dev *pdev)
 		if (IS_ERR(doe_mb)) {
 			pci_err(pdev, "[%x] failed to create mailbox: %ld\n",
 				offset, PTR_ERR(doe_mb));
+			pci_cma_disable(pdev);
 			continue;
 		}
 
@@ -702,6 +703,7 @@ void pci_doe_init(struct pci_dev *pdev)
 			pci_err(pdev, "[%x] failed to insert mailbox: %d\n",
 				offset, rc);
 			pci_doe_destroy_mb(doe_mb);
+			pci_cma_disable(pdev);
 		}
 	}
 }
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 40cfa716392f..d9e467cbec6e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1661,6 +1661,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 #endif
 #ifdef CONFIG_PCIEASPM
 	&aspm_ctrl_attr_group,
+#endif
+#ifdef CONFIG_PCI_CMA
+	&spdm_attr_group,
 #endif
 	NULL,
 };
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b4c2ce5fd070..0041d39ca089 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -337,10 +337,15 @@ static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 void pci_cma_init(struct pci_dev *pdev);
 void pci_cma_destroy(struct pci_dev *pdev);
 void pci_cma_reauthenticate(struct pci_dev *pdev);
+static inline void pci_cma_disable(struct pci_dev *pdev)
+{
+	pdev->spdm_state = ERR_PTR(-ENOTTY);
+}
 #else
 static inline void pci_cma_init(struct pci_dev *pdev) { }
 static inline void pci_cma_destroy(struct pci_dev *pdev) { }
 static inline void pci_cma_reauthenticate(struct pci_dev *pdev) { }
+static inline void pci_cma_disable(struct pci_dev *pdev) { }
 #endif
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cb2a0be57196..c29e9a196540 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2674,6 +2674,18 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
 void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #endif
 
+#ifdef CONFIG_PCI_CMA
+static inline struct spdm_state *pci_dev_to_spdm_state(struct pci_dev *pdev)
+{
+	return pdev->spdm_state;
+}
+#else
+static inline struct spdm_state *pci_dev_to_spdm_state(struct pci_dev *pdev)
+{
+	return NULL;
+}
+#endif
+
 #include <linux/dma-mapping.h>
 
 #define pci_printk(level, pdev, fmt, arg...) \
diff --git a/include/linux/spdm.h b/include/linux/spdm.h
index 568c68b17f1f..9835a3202a0e 100644
--- a/include/linux/spdm.h
+++ b/include/linux/spdm.h
@@ -34,4 +34,6 @@ int spdm_authenticate(struct spdm_state *spdm_state);
 
 void spdm_destroy(struct spdm_state *spdm_state);
 
+extern const struct attribute_group spdm_attr_group;
+
 #endif
diff --git a/lib/spdm/Makefile b/lib/spdm/Makefile
index f579cc898dbc..edd4a3cc3f5c 100644
--- a/lib/spdm/Makefile
+++ b/lib/spdm/Makefile
@@ -8,3 +8,4 @@
 obj-$(CONFIG_SPDM) += spdm.o
 
 spdm-y := core.o req-authenticate.o
+spdm-$(CONFIG_SYSFS) += req-sysfs.o
diff --git a/lib/spdm/req-sysfs.c b/lib/spdm/req-sysfs.c
new file mode 100644
index 000000000000..9bbed7abc153
--- /dev/null
+++ b/lib/spdm/req-sysfs.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DMTF Security Protocol and Data Model (SPDM)
+ * https://www.dmtf.org/dsp/DSP0274
+ *
+ * Requester role: sysfs interface
+ *
+ * Copyright (C) 2023-24 Intel Corporation
+ */
+
+#include "spdm.h"
+
+#include <linux/pci.h>
+
+/**
+ * dev_to_spdm_state() - Retrieve SPDM session state for given device
+ *
+ * @dev: Responder device
+ *
+ * Returns a pointer to the device's SPDM session state,
+ *	   %NULL if the device doesn't have one or
+ *	   %ERR_PTR if it couldn't be determined whether SPDM is supported.
+ *
+ * In the %ERR_PTR case, attributes are visible but return an error on access.
+ * This prevents downgrade attacks where an attacker disturbs memory allocation
+ * or communication with the device in order to create the appearance that SPDM
+ * is unsupported.  E.g. with PCI devices, the attacker may foil CMA or DOE
+ * initialization by simply hogging memory.
+ */
+static struct spdm_state *dev_to_spdm_state(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return pci_dev_to_spdm_state(to_pci_dev(dev));
+
+	/* Insert mappers for further bus types here. */
+
+	return NULL;
+}
+
+/* authenticated attribute */
+
+static umode_t spdm_attrs_are_visible(struct kobject *kobj,
+				      struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct spdm_state *spdm_state = dev_to_spdm_state(dev);
+
+	if (!spdm_state)
+		return SYSFS_GROUP_INVISIBLE;
+
+	return a->mode;
+}
+
+static ssize_t authenticated_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct spdm_state *spdm_state = dev_to_spdm_state(dev);
+	int rc;
+
+	if (IS_ERR(spdm_state))
+		return PTR_ERR(spdm_state);
+
+	if (sysfs_streq(buf, "re")) {
+		rc = spdm_authenticate(spdm_state);
+		if (rc)
+			return rc;
+	} else {
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t authenticated_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct spdm_state *spdm_state = dev_to_spdm_state(dev);
+
+	if (IS_ERR(spdm_state))
+		return PTR_ERR(spdm_state);
+
+	return sysfs_emit(buf, "%u\n", spdm_state->authenticated);
+}
+static DEVICE_ATTR_RW(authenticated);
+
+static struct attribute *spdm_attrs[] = {
+	&dev_attr_authenticated.attr,
+	NULL
+};
+
+const struct attribute_group spdm_attr_group = {
+	.attrs = spdm_attrs,
+	.is_visible = spdm_attrs_are_visible,
+};
diff --git a/lib/spdm/spdm.h b/lib/spdm/spdm.h
index 0e3bb6e18d91..0992b2bc3942 100644
--- a/lib/spdm/spdm.h
+++ b/lib/spdm/spdm.h
@@ -418,6 +418,7 @@ struct spdm_error_rsp {
  * struct spdm_state - SPDM session state
  *
  * @dev: Responder device.  Used for error reporting and passed to @transport.
+ *	Attributes in sysfs appear below this device's directory.
  * @lock: Serializes multiple concurrent spdm_authenticate() calls.
  * @authenticated: Whether device was authenticated successfully.
  * @dev: Responder device.  Used for error reporting and passed to @transport.
-- 
2.43.0


