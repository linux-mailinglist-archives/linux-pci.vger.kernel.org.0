Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C10D6E5A6E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 09:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjDRH2K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 03:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDRH2J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 03:28:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB0E3C1F
        for <linux-pci@vger.kernel.org>; Tue, 18 Apr 2023 00:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681802888; x=1713338888;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b5gj58pMOlqOT9oLBDkubw2YtCIe8cU168OegQgmkUU=;
  b=Yd6IfFuewKGDze9BlypuDqFfCITRv1gGhRv53wJYM2tRIpHQJqm2YWtQ
   tHKv0HhGTkvoCdzF/pDNpEj644MtmyqVrTWQGlDjrquV4TjuiTrgI0NLR
   bgoXpeZUOWes+bqeewVoZ5BzRsYZraN6vN/IrSVK3Bv6/enRUd1QIP6bA
   sBKoeK/rmINVTcrsJWF0eW8GggzW2Hvgvr1oVOIUDlfVjjvhlbB1Ngzvh
   V36mZNTC9aGT3DP2PscvVUkPwgMzdjK/ZFnQ0zd3zu62TOBsRf/B4schT
   yKDEQqDc5LC4s3V8CnmXMUvL87kL7v8ukHuyiNYF0a2kXC44Wt2BeqIyy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="333900937"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="333900937"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 00:28:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="865278645"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="865278645"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 18 Apr 2023 00:28:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5AFBD125; Tue, 18 Apr 2023 10:28:08 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>, oohall@gmail.com,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>,
        shuo.tan@linux.alibaba.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v4] PCI/PM: Shorten pci_bridge_wait_for_secondary_bus() wait time for slow links
Date:   Tue, 18 Apr 2023 10:28:08 +0300
Message-Id: <20230418072808.10431-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With slow links (<= 5GT/s) active link reporting is not mandatory, so if
a device is disconnected during system sleep we might end up waiting for
it to respond for ~60s slowing down resume time. PCIe spec r6.0 sec
6.6.1 mandates that the system software must wait for at least 1s before
it can determine the device as brokine device so use the minimum
requirement for slow links. In addition if the port supports active link
reporting we check if the link is trained before starting to wait.

This should make system resume time faster for slow links as well while
still following the PCIe spec.

While there move the PCI_RESET_WAIT constant into pci.c because it is
not used outside of that file anymore.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Hi all,

Here is the fourth version of the patch. Hopefully I did not miss
anything this time ;-)

This applies on top of

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=reset

Changes since the previous version:
  
  * Added back the comment change that was missed
  * Use PCI_RESET_WAIT - delay for the slow link timeout
  * Check active link reporting support in the slow link path

The previous version of the patch can be found:

  https://lore.kernel.org/linux-pci/20230413101642.8724-1-mika.westerberg@linux.intel.com/

 drivers/pci/pci.c | 44 ++++++++++++++++++++++++++++++++------------
 drivers/pci/pci.h |  7 -------
 2 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0b4f3b08f780..a40234c9f7a4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -64,6 +64,13 @@ struct pci_pme_device {
 
 #define PME_TIMEOUT 1000 /* How long between PME checks */
 
+/*
+ * Following exit from Conventional Reset, devices must be ready within 1 sec
+ * (PCIe r6.0 sec 6.6.1).  A D3cold to D0 transition implies a Conventional
+ * Reset (PCIe r6.0 sec 5.8).
+ */
+#define PCI_RESET_WAIT 1000 /* msec */
+
 /*
  * Devices may extend the 1 sec period through Request Retry Status
  * completions (PCIe r6.0 sec 2.3.1).  The spec does not provide an upper
@@ -5012,11 +5019,9 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 	 *
 	 * However, 100 ms is the minimum and the PCIe spec says the
 	 * software must allow at least 1s before it can determine that the
-	 * device that did not respond is a broken device. There is
-	 * evidence that 100 ms is not always enough, for example certain
-	 * Titan Ridge xHCI controller does not always respond to
-	 * configuration requests if we only wait for 100 ms (see
-	 * https://bugzilla.kernel.org/show_bug.cgi?id=203885).
+	 * device that did not respond is a broken device. Also device can
+	 * take longer than that to respond if it indicates so through Request
+	 * Retry Status completions.
 	 *
 	 * Therefore we wait for 100 ms and check for the device presence
 	 * until the timeout expires.
@@ -5027,14 +5032,29 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
 		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
 		msleep(delay);
-	} else {
-		pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
-			delay);
-		if (!pcie_wait_for_link_delay(dev, true, delay)) {
-			/* Did not train, no need to wait any further */
-			pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
-			return -ENOTTY;
+
+		/*
+		 * If the port supports active link reporting we now check
+		 * whether the link is active and if not bail out early with
+		 * the assumption that the device is not present anymore.
+		 */
+		if (dev->link_active_reporting) {
+			u16 status;
+
+			pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
+			if (!(status & PCI_EXP_LNKSTA_DLLLA))
+				return -ENOTTY;
 		}
+
+		return pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay);
+	}
+
+	pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
+		delay);
+	if (!pcie_wait_for_link_delay(dev, true, delay)) {
+		/* Did not train, no need to wait any further */
+		pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
+		return -ENOTTY;
 	}
 
 	return pci_dev_wait(child, reset_type,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 022da58afb33..f2d3aeab91f4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -64,13 +64,6 @@ struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
 #define PCI_PM_D3HOT_WAIT       10	/* msec */
 #define PCI_PM_D3COLD_WAIT      100	/* msec */
 
-/*
- * Following exit from Conventional Reset, devices must be ready within 1 sec
- * (PCIe r6.0 sec 6.6.1).  A D3cold to D0 transition implies a Conventional
- * Reset (PCIe r6.0 sec 5.8).
- */
-#define PCI_RESET_WAIT		1000	/* msec */
-
 void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
 void pci_refresh_power_state(struct pci_dev *dev);
 int pci_power_up(struct pci_dev *dev);
-- 
2.39.2

