Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CBF5B407A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 22:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiIIUZW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 16:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiIIUZT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 16:25:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FBAADCEB;
        Fri,  9 Sep 2022 13:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81344620DB;
        Fri,  9 Sep 2022 20:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28A5C433C1;
        Fri,  9 Sep 2022 20:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662755115;
        bh=H4Hvk9X1Yt7qkvWdBzft4a3QJFArMQTjPf+CJiLeiSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/bH2qIDnclzkBx0bhkg5Nu9Rft5zehfQWKNRgp3Eu1E2xoYYikeQaav6qI4lz4wU
         B9RAK05YYSjQHmX2Ap/iV828hNB8wQYt4C08QU6eRyyFkXEDf2OolFsCh5yMEUuNST
         9EZhs2vcnc+3jlEKhiZiGGwBKDiwxbJuecokuVmBwrTpR28A2yxN57qddKhdha+8Oo
         hwZyLQ4/CpnBFp5tCUjrILT72LhSh4e3XFrTcqNWXWc1v7A0m5dI1rL5HoxkuBFdn9
         mZISzZnNX6wO8BN70bfbCjOGNag9Q28lm5MlgSWtJDTGTa/dt/xcH3TVSm+kvdNn1M
         AaJ1HqSSfoO7Q==
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
Subject: [PATCH v4 3/9] PCI/PTM: Separate configuration and enable
Date:   Fri,  9 Sep 2022 15:24:59 -0500
Message-Id: <20220909202505.314195-4-helgaas@kernel.org>
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

PTM configuration and enabling were previously mixed together:
pci_ptm_init() collected granularity info and enabled PTM for Root Ports
and Switch Upstream Ports; pci_enable_ptm() did the same for Endpoints.

Move everything related to the PTM Capability register to pci_ptm_init()
for all devices, and everything related to the PTM Control register to
pci_enable_ptm().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/ptm.c | 104 +++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 0df6cdfe38b4..ba1d50c965fa 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -99,25 +99,19 @@ static struct pci_dev *pci_upstream_ptm(struct pci_dev *dev)
 	return NULL;
 }
 
+/*
+ * Find the PTM Capability (if present) and extract the information we need
+ * to use it.
+ */
 void pci_ptm_init(struct pci_dev *dev)
 {
 	u16 ptm;
-	u32 cap, ctrl;
-	u8 local_clock;
+	u32 cap;
 	struct pci_dev *ups;
 
 	if (!pci_is_pcie(dev))
 		return;
 
-	/*
-	 * Enable PTM only on interior devices (root ports, switch ports,
-	 * etc.) on the assumption that it causes no link traffic until an
-	 * endpoint enables it.
-	 */
-	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT ||
-	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END))
-		return;
-
 	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
 	if (!ptm)
 		return;
@@ -126,76 +120,76 @@ void pci_ptm_init(struct pci_dev *dev)
 	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_PTM, sizeof(u16));
 
 	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
-	local_clock = (cap & PCI_PTM_GRANULARITY_MASK) >> 8;
+	dev->ptm_granularity = (cap & PCI_PTM_GRANULARITY_MASK) >> 8;
 
 	/*
-	 * There's no point in enabling PTM unless it's enabled in the
-	 * upstream device or this device can be a PTM Root itself.  Per
-	 * the spec recommendation (PCIe r3.1, sec 7.32.3), select the
-	 * furthest upstream Time Source as the PTM Root.
+	 * Per the spec recommendation (PCIe r6.0, sec 7.9.15.3), select the
+	 * furthest upstream Time Source as the PTM Root.  For Endpoints,
+	 * "the Effective Granularity is the maximum Local Clock Granularity
+	 * reported by the PTM Root and all intervening PTM Time Sources."
 	 */
 	ups = pci_upstream_ptm(dev);
-	if (ups && ups->ptm_enabled) {
-		ctrl = PCI_PTM_CTRL_ENABLE;
+	if (ups) {
 		if (ups->ptm_granularity == 0)
 			dev->ptm_granularity = 0;
-		else if (ups->ptm_granularity > local_clock)
+		else if (ups->ptm_granularity > dev->ptm_granularity)
 			dev->ptm_granularity = ups->ptm_granularity;
-	} else {
-		if (cap & PCI_PTM_CAP_ROOT) {
-			ctrl = PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT;
-			dev->ptm_root = 1;
-			dev->ptm_granularity = local_clock;
-		} else
-			return;
+	} else if (cap & PCI_PTM_CAP_ROOT) {
+		dev->ptm_root = 1;
+	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
+
+		/*
+		 * Per sec 7.9.15.3, this should be the Local Clock
+		 * Granularity of the associated Time Source.  But it
+		 * doesn't say how to find that Time Source.
+		 */
+		dev->ptm_granularity = 0;
 	}
 
-	ctrl |= dev->ptm_granularity << 8;
-	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, ctrl);
-	dev->ptm_enabled = 1;
-
-	pci_ptm_info(dev);
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
+		pci_enable_ptm(dev, NULL);
 }
 
+/**
+ * pci_enable_ptm() - Enable Precision Time Measurement
+ * @dev: PCI device
+ * @granularity: pointer to return granularity
+ *
+ * Enable Precision Time Measurement for @dev.  If successful and
+ * @granularity is non-NULL, return the Effective Granularity.
+ *
+ * Return: zero if successful, or -EINVAL if @dev lacks a PTM Capability or
+ * is not a PTM Root and lacks an upstream path of PTM-enabled devices.
+ */
 int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 {
-	u16 ptm;
-	u32 cap, ctrl;
+	u16 ptm = dev->ptm_cap;
 	struct pci_dev *ups;
+	u32 ctrl;
 
-	if (!pci_is_pcie(dev))
-		return -EINVAL;
-
-	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
 	if (!ptm)
 		return -EINVAL;
 
-	dev->ptm_cap = ptm;
-	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
-	if (!(cap & PCI_PTM_CAP_REQ))
-		return -EINVAL;
-
 	/*
-	 * For a PCIe Endpoint, PTM is only useful if the endpoint can
-	 * issue PTM requests to upstream devices that have PTM enabled.
-	 *
-	 * For Root Complex Integrated Endpoints, there is no upstream
-	 * device, so there must be some implementation-specific way to
-	 * associate the endpoint with a time source.
+	 * A device uses local PTM Messages to request time information
+	 * from a PTM Root that's farther upstream.  Every device along the
+	 * path must support PTM and have it enabled so it can handle the
+	 * messages.  Therefore, if this device is not a PTM Root, the
+	 * upstream link partner must have PTM enabled before we can enable
+	 * PTM.
 	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT) {
+	if (!dev->ptm_root) {
 		ups = pci_upstream_ptm(dev);
 		if (!ups || !ups->ptm_enabled)
 			return -EINVAL;
-
-		dev->ptm_granularity = ups->ptm_granularity;
-	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
-		dev->ptm_granularity = 0;
-	} else
-		return -EINVAL;
+	}
 
 	ctrl = PCI_PTM_CTRL_ENABLE;
 	ctrl |= dev->ptm_granularity << 8;
+	if (dev->ptm_root)
+		ctrl |= PCI_PTM_CTRL_ROOT;
+
 	pci_write_config_dword(dev, ptm + PCI_PTM_CTRL, ctrl);
 	dev->ptm_enabled = 1;
 
-- 
2.25.1

