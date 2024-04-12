Return-Path: <linux-pci+bounces-6178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BBB8A2A2F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 11:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F51F288793
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 09:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6D058107;
	Fri, 12 Apr 2024 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7IoR3ES"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6422F58106
	for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2024 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911937; cv=none; b=KppGgplG5Bol076X+6+mAiYXUVKjJ8FovSn8o1BYljQFbFUwifcTazWhIXsIgs+RtpcsYIptJLnY6rQLcb4GEiuyx0j0+9Vd6TtwaOVcaMKR8dhQJZVQPqNZm7ACvbKeabNXxYRdrOs3yfIeRZUfbiFEBNwmyY23m1ZcnaaaVB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911937; c=relaxed/simple;
	bh=+EGlAuZoeqBwJQH/4ebs+SwuDIB1cgRIQ7mp68x+FvI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WThWbKBIp2K1nhy4RrhYkWOajG2t+lmqUIXwGCp+c2J08cBOgjwqgq6XuPLKT5WDL54x2qoS8EvBujq+VcGctqzHEVSL0EGw7S7sRq6aYGEAUTAFltyuB4ZvKpbMqAa4Ci3AQzn9ncBa9qlofMK0yWnWuodWfqE+j+QX1/qpyp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7IoR3ES; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712911935; x=1744447935;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+EGlAuZoeqBwJQH/4ebs+SwuDIB1cgRIQ7mp68x+FvI=;
  b=I7IoR3ESlUCFdfhaxqmQkKHiMAvHVCFIYyslTZ7jTIVXSpatFY2lJhJ8
   /x/8xLWDWGPn6/iDDp+2a8t3i5AZaiWHx6mID5smuoUnCocTadAcPAvBc
   rUo1PAv8SULeCCIFnipHvtnhXb7Z2brep3LesuG+0IRIzU02RZJncysys
   7hMCbkoRLBRRqifTRvKY2W4G1q8DzYr5SUi6fVv278Vve35t+8cyPTDUI
   6QDz8soeoyR0ntuBkU3xoC6uYq5SGRKXo8cZL6MEMGCFkE7pyF55U+0G9
   cGr0hvl1ybCD4E4IcC1Gl+E7PNrFj3+SDeRy8tq4b5y5+VoYyluElutGc
   w==;
X-CSE-ConnectionGUID: y9u4HSqWSWCrNyL12aMfww==
X-CSE-MsgGUID: 03kqLcc5RMWFICdoI9UThg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8468369"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="8468369"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:52:14 -0700
X-CSE-ConnectionGUID: H20WfK9yS16L6m1Gx6HNFw==
X-CSE-MsgGUID: zBB7DUmUQQ2AnR2hQ8jRlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21226757"
Received: from aclausch-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.251.15.202])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:52:13 -0700
Subject: [RFC PATCH v2 5/6] PCI/TSM: Authenticate devices via platform TSM
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev
Cc: Wu Hao <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
 Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, bhelgaas@google.com, kevin.tian@intel.com,
 gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, lukas@wunner.de
Date: Fri, 12 Apr 2024 01:52:13 -0700
Message-ID: <171291193308.3532867.129739584130889725.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com>
References: <171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com>
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
interface definition builds upon Component Measurement and
Authentication (CMA), and link Integrity and Data Encryption (IDE). It
adds support for assigning devices (PCI physical or virtual function) to
a confidential VM such that the assigned device is enabled to access
guest private memory protected by technologies like Intel TDX, AMD
SEV-SNP, RISCV COVE, or ARM CCA.

The "TSM" (TEE Security Manager) is a concept in the TDISP specification
of an agent that mediates between a "DSM" (Device Security Manager) and
system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
to setup link security and assign devices. A confidential VM uses TSM
ABIs to transition an assigned device into the TDISP "RUN" state and
validate its configuration. From a Linux perspective the TSM abstracts
many of the details of TDISP, IDE, and CMA. Some of those details leak
through at times, but for the most part TDISP is an internal
implementation detail of the TSM.

Similar to the PCI core extensions to support CONFIG_PCI_CMA,
CONFIG_PCI_TSM builds upon that to reuse the "authenticated" sysfs
attribute, and add more properties + controls in a tsm/ subdirectory of
the PCI device sysfs interface. Unlike CMA that can depend on a local to
the PCI core implementation, PCI_TSM needs to be prepared for late
loading of the platform TSM driver. Consider that the TSM driver may
itself be a PCI driver. Userspace can depend on the common TSM device
uevent to know when the PCI core has TSM services enabled. The PCI
device tsm/ subdirectory is supplemented by the TSM device pci/
directory for platform global TSM properties + controls.

