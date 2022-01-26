Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D6649D2C2
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 20:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244611AbiAZTvQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 14:51:16 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:10375 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244584AbiAZTvL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jan 2022 14:51:11 -0500
X-IronPort-AV: E=Sophos;i="5.88,319,1635174000"; 
   d="scan'208";a="107766021"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 27 Jan 2022 04:51:10 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id B2533400C44F;
        Thu, 27 Jan 2022 04:51:07 +0900 (JST)
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
Subject: [RFC PATCH 4/5] misc: pci_endpoint_test: Add support to pass flags for buffer allocation
Date:   Wed, 26 Jan 2022 19:50:42 +0000
Message-Id: <20220126195043.28376-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

By default GFP_KERNEL flag is used for buffer allocation in read, write
and copy test and then later mapped using streaming DMA api. But on
Renesas RZ/G2{EHMN} platforms using the default flag causes the tests to
fail. Allocating the buffers from DMA zone (using the GFP_DMA flag) make
the test cases to pass.

To handle such case add flags as part of struct pci_endpoint_test_data
so that platforms can pass the required flags based on the requirement.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi All,

This patch is based on the conversation where switching to streaming
DMA api causes read/write/copy tests to fail on Renesas RZ/G2 platforms
when buffers are allocated using GFP_KERNEL.

[0] https://www.spinics.net/lists/linux-pci/msg92385.html

Cheers,
Prabhakar
---
 drivers/misc/pci_endpoint_test.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 0a00d45830e9..974546992c5e 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -117,6 +117,7 @@ struct pci_endpoint_test {
 	enum pci_barno test_reg_bar;
 	size_t alignment;
 	size_t dmac_data_alignment;
+	gfp_t flags;
 	const char *name;
 };
 
@@ -125,6 +126,7 @@ struct pci_endpoint_test_data {
 	size_t alignment;
 	int irq_type;
 	size_t dmac_data_alignment;
+	gfp_t flags;
 };
 
 static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
@@ -381,7 +383,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 		goto err;
 	}
 
-	orig_src_addr = kzalloc(size + alignment, GFP_KERNEL);
+	orig_src_addr = kzalloc(size + alignment, test->flags);
 	if (!orig_src_addr) {
 		dev_err(dev, "Failed to allocate source buffer\n");
 		ret = false;
@@ -414,7 +416,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 
 	src_crc32 = crc32_le(~0, src_addr, size);
 
-	orig_dst_addr = kzalloc(size + alignment, GFP_KERNEL);
+	orig_dst_addr = kzalloc(size + alignment, test->flags);
 	if (!orig_dst_addr) {
 		dev_err(dev, "Failed to allocate destination address\n");
 		ret = false;
@@ -518,7 +520,7 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 		goto err;
 	}
 
-	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
+	orig_addr = kzalloc(size + alignment, test->flags);
 	if (!orig_addr) {
 		dev_err(dev, "Failed to allocate address\n");
 		ret = false;
@@ -619,7 +621,7 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 		goto err;
 	}
 
-	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
+	orig_addr = kzalloc(size + alignment, test->flags);
 	if (!orig_addr) {
 		dev_err(dev, "Failed to allocate destination address\n");
 		ret = false;
@@ -788,6 +790,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	test->alignment = 0;
 	test->pdev = pdev;
 	test->irq_type = IRQ_TYPE_UNDEFINED;
+	test->flags = GFP_KERNEL;
 
 	if (no_msi)
 		irq_type = IRQ_TYPE_LEGACY;
@@ -799,6 +802,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		test->alignment = data->alignment;
 		irq_type = data->irq_type;
 		test->dmac_data_alignment = data->dmac_data_alignment;
+		test->flags = data->flags;
 	}
 
 	init_completion(&test->irq_raised);
@@ -947,23 +951,27 @@ static const struct pci_endpoint_test_data default_data = {
 	.test_reg_bar = BAR_0,
 	.alignment = SZ_4K,
 	.irq_type = IRQ_TYPE_MSI,
+	.flags = GFP_KERNEL,
 };
 
 static const struct pci_endpoint_test_data am654_data = {
 	.test_reg_bar = BAR_2,
 	.alignment = SZ_64K,
 	.irq_type = IRQ_TYPE_MSI,
+	.flags = GFP_KERNEL,
 };
 
 static const struct pci_endpoint_test_data j721e_data = {
 	.alignment = 256,
 	.irq_type = IRQ_TYPE_MSI,
+	.flags = GFP_KERNEL,
 };
 
 static const struct pci_endpoint_test_data renesas_rzg2x_data = {
 	.test_reg_bar = BAR_0,
 	.irq_type = IRQ_TYPE_MSI,
 	.dmac_data_alignment = 8,
+	.flags = GFP_KERNEL | GFP_DMA,
 };
 
 static const struct pci_device_id pci_endpoint_test_tbl[] = {
-- 
2.25.1

