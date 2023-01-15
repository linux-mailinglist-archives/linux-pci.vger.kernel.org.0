Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798D166AFEB
	for <lists+linux-pci@lfdr.de>; Sun, 15 Jan 2023 09:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjAOIZB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Jan 2023 03:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjAOIZA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Jan 2023 03:25:00 -0500
X-Greylist: delayed 140 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 Jan 2023 00:24:59 PST
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f236:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC827C151
        for <linux-pci@vger.kernel.org>; Sun, 15 Jan 2023 00:24:59 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 5604E101E6B5D;
        Sun, 15 Jan 2023 09:24:43 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 00091603DB87;
        Sun, 15 Jan 2023 09:24:32 +0100 (CET)
X-Mailbox-Line: From eb37fa345285ec8bacabbf06b020b803f77bdd3d Mon Sep 17 00:00:00 2001
Message-Id: <eb37fa345285ec8bacabbf06b020b803f77bdd3d.1673769517.git.lukas@wunner.de>
In-Reply-To: <cover.1673769517.git.lukas@wunner.de>
References: <cover.1673769517.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 15 Jan 2023 09:20:31 +0100
Subject: [PATCH v2 1/3] PCI/PM: Observe reset delay irrespective of bridge_d3
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If a PCI bridge is suspended to D3cold upon entering system sleep,
resuming it entails a Fundamental Reset per PCIe r6.0 sec 5.8.

The delay prescribed after a Fundamental Reset in PCIe r6.0 sec 6.6.1
is sought to be observed by:

  pci_pm_resume_noirq()
    pci_pm_bridge_power_up_actions()
      pci_bridge_wait_for_secondary_bus()

However, pci_bridge_wait_for_secondary_bus() bails out if the bridge_d3
flag is not set.  That flag indicates whether a bridge is allowed to
suspend to D3cold at *runtime*.

Hence *no* delay is observed on resume from system sleep if runtime
D3cold is forbidden.  That doesn't make any sense, so drop the bridge_d3
check from pci_bridge_wait_for_secondary_bus().

The purpose of the bridge_d3 check was probably to avoid delays if a
bridge remained in D0 during suspend.  However the sole caller of
pci_bridge_wait_for_secondary_bus(), pci_pm_bridge_power_up_actions(),
is only invoked if the previous power state was D3cold.  Hence the
additional bridge_d3 check seems superfluous.

Fixes: ad9001f2f411 ("PCI/PM: Add missing link delays required by the PCIe spec")
Tested-by: Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable@vger.kernel.org # v5.5+
---
Changes v1 -> v2:
 * Add Reviewed-by tags (Mika, Sathyanarayanan)

 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fba95486caaf..f43f3e84f634 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4964,7 +4964,7 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
 	if (pci_dev_is_disconnected(dev))
 		return;
 
-	if (!pci_is_bridge(dev) || !dev->bridge_d3)
+	if (!pci_is_bridge(dev))
 		return;
 
 	down_read(&pci_bus_sem);
-- 
2.39.0

