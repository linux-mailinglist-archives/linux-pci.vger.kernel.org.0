Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80217AA4FA
	for <lists+linux-pci@lfdr.de>; Fri, 22 Sep 2023 00:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjIUW1L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 18:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjIUW0w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 18:26:52 -0400
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3224A75DB
        for <linux-pci@vger.kernel.org>; Thu, 21 Sep 2023 11:01:09 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 9417C100411AD;
        Thu, 21 Sep 2023 16:23:37 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 67BE360DC7C4;
        Thu, 21 Sep 2023 16:23:37 +0200 (CEST)
X-Mailbox-Line: From 47727e792c7f0282dc144e3ec8ce8eb6e713394e Mon Sep 17 00:00:00 2001
Message-Id: <47727e792c7f0282dc144e3ec8ce8eb6e713394e.1695304512.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Thu, 21 Sep 2023 16:23:34 +0200
Subject: [PATCH] PCI: Lengthen reset delay for VideoPropulsion Torrent QN16e
 card
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Chad Schroeder <CSchroeder@sonifi.com>, linux-pci@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit ac91e6980563 ("PCI: Unify delay handling for reset and resume")
shortened an unconditional 1 sec delay after a Secondary Bus Reset to
100 msec for PCIe (per PCIe r6.1 sec 6.6.1).  The 1 sec delay is only
required for Conventional PCI.

But it turns out that there are PCIe devices which require a longer
delay than prescribed before first config space access after reset
recovery or resume from D3cold:

Chad reports that a "VideoPropulsion Torrent QN16e" MPEG QAM Modulator
"raises a PCI system error (PERR), as reported by the IPMI event log,
and the hardware itself would suffer a catastrophic event, cycling the
server" unless the longer delay is observed.

The card is specified to conform to PCIe r1.0 and indeed only supports
Gen1 speed (2.5 GT/s) according to lspci.  PCIe r1.0 sec 7.6 prescribes
the same 100 msec delay as PCIe r6.1 sec 6.6.1:

 "To allow components to perform internal initialization, system software
  must wait for at least 100 ms from the end of a reset (cold/warm/hot)
  before it is permitted to issue Configuration Requests"

The behavior of the Torrent QN16e card thus appears to be a quirk.
Treat it as such and lengthen the reset delay for this specific device.

Fixes: ac91e6980563 ("PCI: Unify delay handling for reset and resume")
Closes: https://lore.kernel.org/linux-pci/DM6PR16MB2844903E34CAB910082DF019B1FAA@DM6PR16MB2844.namprd16.prod.outlook.com/
Reported-by: Chad Schroeder <CSchroeder@sonifi.com>
Tested-by: Chad Schroeder <CSchroeder@sonifi.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v5.4+
---
 drivers/pci/quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index eeec1d6f9023..91a15d79c7c4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6188,3 +6188,15 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
+
+/*
+ * Devices known to require a longer delay before first config space access
+ * after reset recovery or resume from D3cold:
+ *
+ * VideoPropulsion (aka Genroco) Torrent QN16e MPEG QAM Modulator
+ */
+static void pci_fixup_d3cold_delay_1sec(struct pci_dev *pdev)
+{
+	pdev->d3cold_delay = 1000;
+}
+DECLARE_PCI_FIXUP_FINAL(0x5555, 0x0004, pci_fixup_d3cold_delay_1sec);
-- 
2.40.1

