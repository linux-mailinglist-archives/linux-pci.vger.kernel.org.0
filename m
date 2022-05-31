Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949145393F0
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 17:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345668AbiEaP1B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 11:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345659AbiEaP07 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 11:26:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEDB2C133;
        Tue, 31 May 2022 08:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654010817; x=1685546817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xDiY3qrnd7xaoxw2WzBxOs8cD6l8Jpg0xGAEfqiZX2g=;
  b=gD7Z8//cNtzzG1pjn6BYr0xplyTn/WmKdjlXygr9XrUIk1ZvIXVTHtlI
   5QylHN3yzflrWaUDLz7uF5Zp+CzuDMGTlEmqAXYdmacqJnbwEZJaSY/Pv
   tC5/L3WukGq9NIKYDeT2sI+ezV2ungBBPRuudrI2V9sY0IyRyZt2mZ2px
   K/jZe1wBaRaLGeHwbvekvz8Uk1VE8qlKUc6CnGaEI+0CeyeK+HZXRjklv
   EzgR7sAaEfuG0T0aoRF+Nu4X7w9h2GgfFmbCqbKcn9c0vVGlQbqp45ik7
   8x9q5PWIxYH4biGYbXpMFZz0FLsCCkoX01NIaUCwZjEZ/lJOjZkxaPrHM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="338332343"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="338332343"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 08:26:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="666970426"
Received: from mdossant-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.154.135])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 08:26:54 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben@bwidawsk.net>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH V9 2/9] PCI: Replace magic constant for PCI Sig Vendor ID
Date:   Tue, 31 May 2022 08:26:25 -0700
Message-Id: <20220531152632.1397976-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220531152632.1397976-1-ira.weiny@intel.com>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
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

