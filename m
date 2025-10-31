Return-Path: <linux-pci+bounces-39973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78511C270A6
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 22:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11463AF4DA
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 21:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072CD31579B;
	Fri, 31 Oct 2025 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvzqiyJd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D7B324B14
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946146; cv=none; b=vACFDN60gG6xARWk0TtOq5m1zTE6b1QQ/IwOrsD+GU3y5x6K2LB6x7p0ippiZ97tLEXtPZNXeXVddzWHwcZfFIzuAq513amQlneytyKMC0adMHziz+vhER7CCZ/eRvH8WqIsI6Hmf8yziQhEc4+5vsyz/Sgsae5OX/+8Au5vZtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946146; c=relaxed/simple;
	bh=Vo4JVLX5gbgZRNOR2jX9TfIzEUU4jUeDgUZ1NSsaLQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tthoj8b9fzKYTETBJdqM0GIhsIMPqwK7mcGwjp0jl/MpmhHuB7kT1Ea1Xyy25OrxFmZ34ioqxeQdBoJRPAKJogCdnaf3rL3GGwZm643NPfE/W7e5eAmrYZUGh/b6AIWIEO1kOz5cTsC36CvOvxTldKY0AaOcizpvqMpGngEBdro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvzqiyJd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761946145; x=1793482145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vo4JVLX5gbgZRNOR2jX9TfIzEUU4jUeDgUZ1NSsaLQ8=;
  b=FvzqiyJdHw9zPhF9Xd8n+aWo3XXCoGQbR5OkY2l6pgT3P8elm5NJaOp3
   LOi+xfmwsBIseArUaxPN10IuJc7nA0e9lD/gryKMLooRtKczwVk/4mLpG
   vCX/SlqB5YAj14rS6l7aBMINyF2YyKSJEA/IZNM0xgmON83XMpJ85vEqw
   zbqHdLDwywofFr49t3GGF1KfWzlLhPnAwbfGcQ6Pm19WXSN4yojIIiNY6
   DNEq4vro6e3oW/CCxGFg52LQncl/ekblDf4Aj51fkuZzfl7k3gR59us/+
   JaqMvREYzlGmloaJh/QeXASWYmtiNgN4CjU7eoOJ46NG73Flbv22qU8BD
   A==;
X-CSE-ConnectionGUID: VF1WtqyZSHm8kiCAqmUVjw==
X-CSE-MsgGUID: /vdoYRY3QjO545EPME2DJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="64002415"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="64002415"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 14:29:00 -0700
X-CSE-ConnectionGUID: 3vmTNXzTQ7SziJd/06s5hw==
X-CSE-MsgGUID: kYRvOgboSciALx2KqQcPsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="216986665"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa002.jf.intel.com with ESMTP; 31 Oct 2025 14:28:59 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev,
	gregkh@linuxfoundation.org,
	aik@amd.com,
	aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com,
	Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v8 4/9] PCI/TSM: Establish Secure Sessions and Link Encryption
Date: Fri, 31 Oct 2025 14:28:56 -0700
Message-ID: <20251031212902.2256310-5-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031212902.2256310-1-dan.j.williams@intel.com>
References: <20251031212902.2256310-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe 7.0 specification, section 11, defines the Trusted Execution
Environment (TEE) Device Interface Security Protocol (TDISP).  This
protocol definition builds upon Component Measurement and Authentication
(CMA), and link Integrity and Data Encryption (IDE). It adds support for
assigning devices (PCI physical or virtual function) to a confidential VM
such that the assigned device is enabled to access guest private memory
protected by technologies like Intel TDX, AMD SEV-SNP, RISCV COVE, or ARM
CCA.

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
Userspace can watch for the arrival of a "TSM" device,
/sys/class/tsm/tsm0/uevent KOBJ_CHANGE, to know when the PCI core has
initialized TSM services.

The operations that can be executed against a PCI device are split into
two mutually exclusive operation sets, "Link" and "Security" (struct
pci_tsm_{link,security}_ops). The "Link" operations manage physical link
security properties and communication with the device's Device Security
Manager firmware. These are the host side operations in TDISP. The
"Security" operations coordinate the security state of the assigned
virtual device (TDI). These are the guest side operations in TDISP.

Only "link" (Secure Session and physical Link Encryption) operations are
defined at this stage. There are placeholders for the device security
(Trusted Computing Base entry / exit) operations.

The locking allows for multiple devices to be executing commands
simultaneously, one outstanding command per-device and an rwsem
synchronizes the implementation relative to TSM registration/unregistration
events.

Thanks to Wu Hao for his work on an early draft of this support.

