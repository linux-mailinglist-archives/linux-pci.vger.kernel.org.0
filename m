Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FFD7C41C3
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 22:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343647AbjJJUos (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 16:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbjJJUor (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 16:44:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6A899;
        Tue, 10 Oct 2023 13:44:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27487C433C7;
        Tue, 10 Oct 2023 20:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696970685;
        bh=OwkCq7JGuXWQvF8wdGADxRmgdNMJpmy7jJU/pihVCC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cp30P3byp0tMkKOPkBvzwjcj+wYJp36Kc5wakpn74zGIafp7Jg5r56qYodIiBtBo4
         vz56KnzJIOT2xbvZPONuDHCWe+baQn3VnT8628xlAP19ciWcwCtUfzOj2CvhkjusKy
         fLaBSZHWHTpRPZSZYYAaZ9qTNfsggVABIOVojQQBTBvD1QyAhR/4ACtnRlMELUTIEn
         cuj33Vc9KaFivmjhNFkg9yktfhtACkZAXpkcDn0eH0/56jq3+ezkNpWVPTdbLXDIex
         59EE521RQTmOkxgAL+9tHN/dhsvaUUilUataiw1I5rh0RBw2q/oItyOz13aBbG/WCt
         FLQJTJq2hJe/Q==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 01/10] PCI: Use FIELD_GET()
Date:   Tue, 10 Oct 2023 15:44:27 -0500
Message-Id: <20231010204436.1000644-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010204436.1000644-1-helgaas@kernel.org>
References: <20231010204436.1000644-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use FIELD_GET() to remove dependences on the field position, i.e., the
shift value.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c   | 45 ++++++++++++++++++++++-----------------------
 drivers/pci/probe.c |  8 ++++----
 2 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a8adc34dc86f..848c9ee65d7f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1776,8 +1776,7 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
 		return;
 
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
-	nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >>
-		    PCI_REBAR_CTRL_NBAR_SHIFT;
+	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
 
 	for (i = 0; i < nbars; i++, pos += 8) {
 		struct resource *res;
@@ -1788,7 +1787,7 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
 		res = pdev->resource + bar_idx;
 		size = pci_rebar_bytes_to_size(resource_size(res));
 		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
-		ctrl |= size << PCI_REBAR_CTRL_BAR_SHIFT;
+		ctrl |= FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
 		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
 	}
 }
@@ -3229,7 +3228,7 @@ void pci_pm_init(struct pci_dev *dev)
 			 (pmc & PCI_PM_CAP_PME_D2) ? " D2" : "",
 			 (pmc & PCI_PM_CAP_PME_D3hot) ? " D3hot" : "",
 			 (pmc & PCI_PM_CAP_PME_D3cold) ? " D3cold" : "");
-		dev->pme_support = pmc >> PCI_PM_CAP_PME_SHIFT;
+		dev->pme_support = FIELD_GET(PCI_PM_CAP_PME_MASK, pmc);
 		dev->pme_poll = true;
 		/*
 		 * Make device's PM flags reflect the wake-up capability, but
@@ -3300,20 +3299,20 @@ static int pci_ea_read(struct pci_dev *dev, int offset)
 	ent_offset += 4;
 
 	/* Entry size field indicates DWORDs after 1st */
-	ent_size = ((dw0 & PCI_EA_ES) + 1) << 2;
+	ent_size = (FIELD_GET(PCI_EA_ES, dw0) + 1) << 2;
 
 	if (!(dw0 & PCI_EA_ENABLE)) /* Entry not enabled */
 		goto out;
 
-	bei = (dw0 & PCI_EA_BEI) >> 4;
-	prop = (dw0 & PCI_EA_PP) >> 8;
+	bei = FIELD_GET(PCI_EA_BEI, dw0);
+	prop = FIELD_GET(PCI_EA_PP, dw0);
 
 	/*
 	 * If the Property is in the reserved range, try the Secondary
 	 * Property instead.
 	 */
 	if (prop > PCI_EA_P_BRIDGE_IO && prop < PCI_EA_P_MEM_RESERVED)
-		prop = (dw0 & PCI_EA_SP) >> 16;
+		prop = FIELD_GET(PCI_EA_SP, dw0);
 	if (prop > PCI_EA_P_BRIDGE_IO)
 		goto out;
 
@@ -3720,14 +3719,13 @@ static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
 		return -ENOTSUPP;
 
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
-	nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >>
-		    PCI_REBAR_CTRL_NBAR_SHIFT;
+	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
 
 	for (i = 0; i < nbars; i++, pos += 8) {
 		int bar_idx;
 
 		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
-		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
+		bar_idx = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, ctrl);
 		if (bar_idx == bar)
 			return pos;
 	}
