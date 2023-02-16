Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6E86990F1
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 11:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjBPKS0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 05:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjBPKSZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 05:18:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3721DD4
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 02:18:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6D93BCE2A1D
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 10:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E432AC433D2;
        Thu, 16 Feb 2023 10:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676542700;
        bh=jJsBJFVetVNkM6/VLL0/ONPYAbrD03h/fttW3zkE6GI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e6oDX/JqnHIBLTKpQmaq6uTru74Qt+wGy+JkTH91ro6eay83DsrZt7pvLPR/VMmbS
         dnXpUBYu+C3BOwf/7yFP0TVp1N6bKe70zXNOpYKutGW3/ZPIqnTWsPLpGpsWYYqcN+
         WLkhNy63wpi9HxRqpU1bdK5lllaq9qJjXUw+7HHMIPcmaPYLpNC+R+4+ugJ0FHAkDl
         EKEEGWx27V0Jbvf5ScrC0yF4dBR0rephskjePw9JwUubXzN2UHA4+6DhKZD1w8W+aO
         l2reSskJCh+erg31kbAa1ttgsTZZTQ5AuaL0xA7unc0ir3mdeX1pKpqGIYU0bkrKHz
         3zxM6PmmnF/Qg==
Date:   Thu, 16 Feb 2023 15:48:06 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 03/12] pci: epf-test: Fix DMA transfer completion
 detection
Message-ID: <20230216101806.GE2420@thinkpad>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
 <20230215032155.74993-4-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230215032155.74993-4-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 12:21:46PM +0900, Damien Le Moal wrote:
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
> While at it, also modify the channel tx submit call to use
> dmaengine_submit() instead of the hard coded call to the tx_submit()
> operation.
> 

This patch is doing 3 different things. So you need to split them into separate
patches.

Thanks,
Mani

> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 42 +++++++++++++------
>  1 file changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 55283d2379a6..030769893efb 100644
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
> @@ -151,26 +159,36 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>  		return -EIO;
>  	}
>  
> +	reinit_completion(&epf_test->transfer_complete);
> +	epf_test->transfer_chan = chan;
>  	tx->callback = pci_epf_test_dma_callback;
>  	tx->callback_param = epf_test;
> -	cookie = tx->tx_submit(tx);
> -	reinit_completion(&epf_test->transfer_complete);
> +	epf_test->transfer_cookie = dmaengine_submit(tx);
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
> +	WARN_ON(epf_test->transfer_status != DMA_COMPLETE);
> +
> +terminate:
> +	dmaengine_terminate_sync(chan);
> +
> +	return ret;
>  }
>  
>  struct epf_dma_filter {
> -- 
> 2.39.1
> 

-- 
மணிவண்ணன் சதாசிவம்
