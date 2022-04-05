Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4914A4F36E6
	for <lists+linux-pci@lfdr.de>; Tue,  5 Apr 2022 16:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbiDELI4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 07:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348946AbiDEJst (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 05:48:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BADEE4F3
        for <linux-pci@vger.kernel.org>; Tue,  5 Apr 2022 02:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649151469; x=1680687469;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oI74HRdK6wyclicn+isgT5qaWpbGXa6hkATJ83x8Na0=;
  b=bQ3BUvv20UG6qqJwUctksAttqOzCqtJ5qMEeZODelaky5HUuy8tXZBTF
   qbNW1KK/1ba7rd1+SzhtL2GVpS9PZmTyzxtiu6kFHU7+W1R6gq48AsOPg
   nArD5dRCamTI8C23mtb9BGrHLkikzYXG90D5DFlVrBRt5n/M9Kx0gN+Aw
   4I3IhbKrkdmVIoXeM59M/q7DUnMxYy5TmHyZfkA8PU4G2ATptuUvyXxUt
   mBSyXFrfsF8PBDLNBPNN5OhkbC4IiyhHt+c54BwU6C1nfCTyYQS48JxFV
   S9OKpoZx+iGzJiO1kWsOlCOPs6pJqZk71kSJJGuEncAtQh7C0hh8fBmmB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="347148026"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="347148026"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 02:37:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="608377462"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2022 02:37:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C9B2032A; Tue,  5 Apr 2022 12:38:10 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Quirk Intel DG2 ASPM L1 acceptable latency to be unlimited
Date:   Tue,  5 Apr 2022 12:38:10 +0300
Message-Id: <20220405093810.76613-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

Intel DG2 discrete graphics PCIe endpoints hard-code their acceptable L1
ASPM latency to be < 1us even though the hardware actually supports
higher latencies (> 64 us) just fine. In order to allow the links to go
into L1 and save power, quirk the acceptable L1 ASPM latency for these
endpoints to be unlimited.

Note this does not have any effect unless the user requested the kernel
to enable ASPM in the first place (by default we don't enable it). This
is done with "pcie_aspm=force pcie_aspm.policy=powersupsersave" command
line parameters.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/quirks.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index da829274fc66..e97b5daa00eb 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5895,3 +5895,47 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1533, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
+
+#ifdef CONFIG_PCIEASPM
+/*
+ * Intel DG2 graphics card has hard-coded acceptable L1 latency that is
+ * too low which prevents ASPM to be enabled. It does support ASPM L1
+ * and tolerates higher latencies so quirk it to be unlimited.
+ */
+static void quirk_aspm_accepted_l1_latency(struct pci_dev *dev)
+{
+	if ((dev->devcap & PCI_EXP_DEVCAP_L1) >> 9 < 7) {
+		u32 devcap = dev->devcap;
+
+		dev->devcap |= 7 << 9;
+		pci_info(dev, "quirking devcap for L1 accepted latency 0x%08x -> 0x%08x\n",
+			 devcap, dev->devcap);
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f80, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f81, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f82, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f83, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f84, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f85, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f86, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f87, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4f88, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5690, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5691, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5692, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5693, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5694, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5695, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a0, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a1, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a2, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a3, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a4, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a5, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56a6, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b0, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, quirk_aspm_accepted_l1_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, quirk_aspm_accepted_l1_latency);
+#endif
-- 
2.35.1

