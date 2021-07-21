Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FF23D0C42
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 12:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbhGUJWD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 05:22:03 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7042 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbhGUJVX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jul 2021 05:21:23 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GV9vZ5XJLzYd6x;
        Wed, 21 Jul 2021 17:56:10 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 21 Jul 2021 18:01:57 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggema772-chm.china.huawei.com (10.1.198.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 21 Jul 2021 18:01:57 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     <sathyanarayanan.kuppuswamy@linux.intel.com>, <kbusch@kernel.org>,
        <qiuxu.zhuo@intel.com>, <sean.v.kelley@intel.com>,
        <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>
Subject: [RESEND PATCH] PCI/AER: print and clear UNCOR errors signaled as correctable advisory non-fatal error
Date:   Wed, 21 Jul 2021 18:00:40 +0800
Message-ID: <20210721100040.79625-1-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Per PCIe Spec 4.0 sctions 6.2.3.2.4 and 6.2.4.3, some uncorrectable
erros may signal ERR_COR instead of ERR_NONFATAL and logged as
advisory non-fatal error. And section 6.2.5 mentions, for advisory
non-fatal errors, both corresponding bit in Uncorrectable Error Status
reg and bit in Correctable Error status will be set.

Currently we only print the information of Correctable Error status
when advisory non-fatal error received, and with corresponding
bit in Uncorrectable Error Status uncleared. This will leads to
wrong information when non-fatal errors arrive next time, as
AER will print the non-fatal errors signaled as advisory non-fatal
errors last time as well.

Print non-fatal error status signaled as advisory non-fatal error
and clear the uncorrectable error status.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/pci.h      |  1 +
 drivers/pci/pcie/aer.c | 23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 93dcdd431072..54d5795198da 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -419,6 +419,7 @@ struct aer_err_info {
 
 	unsigned int status;		/* COR/UNCOR Error Status */
 	unsigned int mask;		/* COR/UNCOR Error Mask */
+	unsigned int nf_status;		/* Non-Fatal Error Status signaled as COR Error */
 	struct aer_header_log_regs tlp;	/* TLP Header */
 };
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index df4ba9b384c2..6e16cc9db0ce 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -693,6 +693,20 @@ static void __aer_print_error(struct pci_dev *dev,
 		pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
 				info->first_error == i ? " (First)" : "");
 	}
+
+	if (info->severity == AER_CORRECTABLE &&
+	    (status & PCI_ERR_COR_ADV_NFAT)) {
+		status = info->nf_status;
+		pci_printk(level, dev, "   Non-Fatal errors signaled as Correctable error:");
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
 
@@ -783,6 +797,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	info.status = status;
 	info.mask = mask;
 	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
+	info.nf_status = aer->uncor_status;
 
 	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
 	__aer_print_error(dev, &info);
@@ -948,9 +963,13 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
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
@@ -1060,6 +1079,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 			&info->mask);
 		if (!(info->status & ~info->mask))
 			return 0;
+		if (info->status & PCI_ERR_COR_ADV_NFAT)
+			pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &info->nf_status);
 	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
 		   type == PCI_EXP_TYPE_RC_EC ||
 		   type == PCI_EXP_TYPE_DOWNSTREAM ||
-- 
2.17.1

