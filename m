Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91714409C24
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 20:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343777AbhIMS1o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 14:27:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240010AbhIMS11 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 14:27:27 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E9E8610E6;
        Mon, 13 Sep 2021 18:26:11 +0000 (UTC)
Received: from [198.52.44.129] (helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mPqef-00AYPD-IF; Mon, 13 Sep 2021 19:26:09 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>, kernel-team@android.com
Subject: [PATCH v3 09/10] iommu/dart: Exclude MSI doorbell from PCIe device IOVA range
Date:   Mon, 13 Sep 2021 19:25:49 +0100
Message-Id: <20210913182550.264165-10-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913182550.264165-1-maz@kernel.org>
References: <20210913182550.264165-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 198.52.44.129
X-SA-Exim-Rcpt-To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com, kw@linux.com, alyssa@rosenzweig.io, stan@corellium.com, kettenis@openbsd.org, sven@svenpeter.dev, marcan@marcan.st, Robin.Murphy@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The MSI doorbell on Apple HW can be any address in the low 4GB
range. However, the MSI write is matched by the PCIe block before
hitting the iommu. It must thus be excluded from the IOVA range
that is assigned to any PCIe device.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/iommu/apple-dart.c          | 25 +++++++++++++++++++++++++
 drivers/pci/controller/Kconfig      |  5 +++++
 drivers/pci/controller/pcie-apple.c |  4 +++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 559db9259e65..d1456663688e 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -721,6 +721,29 @@ static int apple_dart_def_domain_type(struct device *dev)
 	return 0;
 }
 
+#define DOORBELL_ADDR	(CONFIG_PCIE_APPLE_MSI_DOORBELL_ADDR & PAGE_MASK)
+
+static void apple_dart_get_resv_regions(struct device *dev,
+					struct list_head *head)
+{
+#ifdef CONFIG_PCIE_APPLE
+	if (dev_is_pci(dev)) {
+		struct iommu_resv_region *region;
+		int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+
+		region = iommu_alloc_resv_region(DOORBELL_ADDR,
+						 PAGE_SIZE, prot,
+						 IOMMU_RESV_MSI);
+		if (!region)
+			return;
+
+		list_add_tail(&region->list, head);
+	}
+#endif
+
+	iommu_dma_get_resv_regions(dev, head);
+}
+
 static const struct iommu_ops apple_dart_iommu_ops = {
 	.domain_alloc = apple_dart_domain_alloc,
 	.domain_free = apple_dart_domain_free,
@@ -737,6 +760,8 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 	.device_group = apple_dart_device_group,
 	.of_xlate = apple_dart_of_xlate,
 	.def_domain_type = apple_dart_def_domain_type,
+	.get_resv_regions = apple_dart_get_resv_regions,
+	.put_resv_regions = generic_iommu_put_resv_regions,
 	.pgsize_bitmap = -1UL, /* Restricted during dart probe */
 };
 
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 814833a8120d..b6e7410da254 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -312,6 +312,11 @@ config PCIE_HISI_ERR
 	  Say Y here if you want error handling support
 	  for the PCIe controller's errors on HiSilicon HIP SoCs
 
+config PCIE_APPLE_MSI_DOORBELL_ADDR
+	hex
+	default 0xfffff000
+	depends on PCIE_APPLE
+
 config PCIE_APPLE
 	tristate "Apple PCIe controller"
 	depends on ARCH_APPLE || COMPILE_TEST
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 1ed7b90f8360..76344223245d 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -120,8 +120,10 @@
  * The doorbell address is set to 0xfffff000, which by convention
  * matches what MacOS does, and it is possible to use any other
  * address (in the bottom 4GB, as the base register is only 32bit).
+ * However, it has to be excluded from the the IOVA range, and the
+ * DART driver has to know about it.
  */
-#define DOORBELL_ADDR			0xfffff000
+#define DOORBELL_ADDR		CONFIG_PCIE_APPLE_MSI_DOORBELL_ADDR
 
 struct apple_pcie {
 	struct mutex		lock;
-- 
2.30.2

