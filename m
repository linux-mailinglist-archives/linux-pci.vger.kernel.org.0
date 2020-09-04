Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036A725E095
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 19:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgIDRNo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 13:13:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:46046 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgIDRNo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Sep 2020 13:13:44 -0400
IronPort-SDR: iWYUxgCEQRG6+jCPbjuPj+omLA7gMMW8e88e6ZIUBQRUxZoYTWUo2LVXoq1VbDmhPhhT2CUW94
 a/Vo4u39YbYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="137840887"
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="137840887"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 10:13:32 -0700
IronPort-SDR: 8ic/UQ8nHq0W1toGxtslaSOFbB8wLYPYYZ4Jgjn5IrhbS8Ir1sUbXL64NOqoPKATzWdehYMY/N
 RzylmbOkf7yQ==
X-IronPort-AV: E=Sophos;i="5.76,390,1592895600"; 
   d="scan'208";a="478575139"
Received: from jderrick-mobl.amr.corp.intel.com ([10.252.142.77])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 10:13:32 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH] PCI: vmd: Add AHCI to fast interrupt list
Date:   Fri,  4 Sep 2020 11:13:25 -0600
Message-Id: <20200904171325.64959-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some platforms have an AHCI controller behind VMD. These platforms are
working correctly except for a case when the AHCI MSI is programmed with
VMD IRQ vector 0 (0xfee00000). When programmed with any other interrupt
(0xfeeNN000), the MSI is routed correctly and is handled by VMD. Placing
the AHCI MSI(s) in the fast-interrupt allow list solves the issue.

This also requires that VMD allocate more than one MSI/X vector and
changes the minimum MSI/X vectors allocated to two.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index f69ef8c89f72..d9c72613082a 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -202,15 +202,13 @@ static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd, struct msi_desc *d
 	int i, best = 1;
 	unsigned long flags;
 
-	if (vmd->msix_count == 1)
-		return &vmd->irqs[0];
-
 	/*
-	 * White list for fast-interrupt handlers. All others will share the
+	 * Allow list for fast-interrupt handlers. All others will share the
 	 * "slow" interrupt vector.
 	 */
 	switch (msi_desc_to_pci_dev(desc)->class) {
 	case PCI_CLASS_STORAGE_EXPRESS:
+	case PCI_CLASS_STORAGE_SATA_AHCI:
 		break;
 	default:
 		return &vmd->irqs[0];
@@ -657,7 +655,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (vmd->msix_count < 0)
 		return -ENODEV;
 
-	vmd->msix_count = pci_alloc_irq_vectors(dev, 1, vmd->msix_count,
+	vmd->msix_count = pci_alloc_irq_vectors(dev, 2, vmd->msix_count,
 					PCI_IRQ_MSIX);
 	if (vmd->msix_count < 0)
 		return vmd->msix_count;
-- 
2.17.1

