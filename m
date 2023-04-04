Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00716D5C4F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 11:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjDDJr0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 05:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbjDDJrZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 05:47:25 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4261BC0
        for <linux-pci@vger.kernel.org>; Tue,  4 Apr 2023 02:47:23 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id o2so30759679plg.4
        for <linux-pci@vger.kernel.org>; Tue, 04 Apr 2023 02:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1680601642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LD+Pbh+Dgje2hph4qd/zBGoIsHysnXkNvEoD/PBs05g=;
        b=tJ+tf/k8rs5jkZTkqU8Qm39ujUfEOSFy83Qlzqj1RolcGzwNNjQNiX2/gNvgD7OFlE
         Aj2xvHquVkFZ5egZZ9UjvrOcLq9NOT08vsSaOJ5fstTTD6WaAHLPLYFp6wPFKpJxi0ak
         9KWjDrE9kZdSh0IxIAWBbiAVaFcvIkvIT124thg4wPzOp5qMYPtYp2HVeKw0NBZDBIZG
         elsDH9lj9qLpy8j9YIbewgPfhZLBY6epzAQXYLbhRQWOmz2TRenFoQQSqs/3EnrHnPMb
         yKa45ucmnS0Ps4jr1O9G3olURITBPqOUVmWCD61XwEI62rIcEWNVIftIxFqONHVr124e
         LCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680601642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LD+Pbh+Dgje2hph4qd/zBGoIsHysnXkNvEoD/PBs05g=;
        b=4HMT1go1y/y5malPoFg6WuSMSAy+wcT9rBKOEjaF3luCG01uwpK04u/MTb8WPqqWsb
         M/7jjzPxgXtYQP7MCLQDY1EzBH02EPVQNkTG0WEENpdy9o0PQv/FaAfoCby89CHZNIi0
         VJyTKGDjF8hQj3q6Qtdnn1OphPhwfCfIsYlmd1DWoJpku/YK5OWe8F+cjeKeV90jOi4B
         K8261DHy/pJW6hp7wiOoBCfIiU9Nl556EBgXRaW8osFoJJnvikVt+VQCix4h2nqaO898
         ln4H1DCT5nvj+uf7dIGUBB16Sy9FYbnGfuk0wYxaBo8ARO7H5k63MBdIzweiRmuGmJ0h
         YAnQ==
X-Gm-Message-State: AAQBX9c2Cm5U7x51MMOwVsEqmjIuRLkRmc5x7tZQ4ZOaGQAbro4FjXrC
        i57wRXPD7EPD1SRDLMDa3dwrNm9o0gDVDW1vQ7g=
X-Google-Smtp-Source: AKy350YfpCOKgHLTtKerPwp1BkMoaUCq06nXSId07lQ3Oo2YMB4EP3SyznKhTnKnt2xUTtefuPtfrw==
X-Received: by 2002:a17:902:f311:b0:1a2:19c1:a974 with SMTP id c17-20020a170902f31100b001a219c1a974mr1429296ple.68.1680601642630;
        Tue, 04 Apr 2023 02:47:22 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id 125-20020a630383000000b0050927cb606asm7270401pgd.13.2023.04.04.02.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 02:47:22 -0700 (PDT)
Message-ID: <9a70d819-70d1-fb69-b053-a37ccfacf145@igel.co.jp>
Date:   Tue, 4 Apr 2023 18:47:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v4 04/17] PCI: epf-test: Fix DMA transfer completion
 detection
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230330085357.2653599-1-damien.lemoal@opensource.wdc.com>
 <20230330085357.2653599-5-damien.lemoal@opensource.wdc.com>
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <20230330085357.2653599-5-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2023/03/30 17:53, Damien Le Moal wrote:
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
> ---
>   drivers/pci/endpoint/functions/pci-epf-test.c | 38 +++++++++++++------
>   1 file changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index d65419735d2e..dbea6eb0dee7 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -54,6 +54,9 @@ struct pci_epf_test {
>   	struct delayed_work	cmd_handler;
>   	struct dma_chan		*dma_chan_tx;
>   	struct dma_chan		*dma_chan_rx;
> +	struct dma_chan		*transfer_chan;
> +	dma_cookie_t		transfer_cookie;
> +	enum dma_status		transfer_status;
>   	struct completion	transfer_complete;
>   	bool			dma_supported;
>   	bool			dma_private;
> @@ -85,8 +88,14 @@ static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
>   static void pci_epf_test_dma_callback(void *param)
>   {
>   	struct pci_epf_test *epf_test = param;
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
>   }
>   
>   /**
> @@ -120,7 +129,6 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>   	struct dma_async_tx_descriptor *tx;
>   	struct dma_slave_config sconf = {};
>   	struct device *dev = &epf->dev;
> -	dma_cookie_t cookie;
>   	int ret;
>   
>   	if (IS_ERR_OR_NULL(chan)) {
> @@ -152,25 +160,33 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>   	}
>   
>   	reinit_completion(&epf_test->transfer_complete);
> +	epf_test->transfer_chan = chan;
>   	tx->callback = pci_epf_test_dma_callback;
>   	tx->callback_param = epf_test;
> -	cookie = tx->tx_submit(tx);
> +	epf_test->transfer_cookie = tx->tx_submit(tx);

How about changing the code to use dmaengine_submit() API instead of 
calling a raw function pointer?

>   
> -	ret = dma_submit_error(cookie);
> +	ret = dma_submit_error(epf_test->transfer_cookie);
>   	if (ret) {
> -		dev_err(dev, "Failed to do DMA tx_submit %d\n", cookie);
> -		return -EIO;
> +		dev_err(dev, "Failed to do DMA tx_submit %d\n", ret);
> +		goto terminate;
>   	}
>   
>   	dma_async_issue_pending(chan);
>   	ret = wait_for_completion_interruptible(&epf_test->transfer_complete);
>   	if (ret < 0) {
> -		dmaengine_terminate_sync(chan);
> -		dev_err(dev, "DMA wait_for_completion_timeout\n");
> -		return -ETIMEDOUT;
> +		dev_err(dev, "DMA wait_for_completion interrupted\n");
> +		goto terminate;
>   	}
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
>   }
>   
>   struct epf_dma_filter {

Best,

Shunsuke.

