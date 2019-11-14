Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA245FD0B4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2019 23:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKNWGL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Nov 2019 17:06:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:49834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfKNWGL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Nov 2019 17:06:11 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EF702070E;
        Thu, 14 Nov 2019 22:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573769169;
        bh=vVOkLYuC6as3rxJv57TqAu6jIytxuioP/q1nBZbK83E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DRtuDrty2w+12mqARWUHYWfJtkJokjdktcuJF7ry6tCERqTOccx+ycy4iDPpRhETc
         wm4Vwo/5Z3s4+TUOd+wsILCS2tfjbicW4/kRqPY2mkWoXM6zYr6uvuNiw8RQtPmIyM
         R4SU8tZ1FUJDuPfOR4q7Gml3+IW/1r3eHb9DJ6/4=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org
Cc:     George Cherian <george.cherian@marvell.com>,
        Robert Richter <rrichter@marvell.com>, Feng Kan <fkan@apm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Abhinav Ratna <abhinav.ratna@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] PCI: Make ACS quirk implementations more uniform
Date:   Thu, 14 Nov 2019 16:06:00 -0600
Message-Id: <20191114220601.261647-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191114220601.261647-1-helgaas@kernel.org>
References: <20191114220601.261647-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The ACS quirks differ in needless ways, which makes them look more
different than they really are.

Reorder the ACS flags in order of definitions in the spec:

  PCI_ACS_SV   Source Validation
  PCI_ACS_TB   Translation Blocking
  PCI_ACS_RR   P2P Request Redirect
  PCI_ACS_CR   P2P Completion Redirect
  PCI_ACS_UF   Upstream Forwarding
  PCI_ACS_EC   P2P Egress Control
  PCI_ACS_DT   Direct Translated P2P

(PCIe r5.0, sec 7.7.8.2) and use similar code structure in all.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/quirks.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2544e210b984..59f73d084e1d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4366,18 +4366,18 @@ static bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
 
 static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
 {
+	if (!pci_quirk_cavium_acs_match(dev))
+		return -ENOTTY;
+
 	/*
-	 * Cavium root ports don't advertise an ACS capability.  However,
+	 * Cavium Root Ports don't advertise an ACS capability.  However,
 	 * the RTL internally implements similar protection as if ACS had
-	 * Request Redirection, Completion Redirection, Source Validation,
+	 * Source Validation, Request Redirection, Completion Redirection,
 	 * and Upstream Forwarding features enabled.  Assert that the
 	 * hardware implements and enables equivalent ACS functionality for
 	 * these flags.
 	 */
-	acs_flags &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_SV | PCI_ACS_UF);
-
-	if (!pci_quirk_cavium_acs_match(dev))
-		return -ENOTTY;
+	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 
 	return acs_flags ? 0 : 1;
 }
@@ -4395,7 +4395,7 @@ static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
 }
 
 /*
- * Many Intel PCH root ports do provide ACS-like features to disable peer
+ * Many Intel PCH Root Ports do provide ACS-like features to disable peer
  * transactions and validate bus numbers in requests, but do not provide an
  * actual PCIe ACS capability.  This is the list of device IDs known to fall
  * into that category as provided by Intel in Red Hat bugzilla 1037684.
@@ -4443,37 +4443,34 @@ static bool pci_quirk_intel_pch_acs_match(struct pci_dev *dev)
 	return false;
 }
 
-#define INTEL_PCH_ACS_FLAGS (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_SV)
+#define INTEL_PCH_ACS_FLAGS (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
 
 static int pci_quirk_intel_pch_acs(struct pci_dev *dev, u16 acs_flags)
 {
-	u16 flags = dev->dev_flags & PCI_DEV_FLAGS_ACS_ENABLED_QUIRK ?
-		    INTEL_PCH_ACS_FLAGS : 0;
-
 	if (!pci_quirk_intel_pch_acs_match(dev))
 		return -ENOTTY;
 
-	return acs_flags & ~flags ? 0 : 1;
+	if (dev->dev_flags & PCI_DEV_FLAGS_ACS_ENABLED_QUIRK)
+		acs_flags &= ~(INTEL_PCH_ACS_FLAGS);
+
+	return acs_flags ? 0 : 1;
 }
 
 /*
- * These QCOM root ports do provide ACS-like features to disable peer
+ * These QCOM Root Ports do provide ACS-like features to disable peer
  * transactions and validate bus numbers in requests, but do not provide an
  * actual PCIe ACS capability.  Hardware supports source validation but it
  * will report the issue as Completer Abort instead of ACS Violation.
- * Hardware doesn't support peer-to-peer and each root port is a root
- * complex with unique segment numbers.  It is not possible for one root
- * port to pass traffic to another root port.  All PCIe transactions are
- * terminated inside the root port.
+ * Hardware doesn't support peer-to-peer and each Root Port is a Root
+ * Complex with unique segment numbers.  It is not possible for one Root
+ * Port to pass traffic to another Root Port.  All PCIe transactions are
+ * terminated inside the Root Port.
  */
 static int pci_quirk_qcom_rp_acs(struct pci_dev *dev, u16 acs_flags)
 {
-	u16 flags = (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_SV);
-	int ret = acs_flags & ~flags ? 0 : 1;
-
-	pci_info(dev, "Using QCOM ACS Quirk (%d)\n", ret);
+	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 
-	return ret;
+	return acs_flags ? 0 : 1;
 }
 
 static int pci_quirk_al_acs(struct pci_dev *dev, u16 acs_flags)
-- 
2.24.0.432.g9d3f5f5b63-goog

