Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275F868C7F6
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 21:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjBFUuU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 15:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjBFUuT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 15:50:19 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED772B097;
        Mon,  6 Feb 2023 12:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675716618; x=1707252618;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mfVfcggIP70jrmLKAqmG9n5343VBmt+WOjT7FFp8sF8=;
  b=Od2sqiBlclKmkibsx3I/2dQF7vBEczn3IQKE6YRbqXJMUkqO8MYq79UE
   NkZsfWWY7F/Rly16bCvMCtFF7tqKq62aoV1s6pf8jnUxdBAAnF11AMX0E
   M12o6F6745+g24TuV9qpPuqOy9jk9COPAVjRwXPH7Z71Ey6WVukLt14jL
   F1L/CoQQep7G/vLaT/2+8AxsvH+C7oT/ekh+hqurCcJ1CmcZ617oRG3cf
   5Dgjgqivwc/aWylb7NJpi+kX6kEjzQxwoPLbiIqe+D/O4J9c5L1Ftj3Wl
   GpVObxYYLRZsk3b45GWgStyga9cfD83Z+yN6rdCp/is58yhccCB1XG0Cy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="330604730"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="330604730"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:50:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="995471902"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="995471902"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.111.195])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:50:16 -0800
Subject: [PATCH 06/18] cxl: Add callback to parse the DSMAS subtables from
 CDAT
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
Date:   Mon, 06 Feb 2023 13:50:15 -0700
Message-ID: <167571661375.587790.16681436923769338643.stgit@djiang5-mobl3.local>
In-Reply-To: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide a callback function to the CDAT parser in order to parse the Device
Scoped Memory Affinity Structure (DSMAS). Each DSMAS structure contains the
DPA range and its associated attributes in each entry. See the CDAT
specification for details.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c |   25 +++++++++++++++++++++++++
 drivers/cxl/core/port.c |    2 ++
 drivers/cxl/cxl.h       |   11 +++++++++++
 drivers/cxl/port.c      |    8 ++++++++
 4 files changed, 46 insertions(+)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index be09c8a690f5..f9a64a0f1ee4 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -96,3 +96,28 @@ int cdat_table_parse_dslbis(void *table, cdat_tbl_entry_handler handler, void *a
 	return cdat_table_parse_entries(ACPI_CDAT_TYPE_DSLBIS, header, &proc, 0);
 }
 EXPORT_SYMBOL_NS_GPL(cdat_table_parse_dslbis, CXL);
+
+int cxl_dsmas_parse_entry(struct acpi_cdat_header *header, void *arg)
+{
+	struct cxl_port *port = (struct cxl_port *)arg;
+	struct dsmas_entry *dent;
+	struct acpi_cdat_dsmas *dsmas;
+
+	if (header->type != ACPI_CDAT_TYPE_DSMAS)
+		return -EINVAL;
+
+	dent = devm_kzalloc(&port->dev, sizeof(*dent), GFP_KERNEL);
+	if (!dent)
+		return -ENOMEM;
+
+	dsmas = (struct acpi_cdat_dsmas *)((unsigned long)header + sizeof(*header));
+	dent->handle = dsmas->dsmad_handle;
+	dent->dpa_range.start = dsmas->dpa_base_address;
+	dent->dpa_range.end = dsmas->dpa_base_address + dsmas->dpa_length - 1;
+
+	mutex_lock(&port->cdat.dsmas_lock);
+	list_add_tail(&dent->list, &port->cdat.dsmas_list);
+	mutex_unlock(&port->cdat.dsmas_lock);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dsmas_parse_entry, CXL);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index fe78daf7e7c8..2b27319cfd42 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -660,6 +660,8 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	device_set_pm_not_required(dev);
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_port_type;
+	INIT_LIST_HEAD(&port->cdat.dsmas_list);
+	mutex_init(&port->cdat.dsmas_lock);
 
 	return port;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 839a121c1997..1e5e69f08480 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
+#include <linux/list.h>
 #include <linux/io.h>
 #include <linux/acpi.h>
 
@@ -520,6 +521,8 @@ struct cxl_port {
 	struct cxl_cdat {
 		void *table;
 		size_t length;
+		struct list_head dsmas_list;
+		struct mutex dsmas_lock; /* lock for dsmas_list */
 	} cdat;
 	bool cdat_available;
 };
@@ -698,6 +701,12 @@ static inline struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
 }
 #endif
 
+struct dsmas_entry {
+	struct list_head list;
+	struct range dpa_range;
+	u16 handle;
+};
+
 typedef int (*cdat_tbl_entry_handler)(struct acpi_cdat_header *header, void *arg);
 
 u8 cdat_table_checksum(u8 *buffer, u32 length);
@@ -706,6 +715,8 @@ int cdat_table_parse_dsmas(void *table, cdat_tbl_entry_handler handler,
 int cdat_table_parse_dslbis(void *table, cdat_tbl_entry_handler handler,
 			    void *arg);
 
+int cxl_dsmas_parse_entry(struct acpi_cdat_header *header, void *arg);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 5453771bf330..b1da73e99bab 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -61,6 +61,14 @@ static int cxl_port_probe(struct device *dev)
 		if (rc)
 			return rc;
 
+		if (port->cdat.table) {
+			rc = cdat_table_parse_dsmas(port->cdat.table,
+						    cxl_dsmas_parse_entry,
+						    (void *)port);
+			if (rc < 0)
+				dev_dbg(dev, "Failed to parse DSMAS: %d\n", rc);
+		}
+
 		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
 		if (rc)
 			return rc;


