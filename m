Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6433056736C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 17:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiGEPvI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 11:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiGEPuw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 11:50:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8B4114E;
        Tue,  5 Jul 2022 08:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657036188; x=1688572188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HCbJLPfxlxI92iZKFv4/AkOuve50aUnNogOmoa9pIRI=;
  b=aeEiI36pMDLMHq3xYXcvE89fiRE3zHZU7PvBHTBfWbq79/L2qNDpvB7L
   hiyMuMywb1CaWtfZP5s6RwfbnuZpGGHSpYBPKPcJyHRkdqg22N8iluosi
   AkdnadQJ207qTbYtI8OTLYBJGSlehfhkXtVdtBNb7Z9Cr2oLFCpb9Lvbz
   vrkeMIOpDQXFhfTZyWPvKoK8iyGsNM0SuN9ayRdJfJkAY9UArbVWhlKIJ
   i9j3FtalzFN8EkHzq/S/ZkZENHNJ/ZumFB0dI1qwHU2OB1halVek7+HFd
   zN1LGhQMzVM55WIP0gkv0dqaZ0y5E0PMqImny7k1mQknjDwGJw8zypPsi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="347369947"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="347369947"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 08:49:47 -0700
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="695708965"
Received: from amangla-mobl.amr.corp.intel.com (HELO localhost) ([10.255.0.184])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 08:49:45 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V13 2/9] PCI: Replace magic constant for PCI Sig Vendor ID
Date:   Tue,  5 Jul 2022 08:49:25 -0700
Message-Id: <20220705154932.2141021-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220705154932.2141021-1-ira.weiny@intel.com>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
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
2.35.3