@@ -3782,7 +3780,7 @@ int pci_rebar_get_current_size(struct pci_dev *pdev, int bar)
 		return pos;
 
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
-	return (ctrl & PCI_REBAR_CTRL_BAR_SIZE) >> PCI_REBAR_CTRL_BAR_SHIFT;
+	return FIELD_GET(PCI_REBAR_CTRL_BAR_SIZE, ctrl);
 }
 
 /**
@@ -3805,7 +3803,7 @@ int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size)
 
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
 	ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
-	ctrl |= size << PCI_REBAR_CTRL_BAR_SHIFT;
+	ctrl |= FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
 	pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
 	return 0;
 }
@@ -6043,7 +6041,7 @@ int pcix_get_max_mmrbc(struct pci_dev *dev)
 	if (pci_read_config_dword(dev, cap + PCI_X_STATUS, &stat))
 		return -EINVAL;
 
-	return 512 << ((stat & PCI_X_STATUS_MAX_READ) >> 21);
+	return 512 << FIELD_GET(PCI_X_STATUS_MAX_READ, stat);
 }
 EXPORT_SYMBOL(pcix_get_max_mmrbc);
 
@@ -6066,7 +6064,7 @@ int pcix_get_mmrbc(struct pci_dev *dev)
 	if (pci_read_config_word(dev, cap + PCI_X_CMD, &cmd))
 		return -EINVAL;
 
-	return 512 << ((cmd & PCI_X_CMD_MAX_READ) >> 2);
+	return 512 << FIELD_GET(PCI_X_CMD_MAX_READ, cmd);
 }
 EXPORT_SYMBOL(pcix_get_mmrbc);
 
@@ -6097,19 +6095,19 @@ int pcix_set_mmrbc(struct pci_dev *dev, int mmrbc)
 	if (pci_read_config_dword(dev, cap + PCI_X_STATUS, &stat))
 		return -EINVAL;
 
-	if (v > (stat & PCI_X_STATUS_MAX_READ) >> 21)
+	if (v > FIELD_GET(PCI_X_STATUS_MAX_READ, stat))
 		return -E2BIG;
 
 	if (pci_read_config_word(dev, cap + PCI_X_CMD, &cmd))
 		return -EINVAL;
 
-	o = (cmd & PCI_X_CMD_MAX_READ) >> 2;
+	o = FIELD_GET(PCI_X_CMD_MAX_READ, cmd);
 	if (o != v) {
 		if (v > o && (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_MMRBC))
 			return -EIO;
 
 		cmd &= ~PCI_X_CMD_MAX_READ;
-		cmd |= v << 2;
+		cmd |= FIELD_PREP(PCI_X_CMD_MAX_READ, v);
 		if (pci_write_config_word(dev, cap + PCI_X_CMD, cmd))
 			return -EIO;
 	}
@@ -6129,7 +6127,7 @@ int pcie_get_readrq(struct pci_dev *dev)
 
 	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &ctl);
 
-	return 128 << ((ctl & PCI_EXP_DEVCTL_READRQ) >> 12);
+	return 128 << FIELD_GET(PCI_EXP_DEVCTL_READRQ, ctl);
 }
 EXPORT_SYMBOL(pcie_get_readrq);
 
@@ -6162,7 +6160,7 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 			rq = mps;
 	}
 
-	v = (ffs(rq) - 8) << 12;
+	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
 
 	if (bridge->no_inc_mrrs) {
 		int max_mrrs = pcie_get_readrq(dev);
@@ -6192,7 +6190,7 @@ int pcie_get_mps(struct pci_dev *dev)
 
 	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &ctl);
 
-	return 128 << ((ctl & PCI_EXP_DEVCTL_PAYLOAD) >> 5);
+	return 128 << FIELD_GET(PCI_EXP_DEVCTL_PAYLOAD, ctl);
 }
 EXPORT_SYMBOL(pcie_get_mps);
 
@@ -6215,7 +6213,7 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
 	v = ffs(mps) - 8;
 	if (v > dev->pcie_mpss)
 		return -EINVAL;
-	v <<= 5;
+	v = FIELD_PREP(PCI_EXP_DEVCTL_PAYLOAD, v);
 
 	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
 						  PCI_EXP_DEVCTL_PAYLOAD, v);
@@ -6257,7 +6255,8 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 	while (dev) {
 		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 
-		next_speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
+		next_speed = pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS,
+						       lnksta)];
 		next_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
 
 		next_bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 795534589b98..2036c3a120ee 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -807,8 +807,8 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 		}
 
 		bus->max_bus_speed = max;
-		bus->cur_bus_speed = pcix_bus_speed[
-			(status & PCI_X_SSTATUS_FREQ) >> 6];
+		bus->cur_bus_speed =
+			pcix_bus_speed[FIELD_GET(PCI_X_SSTATUS_FREQ, status)];
 
 		return;
 	}
@@ -1217,8 +1217,8 @@ static bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
 
 	offset = ea + PCI_EA_FIRST_ENT;
 	pci_read_config_dword(dev, offset, &dw);
-	ea_sec =  dw & PCI_EA_SEC_BUS_MASK;
-	ea_sub = (dw & PCI_EA_SUB_BUS_MASK) >> PCI_EA_SUB_BUS_SHIFT;
+	ea_sec = FIELD_GET(PCI_EA_SEC_BUS_MASK, dw);
+	ea_sub = FIELD_GET(PCI_EA_SUB_BUS_MASK, dw);
 	if (ea_sec  == 0 || ea_sub < ea_sec)
 		return false;
 
-- 
2.34.1

