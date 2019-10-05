Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDB16CCBFA
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2019 20:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387706AbfJESVf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Oct 2019 14:21:35 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9268 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387555AbfJESVf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Oct 2019 14:21:35 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d98df2f0000>; Sat, 05 Oct 2019 11:21:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 05 Oct 2019 11:21:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 05 Oct 2019 11:21:34 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 5 Oct
 2019 18:21:34 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 5 Oct 2019 18:21:34 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d98df2b0000>; Sat, 05 Oct 2019 11:21:33 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
Date:   Sat, 5 Oct 2019 23:51:29 +0530
Message-ID: <20191005182129.32538-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570299695; bh=KZvdcY41xUr0IbeaiPRcqIp1ePfnzzAvpzq/58pzYwk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=SRnu9m139fzGGmLABcowiM8bgkImvA2u96/YT7B3OizRMCvJkCweZ4Lecw8CGL6t5
         aaXByxBCDos+2RI7dPUAan5L+pK4yleg7y2n8aQtmBuuyxw6PVsEGmsBexhlSt/oJN
         KDnqCo4oKJmBUcWGMxx41aDReCb+wlc5z3dyvixKak4YETz6FYczRUHhELooXRZqjs
         rQF9hMcmEGmkFK/lpKjRkMYN0iyQCUfQ/aYtPii3SxuoEGbSrkEj+gygOht61/DAgL
         pMNnEQPLQm6NN068KWjceuI5IOvMuyPSk7pG9DJ9rsQg9g+eh+v9qGkFe1DF6CiOc0
         lXYeq0eegOgzg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adds a 60 seconds timeout to consider CRS (Configuration request Retry
Status) from a downstream device when Vendor ID read is attempted by
an upstream device. This helps to work with devices that return CRS
during system resume. This also makes pci_device_is_present() consistent
with the probe path where 60 seconds timeout is already being used.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/pci.c   | 3 ++-
 drivers/pci/pci.h   | 2 ++
 drivers/pci/probe.c | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 95dc78ebdded..3ab9f6d3c8a6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5905,7 +5905,8 @@ bool pci_device_is_present(struct pci_dev *pdev)
 
 	if (pci_dev_is_disconnected(pdev))
 		return false;
-	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
+	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v,
+					  PCI_CRS_TIMEOUT);
 }
 EXPORT_SYMBOL_GPL(pci_device_is_present);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3f6947ee3324..aa25c5fdc6a5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -4,6 +4,8 @@
 
 #include <linux/pci.h>
 
+#define PCI_CRS_TIMEOUT		(60 * 1000)	/* 60 sec*/
+
 #define PCI_FIND_CAP_TTL	48
 
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7c5d68b807ef..6e44a03283c8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2258,7 +2258,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	struct pci_dev *dev;
 	u32 l;
 
-	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
+	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, PCI_CRS_TIMEOUT))
 		return NULL;
 
 	dev = pci_alloc_dev(bus);
-- 
2.17.1

