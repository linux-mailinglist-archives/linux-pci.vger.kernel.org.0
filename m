Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333EE5A67B8
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 17:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiH3Pwb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 11:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiH3Pw3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 11:52:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7323DB5E7D;
        Tue, 30 Aug 2022 08:52:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AF7561656;
        Tue, 30 Aug 2022 15:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3972FC433D6;
        Tue, 30 Aug 2022 15:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661874747;
        bh=3ggh/iU+WYbUFzTX6WB/TTiiJnU4DQBdafBsx3kLGR0=;
        h=From:To:Cc:Subject:Date:From;
        b=Ix2ZGWoE6eDItweoa/J+la02NwmllYakGrE2fD9MwEI19CMXn/FHI+wnmuga5n2oF
         avPE6eQ4SQAcXxc7RMU3InIA7Id9piD/T18YR+Fwi34Z7+PPxVd0oXrMSOJkopuSb4
         PcR2qkQMdUFmmIrKyrt4KPlg93LCb7bmZ6FM7x+LQNn6UbR9eREMpxVeK/10ggYKUn
         GgAy5nBziHTGVJ35ZRzR4v5riDmD4bN/vJd5dmjjUOwReagroJqdKfmluQCmvXHeF4
         rvkCaY1CJlXmDl8XHKwNuUgb+YkQnoFtpsvw4+Q5Ci11Oqsxqhk20zgKMeQkhnF4h+
         /LgNgg6PX2A8w==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Disable PTM on Upstream Ports during suspend
Date:   Tue, 30 Aug 2022 10:52:24 -0500
Message-Id: <20220830155224.103907-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
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

During suspend, we want to disable PTM on Root Ports because that allows
some chips, e.g., Intel mobile chips since Coffee Lake, to enter a
lower-power PM state.

Previously we only disabled PTM for Root Ports, but PCIe r6.0, sec 2.2.8,
strongly recommends that functions support generation of Messages in non-D0
states, so we must assume that Switch Upstream Ports or Endpoints may send
PTM Request Messages while in D1, D2, and D3hot.

A PTM Message received by a Downstream Port, e.g., a Root Port, with PTM
disabled must be treated as an Unsupported Request (sec 6.21.3).

With this topology:

  0000:00:1d.0 Root Port              to [bus 08-71]
  0000:08:00.0 Switch Upstream Port   to [bus 09-71]

Kai-Heng reported errors like this:

  pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
  pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
  pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
  pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
  pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000

Decoding this (from PCIe r6.0, sec 2.2.1.1, 2.2.8.10) shows that 00:1d.0
logged an Unsupported Request error when it received a PTM Request with
Requester ID 08:00.0.

To prevent this error, disable PTM when suspending Upstream Ports
(including those on Endpoints), not just Root Ports.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216210
Based-on: https://lore.kernel.org/r/20220706123244.18056-1-kai.heng.feng@canonical.com
Based-on-patch-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: David E. Box <david.e.box@linux.intel.com>
Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pci.c      | 30 ++++++++++++++----------------
 drivers/pci/pcie/ptm.c |  8 +++++++-
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 95bc329e74c0..96487a9ce5bf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2707,14 +2707,19 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
 		return -EIO;
 
 	/*
-	 * There are systems (for example, Intel mobile chips since Coffee
-	 * Lake) where the power drawn while suspended can be significantly
-	 * reduced by disabling PTM on PCIe root ports as this allows the
-	 * port to enter a lower-power PM state and the SoC to reach a
-	 * lower-power idle state as a whole.
+	 * We want to disable PTM on Root Ports because that allows some
+	 * chips, e.g., Intel mobile chips since Coffee Lake, to enter a
+	 * lower-power PM state.
+	 *
+	 * PCIe r6.0, sec 2.2.8, strongly recommends that functions support
+	 * generation of messages in non-D0 states, so we assume Switch
+	 * Upstream Ports or Endpoints may send PTM Requests while in D1,
+	 * D2, and D3hot.  A PTM message received by a Downstream Port
+	 * (including a Root Port) with PTM disabled must be treated as an
+	 * Unsupported Request (sec 6.21.3).  To prevent this error,
+	 * disable PTM in *all* devices, not just Root Ports.
 	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
-		pci_disable_ptm(dev);
+	pci_disable_ptm(dev);
 
 	pci_enable_wake(dev, target_state, wakeup);
 
@@ -2764,15 +2769,8 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
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
+	/* See rationale above for disabling PTM */
+	pci_disable_ptm(dev);
 
 	__pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
 
diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 368a254e3124..ec338470d13f 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -31,12 +31,18 @@ static void pci_ptm_info(struct pci_dev *dev)
 
 void pci_disable_ptm(struct pci_dev *dev)
 {
-	int ptm;
+	int type, ptm;
 	u16 ctrl;
 
 	if (!pci_is_pcie(dev))
 		return;
 
+	type = pci_pcie_type(dev);
+	if (!(type == PCI_EXP_TYPE_ROOT_PORT ||
+	      type == PCI_EXP_TYPE_UPSTREAM ||
+	      type == PCI_EXP_TYPE_ENDPOINT))
+		return;
+
 	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
 	if (!ptm)
 		return;
-- 
2.25.1

