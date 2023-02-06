Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1353568C7EB
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 21:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjBFUth (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 15:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjBFUtf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 15:49:35 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123CA2BF05;
        Mon,  6 Feb 2023 12:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675716574; x=1707252574;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bkGbiCLyd+lG5cBq1nAbZmdVuueIpeBqaWZkt8YeFBs=;
  b=NHjVfb6wrUFXhNHrO8yoRB+TcLSrNdxAP2eXl9cGu/kfN9tlnIPqNh1G
   8gqKB6xBtIGkpF6KLtLEgrL24oOrB/uWSb4HLD6FFERi40K1HkbjrOHB4
   DXwoSKXDNxe5TpKRKdly+3hxtSElthVQoD90ovuDU4dw/UUOPUI/qQH2C
   XaHwYhNMBgU6FAnU9zfbKxPg+h2pIMSeO79no/+fIBje+tUD253sP+Vdv
   hF7xtMn/d32fuNSavc3l/KoLndvCaXvX39pvNp3BkJ95V4oLn7iNREc16
   mMEWih6Y5bO+HvjsHJX1xDmsLqcLTKs7VcIXuWWJ5AsWjbVNwQVLzwMRF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="393911803"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="393911803"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:49:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="616559345"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="616559345"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.111.195])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:49:32 -0800
Subject: [PATCH 01/18] cxl: Export QTG ids from CFMWS to sysfs
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
Date:   Mon, 06 Feb 2023 13:49:30 -0700
Message-ID: <167571656940.587790.15913351407119270213.stgit@djiang5-mobl3.local>
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

Export the QoS Throttling Group ID from the CXL Fixed Memory Window
Structure (CFMWS) under the root decoder sysfs attributes.
CXL rev3.0 9.17.1.3 CXL Fixed Memory Window Structure (CFMWS)

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |    7 +++++++
 drivers/cxl/acpi.c                      |    3 +++
 drivers/cxl/core/port.c                 |   14 ++++++++++++++
 drivers/cxl/cxl.h                       |    3 +++
 4 files changed, 27 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 8494ef27e8d2..0932c2f6fbf4 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -294,6 +294,13 @@ Description:
 		(WO) Write a string in the form 'regionZ' to delete that region,
 		provided it is currently idle / not bound to a driver.
 
+What:		/sys/bus/cxl/devices/decoderX.Y/qtg_id
+Date:		Jan, 2023
+KernelVersion:	v6.3
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Shows the QoS Throttling Group ID. The QTG ID for a root
+		decoder comes from the CFMWS structure of the CEDT.
 
 What:		/sys/bus/cxl/devices/regionZ/uuid
 Date:		May, 2022
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 13cde44c6086..7a71bb5041c7 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -289,6 +289,9 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 			}
 		}
 	}
+
+	cxld->qtg_id = cfmws->qtg_id;
+
 	rc = cxl_decoder_add(cxld, target_map);
 err_xormap:
 	if (rc)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b631a0520456..fe78daf7e7c8 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -284,6 +284,16 @@ static ssize_t interleave_ways_show(struct device *dev,
 
 static DEVICE_ATTR_RO(interleave_ways);
 
+static ssize_t qtg_id_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+
+	return sysfs_emit(buf, "%d\n", cxld->qtg_id);
+}
+
+static DEVICE_ATTR_RO(qtg_id);
+
 static struct attribute *cxl_decoder_base_attrs[] = {
 	&dev_attr_start.attr,
 	&dev_attr_size.attr,
@@ -303,6 +313,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 	&dev_attr_cap_type2.attr,
 	&dev_attr_cap_type3.attr,
 	&dev_attr_target_list.attr,
+	&dev_attr_qtg_id.attr,
 	SET_CXL_REGION_ATTR(create_pmem_region)
 	SET_CXL_REGION_ATTR(delete_region)
 	NULL,
@@ -1606,6 +1617,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 	}
 
 	atomic_set(&cxlrd->region_id, rc);
+	cxld->qtg_id = CXL_QTG_ID_INVALID;
 	return cxlrd;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
@@ -1643,6 +1655,7 @@ struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 
 	cxld = &cxlsd->cxld;
 	cxld->dev.type = &cxl_decoder_switch_type;
+	cxld->qtg_id = CXL_QTG_ID_INVALID;
 	return cxlsd;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
@@ -1675,6 +1688,7 @@ struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
 	}
 
 	cxld->dev.type = &cxl_decoder_endpoint_type;
+	cxld->qtg_id = CXL_QTG_ID_INVALID;
 	return cxled;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_alloc, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1b1cf459ac77..f558bbfc0332 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -279,6 +279,7 @@ enum cxl_decoder_type {
  */
 #define CXL_DECODER_MAX_INTERLEAVE 16
 
+#define CXL_QTG_ID_INVALID	-1
 
 /**
  * struct cxl_decoder - Common CXL HDM Decoder Attributes
@@ -290,6 +291,7 @@ enum cxl_decoder_type {
  * @target_type: accelerator vs expander (type2 vs type3) selector
  * @region: currently assigned region for this decoder
  * @flags: memory type capabilities and locking
+ * @qtg_id: QoS Throttling Group ID
  * @commit: device/decoder-type specific callback to commit settings to hw
  * @reset: device/decoder-type specific callback to reset hw settings
 */
@@ -302,6 +304,7 @@ struct cxl_decoder {
 	enum cxl_decoder_type target_type;
 	struct cxl_region *region;
 	unsigned long flags;
+	int qtg_id;
 	int (*commit)(struct cxl_decoder *cxld);
 	int (*reset)(struct cxl_decoder *cxld);
 };


