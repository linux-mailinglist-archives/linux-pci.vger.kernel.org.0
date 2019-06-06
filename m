Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6695136FBF
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 11:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfFFJW6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 05:22:58 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2728 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfFFJW5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2019 05:22:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf8db6e0000>; Thu, 06 Jun 2019 02:22:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Jun 2019 02:22:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Jun 2019 02:22:56 -0700
Received: from localhost.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Jun
 2019 09:22:54 +0000
From:   Abhishek Sahu <abhsahu@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lukas@wunner.de>, Abhishek Sahu <abhsahu@nvidia.com>
Subject: [PATCH v2 1/2] PCI: Code reorganization for creating device link
Date:   Thu, 6 Jun 2019 14:52:24 +0530
Message-ID: <20190606092225.17960-2-abhsahu@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190606092225.17960-1-abhsahu@nvidia.com>
References: <20190606092225.17960-1-abhsahu@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559812974; bh=qs9bK8ne1eBh5LsD3PckRgKiqOXqr2trdRsAyQ2P6Sc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         X-Originating-IP:X-ClientProxiedBy:Content-Type;
        b=e/JoyEoSfdd9DNAibE9iSQKl3My58pn66nmiNy6fIrBebYlBTwdminsx55BM8Btzz
         Xxp71T0uzp4H3XfSk90EfsurA9cEj0Vvi/XsuBC/ys+0UAh4pJtbtOnt9vLY0o/KAB
         gPQp18633/+BjxZFb8mxlYAGQIGv1DdcsaEhy3EoCViIJkqEia0KiOxgz8HplhIadN
         K40XAo7MRK7SaqByV7aaT2XnX7IZbpvUgDh0Rs02TTCtbLFHckRnsxdoAkb7/9jg8E
         ILkQlP/4q3UAAQVOLGFz1FvE2fIlGjQfOyQuHyHFV3sCA/I5Mf78696GBuy0dP1aD4
         p889rcoI9wyIQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In Multi-function PCI device, one function (consumer) can have
hardware functional dependencies on another function (supplier).
Whenever the consumer is active and in D0 state, the supplier should
also be in D0 state. Currently, the device link is being created from
HDA function to VGA function for GPU's. This patch does minor code
reorganization. It introduces a helper function which creates device
link from consumer pci device to supplier pci device and uses this
helper function for creating device link from HDA to VGA. This helper
function can be used in future for creating device link from one
function to another function.

Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
---
* Changes from v1:

  1. Make the helper function generic which takes supplier class,
     class shift and function number also.
  2. Minor changes in commit log

 drivers/pci/quirks.c | 53 +++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a077f67fe1da..379cd7fbcb12 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4916,35 +4916,48 @@ static void quirk_fsl_no_msi(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_fsl_no_msi);
 
 /*
- * GPUs with integrated HDA controller for streaming audio to attached displays
- * need a device link from the HDA controller (consumer) to the GPU (supplier)
- * so that the GPU is powered up whenever the HDA controller is accessed.
- * The GPU and HDA controller are functions 0 and 1 of the same PCI device.
- * The device link stays in place until shutdown (or removal of the PCI device
- * if it's hotplugged).  Runtime PM is allowed by default on the HDA controller
- * to prevent it from permanently keeping the GPU awake.
+ * Multi-function PCI devices can have hardware functional dependencies from
+ * one function (consumer) to another function (supplier). Whenever the
+ * consumer is in D0 state, the supplier should also be in D0 state. This is
+ * a helper function which creates device link from the consumer to the
+ * supplier.  The device link stays in place until shutdown (or removal of
+ * the PCI device if it's hotplugged). Runtime PM is allowed by default on
+ * consumers to prevent it from permanently keeping the supplier awake.
  */
-static void quirk_gpu_hda(struct pci_dev *hda)
+static void pci_create_device_link(struct pci_dev *pdev, unsigned int consumer,
+				   unsigned int supplier, unsigned int class,
+				   unsigned int class_shift)
 {
-	struct pci_dev *gpu;
+	struct pci_dev *supplier_pdev;
 
-	if (PCI_FUNC(hda->devfn) != 1)
+	if (PCI_FUNC(pdev->devfn) != consumer)
 		return;
 
-	gpu = pci_get_domain_bus_and_slot(pci_domain_nr(hda->bus),
-					  hda->bus->number,
-					  PCI_DEVFN(PCI_SLOT(hda->devfn), 0));
-	if (!gpu || (gpu->class >> 16) != PCI_BASE_CLASS_DISPLAY) {
-		pci_dev_put(gpu);
+	supplier_pdev = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+				pdev->bus->number,
+				PCI_DEVFN(PCI_SLOT(pdev->devfn), supplier));
+	if (!supplier_pdev || (supplier_pdev->class >> class_shift) != class) {
+		pci_dev_put(supplier_pdev);
 		return;
 	}
 
-	if (!device_link_add(&hda->dev, &gpu->dev,
-			     DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME))
-		pci_err(hda, "cannot link HDA to GPU %s\n", pci_name(gpu));
+	if (device_link_add(&pdev->dev, &supplier_pdev->dev,
+			    DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME))
+		pci_info(pdev, "Linked with %s\n", pci_name(supplier_pdev));
+	else
+		pci_err(pdev, "Cannot link with %s\n", pci_name(supplier_pdev));
+
+	pm_runtime_allow(&pdev->dev);
+	pci_dev_put(supplier_pdev);
+}
 
-	pm_runtime_allow(&hda->dev);
-	pci_dev_put(gpu);
+/*
+ * Create device link for GPUs with integrated HDA controller for streaming
+ * audio to attached displays.
+ */
+static void quirk_gpu_hda(struct pci_dev *hda)
+{
+	pci_create_device_link(hda, 1, 0, PCI_BASE_CLASS_DISPLAY, 16);
 }
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
-- 
2.17.1

