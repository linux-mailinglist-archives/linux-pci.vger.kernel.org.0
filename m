Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1777D8687
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 18:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjJZQNT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 12:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjJZQNT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 12:13:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A89F1AA;
        Thu, 26 Oct 2023 09:13:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F400DC433C8;
        Thu, 26 Oct 2023 16:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698336797;
        bh=SgDvMPJ39b3G/EkHg60mFb/WIe6493yyXQcBZtYOsR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Uu8jcw4IZuVTE+TQe1BG8hsLlOQmTpLauUJW0YOscrUCL3FNpgWRBd725kC8mqsKc
         LsJQ7zfEuZcx5V6tzjJ2raw3EiEpzRPf8o9tjMZruE6lJXOP1Z35IMKIxU7VNyxvWD
         wPSm4dtiCD8GqC/bT5h3/HxEQRXyR5F2GkEqtoAig4N60Ex9YJZ7HseGriD40N5CK1
         u4WeBLieS7gemda+XkUoqgtGZj70LNPwlQGzchBgdfb+4KetKKrvEr3A5v/z9+i9/v
         rSe0W2XcNBHe1doz3qqBcGsxBpzqnukRP7uUwqZqdJ88daCF7C+uZ8LiNNwcbzK3nV
         q7Wb9vc39/G3Q==
Date:   Thu, 26 Oct 2023 11:13:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Fix double free in __pci_epc_create()
Message-ID: <20231026161314.GA1823497@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Applied with Manivannan's reviewed-by to pci/misc for v6.7, thanks!

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
