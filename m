Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE82494BA3
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 11:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359849AbiATK1E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 05:27:04 -0500
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25589 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359850AbiATK07 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 05:26:59 -0500
X-Greylist: delayed 908 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Jan 2022 05:26:59 EST
ARC-Seal: i=1; a=rsa-sha256; t=1642673499; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=kYa9uG1/jCWZP/JiN5Nz1V/eoXA1rrqvmgP2jh6Vra6ynd9glF7t8YtDpEbS7wMhJCR2sTiNXTWcVblQSAw3BDilYgQQBiB5WRn1f79nxrxnJjL85W/lur0DIesBAlP7nh91kRcyT7BserpCG2fiUrVH94jH4sQ+Hg4coeG5rF4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1642673499; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=hUkAjx8bXAZHxayySh1n5KbdoqxfTn8BaHNZ/mTgqV8=; 
        b=F7IvsDPK7BSE2Y+RZQcD80a+HJH0wvCK+cOMhLlSqwAg7Xs7c3VbZZg2EfjBn0HHesyQKM1W6sskyqBXBDK/lbev3kD3QC03u0KALCQlkrcCyoXZ2oFeBOXmdm/vwSdI3bJTtMuUjGQzKBsUG3F+y3Zf3D34d0d7iJbMkujEn6o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1642673499;
        s=zm2020; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:From:To:Message-ID:In-Reply-To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=hUkAjx8bXAZHxayySh1n5KbdoqxfTn8BaHNZ/mTgqV8=;
        b=CO4uu37ZCfH1Jfj2cw2XR7HIjgICak66y2o8SZQcJ/RyA3UiP2xD7JqPUS2i1hTI
        ykAu2PppvTQH7taDHGPLZrcYm/GzHCMGwmpTqOnwEjCCcsUxMstZv3lPxxooxR/dDvE
        zZs4yauUZ+8v6v8/UNak2pFgcO2AqxDWpL8SUOL0=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1642673496435189.80323781141738; Thu, 20 Jan 2022 02:11:36 -0800 (PST)
Received: from  [203.218.243.128] by mail.zoho.com
        with HTTP;Thu, 20 Jan 2022 02:11:36 -0800 (PST)
Date:   Thu, 20 Jan 2022 18:11:36 +0800
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "Kishon Vijay Abraham I" <kishon@ti.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-pci" <linux-pci@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17e76f86155.1222b3923123229.7199263965880267375@zohomail.com>
In-Reply-To: 
Subject: [PATCH V3] misc: pci_endpoint_test: simplify endpoint test read and
 write operations
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce pci_endpoint_epf_transfer_data to simplify
read and write operations.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
Changes in V2:
fix WARNING: line length of 108 exceeds 100 columns
#128: FILE: drivers/misc/pci_endpoint_test.c:243:
Changes in V3:
This patch context doesn't change but resend with my Zoho mail account in that previous 
company mail will contain un-removeable proprietary messages.

 drivers/misc/pci_endpoint_test.c | 289 ++++++++++++-------------------
 1 file changed, 109 insertions(+), 180 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 2ed7e3aaff3a8..b6b0b19b251b3 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -103,6 +103,11 @@ enum pci_barno {
 	BAR_5,
 };
 
