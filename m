Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67505958DF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 12:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbiHPKsr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 06:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbiHPKsW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 06:48:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85129B95AD
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 03:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660644452; x=1692180452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8sJn5Wuc4HEXnk04lBc87C+RBz30csC0Dle0JOGbx7o=;
  b=FPx+lx6owyFtnhTkhx3SPjmHCc0C3fJ9usynLHNWuzcCzh9D5oypA+j/
   hQ2UI6/WTRmWYxxniefhjN147qdhaOKOJFb54SVl/jpSp5mX0sibBPlY8
   I7iy3t3o2SO/I5c19Yhj7SzYYXmEQJWVbpi4MBTmTyzCaluqSvstTpj49
   vJ3d5QdBc9XeDFxMKOiIxkLkbXrM/9QSJGjJ0z7rS+IKi19ug7uV8dG4j
   Zy/cdEQK1/Rq4nHhSCc6L/K9Dr17lZJFI4SxkD+rmufh6aLAppa1H+rvQ
   fRndwm2AF69XJ14wd52Wi0S3rQDrsJuE0JDzbZBrcY3ze0RHtbGHYzlGU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="318171489"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="318171489"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 03:07:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="675157369"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 16 Aug 2022 03:07:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2676B2F6; Tue, 16 Aug 2022 13:07:41 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 2/6] PCI: Pass available buses also when the bridge is already configured
Date:   Tue, 16 Aug 2022 13:07:36 +0300
Message-Id: <20220816100740.68667-3-mika.westerberg@linux.intel.com>
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

