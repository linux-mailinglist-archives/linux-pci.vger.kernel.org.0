Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0488523ADF
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 18:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242136AbiEKQwu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 12:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243028AbiEKQwu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 12:52:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1B80B60;
        Wed, 11 May 2022 09:52:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7B04ED1;
        Wed, 11 May 2022 09:52:48 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.1.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AC1D3F73D;
        Wed, 11 May 2022 09:52:47 -0700 (PDT)
Date:   Wed, 11 May 2022 17:52:43 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Li Chen <lchen.firstlove@zohomail.com>, kishon@ti.com
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V7] misc: pci_endpoint_test: simplify endpoint test read
 and write operations
Message-ID: <Ynvp25i3zijc9/ce@lpieralisi>
References: <20220208152106.GA476995@bhelgaas>
 <17edc630ef0.11d8ab06115620.4524266185949873552@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17edc630ef0.11d8ab06115620.4524266185949873552@zohomail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On Tue, Feb 08, 2022 at 09:49:46PM -0500, Li Chen wrote:
> From: Li Chen <lchen@ambarella.com>
> 
> Introduce pci_endpoint_epf_transfer_data to simplify
> read and write operations.
> 
> Signed-off-by: Li Chen <lchen@ambarella.com>
> ---
> Changes in V2:
> fix WARNING: line length of 108 exceeds 100 columns
> #128: FILE: drivers/misc/pci_endpoint_test.c:243:
> Changes in V3:
> This patch context doesn't change but resend with my Zoho mail account in that previous
> company mail will contain un-removeable proprietary messages.
> Changes in V4:
> Add "From:" to the first line of the message body.
> Changes in V5:
> tabify file
> replace enum EPF_WRITE/EPF_READ with WRITE/READ from linux/kernel.h
> get_random_bytes only when WRITE.
> Changes in V6:
> remove useless "Date:" and "Subject:" in message body, only preserve "From:" tag. 
> Changes in V7:
> use /* */ comments to match the prevailing kernel comment style
> capitalize "RC" and "EP" since they're not real words.
> remove tabify in that the original code have no style issue if tab is 8-width.
> 
>  drivers/misc/pci_endpoint_test.c | 286 ++++++++++++-------------------
>  1 file changed, 106 insertions(+), 180 deletions(-)

Please review these changes when you can, thanks.

Lorenzo

> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 8f786a225dcf8..30adf0e4c36a0 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -12,6 +12,7 @@
>  #include <linux/io.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/kernel.h>
>  #include <linux/miscdevice.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -142,6 +143,109 @@ static inline u32 pci_endpoint_test_bar_readl(struct pci_endpoint_test *test,
>  {
>  	return readl(test->bar[bar] + offset);
>  }
> +static bool pci_endpoint_test_transfer_data(struct pci_endpoint_test *test,
> +				unsigned long arg, const int operation)
> +{
> +	struct pci_endpoint_test_xfer_param param;
> +	bool ret = false;
> +	u32 flags = 0;
> +	bool use_dma;
> +	void *addr;
> +	dma_addr_t phys_addr;
> +	struct pci_dev *pdev = test->pdev;
> +	struct device *dev = &pdev->dev;
> +	void *orig_addr;
> +	dma_addr_t orig_phys_addr;
> +	size_t offset;
> +	size_t alignment = test->alignment;
> +	int irq_type = test->irq_type;
> +	size_t size;
> +	int err;
> +
> +	err = copy_from_user(&param, (void __user *)arg, sizeof(param));
> +	if (err != 0) {
> +		dev_err(dev, "Failed to get transfer param\n");
> +		return false;
> +	}
> +
> +	size = param.size;
> +	if (size > SIZE_MAX - alignment)
> +		goto err;
> +
> +	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
> +	if (use_dma)
> +		flags |= FLAG_USE_DMA;
> +
> +	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
> +		dev_err(dev, "Invalid IRQ type option\n");
> +		goto err;
> +	}
> +
> +	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
> +	if (!orig_addr)
> +		goto err;
> +
> +	if (operation == WRITE)
> +		get_random_bytes(orig_addr, size + alignment);
> +
> +	orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
> +					operation == WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
> +	if (dma_mapping_error(dev, orig_phys_addr)) {
> +		dev_err(dev, "failed to map source buffer address\n");
> +		goto err_phys_addr;
> +	}
> +
> +	if (alignment && !IS_ALIGNED(orig_phys_addr, alignment)) {
> +		phys_addr = PTR_ALIGN(orig_phys_addr, alignment);
> +		offset = phys_addr - orig_phys_addr;
> +		addr = orig_addr + offset;
> +	} else {
> +		phys_addr = orig_phys_addr;
> +		addr = orig_addr;
> +	}
> +
> +	if (operation == WRITE) {
> +
> +		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_CHECKSUM,
> +				 crc32_le(~0, addr, size));
> +
> +		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_SRC_ADDR,
> +								lower_32_bits(phys_addr));
> +		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_SRC_ADDR,
> +								upper_32_bits(phys_addr));
> +	} else {
> +		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_DST_ADDR,
> +								lower_32_bits(phys_addr));
> +		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_DST_ADDR,
> +								upper_32_bits(phys_addr));
> +	}
> +
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
> +
> +	/* if we ask RC to write to EP, then EP should do read operation, and vice versa. */
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> +				 operation == WRITE ? COMMAND_READ : COMMAND_WRITE);
> +
> +	wait_for_completion(&test->irq_raised);
> +
> +	dma_unmap_single(dev, orig_phys_addr, size + alignment,
> +					 operation == WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
> +
> +	if (operation == WRITE)
> +		ret = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS) & STATUS_READ_SUCCESS;
> +	else
> +		ret = crc32_le(~0, addr, size) ==
> +			pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM);
> +
> +err_phys_addr:
> +	kfree(orig_addr);
> +
> +err:
> +	return ret;
> +}
>  
>  static inline void pci_endpoint_test_bar_writel(struct pci_endpoint_test *test,
>  						int bar, u32 offset, u32 value)
> @@ -473,191 +577,13 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
>  static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
>  				    unsigned long arg)
>  {
> -	struct pci_endpoint_test_xfer_param param;
> -	bool ret = false;
> -	u32 flags = 0;
> -	bool use_dma;
> -	u32 reg;
> -	void *addr;
> -	dma_addr_t phys_addr;
> -	struct pci_dev *pdev = test->pdev;
> -	struct device *dev = &pdev->dev;
> -	void *orig_addr;
> -	dma_addr_t orig_phys_addr;
> -	size_t offset;
> -	size_t alignment = test->alignment;
> -	int irq_type = test->irq_type;
> -	size_t size;
> -	u32 crc32;
> -	int err;
> -
> -	err = copy_from_user(&param, (void __user *)arg, sizeof(param));
> -	if (err != 0) {
> -		dev_err(dev, "Failed to get transfer param\n");
> -		return false;
> -	}
> -
> -	size = param.size;
> -	if (size > SIZE_MAX - alignment)
> -		goto err;
> -
> -	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
> -	if (use_dma)
> -		flags |= FLAG_USE_DMA;
> -
> -	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
> -		dev_err(dev, "Invalid IRQ type option\n");
> -		goto err;
> -	}
> -
> -	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
> -	if (!orig_addr) {
> -		dev_err(dev, "Failed to allocate address\n");
> -		ret = false;
> -		goto err;
> -	}
> -
> -	get_random_bytes(orig_addr, size + alignment);
> -
> -	orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
> -					DMA_TO_DEVICE);
> -	if (dma_mapping_error(dev, orig_phys_addr)) {
> -		dev_err(dev, "failed to map source buffer address\n");
> -		ret = false;
> -		goto err_phys_addr;
> -	}
> -
> -	if (alignment && !IS_ALIGNED(orig_phys_addr, alignment)) {
> -		phys_addr =  PTR_ALIGN(orig_phys_addr, alignment);
> -		offset = phys_addr - orig_phys_addr;
> -		addr = orig_addr + offset;
> -	} else {
> -		phys_addr = orig_phys_addr;
> -		addr = orig_addr;
> -	}
> -
> -	crc32 = crc32_le(~0, addr, size);
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_CHECKSUM,
> -				 crc32);
> -
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_SRC_ADDR,
> -				 lower_32_bits(phys_addr));
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_SRC_ADDR,
> -				 upper_32_bits(phys_addr));
> -
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
> -
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> -				 COMMAND_READ);
> -
> -	wait_for_completion(&test->irq_raised);
> -
> -	reg = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> -	if (reg & STATUS_READ_SUCCESS)
> -		ret = true;
> -
> -	dma_unmap_single(dev, orig_phys_addr, size + alignment,
> -			 DMA_TO_DEVICE);
> -
> -err_phys_addr:
> -	kfree(orig_addr);
> -
> -err:
> -	return ret;
> +	return pci_endpoint_test_transfer_data(test, arg, WRITE);
>  }
>  
>  static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
>  				   unsigned long arg)
>  {
> -	struct pci_endpoint_test_xfer_param param;
> -	bool ret = false;
> -	u32 flags = 0;
> -	bool use_dma;
> -	size_t size;
> -	void *addr;
> -	dma_addr_t phys_addr;
> -	struct pci_dev *pdev = test->pdev;
> -	struct device *dev = &pdev->dev;
> -	void *orig_addr;
> -	dma_addr_t orig_phys_addr;
> -	size_t offset;
> -	size_t alignment = test->alignment;
> -	int irq_type = test->irq_type;
> -	u32 crc32;
> -	int err;
> -
> -	err = copy_from_user(&param, (void __user *)arg, sizeof(param));
> -	if (err) {
> -		dev_err(dev, "Failed to get transfer param\n");
> -		return false;
> -	}
> -
> -	size = param.size;
> -	if (size > SIZE_MAX - alignment)
> -		goto err;
> -
> -	use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
> -	if (use_dma)
> -		flags |= FLAG_USE_DMA;
> -
> -	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
> -		dev_err(dev, "Invalid IRQ type option\n");
> -		goto err;
> -	}
> -
> -	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
> -	if (!orig_addr) {
> -		dev_err(dev, "Failed to allocate destination address\n");
> -		ret = false;
> -		goto err;
> -	}
> -
> -	orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
> -					DMA_FROM_DEVICE);
> -	if (dma_mapping_error(dev, orig_phys_addr)) {
> -		dev_err(dev, "failed to map source buffer address\n");
> -		ret = false;
> -		goto err_phys_addr;
> -	}
> -
> -	if (alignment && !IS_ALIGNED(orig_phys_addr, alignment)) {
> -		phys_addr = PTR_ALIGN(orig_phys_addr, alignment);
> -		offset = phys_addr - orig_phys_addr;
> -		addr = orig_addr + offset;
> -	} else {
> -		phys_addr = orig_phys_addr;
> -		addr = orig_addr;
> -	}
> -
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_DST_ADDR,
> -				 lower_32_bits(phys_addr));
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_DST_ADDR,
> -				 upper_32_bits(phys_addr));
> -
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
> -
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
> -	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> -				 COMMAND_WRITE);
> -
> -	wait_for_completion(&test->irq_raised);
> -
> -	dma_unmap_single(dev, orig_phys_addr, size + alignment,
> -			 DMA_FROM_DEVICE);
> -
> -	crc32 = crc32_le(~0, addr, size);
> -	if (crc32 == pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM))
> -		ret = true;
> -
> -err_phys_addr:
> -	kfree(orig_addr);
> -err:
> -	return ret;
> +	return pci_endpoint_test_transfer_data(test, arg, READ);
>  }
>  
>  static bool pci_endpoint_test_clear_irq(struct pci_endpoint_test *test)
> -- 
> 2.34.1
> 
> 
