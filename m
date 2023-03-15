Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA126BB8D6
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 16:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjCOP7D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 11:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjCOP65 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 11:58:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0958021292
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 08:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5B1A61DE3
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 15:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE4AC433EF;
        Wed, 15 Mar 2023 15:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678895874;
        bh=0pGKvS/ywnMLSZ/NTRlHk2/y0xAk13taBnMyHVTGSBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uevyEE2XW6KiHUI1Ky9p5LfdICyham4jFjaXsFJVY3l/oT9NECM/9168AvDeVgX5a
         yCSbcPHsSfKJOKTMyCSYFCanG55mCFduDSawg5PsMiZ2MUsg/Lh23I8K0WCroJHZil
         r6YxQzrsT9vgLoZ8W/50Nz7N/QRlQzPBdENWdix74yq9h+CKkzxVQtcGv0M/4tcGB0
         dtd/TouC94UbUiPnbeR2+f+gHY9vyvZEmM8b1RKPCB/S9NXkpKs5aa9MBcj1RCwmJA
         jxu77F8yYBDEIZkyPHFi6JZRifyN9TsgFlT84/HmgBl0b2R7Y9muQ3gNUueZum/GTM
         wMPEpGC94UudA==
Date:   Wed, 15 Mar 2023 21:27:39 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 11/16] PCI: epf-test: Simplify dma support checks
Message-ID: <20230315155739.GN98488@thinkpad>
References: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
 <20230308090313.1653-12-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308090313.1653-12-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 08, 2023 at 06:03:08PM +0900, Damien Le Moal wrote:
> There is no need to have each read, write and copy test functions check
> for the FLAG_USE_DMA flag against the dma support status indicated by
> epf_test->dma_supported. Move this test to the command handler function
> pci_epf_test_cmd_handler() to check once for all cases.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 45 +++++++------------
>  1 file changed, 15 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index d1b5441391fb..eaa252a170a2 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -331,7 +331,6 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test,
>  			     struct pci_epf_test_reg *reg)
>  {
>  	int ret;
> -	bool use_dma;
>  	void __iomem *src_addr;
>  	void __iomem *dst_addr;
>  	phys_addr_t src_phys_addr;
> @@ -374,14 +373,7 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test,
>  	}
>  
>  	ktime_get_ts64(&start);
> -	use_dma = !!(reg->flags & FLAG_USE_DMA);
> -	if (use_dma) {
> -		if (!epf_test->dma_supported) {
> -			dev_err(dev, "Cannot transfer data using DMA\n");
> -			ret = -EINVAL;
> -			goto err_map_addr;
> -		}
> -
> +	if (reg->flags & FLAG_USE_DMA) {
>  		if (epf_test->dma_private) {
>  			dev_err(dev, "Cannot transfer data using DMA\n");
>  			ret = -EINVAL;
> @@ -407,7 +399,8 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test,
>  		kfree(buf);
>  	}
>  	ktime_get_ts64(&end);
> -	pci_epf_test_print_rate("COPY", reg->size, &start, &end, use_dma);
> +	pci_epf_test_print_rate("COPY", reg->size, &start, &end,
> +				reg->flags & FLAG_USE_DMA);
>  
>  err_map_addr:
>  	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr);
> @@ -432,7 +425,6 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test,
>  	void __iomem *src_addr;
>  	void *buf;
>  	u32 crc32;
> -	bool use_dma;
>  	phys_addr_t phys_addr;
>  	phys_addr_t dst_phys_addr;
>  	struct timespec64 start, end;
> @@ -463,14 +455,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test,
>  		goto err_map_addr;
>  	}
>  
> -	use_dma = !!(reg->flags & FLAG_USE_DMA);
> -	if (use_dma) {
> -		if (!epf_test->dma_supported) {
> -			dev_err(dev, "Cannot transfer data using DMA\n");
> -			ret = -EINVAL;
> -			goto err_dma_map;
> -		}
> -
> +	if (reg->flags & FLAG_USE_DMA) {
>  		dst_phys_addr = dma_map_single(dma_dev, buf, reg->size,
>  					       DMA_FROM_DEVICE);
>  		if (dma_mapping_error(dma_dev, dst_phys_addr)) {
> @@ -495,7 +480,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test,
>  		ktime_get_ts64(&end);
>  	}
>  
> -	pci_epf_test_print_rate("READ", reg->size, &start, &end, use_dma);
> +	pci_epf_test_print_rate("READ", reg->size, &start, &end,
> +				reg->flags & FLAG_USE_DMA);
>  
>  	crc32 = crc32_le(~0, buf, reg->size);
>  	if (crc32 != reg->checksum)
> @@ -520,7 +506,6 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test,
>  	int ret;
>  	void __iomem *dst_addr;
>  	void *buf;
> -	bool use_dma;
>  	phys_addr_t phys_addr;
>  	phys_addr_t src_phys_addr;
>  	struct timespec64 start, end;
> @@ -554,14 +539,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test,
>  	get_random_bytes(buf, reg->size);
>  	reg->checksum = crc32_le(~0, buf, reg->size);
>  
> -	use_dma = !!(reg->flags & FLAG_USE_DMA);
> -	if (use_dma) {
> -		if (!epf_test->dma_supported) {
> -			dev_err(dev, "Cannot transfer data using DMA\n");
> -			ret = -EINVAL;
> -			goto err_dma_map;
> -		}
> -
> +	if (reg->flags & FLAG_USE_DMA) {
>  		src_phys_addr = dma_map_single(dma_dev, buf, reg->size,
>  					       DMA_TO_DEVICE);
>  		if (dma_mapping_error(dma_dev, src_phys_addr)) {
> @@ -588,7 +566,8 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test,
>  		ktime_get_ts64(&end);
>  	}
>  
> -	pci_epf_test_print_rate("WRITE", reg->size, &start, &end, use_dma);
> +	pci_epf_test_print_rate("WRITE", reg->size, &start, &end,
> +				reg->flags & FLAG_USE_DMA);
>  
>  	/*
>  	 * wait 1ms inorder for the write to complete. Without this delay L3
> @@ -673,6 +652,12 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	WRITE_ONCE(reg->command, 0);
>  	WRITE_ONCE(reg->status, 0);
>  
> +	if ((READ_ONCE(reg->flags) & FLAG_USE_DMA) &&
> +	    !epf_test->dma_supported) {
> +		dev_err(dev, "Cannot transfer data using DMA\n");
> +		goto reset_handler;
> +	}
> +
>  	if (reg->irq_type > IRQ_TYPE_MSIX) {
>  		dev_err(dev, "Failed to detect IRQ type\n");
>  		goto reset_handler;
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
