Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3F34AE765
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 04:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiBIDCq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 22:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359741AbiBICvY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 21:51:24 -0500
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8564FC061353;
        Tue,  8 Feb 2022 18:49:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1644374988; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=kuc48FrmESli2C1YS1GIML8e/BiSZ1QUz6jM8pkp7jrwAJGCnyyuD6sk9VJbXqEGhLsoiP9hYR5Ss7qefk3Jsfx1U2GkAtyJblpFluLAaAmTb57NIw5tTAQVQJa5HXsjp8PQNG/GhXKBkO0fuuAL8hodq+7yvwmjWl2BlC+DW7s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1644374988; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=vrVxNXPVZAa+lXLCCCN4URRsfh4Y8/D9V9GK7c6ZZTk=; 
        b=MX+8QGo4TtIyCMkQIDpke3lQ5ZcCPqd4Vra3eCxiFC16qOoXPEbytkg3vP6mbg7hGfmFV98aOthpKjcwAZbKmqRAQer/svRaHPcAywSzcmhdtRf60lKogGErTWVXWy04LECDRH8AdITOqy/A+ehOYJ43x1VTtqxMnkgrBgSTwVk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1644374988;
        s=zm2020; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=vrVxNXPVZAa+lXLCCCN4URRsfh4Y8/D9V9GK7c6ZZTk=;
        b=ECI5TwhrZ2bgVU78QKRoEhZhTH/ivzDLZgAn8f96sgD3FzdzAp5Ho2l8HcxuX8t2
        uC4EHjIJjivwcqDWwyoaxxMoQ0etm4RQewoRwk/507q1RPfuJ8db0a58u4e4+EEcF5s
        qBe9FLwNt5VxSqYhmqzN8/vKnEm9RL8azn5dei6A=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1644374986511392.386513141631; Tue, 8 Feb 2022 18:49:46 -0800 (PST)
Received: from  [40.115.208.189] by mail.zoho.com
        with HTTP;Tue, 8 Feb 2022 18:49:46 -0800 (PST)
Date:   Tue, 08 Feb 2022 21:49:46 -0500
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Kishon Vijay Abraham I" <kishon@ti.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-pci" <linux-pci@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17edc630ef0.11d8ab06115620.4524266185949873552@zohomail.com>
In-Reply-To: <20220208152106.GA476995@bhelgaas>
References: <20220208152106.GA476995@bhelgaas>
Subject: [PATCH V7] misc: pci_endpoint_test: simplify endpoint test read and
 write operations
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Li Chen <lchen@ambarella.com>

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
Changes in V4:
Add "From:" to the first line of the message body.
Changes in V5:
tabify file
replace enum EPF_WRITE/EPF_READ with WRITE/READ from linux/kernel.h
get_random_bytes only when WRITE.
Changes in V6:
remove useless "Date:" and "Subject:" in message body, only preserve "From:" tag. 
Changes in V7:
use /* */ comments to match the prevailing kernel comment style
capitalize "RC" and "EP" since they're not real words.
remove tabify in that the original code have no style issue if tab is 8-width.

 drivers/misc/pci_endpoint_test.c | 286 ++++++++++++-------------------
 1 file changed, 106 insertions(+), 180 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 8f786a225dcf8..30adf0e4c36a0 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/kernel.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -142,6 +143,109 @@ static inline u32 pci_endpoint_test_bar_readl(struct pci_endpoint_test *test,
 {
 	return readl(test->bar[bar] + offset);
 }
+static bool pci_endpoint_test_transfer_data(struct pci_endpoint_test *test,
+				unsigned long arg, const int operation)
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
+	if (operation == WRITE)
+		get_random_bytes(orig_addr, size + alignment);
+
+	orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
+					operation == WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
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
+	if (operation == WRITE) {
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
+	/* if we ask RC to write to EP, then EP should do read operation, and vice versa. */
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 operation == WRITE ? COMMAND_READ : COMMAND_WRITE);
+
+	wait_for_completion(&test->irq_raised);
+
+	dma_unmap_single(dev, orig_phys_addr, size + alignment,
+					 operation == WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
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
@@ -473,191 +577,13 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
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
+	return pci_endpoint_test_transfer_data(test, arg, WRITE);
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
+	return pci_endpoint_test_transfer_data(test, arg, READ);
 }
 
 static bool pci_endpoint_test_clear_irq(struct pci_endpoint_test *test)
-- 
2.34.1


