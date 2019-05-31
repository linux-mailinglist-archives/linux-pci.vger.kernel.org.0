Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECF54307F2
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 07:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfEaFAw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 May 2019 01:00:52 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16233 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaFAv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2019 01:00:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf0b4f80000>; Thu, 30 May 2019 22:00:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 30 May 2019 22:00:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 30 May 2019 22:00:50 -0700
Received: from localhost.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 May
 2019 05:00:48 +0000
From:   Abhishek Sahu <abhsahu@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Abhishek Sahu <abhsahu@nvidia.com>
Subject: [PATCH 1/2] PCI: Code reorganization for VGA device link
Date:   Fri, 31 May 2019 10:31:08 +0530
Message-ID: <20190531050109.16211-2-abhsahu@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531050109.16211-1-abhsahu@nvidia.com>
References: <20190531050109.16211-1-abhsahu@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559278840; bh=KOYlF9zE1nAd15bslH2RS9I7HwZ+Rr/vibg1nSmt3Rs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         X-Originating-IP:X-ClientProxiedBy:Content-Type;
        b=IIUV+IDvaITEXNAfgo8DOsmQ3d2Z5WMqm7I7RUMtjjsqw6pFAqQLhivqTh+2NUbar
         r+QOHqefH8zss2sqJC96L/mzFiXI2tGcacwufDxyYv/wEGQDTPHsgfyPUdr92wmDa0
         OHIdfuX1dTM4UupHyIWaSIC0Q824vlcVU2SVbdnRoRI0QTy/3wXctiJS2FJ0D/DE9M
         rsz3RomLQVIxs2UY75fluC7r9svazexhh3USPq+0gtaPVQa4mr1p0+O8M94qDyNiDl
         77aZgTwtgMmLSHZ+Boh9zuy093Te6QXx8cdOupH3omDWVCdjMgMhF7RD1bIxuKh6rw
         jTnlVAnFlOw7g==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch does minor code reorganization. It introduces a helper
function which creates device link from the non-VGA controller
(consumer) to the VGA (supplier) and uses this helper function for
creating device link from integrated HDA controller to VGA. It will
help in subsequent patches which require a similar kind of device
link from USB/Type-C USCI controller to VGA.

Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
---
 drivers/pci/quirks.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a077f67fe1da..a20f7771a323 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4916,36 +4916,50 @@ static void quirk_fsl_no_msi(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_fsl_no_msi);
 
 /*
- * GPUs with integrated HDA controller for streaming audio to attached displays
- * need a device link from the HDA controller (consumer) to the GPU (supplier)
- * so that the GPU is powered up whenever the HDA controller is accessed.
- * The GPU and HDA controller are functions 0 and 1 of the same PCI device.
- * The device link stays in place until shutdown (or removal of the PCI device
- * if it's hotplugged).  Runtime PM is allowed by default on the HDA controller
- * to prevent it from permanently keeping the GPU awake.
+ * GPUs can be multi-function PCI device which can contain controllers other
+ * than VGA (like Audio, USB, etc.). Internally in the hardware, these non-VGA
+ * controllers are tightly coupled with VGA controller. Whenever these
+ * controllers are runtime active, the VGA controller should also be in active
+ * state. Normally, in these GPUs, the VGA controller is present at function 0.
+ *
+ * This is a helper function which creates device link from the non-VGA
+ * controller (consumer) to the VGA (supplier). The device link stays in place
+ * until shutdown (or removal of the PCI device if it's hotplugged).
+ * Runtime PM is allowed by default on these non-VGA controllers to prevent
+ * it from permanently keeping the GPU awake.
  */
-static void quirk_gpu_hda(struct pci_dev *hda)
+static void
+pci_create_device_link_with_vga(struct pci_dev *pdev, unsigned int devfn)
 {
 	struct pci_dev *gpu;
 
-	if (PCI_FUNC(hda->devfn) != 1)
+	if (PCI_FUNC(pdev->devfn) != devfn)
 		return;
 
-	gpu = pci_get_domain_bus_and_slot(pci_domain_nr(hda->bus),
-					  hda->bus->number,
-					  PCI_DEVFN(PCI_SLOT(hda->devfn), 0));
+	gpu = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+					  pdev->bus->number,
+					  PCI_DEVFN(PCI_SLOT(pdev->devfn), 0));
 	if (!gpu || (gpu->class >> 16) != PCI_BASE_CLASS_DISPLAY) {
 		pci_dev_put(gpu);
 		return;
 	}
 
-	if (!device_link_add(&hda->dev, &gpu->dev,
+	if (!device_link_add(&pdev->dev, &gpu->dev,
 			     DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME))
-		pci_err(hda, "cannot link HDA to GPU %s\n", pci_name(gpu));
+		pci_err(pdev, "cannot link with VGA %s\n", pci_name(gpu));
 
-	pm_runtime_allow(&hda->dev);
+	pm_runtime_allow(&pdev->dev);
 	pci_dev_put(gpu);
 }
+
+/*
+ * Create device link for GPUs with integrated HDA controller for streaming
+ * audio to attached displays.
+ */
+static void quirk_gpu_hda(struct pci_dev *hda)
+{
+	pci_create_device_link_with_vga(hda, 1);
+}
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
-- 
2.17.1