Cc: Lukas Wunner <lukas@wunner.de>
Cc: Samuel Ortiz <sameo@rivosinc.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/Kconfig                     |  15 +
 drivers/pci/Makefile                    |   1 +
 Documentation/ABI/testing/sysfs-bus-pci |  51 ++
 Documentation/driver-api/pci/index.rst  |   1 +
 Documentation/driver-api/pci/tsm.rst    |  21 +
 drivers/pci/pci.h                       |  10 +
 include/linux/pci-doe.h                 |   4 +
 include/linux/pci-tsm.h                 | 157 ++++++
 include/linux/pci.h                     |   3 +
 include/linux/tsm.h                     |   5 +-
 include/uapi/linux/pci_regs.h           |   1 +
 drivers/pci/doe.c                       |   2 -
 drivers/pci/pci-sysfs.c                 |   4 +
 drivers/pci/probe.c                     |   3 +
 drivers/pci/remove.c                    |   6 +
 drivers/pci/tsm.c                       | 643 ++++++++++++++++++++++++
 drivers/virt/coco/tsm-core.c            |  46 +-
 MAINTAINERS                             |   4 +-
 18 files changed, 971 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/driver-api/pci/tsm.rst
 create mode 100644 include/linux/pci-tsm.h
 create mode 100644 drivers/pci/tsm.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index b28423e2057f..00b0210e1f1d 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -125,6 +125,21 @@ config PCI_ATS
 config PCI_IDE
 	bool
 
+config PCI_TSM
+	bool "PCI TSM: Device security protocol support"
+	select PCI_IDE
+	select PCI_DOE
+	select TSM
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
 config PCI_DOE
 	bool "Enable PCI Data Object Exchange (DOE) support"
 	help
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
diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 92debe879ffb..6ffe02f854d6 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -621,3 +621,54 @@ Description:
 		number extended capability. The file is read only and due to
 		the possible sensitivity of accessible serial numbers, admin
 		only.
+
+What:		/sys/bus/pci/devices/.../tsm/
+Contact:	linux-coco@lists.linux.dev
+Description:
+		This directory only appears if a physical device function
+		supports authentication (PCIe CMA-SPDM), interface security
+		(PCIe TDISP), and is accepted for secure operation by the
+		platform TSM driver. This attribute directory appears
+		dynamically after the platform TSM driver loads. So, only after
+		the /sys/class/tsm/tsm0 device arrives can tools assume that
+		devices without a tsm/ attribute directory will never have one;
+		before that, the security capabilities of the device relative to
+		the platform TSM are unknown. See
+		Documentation/ABI/testing/sysfs-class-tsm.
+
+What:		/sys/bus/pci/devices/.../tsm/connect
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RW) Write the name of a TSM (TEE Security Manager) device from
+		/sys/class/tsm to this file to establish a connection with the
+		device.  This typically includes an SPDM (DMTF Security
+		Protocols and Data Models) session over PCIe DOE (Data Object
+		Exchange) and may also include PCIe IDE (Integrity and Data
+		Encryption) establishment. Reads from this attribute return the
+		name of the connected TSM or the empty string if not
+		connected. A TSM device signals its readiness to accept PCI
+		connection via a KOBJ_CHANGE event.
+
+What:		/sys/bus/pci/devices/.../tsm/disconnect
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(WO) Write the name of the TSM device that was specified
+		to 'connect' to teardown the connection.
+
+What:		/sys/bus/pci/devices/.../authenticated
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
diff --git a/Documentation/driver-api/pci/index.rst b/Documentation/driver-api/pci/index.rst
index a38e475cdbe3..9e1b801d0f74 100644
--- a/Documentation/driver-api/pci/index.rst
+++ b/Documentation/driver-api/pci/index.rst
@@ -10,6 +10,7 @@ The Linux PCI driver implementer's API guide
 
    pci
    p2pdma
+   tsm
 
 .. only::  subproject and html
 
diff --git a/Documentation/driver-api/pci/tsm.rst b/Documentation/driver-api/pci/tsm.rst
new file mode 100644
index 000000000000..232b92bec93f
--- /dev/null
+++ b/Documentation/driver-api/pci/tsm.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+========================================================
+PCI Trusted Execution Environment Security Manager (TSM)
+========================================================
+
+Subsystem Interfaces
+====================
+
+.. kernel-doc:: include/linux/pci-ide.h
+   :internal:
+
+.. kernel-doc:: drivers/pci/ide.c
+   :export:
+
+.. kernel-doc:: include/linux/pci-tsm.h
+   :internal:
+
+.. kernel-doc:: drivers/pci/tsm.c
+   :export:
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 86ef13e7cece..6e4cc1c9aa58 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -619,6 +619,16 @@ void pci_ide_init(struct pci_dev *dev);
 static inline void pci_ide_init(struct pci_dev *dev) { }
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
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index 1f14aed4354b..bd4346a7c4e7 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -15,6 +15,10 @@
 
 struct pci_doe_mb;
 
