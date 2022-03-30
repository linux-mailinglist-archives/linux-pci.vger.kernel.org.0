Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9A44ED080
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 01:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351912AbiCaABO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 20:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351901AbiCaABN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 20:01:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C3560AB4;
        Wed, 30 Mar 2022 16:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648684767; x=1680220767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xDiY3qrnd7xaoxw2WzBxOs8cD6l8Jpg0xGAEfqiZX2g=;
  b=D6C5RJVmBEOQ7vMHkBMZcC7tHhrkJiKAwOTu0OdVNZ4yQPmue3Smuqhr
   5IQTCr4Sn2BqfwdwUJKFbMO4EzCL6/MSKTtT71EZEyhrs6VUKHzbqEu0J
   LkJiLZy6Vt1Q+o+krzBaY7tsblxwCVbJRVFX8fYx01BOdXEzov2MZKDUf
   SBifKa75uDHZcMCZpiS68NwK7jz7M6MI2b30tuBdMMPJXpZ/JFwlxkVFr
   j18ImsmAj71J54vBs93F6Yri4qeOq0oWdIgTBWNsmd7TEybZutVfC+bd6
   /DAeKITHYjOlwwH01CFPiYzYP3jlPpwzSsHjiGX+HXTq6Z3Yg58WVCqpg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="258504748"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="258504748"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 16:59:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="654212645"
Received: from npeper-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.16.15])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 16:59:25 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V7 02/10] PCI: Replace magic constant for PCI Sig Vendor ID
Date:   Wed, 30 Mar 2022 16:59:12 -0700
Message-Id: <20220330235920.2800929-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330235920.2800929-1-ira.weiny@intel.com>
References: <20220330235920.2800929-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Replace the magic value in pci_bus_crs_vendor_id() with
PCI_VENDOR_ID_PCI_SIG.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V6
	Simplify commit message
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 17a969942d37..6280e780a48c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2312,7 +2312,7 @@ EXPORT_SYMBOL(pci_alloc_dev);
 
 static bool pci_bus_crs_vendor_id(u32 l)
 {
-	return (l & 0xffff) == 0x0001;
+	return (l & 0xffff) == PCI_VENDOR_ID_PCI_SIG;
 }
 
 static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
-- 
2.35.1

