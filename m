Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF08230809
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 12:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgG1KqE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 06:46:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50252 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbgG1KqE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jul 2020 06:46:04 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1k0N7R-0004YP-H8; Tue, 28 Jul 2020 10:46:02 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: Mark AMD Navi10 GPU rev 0x00 ATS as broken
Date:   Tue, 28 Jul 2020 18:45:53 +0800
Message-Id: <20200728104554.28927-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We are seeing AMD Radeon Pro W5700 doesn't work when IOMMU is enabled:
[    3.375841] iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=63:00.0 address=0x42b5b01a0]
[    3.375845] iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=63:00.0 address=0x42b5b01c0]

The error also makes graphics driver fail to probe the device.

It appears to be the same issue as commit 5e89cd303e3a ("PCI: Mark AMD
Navi14 GPU rev 0xc5 ATS as broken") addresses, and indeed the same ATS
quirk can workaround the issue.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=208725
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/quirks.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 812bfc32ecb8..052efeb9f053 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5192,7 +5192,8 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
  */
 static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
 {
-	if (pdev->device == 0x7340 && pdev->revision != 0xc5)
+	if ((pdev->device == 0x7312 && pdev->revision != 0x00) ||
+	    (pdev->device == 0x7340 && pdev->revision != 0xc5))
 		return;
 
 	pci_info(pdev, "disabling ATS\n");
@@ -5203,6 +5204,8 @@ static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_amd_harvest_no_ats);
 /* AMD Iceland dGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
+/* AMD Navi10 dGPU */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
 /* AMD Navi14 dGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
 #endif /* CONFIG_PCI_ATS */
-- 
2.17.1