+#define PCI_DOE_FEATURE_DISCOVERY 0
+#define PCI_DOE_FEATURE_CMA 1
+#define PCI_DOE_FEATURE_SSESSION 2
+
 struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
 					u8 type);
 
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
new file mode 100644
index 000000000000..e921d30f9b6c
--- /dev/null
+++ b/include/linux/pci-tsm.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PCI_TSM_H
+#define __PCI_TSM_H
+#include <linux/mutex.h>
+#include <linux/pci.h>
+
+struct pci_tsm;
+struct tsm_dev;
+
+/*
+ * struct pci_tsm_ops - manage confidential links and security state
+ * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
+ *	      Provide a secure session transport for TDISP state management
+ *	      (typically bare metal physical function operations).
+ * @devsec_ops: Lock, unlock, and interrogate the security state of the
+ *		function via the platform TSM (typically virtual function
+ *		operations).
+ *
+ * This operations are mutually exclusive either a tsm_dev instance
+ * manages physical link properties or it manages function security
+ * states like TDISP lock/unlock.
+ */
+struct pci_tsm_ops {
+	/*
+	 * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
+	 * @probe: establish context with the TSM (allocate / wrap 'struct
+	 *	   pci_tsm') for follow-on link operations
+	 * @remove: destroy link operations context
+	 * @connect: establish / validate a secure connection (e.g. IDE)
+	 *	     with the device
+	 * @disconnect: teardown the secure link
+	 *
+	 * Context: @probe, @remove, @connect, and @disconnect run under
+	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
+	 * mutual exclusion of @connect and @disconnect. @connect and
+	 * @disconnect additionally run under the DSM lock (struct
+	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
+	 */
+	struct_group_tagged(pci_tsm_link_ops, link_ops,
+		struct pci_tsm *(*probe)(struct tsm_dev *tsm_dev,
+					 struct pci_dev *pdev);
+		void (*remove)(struct pci_tsm *tsm);
+		int (*connect)(struct pci_dev *pdev);
+		void (*disconnect)(struct pci_dev *pdev);
+	);
+
+	/*
+	 * struct pci_tsm_devsec_ops - Manage the security state of the function
+	 * @lock: establish context with the TSM (allocate / wrap 'struct
+	 *	  pci_tsm') for follow-on security state transitions from the
+	 *	  LOCKED state
+	 * @unlock: destroy TSM context and return device to UNLOCKED state
+	 *
+	 * Context: @lock and @unlock run under pci_tsm_rwsem held for write to
+	 * sync with TSM unregistration and each other
+	 */
+	struct_group_tagged(pci_tsm_devsec_ops, devsec_ops,
+		struct pci_tsm *(*lock)(struct tsm_dev *tsm_dev,
+					struct pci_dev *pdev);
+		void (*unlock)(struct pci_tsm *tsm);
+	);
+};
+
+/**
+ * struct pci_tsm - Core TSM context for a given PCIe endpoint
+ * @pdev: Back ref to device function, distinguishes type of pci_tsm context
+ * @dsm_dev: PCI Device Security Manager for link operations on @pdev
+ * @tsm_dev: PCI TEE Security Manager device for Link Confidentiality or Device
+ *	     Function Security operations
+ *
+ * This structure is wrapped by low level TSM driver data and returned by
+ * probe()/lock(), it is freed by the corresponding remove()/unlock().
+ *
+ * For link operations it serves to cache the association between a Device
+ * Security Manager (DSM) and the functions that manager can assign to a TVM.
+ * That can be "self", for assigning function0 of a TEE I/O device, a
+ * sub-function (SR-IOV virtual function, or non-function0
+ * multifunction-device), or a downstream endpoint (PCIe upstream switch-port as
+ * DSM).
+ */
+struct pci_tsm {
+	struct pci_dev *pdev;
+	struct pci_dev *dsm_dev;
+	struct tsm_dev *tsm_dev;
+};
+
+/**
+ * struct pci_tsm_pf0 - Physical Function 0 TDISP link context
+ * @base_tsm: generic core "tsm" context
+ * @lock: mutual exclustion for pci_tsm_ops invocation
+ * @doe_mb: PCIe Data Object Exchange mailbox
+ */
+struct pci_tsm_pf0 {
+	struct pci_tsm base_tsm;
+	struct mutex lock;
+	struct pci_doe_mb *doe_mb;
+};
+
+/* physical function0 and capable of 'connect' */
+static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
+{
+	if (!pdev)
+		return false;
+
+	if (!pci_is_pcie(pdev))
+		return false;
+
+	if (pdev->is_virtfn)
+		return false;
+
+	/*
+	 * Allow for a Device Security Manager (DSM) associated with function0
+	 * of an Endpoint to coordinate TDISP requests for other functions
+	 * (physical or virtual) of the device, or allow for an Upstream Port
+	 * DSM to accept TDISP requests for the Endpoints downstream of the
+	 * switch.
+	 */
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ENDPOINT:
+	case PCI_EXP_TYPE_UPSTREAM:
+	case PCI_EXP_TYPE_RC_END:
+		if (pdev->ide_cap || (pdev->devcap & PCI_EXP_DEVCAP_TEE))
+			break;
+		fallthrough;
+	default:
+		return false;
+	}
+
+	return PCI_FUNC(pdev->devfn) == 0;
+}
+
+#ifdef CONFIG_PCI_TSM
+int pci_tsm_register(struct tsm_dev *tsm_dev);
+void pci_tsm_unregister(struct tsm_dev *tsm_dev);
+int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
+			     struct tsm_dev *tsm_dev);
+int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
+			    struct tsm_dev *tsm_dev);
+void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
+int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
+			 size_t req_sz, void *resp, size_t resp_sz);
+#else
+static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
+{
+	return 0;
+}
+static inline void pci_tsm_unregister(struct tsm_dev *tsm_dev)
+{
+}
+static inline int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type,
+				       const void *req, size_t req_sz,
+				       void *resp, size_t resp_sz)
+{
+	return -ENXIO;
+}
+#endif
+#endif /*__PCI_TSM_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b6a12a82be12..2f9c0cb6a50a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -546,6 +546,9 @@ struct pci_dev {
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
index cd97c63ffa32..22e05b2aac69 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -108,9 +108,11 @@ struct tsm_report_ops {
 	bool (*report_bin_attr_visible)(int n);
 };
 
