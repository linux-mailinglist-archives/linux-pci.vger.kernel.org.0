Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DBD4976AA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240617AbiAXAbT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:31:19 -0500
Received: from mga03.intel.com ([134.134.136.65]:62345 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235522AbiAXAbT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984279; x=1674520279;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c0l8SZblXwv0B6ZZUTJUC6Gddvs4JIEh2lg9YgBwkvE=;
  b=ll+BFWJ+CpvRmH+g0DdzgAAGbGqahDBz7P+832NG0LbMTNX1RN9RQFoY
   2YmaQJUmAmlI1gXPgA8JKNBjAVAwurw37OfAF+7WNsx77REg6FXmXpQs0
   kS9amhYJ6Ec90KVL0t4oWaU43drn0KcVItWbWLYJbNP5lfGJjcbM68FC1
   mTcp9Y3lMdYMvra8s7fO4P7SSkUQyvvlstHTWW5Zx3y13SV3wux958prq
   Qj2FuB5fEAmEAFeeDgl/ax1IIp8OR+xqVI4xEahK9+IKjjHhS4irbyLqM
   F0f3yTlfXHcwQOAuA5Cee8EMGMwPbSwdXsToav+kL23SDq5dMdOPlTo2C
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245879416"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245879416"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:31:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="695240319"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:31:19 -0800
Subject: [PATCH v3 30/40] cxl/pci: Emit device serial number
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:31:19 -0800
Message-ID: <164298427918.3018233.8524862534398549106.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
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

