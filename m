Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2222C68C80E
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 21:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjBFUwL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 15:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjBFUwL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 15:52:11 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B363A2E825;
        Mon,  6 Feb 2023 12:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675716727; x=1707252727;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fbw0gfA3CV6zl+8Xhzyb5C6vwjJRzvTIToKyZi8GRJ8=;
  b=kPz8dQLcYlw1nLTMALh8ePtTx/1k9pYQ3GZSNh4zU9fd/95cuSRjMNYO
   F4mgIOOTc4BoA2v8AMcFZjZzBWkh+3onjKYSy28Jdn6ftFmarJ+z53h+0
   fgqMX3sixbhRlmn6MawqwADRBboF2vC/dBOuhwb6oMjqF+1USKGNq0jZA
   yG6GzLCEAQ06qqPyAAK6q9EurOtHt4mpGfmxkv4atsUzfnFTKNjyf9Ph9
   lvLhmsih2Q+hyhmZz6JbrpG+jMwLvOrMoXtvmyn++L1Zn0ryiZjKGpbZE
   Te4AQszL5Y4RKqvc7M8xCOPcrouQtGgJrFAURGgBb5Ez+QFpHshhS1HmB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="329328291"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="329328291"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:52:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="809264138"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="809264138"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.111.195])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:52:07 -0800
Subject: [PATCH 18/18] cxl: Export sysfs attributes for device QTG IDs
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
Date:   Mon, 06 Feb 2023 13:52:05 -0700
Message-ID: <167571672370.587790.13206197631776290440.stgit@djiang5-mobl3.local>
In-Reply-To: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Export qtg_id sysfs attributes for the respective ram and pmem DPA range of
a CXL device. The QTG ID should show up as
/sys/bus/cxl/devices/memX/pmem/qtg_id for pmem or as
/sys/bus/cxl/devices/memX/ram/qtg_id for ram.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   15 +++++++++++++++
 drivers/cxl/core/memdev.c               |   26 ++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 0932c2f6fbf4..8133a13e118d 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -27,6 +27,14 @@ Description:
 		identically named field in the Identify Memory Device Output
 		Payload in the CXL-2.0 specification.
 
+What:		/sys/bus/cxl/devices/memX/ram/qtg_id
+Date:		January, 2023
+KernelVersion:	v6.3
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Shows calculated QoS Throttling Group ID for the
+		"Volatile Only Capacity" DPA range.
+
 
 What:		/sys/bus/cxl/devices/memX/pmem/size
 Date:		December, 2020
@@ -37,6 +45,13 @@ Description:
 		identically named field in the Identify Memory Device Output
 		Payload in the CXL-2.0 specification.
 
+What:		/sys/bus/cxl/devices/memX/pmem/qtg_id
+Date:		January, 2023
+KernelVersion:	v6.3
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Shows calculated QoS Throttling Group ID for the
+		"Persistent Only Capacity" DPA range.
 
 What:		/sys/bus/cxl/devices/memX/serial
 Date:		January, 2022
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index a74a93310d26..06f9ac929ef4 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -76,6 +76,18 @@ static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_ram_size =
 	__ATTR(size, 0444, ram_size_show, NULL);
 
+static ssize_t ram_qtg_id_show(struct device *dev, struct device_attribute *attr,
+			       char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	return sysfs_emit(buf, "%d\n", cxlds->ram_qtg_id);
+}
+
+static struct device_attribute dev_attr_ram_qtg_id =
+	__ATTR(qtg_id, 0444, ram_qtg_id_show, NULL);
+
 static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
@@ -89,6 +101,18 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_pmem_size =
 	__ATTR(size, 0444, pmem_size_show, NULL);
 
+static ssize_t pmem_qtg_id_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	return sysfs_emit(buf, "%d\n", cxlds->pmem_qtg_id);
+}
+
+static struct device_attribute dev_attr_pmem_qtg_id =
+	__ATTR(qtg_id, 0444, pmem_qtg_id_show, NULL);
+
 static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -117,11 +141,13 @@ static struct attribute *cxl_memdev_attributes[] = {
 
 static struct attribute *cxl_memdev_pmem_attributes[] = {
 	&dev_attr_pmem_size.attr,
+	&dev_attr_pmem_qtg_id.attr,
 	NULL,
 };
 
 static struct attribute *cxl_memdev_ram_attributes[] = {
 	&dev_attr_ram_size.attr,
+	&dev_attr_ram_qtg_id.attr,
 	NULL,
 };
 


