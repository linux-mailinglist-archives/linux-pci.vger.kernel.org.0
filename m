Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45A2EF1CA8
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 18:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbfKFRmH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 12:42:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:23987 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728983AbfKFRmG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 12:42:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 09:42:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="192539718"
Received: from mton-linux-test2.lm.intel.com (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.117.44])
  by orsmga007.jf.intel.com with ESMTP; 06 Nov 2019 09:42:05 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 1/3] PCI: vmd: Reduce VMD vectors using NVMe calculation
Date:   Wed,  6 Nov 2019 04:40:06 -0700
Message-Id: <1573040408-3831-2-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to better affine VMD IRQs, VMD IRQ lists, and child NVMe
devices, reduce the number of VMD vectors exposed to the MSI domain
using the same calculation as NVMe. VMD will still retain one vector for
pciehp and non-NVMe vectors. The remaining will match the maximum number
of NVMe child device IO vectors.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 8bce647..ebe7ff6 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -260,9 +260,20 @@ static int vmd_msi_prepare(struct irq_domain *domain, struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct vmd_dev *vmd = vmd_from_bus(pdev->bus);
+	int max_vectors;
 
-	if (nvec > vmd->msix_count)
-		return vmd->msix_count;
+	/*
+	 * VMD exists primarily as an NVMe storage domain. It thus makes sense
+	 * to reduce the number of VMD vectors exposed to child devices using
+	 * the same calculation as the NVMe driver. This allows better affinity
+	 * matching along the entire stack when multiple device vectors share
+	 * VMD IRQ lists. One additional VMD vector is reserved for pciehp and
+	 * non-NVMe interrupts, and NVMe Admin Queue interrupts can also be
+	 * placed on this slow interrupt.
+	 */
+	max_vectors = min_t(int, vmd->msix_count, num_possible_cpus() + 1);
+	if (nvec > max_vectors)
+		return max_vectors;
 
 	memset(arg, 0, sizeof(*arg));
 	return 0;
-- 
1.8.3.1

