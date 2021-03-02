Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5404F32B255
	for <lists+linux-pci@lfdr.de>; Wed,  3 Mar 2021 04:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242251AbhCCB6P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Mar 2021 20:58:15 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13418 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447956AbhCBNy0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Mar 2021 08:54:26 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Dqcgn1HZ0zjTX6;
        Tue,  2 Mar 2021 21:00:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Mar 2021 21:02:08 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     <tanxiaofei@huawei.com>, <prime.zeng@huawei.com>,
        <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH] PCI/AER: Correctly handle advisory non-fatal errors
Date:   Tue, 2 Mar 2021 20:59:54 +0800
Message-ID: <1614689994-10925-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Per PCIe Spec 4.0 sctions 6.2.3.2.4 and 6.2.4.3, some uncorrectable
errors may signal ERR_COR instead of ERR_NONFATAL and logged as
advisory non-fatal error. And section 6.2.5 mentions, for advisory
non-fatal errors, both corresponding bit in Uncorrectable Error Status
reg and bit in Correctable Error status will be set.

Currently we only print the information of correctable error status
when advisory non-fatal error received, and with corresponding
bit in uncorrectable error status uncleared. This will leads to
wrong information when non-fatal errors arrive in the future, as
AER will print the non-fatal errors that already handled as
advisory non-fatal errors.

Print non-fatal error status signaled as advisory non-fatal error
and clear the uncorrectable error status.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/pci.h      |  1 +
 drivers/pci/pcie/aer.c | 23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ef7c466..6a5f76c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -424,6 +424,7 @@ struct aer_err_info {
 
 	unsigned int status;		/* COR/UNCOR Error Status */
 	unsigned int mask;		/* COR/UNCOR Error Mask */
+	unsigned int nf_status;		/* Non-Fatal Error Status signaled as COR Error */
 	struct aer_header_log_regs tlp;	/* TLP Header */
 };
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ba22388..a3e7d8d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -691,6 +691,20 @@ static void __aer_print_error(struct pci_dev *dev,
 		pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
 				info->first_error == i ? " (First)" : "");
 	}
+
+	if (info->severity == AER_CORRECTABLE &&
+	    (status & PCI_ERR_COR_ADV_NFAT)) {
+		status = info->nf_status;
+		pci_printk(level, dev, "   Non-Fatal errors signaled as correctable NonFatalErr:");
+		for_each_set_bit(i, &status, 32) {
+			errmsg = aer_uncorrectable_error_string[i];
+			if (!errmsg)
+				errmsg = "Unknown Error Bit";
+
+			pci_printk(level, dev, "   [%2d] %-22s\n", i, errmsg);
+		}
+	}
+
 	pci_dev_aer_stats_incr(dev, info);
 }
 
@@ -781,6 +795,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	info.status = status;
 	info.mask = mask;
 	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
+	info.nf_status = aer->uncor_status;
 
 	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
 	__aer_print_error(dev, &info);
@@ -946,9 +961,13 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 		 * Correctable error does not need software intervention.
 		 * No need to go through error recovery process.
 		 */
-		if (aer)
+		if (aer) {
 			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
 					info->status);
+			if (info->status & PCI_ERR_COR_ADV_NFAT)
+				pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,
+						       info->nf_status);
+		}
 		if (pcie_aer_is_native(dev))
 			pcie_clear_device_status(dev);
 	} else if (info->severity == AER_NONFATAL)
@@ -1058,6 +1077,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 			&info->mask);
 		if (!(info->status & ~info->mask))
 			return 0;
+		if (info->status & PCI_ERR_COR_ADV_NFAT)
+			pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &info->nf_status);
 	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
 		   type == PCI_EXP_TYPE_RC_EC ||
 		   type == PCI_EXP_TYPE_DOWNSTREAM ||
-- 
2.8.1

