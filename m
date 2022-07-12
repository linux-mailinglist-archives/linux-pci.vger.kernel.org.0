Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EBE571EE1
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 17:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbiGLPVs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jul 2022 11:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiGLPVW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2022 11:21:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3159A14025;
        Tue, 12 Jul 2022 08:18:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC0B3B819D1;
        Tue, 12 Jul 2022 15:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33190C3411C;
        Tue, 12 Jul 2022 15:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657639129;
        bh=SQi3anDx9ImSp0D1yOJfqnUIR/zJGBkVtJpq68FoFhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U/h1ew29u9NtkfB80rucIkfFo/GIuuYudh5bE66AyjeA2t3WhyGQO3c+y3eqkD66g
         l2iHPYulITFhQUtGRqySg0IPC+KopRZBXFeOzIUvyOP6P8DHO6olAraT0efGQWqNDa
         zfVCeb8v2uZvYE9mqGAclQiS13kzOVFG1JGD5YI+WUqHkyXMo2XyvCcXKtSeuE6PWo
         uC0IWcjNCXnYAxC4A7lXh8vY6V7ZDIyJJHPO/JTMQQgME94rRT9/QvLtKAE+mHXlWc
         e+PDoYYrdunsCD4J9es1gHu+mDeIlAqoJ7sh0kf2BVSWOMfj1Wa5iVv7hNmTLuqcU1
         9YcIjOcMN+mWw==
Date:   Tue, 12 Jul 2022 10:18:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Shunsuke Mie <mie@igel.co.jp>, Li Chen <lchen@ambarella.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: IS_ERR() vs NULL bug in
 pci_epf_test_init_dma_chan()
Message-ID: <20220712151847.GA767932@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys2GSTnZhuLzzQG5@kili>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 12, 2022 at 05:33:45PM +0300, Dan Carpenter wrote:
> The dma_request_channel() function doesn't return error pointers, it
> returns NULL.
> 
> Fixes: fff86dfbbf82 ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, I squashed this into fff86dfbbf82 on my pci/ctrl/dwc-edma
branch.  I added a mention of Shunsuke's previous post of a similar
fix, but merged this one because it fixes both the RX and TX paths.

> ---
> v2: Clean up the first IS_ERR_OR_NULL() check as well
> 
>  drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 34aac220dd4c..36b1801a061b 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -211,7 +211,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
>  	dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
> -	if (IS_ERR_OR_NULL(dma_chan)) {
> +	if (!dma_chan) {
>  		dev_info(dev, "Failed to get private DMA rx channel. Falling back to generic one\n");
>  		goto fail_back_tx;
>  	}
> @@ -221,7 +221,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
>  	filter.dma_mask = BIT(DMA_MEM_TO_DEV);
>  	dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
>  
> -	if (IS_ERR(dma_chan)) {
> +	if (!dma_chan) {
>  		dev_info(dev, "Failed to get private DMA tx channel. Falling back to generic one\n");
>  		goto fail_back_rx;
>  	}
> -- 
> 2.35.1
> 