The common verbs that the low-level TSM drivers implement are defined by
'enum pci_tsm_cmd'. For now only connect and disconnect are defined for
establishing a trust relationship between the host and the device,
securing the interconnect (optionally establishing IDE), and tearing
that down.

The locking allows for multiple devices to be executing commands
simultaneously, one outstanding command per-device and an rwsem flushes
all inflight commands when a TSM low-level driver/device is removed.

In addition to commands submitted through an 'exec' operation the
low-level TSM driver is notified of device arrival and departure events
via 'add' and 'del' operations. With those it can setup per-device
context, or filter devices that the TSM is not prepared to support.

Cc: Wu Hao <hao.wu@intel.com>
Cc: Yilun Xu <yilun.xu@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |   46 +++++
 MAINTAINERS                             |    2 
 drivers/pci/Kconfig                     |   13 +
 drivers/pci/Makefile                    |    2 
 drivers/pci/pci-sysfs.c                 |    4 
 drivers/pci/pci.h                       |   10 +
 drivers/pci/probe.c                     |    1 
 drivers/pci/remove.c                    |    1 
 drivers/pci/tsm.c                       |  270 +++++++++++++++++++++++++++++++
 drivers/virt/coco/host/tsm-core.c       |   22 ++-
 include/linux/pci-tsm.h                 |   80 +++++++++
 include/linux/pci.h                     |   11 +
 include/linux/tsm.h                     |    4 
 include/uapi/linux/pci_regs.h           |    4 
 14 files changed, 466 insertions(+), 4 deletions(-)
 create mode 100644 drivers/pci/tsm.c
 create mode 100644 include/linux/pci-tsm.h

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ecf47559f495..4ae50621e65b 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -500,3 +500,49 @@ Description:
 		console drivers from the device.  Raw users of pci-sysfs
 		resourceN attributes must be terminated prior to resizing.
 		Success of the resizing operation is not guaranteed.
+
+What:		/sys/bus/pci/devices/.../authenticated
+Date:		March 2024
+Contact:	linux-pci@vger.kernel.org
+Description:
+		This file contains 1 if the device authenticated successfully.
+		It contains 0 if the device failed authentication (and may thus
+		be malicious). There are 2 potential authentication methods:
+		native PCI CMA (Component Measurement and Authentication) and
+		PCI TSM (TEE Security Manager). In the PCI TSM case the device's
+		PCI CMA interface is subsumed by the TSM driver. A TSM
+		implementation uses its own private certificate store + keys to
+		authenticate the device. Without a TSM the kernel can
+		authenticate using its own certificate chain.
+
+		In the TSM case, "authenticated" is read-only (0444) and the
+		"tsm/connect" attribute reflects whether the device is TSM
+		"connected" which includes not only CMA authentication, but
+		optionally IDE (link Integrity and Data encryption) if the TSM
+		deems that is necessary. When the device is disconnected from
+		the TSM the kernel may attempt authentication with its own
+		certificate chain. See
+		Documentation/ABI/testing/sysfs-devices-spdm.
+
+		The file is not visible if authentication is unsupported by the
+		device, or if PCI CMA support is disabled and the TSM
+		driver has no available authentication methods for the device.
+
+What:		/sys/bus/pci/devices/.../tsm/
+Date:		March 2024
+Contact:	linux-coco@lists.linux.dev
+Description:
+		This directory only appears if a device supports CMA and IDE,
+		and only after a TSM driver has loaded and evaluated this
+		PCI device. All present devices shall be dispositioned
+		after the 'add' event for /sys/class/tsm/tsm0 triggers.
+
+What:		/sys/bus/pci/devices/.../tsm/connect
+Date:		March 2024
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RW) Writing "1" to this file triggers the TSM to establish a
+		connection with the device. This typically includes an SPDM
+		(DMTF Security Protocols and Data Models) session over PCIe DOE
+		(Data Object Exchange) and may also include PCIe IDE (Integrity
+		and Data Encryption) establishment.
diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bcd9d43ac..0e1d995e7a16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22466,8 +22466,10 @@ M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-coco@lists.linux.dev
 S:	Maintained
 F:	Documentation/ABI/testing/configfs-tsm
