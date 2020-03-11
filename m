Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A67C1180F01
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 05:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgCKEw7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 00:52:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38339 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgCKEw7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 00:52:59 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jBtMV-000640-8p; Wed, 11 Mar 2020 04:52:55 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] PCI/PM: Skip link training delay for S3 resume
Date:   Wed, 11 Mar 2020 12:52:49 +0800
Message-Id: <20200311045249.5200-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit ad9001f2f411 ("PCI/PM: Add missing link delays required by the
PCIe spec") added a 1100ms delay on resume for bridges that don't
support Link Active Reporting.

The commit also states that the delay can be skipped for S3, as the
firmware should already handled the case for us.

So let's skip the link training delay for S3, to save 1100ms resume
time.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pci-driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 0454ca0e4e3f..3050375bad04 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -916,7 +916,8 @@ static int pci_pm_resume_noirq(struct device *dev)
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 	pcie_pme_root_status_cleanup(pci_dev);
 
-	if (!skip_bus_pm && prev_state == PCI_D3cold)
+	if (!skip_bus_pm && prev_state == PCI_D3cold
+	    && !pm_resume_via_firmware())
 		pci_bridge_wait_for_secondary_bus(pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))
-- 
2.17.1

