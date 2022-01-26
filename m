Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7596049D16B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 19:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbiAZSHp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 13:07:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59804 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiAZSHo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jan 2022 13:07:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40C89B80EB0;
        Wed, 26 Jan 2022 18:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C11C340E9;
        Wed, 26 Jan 2022 18:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643220462;
        bh=65ZDoi17bcsQKZgV9WYL6L22SQtTF80HKQFjYnCUUBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eK6Rp6QwOWsPIIq6a3z/WvWxgYSXJI5J1/BZ3jpAfkZAlhwRnOWqRjz/jK072zaTm
         zccNlHxevHpBdgSg7zuh+35PsmQ74/s9KpQAeWPwoV1ZKqWmpIWVOxPPbm0MKUMkTa
         XqMEqYlaId+52KSjaNQCf9Is7VSn/oPqP3S+dU2g=
Date:   Wed, 26 Jan 2022 19:07:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Li Chen <lchen.firstlove@zohomail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?utf-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4] misc: pci_endpoint_test: simplify endpoint test read
 and write operations
Message-ID: <YfGN69H64acLNbtS@kroah.com>
References: <17e76f86155.1222b3923123229.7199263965880267375@zohomail.com>
 <17e7787698b.fb1a6d971174.8745566338649911775@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17e7787698b.fb1a6d971174.8745566338649911775@zohomail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 20, 2022 at 08:47:50PM +0800, Li Chen wrote:
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
> 
> drivers/misc/pci_endpoint_test.c | 289 ++++++++++++-------------------
> 1 file changed, 109 insertions(+), 180 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 2ed7e3aaff3a8..b6b0b19b251b3 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -103,6 +103,11 @@ enum pci_barno {
>     BAR_5,
> };
> 
> +enum operation {
> +    EPF_READ,
> +    EPF_WRITE,
> +};
> +
> struct pci_endpoint_test {
>     struct pci_dev    *pdev;
>     void __iomem    *base;
> @@ -142,6 +147,108 @@ static inline u32 pci_endpoint_test_bar_readl(struct pci_endpoint_test *test,
> {
>     return readl(test->bar[bar] + offset);
> }
> +static bool pci_endpoint_test_transfer_data(struct pci_endpoint_test *test,
> +                unsigned long arg, const enum operation operation)
> +{
> +    struct pci_endpoint_test_xfer_param param;
> +    bool ret = false;
> +    u32 flags = 0;
> +    bool use_dma;
> +    void *addr;
> +    dma_addr_t phys_addr;
> +    struct pci_dev *pdev = test->pdev;
> +    struct device *dev = &pdev->dev;
> +    void *orig_addr;
> +    dma_addr_t orig_phys_addr;
> +    size_t offset;
> +    size_t alignment = test->alignment;
> +    int irq_type = test->irq_type;
> +    size_t size;
> +    int err;
> +
> +    err = copy_from_user(&param, (void __user *)arg, sizeof(param));
> +    if (err != 0) {
> +        dev_err(dev, "Failed to get transfer param\n");
> +        return false;
> +    }
> +
> +    size = param.size;
> +    if (size > SIZE_MAX - alignment)
> +        goto err;
> +
> +    use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
> +    if (use_dma)
> +        flags |= FLAG_USE_DMA;
> +
> +    if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
> +        dev_err(dev, "Invalid IRQ type option\n");
> +        goto err;
> +    }
> +
> +    orig_addr = kzalloc(size + alignment, GFP_KERNEL);
> +    if (!orig_addr)
> +        goto err;
> +
> +    get_random_bytes(orig_addr, size + alignment);
> +
> +    orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
> +                    operation == EPF_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
> +    if (dma_mapping_error(dev, orig_phys_addr)) {
> +        dev_err(dev, "failed to map source buffer address\n");
> +        goto err_phys_addr;
> +    }
> +
> +    if (alignment && !IS_ALIGNED(orig_phys_addr, alignment)) {
> +        phys_addr = PTR_ALIGN(orig_phys_addr, alignment);
> +        offset = phys_addr - orig_phys_addr;
> +        addr = orig_addr + offset;
> +    } else {
> +        phys_addr = orig_phys_addr;
> +        addr = orig_addr;
> +    }
> +
> +    if (operation == EPF_WRITE) {
> +
> +        pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_CHECKSUM,
> +                 crc32_le(~0, addr, size));
> +
> +        pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_SRC_ADDR,
> +                                lower_32_bits(phys_addr));
> +        pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_SRC_ADDR,
> +                                upper_32_bits(phys_addr));
> +    } else {
> +        pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_DST_ADDR,
> +                                lower_32_bits(phys_addr));
> +        pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_DST_ADDR,
> +                                upper_32_bits(phys_addr));
> +    }
> +
> +    pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
> +    pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
> +    pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
> +    pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
> +
> +    // if we ask rc to write to ep, then ep should do read operation, and vice versa.
> +    pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> +                 operation == EPF_WRITE ? COMMAND_READ : COMMAND_WRITE);
> +
> +    wait_for_completion(&test->irq_raised);
> +
> +    dma_unmap_single(dev, orig_phys_addr, size + alignment,
> +                     operation == EPF_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
> +
> +    if (operation == WRITE)
> +        ret = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS) & STATUS_READ_SUCCESS;
> +    else
> +        ret = crc32_le(~0, addr, size) ==
> +            pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM);
> +
> +err_phys_addr:
> +    kfree(orig_addr);
> +
> +err:
> +    return ret;
> +}
> 
> static inline void pci_endpoint_test_bar_writel(struct pci_endpoint_test *test,
>                         int bar, u32 offset, u32 value)
> @@ -473,191 +580,13 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
> static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
>                  unsigned long arg)
> {
> -    struct pci_endpoint_test_xfer_param param;
> -    bool ret = false;
> -    u32 flags = 0;
> -    bool use_dma;
> -    u32 reg;
> -    void *addr;
> -    dma_addr_t phys_addr;
> -    struct pci_dev *pdev = test->pdev;
> -    struct device *dev = &pdev->dev;
> -    void *orig_addr;
> -    dma_addr_t orig_phys_addr;
> -    size_t offset;
> -    size_t alignment = test->alignment;
> -    int irq_type = test->irq_type;
> -    size_t size;
> -    u32 crc32;
> -    int err;
> -
> -    err = copy_from_user(&param, (void __user *)arg, sizeof(param));
> -    if (err != 0) {
> -        dev_err(dev, "Failed to get transfer param\n");
> -        return false;
> -    }
> -
> -    size = param.size;
> -    if (size > SIZE_MAX - alignment)
> -        goto err;
> -
> -    use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
> -    if (use_dma)
> -        flags |= FLAG_USE_DMA;
> -
> -    if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
> -        dev_err(dev, "Invalid IRQ type option\n");
> -        goto err;
> -    }
> -
> -    orig_addr = kzalloc(size + alignment, GFP_KERNEL);
> -    if (!orig_addr) {
> -        dev_err(dev, "Failed to allocate address\n");
> -        ret = false;
> -        goto err;
> -    }
> -
> -    get_random_bytes(orig_addr, size + alignment);
> -
> -    orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
> -                    DMA_TO_DEVICE);
> -    if (dma_mapping_error(dev, orig_phys_addr)) {
> -        dev_err(dev, "failed to map source buffer address\n");
> -        ret = false;
> -        goto err_phys_addr;
> -    }
> -
> -    if (alignment && !IS_ALIGNED(orig_phys_addr, alignment)) {
> -        phys_addr = PTR_ALIGN(orig_phys_addr, alignment);
> -        offset = phys_addr - orig_phys_addr;
> -        addr = orig_addr + offset;
> -    } else {
> -        phys_addr = orig_phys_addr;
> -        addr = orig_addr;
> -    }
> -
> -    crc32 = crc32_le(~0, addr, size);
> -    pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_CHECKSUM,
> -                 crc32);
> -
> -    pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_SRC_ADDR,
> -                 lower_32_bits(phys_addr));
> -    pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_SRC_ADDR,
> -                 upper_32_bits(phys_addr));
> -
> -    pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
> -
> -    pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
> -    pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
> -    pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
> -    pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> -                 COMMAND_READ);
> -
> -    wait_for_completion(&test->irq_raised);
> -
> -    reg = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> -    if (reg & STATUS_READ_SUCCESS)
> -        ret = true;
> -
> -    dma_unmap_single(dev, orig_phys_addr, size + alignment,
> -             DMA_TO_DEVICE);
> -
> -err_phys_addr:
> -    kfree(orig_addr);
> -
> -err:
> -    return ret;
> +    return pci_endpoint_test_transfer_data(test, arg, EPF_WRITE);
> }
> 
> static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
>                  unsigned long arg)
> {
> -    struct pci_endpoint_test_xfer_param param;
> -    bool ret = false;
> -    u32 flags = 0;
> -    bool use_dma;
> -    size_t size;
> -    void *addr;
> -    dma_addr_t phys_addr;
> -    struct pci_dev *pdev = test->pdev;
> -    struct device *dev = &pdev->dev;
> -    void *orig_addr;
> -    dma_addr_t orig_phys_addr;
> -    size_t offset;
> -    size_t alignment = test->alignment;
> -    int irq_type = test->irq_type;
> -    u32 crc32;
> -    int err;
> -
> -    err = copy_from_user(&param, (void __user *)arg, sizeof(param));
> -    if (err) {
> -        dev_err(dev, "Failed to get transfer param\n");
> -        return false;
> -    }
> -
> -    size = param.size;
> -    if (size > SIZE_MAX - alignment)
> -        goto err;
> -
> -    use_dma = !!(param.flags & PCITEST_FLAGS_USE_DMA);
> -    if (use_dma)
> -        flags |= FLAG_USE_DMA;
> -
> -    if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
> -        dev_err(dev, "Invalid IRQ type option\n");
> -        goto err;
> -    }
> -
> -    orig_addr = kzalloc(size + alignment, GFP_KERNEL);
> -    if (!orig_addr) {
> -        dev_err(dev, "Failed to allocate destination address\n");
> -        ret = false;
> -        goto err;
> -    }
> -
> -    orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
> -                    DMA_FROM_DEVICE);
> -    if (dma_mapping_error(dev, orig_phys_addr)) {
> -        dev_err(dev, "failed to map source buffer address\n");
> -        ret = false;
> -        goto err_phys_addr;
> -    }
> -
> -    if (alignment && !IS_ALIGNED(orig_phys_addr, alignment)) {
> -        phys_addr = PTR_ALIGN(orig_phys_addr, alignment);
> -        offset = phys_addr - orig_phys_addr;
> -        addr = orig_addr + offset;
> -    } else {
> -        phys_addr = orig_phys_addr;
> -        addr = orig_addr;
> -    }
> -
> -    pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_DST_ADDR,
> -                 lower_32_bits(phys_addr));
> -    pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_DST_ADDR,
> -                 upper_32_bits(phys_addr));
> -
> -    pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
> -
> -    pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
> -    pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
> -    pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
> -    pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> -                 COMMAND_WRITE);
> -
> -    wait_for_completion(&test->irq_raised);
> -
> -    dma_unmap_single(dev, orig_phys_addr, size + alignment,
> -             DMA_FROM_DEVICE);
> -
> -    crc32 = crc32_le(~0, addr, size);
> -    if (crc32 == pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM))
> -        ret = true;
> -
> -err_phys_addr:
> -    kfree(orig_addr);
> -err:
> -    return ret;
> +    return pci_endpoint_test_transfer_data(test, arg, EPF_READ);
> }
> 
> static bool pci_endpoint_test_clear_irq(struct pci_endpoint_test *test)
> --
> 2.34.1

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.
If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
