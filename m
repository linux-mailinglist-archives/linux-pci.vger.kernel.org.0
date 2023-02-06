Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA5968C7F0
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 21:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjBFUty (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 15:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjBFUtw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 15:49:52 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9541F496;
        Mon,  6 Feb 2023 12:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675716591; x=1707252591;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xS04BnIp7MCjHPpNH7pRQHA3mknpzH+ZYewjFg6BC9M=;
  b=iz+FkeKBYOyjWqSIr1C3i2JtdyEovnvF/z9aGCqTZ9GJickOKo3mePZl
   knsdNDfCTzFZsoyIT1m26FX0rB2Iq7mWh7nK04mAUHhaNGgU6s1qXDxGu
   1jMn7+ufY/R+bc/JvtOiKgGA5IcOyj6GRJtFxLhX9azTi7ceaUqMyNpY1
   3wyLyfQ6zuAwxUSRAMz00T5LH8CjYDmpUjl01K1uZo02bq+TjJtxrFEb6
   r8YHMIMGLT3EPSp/DyFNWFN2F/lttns9JRM6wt1sWK9PIcanP085Vhy66
   ZCgvvIIPSBiHiZXUDO+G92EI/3MLdI3YsXsrjQWZXzxVyvwdFnMb4Z2A7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="393911860"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="393911860"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:49:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="616559420"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="616559420"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.111.195])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:49:50 -0800
Subject: [PATCH 03/18] cxl: Add checksum verification to CDAT from CXL
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
Date:   Mon, 06 Feb 2023 13:49:48 -0700
Message-ID: <167571658747.587790.17252249256706733075.stgit@djiang5-mobl3.local>
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

A CDAT table is available from a CXL device. The table is read by the
driver and cached in software. With the CXL subsystem needing to parse the
CDAT table, the checksum should be verified. Add checksum verification
after the CDAT table is read from device.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 57764e9cd19d..a24dac36bedd 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -3,6 +3,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/acpi.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <cxlpci.h>
@@ -592,6 +593,7 @@ void read_cdat_data(struct cxl_port *port)
 	struct device *dev = &port->dev;
 	struct device *uport = port->uport;
 	size_t cdat_length;
+	acpi_status status;
 	int rc;
 
 	cdat_doe = find_cdat_doe(uport);
@@ -620,5 +622,14 @@ void read_cdat_data(struct cxl_port *port)
 		port->cdat.length = 0;
 		dev_err(dev, "CDAT data read error\n");
 	}
+
+	status = acpi_ut_verify_cdat_checksum(port->cdat.table, port->cdat.length);
+	if (status != AE_OK) {
+		/* Don't leave table data allocated on error */
+		devm_kfree(dev, port->cdat.table);
+		port->cdat.table = NULL;
+		port->cdat.length = 0;
+		dev_err(dev, "CDAT data checksum error\n");
+	}
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);


