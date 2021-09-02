Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555AD3FEA64
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 10:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244229AbhIBIHt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Sep 2021 04:07:49 -0400
Received: from mx21.baidu.com ([220.181.3.85]:38364 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244111AbhIBIHA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Sep 2021 04:07:00 -0400
Received: from Bc-Mail-Ex13.internal.baidu.com (unknown [172.31.51.53])
        by Forcepoint Email with ESMTPS id EDEAF2A36F94547B3CD7;
        Thu,  2 Sep 2021 16:05:40 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 Bc-Mail-Ex13.internal.baidu.com (172.31.51.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 2 Sep 2021 16:05:40 +0800
Received: from localhost (172.31.63.8) by BJHW-MAIL-EX27.internal.baidu.com
 (10.127.64.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 2
 Sep 2021 16:05:40 +0800
Date:   Thu, 2 Sep 2021 16:05:39 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <rafael@kernel.org>, <patrice.chotard@foss.st.com>,
        <mchehab@kernel.org>, <ryder.lee@mediatek.com>,
        <jianjun.wang@mediatek.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <matthias.bgg@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] driver core: platform: Add the helper function
 devm_platform_get_and_ioremap_resource_byname()
Message-ID: <20210902080539.GA32174@LAPTOP-UKSR4ENP.internal.baidu.com>
References: <20210902063702.32066-1-caihuoqing@baidu.com>
 <20210902063702.32066-2-caihuoqing@baidu.com>
 <YTB0vegl2YFfaWzM@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YTB0vegl2YFfaWzM@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex27.internal.baidu.com (172.31.51.21) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02 Sep 21 08:52:45, Greg KH wrote:
> On Thu, Sep 02, 2021 at 02:37:00PM +0800, Cai Huoqing wrote:
> > Since provide the helper function devm_platform_ioremap_resource_byname()
> > which is wrap platform_get_resource_byname() and devm_ioremap_resource().
> > But sometimes, many drivers still need to use the resource variables
> > obtained by platform_get_resource(). In these cases, provide this helper
> > function devm_platform_get_and_ioremap_resource_byname().
> > 
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> > ---
> > v1->v2: Resend this patch as part of a patch series that uses
> > 	the new function. 
> > 
> >  drivers/base/platform.c         | 30 ++++++++++++++++++++++++++----
> >  include/linux/platform_device.h |  3 +++
> >  2 files changed, 29 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 652531f67135..34bb581338d9 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -124,6 +124,31 @@ void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
> >  }
> >  EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
> >  
> > +/**
> > + * devm_platform_get_and_ioremap_resource_byname - call devm_ioremap_resource() for a
> > + *						   platform device and get resource
> > + *
> > + * @pdev: platform device to use both for memory resource lookup as well as
> > + *        resource management
> > + * @name: name of the resource
> > + * @res: optional output parameter to store a pointer to the obtained resource.
> > + *
> > + * Return: a pointer to the remapped memory or an ERR_PTR() encoded error code
> > + * on failure.
> > + */
> > +void __iomem *
> > +devm_platform_get_and_ioremap_resource_byname(struct platform_device *pdev,
> > +					      const char *name, struct resource **res)
> > +{
> > +	struct resource *r;
> > +
> > +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
> > +	if (res)
> > +		*res = r;
> 
> You forgot to check the return value of this call :(
devm_ioremap_resource wiil check it and print error message, here:
./lib/devres.c:136:__devm_ioremap_resource(

	if (!res || resource_type(res) != IORESOURCE_MEM) {
		dev_err(dev, "invalid resource\n");
		return IOMEM_ERR_PTR(-EINVAL);
> 
> Which means you did not test this?  Why not?
> 
> But step back, _WHY_ is this needed at all?  How deep are we going to
> get with the "devm_platform_get_and_do_this_and_that_and_that" type
> functions here?
  the function name seems too long, how can I rename it:)
> 
> You show 2 users of this call, and they save what, 1-2 lines of code
> here?
> 
> What is the real need for this?
> 
> thanks,
> 
> greg k-h
many thanks for your feedback.

Cai
