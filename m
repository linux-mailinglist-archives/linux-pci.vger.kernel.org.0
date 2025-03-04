Return-Path: <linux-pci+bounces-22815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3559A4D4B6
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 08:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9063B14E0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 07:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9351F76B4;
	Tue,  4 Mar 2025 07:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAFJxGPF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5FA1F76A8
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 07:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072488; cv=none; b=RFhR2ycBYFMf82m2muhu7IMficwPxvhVJb77yMzDg+FGcFVNrdDFw5Ngqsw/FB2DmIuw6pm4+45A/+RlZsl563InqgHmQlGwRUnyzqcToSChCJhSinm5lzpOyjC/qUVGk0j3gqXMR9xDcwfjLSN5MkqSQzMreUXabijnJAQpZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072488; c=relaxed/simple;
	bh=lHorGtrGPgvWvAiW7aEKuvcs2Heqie+KAH3L4WVkZW4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URprEb6MZ6YEBz9PY8iLElNvqS9HBpa9qvDRaKXKy/CNevM75en4WkNZtP+xQwC/svScDqDjMLXrBxIsiZbn2fzaPTkfMQoTYtQf1Vpe6yvZ6mTJAKYJSZ1WRn0vUin5H8ub86gW0woLeyX8U4GbwqvLndm5et3Fw6OcEnHdZRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CAFJxGPF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741072486; x=1772608486;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lHorGtrGPgvWvAiW7aEKuvcs2Heqie+KAH3L4WVkZW4=;
  b=CAFJxGPFNvyu++7epW2VdCjLrV8I+IjzG/aYpTM1vTEVQAwupBU3Ampo
   xK0TN+tHqirlWGW/ddSwfG+2lGQA7+FG39xmP7UsR31vY00rhXe8Yx/bJ
   XR+LIJqxBpVdWnc8XXEN8cj/wn94kkMJB+zGS30RFPD5YQ+7Jrckp+LvW
   55LBHmYktKMmWHlmSsGlhvJEJUsrYetfW9z9xxZyH+azzLy8I2yih3TIg
   apH9DhpfXG5jR9ehgGIbPCY865/jsW1THKABPRHj49DTNBDXIyhKu4dJW
   lJndiNH/AkjX08x/MNMEDxs51/1T+heBdFsYCjdeqZYcWbtVXob/UXMpN
   g==;
X-CSE-ConnectionGUID: /Cnwj7UNSae3GCWx1H8OzQ==
X-CSE-MsgGUID: J7g0QjZrStC9hXnNHjbV8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="29565131"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="29565131"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:14:45 -0800
X-CSE-ConnectionGUID: v6rzj1WyT3+kw40KlMIr3A==
X-CSE-MsgGUID: lg3r1DjHRY+EkRq+WO36jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="122905524"
Received: from inaky-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.47])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:14:45 -0800
Subject: [PATCH v2 05/11] PCI/TSM: Authenticate devices via platform TSM
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
 Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, gregkh@linuxfoundation.org,
 linux-pci@vger.kernel.org, aik@amd.com, lukas@wunner.de
Date: Mon, 03 Mar 2025 23:14:44 -0800
Message-ID: <174107248456.1288555.10068789075179290465.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The PCIe 6.1 specification, section 11, introduces the Trusted Execution
Environment (TEE) Device Interface Security Protocol (TDISP).  This
protocol definition builds upon Component Measurement and Authentication
(CMA), and link Integrity and Data Encryption (IDE). It adds support for
assigning devices (PCI physical or virtual function) to a confidential
VM such that the assigned device is enabled to access guest private
memory protected by technologies like Intel TDX, AMD SEV-SNP, RISCV
COVE, or ARM CCA.

The "TSM" (TEE Security Manager) is a concept in the TDISP specification
of an agent that mediates between a "DSM" (Device Security Manager) and
system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
to setup link security and assign devices. A confidential VM uses TSM
ABIs to transition an assigned device into the TDISP "RUN" state and
validate its configuration. From a Linux perspective the TSM abstracts
many of the details of TDISP, IDE, and CMA. Some of those details leak
through at times, but for the most part TDISP is an internal
implementation detail of the TSM.

CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
to pci-sysfs. Consider that the TSM driver may itself be a PCI driver.
Userspace can watch for the arrival of the "TSM" core device,
/sys/class/tsm/tsm0/uevent, to know when the PCI core has initialized
TSM services.

The common verbs that the low-level TSM drivers implement are defined by
'struct pci_tsm_ops'. For now only 'connect' and 'disconnect' are
defined for secure session and IDE establishment. The 'probe' and
'remove' operations setup per-device context objects starting with
'struct pci_tsm_pf0', the device Physical Function 0 that mediates
communication to the device's Security Manager (DSM).

The locking allows for multiple devices to be executing commands
simultaneously, one outstanding command per-device and an rwsem
synchronizes the implementation relative to TSM
registration/unregistration events.

Thanks to Wu Hao for his work on an early draft of this support.

Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |   45 ++++
 MAINTAINERS                             |    2 
 drivers/pci/Kconfig                     |   23 ++
 drivers/pci/Makefile                    |    1 
 drivers/pci/pci-sysfs.c                 |    4 
 drivers/pci/pci.h                       |   10 +
 drivers/pci/probe.c                     |    1 
 drivers/pci/remove.c                    |    3 
 drivers/pci/tsm.c                       |  377 +++++++++++++++++++++++++++++++
 drivers/virt/coco/host/tsm-core.c       |   19 +-
 include/linux/pci-tsm.h                 |  135 +++++++++++
 include/linux/pci.h                     |    3 
 include/linux/tsm.h                     |    4 
 include/uapi/linux/pci_regs.h           |    1 
 14 files changed, 625 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/tsm.c
 create mode 100644 include/linux/pci-tsm.h

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 5da6a14dc326..816a342695b3 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -583,3 +583,48 @@ Description:
 		enclosure-specific indications "specific0" to "specific7",
 		hence the corresponding led class devices are unavailable if
 		the DSM interface is used.
+
+What:		/sys/bus/pci/devices/.../tsm/
+Date:		July 2024
+Contact:	linux-coco@lists.linux.dev
+Description:
+		This directory only appears if a physical device function
+		supports authentication (PCIe CMA-SPDM), interface security
+		(PCIe TDISP), and is accepted for secure operation by the
+		platform TSM driver. This attribute directory appears
+		dynamically after the platform TSM driver loads. So, only after
+		the /sys/class/tsm/tsm0 device arrives can tools assume that
+		devices without a tsm/ attribute directory will never have one,
+		before that, the security capabilities of the device relative to
+		the platform TSM are unknown. See
+		Documentation/ABI/testing/sysfs-class-tsm.
+
+What:		/sys/bus/pci/devices/.../tsm/connect
+Date:		July 2024
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RW) Writing "1" to this file triggers the platform TSM (TEE
+		Security Manager) to establish a connection with the device.
+		This typically includes an SPDM (DMTF Security Protocols and
+		Data Models) session over PCIe DOE (Data Object Exchange) and
+		may also include PCIe IDE (Integrity and Data Encryption)
+		establishment.
+
+What:		/sys/bus/pci/devices/.../authenticated
+Date:		July 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		When the device's tsm/ directory is present device
+		authentication (PCIe CMA-SPDM) and link encryption (PCIe IDE)
+		are handled by the platform TSM (TEE Security Manager). When the
+		tsm/ directory is not present this attribute reflects only the
+		native CMA-SPDM authentication state with the kernel's
+		certificate store.
+
+		If the attribute is not present, it indicates that
+		authentication is unsupported by the device, or the TSM has no
+		available authentication methods for the device.
+
+		When present and the tsm/ attribute directory is present, the
+		authenticated attribute is an alias for the device 'connect'
+		state. See the 'tsm/connect' attribute for more details.
diff --git a/MAINTAINERS b/MAINTAINERS
index 352f982f435e..80a5951bfa04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24116,8 +24116,10 @@ M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-coco@lists.linux.dev
 S:	Maintained
 F:	Documentation/ABI/testing/configfs-tsm-report
