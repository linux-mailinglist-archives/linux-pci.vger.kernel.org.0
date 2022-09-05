Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607115ACD5D
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 10:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbiIEIC1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 04:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbiIEICY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 04:02:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E1646DAD
        for <linux-pci@vger.kernel.org>; Mon,  5 Sep 2022 01:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662364942; x=1693900942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xCq71ILO/+9H+27+C5zeVh+nJ6cK6g+cPM0DPH8ZZt0=;
  b=Vr3ne4/9caTocn0TTLLyJzovg5+aZVd0Gbct4TeyV2REiZGfgPIYhkC2
   H7Uz2QYdk9ZRcfG1PJ9VGplCUJyhELSvVjfqywiYWwY/zIRaMhPang/ab
   /iIcmPRAxPtrcHjRrMzpqvasUOWfmA1GAb6F1XsXrz0xfBeF7mvz0VL0D
   x/73zjguXM6lwbcSZWliUxDATwCRKwD2sAFRYWQbePN9LqPp+RrIppRnc
   dsSzZvyM9smDYzo93nZO1DWVd4+OYs574jko51V/XiwP+0FWmuMW6IS18
   WLf31U+SLodJjM7SOmGsZASrpLiZK9vwYu5WPYiCiczMzHFAEoAZQ41YC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="283328134"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="283328134"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 01:02:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="564666880"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 05 Sep 2022 01:02:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E133919D; Mon,  5 Sep 2022 11:02:32 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 6/6] PCI: Fix typo in pci_scan_child_bus_extend()
Date:   Mon,  5 Sep 2022 11:02:32 +0300
Message-Id: <20220905080232.36087-7-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220905080232.36087-1-mika.westerberg@linux.intel.com>
References: <20220905080232.36087-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Should be 'if' not 'of'. Fix this.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8f25deb6b763..b66fa42c4b1f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2956,7 +2956,7 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 	/*
 	 * Make sure a hotplug bridge has at least the minimum requested
 	 * number of buses but allow it to grow up to the maximum available
-	 * bus number of there is room.
+	 * bus number if there is room.
 	 */
 	if (bus->self && bus->self->is_hotplug_bridge) {
 		used_buses = max_t(unsigned int, available_buses,
-- 
2.35.1

