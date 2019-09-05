Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78B9FAAC06
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 21:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390668AbfIETcG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 15:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731375AbfIETcG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 15:32:06 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6147220825;
        Thu,  5 Sep 2019 19:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567711926;
        bh=SmwJMLR+m00TaQ+fo1Kofr+s5/dJAG03KJZUl3/8S1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NRBZ4izvA63ZK8ELUKTicOUrIZJxSqLjce2UmxoOzjYI7UIEc9409GA+Kfj/cs33i
         fy7/gZGuN0ruMK7h/TWQ/7FJVYFM/SwdWQ4syFGyN7dDOUnpksQ1ijSGSZgt/vqny4
         31Dj3VtYDUDpp53aNClqtm4AiBMnzk4ntnb4L8Yg=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/5] PCI/ATS: Handle sharing of PF PASID Capability with all VFs
Date:   Thu,  5 Sep 2019 14:31:43 -0500
Message-Id: <20190905193146.90250-3-helgaas@kernel.org>
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

Per PCIe r5.0, sec 9.3.7.14, if a PF implements the PASID Capability, the
PF PASID configuration is shared by its VFs.  VFs must not implement their
own PASID Capability.  Since VFs don't have a PASID Capability,
pci_enable_pasid() always failed, which caused IOMMU setup to fail.

Update the PASID interfaces so for VFs they reflect the state of the PF
PASID.

[bhelgaas: rebase without pasid_cap caching, commit log]
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Link: https://lore.kernel.org/r/8ba1ac192e4ac737508b6ac15002158e176bab91.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/ats.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 3b1c9a2305c1..ab928f8267cf 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -318,6 +318,16 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	u16 control, supported;
 	int pos;
 
+	/*
+	 * VFs must not implement the PASID Capability, but if a PF
+	 * supports PASID, its VFs share the PF PASID configuration.
+	 */
+	if (pdev->is_virtfn) {
+		if (pci_physfn(pdev)->pasid_enabled)
+			return 0;
+		return -EINVAL;
+	}
+
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
 
@@ -355,6 +365,10 @@ void pci_disable_pasid(struct pci_dev *pdev)
 	u16 control = 0;
 	int pos;
 
+	/* VFs share the PF PASID configuration */
+	if (pdev->is_virtfn)
+		return;
+
 	if (WARN_ON(!pdev->pasid_enabled))
 		return;
 
@@ -377,6 +391,9 @@ void pci_restore_pasid_state(struct pci_dev *pdev)
 	u16 control;
 	int pos;
 
+	if (pdev->is_virtfn)
+		return;
+
 	if (!pdev->pasid_enabled)
 		return;
 
@@ -404,6 +421,9 @@ int pci_pasid_features(struct pci_dev *pdev)
 	u16 supported;
 	int pos;
 
+	if (pdev->is_virtfn)
+		pdev = pci_physfn(pdev);
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
 	if (!pos)
 		return -EINVAL;
@@ -463,6 +483,9 @@ int pci_max_pasids(struct pci_dev *pdev)
 	u16 supported;
 	int pos;
 
+	if (pdev->is_virtfn)
+		pdev = pci_physfn(pdev);
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
 	if (!pos)
 		return -EINVAL;
-- 
2.23.0.187.g17f5b7556c-goog

