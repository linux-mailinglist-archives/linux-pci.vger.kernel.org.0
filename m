Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55E00AAC08
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 21:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbfIETcK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 15:32:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729209AbfIETcK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 15:32:10 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 042FE20825;
        Thu,  5 Sep 2019 19:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567711930;
        bh=l1B9NrEMtrPqREFjfDsxHkm/QP7QX3vC/W5IY0dLndU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XcSmBkdHsCjayPvh1on2a38To674ibdlKqRr4wSrS7Wbd1M9ZuDXdE71fC9cKSWA7
         WMKJwHxsnjK4IY+Gx9WkjdksQM14DEicahvvfE1Tm5tV+4g8EKCighcAZdWhd9Zr9/
         Bz+JgclyAJARnAFPQpVNKCMOaFqVRflsliYarb80=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/5] PCI/ATS: Disable PF/VF ATS service independently
Date:   Thu,  5 Sep 2019 14:31:44 -0500
Message-Id: <20190905193146.90250-4-helgaas@kernel.org>
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

Previously we didn't disable the PF ATS until all associated VFs had
disabled it.  But per PCIe spec r5.0, sec 9.3.7.8, the ATS Capability in
VFs and associated PFs may be enabled independently.  Leaving ATS enabled
in the PF unnecessarily may have power and performance impacts.

Remove this dependency logic in the ATS enable/disable code.

[bhelgaas: commit log]
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Link: https://lore.kernel.org/r/8163ab8fa66afd2cba514ae95d29ab12104781aa.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/ats.c   | 11 -----------
 include/linux/pci.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index ab928f8267cf..920deeccf38d 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -60,8 +60,6 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 		pdev = pci_physfn(dev);
 		if (pdev->ats_stu != ps)
 			return -EINVAL;
-
-		atomic_inc(&pdev->ats_ref_cnt);  /* count enabled VFs */
 	} else {
 		dev->ats_stu = ps;
 		ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
@@ -79,20 +77,11 @@ EXPORT_SYMBOL_GPL(pci_enable_ats);
  */
 void pci_disable_ats(struct pci_dev *dev)
 {
-	struct pci_dev *pdev;
 	u16 ctrl;
 
 	if (WARN_ON(!dev->ats_enabled))
 		return;
 
-	if (atomic_read(&dev->ats_ref_cnt))
-		return;		/* VFs still enabled */
-
-	if (dev->is_virtfn) {
-		pdev = pci_physfn(dev);
-		atomic_dec(&pdev->ats_ref_cnt);
-	}
-
 	pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, &ctrl);
 	ctrl &= ~PCI_ATS_CTRL_ENABLE;
 	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9e700d9f9f28..a73e8d28a896 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -452,7 +452,6 @@ struct pci_dev {
 	};
 	u16		ats_cap;	/* ATS Capability offset */
 	u8		ats_stu;	/* ATS Smallest Translation Unit */
-	atomic_t	ats_ref_cnt;	/* Number of VFs with ATS enabled */
 #endif
 #ifdef CONFIG_PCI_PRI
 	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
-- 
2.23.0.187.g17f5b7556c-goog

