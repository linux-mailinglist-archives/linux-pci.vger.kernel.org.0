Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32AE2B67FE
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 15:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgKQO5h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 09:57:37 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9228 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgKQO5g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 09:57:36 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb3e4ea0003>; Tue, 17 Nov 2020 06:57:46 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Nov
 2020 14:57:34 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 17 Nov 2020 14:57:32 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH] PCI/MSI: Set device flag indicating only 32-bit MSI support
Date:   Tue, 17 Nov 2020 20:27:28 +0530
Message-ID: <20201117145728.4516-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605625066; bh=ZTUMvtaqennQ1JdMmdsb/E7562d9dVUi9teJOnYd07c=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=ctuRNIY359o8unfTMllbc5J+MZOGVs+aYUuOr65JDk/A1YkFhI2XNj5plSaSw9YDs
         7KEKrrn7MNcsBkOiMtm0RCDGFAPsDSev8TSWKtpq5WuvWcT+ki2dILqzRt0NPIT7Gd
         UdOClACtK/qkqKp8wwDkIQ8FD8BW7LBdnM8fF4iSUj/XUbzUwn2qwTO+mWPhuQVVqk
         YVegRtESl73kBT4GXImeAAeF3t4NyJUO06yLURaQwU9orqJvJe4JteRIA0lJmBvVXS
         KhD/9CV//VrQTdFZZLh3JgqUo87F+joeNdgFH0x6pllhyMUZmB60cf8Vva9u4p/Pgi
         pUxcnsMDtHjZA==
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
 drivers/pci/msi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d52d118979a6..af49da28854e 100644
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
-- 
2.17.1

