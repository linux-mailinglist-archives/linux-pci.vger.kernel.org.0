Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE09BAAC04
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 21:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390608AbfIETcD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 15:32:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731375AbfIETcD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 15:32:03 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9019D20825;
        Thu,  5 Sep 2019 19:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567711923;
        bh=QNbwv7VKjGJnBF0wl/tP/Qr1SWee/bk3a6j1ARBoM/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PAr9jY6gV/kF4f4YU8KttdPu4gLXPQ3SPQcwqqWKpjSFPoX24aOozPgL3HQohdAgp
         QEpCwl/6VcwbXkmnmGvgvPqelKPM34fAedYIs084eXOlNBoFOIk8A6Qsy1xLbTp9dM
         7AIRs1xlTOCpq+TmH7jvkHluoVyk+IlwwSigcOrw=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/5] PCI/ATS: Handle sharing of PF PRI Capability with all VFs
Date:   Thu,  5 Sep 2019 14:31:42 -0500
Message-Id: <20190905193146.90250-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190905193146.90250-1-helgaas@kernel.org>
References: <20190905193146.90250-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Per PCIe r5.0, sec 9.3.7.11, VFs must not implement the PRI Capability.  If
the PF implements PRI, it is shared by the VFs.  Since VFs don't have a PRI
Capability, pci_enable_pri() always failed, which caused IOMMU setup to
fail.

Update the PRI interfaces so for VFs they reflect the state of the PF PRI.

[bhelgaas: rebase without pri_cap caching, commit log]
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Link: https://lore.kernel.org/r/b971e31f8695980da8e4a7f93e3b6a3edba3edaa.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/ats.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index e18499243f84..3b1c9a2305c1 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -182,6 +182,17 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 	u32 max_requests;
 	int pos;
 
+	/*
+	 * VFs must not implement the PRI Capability.  If their PF
+	 * implements PRI, it is shared by the VFs, so if the PF PRI is
+	 * enabled, it is also enabled for the VF.
+	 */
+	if (pdev->is_virtfn) {
+		if (pci_physfn(pdev)->pri_enabled)
+			return 0;
+		return -EINVAL;
+	}
+
 	if (WARN_ON(pdev->pri_enabled))
 		return -EBUSY;
 
@@ -218,6 +229,10 @@ void pci_disable_pri(struct pci_dev *pdev)
 	u16 control;
 	int pos;
 
+	/* VFs share the PF PRI */
+	if (pdev->is_virtfn)
+		return;
+
 	if (WARN_ON(!pdev->pri_enabled))
 		return;
 
@@ -243,6 +258,9 @@ void pci_restore_pri_state(struct pci_dev *pdev)
 	u32 reqs = pdev->pri_reqs_alloc;
 	int pos;
 
+	if (pdev->is_virtfn)
+		return;
+
 	if (!pdev->pri_enabled)
 		return;
 
@@ -267,6 +285,9 @@ int pci_reset_pri(struct pci_dev *pdev)
 	u16 control;
 	int pos;
 
+	if (pdev->is_virtfn)
+		return 0;
+
 	if (WARN_ON(pdev->pri_enabled))
 		return -EBUSY;
 
@@ -412,6 +433,9 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 	u16 status;
 	int pos;
 
+	if (pdev->is_virtfn)
+		pdev = pci_physfn(pdev);
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
 	if (!pos)
 		return 0;
-- 
2.23.0.187.g17f5b7556c-goog

