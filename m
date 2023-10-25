Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D077D7205
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 19:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjJYRFa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 13:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjJYRFa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 13:05:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F43138;
        Wed, 25 Oct 2023 10:05:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E53C433C7;
        Wed, 25 Oct 2023 17:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698253527;
        bh=itrf3YPLZXA1U9eMPDK77GgHzah33OvhKLvGx9sIU/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZD3KDLlVqQkHNy61Z+yJ3gbkRB8IJ4kgu9FeDqGEg1ILEgs1D8NjaWVnuYexaPIT
         58fSjj1NexuGw+DWXrtx8L7jIKGIqhkXNai+q5A34GJa9wfEs+UFrX1LdzZHXY2t/t
         psTxWQcy59CTA0apshwXuiF8Tbcc19vJ9+eZyWlM/kG/n5yDtGC2i7uUNz4A0ivTOt
         2ORRS4TUafJ+Ljy14s0guA9o5a5qex77WWKOy4tzbibs81wY1g9EXcGWEo037nFpQy
         8qWAY/tQEYlErK6sS+41ByF2+VlcVqLNEWgtsdUQlvv8iuhMrYIdo8kQ2P+b0vsQjG
         znWXcKvMybf9w==
Date:   Wed, 25 Oct 2023 22:35:20 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Fix double free in __pci_epc_create()
Message-ID: <20231025170520.GA96219@thinkpad>
References: <2ce68694-87a7-4c06-b8a4-9870c891b580@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ce68694-87a7-4c06-b8a4-9870c891b580@moroto.mountain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 25, 2023 at 02:57:23PM +0300, Dan Carpenter wrote:
> The pci_epc_release() function frees "epc" so the kfree() on the next
> line is a double free.
> 
> Fixes: 7711cbb4862a ("PCI: endpoint: Fix WARN() when an endpoint driver is removed")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/pci-epc-core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index fe421d46a8a4..56e1184bc6c2 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -869,7 +869,6 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>  
>  put_dev:
>  	put_device(&epc->dev);
> -	kfree(epc);
>  
>  err_ret:
>  	return ERR_PTR(ret);
> -- 
> 2.42.0
> 

-- 
மணிவண்ணன் சதாசிவம்