+F:	drivers/pci/tsm.c
 F:	drivers/virt/coco/guest/
 F:	drivers/virt/coco/host/
+F:	include/linux/pci-tsm.h
 F:	include/linux/tsm.h
 
 TRUSTED SERVICES TEE DRIVER
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 5fb6dd113b0d..f9e0e517aaed 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -135,6 +135,29 @@ config PCI_IDE_STREAM_MAX
 	  track the maximum possibility of 256 streams per host bridge
 	  in the typical case.
 
+config PCI_TSM
+	bool "PCI TSM: Device security protocol support"
+	select PCI_IDE
+	select PCI_DOE
+	help
+	  The TEE (Trusted Execution Environment) Device Interface
+	  Security Protocol (TDISP) defines a "TSM" as a platform agent
+	  that manages device authentication, link encryption, link
+	  integrity protection, and assignment of PCI device functions
+	  (virtual or physical) to confidential computing VMs that can
+	  access (DMA) guest private memory.
+
+	  Enable a platform TSM driver to use this capability.
+
+config PCI_TSM_DEBUG
+	bool "PCI TSM: Debug"
+	depends on PCI_TSM
+	help
+	  Enable runtime sanity checks and assertions for the pci_tsm
+	  object model. For example, validate that a low-level TSM
+	  driver use the expected initialization helpers for newly
+	  created objects.
+
 config PCI_DOE
 	bool
 
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 6612256fd37d..2c545f877062 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
 obj-$(CONFIG_PCI_IDE)		+= ide.o
+obj-$(CONFIG_PCI_TSM)		+= tsm.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index b46ce1a2c554..b595cbaed8c0 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1804,6 +1804,10 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 #endif
 #ifdef CONFIG_PCIEASPM
 	&aspm_ctrl_attr_group,
+#endif
+#ifdef CONFIG_PCI_TSM
+	&pci_tsm_auth_attr_group,
+	&pci_tsm_pf0_attr_group,
 #endif
 	NULL,
 };
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6927028ab695..b38bdd91e742 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -462,6 +462,16 @@ void pci_ide_init(struct pci_dev *dev);
 static inline void pci_ide_init(struct pci_dev *dev) { }
 #endif
 
+#ifdef CONFIG_PCI_TSM
+void pci_tsm_init(struct pci_dev *pdev);
+void pci_tsm_destroy(struct pci_dev *pdev);
+extern const struct attribute_group pci_tsm_pf0_attr_group;
+extern const struct attribute_group pci_tsm_auth_attr_group;
+#else
+static inline void pci_tsm_init(struct pci_dev *pdev) { }
+static inline void pci_tsm_destroy(struct pci_dev *pdev) { }
+#endif
+
 /**
  * pci_dev_set_io_state - Set the new error state if possible.
  *
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6114d199c1d5..1d1d7de642da 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2566,6 +2566,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_doe_init(dev);		/* Data Object Exchange */
 	pci_tph_init(dev);		/* TLP Processing Hints */
 	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
+	pci_tsm_init(dev);		/* TEE Security Manager connection */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index efc37fcb73e2..fd4ccafed067 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -55,6 +55,9 @@ static void pci_destroy_dev(struct pci_dev *dev)
 
 	pci_npem_remove(dev);
 
