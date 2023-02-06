Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C23A68C804
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 21:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjBFUvZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 15:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjBFUvY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 15:51:24 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF032CC75;
        Mon,  6 Feb 2023 12:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675716682; x=1707252682;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7O4X6qGSX/zqCT/RteJSiBi67krWrHZ5oj0nquyYo4E=;
  b=A34CYjWWBaewdOMX/sDjQPomVG7y3O7v75KR77Zud+tWMW6SLXq8czBb
   o1+P4HZnza1nWCZvXhUD5qZ2UCj2HWmGMpB57gQBO8RKAB+iI090/zS0/
   b7qm4FKLqHMsYgWt+P8DiJZUDEjvL4BC/kzGuhWayczoY8SvZ63WOeqDO
   603jyvatNXCi7Sqxkkv3VPZ32+WnSJ1TL+Xw1xObBHjA85Q33gqQoIwZQ
   8450okwD1+d6CONJmx4ATdgs2EozgremCCxxI1u9Jt4lIS+PN3Hh36ZTx
   U3Sy72eNcKvMFK/L8nOaGKle1KuVYlI1vtMUCFvlMCTqxGmlS6fQzLdbG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="391708550"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="391708550"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:51:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="840493062"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="840493062"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.111.195])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:51:21 -0800
Subject: [PATCH 13/18] cxl: Add latency and bandwidth calculations for the CXL
 path
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
Date:   Mon, 06 Feb 2023 13:51:19 -0700
Message-ID: <167571667794.587790.14172786993094257614.stgit@djiang5-mobl3.local>
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

CXL Memory Device SW Guide rev1.0 2.11.2 provides instruction on how to
caluclate latency and bandwidth for CXL memory device. Calculate minimum
bandwidth and total latency for the path from the CXL device to the root
port. The calculates values are stored in the cached DSMAS entries attached
to the cxl_port of the CXL device.

For example for a device that is directly attached to a host bus:
Total Latency = Device Latency (from CDAT) + Dev to Host Bus (HB) Link
		Latency
Min Bandwidth = Link Bandwidth between Host Bus and CXL device

For a device that has a switch in between host bus and CXL device:
Total Latency = Device (CDAT) Latency + Dev to Switch Link Latency +
		Switch (CDAT) Latency + Switch to HB Link Latency
Min Bandwidth = min(dev to switch bandwidth, switch to HB bandwidth)
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

The internal latency for a switch can be retrieved from the CDAT of the
switch PCI device. However, since there's no easy way to retrieve that
right now on Linux, a guesstimated constant is used per switch to simplify
the driver code.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    9 +++++++
 drivers/cxl/port.c      |   42 +++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 2b27319cfd42..aa260361ba7d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1899,6 +1899,66 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
 }
 EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
 
+int cxl_port_get_downstream_qos(struct cxl_port *port, long *bw, long *lat)
+{
+	long total_lat = 0, latency;
+	long min_bw = INT_MAX;
+	struct pci_dev *pdev;
+	struct cxl_port *p;
+	struct device *dev;
+	int devices = 0;
+
+	/* Grab the device that is the PCI device for CXL memdev */
+	dev = port->uport->parent;
+	/* Skip if it's not PCI, most likely a cxl_test device */
+	if (!dev_is_pci(dev))
+		return 0;
+
+	pdev = to_pci_dev(dev);
+	min_bw = pcie_bandwidth_available(pdev, NULL, NULL, NULL);
+	if (min_bw == 0)
+		return -ENXIO;
+
+	/* convert to MB/s from Mb/s */
+	min_bw >>= 3;
+
+	p = port;
+	do {
+		struct cxl_dport *dport;
+
+		latency = cxl_pci_get_latency(pdev);
+		if (latency < 0)
+			return latency;
+
+		total_lat += latency;
+		devices++;
+
+		dport = p->parent_dport;
+		if (!dport)
+			break;
+
+		p = dport->port;
+		dev = p->uport;
+		if (!dev_is_pci(dev))
+			break;
+		pdev = to_pci_dev(dev);
+	} while (1);
+
+	/*
+	 * Add an approximate latency to the switch. Currently there
+	 * is no easy mechanism to read the CDAT for switches. 'devices'
+	 * should account for all the PCI devices encountered minus the
+	 * root device. So the number of switches would be 'devices - 1'
+	 * to account for the CXL device.
+	 */
+	total_lat += CXL_SWITCH_APPROX_LAT * (devices - 1);
+
+	*bw = min_bw;
+	*lat = total_lat;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_get_downstream_qos, CXL);
+
 /* for user tooling to ensure port disable work has completed */
 static ssize_t flush_store(struct bus_type *bus, const char *buf, size_t count)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ac6ea550ab0a..86668fab6e91 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -480,6 +480,13 @@ struct cxl_pmem_region {
 	struct cxl_pmem_region_mapping mapping[];
 };
 
