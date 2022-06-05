Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A992B53D8F3
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jun 2022 02:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242660AbiFEAvL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Jun 2022 20:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242616AbiFEAvK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Jun 2022 20:51:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671EC4C42B;
        Sat,  4 Jun 2022 17:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654390269; x=1685926269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YOLrU6oAOg72IT0OHJ1sHPJvFSb4p5oL2hmN5FpFHko=;
  b=LLapVbvS6fmf/yyMpR4EclU/8Au7qFsgMkHJp7XdbmpaRGAlPBlCiNGB
   CXz+x3un9tJEchLomG8VJvc4fjb5/H248eAqhuKubMLg3MxqejgFQrLsI
   +LwmStXJYfC236BZ5MYJ8Q+n/QQM3sR0fmEc069MUOFGfsY9uOnfhWrR1
   CB/knnzRKmYw1rlB7yibHdigyU8mAPWJXVqSN4U8xWlNiGhuJCD03YOfO
   tG0BFKbmSy8GYkRuvosqNLYG2WtoU9piFc3Gf2LQR80oafZqVtXXkoKas
   vEqeKojtKdF9A5qOsebWPaz25CkS1HCciTGXhm2tiBW5I3rDWKuFS2M6Q
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="256360514"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="256360514"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 17:51:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="564326339"
Received: from aftome-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.107.207])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 17:51:08 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben@bwidawsk.net>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH V10 2/9] PCI: Replace magic constant for PCI Sig Vendor ID
Date:   Sat,  4 Jun 2022 17:50:42 -0700
Message-Id: <20220605005049.2155874-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220605005049.2155874-1-ira.weiny@intel.com>
References: <20220605005049.2155874-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
2.35.1

