Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24466828A4
	for <lists+linux-pci@lfdr.de>; Tue, 31 Jan 2023 10:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjAaJXn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 04:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjAaJXm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 04:23:42 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29563C2E
        for <linux-pci@vger.kernel.org>; Tue, 31 Jan 2023 01:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675157021; x=1706693021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RUPquBocq24xxLJzGXRGDEouk9lpxcHaefiLGTyQD6s=;
  b=GotIjND7uIFN+RGqpX3JxKZPkhgrxPu3agUWHtKUJbWcloDbwsaBuZmM
   BcIBgFASnrfq5Z+veTq9aBx+GSvem+eATgYWqZfyHkfbBeGgTpv+/XEdf
   kXStAMi0Bbc3OI6FZP0mcGIainMT4us1nG0oAmQTA4FEralBBXANfgT2u
   5gUFSSf183n8pmxjPB4GOS8GEFBdsmtD00PaP82nsToQQn0DP7ypzVxiV
   /olH+jjw/r2F1YnDuRN+EN56lLfRBGTx1H9ijGUk6MyxYhCL29tQqkTUM
   PwDCRlv6i10k4dBx9MyVek0Nqbe0hSuNgVtfTnssQiyCY9iTROL9a2wk6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="390155447"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="390155447"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 01:23:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="753168306"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="753168306"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jan 2023 01:23:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3BEBE1A5; Tue, 31 Jan 2023 11:24:06 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Alexander Motin <mav@ixsystems.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v6 1/3] PCI: Align extra resources for hotplug bridges properly
Date:   Tue, 31 Jan 2023 11:24:03 +0200
Message-Id: <20230131092405.29121-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230131092405.29121-1-mika.westerberg@linux.intel.com>
References: <20230131092405.29121-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After division the extra resource space per hotplug bridge may not be
aligned according to the window alignment so do that before passing it
down for further distribution.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b4096598dbcb..e440f264accb 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1891,6 +1891,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	 * resource space between hotplug bridges.
 	 */
 	for_each_pci_bridge(dev, bus) {
+		struct resource *res;
 		struct pci_bus *b;
 
 		b = dev->subordinate;
@@ -1902,16 +1903,28 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 		 * hotplug-capable downstream ports taking alignment into
 		 * account.
 		 */
-		io.end = io.start + io_per_hp - 1;
-		mmio.end = mmio.start + mmio_per_hp - 1;
-		mmio_pref.end = mmio_pref.start + mmio_pref_per_hp - 1;
+		res = &dev->resource[PCI_BRIDGE_IO_WINDOW];
+		align = pci_resource_alignment(dev, res);
+		io.end = align ? io.start + ALIGN_DOWN(io_per_hp, align) - 1
+			       : io.start + io_per_hp - 1;
+
+		res = &dev->resource[PCI_BRIDGE_MEM_WINDOW];
+		align = pci_resource_alignment(dev, res);
+		mmio.end = align ? mmio.start + ALIGN_DOWN(mmio_per_hp, align) - 1
+				 : mmio.start + mmio_per_hp - 1;
+
+		res = &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
+		align = pci_resource_alignment(dev, res);
+		mmio_pref.end = align ? mmio_pref.start +
+					ALIGN_DOWN(mmio_pref_per_hp, align) - 1
+				      : mmio_pref.start + mmio_pref_per_hp - 1;
 
 		pci_bus_distribute_available_resources(b, add_list, io, mmio,
 						       mmio_pref);
 
-		io.start += io_per_hp;
-		mmio.start += mmio_per_hp;
-		mmio_pref.start += mmio_pref_per_hp;
+		io.start += io.end + 1;
+		mmio.start += mmio.end + 1;
+		mmio_pref.start += mmio_pref.end + 1;
 	}
 }
 
-- 
2.39.0

