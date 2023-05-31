Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B78718298
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 15:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbjEaNoW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 09:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbjEaNoB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 09:44:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D508D10C0;
        Wed, 31 May 2023 06:42:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6122A63B28;
        Wed, 31 May 2023 13:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CA8C433D2;
        Wed, 31 May 2023 13:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540537;
        bh=fdVj8BXjOEAs5TW0LSt3vogjdTYde6j0fNINNh2ZRzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KEmfH/KgS146P7MiVcA9cJqmJnFOVRkgvCBOa8kPfKhMfJU6JMYNl/kqTEsNQ19Yh
         gxUM6Ap+PCvohN/bTaKA6e9t1hLuRvAjo5B5BfqnkDINfP+L+emmLRzVlkeV5wPum9
         aw4ZDb6aMhaE/iAupSR6IVy9fEcpxw2GXqxTKF5SGinUbxbhdyjq8vghpKUBqEc531
         S/eHu9fv+v5SOm8qxY2saQqtYIQRCFsLI8G9DzgIHCFXGZbWC2rAyftW1mH1kl+Hyb
         21kZU8rarLaRhSsEgO5I8zAR4yJfbloEx5s5sYWf6Oyh5k12gCv6RjwGFBJJ8d+W60
         uJUZE7PP8GkSg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Blakeney <mark.blakeney@bullet-systems.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 08/33] PCI/DPC: Quirk PIO log size for Intel Ice Lake Root Ports
Date:   Wed, 31 May 2023 09:41:34 -0400
Message-Id: <20230531134159.3383703-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134159.3383703-1-sashal@kernel.org>
References: <20230531134159.3383703-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 3b8803494a0612acdeee714cb72aa142b1e05ce5 ]

Commit 5459c0b70467 ("PCI/DPC: Quirk PIO log size for certain Intel Root
Ports") added quirks for Tiger and Alder Lake Root Ports but missed that
the same issue exists also in the previous generation, Ice Lake.

Apply the quirk for Ice Lake Root Ports as well.  This prevents kernel
complaints like:

  DPC: RP PIO log size 0 is invalid

and also enables the DPC driver to dump the RP PIO Log registers when DPC
is triggered.

[bhelgaas: add dmesg warning and RP PIO Log dump info]
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=209943
Link: https://lore.kernel.org/r/20230511121905.73949-1-mika.westerberg@linux.intel.com
Reported-by: Mark Blakeney <mark.blakeney@bullet-systems.net>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8d32a3834688f..ccc90656130a0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5995,8 +5995,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency
 
 #ifdef CONFIG_PCIE_DPC
 /*
- * Intel Tiger Lake and Alder Lake BIOS has a bug that clears the DPC
- * RP PIO Log Size of the integrated Thunderbolt PCIe Root Ports.
+ * Intel Ice Lake, Tiger Lake and Alder Lake BIOS has a bug that clears
+ * the DPC RP PIO Log Size of the integrated Thunderbolt PCIe Root
+ * Ports.
  */
 static void dpc_log_size(struct pci_dev *dev)
 {
@@ -6019,6 +6020,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x461f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x462f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x463f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x466e, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8a1d, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8a1f, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8a21, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8a23, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a23, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a25, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a27, dpc_log_size);
-- 
2.39.2

