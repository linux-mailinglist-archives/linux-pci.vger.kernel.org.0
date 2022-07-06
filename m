Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BB7568866
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 14:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiGFMdq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 08:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiGFMdp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 08:33:45 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D399EE04;
        Wed,  6 Jul 2022 05:33:44 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B0CE441692;
        Wed,  6 Jul 2022 12:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657110822;
        bh=Ij7XJmC/+XwLc9RCA+8oEtzYP6f2opNzC/i7DALyxf4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=N4a6WjFi3HaggQEMc5n/WBnTOkNwycKmXj7W+LLP5Rz4J6dVDd4GLV4FnHAMculYC
         cux0bvryXmlasULy+7Ni9LuvBbB09oxeyf4PtCJ11nrfllWO6VjAzTY0E7hVhS6fTj
         mF9YuPnDu5IbgC4fMrGQ66QYwUe1lD1ON/SsBfDVOU0gsUYPpC+D6/pwCQf3sidhgN
         gMcz/yzneo98haN2J7DDew4Fp1jcFHQa9QGKotyzD53fKVctPFqeNr26BAyGRfEcgc
         G+LLBsrfRdZpnGuSazTS3bx06e/rGcnnuK6CU7zjmzTSZc8PXr9KwieRTL/P62FYaD
         mDLAdryM+I2Qg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Disable upstream port PTM during suspend
Date:   Wed,  6 Jul 2022 20:32:44 +0800
Message-Id: <20220706123244.18056-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Intel Alder Lake platforms, Thunderbolt entering D3cold can cause
some errors reported by AER:
pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
pcieport 0000:00:1d.0: AER: device recovery failed

In addition to that, it can also block system from suspending when
a Thunderbolt dock is attached to the same system.

The original approach [1] is to disable AER and DPC when link is in
L2/L3 Ready, L2 and L3, but Bjorn identified the root cause is the Unsupported
Request:
  - 08:00.0 sent a PTM Request Message (a Posted Request)
  - 00:1d.0 received the PTM Request Message
  - The link transitioned to DL_Down
  - Per sec 2.9.1, 00:1d.0 discarded the Request and reported an
    Unsupported Request
  - Or, per sec 6.21.3, if 00:1d.0 received a PTM Request when its
    own PTM Enable was clear, it would also be treated as an
    Unsupported Request

And further: 'David did something like this [1], but just for Root Ports. That
looks wrong to me because sec 6.21.3 says we should not have PTM enabled in an
Upstream Port (i.e., in a downstream device like 08:00.0) unless it is already
enabled in the Downstream Port (i.e., in the Root Port 00:1d.0).'

So also disable upstream port PTM to make the PCI driver conform to the spec
and solve the issue.

[1] https://lore.kernel.org/all/20220408153159.106741-1-kai.heng.feng@canonical.com/
[2] https://lore.kernel.org/all/20220422222433.GA1464120@bhelgaas/
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216210
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: David E. Box <david.e.box@linux.intel.com>
Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index cfaf40a540a82..8ba8a0e12946e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2717,7 +2717,8 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
 	 * port to enter a lower-power PM state and the SoC to reach a
 	 * lower-power idle state as a whole.
 	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
 		pci_disable_ptm(dev);
 
 	pci_enable_wake(dev, target_state, wakeup);
@@ -2775,7 +2776,8 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
 	 * port to enter a lower-power PM state and the SoC to reach a
 	 * lower-power idle state as a whole.
 	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
 		pci_disable_ptm(dev);
 
 	__pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
-- 
2.36.1

