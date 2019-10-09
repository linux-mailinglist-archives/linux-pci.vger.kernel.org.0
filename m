Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16DC4D1C43
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 00:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbfJIWyL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 18:54:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:32962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732287AbfJIWyK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Oct 2019 18:54:10 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C57220B7C;
        Wed,  9 Oct 2019 22:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570661650;
        bh=8Nlqxp+t3d/SxUKiK4OInRALysoVn832+0LN9EyvS/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EyunVZAf/t7AAzUOk50vb9ICtbpAKLycfzckejjaZk0NQaoCpAdoUQKDymAMBrLIS
         kwDGcBB7vMrZ23FfY3++/mT+qhYoUFsgO3vK6qOIk8Sla3TLK58iFU4Yu0C3Tzqkku
         97fAiowVbzFyJKVvLHFGeBS5wi7fCM5aqBVafNOI=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/3] PCI/ATS: Remove unused PRI and PASID stubs
Date:   Wed,  9 Oct 2019 17:53:52 -0500
Message-Id: <20191009225354.181018-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191009225354.181018-1-helgaas@kernel.org>
References: <20191009225354.181018-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The following functions are only used by amd_iommu.c and intel-iommu.c
(when CONFIG_INTEL_IOMMU_SVM is enabled).  CONFIG_PCI_PRI and
CONFIG_PCI_PASID are always defined in those cases, so there's no need for
the stubs.

  pci_enable_pri()
  pci_disable_pri()
  pci_reset_pri()
  pci_prg_resp_pasid_required()
  pci_enable_pasid()
  pci_disable_pasid()

Remove the unused stubs.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci-ats.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 67de3a9499bb..963c11f7c56b 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -27,14 +27,7 @@ void pci_restore_pri_state(struct pci_dev *pdev);
 int pci_reset_pri(struct pci_dev *pdev);
 int pci_prg_resp_pasid_required(struct pci_dev *pdev);
 #else /* CONFIG_PCI_PRI */
-static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
-{ return -ENODEV; }
-static inline void pci_disable_pri(struct pci_dev *pdev) { }
 static inline void pci_restore_pri_state(struct pci_dev *pdev) { }
-static inline int pci_reset_pri(struct pci_dev *pdev)
-{ return -ENODEV; }
-static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
-{ return 0; }
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
@@ -44,9 +37,6 @@ void pci_restore_pasid_state(struct pci_dev *pdev);
 int pci_pasid_features(struct pci_dev *pdev);
 int pci_max_pasids(struct pci_dev *pdev);
 #else /* CONFIG_PCI_PASID */
-static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
-{ return -EINVAL; }
-static inline void pci_disable_pasid(struct pci_dev *pdev) { }
 static inline void pci_restore_pasid_state(struct pci_dev *pdev) { }
 static inline int pci_pasid_features(struct pci_dev *pdev)
 { return -EINVAL; }
-- 
2.23.0.581.g78d2f28ef7-goog

