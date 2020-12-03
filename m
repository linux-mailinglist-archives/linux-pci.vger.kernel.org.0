Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB7B2CDE0F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 19:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbgLCSwG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 13:52:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731716AbgLCSwG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Dec 2020 13:52:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Kishore <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Vidya Sagar <sagar.tv@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 3/3] PCI/MSI: Set device flag indicating only 32-bit MSI support
Date:   Thu,  3 Dec 2020 12:51:10 -0600
Message-Id: <20201203185110.1583077-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203185110.1583077-1-helgaas@kernel.org>
References: <20201203185110.1583077-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Vidya Sagar <vidyas@nvidia.com>

The MSI-X Capability requires devices to support 64-bit Message Addresses,
but the MSI Capability can support either 32- or 64-bit addresses.

Previously, we set dev->no_64bit_msi for a few broken devices that
advertise 64-bit MSI support but don't correctly support it.

In addition, check the MSI "64-bit Address Capable" bit for all devices and
set dev->no_64bit_msi for devices that don't advertise 64-bit support.
This allows msi_verify_entries() to catch arch code defects that assign
64-bit addresses when they're not supported.

[bhelgaas: set no_64bit_msi in pci_msi_init(), commit log]
Link: https://lore.kernel.org/r/20201124105035.24573-1-vidyas@nvidia.com
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 3e302ca8a96f..29baa81e7be9 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -623,11 +623,11 @@ static int msi_verify_entries(struct pci_dev *dev)
 	struct msi_desc *entry;
 
 	for_each_pci_msi_entry(entry, dev) {
-		if (!dev->no_64bit_msi || !entry->msg.address_hi)
-			continue;
-		pci_err(dev, "Device has broken 64-bit MSI but arch"
-			" tried to assign one above 4G\n");
-		return -EIO;
+		if (entry->msg.address_hi && dev->no_64bit_msi) {
+			pci_err(dev, "arch assigned 64-bit MSI address %#x%08x but device only supports 32 bits\n",
+				entry->msg.address_hi, entry->msg.address_lo);
+			return -EIO;
+		}
 	}
 	return 0;
 }
@@ -1619,6 +1619,9 @@ void pci_msi_init(struct pci_dev *dev)
 	if (ctrl & PCI_MSI_FLAGS_ENABLE)
 		pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS,
 				      ctrl & ~PCI_MSI_FLAGS_ENABLE);
+
+	if (!(ctrl & PCI_MSI_FLAGS_64BIT))
+		dev->no_64bit_msi = 1;
 }
 
 void pci_msix_init(struct pci_dev *dev)
-- 
2.25.1