+/*
+ * Set in picoseconds per ACPI spec 6.5 Table 5.148 Entry Base Unit.
+ * This is an approximate constant to use for switch latency calculation
+ * until there's a way to access switch CDAT.
+ */
+#define CXL_SWITCH_APPROX_LAT	5000
+
 /**
  * struct cxl_port - logical collection of upstream port devices and
  *		     downstream port devices to construct a CXL memory
@@ -706,6 +713,7 @@ struct dsmas_entry {
 	struct range dpa_range;
 	u16 handle;
 	u64 qos[ACPI_HMAT_WRITE_BANDWIDTH + 1];
+	int qtg_id;
 };
 
 typedef int (*cdat_tbl_entry_handler)(struct acpi_cdat_header *header, void *arg);
@@ -734,6 +742,7 @@ struct qtg_dsm_output {
 struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
 						 struct qtg_dsm_input *input);
 acpi_handle cxl_acpi_get_rootdev_handle(struct device *dev);
+int cxl_port_get_downstream_qos(struct cxl_port *port, long *bw, long *lat);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 8de311208b37..d72e38f9ae44 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -30,6 +30,44 @@ static void schedule_detach(void *cxlmd)
 	schedule_cxl_memdev_detach(cxlmd);
 }
 
+static int cxl_port_qos_calculate(struct cxl_port *port)
+{
+	struct qtg_dsm_output *output;
+	struct qtg_dsm_input input;
+	struct dsmas_entry *dent;
+	long min_bw, total_lat;
+	acpi_handle handle;
+	int rc;
+
+	rc = cxl_port_get_downstream_qos(port, &min_bw, &total_lat);
+	if (rc)
+		return rc;
+
+	handle = cxl_acpi_get_rootdev_handle(&port->dev);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
+	mutex_lock(&port->cdat.dsmas_lock);
+	list_for_each_entry(dent, &port->cdat.dsmas_list, list) {
+		input.rd_lat = dent->qos[ACPI_HMAT_READ_LATENCY] + total_lat;
+		input.wr_lat = dent->qos[ACPI_HMAT_WRITE_LATENCY] + total_lat;
+		input.rd_bw = min_t(int, min_bw,
+				    dent->qos[ACPI_HMAT_READ_BANDWIDTH]);
+		input.wr_bw = min_t(int, min_bw,
+				    dent->qos[ACPI_HMAT_WRITE_BANDWIDTH]);
+
+		output = cxl_acpi_evaluate_qtg_dsm(handle, &input);
+		if (IS_ERR(output))
+			continue;
+
+		dent->qtg_id = output->qtg_ids[0];
+		kfree(output);
+	}
+	mutex_unlock(&port->cdat.dsmas_lock);
+
+	return 0;
+}
+
 static int cxl_port_probe(struct device *dev)
 {
 	struct cxl_port *port = to_cxl_port(dev);
@@ -74,6 +112,10 @@ static int cxl_port_probe(struct device *dev)
 			} else {
 				dev_dbg(dev, "Failed to parse DSMAS: %d\n", rc);
 			}
+
+			rc = cxl_port_qos_calculate(port);
+			if (rc)
+				dev_dbg(dev, "Failed to do QoS calculations\n");
 		}
 
 		rc = cxl_hdm_decode_init(cxlds, cxlhdm);


