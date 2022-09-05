Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811DF5ACD63
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 10:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbiIEIC0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 04:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbiIEICV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 04:02:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E202147BA6
        for <linux-pci@vger.kernel.org>; Mon,  5 Sep 2022 01:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662364940; x=1693900940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8wVco/wdG7EgUjSVCRzc0dXokxEcp15Q0CTnYAutJkk=;
  b=ZZrq2P0To8/6/33ccLKGYeKOLSbqZ/t9Co0lU+qljx357Xm8VRtUg6yk
   LO24sRDYsHFREu0iQ0zZH9w0NalSoQwr5/g2RNWSEJ4Ybgud/ry6B4Lmu
   dvaUCsNftRHx7sog1P/vt+omHMPgBOSB4bCkYX0nZZSjPf9P/jWWSepUv
   rehBfYB9rNm5Hc8yE13aI2+OJSYU5LYCEZMeqahJimOlfcAJVJagZ07j1
   HhcXYGn9Vm0PDpvka5rDS74/zr1azPeX6R7RsSOtrX9OrJDvJdnifgnZu
   bb2me49jlJSVTlFBsUw7dpm8bhbkj9R00TkPyWD8uAopeiSjnW0Ddqk/2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="295073107"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="295073107"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 01:02:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="643709849"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 05 Sep 2022 01:02:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id BA34C86; Mon,  5 Sep 2022 11:02:32 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 1/6] PCI: Fix used_buses calculation in pci_scan_child_bus_extend()
Date:   Mon,  5 Sep 2022 11:02:27 +0300
Message-Id: <20220905080232.36087-2-mika.westerberg@linux.intel.com>
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

The 'cmax' and 'max' are in wrong order and that might cause the
used_buses to become negative in certain cases. It should be the same as
we do in the block following this one. Fix this.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216000
Fixes: 3374c545c27c ("PCI: Account for all bridges on bus when distributing bus numbers")
Reported-by: Chris Chiu <chris.chiu@canonical.com>
Tested-by: Chris Chiu <chris.chiu@canonical.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

