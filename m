Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6B84A51ED
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 22:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiAaV4R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 16:56:17 -0500
Received: from mga06.intel.com ([134.134.136.31]:15637 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbiAaV4N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 16:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643666173; x=1675202173;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K7qga3eZ1iQPzkhpO0/Tpd0vzWpBCsIwWSgi0Hbgg/w=;
  b=WdzkGkv/qndtXrBIxhSLWQhp3ar/q93liY+FrVX2SagkvBR+nrvquGoi
   7qezXOkpXpQUWX2emG4z7ez+DY0lRVdxtogsV8tXs2+6namDdjkYRBvAy
   KqYFpHz8MGWUgsyOkNwJUNAAtQZh2SSFB48Qad/s59F74Bb7bkCjDh+hY
   5DOZPUeAKfZGI32oSF3AzHHQZJdt3Ph3Xu+YwPUlztNI8H65pxs9DqsHN
   Bgg3jXXJR8Viu67WD2GB2YIA964TIHAhZ+Mry9QGwgKtr6GBNzlCZDIKV
   uu1heFoBY8iKczIITEIfqyaTetjACrbMWyERcEBLamuTGRsYO9fdgqWpg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="308289927"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="308289927"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 13:56:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="537510990"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 13:56:11 -0800
Subject: [PATCH v4 30/40] cxl/pci: Emit device serial number
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Mon, 31 Jan 2022 13:56:11 -0800
Message-ID: <164366608838.196598.16856227191534267098.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298427918.3018233.8524862534398549106.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298427918.3018233.8524862534398549106.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Per the CXL specification (8.1.12.2 Memory Device PCIe Capabilities and
Extended Capabilities) the Device Serial Number capability is mandatory.
Emit it for user tooling to identify devices.

It is reasonable to ask whether the attribute should be added to the
list of PCI sysfs device attributes. The PCI layer can optionally emit
it too, but the CXL subsystem is aiming to preserve its independence and
the possibility of CXL topologies with non-PCI devices in it. To date
that has only proven useful for the 'cxl_test' model, but as can be seen
with seen with ACPI0016 devices, sometimes all that is needed is a
platform firmware table to point to CXL Component Registers in MMIO
space to define a "CXL" device.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v3:
- Fixup changelog to clarify why CXL is emitting this attribute
  regardless of whether PCI later emits it. (Jonathan)

 Documentation/ABI/testing/sysfs-bus-cxl |    9 +++++++++
 drivers/cxl/core/memdev.c               |   11 +++++++++++
 drivers/cxl/cxlmem.h                    |    2 ++
 drivers/cxl/pci.c                       |    1 +
 tools/testing/cxl/test/mem.c            |    1 +
 5 files changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 6d8cbf3355b5..87c0e5e65322 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -25,6 +25,15 @@ Description:
 		identically named field in the Identify Memory Device Output
 		Payload in the CXL-2.0 specification.
 
+What:		/sys/bus/cxl/devices/memX/serial
+Date:		January, 2022
+KernelVersion:	v5.18
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) 64-bit serial number per the PCIe Device Serial Number
+		capability. Mandatory for CXL devices, see CXL 2.0 8.1.12.2
+		Memory Device PCIe Capabilities and Extended Capabilities.
+
 What:		/sys/bus/cxl/devices/*/devtype
 Date:		June, 2021
 KernelVersion:	v5.14
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 61029cb7ac62..1e574b052583 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -89,7 +89,18 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_pmem_size =
 	__ATTR(size, 0444, pmem_size_show, NULL);
 
+static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	return sysfs_emit(buf, "%#llx\n", cxlds->serial);
+}
+static DEVICE_ATTR_RO(serial);
+
 static struct attribute *cxl_memdev_attributes[] = {
+	&dev_attr_serial.attr,
 	&dev_attr_firmware_version.attr,
 	&dev_attr_payload_max.attr,
 	&dev_attr_label_storage_size.attr,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index e70838e5dc17..0ba0cf8dcdbc 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -131,6 +131,7 @@ struct cxl_endpoint_dvsec_info {
  * @next_persistent_bytes: persistent capacity change pending device reset
  * @component_reg_phys: register base of component registers
  * @info: Cached DVSEC information about the device.
+ * @serial: PCIe Device Serial Number
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  * @wait_media_ready: @dev specific method to await media ready
  *
@@ -164,6 +165,7 @@ struct cxl_dev_state {
 
 	resource_size_t component_reg_phys;
 	struct cxl_endpoint_dvsec_info info;
+	u64 serial;
 
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
 	int (*wait_media_ready)(struct cxl_dev_state *cxlds);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 513cb0e2a70a..9252e1f4b18c 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -557,6 +557,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlds))
 		return PTR_ERR(cxlds);
 
+	cxlds->serial = pci_get_dsn(pdev);
 	cxlds->cxl_dvsec = pci_find_dvsec_capability(
 		pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC);
 	if (!cxlds->cxl_dvsec) {
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 3af3f94de0c3..36ef337c775c 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -268,6 +268,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (IS_ERR(cxlds))
 		return PTR_ERR(cxlds);
 
+	cxlds->serial = pdev->id;
 	cxlds->mbox_send = cxl_mock_mbox_send;
 	cxlds->wait_media_ready = cxl_mock_wait_media_ready;
 	cxlds->payload_size = SZ_4K;

