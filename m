Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18175570CFF
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 23:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiGKVv6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 17:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiGKVv5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 17:51:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1401B357F7;
        Mon, 11 Jul 2022 14:51:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADE6060F21;
        Mon, 11 Jul 2022 21:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BFBC34115;
        Mon, 11 Jul 2022 21:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657576315;
        bh=Upwhgkcc7yl3xKyU2Wru0TovC57odUplM8mjq7SZp3s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BnpP72SYfDFZFhwN8B6BXB1L0ZSg7gruvjQpzCf15t4JyLiBhAzbPZ4kBoHkL5AiU
         sqJQBAd1AinBeac9DsGmvd9LJmsC9xrrN6OslDBBdCbXwbah0Ns7l0kxaFH6cmiFeK
         KWTiqkGdASYtd0B5Zh29VhjcPtLkqXKY7vCUkPYxoYY4yMaSHdI2BnsXpgURo6MbDp
         vVTYtdyePRCyiuxJsftXpKMD29XNEui7a6IDs9dWAa/a5fMzdTZ0dHawJ1So9OkygA
         f8prWm3V1fRG1ADNti3rHQKWKq0zG1Zp7W8XWaUwRzT94Ah/gP9WslXFSiASSnqwlO
         on3mziOcG45LA==
Date:   Mon, 11 Jul 2022 16:51:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Peng Wu <wupeng58@huawei.com>
Cc:     kishon@ti.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, liwei391@huawei.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Shunsuke Mie <mie@igel.co.jp>
Subject: Re: [PATCH] PCI: endpoint: Fix a NULL vs IS_ERR() check in
 pci_epf_test_init_dma_chan()
Message-ID: <20220711215153.GA691840@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707131215.65075-1-wupeng58@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Dan, Shunsuke]

On Thu, Jul 07, 2022 at 01:12:15PM +0000, Peng Wu wrote:
> On failure, dma_request_channel() returns NULL and not a
> ERR_PTR() value. Fix return value checking by using is NULL.
> 
> Signed-off-by: Peng Wu <wupeng58@huawei.com>

Thanks for the patch.  Dan posted the same thing later [1].

I'd be happy to do this, but Shunsuke suggested that the rx path
should be changed similarly, so I'll look for a patch that does both.

[1] https://lore.kernel.org/r/YsftwaVowtU9/pgn@kili
[2] https://lore.kernel.org/r/CANXvt5rK98-cEMgpzopY9POOK8a5=VDib8uKPLgJakOG=hRfwQ@mail.gmail.com

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 34aac220dd4c..eed6638ab71d 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
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
> 2.17.1
> 
