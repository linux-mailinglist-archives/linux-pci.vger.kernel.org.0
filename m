Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52645759C4
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 05:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241211AbiGODEi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 23:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241190AbiGODEg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 23:04:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C1F6D9E5;
        Thu, 14 Jul 2022 20:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657854275; x=1689390275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CIzVUNVWr6BnPVOqtfdAEOoTe2cMGpIyqjYMmya25/Y=;
  b=DI7LrxBOkZKcJEbNG7itGGrsFx3FH//rTx9mwqvT1RgCRbOZKxxAdOfu
   ahRyFv2QgWkzi9j5vHsoyT1RUZ6k1x8JkFj9wyzxFsEw50PSeMAph+kmt
   XlMqrTYzoMUwZl3WW0kGNQczMpaIfh4VDa/mQuvB2qYc5vl0OXZIG65Xi
   WwM24wLdA7QA66wNek9rEZhHy4EHOnOo4Fm8QqERK9g0fdeLU6guDtIrx
   H7LzPfjrbU+r5FQCKFpLCXkhnMHtTZ/lwyh29yAV3BNiuBzJcJEm2dzmt
   n1UthVLHT0JkygDgAmn5hj9VCZ8N1sdUrcXYk1xzkmYMY/sy4ICQiiihu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="372003588"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="372003588"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 20:04:35 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="546503573"
Received: from mbordone-mobl.amr.corp.intel.com (HELO localhost) ([10.255.5.217])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 20:04:32 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V14 1/7] PCI: Add vendor ID for the PCI SIG
Date:   Thu, 14 Jul 2022 20:04:18 -0700
Message-Id: <20220715030424.462963-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220715030424.462963-1-ira.weiny@intel.com>
References: <20220715030424.462963-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This ID is used in DOE headers to identify protocols that are defined
within the PCI Express Base Specification, PCIe r6.0, sec 6.30.1.1 table
6-32.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 0178823ce8c2..8af3b86206b1 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -151,6 +151,7 @@
 #define PCI_CLASS_OTHERS		0xff
 
 /* Vendors and devices.  Sort key: vendor first, device next. */
+#define PCI_VENDOR_ID_PCI_SIG		0x0001
 
 #define PCI_VENDOR_ID_LOONGSON		0x0014
 
-- 
2.35.3

