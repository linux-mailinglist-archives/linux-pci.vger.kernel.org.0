Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D492F23B0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 01:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391788AbhALAZ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jan 2021 19:25:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:11211 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390792AbhAKWwZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Jan 2021 17:52:25 -0500
IronPort-SDR: 2k4tSKq5JUQImTdMjWHRWo0M6kWXHXFz0eUZ5VRFnCfTG3OTEPQRqwntpfyvvw1pfVoA+1xdud
 TTq3lfoA9owQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="157726530"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="157726530"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:51:31 -0800
IronPort-SDR: t7Ycay7vGglJDba2P/49q7vxpm3h/0RQiQLIx/PukJxhRCp9sZWhmZKhnUkqhcj0k3roLNBI5k
 a4ZP9PKevETg==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="352777938"
Received: from yyang31-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.142.71])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:51:30 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        daniel.lll@alibaba-inc.com
Subject: [RFC PATCH v3 03/16] cxl/acpi: add OSC support
Date:   Mon, 11 Jan 2021 14:51:07 -0800
Message-Id: <20210111225121.820014-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210111225121.820014-1-ben.widawsky@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Vishal Verma <vishal.l.verma@intel.com>

Add support to advertise OS capabilities, and request OS control for CXL
features using the ACPI _OSC mechanism. Advertise support for all
possible CXL features, and attempt to request control for all possible
features.

Based on a patch by Sean Kelley.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/cxl/memory-devices.rst |  15 ++
 drivers/cxl/acpi.c                   | 260 ++++++++++++++++++++++++++-
 drivers/cxl/acpi.h                   |  20 +++
 3 files changed, 292 insertions(+), 3 deletions(-)

diff --git a/Documentation/cxl/memory-devices.rst b/Documentation/cxl/memory-devices.rst
index aa4262280c67..6ce88f9d5f4f 100644
--- a/Documentation/cxl/memory-devices.rst
+++ b/Documentation/cxl/memory-devices.rst
@@ -13,3 +13,18 @@ Driver Infrastructure
 =====================
 
 This sections covers the driver infrastructure for a CXL memory device.
+
+ACPI CXL
+--------
+
+.. kernel-doc:: drivers/cxl/acpi.c
+   :doc: cxl acpi
+
+.. kernel-doc:: drivers/cxl/acpi.c
+   :internal:
+
+External Interfaces
+===================
+
+.. kernel-doc:: drivers/cxl/acpi.c
+   :export:
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 0f1ba9b3f1ed..af9c0dfdee20 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -11,7 +11,258 @@
 #include <linux/pci.h>
 #include "acpi.h"
 
