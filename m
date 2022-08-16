Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093F65958E2
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 12:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiHPKst (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 06:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiHPKsX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 06:48:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29461BA160
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 03:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660644453; x=1692180453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K5UNXhzXw1ZtirG/F3j1naO3htxk4w0EKIpItJ4JuUY=;
  b=WAG8RbuRyAkAGuEai3Q05Zlpx31hsqC39BxNIglhHJFVtnHlpN6+Hid/
   yvcHjfbuJClbx1+BlLjjYodWDuBs6vf74Mrzdwtvg5DmwiWe77iqV0y5Q
   gsGYQR3CfgVdJUJ7wbxMCC5tK0frOviRjwy1qT1ckj2JpunBfBVrc6cRR
   izUcOGoX0Gto05IKJWEsihwTYlTQChevEczA8yTW/P34mgrwx/f9zc0O9
   VJdQ/5xBRaEzOvxMANo1UQ50O5G7rBw07UyeycnG1u7zwg6YmBuTPMsEN
   dzNjq9SpI2I5T2qzpMkwc1dpn4MVMvsEIdffhxxQsaMQCBhqHckjAc0Zp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="292974309"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="292974309"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 03:07:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="710082641"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2022 03:07:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 42C5345C; Tue, 16 Aug 2022 13:07:41 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 5/6] PCI: Fix typo in pci_scan_child_bus_extend()
Date:   Tue, 16 Aug 2022 13:07:39 +0300
Message-Id: <20220816100740.68667-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220816100740.68667-1-mika.westerberg@linux.intel.com>
References: <20220816100740.68667-1-mika.westerberg@linux.intel.com>
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

