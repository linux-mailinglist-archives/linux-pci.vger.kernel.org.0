Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF275ABB47
	for <lists+linux-pci@lfdr.de>; Sat,  3 Sep 2022 01:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiIBXgA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 19:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiIBXf5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 19:35:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAD5DFB68;
        Fri,  2 Sep 2022 16:35:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD673B82E08;
        Fri,  2 Sep 2022 23:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D47C433C1;
        Fri,  2 Sep 2022 23:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662161752;
        bh=499J1ALryCuJ+6HDm82sa2IWHYaV94fHkOG4KesRkw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJwTCl//9uW8H+Ad+QJqYtqtDT8D6QOK3j+1/Omo9e2MFDRnjYlPPNoojaoQ3BW4d
         bu7jxbi62CQgoH/Rs6NjryqDBTFtQd0Y3LYceBbraa8d/JIoDT1fVen/g+SD9D3GRd
         0GLPqNfJMrcRfaXLiaBJzuHyrKbKcESJQc3CmAL0F1BMI/ySEmUwdk5m1kxt+SlYGu
         F/FElKjHODWUImh0gHD/ZQ1InJzvqqsi08j8HCWl7Sl9z4f2sgOZXf/RlrIEEbeaFO
         fIQ2eohmC+Y7gEBomwB4bvaaODW6PMC0UF1LyZdnTuCNkdNRvXF8RQpO8w4UjcevmP
         P+117PJEV7I5A==
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
Subject: [PATCH v2 3/3] PCI/PM: Always disable PTM for all devices during suspend
Date:   Fri,  2 Sep 2022 18:35:43 -0500
Message-Id: <20220902233543.390890-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902233543.390890-1-helgaas@kernel.org>
References: <20220902233543.390890-1-helgaas@kernel.org>
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
*before* saving state, we must explicitly re-enable it.

Here's a sample of errors that occur when PTM is disabled only on the Root
Port.  With this topology:

  0000:00:1d.0 Root Port            to [bus 08-71]
  0000:08:00.0 Switch Upstream Port to [bus 09-71]

Kai-Heng reported errors like this:

  pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
  pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
  pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
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
Based-on: https://lore.kernel.org/r/20220706123244.18056-1-kai.heng.feng@canonical.com
Based-on-patch-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-driver.c | 14 ++++++++++++++
 drivers/pci/pci.c        | 20 --------------------
 2 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 2815922ac525..115febaa7e0b 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -772,6 +772,12 @@ static int pci_pm_suspend(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
+	/*
+	 * Disabling PTM allows some systems, e.g., Intel mobile chips
+	 * since Coffee Lake, to enter a lower-power PM state.
+	 */
+	pci_disable_ptm(pci_dev);
+
 	pci_dev->skip_bus_pm = false;
 
 	if (pci_has_legacy_pm_support(pci_dev))
@@ -982,6 +988,9 @@ static int pci_pm_resume(struct device *dev)
 	if (pci_dev->state_saved)
 		pci_restore_standard_config(pci_dev);
 
+	if (pci_dev->ptm_enabled)
+		pci_enable_ptm(pci_dev, NULL);
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume(dev);
 
@@ -1269,6 +1278,8 @@ static int pci_pm_runtime_suspend(struct device *dev)
 	pci_power_t prev = pci_dev->current_state;
 	int error;
 
+	pci_disable_ptm(pci_dev);
+
 	/*
 	 * If pci_dev->driver is not set (unbound), we leave the device in D0,
 	 * but it may go to D3cold when the bridge above it runtime suspends.
@@ -1331,6 +1342,9 @@ static int pci_pm_runtime_resume(struct device *dev)
 	 */
 	pci_pm_default_resume_early(pci_dev);
 
+	if (pci_dev->ptm_enabled)
+		pci_enable_ptm(pci_dev, NULL);
+
 	if (!pci_dev->driver)
 		return 0;
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 95bc329e74c0..b0e2968c8cca 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2706,16 +2706,6 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
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
-		pci_disable_ptm(dev);
-
 	pci_enable_wake(dev, target_state, wakeup);
 
 	error = pci_set_power_state(dev, target_state);
@@ -2764,16 +2754,6 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
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
-		pci_disable_ptm(dev);
-
 	__pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
 
 	error = pci_set_power_state(dev, target_state);
-- 
2.25.1