+F:	drivers/pci/tsm.c
 F:	drivers/virt/coco/guest/tsm_report.c
 F:	drivers/virt/coco/host/
+F:	include/linux/pci-tsm.h
 F:	include/linux/tsm.h
 
 TTY LAYER AND SERIAL DRIVERS
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index d35001589d88..cd863c5e49ca 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -121,6 +121,19 @@ config XEN_PCIDEV_FRONTEND
 config PCI_ATS
 	bool
 
+config PCI_TSM
+	bool "TEE Security Manager for PCI Device Security"
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
+
 config PCI_DOE
 	bool
 
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 175302036890..b9884a669c5f 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -35,6 +35,8 @@ obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 
+obj-$(CONFIG_PCI_TSM)		+= tsm.o
+
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
 
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 40cfa716392f..c6ea624dd76c 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1661,6 +1661,10 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 #endif
 #ifdef CONFIG_PCIEASPM
 	&aspm_ctrl_attr_group,
+#endif
+#ifdef CONFIG_PCI_TSM
+	&pci_tsm_auth_attr_group,
+	&pci_tsm_attr_group,
 #endif
 	NULL,
 };
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 17fed1846847..9b864cbf8682 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -335,6 +335,16 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
 static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #endif
 
+#ifdef CONFIG_PCI_TSM
+void pci_tsm_init(struct pci_dev *pdev);
+void pci_tsm_destroy(struct pci_dev *pdev);
+extern const struct attribute_group pci_tsm_attr_group;
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
index 1325fbae2f28..d89b67541d02 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2481,6 +2481,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_dpc_init(dev);		/* Downstream Port Containment */
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
 	pci_doe_init(dev);		/* Data Object Exchange */
+	pci_tsm_init(dev);		/* TEE Security Manager connection */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d749ea8250d6..d94b2458934a 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -39,6 +39,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	list_del(&dev->bus_list);
 	up_write(&pci_bus_sem);
 
