Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B5E2C2346
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 11:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgKXKuo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Nov 2020 05:50:44 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7772 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgKXKuo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2020 05:50:44 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbce5860000>; Tue, 24 Nov 2020 02:50:46 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 24 Nov
 2020 10:50:41 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 24 Nov 2020 10:50:38 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2] PCI/MSI: Set device flag indicating only 32-bit MSI support
Date:   Tue, 24 Nov 2020 16:20:35 +0530
Message-ID: <20201124105035.24573-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117145728.4516-1-vidyas@nvidia.com>
References: <20201117145728.4516-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606215046; bh=3JBsQO4wFUzjO27TheH1pFiQ6ly/QM6C3KH95EJK6Eg=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=C56xgmlYh26LbnSdnf3nF/F3dfpAv2FsKvR19HHYd1r3UjHOJbtc2QsPTW20RruQ6
         JySyFKQCQ/rucKxME9Z9YZ987L0o1FlLZ65M+5vFTDixXIlaBF27FCkA7mjnUA1zSZ
         l/5JmMk+X8BFdniJrFavfXxoXRz7Al6y7ua9OP6DuA8KXaaUCO2DTfPdx0uBZFAkVb
         cI3XsT8GWAcxIRU5geI8iMxN2yF91jZ4IN7jZdvDpvqaIfguA0Vap+vaUmxuxDIrgA
         atjlIjWyJtKH4dSDtwmRf19KvuCy3dCFdq7IvR3JM+P/+kBd3Pt197GkeS3+cgLEbp
         Uex0+7N+J0m1Q==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are devices (Ex:- Marvell SATA controller) that don't support
64-bit MSIs and the same is advertised through their MSI capability
register. Set no_64bit_msi flag explicitly for such devices in the
MSI setup code so that the msi_verify_entries() API would catch
if the MSI arch code tries to use 64-bit MSI.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* Addressed Bjorn's comment and changed the error message

 drivers/pci/msi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d52d118979a6..8de5ba6b4a59 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -581,10 +581,12 @@ msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
 	entry->msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
 	entry->msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
 
-	if (control & PCI_MSI_FLAGS_64BIT)
+	if (control & PCI_MSI_FLAGS_64BIT) {
 		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
-	else
+	} else {
 		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
+		dev->no_64bit_msi = 1;
+	}
 
 	/* Save the initial mask status */
 	if (entry->msi_attrib.maskbit)
@@ -602,8 +604,9 @@ static int msi_verify_entries(struct pci_dev *dev)
 	for_each_pci_msi_entry(entry, dev) {
 		if (!dev->no_64bit_msi || !entry->msg.address_hi)
 			continue;
-		pci_err(dev, "Device has broken 64-bit MSI but arch"
-			" tried to assign one above 4G\n");
+		pci_err(dev, "Device has either broken 64-bit MSI or "
+			"only 32-bit MSI support but "
+			"arch tried to assign one above 4G\n");
 		return -EIO;
 	}
 	return 0;
-- 
2.17.1