+struct pci_tsm_ops;
 struct tsm_dev {
 	struct device dev;
 	int id;
+	const struct pci_tsm_ops *pci_ops;
 };
 
 DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
@@ -118,6 +120,7 @@ DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
 
 int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
 int tsm_report_unregister(const struct tsm_report_ops *ops);
-struct tsm_dev *tsm_register(struct device *parent);
+struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *ops);
 void tsm_unregister(struct tsm_dev *tsm_dev);
+struct tsm_dev *find_tsm_dev(int id);
 #endif /* __TSM_H */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 05bd22d9e352..f2759c1097bc 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -503,6 +503,7 @@
 #define  PCI_EXP_DEVCAP_PWR_VAL	0x03fc0000 /* Slot Power Limit Value */
 #define  PCI_EXP_DEVCAP_PWR_SCL	0x0c000000 /* Slot Power Limit Scale */
 #define  PCI_EXP_DEVCAP_FLR     0x10000000 /* Function Level Reset */
+#define  PCI_EXP_DEVCAP_TEE     0x40000000 /* TEE I/O (TDISP) Support */
 #define PCI_EXP_DEVCTL		0x08	/* Device Control */
 #define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
 #define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable */
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index aae9a8a00406..62be9c8dbc52 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -24,8 +24,6 @@
 
 #include "pci.h"
 
-#define PCI_DOE_FEATURE_DISCOVERY 0
-
 /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
 #define PCI_DOE_TIMEOUT HZ
 #define PCI_DOE_POLL_INTERVAL	(PCI_DOE_TIMEOUT / 128)
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9d6f74bd95f8..7f9237a926c2 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1868,6 +1868,10 @@ const struct attribute_group *pci_dev_attr_groups[] = {
 #endif
 #ifdef CONFIG_PCI_DOE
 	&pci_doe_sysfs_group,
+#endif
+#ifdef CONFIG_PCI_TSM
+	&pci_tsm_auth_attr_group,
+	&pci_tsm_attr_group,
 #endif
 	NULL,
 };
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4c55020f3ddf..d1467348c169 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2763,6 +2763,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	ret = device_add(&dev->dev);
 	WARN_ON(ret < 0);
 
