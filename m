Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AC53FEA96
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 10:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbhIBI0Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Sep 2021 04:26:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243655AbhIBI0P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Sep 2021 04:26:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8C1160F12;
        Thu,  2 Sep 2021 08:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630571116;
        bh=9+mDHSUkvjKf2yVlziOhRgyE+SsrmCW+FsNFa0wT210=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mtAfN/rZVxLB195SfCr0mJEsGPxO/RhjVLRAOiVWNIPdePHyRVfkJBiFRkjsLuStN
         R63+iBm6Hlzf+YxVHQWGduCyQLEFO/IMCpxRkEqJTYRZO8g3AugHUJQHD6CV8nBrka
         DjVynLq5zXwywLFFE6QDqSuwEPcmdsTxwcbYIfXc=
Date:   Thu, 2 Sep 2021 10:25:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     rafael@kernel.org, patrice.chotard@foss.st.com, mchehab@kernel.org,
        ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/3] driver core: platform: Add the helper function
 devm_platform_get_and_ioremap_resource_byname()
Message-ID: <YTCKaepfkrqb4ahN@kroah.com>
References: <20210902063702.32066-1-caihuoqing@baidu.com>
 <20210902063702.32066-2-caihuoqing@baidu.com>
 <YTB0vegl2YFfaWzM@kroah.com>
 <20210902080539.GA32174@LAPTOP-UKSR4ENP.internal.baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902080539.GA32174@LAPTOP-UKSR4ENP.internal.baidu.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 02, 2021 at 04:05:39PM +0800, Cai Huoqing wrote:
> On 02 Sep 21 08:52:45, Greg KH wrote:
> > On Thu, Sep 02, 2021 at 02:37:00PM +0800, Cai Huoqing wrote:
> > > Since provide the helper function devm_platform_ioremap_resource_byname()
> > > which is wrap platform_get_resource_byname() and devm_ioremap_resource().
> > > But sometimes, many drivers still need to use the resource variables
> > > obtained by platform_get_resource(). In these cases, provide this helper
> > > function devm_platform_get_and_ioremap_resource_byname().
> > > 
> > > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> > > ---
> > > v1->v2: Resend this patch as part of a patch series that uses
> > > 	the new function. 
> > > 
> > >  drivers/base/platform.c         | 30 ++++++++++++++++++++++++++----
> > >  include/linux/platform_device.h |  3 +++
> > >  2 files changed, 29 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > > index 652531f67135..34bb581338d9 100644
> > > --- a/drivers/base/platform.c
> > > +++ b/drivers/base/platform.c
> > > @@ -124,6 +124,31 @@ void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
> > >  }
> > >  EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
> > >  
> > > +/**
> > > + * devm_platform_get_and_ioremap_resource_byname - call devm_ioremap_resource() for a
> > > + *						   platform device and get resource
> > > + *
> > > + * @pdev: platform device to use both for memory resource lookup as well as
> > > + *        resource management
> > > + * @name: name of the resource
> > > + * @res: optional output parameter to store a pointer to the obtained resource.
> > > + *
> > > + * Return: a pointer to the remapped memory or an ERR_PTR() encoded error code
> > > + * on failure.
> > > + */
> > > +void __iomem *
> > > +devm_platform_get_and_ioremap_resource_byname(struct platform_device *pdev,
> > > +					      const char *name, struct resource **res)
> > > +{
> > > +	struct resource *r;
> > > +
> > > +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
> > > +	if (res)
> > > +		*res = r;
> > 
> > You forgot to check the return value of this call :(
> devm_ioremap_resource wiil check it and print error message, here:
> ./lib/devres.c:136:__devm_ioremap_resource(
> 
> 	if (!res || resource_type(res) != IORESOURCE_MEM) {
> 		dev_err(dev, "invalid resource\n");
> 		return IOMEM_ERR_PTR(-EINVAL);

And then you move on and use the resource :(

Please properly test your code.

> > Which means you did not test this?  Why not?
> > 
> > But step back, _WHY_ is this needed at all?  How deep are we going to
> > get with the "devm_platform_get_and_do_this_and_that_and_that" type
> > functions here?
>   the function name seems too long, how can I rename it:)

You have not shown a requirement that this new function is needed at
all.

Why are you making this change?  Why do you want to do this?  What is it
helping out with?

thanks,

greg k-h
