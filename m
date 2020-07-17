Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BBE2244B1
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 21:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgGQT42 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jul 2020 15:56:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgGQT41 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jul 2020 15:56:27 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 421132070E;
        Fri, 17 Jul 2020 19:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595015787;
        bh=mt3BbHSlYpBuGi7zxMIq0lWa3jawRRf0GkV5BTzsBE4=;
        h=From:To:Cc:Subject:Date:From;
        b=aUY7K8/Zk+svPbmFnZmrVcHpSvaQojwfpzsvtUOGEZx+w6H8XAxzPDdpH5El22Bwk
         xC0GYIC1U6L5NRR7N/DBM1EPhiVwe6wD0ibo5rYuPQwKbZaf+b+mw+xrYgceFJ5BrD
         hgTcVqee+aA1n9FeAUgJhzvnF7t7E3aJCMcJeX0Y=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean Kelley <sean.v.kelley@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linuxarm@huawei.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI/ERR: Rename pci_aer_clear_device_status() to pcie_clear_device_status()
Date:   Fri, 17 Jul 2020 14:56:19 -0500
Message-Id: <20200717195619.766662-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci_aer_clear_device_status() clears the error bits in the PCIe Device
Status Register (PCI_EXP_DEVSTA).  Every PCIe device has this register,
regardless of whether it supports AER.

Rename pci_aer_clear_device_status() to pcie_clear_device_status() to make
clear that it is PCIe-specific but not AER-specific.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h      | 4 ++--
 drivers/pci/pcie/aer.c | 4 ++--
 drivers/pci/pcie/err.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c6c0c455f59f..c5f271e6e276 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -657,16 +657,16 @@ void pci_no_aer(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
+void pcie_clear_device_status(struct pci_dev *dev);
 void pci_aer_clear_fatal_status(struct pci_dev *dev);
-void pci_aer_clear_device_status(struct pci_dev *dev);
 int pci_aer_clear_status(struct pci_dev *dev);
 int pci_aer_raw_clear_status(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
+static inline void pcie_clear_device_status(struct pci_dev *dev) { }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
-static inline void pci_aer_clear_device_status(struct pci_dev *dev) { }
 static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
 #endif
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ca886bf91fd9..d3ea667c8520 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -241,7 +241,7 @@ int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
 
-void pci_aer_clear_device_status(struct pci_dev *dev)
+void pcie_clear_device_status(struct pci_dev *dev)
 {
 	u16 sta;
 
@@ -947,7 +947,7 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 		if (aer)
 			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
 					info->status);
-		pci_aer_clear_device_status(dev);
+		pcie_clear_device_status(dev);
 	} else if (info->severity == AER_NONFATAL)
 		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
 	else if (info->severity == AER_FATAL)
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 467686ee2d8b..55755bc493f1 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -197,7 +197,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(dev, "broadcast resume message\n");
 	pci_walk_bus(bus, report_resume, &status);
 
-	pci_aer_clear_device_status(dev);
+	pcie_clear_device_status(dev);
 	pci_aer_clear_nonfatal_status(dev);
 	pci_info(dev, "device recovery successful\n");
 	return status;
-- 
2.25.1

