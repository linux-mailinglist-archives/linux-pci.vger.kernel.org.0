Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FB06BB6E4
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 16:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjCOPEJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 11:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjCOPD4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 11:03:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7334C17
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 08:03:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FAAD61DA5
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 15:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0ADCC433D2;
        Wed, 15 Mar 2023 15:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678892613;
        bh=2MSOwxrzc7Xz4R3htcDaL2ylScq76w7nT7BNEXIrJ0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e1bBi14ESD/Jz8Ad4vJvfGuGNPbdQZPIFEhjF2tGHmCuMU4Nooc5D34bnbg9mI9fu
         X3Gix9ocOnXt1Fty8u1A30iDVKTzQBoGe7dFfgLIJ7ovvi6CcMqhZdiky4w/y6AcNu
         kj2Rk7fM0yrG9mHWLICTypZsoZcp/FsCOynJo6HNT94ZCvqRJaZQnYywNCzc9m3wSA
         +pSU0f5MCig8yY7MY9IZmFjID6kI0ordwFLxPhtUnrasbTcFfIjyvczDubF/NK65LA
         7kWqDLaAxA6fj+mKiMBu6uB+C7TrWSG1HABqXPaU2ufSJ110ZsVmHu29RfsZya6ef7
         Y1YnfuR5t8D1Q==
Date:   Wed, 15 Mar 2023 20:33:19 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 03/16] PCI: epf-test: Fix DMA transfer completion
 initialization
Message-ID: <20230315150319.GE98488@thinkpad>
References: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
 <20230308090313.1653-4-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308090313.1653-4-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 08, 2023 at 06:03:00PM +0900, Damien Le Moal wrote:
> Re-initialize the transfer_complete DMA transfer completion before
> calling tx_submit(), to avoid seeing the DMA transfer complete before
> the completion is initialized, thus potentially losing the completion
> notification.
> 
> Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")

Please also CC stable list for backporting

> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 0f9d2ec822ac..d65419735d2e 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -151,10 +151,10 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>  		return -EIO;
>  	}
>  
> +	reinit_completion(&epf_test->transfer_complete);
>  	tx->callback = pci_epf_test_dma_callback;
>  	tx->callback_param = epf_test;
>  	cookie = tx->tx_submit(tx);
> -	reinit_completion(&epf_test->transfer_complete);
>  
>  	ret = dma_submit_error(cookie);
>  	if (ret) {
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
