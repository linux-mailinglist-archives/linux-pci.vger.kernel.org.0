Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C335B4976A4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbiAXAbF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:31:05 -0500
Received: from mga03.intel.com ([134.134.136.65]:62312 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240611AbiAXAbF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984265; x=1674520265;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SfrX49CEwqgdGrl9quxjdej7SjvgtM4DFLCaE+t2LKI=;
  b=KHqeQvlcWdsKs+78/7MQxuoig2rM4ViOwc6a4Fq/GEX7287cuxPgkqC8
   rgwaN0EQjWIOiK+eQMnsEzmf1ATSEj6q9WgxuyIzUuNiTG9KC4Fn43XJN
   TQtFXqNMI/ldTOx2kdInBM16oeiFh4ARNW0ZOr1/ULOp49sdYDI2gJ9Bd
   2AdqzqNXVFdPQR3moTBbGGVN90cMejcZutmtqdSY6l6xczBz+R4MKU1ih
   NCjUsSKk6dg3NPeZQyu8xro5UYLmqDMs6q1TDF/IVDDZ5oQ4HHfgMKcfN
   2ERyslVRdoEYfzisQuUPSnFDTRbxXyjYVCO45C0C0cl7ht9y7DeR2wr/i
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245879330"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245879330"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:30:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="476536965"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:30:41 -0800
Subject: [PATCH v3 23/40] cxl/core: Emit modalias for CXL devices
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:30:41 -0800
Message-ID: <164298424120.3018233.15611905873808708542.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to enable libkmod lookups for CXL device objects to their
corresponding module, add 'modalias' to the base attribute of CXL
devices.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |    9 +++++++++
 drivers/cxl/core/port.c                 |   26 +++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 0b6a2e6e8fbb..6d8cbf3355b5 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -34,6 +34,15 @@ Description:
 		the same value communicated in the DEVTYPE environment variable
 		for uevents for devices on the "cxl" bus.
 
+What:		/sys/bus/cxl/devices/*/modalias
+Date:		December, 2021
+KernelVersion:	v5.18
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		CXL device objects export the modalias attribute which mirrors
+		the same value communicated in the MODALIAS environment variable
+		for uevents for devices on the "cxl" bus.
+
 What:		/sys/bus/cxl/devices/portX/uport
 Date:		June, 2021
 KernelVersion:	v5.14
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 72633865b386..eede0bbe687a 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -34,8 +34,25 @@ static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(devtype);
 
+static int cxl_device_id(struct device *dev)
+{
+	if (dev->type == &cxl_nvdimm_bridge_type)
+		return CXL_DEVICE_NVDIMM_BRIDGE;
+	if (dev->type == &cxl_nvdimm_type)
+		return CXL_DEVICE_NVDIMM;
+	return 0;
+}
+
+static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	return sysfs_emit(buf, CXL_MODALIAS_FMT "\n", cxl_device_id(dev));
+}
+static DEVICE_ATTR_RO(modalias);
+
 static struct attribute *cxl_base_attributes[] = {
 	&dev_attr_devtype.attr,
+	&dev_attr_modalias.attr,
 	NULL,
 };
 
@@ -845,15 +862,6 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_driver_unregister, CXL);
 
-static int cxl_device_id(struct device *dev)
-{
-	if (dev->type == &cxl_nvdimm_bridge_type)
-		return CXL_DEVICE_NVDIMM_BRIDGE;
-	if (dev->type == &cxl_nvdimm_type)
-		return CXL_DEVICE_NVDIMM;
-	return 0;
-}
-
 static int cxl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	return add_uevent_var(env, "MODALIAS=" CXL_MODALIAS_FMT,