+enum operation {
+	EPF_READ,
+	EPF_WRITE,
+};
+
 struct pci_endpoint_test {
 	struct pci_dev	*pdev;
 	void __iomem	*base;
@@ -142,6 +147,108 @@ static inline u32 pci_endpoint_test_bar_readl(struct pci_endpoint_test *test,
 {
 	return readl(test->bar[bar] + offset);
 }
+static bool pci_endpoint_test_transfer_data(struct pci_endpoint_test *test,
+				unsigned long arg, const enum operation operation)
+{
+	struct pci_endpoint_test_xfer_param param;
+	bool ret = false;
+	u32 flags = 0;
+	bool use_dma;
+	void *addr;
+	dma_addr_t phys_addr;
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	void *orig_addr;
+	dma_addr_t orig_phys_addr;
+	size_t offset;
+	size_t alignment = test->alignment;
+	int irq_type = test->irq_type;
+	size_t size;
+	int err;
+
+	err = copy_from_user(&param, (void __user *)arg, sizeof(param));
+	if (err != 0) {
+		dev_err(dev, "Failed to get transfer param\n");
+		return false;
+	}
+
+	size = param.size;
+	if (size > SIZE_MAX - alignment)
+		goto err;
+
+	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
+	if (use_dma)
+		flags |= FLAG_USE_DMA;
+
+	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		goto err;
+	}
+
+	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
+	if (!orig_addr)
+		goto err;
+
+	get_random_bytes(orig_addr, size + alignment);
+
+	orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
+					operation == EPF_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	if (dma_mapping_error(dev, orig_phys_addr)) {
+		dev_err(dev, "failed to map source buffer address\n");
+		goto err_phys_addr;
+	}
+
+	if (alignment && !IS_ALIGNED(orig_phys_addr, alignment)) {
+		phys_addr = PTR_ALIGN(orig_phys_addr, alignment);
+		offset = phys_addr - orig_phys_addr;
+		addr = orig_addr + offset;
+	} else {
+		phys_addr = orig_phys_addr;
+		addr = orig_addr;
+	}
+
+	if (operation == EPF_WRITE) {
+
+		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_CHECKSUM,
+				 crc32_le(~0, addr, size));
+
+		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_SRC_ADDR,
+								lower_32_bits(phys_addr));
+		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_SRC_ADDR,
+								upper_32_bits(phys_addr));
+	} else {
+		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_DST_ADDR,
+								lower_32_bits(phys_addr));
+		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_DST_ADDR,
+								upper_32_bits(phys_addr));
+	}
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+
+	// if we ask rc to write to ep, then ep should do read operation, and vice versa.
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 operation == EPF_WRITE ? COMMAND_READ : COMMAND_WRITE);
+
+	wait_for_completion(&test->irq_raised);
+
+	dma_unmap_single(dev, orig_phys_addr, size + alignment,
+					 operation == EPF_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+
+	if (operation == WRITE)
+		ret = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS) & STATUS_READ_SUCCESS;
+	else
+		ret = crc32_le(~0, addr, size) ==
+			pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM);
+
+err_phys_addr:
+	kfree(orig_addr);
+
+err:
+	return ret;
+}
 
 static inline void pci_endpoint_test_bar_writel(struct pci_endpoint_test *test,
 						int bar, u32 offset, u32 value)