+	pci_tsm_destroy(dev);
 	pci_doe_destroy(dev);
 	pcie_aspm_exit_link_state(dev);
 	pci_bridge_d3_update(dev);
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
new file mode 100644
index 000000000000..9c5fb2c46662
--- /dev/null
+++ b/drivers/pci/tsm.c
@@ -0,0 +1,270 @@
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
+#include <linux/pci.h>
+#include <linux/pci-doe.h>
+#include <linux/sysfs.h>
+#include <linux/xarray.h>
+#include <linux/pci-tsm.h>
+#include <linux/bitfield.h>
+#include "pci.h"
+
+/* collect TSM capable devices to rendezvous with the tsm driver */
+static DEFINE_XARRAY(pci_tsm_devs);
+
+/*
+ * Provide a read/write lock against the init / exit of pdev tsm
+ * capabilities and arrival/departure of a tsm instance
+ */
+static DECLARE_RWSEM(pci_tsm_rwsem);
+static const struct pci_tsm_ops *tsm_ops;
+
+static int pci_tsm_disconnect(struct pci_dev *pdev)
+{
+	struct pci_tsm *pci_tsm = pdev->tsm;
+
+	lockdep_assert_held_read(&pci_tsm_rwsem);
+	scoped_cond_guard(mutex_intr, return -EINTR, &pci_tsm->exec_lock) {
+		int rc;
+
+		if (pci_tsm->state < PCI_TSM_CONNECT)
+			return 0;
+		if (pci_tsm->state < PCI_TSM_INIT)
+			return -ENXIO;
+
+		rc = tsm_ops->exec(pdev, TSM_EXEC_DISCONNECT);
+		if (rc)
+			return rc;
+		pci_tsm->state = PCI_TSM_INIT;
+	}
+	return 0;
+}
+
+static int pci_tsm_connect(struct pci_dev *pdev)
+{
+	struct pci_tsm *pci_tsm = pdev->tsm;
+
+	lockdep_assert_held_read(&pci_tsm_rwsem);
+	scoped_cond_guard(mutex_intr, return -EINTR, &pci_tsm->exec_lock) {
+		int rc;
+
+		if (pci_tsm->state >= PCI_TSM_CONNECT)
+			return 0;
+		if (pci_tsm->state < PCI_TSM_INIT)
+			return -ENXIO;
+
+		rc = tsm_ops->exec(pdev, TSM_EXEC_CONNECT);
+		if (rc)
+			return rc;
+		pci_tsm->state = PCI_TSM_CONNECT;
+	}
+	return 0;
+}
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
+
+	return sysfs_emit(buf, "%d\n", pdev->tsm->state >= PCI_TSM_CONNECT);
+}
+static DEVICE_ATTR_RW(connect);
+
+static bool pci_tsm_group_visible(struct kobject *kobj)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (pdev->tsm && pdev->tsm->state > PCI_TSM_IDLE)
+		return true;
+	return false;
+}
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm);
+
+static struct attribute *pci_tsm_attrs[] = {
+	&dev_attr_connect.attr,
+	NULL,
+};
+
+const struct attribute_group pci_tsm_attr_group = {
+	.name = "tsm",
+	.attrs = pci_tsm_attrs,
+	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm),
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
+	NULL,
+};
+
+const struct attribute_group pci_tsm_auth_attr_group = {
+	.attrs = pci_tsm_auth_attrs,
+	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm),
+};
+
+static int pci_tsm_add(struct pci_dev *pdev)
+{
+	struct pci_tsm *pci_tsm = pdev->tsm;
+
+	lockdep_assert_held(&pci_tsm_rwsem);
+	if (!tsm_ops)
+		return 0;
+	if (pci_tsm->state < PCI_TSM_INIT) {
+		int rc = tsm_ops->add(pdev);
+
+		if (rc)
+			return rc;
+	}
+	pci_tsm->state = PCI_TSM_INIT;
+	return sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
+}
+
+static void pci_tsm_del(struct pci_dev *pdev)
+{
+	struct pci_tsm *pci_tsm = pdev->tsm;
+
+	lockdep_assert_held(&pci_tsm_rwsem);
+	/* shutdown sysfs operations before tsm delete */
+	scoped_guard(mutex, &pdev->tsm->exec_lock)
+		pci_tsm->state = PCI_TSM_IDLE;
+	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
+	tsm_ops->del(pdev);
+}
+
+int pci_tsm_register(const struct pci_tsm_ops *ops)
+{
+	struct pci_dev *pdev;
+	unsigned long index;
+
+	if (!ops)
+		return 0;
+	guard(rwsem_write)(&pci_tsm_rwsem);
+	if (tsm_ops)
+		return -EBUSY;
+	tsm_ops = ops;
+	xa_for_each(&pci_tsm_devs, index, pdev)
+		pci_tsm_add(pdev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_register);
+
+void pci_tsm_unregister(const struct pci_tsm_ops *ops)
+{
+	struct pci_dev *pdev;
+	unsigned long index;
+
+	if (!ops)
+		return;
+	guard(rwsem_write)(&pci_tsm_rwsem);
+	if (ops != tsm_ops)
+		return;
+	xa_for_each(&pci_tsm_devs, index, pdev)
+		pci_tsm_del(pdev);
+	tsm_ops = NULL;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_unregister);
+
+int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
+			 const void *req, size_t req_sz, void *resp,
+			 size_t resp_sz)
+{
+	if (!pdev->tsm || !pdev->tsm->doe_mb)
+		return -ENXIO;
+
+	return pci_doe(pdev->tsm->doe_mb, PCI_VENDOR_ID_PCI_SIG, type, req,
+		       req_sz, resp, resp_sz);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
+
+static unsigned long pci_tsm_devid(struct pci_dev *pdev)
+{
+	return FIELD_PREP(GENMASK(15, 0),
+			  PCI_DEVID(pdev->bus->number, pdev->devfn)) |
+	       FIELD_PREP(GENMASK(31, 16), pci_domain_nr(pdev->bus));
+}
+
+void pci_tsm_init(struct pci_dev *pdev)
+{
+	bool tee_cap;
+	u16 ide_cap;
+	int rc;
+
+	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
+	tee_cap = pdev->devcap & PCI_EXP_DEVCAP_TEE;
+
+	if (ide_cap || tee_cap)
+		pci_dbg(pdev,
+			"Device security capabailities detected (%s%s ), init TSM\n",
+			ide_cap ? " ide" : "", tee_cap ? " tee" : "");
+	else
+		return;
+
+	struct pci_tsm *pci_tsm __free(kfree) = kzalloc(sizeof(*pci_tsm), GFP_KERNEL);
+	if (!pci_tsm)
+		return;
+
+	pci_tsm->ide_cap = ide_cap;
+	mutex_init(&pci_tsm->exec_lock);
+
+	pci_tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
+					       PCI_DOE_PROTO_CMA);
+	if (!pci_tsm->doe_mb)
+		return;
+
+	rc = xa_insert(&pci_tsm_devs, pci_tsm_devid(pdev), pdev, GFP_KERNEL);
+	if (rc) {
+		pci_dbg(pdev, "failed to register TSM capable device\n");
+		return;
+	}
+
+	guard(rwsem_write)(&pci_tsm_rwsem);
+	pdev->tsm = no_free_ptr(pci_tsm);
+	pci_tsm_add(pdev);
+}
+
+void pci_tsm_destroy(struct pci_dev *pdev)
+{
+	guard(rwsem_write)(&pci_tsm_rwsem);
+	pci_tsm_del(pdev);
+	xa_erase(&pci_tsm_devs, pci_tsm_devid(pdev));
+	kfree(pdev->tsm);
+	pdev->tsm = NULL;
+}
diff --git a/drivers/virt/coco/host/tsm-core.c b/drivers/virt/coco/host/tsm-core.c
index 0ee738fc40ed..994a7f77c5c9 100644
--- a/drivers/virt/coco/host/tsm-core.c
+++ b/drivers/virt/coco/host/tsm-core.c
@@ -8,11 +8,13 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/cleanup.h>
+#include <linux/pci-tsm.h>
 
 static DECLARE_RWSEM(tsm_core_rwsem);
 static struct class *tsm_class;
 static struct tsm_subsys {
 	struct device dev;
+	const struct pci_tsm_ops *pci_ops;
 } *tsm_subsys;
 
 static struct tsm_subsys *
