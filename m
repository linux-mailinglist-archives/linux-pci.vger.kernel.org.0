Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B87D1C1C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 00:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbfJIWqp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 18:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731736AbfJIWqp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Oct 2019 18:46:45 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27B9820B7C;
        Wed,  9 Oct 2019 22:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570661204;
        bh=T/sptErry+zYk95pBQaGv5ewZEsfKA7Zo0hyLyEPIq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bbdtngIW/1XIXa2HYPt9nI8DYeCsu41NxFgraLGnT40mZz/QrqLMgSYV0w6C7ZDSY
         mFue7vHyVXdqTpjRw8r39G469v35jYvYg9Ibyhjt4vBcNyYWbf0U7jj3obe3EaVPW+
         Mr3Rpp9UzjbMDPhqnp/EO+aZVreadWgsxjQSv9MU=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] iommu/vt-d: Select PCI_PRI for INTEL_IOMMU_SVM
Date:   Wed,  9 Oct 2019 17:45:50 -0500
Message-Id: <20191009224551.179497-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191009224551.179497-1-helgaas@kernel.org>
References: <20191009224551.179497-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

When CONFIG_INTEL_IOMMU_SVM=y, iommu_enable_dev_iotlb() calls PRI
interfaces (pci_reset_pri() and pci_enable_pri()), but those are only
implemented when CONFIG_PCI_PRI is enabled.

Previously INTEL_IOMMU_SVM selected PCI_PASID but not PCI_PRI, so the state
of PCI_PRI depended on whether AMD_IOMMU (which selects PCI_PRI) was
enabled or PCI_PRI was enabled explicitly.

The behavior of iommu_enable_dev_iotlb() should not depend on whether
AMD_IOMMU is enabled.  Make it predictable by having INTEL_IOMMU_SVM select
PCI_PRI so iommu_enable_dev_iotlb() always uses the full implementations of
PRI interfaces.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e3842eabcfdd..b183c9f916b0 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -207,6 +207,7 @@ config INTEL_IOMMU_SVM
 	bool "Support for Shared Virtual Memory with Intel IOMMU"
 	depends on INTEL_IOMMU && X86
 	select PCI_PASID
+	select PCI_PRI
 	select MMU_NOTIFIER
 	help
 	  Shared Virtual Memory (SVM) provides a facility for devices
-- 
2.23.0.581.g78d2f28ef7-goog

