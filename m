Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8D27A4079
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 07:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239637AbjIRFbT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Sep 2023 01:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239665AbjIRFau (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 01:30:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB9311C
        for <linux-pci@vger.kernel.org>; Sun, 17 Sep 2023 22:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695015045; x=1726551045;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aqvFkjDrEun0ME8P5iXzxGrqFE0/uBhcHfbJBURGMl4=;
  b=KxHmUUSBDxT0gWYfbABAMSIBxvE1cMFz9A3J9EJSXA2CyucBSZ+bd2UJ
   gJ/STIIIgGDDAp2qjywI34j+57KpXvkwgSptuVGhfIGfrWcoNzzg35D+0
   Fgodp0Tq3tFzhoaWVfK57O+VPK3xN6MVtS6wzZpcAFEHczRoClGGY+Udd
   QmSrY4CYMr0usVoeQJzjY9zopnxeqkEPnMAE7JNjCTdp4OcFprlI+a8gX
   ik0MRNVXevTMtIpGapaS6L1GIPvXRtEjK1KAov1/N1UW++3WtorMKdXsu
   y0vQzEYyeU4YNW0LfPpXEgkN8OYnjpd4ZmdxGZd3EVoVfuW5+RxnzUHG9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378480435"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="378480435"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 22:30:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="869431376"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="869431376"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 17 Sep 2023 22:30:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A8B0E18E; Mon, 18 Sep 2023 08:30:41 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Mark Blakeney <mark.blakeney@bullet-systems.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI/PM: Mark devices disconnected if their upstream PCIe link is down on resume
Date:   Mon, 18 Sep 2023 08:30:41 +0300
Message-Id: <20230918053041.1018876-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Mark Blakeney reported that when suspending system with a Thunderbolt
dock connected and then unplugging the dock before resume (which is
pretty normal flow with laptops), resuming takes long time.

What happens is that the PCIe link from the root port to the PCIe switch
inside the Thunderbolt device does not train (as expected, the link is
upplugged):

[   34.903158] pcieport 0000:00:07.2: restoring config space at offset 0x24 (was 0x3bf12001, writing 0x3bf12001)
[   34.903231] pcieport 0000:00:07.0: waiting 100 ms for downstream link
[   36.140616] pcieport 0000:01:00.0: not ready 1023ms after resume; giving up

However, at this point we still try the resume the devices below that
unplugged link:

[   36.140741] pcieport 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible
...
[   36.142235] pcieport 0000:01:00.0: restoring config space at offset 0x38 (was 0xffffffff, writing 0x0)
...
[   36.144702] pcieport 0000:02:02.0: waiting 100 ms for downstream link, after activation

And this is the link from PCIe switch downstream port to the xHCI on the
dock:

[   38.380618] xhci_hcd 0000:03:00.0: not ready 1023ms after resume; waiting
[   39.420587] xhci_hcd 0000:03:00.0: not ready 2047ms after resume; waiting
[   41.527250] xhci_hcd 0000:03:00.0: not ready 4095ms after resume; waiting
[   45.793957] xhci_hcd 0000:03:00.0: not ready 8191ms after resume; waiting
[   54.113950] xhci_hcd 0000:03:00.0: not ready 16383ms after resume; waiting
[   71.180576] xhci_hcd 0000:03:00.0: not ready 32767ms after resume; waiting
...
[  105.313963] xhci_hcd 0000:03:00.0: not ready 65535ms after resume; giving up
[  105.314037] xhci_hcd 0000:03:00.0: Unable to change power state from D3cold to D0, device inaccessible
[  105.315640] xhci_hcd 0000:03:00.0: restoring config space at offset 0x3c (was 0xffffffff, writing 0x1ff)
...

This ends up slowing down the resume time considerably. For this reason
mark these devices as disconnected if the link above them did not train
properly.

Fixes: e8b908146d44 ("PCI/PM: Increase wait time after resume")
Reported-by: Mark Blakeney <mark.blakeney@bullet-systems.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217915
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci-driver.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index a79c110c7e51..51ec9e7e784f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -572,7 +572,19 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 
 static void pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
 {
-	pci_bridge_wait_for_secondary_bus(pci_dev, "resume");
+	int ret;
+
+	ret = pci_bridge_wait_for_secondary_bus(pci_dev, "resume");
+	if (ret) {
+		/*
+		 * The downstream link failed to come up, so mark the
+		 * devices below as disconnected to make sure we don't
+		 * attempt to resume them.
+		 */
+		pci_walk_bus(pci_dev->subordinate, pci_dev_set_disconnected,
+			     NULL);
+		return;
+	}
 
 	/*
 	 * When powering on a bridge from D3cold, the whole hierarchy may be
-- 
2.40.1

