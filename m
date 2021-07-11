Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B28A3C3C0A
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jul 2021 13:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhGKL6x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Jul 2021 07:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229688AbhGKL6x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 11 Jul 2021 07:58:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8D5F61090;
        Sun, 11 Jul 2021 11:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626004566;
        bh=WzhpHgoJ55znqI9v2KgCulY11RVSrhkw90oNP0TAaNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rfjwd3SrnEITNEfGHks9pZLMimE7BuMh6egQEIoqoSaepy6W8Ye1fCzaKtYPXOjSQ
         JQMF9CHURnTFGs9BydGrLmr19o/orWyGyk3//Lx9su6Z1nrCjAH6MCxVYBAnFIazRT
         xS/hVXOi4psGZHwjHUUZYV1t9aCUNjTPsa1V8wvY5MYSIU6mm6oaQ2P+oxkehFVNBY
         WhAq/YqIYrUM5LoOLZrAgD0WwwkNOkTK4K7yJ6W5HtYOkAQNZ1vkCfdF494qKFlDvo
         K9CJBDj6IYhCzj/tW2fA2bXGf2Qr8g/y4FD4bisQcsJ2WcsfGw4WZIEEW8Hdl1Dku/
         nfYtc6Kz3GF6A==
Date:   Sun, 11 Jul 2021 14:56:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Shunyong Yang <yang.shunyong@gmail.com>
Cc:     bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        kw@linux.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: PCI: Zero-initialize param
Message-ID: <YOrcUcx2PdaBxRQi@unreal>
References: <20210627003937.6249-1-yang.shunyong@gmail.com>
 <d4c250af-aa50-0ec0-c66a-104092646e15@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4c250af-aa50-0ec0-c66a-104092646e15@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jul 11, 2021 at 09:48:17AM +0800, Shunyong Yang wrote:
> Hi, Bjorn and Kishon,
> 
>   Gentle ping. Would you please help to review and merge this tiny change?
> 
> Thansk.
> 
> Shunyong.
> 
> On 2021/6/27 8:39, Shunyong Yang wrote:
> > The values in param may be random if they are not initialized, which
> > may cause use_dma flag set even when "-d" option is not provided
> > in command line. Initializing all members to 0 to solve this.
> > 
> > Signed-off-by: Shunyong Yang <yang.shunyong@gmail.com>
> > ---
> >   tools/pci/pcitest.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> > index 0a1344c45213..59bcd6220a58 100644
> > --- a/tools/pci/pcitest.c
> > +++ b/tools/pci/pcitest.c
> > @@ -40,7 +40,7 @@ struct pci_test {
> >   static int run_test(struct pci_test *test)
> >   {
> > -	struct pci_endpoint_test_xfer_param param;
> > +	struct pci_endpoint_test_xfer_param param = {0};

You can simply write {} instead of {0} - zero is not needed.

Thanks

> >   	int ret = -EINVAL;
> >   	int fd;
