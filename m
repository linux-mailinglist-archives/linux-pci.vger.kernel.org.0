Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4ED5ACD5A
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 10:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbiIEICl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 04:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiIEICk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 04:02:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35497481F6
        for <linux-pci@vger.kernel.org>; Mon,  5 Sep 2022 01:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662364955; x=1693900955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FRwp+3CRTkktgv/rN1m0VJyXATMdwlWHICXW1mZNDWM=;
  b=Ivk5z7bKb3QX8FKfQuKvruaIjm/mLNrUiPMvPmUsw1SjL0t1d/2lnLhR
   qFqBZcTv8QOc7BUEoiYGNkv8+1qTz7cX68R1zmF0aaBb7TZ7/gD/ojmH2
   d7ZAEBLT+7SVmKXIB0pbJmAzxkU6d+1WqqfVSyECiCQZmFYh69mmEsmpn
   6pe2jTEvwVY0ceMf0SrdEjSUklTFnTQl079OQEUvPXhBFS3CUpq4YJ9Hf
   4yYvwd5z9CFSCc8BS350vjnoieuxwiCKcH3OmCDXHikUkBhyTv+YjyFf8
   +91omWNL/QMhDkoP4zOPipGG0P/WaTI2NXKxsHNufKe1xYi9HuNvWOxY8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="276727933"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="276727933"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 01:02:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="609602287"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 05 Sep 2022 01:02:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id DB84249F; Mon,  5 Sep 2022 11:02:32 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 5/6] PCI: Fix whitespace and indentation
Date:   Mon,  5 Sep 2022 11:02:31 +0300
Message-Id: <20220905080232.36087-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220905080232.36087-1-mika.westerberg@linux.intel.com>
References: <20220905080232.36087-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Drop two empty lines from pci_scan_child_bus_extend() and correct
indentation in pci_bridge_distribute_available_resources() to better
follow the kernel coding style.

No functional impact.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/probe.c     | 2 --
 drivers/pci/setup-bus.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 86130926a74f..8f25deb6b763 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2930,7 +2930,6 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 		unsigned int buses = 0;
 
 		if (!hotplug_bridges && normal_bridges == 1) {
-
 			/*
 			 * There is only one bridge on the bus (upstream
 			 * port) so it gets all available buses which it
@@ -2939,7 +2938,6 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 			 */
 			buses = available_buses;
 		} else if (dev->is_hotplug_bridge) {
-
 			/*
 			 * Distribute the extra buses between hotplug
 			 * bridges if any.
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index df9fc974b313..dc6a30ee6edf 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1919,7 +1919,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 }
 
 static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
-						     struct list_head *add_list)
+						      struct list_head *add_list)
 {
 	struct resource available_io, available_mmio, available_mmio_pref;
 
-- 
2.35.1

