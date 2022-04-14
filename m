Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40020501CD3
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 22:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346438AbiDNUfV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 16:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346408AbiDNUfT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 16:35:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E51AB6D0B;
        Thu, 14 Apr 2022 13:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649968373; x=1681504373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3gyDazsOshz3oeahlbhDyK1bPrO6GOsAq/G6LeDMe1I=;
  b=iJGXarbHBpiEHpqNLg7NoYgFfdAf3KbDEA/aYPRfeKSCwonfvMPqt4b7
   8w1ks/j+mpqyo6k4miziuq8d3chc8yE9EDnPgo+ao+7TdMahpLk0Z0YxC
   l63jEq0ADgNxW3VGCZqi+RWFewq/PPXytoaKABQ8oeqh+V/wm3ZMW+t5x
   KaLYjQz4emiODgYk/SV7Dk0AchIVTHYvdecMs9YEkcXXCAlRRusMEqRS6
   KOD219fxf5BRXG1zsDo/Ycmm4KB/VBUV4qHUB/82MLNvXjbf6KGnoIaq+
   u0xUKi+AfsomVp5eTli6JaTXmElTRYgLoDAFvBb72cP7wElxXjiQHwZZ3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="323468891"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="323468891"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 13:32:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="656144408"
Received: from aimeehax-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.113.132])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 13:32:43 -0700
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
Subject: [PATCH V8 01/10] PCI: Add vendor ID for the PCI SIG
Date:   Thu, 14 Apr 2022 13:32:28 -0700
Message-Id: <20220414203237.2198665-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414203237.2198665-1-ira.weiny@intel.com>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
2.35.1

