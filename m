Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F5F376580
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 14:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbhEGMvK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 08:51:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17151 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhEGMvI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 May 2021 08:51:08 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fc9F52jrqzqTDj;
        Fri,  7 May 2021 20:46:49 +0800 (CST)
Received: from huawei.com (10.174.185.226) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Fri, 7 May 2021
 20:50:00 +0800
From:   Wang Xingang <wangxingang5@huawei.com>
To:     <will@kernel.org>, <joro@8bytes.org>
CC:     <bhelgaas@google.com>, <gregkh@linuxfoundation.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <xieyingtai@huawei.com>,
        <wangxingang5@huawei.com>
Subject: [PATCH 1/1] iommu/of: Fix request and enable ACS for of_iommu_configure
Date:   Fri, 7 May 2021 12:49:53 +0000
Message-ID: <1620391793-18744-2-git-send-email-wangxingang5@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
In-Reply-To: <1620391793-18744-1-git-send-email-wangxingang5@huawei.com>
References: <1620391793-18744-1-git-send-email-wangxingang5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xingang Wang <wangxingang5@huawei.com>

When request ACS for PCI device in of_iommu_configure, the pci device
has already been scanned and added with 'pci_acs_enable=0'. So the
pci_request_acs() in current procedure does not work for enabling ACS.
Besides, the ACS should be enabled only if there's an IOMMU in system.
So this fix the call of pci_request_acs() and call pci_enable_acs() to
make sure ACS is enabled for the pci_device.

Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
configuring IOMMU linkage")
Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
---
 drivers/iommu/of_iommu.c | 10 +++++++++-
 drivers/pci/pci.c        |  2 +-
 include/linux/pci.h      |  1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a9d2df001149..dc621861ae72 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			.np = master_np,
 		};
 
-		pci_request_acs();
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
 	} else {
@@ -222,6 +221,15 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		/* The fwspec pointer changed, read it again */
 		fwspec = dev_iommu_fwspec_get(dev);
 		ops    = fwspec->ops;
+
+		/*
+		 * If we found an IOMMU and the device is pci,
+		 * make sure we enable ACS.
+		 */
+		if (dev_is_pci(dev)) {
+			pci_request_acs();
+			pci_enable_acs(to_pci_dev(dev));
+		}
 	}
 	/*
 	 * If we have reason to believe the IOMMU driver missed the initial
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b717680377a9..4e4f98ee2870 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -926,7 +926,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
  */
-static void pci_enable_acs(struct pci_dev *dev)
+void pci_enable_acs(struct pci_dev *dev)
 {
 	if (!pci_acs_enable)
 		goto disable_acs_redir;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c20211e59a57..e6a8bfbc9c98 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2223,6 +2223,7 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
 }
 
 void pci_request_acs(void);
+void pci_enable_acs(struct pci_dev *dev);
 bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
 bool pci_acs_path_enabled(struct pci_dev *start,
 			  struct pci_dev *end, u16 acs_flags);
-- 
2.19.1

