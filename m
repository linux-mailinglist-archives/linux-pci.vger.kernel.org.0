Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E9768C7F8
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 21:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjBFUue (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 15:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjBFUud (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 15:50:33 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A1F20050;
        Mon,  6 Feb 2023 12:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675716632; x=1707252632;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kIXOGWIlRzYzArn4iLknajFZdj1TLid0ppmpb6d89J4=;
  b=PNvr+yo7RFbI0rT2jVpuhKRBR+JTIi0X3mMCy+dKv56WhS4vELf/Dpqk
   r9RDS4SVGipTZuoxnkRG4Sxkeqn/WjBpTiGZdVK0M/d1xK6386wAlmtUz
   yZm/nacjWHwY0o474Xu9xohMy+8j6T6Mp5/5z/+khSYcNgqvros2o0ZnA
   cU342kmevUzg87iOjIQvs5dofDujh5aoAFF1U8BtQzFP2tVV2nC7jto/+
   TnDUXiemSa8xfijuJngWKuE6GgP9DQgFHaARXjh+ZKEm1O6m0KVARhZh8
   JV9eJJ0WuTDRYPbhcJYAzdfpDo6CxCYEnuAcsAEft/2MdYOcOQ1g0UAla
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="393911985"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="393911985"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:50:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="616559542"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="616559542"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.111.195])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:50:26 -0800
Subject: [PATCH 07/18] cxl: Add callback to parse the DSLBIS subtable from
 CDAT
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
Date:   Mon, 06 Feb 2023 13:50:23 -0700
Message-ID: <167571662248.587790.4362747686454305108.stgit@djiang5-mobl3.local>
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

Provide a callback to parse the Device Scoped Latency and Bandwidth
Information Structure (DSLBIS) in the CDAT structures. The DSLBIS
contains the bandwidth and latency information that's tied to a DSMAS
handle. The driver will retrieve the read and write latency and
bandwidth associated with the DSMAS which is tied to a DPA range.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c |   34 ++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    2 ++
 drivers/cxl/port.c      |    9 ++++++++-
 include/acpi/actbl1.h   |    5 +++++
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index f9a64a0f1ee4..3c8f3956487e 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -121,3 +121,37 @@ int cxl_dsmas_parse_entry(struct acpi_cdat_header *header, void *arg)
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dsmas_parse_entry, CXL);
+
+int cxl_dslbis_parse_entry(struct acpi_cdat_header *header, void *arg)
+{
+	struct cxl_port *port = (struct cxl_port *)arg;
+	struct dsmas_entry *dent;
+	struct acpi_cdat_dslbis *dslbis;
+	u64 val;
+
+	if (header->type != ACPI_CDAT_TYPE_DSLBIS)
+		return -EINVAL;
+
+	dslbis = (struct acpi_cdat_dslbis *)((unsigned long)header + sizeof(*header));
+	if ((dslbis->flags & ACPI_CEDT_DSLBIS_MEM_MASK) !=
+	     ACPI_CEDT_DSLBIS_MEM_MEMORY)
+		return 0;
+
+	if (dslbis->data_type > ACPI_HMAT_WRITE_BANDWIDTH)
+		return -ENXIO;
+
+	/* Value calculation with base_unit, see ACPI Spec 6.5 5.2.28.4 */
+	val = dslbis->entry[0] * dslbis->entry_base_unit;
+
+	mutex_lock(&port->cdat.dsmas_lock);
+	list_for_each_entry(dent, &port->cdat.dsmas_list, list) {
+		if (dslbis->handle == dent->handle) {
+			dent->qos[dslbis->data_type] = val;
+			break;
+		}
+	}
+	mutex_unlock(&port->cdat.dsmas_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dslbis_parse_entry, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1e5e69f08480..849b22236f1d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -705,6 +705,7 @@ struct dsmas_entry {
 	struct list_head list;
 	struct range dpa_range;
 	u16 handle;
+	u64 qos[ACPI_HMAT_WRITE_BANDWIDTH + 1];
 };
 
 typedef int (*cdat_tbl_entry_handler)(struct acpi_cdat_header *header, void *arg);
@@ -716,6 +717,7 @@ int cdat_table_parse_dslbis(void *table, cdat_tbl_entry_handler handler,
 			    void *arg);
 
 int cxl_dsmas_parse_entry(struct acpi_cdat_header *header, void *arg);
+int cxl_dslbis_parse_entry(struct acpi_cdat_header *header, void *arg);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index b1da73e99bab..8de311208b37 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -65,8 +65,15 @@ static int cxl_port_probe(struct device *dev)
 			rc = cdat_table_parse_dsmas(port->cdat.table,
 						    cxl_dsmas_parse_entry,
 						    (void *)port);
-			if (rc < 0)
+			if (rc > 0) {
+				rc = cdat_table_parse_dslbis(port->cdat.table,
+							     cxl_dslbis_parse_entry,
+							     (void *)port);
+				if (rc <= 0)
+					dev_dbg(dev, "Failed to parse DSLBIS: %d\n", rc);
+			} else {
 				dev_dbg(dev, "Failed to parse DSMAS: %d\n", rc);
+			}
 		}
 
 		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index e8297cefde09..ff6092e45196 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -369,6 +369,11 @@ struct acpi_cdat_dslbis {
 	u16 reserved2;
 };
 
+/* Flags for subtable above */
+
+#define ACPI_CEDT_DSLBIS_MEM_MASK	GENMASK(3, 0)
+#define ACPI_CEDT_DSLBIS_MEM_MEMORY	0
+
 /* Subtable 2: Device Scoped Memory Side Cache Information Structure (DSMSCIS) */
 
 struct acpi_cdat_dsmscis {


