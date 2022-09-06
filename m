Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C1D5AF7E0
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 00:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiIFWYN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 18:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiIFWYK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 18:24:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA4CAB18A;
        Tue,  6 Sep 2022 15:24:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2F9A6CE193F;
        Tue,  6 Sep 2022 22:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F530C43470;
        Tue,  6 Sep 2022 22:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662503043;
        bh=rPl1TPqw2/PuhdUCzI4nj4Vdv7gDiO1VXLiBI/IcQQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uFOXnfAX63txEqjxwpkQFwdA/yiuCn4en+X6TwNGJn9je5pFG6jNxyg4tr5tmM32A
         +nWNCab2Z7f6V1kWbqyD04p5mRM9ObysscvvPHyZrODgqrGcQ/NBk7qtBXZ1L1mZRa
         +2WrY2hrPzeOfL6fEh/z/LvlbNEqWSueBkhOlxAi8OMUByCtn55J+dG3dDmpY1TIF2
         D58DyyFbN2DcNordDrFgkcwJRf2tGg5RKYqQz4yrq3TaNTi6Rkf7BDIwIFZoVDwCfj
         WamHSihYAJRzWCY1LjBkFYTZukgzoXZJ674gsIvQvfLp0/IusU7Jjk6xux+/Tf9fnu
         CX1ps7h7SPfAA==
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
Subject: [PATCH v3 04/10] PCI/PTM: Separate configuration and enable
Date:   Tue,  6 Sep 2022 17:23:45 -0500
Message-Id: <20220906222351.64760-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906222351.64760-1-helgaas@kernel.org>
References: <20220906222351.64760-1-helgaas@kernel.org>
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
 drivers/pci/pcie/ptm.c | 81 ++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 54 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 8729c3e452ee..ac51cd84793f 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -102,22 +102,12 @@ static struct pci_dev *pci_upstream_ptm(struct pci_dev *dev)
 void pci_ptm_init(struct pci_dev *dev)
 {
 	int ptm;
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
@@ -126,76 +116,59 @@ void pci_ptm_init(struct pci_dev *dev)
 	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_PTM, sizeof(u16));
 
 	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
-	local_clock = (cap & PCI_PTM_GRANULARITY_MASK) >> 8;
+	dev->ptm_granularity = (cap & PCI_PTM_GRANULARITY_MASK) >> 8;
 
 	/*
-	 * There's no point in enabling PTM unless it's enabled in the
-	 * upstream device or this device can be a PTM Root itself.  Per
-	 * the spec recommendation (PCIe r3.1, sec 7.32.3), select the
+	 * Per the spec recommendation (PCIe r6.0, sec 7.9.15.3), select the
 	 * furthest upstream Time Source as the PTM Root.
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
 
 int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 {
-	int ptm;
-	u32 cap, ctrl;
+	int ptm = dev->ptm_cap;
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
+	 * If this device is not a PTM Root, the upstream link partner must
+	 * have PTM enabled before we can enable PTM.
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