+	/* Establish pdev->tsm for newly added (e.g. new SR-IOV VFs) */
+	pci_tsm_init(dev);
+
 	pci_npem_create(dev);
 
 	pci_doe_sysfs_init(dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index ce5c25adef55..803391892c4a 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -57,6 +57,12 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	pci_doe_sysfs_teardown(dev);
 	pci_npem_remove(dev);
 
+	/*
+	 * While device is in D0 drop the device from TSM link operations
+	 * including unbind and disconnect (IDE + SPDM teardown).
+	 */
+	pci_tsm_destroy(dev);
+
 	device_del(&dev->dev);
 
 	down_write(&pci_bus_sem);
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
new file mode 100644
index 000000000000..6a2849f77adc
--- /dev/null
+++ b/drivers/pci/tsm.c
@@ -0,0 +1,643 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Interface with platform TEE Security Manager (TSM) objects as defined by
+ * PCIe r7.0 section 11 TEE Device Interface Security Protocol (TDISP)
+ *
+ * Copyright(c) 2024-2025 Intel Corporation. All rights reserved.
+ */
+
+#define dev_fmt(fmt) "PCI/TSM: " fmt
+
+#include <linux/bitfield.h>
+#include <linux/pci.h>
+#include <linux/pci-doe.h>
+#include <linux/pci-tsm.h>
+#include <linux/sysfs.h>
+#include <linux/tsm.h>
+#include <linux/xarray.h>
+#include "pci.h"
+
+/*
+ * Provide a read/write lock against the init / exit of pdev tsm
+ * capabilities and arrival/departure of a TSM instance
+ */
+static DECLARE_RWSEM(pci_tsm_rwsem);
+
+/*
+ * Count of TSMs registered that support physical link operations vs device
+ * security state management.
+ */
+static int pci_tsm_link_count;
+static int pci_tsm_devsec_count;
+
+static const struct pci_tsm_ops *to_pci_tsm_ops(struct pci_tsm *tsm)
+{
+	return tsm->tsm_dev->pci_ops;
+}
+
+static inline bool is_dsm(struct pci_dev *pdev)
+{
+	return pdev->tsm && pdev->tsm->dsm_dev == pdev;
+}
+
+static inline bool has_tee(struct pci_dev *pdev)
+{
+	return pdev->devcap & PCI_EXP_DEVCAP_TEE;
+}
+
+/* 'struct pci_tsm_pf0' wraps 'struct pci_tsm' when ->dsm_dev == ->pdev (self) */
+static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *tsm)
+{
+	/*
+	 * All "link" TSM contexts reference the device that hosts the DSM
+	 * interface for a set of devices. Walk to the DSM device and cast its
+	 * ->tsm context to a 'struct pci_tsm_pf0 *'.
+	 */
+	struct pci_dev *pf0 = tsm->dsm_dev;
+
+	if (!is_pci_tsm_pf0(pf0) || !is_dsm(pf0)) {
+		pci_WARN_ONCE(tsm->pdev, 1, "invalid context object\n");
+		return NULL;
+	}
+
+	return container_of(pf0->tsm, struct pci_tsm_pf0, base_tsm);
+}
+
+static void tsm_remove(struct pci_tsm *tsm)
+{
+	struct pci_dev *pdev;
+
+	if (!tsm)
+		return;
+
+	pdev = tsm->pdev;
+	to_pci_tsm_ops(tsm)->remove(tsm);
+	pdev->tsm = NULL;
+}
+DEFINE_FREE(tsm_remove, struct pci_tsm *, if (_T) tsm_remove(_T))
+
+static void pci_tsm_walk_fns(struct pci_dev *pdev,
+			     int (*cb)(struct pci_dev *pdev, void *data),
+			     void *data)
+{
+	/* Walk subordinate physical functions */
+	for (int i = 0; i < 8; i++) {
+		struct pci_dev *pf __free(pci_dev_put) = pci_get_slot(
+			pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
+
+		if (!pf)
+			continue;
+
+		/* on entry function 0 has already run @cb */
+		if (i > 0)
+			cb(pf, data);
+
+		/* walk virtual functions of each pf */
+		for (int j = 0; j < pci_num_vf(pf); j++) {
+			struct pci_dev *vf __free(pci_dev_put) =
+				pci_get_domain_bus_and_slot(
+					pci_domain_nr(pf->bus),
+					pci_iov_virtfn_bus(pf, j),
+					pci_iov_virtfn_devfn(pf, j));
+
+			if (!vf)
+				continue;
+
+			cb(vf, data);
+		}
+	}
+
+	/*
+	 * Walk downstream devices, assumes that an upstream DSM is
+	 * limited to downstream physical functions
+	 */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM && is_dsm(pdev))
+		pci_walk_bus(pdev->subordinate, cb, data);
+}
+
+static void pci_tsm_walk_fns_reverse(struct pci_dev *pdev,
+				     int (*cb)(struct pci_dev *pdev,
+					       void *data),
+				     void *data)
+{
+	/* Reverse walk downstream devices */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM && is_dsm(pdev))
+		pci_walk_bus_reverse(pdev->subordinate, cb, data);
+
+	/* Reverse walk subordinate physical functions */
+	for (int i = 7; i >= 0; i--) {
+		struct pci_dev *pf __free(pci_dev_put) = pci_get_slot(
+			pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
+
+		if (!pf)
+			continue;
+
+		/* reverse walk virtual functions */
+		for (int j = pci_num_vf(pf) - 1; j >= 0; j--) {
+			struct pci_dev *vf __free(pci_dev_put) =
+				pci_get_domain_bus_and_slot(
+					pci_domain_nr(pf->bus),
+					pci_iov_virtfn_bus(pf, j),
+					pci_iov_virtfn_devfn(pf, j));
+
+			if (!vf)
+				continue;
+			cb(vf, data);
+		}
+
+		/* on exit, caller will run @cb on function 0 */
+		if (i > 0)
+			cb(pf, data);
+	}
+}
+
+static int probe_fn(struct pci_dev *pdev, void *dsm)
+{
+	struct pci_dev *dsm_dev = dsm;
+	const struct pci_tsm_ops *ops = to_pci_tsm_ops(dsm_dev->tsm);
+
+	pdev->tsm = ops->probe(dsm_dev->tsm->tsm_dev, pdev);
+	pci_dbg(pdev, "setup TSM context: DSM: %s status: %s\n",
+		pci_name(dsm_dev), pdev->tsm ? "success" : "failed");
+	return 0;
+}
+
+static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
+{
+	int rc;
+	struct pci_tsm_pf0 *tsm_pf0;
+	const struct pci_tsm_ops *ops = tsm_dev->pci_ops;
+	struct pci_tsm *pci_tsm __free(tsm_remove) = ops->probe(tsm_dev, pdev);
+
+	/* connect() mutually exclusive with subfunction pci_tsm_init() */
+	lockdep_assert_held_write(&pci_tsm_rwsem);
+
+	if (!pci_tsm)
+		return -ENXIO;
+
+	pdev->tsm = pci_tsm;
+	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
+
+	/* mutex_intr assumes connect() is always sysfs/user driven */
+	ACQUIRE(mutex_intr, lock)(&tsm_pf0->lock);
+	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
+		return rc;
+
+	rc = ops->connect(pdev);
+	if (rc)
+		return rc;
+
+	pdev->tsm = no_free_ptr(pci_tsm);
+
+	/*
+	 * Now that the DSM is established, probe() all the potential
+	 * dependent functions. Failure to probe a function is not fatal
+	 * to connect(), it just disables subsequent security operations
+	 * for that function.
+	 *
+	 * Note this is done unconditionally, without regard to finding
+	 * PCI_EXP_DEVCAP_TEE on the dependent function, for robustness. The DSM
+	 * is the ultimate arbiter of security state relative to a given
+	 * interface id, and if it says it can manage TDISP state of a function,
+	 * let it.
+	 */
+	if (has_tee(pdev))
+		pci_tsm_walk_fns(pdev, probe_fn, pdev);
+	return 0;
+}
+
+static ssize_t connect_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct tsm_dev *tsm_dev;
+	int rc;
+
+	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
+		return rc;
+
+	if (!pdev->tsm)
+		return sysfs_emit(buf, "\n");
+
+	tsm_dev = pdev->tsm->tsm_dev;
+	return sysfs_emit(buf, "%s\n", dev_name(&tsm_dev->dev));
+}
+
+/* Is @tsm_dev managing physical link / session properties... */
+static bool is_link_tsm(struct tsm_dev *tsm_dev)
+{
+	return tsm_dev && tsm_dev->pci_ops && tsm_dev->pci_ops->link_ops.probe;
+}
+
+/* ...or is @tsm_dev managing device security state ? */
+static bool is_devsec_tsm(struct tsm_dev *tsm_dev)
+{
+	return tsm_dev && tsm_dev->pci_ops && tsm_dev->pci_ops->devsec_ops.lock;
+}
+
+static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t len)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int rc, id;
+
+	rc = sscanf(buf, "tsm%d\n", &id);
+	if (rc != 1)
+		return -EINVAL;
+
+	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &lock)))
+		return rc;
+
+	if (pdev->tsm)
+		return -EBUSY;
+
+	struct tsm_dev *tsm_dev __free(put_tsm_dev) = find_tsm_dev(id);
+	if (!is_link_tsm(tsm_dev))
+		return -ENXIO;
+
+	rc = pci_tsm_connect(pdev, tsm_dev);
+	if (rc)
+		return rc;
+	return len;
+}
+static DEVICE_ATTR_RW(connect);
+
+static int remove_fn(struct pci_dev *pdev, void *data)
+{
+	tsm_remove(pdev->tsm);
+	return 0;
+}
+
+static void __pci_tsm_disconnect(struct pci_dev *pdev)
+{
+	struct pci_tsm_pf0 *tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
+	const struct pci_tsm_ops *ops = to_pci_tsm_ops(pdev->tsm);
+
+	/* disconnect() mutually exclusive with subfunction pci_tsm_init() */
+	lockdep_assert_held_write(&pci_tsm_rwsem);
+
+	/*
+	 * disconnect() is uninterruptible as it may be called for device
+	 * teardown
+	 */
+	guard(mutex)(&tsm_pf0->lock);
+	pci_tsm_walk_fns_reverse(pdev, remove_fn, NULL);
+	ops->disconnect(pdev);
+}
+
+static void pci_tsm_disconnect(struct pci_dev *pdev)
+{
+	__pci_tsm_disconnect(pdev);
+	tsm_remove(pdev->tsm);
+}
+
+static ssize_t disconnect_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t len)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct tsm_dev *tsm_dev;
+	int rc;
+
+	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &lock)))
+		return rc;
+
+	if (!pdev->tsm)
+		return -ENXIO;
+
+	tsm_dev = pdev->tsm->tsm_dev;
+	if (!sysfs_streq(buf, dev_name(&tsm_dev->dev)))
+		return -EINVAL;
+
+	pci_tsm_disconnect(pdev);
+	return len;
+}
+static DEVICE_ATTR_WO(disconnect);
+
+/* The 'authenticated' attribute is exclusive to the presence of a 'link' TSM */
+static bool pci_tsm_link_group_visible(struct kobject *kobj)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	return pci_tsm_link_count && is_pci_tsm_pf0(pdev);
+}
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm_link);
+
+/*
+ * 'link' and 'devsec' TSMs share the same 'tsm/' sysfs group, so the TSM type
+ * specific attributes need individual visibility checks.
+ */
+static umode_t pci_tsm_attr_visible(struct kobject *kobj,
+				    struct attribute *attr, int n)
+{
+	if (pci_tsm_link_group_visible(kobj)) {
+		if (attr == &dev_attr_connect.attr ||
+		    attr == &dev_attr_disconnect.attr)
+			return attr->mode;
+	}
+
+	return 0;
+}
+
+static bool pci_tsm_group_visible(struct kobject *kobj)
+{
+	return pci_tsm_link_group_visible(kobj);
+}
+DEFINE_SYSFS_GROUP_VISIBLE(pci_tsm);
+
+static struct attribute *pci_tsm_attrs[] = {
+	&dev_attr_connect.attr,
+	&dev_attr_disconnect.attr,
+	NULL
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
+	 * When the SPDM session established via TSM the 'authenticated' state
+	 * of the device is identical to the connect state.
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
+	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm_link),
+};
+
+/*
+ * Retrieve physical function0 device whether it has TEE capability or not
+ */
+static struct pci_dev *pf0_dev_get(struct pci_dev *pdev)
+{
+	struct pci_dev *pf_dev = pci_physfn(pdev);
+
+	if (PCI_FUNC(pf_dev->devfn) == 0)
+		return pci_dev_get(pf_dev);
+
+	return pci_get_slot(pf_dev->bus,
+			    pf_dev->devfn - PCI_FUNC(pf_dev->devfn));
+}
+
+/*
+ * Find the PCI Device instance that serves as the Device Security Manager (DSM)
+ * for @pdev. Note that no additional reference is held for the resulting device
+ * because that resulting object always has a registered lifetime
+ * greater-than-or-equal to that of the @pdev argument. This is by virtue of
+ * @pdev being a descendant of, or identical to, the returned DSM device.
+ */
+static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
+{
+	struct device *grandparent;
+	struct pci_dev *uport;
+
+	if (is_pci_tsm_pf0(pdev))
+		return pdev;
+
+	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
+	if (!pf0)
+		return NULL;
+
+	if (is_dsm(pf0))
+		return pf0;
+
+	/*
+	 * For cases where a switch may be hosting TDISP services on behalf of
+	 * downstream devices, check the first upstream port relative to this
+	 * endpoint.
+	 */
+	if (!pdev->dev.parent)
+		return NULL;
+	grandparent = pdev->dev.parent->parent;
+	if (!grandparent)
+		return NULL;
+	if (!dev_is_pci(grandparent))
+		return NULL;
+	uport = to_pci_dev(grandparent);
+	if (!pci_is_pcie(uport) ||
+	    pci_pcie_type(uport) != PCI_EXP_TYPE_UPSTREAM)
+		return NULL;
+
+	if (is_dsm(uport))
+		return uport;
+	return NULL;
+}
+
+/**
+ * pci_tsm_link_constructor() - base 'struct pci_tsm' initialization for link TSMs
+ * @pdev: The PCI device
+ * @tsm: context to initialize
+ * @tsm_dev: Platform TEE Security Manager, initiator of security operations
+ */
+int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
+			     struct tsm_dev *tsm_dev)
+{
+	if (!is_link_tsm(tsm_dev))
+		return -EINVAL;
+
+	tsm->dsm_dev = find_dsm_dev(pdev);
+	if (!tsm->dsm_dev) {
+		pci_warn(pdev, "failed to find Device Security Manager\n");
+		return -ENXIO;
+	}
+	tsm->pdev = pdev;
+	tsm->tsm_dev = tsm_dev;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_link_constructor);
+
+/**
+ * pci_tsm_pf0_constructor() - common 'struct pci_tsm_pf0' (DSM) initialization
+ * @pdev: Physical Function 0 PCI device (as indicated by is_pci_tsm_pf0())
+ * @tsm: context to initialize
+ * @tsm_dev: Platform TEE Security Manager, initiator of security operations
+ */
+int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
+			    struct tsm_dev *tsm_dev)
+{
+	mutex_init(&tsm->lock);
+	tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
+					   PCI_DOE_FEATURE_CMA);
+	if (!tsm->doe_mb) {
+		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
+		return -ENODEV;
+	}
+
+	return pci_tsm_link_constructor(pdev, &tsm->base_tsm, tsm_dev);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_pf0_constructor);
+
+void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *pf0_tsm)
+{
+	mutex_destroy(&pf0_tsm->lock);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_pf0_destructor);
+
+static void pf0_sysfs_enable(struct pci_dev *pdev)
+{
+	bool tee = has_tee(pdev);
+
+	pci_dbg(pdev, "Device Security Manager detected (%s%s%s)\n",
+		pdev->ide_cap ? "IDE" : "", pdev->ide_cap && tee ? " " : "",
+		tee ? "TEE" : "");
+
+	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
+	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
+}
+
+int pci_tsm_register(struct tsm_dev *tsm_dev)
+{
+	struct pci_dev *pdev = NULL;
+
+	if (!tsm_dev)
+		return -EINVAL;
+
+	/* The TSM device must only implement one of link_ops or devsec_ops */
+	if (!is_link_tsm(tsm_dev) && !is_devsec_tsm(tsm_dev))
+		return -EINVAL;
+
+	if (is_link_tsm(tsm_dev) && is_devsec_tsm(tsm_dev))
+		return -EINVAL;
+
+	guard(rwsem_write)(&pci_tsm_rwsem);
+
+	/* On first enable, update sysfs groups */
+	if (is_link_tsm(tsm_dev) && pci_tsm_link_count++ == 0) {
+		for_each_pci_dev(pdev)
+			if (is_pci_tsm_pf0(pdev))
+				pf0_sysfs_enable(pdev);
+	} else if (is_devsec_tsm(tsm_dev)) {
+		pci_tsm_devsec_count++;
+	}
+
+	return 0;
+}
+
+static void pci_tsm_fn_exit(struct pci_dev *pdev)
+{
+	/* TODO: unbind the fn */
+	tsm_remove(pdev->tsm);
+}
+
+/**
+ * __pci_tsm_destroy() - destroy the TSM context for @pdev
+ * @pdev: device to cleanup
+ * @tsm_dev: the TSM device being removed, or NULL if @pdev is being removed.
+ *
+ * At device removal or TSM unregistration all established context
+ * with the TSM is torn down. Additionally, if there are no more TSMs
+ * registered, the PCI tsm/ sysfs attributes are hidden.
+ */
+static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
+{
+	struct pci_tsm *tsm = pdev->tsm;
+
+	lockdep_assert_held_write(&pci_tsm_rwsem);
+
+	/*
+	 * First, handle the TSM removal case to shutdown @pdev sysfs, this is
+	 * skipped if the device itself is being removed since sysfs goes away
+	 * naturally at that point
+	 */
+	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev) && !pci_tsm_link_count) {
+		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
+		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
+	}
+
+	/* Nothing else to do if this device never attached to the departing TSM */
+	if (!tsm)
+		return;
+
+	/* Now lookup the tsm_dev to destroy TSM context */
+	if (!tsm_dev)
+		tsm_dev = tsm->tsm_dev;
+	else if (tsm_dev != tsm->tsm_dev)
+		return;
+
+	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev))
+		pci_tsm_disconnect(pdev);
+	else
+		pci_tsm_fn_exit(pdev);
+}
+
+void pci_tsm_destroy(struct pci_dev *pdev)
+{
+	guard(rwsem_write)(&pci_tsm_rwsem);
+	__pci_tsm_destroy(pdev, NULL);
+}
+
+void pci_tsm_init(struct pci_dev *pdev)
+{
+	guard(rwsem_read)(&pci_tsm_rwsem);
+
+	/*
+	 * Subfunctions are either probed synchronous with connect() or later
+	 * when either the SR-IOV configuration is changed, or, unlikely,
+	 * connect() raced initial bus scanning.
+	 */
+	if (pdev->tsm)
+		return;
+
+	if (pci_tsm_link_count) {
+		struct pci_dev *dsm = find_dsm_dev(pdev);
+
+		if (!dsm)
+			return;
+
+		/*
+		 * The only path to init a Device Security Manager capable
+		 * device is via connect().
+		 */
+		if (!dsm->tsm)
+			return;
+
+		probe_fn(pdev, dsm);
+	}
+}
+
+void pci_tsm_unregister(struct tsm_dev *tsm_dev)
+{
+	struct pci_dev *pdev = NULL;
+
+	guard(rwsem_write)(&pci_tsm_rwsem);
+	if (is_link_tsm(tsm_dev))
+		pci_tsm_link_count--;
+	if (is_devsec_tsm(tsm_dev))
+		pci_tsm_devsec_count--;
+	for_each_pci_dev_reverse(pdev)
+		__pci_tsm_destroy(pdev, tsm_dev);
+}
+
+int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
+			 size_t req_sz, void *resp, size_t resp_sz)
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
diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
index 347507cc5e3f..0e705f3067a1 100644
--- a/drivers/virt/coco/tsm-core.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -8,11 +8,29 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/cleanup.h>
+#include <linux/pci-tsm.h>
 
 static struct class *tsm_class;
 static DECLARE_RWSEM(tsm_rwsem);
 static DEFINE_IDA(tsm_ida);
 