+	/* before device_del() to keep config cycle access */
+	pci_tsm_destroy(dev);
+
 	device_del(&dev->dev);
 
 	down_write(&pci_bus_sem);
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
new file mode 100644
index 000000000000..e5ea9f306672
--- /dev/null
+++ b/drivers/pci/tsm.c
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TEE Security Manager for the TEE Device Interface Security Protocol
+ * (TDISP, PCIe r6.1 sec 11)
+ *
+ * Copyright(c) 2024 Intel Corporation. All rights reserved.
+ */
+
+#define dev_fmt(fmt) "TSM: " fmt
+
+#include <linux/bitfield.h>
+#include <linux/xarray.h>
+#include <linux/sysfs.h>
+
+#include <linux/pci.h>
+#include <linux/pci-doe.h>
+#include <linux/pci-tsm.h>
+#include "pci.h"
+
+/*
+ * Provide a read/write lock against the init / exit of pdev tsm
+ * capabilities and arrival/departure of a tsm instance
+ */
+static DECLARE_RWSEM(pci_tsm_rwsem);
+static const struct pci_tsm_ops *tsm_ops;
+
+/* supplemental attributes to surface when pci_tsm_attr_group is active */
+static const struct attribute_group *pci_tsm_owner_attr_group;
+
+static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *pci_tsm)
+{
+	struct pci_dev *pdev = pci_tsm->pdev;
+
+	if (!is_pci_tsm_pf0(pdev) || !pci_tsm_check_type(pci_tsm, PCI_TSM_PF0)) {
+		dev_WARN_ONCE(&pdev->dev, 1, "invalid context object\n");
+		return NULL;
+	}
+
+	return container_of(pci_tsm, struct pci_tsm_pf0, tsm);
+}
+
+static struct mutex *tsm_ops_lock(struct pci_tsm_pf0 *tsm)
+{
+	lockdep_assert_held(&pci_tsm_rwsem);
+
+	if (mutex_lock_interruptible(&tsm->lock) != 0)
+		return NULL;
+	return &tsm->lock;
+}
+DEFINE_FREE(tsm_ops_unlock, struct mutex *, if (_T) mutex_unlock(_T))
+
+static int pci_tsm_disconnect(struct pci_dev *pdev)
+{
+	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
+
+	struct mutex *lock __free(tsm_ops_unlock) = tsm_ops_lock(tsm);
+	if (!lock)
+		return -EINTR;
+
+	if (tsm->state < PCI_TSM_INIT)
+		return -ENXIO;
+	if (tsm->state < PCI_TSM_CONNECT)
+		return 0;
+
+	tsm_ops->disconnect(pdev);
+	tsm->state = PCI_TSM_INIT;
+
+	return 0;
+}
+
+static int pci_tsm_connect(struct pci_dev *pdev)
+{
+	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
+	int rc;
+
+	struct mutex *lock __free(tsm_ops_unlock) = tsm_ops_lock(tsm);
+	if (!lock)
+		return -EINTR;
+
+	if (tsm->state < PCI_TSM_INIT)
+		return -ENXIO;
+	if (tsm->state >= PCI_TSM_CONNECT)
+		return 0;
+
+	rc = tsm_ops->connect(pdev);
+	if (rc)
+		return rc;
+	tsm->state = PCI_TSM_CONNECT;
+	return 0;
+}
+
+/* registration read lock */
+static struct rw_semaphore *tsm_read_lock(void)
+{
+	if (down_read_interruptible(&pci_tsm_rwsem))
+		return NULL;
+	return &pci_tsm_rwsem;
+}
+DEFINE_FREE(tsm_read_unlock, struct rw_semaphore *, if (_T) up_read(_T))
+
+static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t len)
+{
+	int rc;
+	bool connect;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	rc = kstrtobool(buf, &connect);
+	if (rc)
+		return rc;
+
+	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
+	if (!lock)
+		return -EINTR;
+
+	if (connect)
+		rc = pci_tsm_connect(pdev);
+	else
+		rc = pci_tsm_disconnect(pdev);
+	if (rc)
+		return rc;
+	return len;
+}
+
+static ssize_t connect_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_tsm_pf0 *tsm;
+
+	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
+	if (!lock)
+		return -EINTR;
+
+	if (!pdev->tsm)
+		return -ENXIO;
+
+	tsm = to_pci_tsm_pf0(pdev->tsm);
+	return sysfs_emit(buf, "%d\n", tsm->state >= PCI_TSM_CONNECT);
+}
+static DEVICE_ATTR_RW(connect);
+
+static bool pci_tsm_pf0_group_visible(struct kobject *kobj)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (pdev->tsm && is_pci_tsm_pf0(pdev))
+		return true;
+	return false;
+}
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm_pf0);
+
+static struct attribute *pci_tsm_pf0_attrs[] = {
+	&dev_attr_connect.attr,
+	NULL
+};
+
+const struct attribute_group pci_tsm_pf0_attr_group = {
+	.name = "tsm",
+	.attrs = pci_tsm_pf0_attrs,
+	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm_pf0),
+};
+
+static ssize_t authenticated_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	/*
+	 * When device authentication is TSM owned, 'authenticated' is
+	 * identical to the connect state.
+	 */
+	return connect_show(dev, attr, buf);
+}
+static DEVICE_ATTR_RO(authenticated);
+
+static struct attribute *pci_tsm_auth_attrs[] = {
+	&dev_attr_authenticated.attr,
+	NULL
+};
+
+const struct attribute_group pci_tsm_auth_attr_group = {
+	.attrs = pci_tsm_auth_attrs,
+	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm_pf0),
+};
+
+/**
+ * pci_tsm_pf0_initialize() - common 'struct pci_tsm_pf0' initialization
+ * @pdev: Physical Function 0 PCI device
+ * @tsm: context to initialize
+ */
+int pci_tsm_pf0_initialize(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm)
+{
+	mutex_init(&tsm->lock);
+	tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
+					   PCI_DOE_PROTO_CMA);
+	if (!tsm->doe_mb) {
+		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
+		return -ENODEV;
+	}
+
+	tsm->state = PCI_TSM_INIT;
+	pci_tsm_set_type(&tsm->tsm, PCI_TSM_PF0);
+	tsm->tsm.pdev = pdev;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_pf0_initialize);
+
+static void tsm_remove(struct pci_tsm *tsm)
+{
+	if (!tsm)
+		return;
+	tsm_ops->remove(tsm);
+}
+DEFINE_FREE(tsm_remove, struct pci_tsm *, if (_T) tsm_remove(_T))
+
+static void pci_tsm_pf0_init(struct pci_dev *pdev)
+{
+	bool tee_cap;
+
+	tee_cap = pdev->devcap & PCI_EXP_DEVCAP_TEE;
+
+	if (!(pdev->ide_cap || tee_cap))
+		return;
+
+	lockdep_assert_held_write(&pci_tsm_rwsem);
+	if (!tsm_ops)
+		return;
+
+	/*
+	 * If a physical device has any security capabilities it may be
+	 * a candidate to connect with the platform TSM
+	 */
+	struct pci_tsm *pci_tsm __free(tsm_remove) = tsm_ops->probe(pdev);
+
+	pci_dbg(pdev, "Device security capabilities detected (%s%s ), TSM %s\n",
+		pdev->ide_cap ? " ide" : "", tee_cap ? " tee" : "",
+		pci_tsm ? "attach" : "skip");
+
+	if (!pci_tsm)
+		return;
+
+	pdev->tsm = no_free_ptr(pci_tsm);
+	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
+	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_pf0_attr_group);
+	if (pci_tsm_owner_attr_group)
+		sysfs_merge_group(&pdev->dev.kobj, pci_tsm_owner_attr_group);
+}
+
+static void pci_tsm_virtfn_init(struct pci_dev *pdev)
+{
+	if (!pci_physfn(pdev)->tsm)
+		return;
+
+	struct pci_tsm *pci_tsm __free(tsm_remove) = tsm_ops->probe(pdev);
+	if (!pci_tsm)
+		return;
+
+	pdev->tsm = no_free_ptr(pci_tsm);
+}
+
+static void pci_tsm_mfd_init(struct pci_dev *pdev)
+{
+	struct pci_dev *pf0_dev __free(pci_dev_put) =
+		pci_get_slot(pdev->bus, pdev->devfn - PCI_FUNC(pdev->devfn));
+
+	if (!pf0_dev)
+		return;
+
+	if (!pf0_dev->tsm)
+		return;
+
+	struct pci_tsm *pci_tsm __free(tsm_remove) = tsm_ops->probe(pdev);
+	if (!pci_tsm)
+		return;
+
+	pdev->tsm = no_free_ptr(pci_tsm);
+}
+
+static void __pci_tsm_init(struct pci_dev *pdev)
+{
+	if (is_pci_tsm_pf0(pdev))
+		pci_tsm_pf0_init(pdev);
+	else if (pdev->is_virtfn)
+		pci_tsm_virtfn_init(pdev);
+	else
+		pci_tsm_mfd_init(pdev);
+}
+
+void pci_tsm_init(struct pci_dev *pdev)
+{
+	guard(rwsem_write)(&pci_tsm_rwsem);
+	__pci_tsm_init(pdev);
+}
+
+int pci_tsm_core_register(const struct pci_tsm_ops *ops, const struct attribute_group *grp)
+{
+	struct pci_dev *pdev = NULL;
+
+	if (!ops)
+		return 0;
+	guard(rwsem_write)(&pci_tsm_rwsem);
+	if (tsm_ops)
+		return -EBUSY;
+	tsm_ops = ops;
+	pci_tsm_owner_attr_group = grp;
+	for_each_pci_dev(pdev)
+		__pci_tsm_init(pdev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_core_register);
+
+static void pci_tsm_pf0_destroy(struct pci_dev *pdev)
+{
+	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
+
+	if (tsm->state > PCI_TSM_INIT)
+		pci_tsm_disconnect(pdev);
+	pdev->tsm = NULL;
+	if (pci_tsm_owner_attr_group)
+		sysfs_unmerge_group(&pdev->dev.kobj, pci_tsm_owner_attr_group);
+	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_pf0_attr_group);
+	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
+}
+
+static void __pci_tsm_destroy(struct pci_dev *pdev)
+{
+	struct pci_tsm *pci_tsm = pdev->tsm;
+
+	if (!pci_tsm)
+		return;
+
+	lockdep_assert_held_write(&pci_tsm_rwsem);
+
+	if (is_pci_tsm_pf0(pdev))
+		pci_tsm_pf0_destroy(pdev);
+	tsm_ops->remove(pci_tsm);
+}
+
+void pci_tsm_destroy(struct pci_dev *pdev)
+{
+	guard(rwsem_write)(&pci_tsm_rwsem);
+	__pci_tsm_destroy(pdev);
+}
+
+void pci_tsm_core_unregister(const struct pci_tsm_ops *ops)
+{
+	struct pci_dev *pdev = NULL;
+
+	if (!ops)
+		return;
+	guard(rwsem_write)(&pci_tsm_rwsem);
+	if (ops != tsm_ops)
+		return;
+	for_each_pci_dev(pdev)
+		__pci_tsm_destroy(pdev);
+	tsm_ops = NULL;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_core_unregister);
+
+int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
+			 const void *req, size_t req_sz, void *resp,
+			 size_t resp_sz)
+{
+	struct pci_tsm_pf0 *tsm;
+
+	if (!pdev->tsm || !is_pci_tsm_pf0(pdev))
+		return -ENXIO;
+
+	tsm = to_pci_tsm_pf0(pdev->tsm);
+	if (!tsm->doe_mb)
+		return -ENXIO;
+
+	return pci_doe(tsm->doe_mb, PCI_VENDOR_ID_PCI_SIG, type, req, req_sz,
+		       resp, resp_sz);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
diff --git a/drivers/virt/coco/host/tsm-core.c b/drivers/virt/coco/host/tsm-core.c
index 4f64af1a8967..51146f226a64 100644
--- a/drivers/virt/coco/host/tsm-core.c
+++ b/drivers/virt/coco/host/tsm-core.c
@@ -8,11 +8,13 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/cleanup.h>
+#include <linux/pci-tsm.h>
 
 static DECLARE_RWSEM(tsm_core_rwsem);
 static struct class *tsm_class;
 static struct tsm_core_dev {
 	struct device dev;
+	const struct pci_tsm_ops *pci_ops;
 } *tsm_core;
 
 static struct tsm_core_dev *
@@ -39,7 +41,8 @@ static void put_tsm_core(struct tsm_core_dev *core)
 DEFINE_FREE(put_tsm_core, struct tsm_core_dev *,
 	    if (!IS_ERR_OR_NULL(_T)) put_tsm_core(_T))
 struct tsm_core_dev *tsm_register(struct device *parent,
-				  const struct attribute_group **groups)
+				  const struct attribute_group **groups,
+				  const struct pci_tsm_ops *pci_ops)
 {
 	struct device *dev;
 	int rc;
@@ -61,10 +64,20 @@ struct tsm_core_dev *tsm_register(struct device *parent,
 	if (rc)
 		return ERR_PTR(rc);
 
+	rc = pci_tsm_core_register(pci_ops, NULL);
+	if (rc) {
+		dev_err(parent, "PCI initialization failure: %pe\n",
+			ERR_PTR(rc));
+		return ERR_PTR(rc);
+	}
+
 	rc = device_add(dev);
-	if (rc)
+	if (rc) {
+		pci_tsm_core_unregister(pci_ops);
 		return ERR_PTR(rc);
+	}
 
+	core->pci_ops = pci_ops;
 	tsm_core = no_free_ptr(core);
 
 	return tsm_core;
@@ -79,7 +92,9 @@ void tsm_unregister(struct tsm_core_dev *core)
 		return;
 	}
 
+	pci_tsm_core_unregister(core->pci_ops);
 	device_unregister(&core->dev);
+
 	tsm_core = NULL;
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
new file mode 100644
index 000000000000..17657b7ef66c
--- /dev/null
+++ b/include/linux/pci-tsm.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PCI_TSM_H
+#define __PCI_TSM_H
+#include <linux/mutex.h>
+#include <linux/pci.h>
+
+struct pci_dev;
+
+enum pci_tsm_state {
+	PCI_TSM_ERR = -1,
+	PCI_TSM_INIT,
+	PCI_TSM_CONNECT,
+};
+
+enum pci_tsm_type {
+	PCI_TSM_INVALID,
+	PCI_TSM_PF0,
+	PCI_TSM_VIRTFN,
+	PCI_TSM_MFD,
+};
+
+/**
+ * struct pci_tsm - Core TSM context for a given PCIe endpoint
+ * @pdev: indicates the type of pci_tsm object
+ * @type: debug validation of the pci_tsm object type inferred by @pdev
+ *
+ * This structure is wrapped by a low level TSM driver and returned by
+ * tsm_ops.probe(), it is freed by tsm_ops.remove(). Depending on
+ * whether @pdev is physical function 0, another physical function, or a
+ * virtual function determines the pci_tsm object type. E.g. see 'struct
+ * pci_tsm_pf0'.
+ */
+struct pci_tsm {
+	struct pci_dev *pdev;
+#ifdef CONFIG_PCI_TSM_DEBUG
+	enum pci_tsm_type type;
+#endif
+};
+
+#ifdef CONFIG_PCI_TSM_DEBUG
+static inline void pci_tsm_set_type(struct pci_tsm *pci_tsm, enum pci_tsm_type type)
+{
+	pci_tsm->type = type;
+}
+static inline bool pci_tsm_check_type(struct pci_tsm *pci_tsm, enum pci_tsm_type type)
+{
+	return pci_tsm->type == type;
+}
+#else
+static inline void pci_tsm_set_type(struct pci_tsm *pci_tsm, enum pci_tsm_type type)
+{
+}
+
+static inline bool pci_tsm_check_type(struct pci_tsm *pci_tsm, enum pci_tsm_type type)
+{
+	return true;
+}
+#endif
+
+/**
+ * struct pci_tsm_pf0 - Physical Function 0 TDISP context
+ * @state: reflect device initialized, connected, or bound
+ * @lock: protect @state vs pci_tsm_ops invocation
+ * @doe_mb: PCIe Data Object Exchange mailbox
+ */
+struct pci_tsm_pf0 {
+	struct pci_tsm tsm;
+	enum pci_tsm_state state;
+	struct mutex lock;
+	struct pci_doe_mb *doe_mb;
+};
+
+static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
+{
+	if (!pci_is_pcie(pdev))
+		return false;
+
+	if (pdev->is_virtfn)
+		return false;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+		return false;
+
+	return PCI_FUNC(pdev->devfn) == 0;
+}
+
+/**
+ * struct pci_tsm_ops - Low-level TSM-exported interface to the PCI core
+ * @probe: probe/accept device for tsm operation, setup DSM context
+ * @remove: destroy DSM context
+ * @connect: establish / validate a secure connection (e.g. IDE) with the device
+ * @disconnect: teardown the secure connection
+ *
+ * @probe and @remove run in pci_tsm_rwsem held for write context. All
+ * other ops run under the @pdev->tsm->lock mutex and pci_tsm_rwsem held
+ * for read.
+ */
+struct pci_tsm_ops {
+	struct pci_tsm *(*probe)(struct pci_dev *pdev);
+	void (*remove)(struct pci_tsm *tsm);
+	int (*connect)(struct pci_dev *pdev);
+	void (*disconnect)(struct pci_dev *pdev);
+};
+
+enum pci_doe_proto {
+	PCI_DOE_PROTO_CMA = 1,
+	PCI_DOE_PROTO_SSESSION = 2,
+};
+
+#ifdef CONFIG_PCI_TSM
+int pci_tsm_core_register(const struct pci_tsm_ops *ops,
+			  const struct attribute_group *grp);
+void pci_tsm_core_unregister(const struct pci_tsm_ops *ops);
+int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
+			 const void *req, size_t req_sz, void *resp,
+			 size_t resp_sz);
+int pci_tsm_pf0_initialize(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm);
+#else
+static inline int pci_tsm_core_register(const struct pci_tsm_ops *ops,
+					const struct attribute_group *grp)
+{
+	return 0;
+}
+static inline void pci_tsm_core_unregister(const struct pci_tsm_ops *ops)
+{
+}
+static inline int pci_tsm_doe_transfer(struct pci_dev *pdev,
+				       enum pci_doe_proto type, const void *req,
+				       size_t req_sz, void *resp,
+				       size_t resp_sz)
+{
+	return -ENOENT;
+}
+#endif
+#endif /*__PCI_TSM_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 628f9f5fdac9..57cfa0e3f2bd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -537,6 +537,9 @@ struct pci_dev {
 	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
 	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
 	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