-/*
+/**
+ * DOC: cxl acpi
+ *
+ * ACPI _OSC setup: The exported function cxl_bus_acquire() sets up ACPI
+ * Operating System Capabilities (_OSC) for the CXL bus. It declares support
+ * for all CXL capabilities, and attempts to request control for all possible
+ * capabilities. The resulting support and control sets are saved in global
+ * variables cxl_osc_support_set and cxl_osc_control_set. The internal
+ * functions cxl_osc_declare_support(), and cxl_osc_request_control() can be
+ * used to update the support and control sets in accordance with the ACPI
+ * rules for _OSC evaluation - most importantly, capabilities already granted
+ * should not be rescinded by either the OS or firmware.
+ */
+
+static u32 cxl_osc_support_set;
+static u32 cxl_osc_control_set;
+static DEFINE_MUTEX(acpi_desc_lock);
+
+struct pci_osc_bit_struct {
+	u32 bit;
+	char *desc;
+};
+
+static struct pci_osc_bit_struct cxl_osc_support_bit[] = {
+	{ CXL_OSC_PORT_REG_ACCESS_SUPPORT, "CXLPortRegAccess" },
+	{ CXL_OSC_PORT_DEV_REG_ACCESS_SUPPORT, "CXLPortDevRegAccess" },
+	{ CXL_OSC_PER_SUPPORT, "CXLProtocolErrorReporting" },
+	{ CXL_OSC_NATIVE_HP_SUPPORT, "CXLNativeHotPlug" },
+};
+
+static struct pci_osc_bit_struct cxl_osc_control_bit[] = {
+	{ CXL_OSC_MEM_ERROR_CONTROL, "CXLMemErrorReporting" },
+};
+
+static u8 cxl_osc_uuid_str[] = "68F2D50B-C469-4d8A-BD3D-941A103FD3FC";
+
+static void decode_osc_bits(struct device *dev, char *msg, u32 word,
+			    struct pci_osc_bit_struct *table, int size)
+{
+	char buf[80];
+	int i, len = 0;
+	struct pci_osc_bit_struct *entry;
+
+	buf[0] = '\0';
+	for (i = 0, entry = table; i < size; i++, entry++)
+		if (word & entry->bit)
+			len += scnprintf(buf + len, sizeof(buf) - len, "%s%s",
+					 len ? " " : "", entry->desc);
+
+	dev_info(dev, "_OSC: %s [%s]\n", msg, buf);
+}
+
+static void decode_cxl_osc_support(struct device *dev, char *msg, u32 word)
+{
+	decode_osc_bits(dev, msg, word, cxl_osc_support_bit,
+			ARRAY_SIZE(cxl_osc_support_bit));
+}
+
+static void decode_cxl_osc_control(struct device *dev, char *msg, u32 word)
+{
+	decode_osc_bits(dev, msg, word, cxl_osc_control_bit,
+			ARRAY_SIZE(cxl_osc_control_bit));
+}
+
+static acpi_status acpi_cap_run_osc(acpi_handle handle, const u32 *capbuf,
+				    u8 *uuid_str, u32 *retval)
+{
+	struct acpi_osc_context context = {
+		.uuid_str = uuid_str,
+		.rev = 1,
+		.cap.length = 20,
+		.cap.pointer = (void *)capbuf,
+	};
+	acpi_status status;
+
+	status = acpi_run_osc(handle, &context);
+	if (ACPI_SUCCESS(status)) {
+		/* pointer + offset to DWORD 5 */
+		*retval = *((u32 *)(context.ret.pointer + 16));
+		kfree(context.ret.pointer);
+	}
+	return status;
+}
+
+static acpi_status cxl_query_osc(acpi_handle handle, u32 support, u32 *control)
+{
+	struct acpi_pci_root *root;
+	acpi_status status;
+	u32 result, capbuf[5];
+
+	root = acpi_pci_find_root(handle);
+	if (!root)
+		return -ENXIO;
+
+	support &= CXL_OSC_SUPPORT_VALID_MASK;
+	support |= cxl_osc_support_set;
+
+	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
+	capbuf[PCI_OSC_SUPPORT_DWORD] = root->osc_support_set;
+	capbuf[PCI_OSC_CONTROL_DWORD] = root->osc_control_set;
+	capbuf[CXL_OSC_SUPPORT_DWORD] = support;
+	if (control) {
+		*control &= CXL_OSC_CONTROL_VALID_MASK;
+		capbuf[CXL_OSC_CONTROL_DWORD] = *control | cxl_osc_control_set;
+	} else {
+		/* Run _OSC query only with existing controls. */
+		capbuf[CXL_OSC_CONTROL_DWORD] = cxl_osc_control_set;
+	}
+
+	status = acpi_cap_run_osc(handle, capbuf, cxl_osc_uuid_str, &result);
+	if (ACPI_SUCCESS(status)) {
+		cxl_osc_support_set = support;
+		if (control)
+			*control = result;
+	}
+	return status;
+}
+
+/**
+ * cxl_osc_declare_support - Declare support for CXL root _OSC features.
+ * @handle: ACPI device handle for the PCI root bridge (or PCIe Root Complex).
+ * @flags: The _OSC bits to declare support for.
+ *
+ * The PCI specific DWORDS are obtained from the pci root port device, and
+ * used as-is. The resulting CXL support set is saved in cxl_osc_support_set.
+ * Any future calls to this are forced to be strictly incremental from the
+ * existing cxl_osc_support_set.
+ */
+static acpi_status cxl_osc_declare_support(acpi_handle handle, u32 flags)
+{
+	acpi_status status;
+
+	mutex_lock(&acpi_desc_lock);
+	status = cxl_query_osc(handle, flags, NULL);
+	mutex_unlock(&acpi_desc_lock);
+	return status;
+}
+
+/**
+ * cxl_osc_request_control - Request control of CXL root _OSC features.
+ * @adev: ACPI device for the PCI root bridge (or PCIe Root Complex).
+ * @mask: Mask of _OSC bits to request control of, place to store control mask.
+ * @req: Mask of _OSC bits the control of is essential to the caller.
+ *
+ * The PCI specific DWORDS are obtained from the pci root port device, and
+ * used as-is. The resulting CXL control set is saved in cxl_osc_control_set.
+ * Any future calls to this are forced to be strictly incremental from the
+ * existing cxl_osc_control_set.
+ */
+static acpi_status cxl_osc_request_control(struct acpi_device *adev, u32 *mask,
+					   u32 req)
+{
+	acpi_handle handle = adev->handle;
+	struct device *dev = &adev->dev;
+	struct acpi_pci_root *root;
+	acpi_status status = AE_OK;
+	u32 ctrl, capbuf[5];
+
+	if (!mask)
+		return AE_BAD_PARAMETER;
+
+	ctrl = *mask & CXL_OSC_MEM_ERROR_CONTROL;
+	if ((ctrl & req) != req)
+		return AE_TYPE;
+
+	root = acpi_pci_find_root(handle);
+	if (!root)
+		return -ENXIO;
+
+	mutex_lock(&acpi_desc_lock);
+
+	*mask = ctrl | cxl_osc_control_set;
+	/* No need to evaluate _OSC if the control was already granted. */
+	if ((cxl_osc_control_set & ctrl) == ctrl)
+		goto out;
+
+	/* Need to check the available controls bits before requesting them. */
+	while (*mask) {
+		status = cxl_query_osc(handle, cxl_osc_support_set, mask);
+		if (ACPI_FAILURE(status))
+			goto out;
+		if (ctrl == *mask)
+			break;
+		decode_cxl_osc_control(dev, "platform does not support",
+				       ctrl & ~(*mask));
+		ctrl = *mask;
+	}
+
+	if ((ctrl & req) != req) {
+		decode_cxl_osc_control(dev,
+				       "not requesting control; platform does not support",
+				       req & ~(ctrl));
+		status = AE_SUPPORT;
+		goto out;
+	}
+
+	capbuf[OSC_QUERY_DWORD] = 0;
+	capbuf[PCI_OSC_SUPPORT_DWORD] = root->osc_support_set;
+	capbuf[PCI_OSC_CONTROL_DWORD] = root->osc_control_set;
+	capbuf[CXL_OSC_SUPPORT_DWORD] = cxl_osc_support_set;
+	capbuf[CXL_OSC_CONTROL_DWORD] = ctrl;
+	status = acpi_cap_run_osc(handle, capbuf, cxl_osc_uuid_str, mask);
+	if (ACPI_SUCCESS(status))
+		cxl_osc_control_set = *mask;
+out:
+	mutex_unlock(&acpi_desc_lock);
+	return status;
+}
+
+static int cxl_negotiate_osc(struct acpi_device *adev)
+{
+	u32 cxl_support, cxl_control, requested;
+	acpi_handle handle = adev->handle;
+	struct device *dev = &adev->dev;
+	acpi_status status;
+
+	/* Declare support for everything */
+	cxl_support = CXL_OSC_SUPPORT_VALID_MASK;
+	decode_cxl_osc_support(dev, "OS supports", cxl_support);
+	status = cxl_osc_declare_support(handle, cxl_support);
+	if (ACPI_FAILURE(status)) {
+		dev_info(dev, "CXL_OSC failed (%s)\n",
+			 acpi_format_exception(status));
+		return -ENXIO;
+	}
+
+	/* Request control for everything */
+	cxl_control = CXL_OSC_CONTROL_VALID_MASK;
+	requested = cxl_control;
+	status = cxl_osc_request_control(adev, &cxl_control,
+					 CXL_OSC_MEM_ERROR_CONTROL);
+	if (ACPI_SUCCESS(status)) {
+		decode_cxl_osc_control(dev, "OS now controls", cxl_control);
+	} else {
+		decode_cxl_osc_control(dev, "OS requested", requested);
+		decode_cxl_osc_control(dev, "platform willing to grant",
+				       cxl_control);
+		dev_info(dev, "_OSC failed (%s)\n",
+			 acpi_format_exception(status));
+	}
+	return 0;
+}
+
+/**
+ * cxl_bus_acquire - Perform platform-specific bus operations
+ * @pdev: pci_dev associated with the CXL device
+ *
+ * This performs bus-specific operations such as ACPI _OSC to ensure that
+ * the bus is 'prepared'. Since the CXL definition of _OSC depends on the
+ * existing PCI _OSC DWORDS in 'Arg3', pull those in from the pci root port
+ * device, and merge those into the new CXL-augmented _OSC calls.
+ *
  * If/when CXL support is defined by other platform firmware the kernel
  * will need a mechanism to select between the platform specific version
  * of this routine, until then, hard-code ACPI assumptions
@@ -21,6 +272,7 @@ int cxl_bus_acquire(struct pci_dev *pdev)
 	struct acpi_device *adev;
 	struct pci_dev *root_port;
 	struct device *root;
+	int rc;
 
 	root_port = pcie_find_root_port(pdev);
 	if (!root_port)
@@ -34,9 +286,11 @@ int cxl_bus_acquire(struct pci_dev *pdev)
 	if (!adev)
 		return -ENXIO;
 
-	/* TODO: OSC enabling */
+	rc = cxl_negotiate_osc(adev);
+	if (rc)
+		dev_err(&pdev->dev, "Failed to negotiate OSC\n");
 