@@ -473,191 +580,13 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 				    unsigned long arg)
 {
-	struct pci_endpoint_test_xfer_param param;
-	bool ret = false;
-	u32 flags = 0;
-	bool use_dma;
-	u32 reg;
-	void *addr;
-	dma_addr_t phys_addr;
-	struct pci_dev *pdev = test->pdev;
-	struct device *dev = &pdev->dev;
-	void *orig_addr;
-	dma_addr_t orig_phys_addr;
-	size_t offset;
-	size_t alignment = test->alignment;
-	int irq_type = test->irq_type;
-	size_t size;
-	u32 crc32;
-	int err;
-
-	err = copy_from_user(&param, (void __user *)arg, sizeof(param));
-	if (err != 0) {
-		dev_err(dev, "Failed to get transfer param\n");
-		return false;
-	}
-
-	size = param.size;
-	if (size > SIZE_MAX - alignment)
-		goto err;
-
-	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
-	if (use_dma)
-		flags |= FLAG_USE_DMA;
-
-	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
-		dev_err(dev, "Invalid IRQ type option\n");
-		goto err;
-	}
-
-	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
-	if (!orig_addr) {
-		dev_err(dev, "Failed to allocate address\n");
-		ret = false;
-		goto err;
-	}
-
-	get_random_bytes(orig_addr, size + alignment);
-
-	orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
-					DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, orig_phys_addr)) {
-		dev_err(dev, "failed to map source buffer address\n");
-		ret = false;
-		goto err_phys_addr;
-	}
-
-	if (alignment && !IS_ALIGNED(orig_phys_addr, alignment)) {
-		phys_addr =  PTR_ALIGN(orig_phys_addr, alignment);
-		offset = phys_addr - orig_phys_addr;
-		addr = orig_addr + offset;
-	} else {
-		phys_addr = orig_phys_addr;
-		addr = orig_addr;
-	}
-
-	crc32 = crc32_le(~0, addr, size);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_CHECKSUM,
-				 crc32);
-
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_SRC_ADDR,
-				 lower_32_bits(phys_addr));
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_SRC_ADDR,
-				 upper_32_bits(phys_addr));
-
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
-
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 COMMAND_READ);
-
-	wait_for_completion(&test->irq_raised);
-
-	reg = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
-	if (reg & STATUS_READ_SUCCESS)
-		ret = true;
-
-	dma_unmap_single(dev, orig_phys_addr, size + alignment,
-			 DMA_TO_DEVICE);
-
-err_phys_addr:
-	kfree(orig_addr);
-
-err:
-	return ret;
+	return pci_endpoint_test_transfer_data(test, arg, EPF_WRITE);
 }
 
 static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 				   unsigned long arg)
 {
-	struct pci_endpoint_test_xfer_param param;
-	bool ret = false;
-	u32 flags = 0;
-	bool use_dma;
-	size_t size;
-	void *addr;
-	dma_addr_t phys_addr;
-	struct pci_dev *pdev = test->pdev;
-	struct device *dev = &pdev->dev;
-	void *orig_addr;
-	dma_addr_t orig_phys_addr;
-	size_t offset;
-	size_t alignment = test->alignment;
-	int irq_type = test->irq_type;
-	u32 crc32;
-	int err;
-
-	err = copy_from_user(&param, (void __user *)arg, sizeof(param));
-	if (err) {
-		dev_err(dev, "Failed to get transfer param\n");
-		return false;
-	}
-
-	size = param.size;
-	if (size > SIZE_MAX - alignment)
-		goto err;
-
-	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
-	if (use_dma)
-		flags |= FLAG_USE_DMA;
-
-	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
-		dev_err(dev, "Invalid IRQ type option\n");
-		goto err;
-	}
-
-	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
-	if (!orig_addr) {
-		dev_err(dev, "Failed to allocate destination address\n");
-		ret = false;
-		goto err;
-	}
-
-	orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
-					DMA_FROM_DEVICE);
-	if (dma_mapping_error(dev, orig_phys_addr)) {
-		dev_err(dev, "failed to map source buffer address\n");
-		ret = false;
-		goto err_phys_addr;
-	}
-
-	if (alignment && !IS_ALIGNED(orig_phys_addr, alignment)) {
-		phys_addr = PTR_ALIGN(orig_phys_addr, alignment);
-		offset = phys_addr - orig_phys_addr;
-		addr = orig_addr + offset;
-	} else {
-		phys_addr = orig_phys_addr;
-		addr = orig_addr;
-	}
-
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_DST_ADDR,
-				 lower_32_bits(phys_addr));
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_DST_ADDR,
-				 upper_32_bits(phys_addr));
-
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
-
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 COMMAND_WRITE);
-
-	wait_for_completion(&test->irq_raised);
-
-	dma_unmap_single(dev, orig_phys_addr, size + alignment,
-			 DMA_FROM_DEVICE);
-
-	crc32 = crc32_le(~0, addr, size);
-	if (crc32 == pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM))
-		ret = true;
-
-err_phys_addr:
-	kfree(orig_addr);
-err:
-	return ret;
+	return pci_endpoint_test_transfer_data(test, arg, EPF_READ);
 }
 
 static bool pci_endpoint_test_clear_irq(struct pci_endpoint_test *test)
-- 
2.34.1

