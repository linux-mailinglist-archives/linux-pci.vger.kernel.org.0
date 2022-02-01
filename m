Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376D24A579B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 08:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiBAHT7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 02:19:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:26795 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234687AbiBAHT7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 02:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643699999; x=1675235999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EUq4qTJCDuR52iNO3fH2Zz916n1DoQ0Wd3lHRxgq0zM=;
  b=EYJu4g/QVTzZ52JrHBJfdnqzEhlcTY/OpHAKYY9K+dRpt24SN6DsgxS5
   GzC5AiXFc20jYCoCpGxnWWP6XsdqS6xd4hjOcDajfK4o8uCxllXmb3tJ3
   7U8wZfbSkMFbeWnLU5a/xSNg7berg05UJ0Sr47a6Xpom/6Bv02kJpcrJC
   4JNtN9+WM+GUTsY6ng3CD5fed4/Ve1mDHgCUDg5Zs2asAHGDQZO5g03JU
   oMEJGVb/ALFToz3jSsKrE1Lm+AmwHYjywz21aFGMZBplAcgPQHhsuSfGw
   gV4oaBO2itajtKgXclWKJIaxXk3MqBvgnlYuN4PZNnMObrc6MwnSAYyyZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="310942240"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="310942240"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:19:58 -0800
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="676000441"
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
Subject: [PATCH V6 01/10] PCI: Add vendor ID for the PCI SIG
Date:   Mon, 31 Jan 2022 23:19:43 -0800
Message-Id: <20220201071952.900068-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220201071952.900068-1-ira.weiny@intel.com>
References: <20220201071952.900068-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This ID is used in DOE headers to identify protocols that are defined
within the PCI Express Base Specification.

Specified in Table 7-x2 of the Data Object Exchange ECN (approved 12 March
2020) available from https://members.pcisig.com/wg/PCI-SIG/document/14143

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 011f2f1ea5bb..849f514cd7db 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -149,6 +149,7 @@
 #define PCI_CLASS_OTHERS		0xff
 
 /* Vendors and devices.  Sort key: vendor first, device next. */
+#define PCI_VENDOR_ID_PCI_SIG		0x0001
 
 #define PCI_VENDOR_ID_LOONGSON		0x0014
 
-- 
2.31.1

