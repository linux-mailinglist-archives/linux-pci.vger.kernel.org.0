Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36874A579F
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 08:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbiBAHUA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 02:20:00 -0500
Received: from mga07.intel.com ([134.134.136.100]:26795 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234691AbiBAHT7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 02:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643699999; x=1675235999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AmWU1AV08VfGeckIh6guz9YGRRuCnFpXZUJeaNG+8g0=;
  b=YWbcc/MO0gu9hWHNoQNdjN1K3myBMKgmW+d1cs/AfeC/ZgWbfHbME1y8
   cVEIVetUBzRubIhMp5a7gtKKPHFmE5a4OkCWChXnN7x4FafqopeEVp1ZQ
   0+UW16yOfZMMJQfLc95Noqzqe2KiLOQOoCm8C/FCYYaOOv2EPc6BosoQz
   dm8fUBwo2TbiILtao9BpjmCgngqYZCkyzoMzKGBEICLnb9gT/vnAnon0m
   o+hMhwXSh/oQuSgE30U7DBjn0olFOMaSZ+M7sO8j9D8OEluCM1ojClMLX
   ZzeQI7ferFuAZ63hQG6ODCCyj0wtB1i/nXXVUmVrio1fDl71cD9pnyDv1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="310942241"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="310942241"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:19:58 -0800
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="676000446"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:19:58 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V6 02/10] PCI: Replace magic constant for PCI Sig Vendor ID
Date:   Mon, 31 Jan 2022 23:19:44 -0800
Message-Id: <20220201071952.900068-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220201071952.900068-1-ira.weiny@intel.com>
References: <20220201071952.900068-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Based on Bjorn's suggestion[1], now that the PCI Sig Vendor ID is
defined the define should be used in pci_bus_crs_vendor_id() rather than
the hard coded magic value.

Replace the magic value in pci_bus_crs_vendor_id() with
PCI_VENDOR_ID_PCI_SIG.

[1] https://lore.kernel.org/linux-cxl/20211117215044.GA1777828@bhelgaas/

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 087d3658f75c..d92dbb136fc9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2318,7 +2318,7 @@ EXPORT_SYMBOL(pci_alloc_dev);
 
 static bool pci_bus_crs_vendor_id(u32 l)
 {
-	return (l & 0xffff) == 0x0001;
+	return (l & 0xffff) == PCI_VENDOR_ID_PCI_SIG;
 }
 
 static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
-- 
2.31.1

