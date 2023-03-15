Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1DD6BB785
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 16:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjCOPWF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 11:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjCOPWB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 11:22:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7BA76054
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 08:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C2A91CE1A96
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 15:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9F8C433EF;
        Wed, 15 Mar 2023 15:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678893712;
        bh=f0PW7rnFF1Q43VjEwHvnbu1JDIrWrg2RfhrVxR0fMtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PnVGyXt+SH+6PnYQYNDlW2BD8phEyvVBpxFmKogpk8cih5Nf3QupfoPvmMYhxSBcy
         RXnw7buAH65aAjkE839R/6wM3iMje2NCLGttEUrnogCnXM1okEKNOHF/deveJ+zT1Y
         sFKyml2/3vq9vsUmop5cYBKHWx/bGpAS3/9Hqb7pFdQNUx8yJZcUDG7JDkvUgoKfX5
         c+AwUFid+WvGPg0YPlffsxxPc8tEFAslvKWbN8cgZNjn9jdomavMDb6O3Nt5AW2sTC
         IupFlFxL1LgfJVtOZ3IdXg5N0Vys5tBD0pyNEKuifMaFnPCPj+C0BHz3qBtIpB6dPK
         moJ5Jby13ZdCw==
Date:   Wed, 15 Mar 2023 20:51:38 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 05/16] PCI: epf-test: Use dmaengine_submit() to
 initiate DMA transfer
Message-ID: <20230315152138.GG98488@thinkpad>
References: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
 <20230308090313.1653-6-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308090313.1653-6-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 08, 2023 at 06:03:02PM +0900, Damien Le Moal wrote:
> Instead of an open coded call to the tx_submit() operation of struct
> dma_async_tx_descriptor, use the helper function dmaengine_submit().
> No functional change is introduced with this.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 557fbb91c729..3dce9827bd2a 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -163,7 +163,7 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>  	epf_test->transfer_chan = chan;
>  	tx->callback = pci_epf_test_dma_callback;
>  	tx->callback_param = epf_test;
> -	epf_test->transfer_cookie = tx->tx_submit(tx);
> +	epf_test->transfer_cookie = dmaengine_submit(tx);
>  
>  	ret = dma_submit_error(epf_test->transfer_cookie);
>  	if (ret) {
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
