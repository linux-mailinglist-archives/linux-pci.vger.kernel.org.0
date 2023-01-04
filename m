Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560EC65CF4D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 10:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbjADJQJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 04:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjADJQJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 04:16:09 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A01167C9
        for <linux-pci@vger.kernel.org>; Wed,  4 Jan 2023 01:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672823767; x=1704359767;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kRdYd1BBUDFRXpS8n225Vc+pQfnBq+ne5kGQHwXdAX0=;
  b=IW09PNYy0PrQfoOw1e+Bi2zm1Mx3+R6eRIvzPDX/SnP4oz/K6ovnBiDw
   o7rQzwy/aX9LBNTVPHYF9FhcWQwS+jPjeHoTNs5akoiTsIGQf0IWvtMUj
   Y5XTHdPYSpufrBjYaq/Hg32m74SRuFYAS7Bh3cZQke/m+1OoSImlFFmNm
   +zBqEA+LBVTDHjnsetOhV3cTdhlTIm/Awuv7qS8+OB+a+QXL9kZH8qo7r
   nvp+tQoaHcuD6PQySEqyyywuHq0QWGRsPvS4WzGjVxe2sNjabgEoZE1RC
   3IAzz4QFzYq1Rcmj673zrOCcxQ5fzvylsN1N71JNsRZLbaqD6s8XKLg5z
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="301578364"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="301578364"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 01:16:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="723580078"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="723580078"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jan 2023 01:16:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1CB1219E; Wed,  4 Jan 2023 11:16:35 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Alexander Motin <mav@ixsystems.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v4 0/2] PCI: distribute resources for root buses
Date:   Wed,  4 Jan 2023 11:16:33 +0200
Message-Id: <20230104091635.63331-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

This is fourth iteration of the patch series trying to solve the problem
reported by Chris Chiu [1]. In summary the current resource distribution
code does not cover the initial device enumeration so if we find
unconfigured bridges they get the bare minimum.

In addition to that it turned out the current resource distribution code
does not take into account possible multifunction devices and/or other
devices on the bus. The patch 1/2 tries to make it more generic. I've
tested it on QEMU following the topology Jonathan is using and also in a
a couple of systems with Thunderbolt controller and complex topologies
to make sure it still keeps working.

The previous versions of the series can be found:

v3: https://lore.kernel.org/linux-pci/20221130112221.66612-1-mika.westerberg@linux.intel.com/

v2: https://lore.kernel.org/linux-pci/20221114115953.40236-1-mika.westerberg@linux.intel.com/
v1: https://lore.kernel.org/linux-pci/20221103103254.30497-1-mika.westerberg@linux.intel.com/

Changes from v3:
  * Make it more generic and not depend on how many bridges there are
    on the bus.

Changes from v2:
  * Make both patches to work with PCI devices too (do not expect that
    the bridge is always first device on the bus).
  * Allow distribution with bridges that do not have all resource
    windows programmed (therefore the patch 2/2 is not revert anymore)
  * I did not add the tags from Rafael and Jonathan because the code is
    not exactly the same anymore so was not sure if they still apply.

Changes from v1:
  * Re-worded the commit message to hopefully explain the problem better
  * Added Link: to the bug report
  * Update the comment according to Bjorn's suggestion
  * Dropped the ->multifunction check
  * Use %#llx in log format.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=216000

Mika Westerberg (2):
  PCI: Take other bus devices into account when distributing resources
  PCI: Distribute available resources for root buses too

 drivers/pci/setup-bus.c | 262 ++++++++++++++++++++++++++++------------
 1 file changed, 185 insertions(+), 77 deletions(-)

-- 
2.35.1

