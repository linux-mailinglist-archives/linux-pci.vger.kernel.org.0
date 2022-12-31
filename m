Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D3665A61F
	for <lists+linux-pci@lfdr.de>; Sat, 31 Dec 2022 19:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiLaSt0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Dec 2022 13:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLaStZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Dec 2022 13:49:25 -0500
X-Greylist: delayed 598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 31 Dec 2022 10:49:24 PST
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580112642
        for <linux-pci@vger.kernel.org>; Sat, 31 Dec 2022 10:49:24 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 271FA1018C420;
        Sat, 31 Dec 2022 19:39:22 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 007466014655;
        Sat, 31 Dec 2022 19:39:21 +0100 (CET)
X-Mailbox-Line: From a2ff8481c3f08458dcd2b4028a838730e965c72f Mon Sep 17 00:00:00 2001
Message-Id: <a2ff8481c3f08458dcd2b4028a838730e965c72f.1672511017.git.lukas@wunner.de>
In-Reply-To: <cover.1672511016.git.lukas@wunner.de>
References: <cover.1672511016.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 31 Dec 2022 19:33:39 +0100
Subject: [PATCH 3/3] PCI/DPC: Await readiness of secondary bus after reset
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We're calling pci_bridge_wait_for_secondary_bus() after performing a
Secondary Bus Reset, but neglect to do the same after coming out of a
DPC-induced Hot Reset.  As a result, we're not observing the delays
prescribed by PCIe r6.0 sec 6.6.1 and may access devices on the
secondary bus before they're ready.  Fix it.

Tested-by: Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org
---
 drivers/pci/pci.c      | 3 ---
 drivers/pci/pci.h      | 3 +++
 drivers/pci/pcie/dpc.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b0b49243a908..19fe0ef0e583 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -167,9 +167,6 @@ static int __init pcie_port_pm_setup(char *str)
 }
 __setup("pcie_port_pm=", pcie_port_pm_setup);
 
-/* Time to wait after a reset for device to become responsive */
-#define PCIE_RESET_READY_POLL_MS 60000
-
 /**
  * pci_bus_max_busnr - returns maximum PCI bus number of given bus' children
  * @bus: pointer to PCI bus structure to search
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 40758248dd80..b72fd888379b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -7,6 +7,9 @@
 /* Number of possible devfns: 0.0 to 1f.7 inclusive */
 #define MAX_NR_DEVFNS 256
 
+/* Time to wait after a reset for device to become responsive */
+#define PCIE_RESET_READY_POLL_MS 60000
+
 #define PCI_FIND_CAP_TTL	48
 
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index f5ffea17c7f8..a5d7c69b764e 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -170,8 +170,8 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 			      PCI_EXP_DPC_STATUS_TRIGGER);
 
-	if (!pcie_wait_for_link(pdev, true)) {
-		pci_info(pdev, "Data Link Layer Link Active not set in 1000 msec\n");
+	if (pci_bridge_wait_for_secondary_bus(pdev, "DPC",
+					      PCIE_RESET_READY_POLL_MS)) {
 		clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
 		ret = PCI_ERS_RESULT_DISCONNECT;
 	} else {
-- 
2.39.0