-	return 0;
+	return rc;
 }
 EXPORT_SYMBOL_GPL(cxl_bus_acquire);
 
diff --git a/drivers/cxl/acpi.h b/drivers/cxl/acpi.h
index d638f8886ab7..6ef154021745 100644
--- a/drivers/cxl/acpi.h
+++ b/drivers/cxl/acpi.h
@@ -12,4 +12,24 @@ struct cxl_acpi_desc {
 
 int cxl_bus_acquire(struct pci_dev *pci_dev);
 
+/* Indexes into _OSC Capabilities Buffer */
+#define PCI_OSC_SUPPORT_DWORD			1	/* DWORD 2 */
+#define PCI_OSC_CONTROL_DWORD			2	/* DWORD 3 */
+#define CXL_OSC_SUPPORT_DWORD			3	/* DWORD 4 */
+#define CXL_OSC_CONTROL_DWORD			4	/* DWORD 5 */
+
+/* CXL Host Bridge _OSC: Capabilities DWORD 4: Support Field */
+#define CXL_OSC_PORT_REG_ACCESS_SUPPORT		0x00000001
+#define CXL_OSC_PORT_DEV_REG_ACCESS_SUPPORT	0x00000002
+#define CXL_OSC_PER_SUPPORT			0x00000004
+#define CXL_OSC_NATIVE_HP_SUPPORT		0x00000008
+#define CXL_OSC_SUPPORT_VALID_MASK		(CXL_OSC_PORT_REG_ACCESS_SUPPORT |	\
+						 CXL_OSC_PORT_DEV_REG_ACCESS_SUPPORT |	\
+						 CXL_OSC_PER_SUPPORT |			\
+						 CXL_OSC_NATIVE_HP_SUPPORT)
+
+/* CXL Host Bridge _OSC: Capabilities DWORD 5: Control Field */
+#define CXL_OSC_MEM_ERROR_CONTROL		0x00000001
+#define CXL_OSC_CONTROL_VALID_MASK		(CXL_OSC_MEM_ERROR_CONTROL)
+
 #endif	/* __CXL_ACPI_H__ */
-- 
2.30.0

