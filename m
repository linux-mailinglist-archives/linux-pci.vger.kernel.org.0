Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515EE6828A2
	for <lists+linux-pci@lfdr.de>; Tue, 31 Jan 2023 10:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjAaJXe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 04:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjAaJXd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 04:23:33 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A1C106
        for <linux-pci@vger.kernel.org>; Tue, 31 Jan 2023 01:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675157012; x=1706693012;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DFkIuk0m6+NxTr9XFzFZ1FBUkpJZdqeANpIb1yG6xkg=;
  b=LKq4yKIyUNqUqDHFiCsjt81N7DJD5e2L1CT2mzdMZ84DfuGoPfFqlBCe
   97xJmPZqty2q2slTATFL4TfOhXtr/dJwd5dcOln7bSIip0T0O+WZKhGny
   VIV/MtkmTAtyTUJqmvvwPu31tz52VAs8Me/daSbYNHZSNAdUz2cd6oo/2
   pSqfUIdh+EMVqV568kHmbSrOMeVfy6CTFN+HJP6TsDxPNUtjnlRGf7EFl
   MgRcW7Smul6OZu9mO5VQL9qDPqMe5Uclbo7HdIMCPFE9i3EDS524pwpbb
   yserFtdNabGZ+FlT8EA+g4DtiSCU1eY9hxEpHO7eR/XWHFUtqEqoJQ1Lr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="326456615"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="326456615"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 01:23:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="807035713"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="807035713"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2023 01:23:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2BB9823A; Tue, 31 Jan 2023 11:24:05 +0200 (EET)
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
Subject: [PATCH v6 0/3] PCI: distribute resources for root buses
Date:   Tue, 31 Jan 2023 11:24:02 +0200
Message-Id: <20230131092405.29121-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.39.0
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

Hi all,

This is sixth iteration of the patch series trying to solve the problem
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

v5: https://lore.kernel.org/linux-pci/20230112110000.59974-1-mika.westerberg@linux.intel.com/
v4: https://lore.kernel.org/linux-pci/20230104091635.63331-1-mika.westerberg@linux.intel.com/
v3: https://lore.kernel.org/linux-pci/20221130112221.66612-1-mika.westerberg@linux.intel.com/
v2: https://lore.kernel.org/linux-pci/20221114115953.40236-1-mika.westerberg@linux.intel.com/
v1: https://lore.kernel.org/linux-pci/20221103103254.30497-1-mika.westerberg@linux.intel.com/

Changes from v5:
  * Correct typo in mmio calculation (io_per_hp -> mmio_per_hp)
  * Add missing -1 to the mmio_pref end when align == 0.

Changes from v4:
  * Split the alignment fix into separate patch
  * Create helper for removing resources
  * Skip VF BARs when removing
  * Add check for 32-bit/64-bit prefetchable resource so that we account
    them correctly.
  * Update comments and commit log slightly according to review
    comments.
  * Did not add the "lookup for hotplug bridges below non-hotplug ones".
    It turned out to be non-trivial. The current code works for the
    "common" case of Thunderbolt/USB4 PCIe switches but we may need to
    revisit this if there is a real need.

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

Mika Westerberg (3):
  PCI: Align extra resources for hotplug bridges properly
  PCI: Take other bus devices into account when distributing resources
  PCI: Distribute available resources for root buses too

 drivers/pci/setup-bus.c | 232 ++++++++++++++++++++++++++++------------
 1 file changed, 166 insertions(+), 66 deletions(-)

-- 
2.39.0

