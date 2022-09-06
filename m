Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6615AF7EC
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 00:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiIFWYr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 18:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiIFWY0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 18:24:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE80AE86F;
        Tue,  6 Sep 2022 15:24:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A378861713;
        Tue,  6 Sep 2022 22:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE96C433C1;
        Tue,  6 Sep 2022 22:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662503054;
        bh=8zBtTybYX8wofqg/4M5b5Eesn1tmGcj3alXYa5B6SS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTF2mls+dk/XL02WdDwayJCVNRSAdDhBURu3wckxOru9a5/wQKNLb4P6TPbmkSIKh
         bzQb8xJ/qYcu56kRUVpLaWHZLUwzo8iFfG6qZ6etUMrP0R7idmfxLO/yxpNEAlPebj
         XgEpTnQgLZDegIE+t+qwm5vozzOLCSlS7KORLibCFL8GZ+0czg7iQEr+fqKN5GtM7N
         wgCtCDsDJE5DdbD6/kaEQGCUhhXaJLnXULnB2hZ8xqYMHZ/OD9rZagdEY7ZfdeqPJ0
         INRsniFzvKiQE7cXiouUc4v7XEW7341ma0ApVVjqFnw0ZAt5kDLcTajzAXGTxd7GMA
         YRVqMpdEIuKyw==
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
Subject: [PATCH v3 10/10] PCI/PM: Always disable PTM for all devices during suspend
Date:   Tue,  6 Sep 2022 17:23:51 -0500
Message-Id: <20220906222351.64760-11-helgaas@kernel.org>
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

We want to disable PTM on Root Ports because that allows some chips, e.g.,
Intel mobile chips since Coffee Lake, to enter a lower-power PM state.

That means we also have to disable PTM on downstream devices.  PCIe r6.0,
sec 2.2.8, recommends that functions support generation of messages in
non-D0 states, so we have to assume Switch Upstream Ports or Endpoints may
send PTM Requests while in D1, D2, and D3hot.  A PTM message received by a
Downstream Port (including a Root Port) with PTM disabled must be treated
as an Unsupported Request (sec 6.21.3).

PTM was previously disabled only for Root Ports, and it was disabled in
pci_prepare_to_sleep(), which is not called at all if a driver supports
legacy PM or does its own state saving.

Instead, disable PTM early in pci_pm_suspend() and pci_pm_runtime_suspend()
so we do it in all cases.

Previously PTM was disabled *after* saving device state, so the state
restore on resume automatically re-enabled it.  Since we now disable PTM
*before* saving state, we must explicitly re-enable it in pci_pm_resume()
and pci_pm_runtime_resume().

Here's a sample of errors that occur when PTM is disabled only on the Root
Port.  With this topology:

  0000:00:1d.0 Root Port            to [bus 08-71]
  0000:08:00.0 Switch Upstream Port to [bus 09-71]

Kai-Heng reported errors like this:

  pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
  pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000

Decoding TLP header 0x34...... (0011 0100b) and 0x08000052:

  Fmt                         001b  4 DW header, no data
  Type                     1 0100b  Msg (Local - Terminate at Receiver)
  Requester ID  0x0800              Bus 08 Devfn 00.0
  Message Code    0x52  0101 0010b  PTM Request

The 00:1d.0 Root Port logged an Unsupported Request error when it received
a PTM Request with Requester ID 08:00.0.

Fixes: a697f072f5da ("PCI: Disable PTM during suspend to save power")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216210
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-driver.c | 11 +++++++++++
 drivers/pci/pci.c        | 28 ++--------------------------
 2 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 2815922ac525..107d77f3c846 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -774,6 +774,12 @@ static int pci_pm_suspend(struct device *dev)
 
 	pci_dev->skip_bus_pm = false;
 
+	/*
+	 * Disabling PTM allows some systems, e.g., Intel mobile chips
+	 * since Coffee Lake, to enter a lower-power PM state.
+	 */
+	pci_suspend_ptm(pci_dev);
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_SUSPEND);
 
@@ -982,6 +988,8 @@ static int pci_pm_resume(struct device *dev)
 	if (pci_dev->state_saved)
 		pci_restore_standard_config(pci_dev);
 
+	pci_resume_ptm(pci_dev);
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume(dev);
 
@@ -1269,6 +1277,8 @@ static int pci_pm_runtime_suspend(struct device *dev)
 	pci_power_t prev = pci_dev->current_state;
 	int error;
 
+	pci_suspend_ptm(pci_dev);
+
 	/*
 	 * If pci_dev->driver is not set (unbound), we leave the device in D0,
 	 * but it may go to D3cold when the bridge above it runtime suspends.
@@ -1330,6 +1340,7 @@ static int pci_pm_runtime_resume(struct device *dev)
 	 * D3cold when the bridge above it runtime suspended.
 	 */
 	pci_pm_default_resume_early(pci_dev);
+	pci_resume_ptm(pci_dev);
 
 	if (!pci_dev->driver)
 		return 0;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 83818f81577d..107afa0a5b03 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2706,24 +2706,12 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
 	if (target_state == PCI_POWER_ERROR)
 		return -EIO;
 
-	/*
-	 * There are systems (for example, Intel mobile chips since Coffee
-	 * Lake) where the power drawn while suspended can be significantly
-	 * reduced by disabling PTM on PCIe root ports as this allows the
-	 * port to enter a lower-power PM state and the SoC to reach a
-	 * lower-power idle state as a whole.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
-		pci_suspend_ptm(dev);
-
 	pci_enable_wake(dev, target_state, wakeup);
 
 	error = pci_set_power_state(dev, target_state);
 
-	if (error) {
+	if (error)
 		pci_enable_wake(dev, target_state, false);
-		pci_restore_ptm_state(dev);
-	}
 
 	return error;
 }
@@ -2764,24 +2752,12 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
 	if (target_state == PCI_POWER_ERROR)
 		return -EIO;
 
-	/*
-	 * There are systems (for example, Intel mobile chips since Coffee
-	 * Lake) where the power drawn while suspended can be significantly
-	 * reduced by disabling PTM on PCIe root ports as this allows the
-	 * port to enter a lower-power PM state and the SoC to reach a
-	 * lower-power idle state as a whole.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
-		pci_suspend_ptm(dev);
-
 	__pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
 
 	error = pci_set_power_state(dev, target_state);
 
-	if (error) {
+	if (error)
 		pci_enable_wake(dev, target_state, false);
-		pci_restore_ptm_state(dev);
-	}
 
 	return error;
 }
-- 
2.25.1

