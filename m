Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F03B69911F
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 11:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjBPK1h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 05:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBPK1g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 05:27:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC75E10A9F
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 02:27:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6836CB823E0
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 10:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFB2C433EF;
        Thu, 16 Feb 2023 10:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676543253;
        bh=PpSe6GkNEzV9PQVeXeuYNtYlLB5AXX2l5Cc1sWHG8YI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hg1zI77t4mKmtuchLtVdox9MBfSFMmmKOCXSxPzcRsrFgHAACt4RzRbuV16uFgWsF
         J9g6j16bP6UYROftXu2YR4m5s/6ekfRm5wPYOZD+6RWoHS+KGermDYaOwxf6yiwal4
         oaJMSAeKIa0bNN67gAKcxLrkU4bh4x6oq+HixAaeOoGHCdQwZPFn+S31ktEKjuaabR
         XmPtjdO0LepP4thY/x+KjcZpJ7CnIgEKx66v8vuboKhaeKcSuQMWzHu/aaymM1zW3F
         C3VZSqk+II6D7AW7zxO1HVzUmSGdoUyMywTC8sl1sWEpBbI8lndyXyi1PNUs5m6Jfs
         pPbBa5fd/SZ6w==
Date:   Thu, 16 Feb 2023 15:57:19 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 05/12] pci: epf-test: Simplify dma support checks
Message-ID: <20230216102719.GG2420@thinkpad>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
 <20230215032155.74993-6-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230215032155.74993-6-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 12:21:48PM +0900, Damien Le Moal wrote:
> There is no need to have each read, write and copy test functions check
> for the FLAG_USE_DMA flag against the dma support status indicated by
> epf_test->dma_supported. Move this test to the command handler function
> pci_epf_test_cmd_handler() to check once for all cases. The functions
> pci_epf_test_write(), pci_epf_test_read() and pci_epf_test_copy() are
> modified to add the use_dma boolean argument to indicate if transfers
> should be done using DMA or mmio accesses.
> 

For all the endpoint patches, please follow the conventional subject prefix,
which is,

PCI: endpoint:

> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

With that fixed,

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 43 ++++++-------------
>  1 file changed, 13 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index df3074667bbc..e07868c99531 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -327,10 +327,9 @@ static void pci_epf_test_print_rate(const char *ops, u64 size,
>  		(u64)ts.tv_sec, (u32)ts.tv_nsec, rate / 1024);
>  }
>  
> -static int pci_epf_test_copy(struct pci_epf_test *epf_test)
> +static int pci_epf_test_copy(struct pci_epf_test *epf_test, bool use_dma)
>  {
>  	int ret;
> -	bool use_dma;
>  	void __iomem *src_addr;
>  	void __iomem *dst_addr;
>  	phys_addr_t src_phys_addr;
> @@ -375,14 +374,7 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
>  	}
>  
>  	ktime_get_ts64(&start);
> -	use_dma = !!(reg->flags & FLAG_USE_DMA);
>  	if (use_dma) {
> -		if (!epf_test->dma_supported) {
> -			dev_err(dev, "Cannot transfer data using DMA\n");
> -			ret = -EINVAL;
> -			goto err_map_addr;
> -		}
> -
>  		if (epf_test->dma_private) {
>  			dev_err(dev, "Cannot transfer data using DMA\n");
>  			ret = -EINVAL;
> @@ -426,13 +418,12 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
>  	return ret;
>  }
>  
> -static int pci_epf_test_read(struct pci_epf_test *epf_test)
> +static int pci_epf_test_read(struct pci_epf_test *epf_test, bool use_dma)
>  {
>  	int ret;
>  	void __iomem *src_addr;
>  	void *buf;
>  	u32 crc32;
> -	bool use_dma;
>  	phys_addr_t phys_addr;
>  	phys_addr_t dst_phys_addr;
>  	struct timespec64 start, end;
> @@ -465,14 +456,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  		goto err_map_addr;
>  	}
>  
> -	use_dma = !!(reg->flags & FLAG_USE_DMA);
>  	if (use_dma) {
> -		if (!epf_test->dma_supported) {
> -			dev_err(dev, "Cannot transfer data using DMA\n");
> -			ret = -EINVAL;
> -			goto err_dma_map;
> -		}
> -
>  		dst_phys_addr = dma_map_single(dma_dev, buf, reg->size,
>  					       DMA_FROM_DEVICE);
>  		if (dma_mapping_error(dma_dev, dst_phys_addr)) {
> @@ -516,12 +500,11 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  	return ret;
>  }
>  
> -static int pci_epf_test_write(struct pci_epf_test *epf_test)
> +static int pci_epf_test_write(struct pci_epf_test *epf_test, bool use_dma)
>  {
>  	int ret;
>  	void __iomem *dst_addr;
>  	void *buf;
> -	bool use_dma;
>  	phys_addr_t phys_addr;
>  	phys_addr_t src_phys_addr;
>  	struct timespec64 start, end;
> @@ -557,14 +540,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>  	get_random_bytes(buf, reg->size);
>  	reg->checksum = crc32_le(~0, buf, reg->size);
>  
> -	use_dma = !!(reg->flags & FLAG_USE_DMA);
>  	if (use_dma) {
> -		if (!epf_test->dma_supported) {
> -			dev_err(dev, "Cannot transfer data using DMA\n");
> -			ret = -EINVAL;
> -			goto err_dma_map;
> -		}
> -
>  		src_phys_addr = dma_map_single(dma_dev, buf, reg->size,
>  					       DMA_TO_DEVICE);
>  		if (dma_mapping_error(dma_dev, src_phys_addr)) {
> @@ -647,6 +623,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	int ret;
>  	int count;
>  	u32 command;
> +	bool use_dma;
>  	struct pci_epf_test *epf_test = container_of(work, struct pci_epf_test,
>  						     cmd_handler.work);
>  	struct pci_epf *epf = epf_test->epf;
> @@ -662,6 +639,12 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	reg->command = 0;
>  	reg->status = 0;
>  
> +	use_dma = reg->flags & FLAG_USE_DMA;
> +	if (use_dma && !epf_test->dma_supported) {
> +		dev_err(dev, "Cannot transfer data using DMA\n");
> +		goto reset_handler;
> +	}
> +
>  	if (reg->irq_type > IRQ_TYPE_MSIX) {
>  		dev_err(dev, "Failed to detect IRQ type\n");
>  		goto reset_handler;
> @@ -675,7 +658,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	}
>  
>  	if (command & COMMAND_WRITE) {
> -		ret = pci_epf_test_write(epf_test);
> +		ret = pci_epf_test_write(epf_test, use_dma);
>  		if (ret)
>  			reg->status |= STATUS_WRITE_FAIL;
>  		else
> @@ -686,7 +669,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	}
>  
>  	if (command & COMMAND_READ) {
> -		ret = pci_epf_test_read(epf_test);
> +		ret = pci_epf_test_read(epf_test, use_dma);
>  		if (!ret)
>  			reg->status |= STATUS_READ_SUCCESS;
>  		else
> @@ -697,7 +680,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	}
>  
>  	if (command & COMMAND_COPY) {
> -		ret = pci_epf_test_copy(epf_test);
> +		ret = pci_epf_test_copy(epf_test, use_dma);
>  		if (!ret)
>  			reg->status |= STATUS_COPY_SUCCESS;
>  		else
> -- 
> 2.39.1
> 

-- 
மணிவண்ணன் சதாசிவம்