+#endif
+#ifdef CONFIG_PCI_TSM
+	struct pci_tsm *tsm;		/* TSM operation state */
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
 	u8		supported_speeds; /* Supported Link Speeds Vector */
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 9253b79b8582..59d3848404e1 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -111,7 +111,9 @@ struct tsm_report_ops {
 int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
 int tsm_report_unregister(const struct tsm_report_ops *ops);
 struct tsm_core_dev;
+struct pci_tsm_ops;
 struct tsm_core_dev *tsm_register(struct device *parent,
-				  const struct attribute_group **groups);
+				  const struct attribute_group **groups,
+				  const struct pci_tsm_ops *ops);
 void tsm_unregister(struct tsm_core_dev *tsm_core);
 #endif /* __TSM_H */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 000258cd93c8..713588a29813 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -499,6 +499,7 @@
 #define  PCI_EXP_DEVCAP_PWR_VAL	0x03fc0000 /* Slot Power Limit Value */
 #define  PCI_EXP_DEVCAP_PWR_SCL	0x0c000000 /* Slot Power Limit Scale */
 #define  PCI_EXP_DEVCAP_FLR     0x10000000 /* Function Level Reset */
+#define  PCI_EXP_DEVCAP_TEE     0x40000000 /* TEE I/O (TDISP) Support */
 #define PCI_EXP_DEVCTL		0x08	/* Device Control */
 #define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
 #define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable */


