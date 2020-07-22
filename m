Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A89D229570
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 11:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbgGVJvS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jul 2020 05:51:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8248 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730990AbgGVJvS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Jul 2020 05:51:18 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E2D5C81D0724F7BAC3D9;
        Wed, 22 Jul 2020 17:51:14 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 22 Jul 2020 17:51:06 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] PCI: Put the IVRS table in AMD ACS quirk handler
Date:   Wed, 22 Jul 2020 17:44:28 +0800
Message-ID: <1595411068-15440-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The acpi_get_table() should be coupled with acpi_put_table() if
the mapped table is not used at runtime to release the table
mapping.

In pci_quirk_amd_sb_acs(), IVRS table is just used for checking
AMD IOMMU is supported, not used at runtime, put the table after
using it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 812bfc3..487ed4d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4409,6 +4409,8 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
+	acpi_put_table(header);
+
 	/* Filter out flags not applicable to multifunction */
 	acs_flags &= (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC | PCI_ACS_DT);
 
-- 
1.7.12.4

