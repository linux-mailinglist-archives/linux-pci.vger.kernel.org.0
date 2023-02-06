Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E837C68C80C
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 21:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjBFUwA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 15:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjBFUv7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 15:51:59 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A1D2A9B9;
        Mon,  6 Feb 2023 12:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675716719; x=1707252719;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JpDWvJWFRhu/T3wx6PiMHyV4AusHz3nMjcnJti5tzgQ=;
  b=C4ac6kTbhvRe4YFdoKZ0+CdGsPD5tbHltLifxfRzanL4u2ICN/Q77yQT
   4CBGBnDJI4E0I3Py3ur3X/0k2O72qg1+0WHJHnNZngSPmsW0DhG53oJiY
   E6buD3syBJM4F+2C/Dwfm3+Dz4tPbzPcF/xTgWOyaQgpzv+cV/FIvicCL
   JwTv+Uf+aSrMLvXOkFJsB/401MRaYWr1wnbyh23uRkJ3P5cBUxzw1Nz0Q
   WjAqbogEHKkBANw3SZDelxW0FBqjrwdp3GTu49IbGUvIS1Ou/608SwZ9L
   G74AyC5ReSLSY2bj6mrswsnOk405IiFYXBS6ev0hFUW7FGCf+XfZmE7Iw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="327946663"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="327946663"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:51:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="790552392"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="790552392"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.111.195])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:51:57 -0800
Subject: [PATCH 17/18] cxl: Attach QTG IDs to the DPA ranges for the device
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
Date:   Mon, 06 Feb 2023 13:51:55 -0700
Message-ID: <167571671461.587790.3035047445704886954.stgit@djiang5-mobl3.local>
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

Match the DPA ranges of the mem device and the calcuated DPA range attached
to the DSMAS. If a match is found, then assign the QTG ID to the relevant
DPA range of the memory device.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c |    2 ++
 drivers/cxl/cxlmem.h    |    2 ++
 drivers/cxl/port.c      |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index b03fba212799..2a7b07d65010 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -869,6 +869,8 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
 
 	mutex_init(&cxlds->mbox_mutex);
 	cxlds->dev = dev;
+	cxlds->pmem_qtg_id = -1;
+	cxlds->ram_qtg_id = -1;
 
 	return cxlds;
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ab138004f644..d88b88ecc807 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -251,6 +251,8 @@ struct cxl_dev_state {
 	struct resource dpa_res;
 	struct resource pmem_res;
 	struct resource ram_res;
+	int pmem_qtg_id;
+	int ram_qtg_id;
 	u64 total_bytes;
 	u64 volatile_only_bytes;
 	u64 persistent_only_bytes;
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 6b2ad22487f5..c4cee69d6625 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -68,6 +68,39 @@ static int cxl_port_qos_calculate(struct cxl_port *port)
 	return 0;
 }
 
+static bool dpa_match_qtg_range(struct range *dpa, struct range *qtg)
+{
+	if (dpa->start >= qtg->start && dpa->end <= qtg->end)
+		return true;
+	return false;
+}
+
+static void cxl_dev_set_qtg(struct cxl_port *port, struct cxl_dev_state *cxlds)
+{
+	struct dsmas_entry *dent;
+	struct range ram_range = {
+		.start = cxlds->ram_res.start,
+		.end = cxlds->ram_res.end,
+	};
+	struct range pmem_range =  {
+		.start = cxlds->pmem_res.start,
+		.end = cxlds->pmem_res.end,
+	};
+
+	mutex_lock(&port->cdat.dsmas_lock);
+	list_for_each_entry(dent, &port->cdat.dsmas_list, list) {
+		if (dpa_match_qtg_range(&ram_range, &dent->dpa_range)) {
+			cxlds->ram_qtg_id = dent->qtg_id;
+			break;
+		}
+		if (dpa_match_qtg_range(&pmem_range, &dent->dpa_range)) {
+			cxlds->pmem_qtg_id = dent->qtg_id;
+			break;
+		}
+	}
+	mutex_unlock(&port->cdat.dsmas_lock);
+}
+
 static int cxl_port_probe(struct device *dev)
 {
 	struct cxl_port *port = to_cxl_port(dev);
@@ -134,6 +167,8 @@ static int cxl_port_probe(struct device *dev)
 		rc = cxl_mem_create_range_info(cxlds);
 		if (rc)
 			return rc;
+
+		cxl_dev_set_qtg(port, cxlds);
 	}
 
 	rc = devm_cxl_enumerate_decoders(cxlhdm);


