Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E875958DD
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 12:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbiHPKsm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 06:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiHPKsM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 06:48:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1297B56F3
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 03:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660644450; x=1692180450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PVlToHjzUmkOUyIQDLygwOdsJ9kHXBehWSrPCXAaSw0=;
  b=I00YbTDRO+SsWg1q1eKblZVFE9DJLcXOaJKFK7jHkBXhLryAKdH/JI3z
   UKLgHymoyO3hv+mEC2+oDBYXOmh1NozRKaIy/8G+y4Z/f+ZRIytpokidk
   90yuRrPQSDGxWcdYPj6k6MMI6I1bwRE4g7JKC0fzh+ubHvkZ+WcpD75X/
   ImprqB/UTqBJsRI/nfLtxEuYcHPt3Ordvpg3D43yV2bJKccx+lBVXMXDY
   3megb/A8RA9dwe0rmHgolpsxbjJ//YDGPeksyoz3gMuFnIVv00ANel2Bg
   7teZVpEtaTLoKJoUlkBnQMtH0WPeSNVdqu8wAipfkiUZyvMawOk5VXlly
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="292175643"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="292175643"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 03:07:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="782969817"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 16 Aug 2022 03:07:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1C94A235; Tue, 16 Aug 2022 13:07:41 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/6] PCI: Fix used_buses calculation in pci_scan_child_bus_extend()
Date:   Tue, 16 Aug 2022 13:07:35 +0300
Message-Id: <20220816100740.68667-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220816100740.68667-1-mika.westerberg@linux.intel.com>
References: <20220816100740.68667-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The 'cmax' and 'max' are in wrong order and that might cause the
used_buses to become negative in certain cases. It should be the same as
we do in the block following this one. Fix this.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216000
Fixes: 3374c545c27c ("PCI: Account for all bridges on bus when distributing bus numbers")
Reported-by: Chris Chiu <chris.chiu@canonical.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/probe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c5286b027f00..4f940dcd102c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2920,8 +2920,8 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 		 * hotplug bridges too much during the second scan below.
 		 */
 		used_buses++;
-		if (cmax - max > 1)
-			used_buses += cmax - max - 1;
+		if (max - cmax > 1)
+			used_buses += max - cmax - 1;
 	}
 
 	/* Scan bridges that need to be reconfigured */
-- 
2.35.1

