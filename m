Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E6E6D16C4
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 07:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjCaFZ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 01:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCaFZ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 01:25:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D2811144
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 22:25:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEB0BB82AFE
        for <linux-pci@vger.kernel.org>; Fri, 31 Mar 2023 05:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA39DC433D2;
        Fri, 31 Mar 2023 05:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680240352;
        bh=sfytSMuukLKT3jozMZiMDTNMU/HdTuHa5wegKCpj6zY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bx5yifrs56WI9Yw06F+3qwklnuzRDK2VK6hQk7EiOEAo2CZ+yEKOs6yQRPFk+b9hX
         X0ToK8ZZr46gfzpel3q4BltY8+g240p5KW5v2prg1zSDe5Zg/J75/6FEmI1BdPI8lo
         0+PWi7TwCJfdSu6svlCsGDsKuqFd4svZc47iOTEC3SiVwAH3Qe6T1CH7i+ObHb6QsN
         8w2XoWmgXZzYmRONXZV7u++Ae+xdik9HHejI35chEl5oFN8nxqWB99ep0o9Xx1pzxb
         jtU2gxcCjO/X3Zd8fIwB8KBJ8IFGcEkmKqeg8CwPKhv/9KoAfovRwiu5gfui8shDTw
         +NcpmWvdn0eKA==
Date:   Fri, 31 Mar 2023 10:55:40 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 04/17] PCI: epf-test: Fix DMA transfer completion
 detection
Message-ID: <20230331052540.GB4973@thinkpad>
References: <20230330085357.2653599-1-damien.lemoal@opensource.wdc.com>
 <20230330085357.2653599-5-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230330085357.2653599-5-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 05:53:44PM +0900, Damien Le Moal wrote:
> pci_epf_test_data_transfer() and pci_epf_test_dma_callback() are not
> handling DMA transfer completion correctly, leading to completion
> notifications to the RC side that are too early. This problem can be
> detected when the RC side is running an IOMMU with messages such as:
> 
> pci-endpoint-test 0000:0b:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
> domain=0x001c address=0xfff00000 flags=0x0000]
> 
> When running the pcitest.sh tests: the address used for a previous
> test transfer generates the above error while the next test transfer is
> running.
> 
> Fix this by testing the dma transfer status in
> pci_epf_test_dma_callback() and notifying the completion only when the
> transfer status is DMA_COMPLETE or DMA_ERROR. Furthermore, in
> pci_epf_test_data_transfer(), be paranoid and check again the transfer
> status and always call dmaengine_terminate_sync() before returning.
> 
> Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 38 +++++++++++++------
>  1 file changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index d65419735d2e..dbea6eb0dee7 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -54,6 +54,9 @@ struct pci_epf_test {
>  	struct delayed_work	cmd_handler;
>  	struct dma_chan		*dma_chan_tx;
>  	struct dma_chan		*dma_chan_rx;
> +	struct dma_chan		*transfer_chan;
> +	dma_cookie_t		transfer_cookie;
> +	enum dma_status		transfer_status;
>  	struct completion	transfer_complete;
>  	bool			dma_supported;
>  	bool			dma_private;
> @@ -85,8 +88,14 @@ static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
>  static void pci_epf_test_dma_callback(void *param)
>  {
>  	struct pci_epf_test *epf_test = param;
> -
> -	complete(&epf_test->transfer_complete);
> +	struct dma_tx_state state;
> +
> +	epf_test->transfer_status =
> +		dmaengine_tx_status(epf_test->transfer_chan,
> +				    epf_test->transfer_cookie, &state);
> +	if (epf_test->transfer_status == DMA_COMPLETE ||
> +	    epf_test->transfer_status == DMA_ERROR)
> +		complete(&epf_test->transfer_complete);
>  }
>  
>  /**
> @@ -120,7 +129,6 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>  	struct dma_async_tx_descriptor *tx;
>  	struct dma_slave_config sconf = {};
>  	struct device *dev = &epf->dev;
> -	dma_cookie_t cookie;
>  	int ret;
>  
>  	if (IS_ERR_OR_NULL(chan)) {
> @@ -152,25 +160,33 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>  	}
>  
>  	reinit_completion(&epf_test->transfer_complete);
> +	epf_test->transfer_chan = chan;
>  	tx->callback = pci_epf_test_dma_callback;
>  	tx->callback_param = epf_test;
> -	cookie = tx->tx_submit(tx);
> +	epf_test->transfer_cookie = tx->tx_submit(tx);
>  
> -	ret = dma_submit_error(cookie);
> +	ret = dma_submit_error(epf_test->transfer_cookie);
>  	if (ret) {
> -		dev_err(dev, "Failed to do DMA tx_submit %d\n", cookie);
> -		return -EIO;
> +		dev_err(dev, "Failed to do DMA tx_submit %d\n", ret);
> +		goto terminate;
>  	}
>  
>  	dma_async_issue_pending(chan);
>  	ret = wait_for_completion_interruptible(&epf_test->transfer_complete);
>  	if (ret < 0) {
> -		dmaengine_terminate_sync(chan);
> -		dev_err(dev, "DMA wait_for_completion_timeout\n");
> -		return -ETIMEDOUT;
> +		dev_err(dev, "DMA wait_for_completion interrupted\n");
> +		goto terminate;
>  	}
>  
> -	return 0;
> +	if (epf_test->transfer_status == DMA_ERROR) {
> +		dev_err(dev, "DMA transfer failed\n");
> +		ret = -EIO;
> +	}
> +
> +terminate:
> +	dmaengine_terminate_sync(chan);
> +
> +	return ret;
>  }
>  
>  struct epf_dma_filter {
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