+static int match_id(struct device *dev, const void *data)
+{
+	struct tsm_dev *tsm_dev = container_of(dev, struct tsm_dev, dev);
+	int id = *(const int *)data;
+
+	return tsm_dev->id == id;
+}
+
+struct tsm_dev *find_tsm_dev(int id)
+{
+	struct device *dev = class_find_device(tsm_class, NULL, &id, match_id);
+
+	if (!dev)
+		return NULL;
+	return container_of(dev, struct tsm_dev, dev);
+}
+
 static struct tsm_dev *alloc_tsm_dev(struct device *parent)
 {
 	struct device *dev;
@@ -36,7 +54,29 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent)
 	return no_free_ptr(tsm_dev);
 }
 
-struct tsm_dev *tsm_register(struct device *parent)
+static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
+						 struct pci_tsm_ops *pci_ops)
+{
+	int rc;
+
+	if (!pci_ops)
+		return tsm_dev;
+
+	tsm_dev->pci_ops = pci_ops;
+	rc = pci_tsm_register(tsm_dev);
+	if (rc) {
+		dev_err(tsm_dev->dev.parent,
+			"PCI/TSM registration failure: %d\n", rc);
+		device_unregister(&tsm_dev->dev);
+		return ERR_PTR(rc);
+	}
+
+	/* Notify TSM userspace that PCI/TSM operations are now possible */
+	kobject_uevent(&tsm_dev->dev.kobj, KOBJ_CHANGE);
+	return tsm_dev;
+}
+
+struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
 {
 	struct tsm_dev *tsm_dev __free(put_tsm_dev) = alloc_tsm_dev(parent);
 	struct device *dev;
@@ -54,12 +94,14 @@ struct tsm_dev *tsm_register(struct device *parent)
 	if (rc)
 		return ERR_PTR(rc);
 
-	return no_free_ptr(tsm_dev);
+	return tsm_register_pci_or_reset(no_free_ptr(tsm_dev), pci_ops);
 }
 EXPORT_SYMBOL_GPL(tsm_register);
 
 void tsm_unregister(struct tsm_dev *tsm_dev)
 {
+	if (tsm_dev->pci_ops)
+		pci_tsm_unregister(tsm_dev);
 	device_unregister(&tsm_dev->dev);
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
diff --git a/MAINTAINERS b/MAINTAINERS
index 06285f3a24df..ebf6988666eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26103,8 +26103,10 @@ L:	linux-coco@lists.linux.dev
 S:	Maintained
 F:	Documentation/ABI/testing/configfs-tsm-report
 F:	Documentation/driver-api/coco/
+F:	Documentation/driver-api/pci/tsm.rst
+F:	drivers/pci/tsm.c
 F:	drivers/virt/coco/guest/
-F:	include/linux/tsm*.h
+F:	include/linux/*tsm*.h
 F:	samples/tsm-mr/
 
 TRUSTED SERVICES TEE DRIVER
-- 
2.51.0