@@ -40,7 +42,8 @@ static void put_tsm_subsys(struct tsm_subsys *subsys)
 DEFINE_FREE(put_tsm_subsys, struct tsm_subsys *,
 	    if (!IS_ERR_OR_NULL(_T)) put_tsm_subsys(_T))
 struct tsm_subsys *tsm_register(struct device *parent,
-				const struct attribute_group **groups)
+				const struct attribute_group **groups,
+				const struct pci_tsm_ops *pci_ops)
 {
 	struct device *dev;
 	int rc;
@@ -62,10 +65,20 @@ struct tsm_subsys *tsm_register(struct device *parent,
 	if (rc)
 		return ERR_PTR(rc);
 
+	rc = pci_tsm_register(pci_ops);
+	if (rc) {
+		dev_err(parent, "PCI initialization failure: %pe\n",
+			ERR_PTR(rc));
+		return ERR_PTR(rc);
+	}
+
 	rc = device_add(dev);
-	if (rc)
+	if (rc) {
+		pci_tsm_unregister(pci_ops);
 		return ERR_PTR(rc);
+	}
 
+	subsys->pci_ops = pci_ops;
 	tsm_subsys = no_free_ptr(subsys);
 
 	return tsm_subsys;
@@ -74,13 +87,18 @@ EXPORT_SYMBOL_GPL(tsm_register);
 
 void tsm_unregister(struct tsm_subsys *subsys)
 {
+	const struct pci_tsm_ops *pci_ops;
+
 	guard(rwsem_write)(&tsm_core_rwsem);
 	if (!tsm_subsys || subsys != tsm_subsys) {
 		pr_warn("failed to unregister, not currently registered\n");
 		return;
 	}
 
+	pci_ops = subsys->pci_ops;
 	device_unregister(&subsys->dev);
+
+	pci_tsm_unregister(pci_ops);
 	tsm_subsys = NULL;
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
new file mode 100644
index 000000000000..d17f5e0574c4
--- /dev/null
+++ b/include/linux/pci-tsm.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PCI_TSM_H
+#define __PCI_TSM_H
+#include <linux/mutex.h>
+
+enum pci_tsm_cmd {
+	TSM_EXEC_CONNECT,
+	TSM_EXEC_DISCONNECT,
+};
+
+struct pci_dev;
+/**
+ * struct pci_tsm_ops - Low-level TSM-exported interface to the PCI core
+ * @add: accept device for tsm operation
+ * @del: teardown tsm context for @pdev
+ * @exec: synchronously execute @cmd
+ *
+ * Note that @add, and @del run in down_write(&pci_tsm_rswem) context to
+ * synchronize with TSM driver bind/unbind events and
+ * pci_device_add()/pci_destroy_dev(). @exec runs in
+ * @pdev->tsm->exec_lock context to synchronize @exec results with
+ * @pdev->tsm->state
+ */
+struct pci_tsm_ops {
+	int (*add)(struct pci_dev *pdev);
+	void (*del)(struct pci_dev *pdev);
+	int (*exec)(struct pci_dev *pdev, enum pci_tsm_cmd cmd);
+};
+
+enum pci_tsm_state {
+	PCI_TSM_IDLE,
+	PCI_TSM_INIT,
+	PCI_TSM_CONNECT,
+};
+
+/**
+ * struct pci_tsm - per device TSM context
+ * @state: reflect device initialized, connected, or bound
+ * @ide_cap: PCIe IDE Extended Capability offset
+ * @exec_lock: protect @state vs pci_tsm_ops.exec() results
+ * @doe_mb: PCIe Data Object Exchange mailbox
+ * @tsm_data: TSM driver private context
+ */
+struct pci_tsm {
+	enum pci_tsm_state state;
+	u16 ide_cap;
+	struct mutex exec_lock;
+	struct pci_doe_mb *doe_mb;
+	void *tsm_data;
+};
+
+enum pci_doe_proto {
+	PCI_DOE_PROTO_CMA = 1,
+	PCI_DOE_PROTO_SSESSION = 2,
+};
+
+#ifdef CONFIG_PCI_TSM
+int pci_tsm_register(const struct pci_tsm_ops *ops);
+void pci_tsm_unregister(const struct pci_tsm_ops *ops);
+int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
+			 const void *req, size_t req_sz, void *resp,
+			 size_t resp_sz);
+#else
+static inline int pci_tsm_register(const struct pci_tsm_ops *ops)
+{
+	return 0;
+}
+static inline void pci_tsm_unregister(const struct pci_tsm_ops *ops)
+{
+}
+static inline int pci_tsm_doe_transfer(struct pci_dev *pdev,
+				       enum pci_doe_proto type, const void *req,
+				       size_t req_sz, void *resp,
+				       size_t resp_sz)
+{
+	return -ENOENT;
+}
+
+#endif
+#endif /*__PCI_TSM_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 16493426a04f..dd4dc8719c5c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -515,6 +515,9 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_PCI_DOE
 	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
+#endif
+#ifdef CONFIG_PCI_TSM
+	struct pci_tsm *tsm;		/* TSM operation state */
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
@@ -550,6 +553,12 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
 	return (pdev->error_state != pci_channel_io_normal);
 }
 
+/* id resources that may be shared across host-bridges */
+struct pci_hb_id_pool {
+	int nr_stream_ids;
+	int nr_cxl_cache_ids;
+};
+
 /*
  * Currently in ACPI spec, for each PCI host bridge, PCI Segment
  * Group number is limited to a 16-bit value, therefore (int)-1 is
@@ -568,6 +577,8 @@ struct pci_host_bridge {
 	void		*sysdata;
 	int		busnr;
 	int		domain_nr;
+	struct pci_hb_id_pool __pool;
+	struct pci_hb_id_pool *pool;	/* &self->__pool, unless shared */
 	struct list_head windows;	/* resource_entry */
 	struct list_head dma_ranges;	/* dma ranges resource list */
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 2867c2ecbd11..6481cc99ea6d 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -68,7 +68,9 @@ int tsm_report_register(const struct tsm_report_ops *ops, void *priv,
 			const struct config_item_type *type);
 int tsm_report_unregister(const struct tsm_report_ops *ops);
 struct tsm_subsys;
+struct pci_tsm_ops;
 struct tsm_subsys *tsm_register(struct device *parent,
-				const struct attribute_group **groups);
+				const struct attribute_group **groups,
+				const struct pci_tsm_ops *ops);
 void tsm_unregister(struct tsm_subsys *subsys);
 #endif /* __TSM_H */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index a39193213ff2..9aaffa379cae 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -498,6 +498,7 @@
 #define  PCI_EXP_DEVCAP_PWR_VAL	0x03fc0000 /* Slot Power Limit Value */
 #define  PCI_EXP_DEVCAP_PWR_SCL	0x0c000000 /* Slot Power Limit Scale */
 #define  PCI_EXP_DEVCAP_FLR     0x10000000 /* Function Level Reset */
+#define  PCI_EXP_DEVCAP_TEE     0x40000000 /* TEE I/O (TDISP) Support */
 #define PCI_EXP_DEVCTL		0x08	/* Device Control */
 #define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
 #define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable */
@@ -742,7 +743,8 @@
 #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
+#define PCI_EXT_CAP_ID_IDE	0x30	/* Integrity and Data Encryption */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_IDE
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40


