Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993D95B4079
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 22:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiIIUZV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 16:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiIIUZR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 16:25:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFEC9E0D7;
        Fri,  9 Sep 2022 13:25:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E85D620BE;
        Fri,  9 Sep 2022 20:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE8CC433D6;
        Fri,  9 Sep 2022 20:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662755114;
        bh=ResNdvSRNv04okFK2Y+rWUbzoFtpHE/Unrx/hdtFI/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NuB+gPMeFpbvB9XgcDDLDmrIryWE8oeUpoC8N7nOvyvIGrV2x+b8sLjsVMMumt2ol
         RIrgwXjU3QO8QM5DTSKjnIvLoFhqEOTXPTjsVNjPVXaUssu5biY1/XKPjeE7RbTrgs
         Q5pj9Tvan869ycA+lJjbfuJMpcuIVIXbemBL0Q45oQevVv3zIHrj57drDNHOMaci3u
         gnpzNpubRclcm1dnvj+2zn7YCfj/HpfJM2cRTFoZdR9LnGmUoaqUpklynhwF5zlqQy
         ZzJwZd3P/JIBKM/LfNH5zJaSCpbjjE1+c5l1CqoU/Xv8YyiN0Y2K5Bc4jiugXzgYKZ
         2AwAN+4JEWTDQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v4 2/9] PCI/PTM: Add pci_upstream_ptm() helper
Date:   Fri,  9 Sep 2022 15:24:58 -0500
Message-Id: <20220909202505.314195-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909202505.314195-1-helgaas@kernel.org>
References: <20220909202505.314195-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

PTM requires an unbroken path of PTM-supporting devices between the PTM
Root and the ultimate PTM Requester, but if a Switch supports PTM, only the
Upstream Port can have a PTM Capability; the Downstream Ports do not.

Previously we copied the PTM configuration from the Switch Upstream Port to
the Downstream Ports so dev->ptm_enabled for any device implied that all
the upstream devices support PTM.

Instead of making it look like Downstream Ports have their own PTM config,
add pci_upstream_ptm(), which returns the upstream device that has a PTM
Capability (either a Root Port or a Switch Upstream Port).

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/ptm.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 85382c135885..0df6cdfe38b4 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -76,6 +76,29 @@ void pci_restore_ptm_state(struct pci_dev *dev)
 	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
 }
 
+/*
+ * If the next upstream device supports PTM, return it; otherwise return
+ * NULL.  PTM Messages are local, so both link partners must support it.
+ */
+static struct pci_dev *pci_upstream_ptm(struct pci_dev *dev)
+{
+	struct pci_dev *ups = pci_upstream_bridge(dev);
+
+	/*
+	 * Switch Downstream Ports are not permitted to have a PTM
+	 * capability; their PTM behavior is controlled by the Upstream
+	 * Port (PCIe r5.0, sec 7.9.16), so if the upstream bridge is a
+	 * Switch Downstream Port, look up one more level.
+	 */
+	if (ups && pci_pcie_type(ups) == PCI_EXP_TYPE_DOWNSTREAM)
+		ups = pci_upstream_bridge(ups);
+
+	if (ups && ups->ptm_cap)
+		return ups;
+
+	return NULL;
+}
+
 void pci_ptm_init(struct pci_dev *dev)
 {
 	u16 ptm;
@@ -95,19 +118,6 @@ void pci_ptm_init(struct pci_dev *dev)
 	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END))
 		return;
 
-	/*
-	 * Switch Downstream Ports are not permitted to have a PTM
-	 * capability; their PTM behavior is controlled by the Upstream
-	 * Port (PCIe r5.0, sec 7.9.16).
-	 */
-	ups = pci_upstream_bridge(dev);
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM &&
-	    ups && ups->ptm_enabled) {
-		dev->ptm_granularity = ups->ptm_granularity;
-		dev->ptm_enabled = 1;
-		return;
-	}
-
 	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
 	if (!ptm)
 		return;
@@ -124,6 +134,7 @@ void pci_ptm_init(struct pci_dev *dev)
 	 * the spec recommendation (PCIe r3.1, sec 7.32.3), select the
 	 * furthest upstream Time Source as the PTM Root.
 	 */
+	ups = pci_upstream_ptm(dev);
 	if (ups && ups->ptm_enabled) {
 		ctrl = PCI_PTM_CTRL_ENABLE;
 		if (ups->ptm_granularity == 0)
@@ -173,7 +184,7 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 	 * associate the endpoint with a time source.
 	 */
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT) {
-		ups = pci_upstream_bridge(dev);
+		ups = pci_upstream_ptm(dev);
 		if (!ups || !ups->ptm_enabled)
 			return -EINVAL;
 
-- 
2.25.1

