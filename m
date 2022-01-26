Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB2C49D2BF
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 20:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244598AbiAZTvN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 14:51:13 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:62469 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244546AbiAZTvI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jan 2022 14:51:08 -0500
X-IronPort-AV: E=Sophos;i="5.88,319,1635174000"; 
   d="scan'208";a="108403304"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 27 Jan 2022 04:51:07 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 66EE94008541;
        Thu, 27 Jan 2022 04:51:04 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 3/5] misc: pci_endpoint_test: Add driver data for Renesas RZ/G2{EHMN}
Date:   Wed, 26 Jan 2022 19:50:41 +0000
Message-Id: <20220126195043.28376-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add "dmac_data_alignment" member (indicating the alignment requirement
for internal DMAC for data transfers) to struct pci_endpoint_test_data
and add driver_data to Renesas RZ/G2{EHMN}.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/misc/pci_endpoint_test.c | 40 ++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 8f786a225dcf..0a00d45830e9 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -116,6 +116,7 @@ struct pci_endpoint_test {
 	struct miscdevice miscdev;
 	enum pci_barno test_reg_bar;
 	size_t alignment;
+	size_t dmac_data_alignment;
 	const char *name;
 };
 
@@ -123,6 +124,7 @@ struct pci_endpoint_test_data {
 	enum pci_barno test_reg_bar;
 	size_t alignment;
 	int irq_type;
+	size_t dmac_data_alignment;
 };
 
 static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
@@ -368,8 +370,11 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 		goto err;
 
 	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
-	if (use_dma)
+	if (use_dma) {
 		flags |= FLAG_USE_DMA;
+		if (test->dmac_data_alignment)
+			size =  ALIGN(size, test->dmac_data_alignment);
+	}
 
 	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
@@ -502,8 +507,11 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 		goto err;
 
 	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
-	if (use_dma)
+	if (use_dma) {
 		flags |= FLAG_USE_DMA;
+		if (test->dmac_data_alignment)
+			size =  ALIGN(size, test->dmac_data_alignment);
+	}
 
 	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
@@ -600,8 +608,11 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 		goto err;
 
 	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
-	if (use_dma)
+	if (use_dma) {
 		flags |= FLAG_USE_DMA;
+		if (test->dmac_data_alignment)
+			size =  ALIGN(size, test->dmac_data_alignment);
+	}
 
 	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
@@ -787,6 +798,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		test->test_reg_bar = test_reg_bar;
 		test->alignment = data->alignment;
 		irq_type = data->irq_type;
+		test->dmac_data_alignment = data->dmac_data_alignment;
 	}
 
 	init_completion(&test->irq_raised);
@@ -948,6 +960,12 @@ static const struct pci_endpoint_test_data j721e_data = {
 	.irq_type = IRQ_TYPE_MSI,
 };
 
+static const struct pci_endpoint_test_data renesas_rzg2x_data = {
+	.test_reg_bar = BAR_0,
+	.irq_type = IRQ_TYPE_MSI,
+	.dmac_data_alignment = 8,
+};
+
 static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x),
 	  .driver_data = (kernel_ulong_t)&default_data,
@@ -965,10 +983,18 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
 	  .driver_data = (kernel_ulong_t)&am654_data
 	},
-	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774A1),},
-	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774B1),},
-	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0),},
-	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774E1),},
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774A1),
+	 .driver_data = (kernel_ulong_t)&renesas_rzg2x_data,
+	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774B1),
+	 .driver_data = (kernel_ulong_t)&renesas_rzg2x_data,
+	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0),
+	 .driver_data = (kernel_ulong_t)&renesas_rzg2x_data,
+	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774E1),
+	 .driver_data = (kernel_ulong_t)&renesas_rzg2x_data,
+	},
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
 	  .driver_data = (kernel_ulong_t)&j721e_data,
 	},
-- 
2.25.1

