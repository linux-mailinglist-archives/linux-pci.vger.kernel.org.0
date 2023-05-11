Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2926FF166
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 14:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjEKMS7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 08:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjEKMS6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 08:18:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC470107
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2023 05:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683807537; x=1715343537;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4eNzcfjfSM3kDdNpWkkdr1yq1ubOgwe2K4qz7dvApcw=;
  b=WJmGlNMZGEeVCSBAIrfQHND/IY9mU0kyfbEz7vnUc8MDOIG+ls32OKkC
   Yg6S0ZPAlpgdG7b3JUIGBpztbC4aTS8M8yGk0qcEGhSPCl+qcstr6ESua
   S9ReNoyiPqhdryhER73PnpaoPWh62MFeHQ3+KOzZu2qo/9WCCu1fcV6Yx
   M08HxOWKhmtORZ8MNbQly30hSHNMt8Bu0Oj4qL62s2A9vCQ8KLR8lEmyz
   rStfzQpDdzgYVAOD1pNAk3n3H9jJ9p2IMg0NRsEV/cpf3QO8NQghSfXfp
   OQ38U6VQ+ZArE7QBMXPmgu5ywysXQzmgjLwzG1SeUUDOGe33SY8Fr66sm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="413813520"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="413813520"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 05:18:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="677218453"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="677218453"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 11 May 2023 05:18:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B5C771FC; Thu, 11 May 2023 15:19:05 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Mark Blakeney <mark.blakeney@bullet-systems.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI/DPC: Apply PIO log size quirk to Intel Ice Lake Root Ports too
Date:   Thu, 11 May 2023 15:19:05 +0300
Message-Id: <20230511121905.73949-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 5459c0b70467 ("PCI/DPC: Quirk PIO log size for certain Intel Root
Ports") added quirk for Tiger and Alder Lake Root Ports but missed that
the same issue exists also in the previous generation, Ice Lake, Root
Ports.

For this reason apply the quirk for Ice Lake Root Ports as well.

Reported-by: Mark Blakeney <mark.blakeney@bullet-systems.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=209943
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/quirks.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b0304fc97c22..8206228a95e1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6006,8 +6006,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency
 
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
@@ -6030,6 +6031,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x461f, dpc_log_size);
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

