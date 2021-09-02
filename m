Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B5F3FE989
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 08:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242358AbhIBGxw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Sep 2021 02:53:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233363AbhIBGxv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Sep 2021 02:53:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9F3F60C3E;
        Thu,  2 Sep 2021 06:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630565573;
        bh=Tv65ZWVxn/+fMQglBkEG2bViohQl6I7pMD5PRiDb/OY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zkCACKOHW+/1wPgjnLO9CWoKRkNWPwCBuFETWGmgqgHMfYAokbL91qIXIRaeMLZX6
         QHK7uMeRtgBzHAe1Mha1kFZ9Dr8aV2+aPFvT5+fax8HqXBuClP644379CI4V9H4WmQ
         nY2AnuWhX1xuIsKoBemem4jhbTuFu8wiLukApgr0=
Date:   Thu, 2 Sep 2021 08:52:45 +0200
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
Message-ID: <YTB0vegl2YFfaWzM@kroah.com>
References: <20210902063702.32066-1-caihuoqing@baidu.com>
 <20210902063702.32066-2-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902063702.32066-2-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 02, 2021 at 02:37:00PM +0800, Cai Huoqing wrote:
> Since provide the helper function devm_platform_ioremap_resource_byname()
> which is wrap platform_get_resource_byname() and devm_ioremap_resource().
> But sometimes, many drivers still need to use the resource variables
> obtained by platform_get_resource(). In these cases, provide this helper
> function devm_platform_get_and_ioremap_resource_byname().
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
> v1->v2: Resend this patch as part of a patch series that uses
> 	the new function. 
> 
>  drivers/base/platform.c         | 30 ++++++++++++++++++++++++++----
>  include/linux/platform_device.h |  3 +++
>  2 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 652531f67135..34bb581338d9 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -124,6 +124,31 @@ void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
>  }
>  EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
>  
> +/**
> + * devm_platform_get_and_ioremap_resource_byname - call devm_ioremap_resource() for a
> + *						   platform device and get resource
> + *
> + * @pdev: platform device to use both for memory resource lookup as well as
> + *        resource management
> + * @name: name of the resource
> + * @res: optional output parameter to store a pointer to the obtained resource.
> + *
> + * Return: a pointer to the remapped memory or an ERR_PTR() encoded error code
> + * on failure.
> + */
> +void __iomem *
> +devm_platform_get_and_ioremap_resource_byname(struct platform_device *pdev,
> +					      const char *name, struct resource **res)
> +{
> +	struct resource *r;
> +
> +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
> +	if (res)
> +		*res = r;

You forgot to check the return value of this call :(

Which means you did not test this?  Why not?

But step back, _WHY_ is this needed at all?  How deep are we going to
get with the "devm_platform_get_and_do_this_and_that_and_that" type
functions here?

You show 2 users of this call, and they save what, 1-2 lines of code
here?

What is the real need for this?

thanks,

greg k-h
