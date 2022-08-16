Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253075958DE
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 12:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbiHPKsn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 06:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbiHPKsN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 06:48:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642D2B5E6A
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 03:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660644451; x=1692180451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eKdwuHUEQ5iHdLeGzFWnZZ5OboFsdjjgUwuIZdCP/JM=;
  b=fnRoeZI1CDq9YsR/mhfKtNCC8LBwgttRnvZ0Gg/m56DLjYWuK3Mp7DSK
   kVkwFU5EbOTWrK+H5WWnytFX1ojc18bLiLmID7vUtDKmTeueL92CJuH4b
   ZeWqxbtg9Xc93EeEaxh8zWquZi/bprFADLcCwf7rke+T6SeL3taVgevF0
   KkclNJxvbf/ZgOMMgRxtNBEWi4BNq8EmUS+/ABSqHYjC5GRohP7gTYGww
   UeEzjlMqWcW3T1sRaFLrRKySMdJY3Ier1n8kiZ5KQNkyCFDl+hmkzE2Up
   zMXsm//rM/SmgBwpZrmVojOz+7aFpKcmoYj55T1NINmUAPqKsY3ZrvdhI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="318171486"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="318171486"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 03:07:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="852588681"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2022 03:07:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 398A7363; Tue, 16 Aug 2022 13:07:41 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 4/6] PCI: Remove two unnecessary empty lines in pci_scan_child_bus_extend()
Date:   Tue, 16 Aug 2022 13:07:38 +0300
Message-Id: <20220816100740.68667-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220816100740.68667-1-mika.westerberg@linux.intel.com>
References: <20220816100740.68667-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These are not needed and are against the normal coding style anyway.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/probe.c | 2 --
 1 file changed, 2 deletions(-)

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
-- 
2.35.1

