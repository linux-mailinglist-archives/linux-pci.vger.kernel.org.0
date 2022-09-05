Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149745ACD62
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 10:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbiIEICX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 04:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbiIEICU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 04:02:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C20474C0
        for <linux-pci@vger.kernel.org>; Mon,  5 Sep 2022 01:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662364939; x=1693900939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yUt7kimyDFp5iQ4HRnFUbUhLnRJMHEXFpKLhta7edCE=;
  b=Akl7UdUb78Q9lljFRseVTtrtvl5qArNzs6ETOZzeZpM5FzlMX7Wp7x3j
   2KNBlLUgdi23A91m7EjxhQ8NRIMbi0dKiVdRSAh3vTpP0+7jUT3rPToAb
   mRIYFifQDOFVvDb3DjbB8Th1rlkMhCKx3gMYVw+wV4k4rVROqXBjLNQCP
   QEGbzQvzqEB9raabAbI+OMA+tjmlN5MZQZGoiDqf+cAm0uzGbRBR2R2U1
   Aypz8BkqN25P+TfcXmzdq1/4caixW6rdlZy6cUg03nT5wNEHj++phkEjE
   46C6UQWRETRSrPyTbDf+pYxXEoWSW+v4bkbW+w8KxQhYqltw/TVnIM2DH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="295073103"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="295073103"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 01:02:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="590825806"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 05 Sep 2022 01:02:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C3ED71C3; Mon,  5 Sep 2022 11:02:32 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 2/6] PCI: Pass available buses also when the bridge is already configured
Date:   Mon,  5 Sep 2022 11:02:28 +0300
Message-Id: <20220905080232.36087-3-mika.westerberg@linux.intel.com>
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

If some part of the PCI topology is already configured (by the boot
firmware) but not all, and it includes hotplug bridges, we may need to
extend the bus resources of those bridges to accommondate any future
hotplugs too - in the same way we already do with normal hotplug case.

For this reason pass the available busses to pci_scan_child_bus_extend()
even when the bridge in question is already configured. This allows the
bus allocation code to use these available buses to extend the possible
hotplug bridges below.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216000
Reported-by: Chris Chiu <chris.chiu@canonical.com>
Tested-by: Chris Chiu <chris.chiu@canonical.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/probe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4f940dcd102c..86130926a74f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1297,7 +1297,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 
 	if ((secondary || subordinate) && !pcibios_assign_all_busses() &&
 	    !is_cardbus && !broken) {
-		unsigned int cmax;
+		unsigned int cmax, buses;
 
 		/*
 		 * Bus already configured by firmware, process it in the
@@ -1322,7 +1322,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			child->bridge_ctl = bctl;
 		}
 
-		cmax = pci_scan_child_bus(child);
+		buses = subordinate - secondary;
+		cmax = pci_scan_child_bus_extend(child, buses);
 		if (cmax > subordinate)
 			pci_warn(dev, "bridge has subordinate %02x but max busn %02x\n",
 				 subordinate, cmax);
-- 
2.35.1

