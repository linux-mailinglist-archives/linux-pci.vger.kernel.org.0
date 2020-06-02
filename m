Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3156F1EBE9D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 17:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgFBPB0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 11:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgFBPB0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jun 2020 11:01:26 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A219F207ED;
        Tue,  2 Jun 2020 15:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591110085;
        bh=55TlJm9Dr3QsjqeRufkN1VtYyL+ASBusa+Aug2olZ8Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rUsaTarULhnkYan/YyPORqmGFHQhd7zRQkwQV7hk8tPiz4xkcbJkb9vqcp5xXJuUL
         KtjTRj9PspTYXnI1eyKzZEBVAFYfG5lXWQF+DnL57YkEuFLAz3dhW3P6IXEM/h6Ao7
         +uAmvSrP0xzBhVK3FKOA+ES2wJDjMBBQ6N/iPQz0=
Received: by mail-ot1-f44.google.com with SMTP id k15so7696141otp.8;
        Tue, 02 Jun 2020 08:01:25 -0700 (PDT)
X-Gm-Message-State: AOAM531mPB/MKnfxXVZCN1+h1EtaBOXPJMBKbNPvJai37xXf6Oqo+80Y
        2R/LOolN5kHGGcdkdIzySeYHmaa4CehB4hssXA==
X-Google-Smtp-Source: ABdhPJxkDUpYWOW+NltjZLrMP/I4OmK39ZJv7zRGcJpVG9LyYVjU5E/lqS8dyOmVjR+i30US65E8WB4RmuDvEjsB+7c=
X-Received: by 2002:a05:6830:549:: with SMTP id l9mr12706002otb.129.1591110084909;
 Tue, 02 Jun 2020 08:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200526150954.4729-1-zhengdejin5@gmail.com> <1d7703d5c29dc9371ace3645377d0ddd9c89be30.camel@amazon.com>
 <20200527132005.GA7143@nuc8i5> <1b54c08f759c101a8db162f4f62c6b6a8a455d3f.camel@amazon.com>
In-Reply-To: <1b54c08f759c101a8db162f4f62c6b6a8a455d3f.camel@amazon.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 2 Jun 2020 09:01:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJWKfShzb6r=pXFv03T4L+nmNrCHvt+NkEy5EFuuD1HAA@mail.gmail.com>
Message-ID: <CAL_JsqJWKfShzb6r=pXFv03T4L+nmNrCHvt+NkEy5EFuuD1HAA@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: controller: Remove duplicate error message
To:     "Chocron, Jonathan" <jonnyc@amazon.com>
Cc:     "zhengdejin5@gmail.com" <zhengdejin5@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "tjoseph@cadence.com" <tjoseph@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 2, 2020 at 1:44 AM Chocron, Jonathan <jonnyc@amazon.com> wrote:
>
> On Wed, 2020-05-27 at 21:20 +0800, Dejin Zheng wrote:
> > CAUTION: This email originated from outside of the organization. Do
> > not click links or open attachments unless you can confirm the sender
> > and know the content is safe.
> >
> >
> >
> > On Tue, May 26, 2020 at 06:22:56PM +0000, Chocron, Jonathan wrote:
> > > On Tue, 2020-05-26 at 23:09 +0800, Dejin Zheng wrote:
> > > > CAUTION: This email originated from outside of the organization.
> > > > Do
> > > > not click links or open attachments unless you can confirm the
> > > > sender
> > > > and know the content is safe.
> > > >
> > > >
> > > >
> > > > It will print an error message by itself when
> > > > devm_pci_remap_cfg_resource() goes wrong. so remove the duplicate
> > > > error message.
> > > >
> > >
> > > It seems like that in the first error case in
> > > devm_pci_remap_cfg_resource(), the print will be less indicative.
> > > Could
> > > you please share an example print log with the duplicate print?
> > >
> >
> > Hi Jonathan:
> >
> > Thank you very much for using your precious time to review my patch.
> >
> Sure, no problem.
>
> > I did not have this log and just found it by review codes. the
> > function
> > of devm_pci_remap_cfg_resource() is designed to handle error messages
> > by
> > itself. and Its recommended usage is as follows in the function
> > description
> >
> >         base = devm_pci_remap_cfg_resource(&pdev->dev, res);
> >         if (IS_ERR(base))
> >                 return PTR_ERR(base);
> >
> I assume that the recommended usage's main intent was to point out that
> IS_ERR() should be used, but this is mainly speculation.

It's generally preferred to print error messages in a called function
rather than in return error handling.

> > In fact, I think its error handling is clear enough, It just goes
> > wrong
> > in three places, as follows:
> >
> > void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
> >                                           struct resource *res)
> > {
> >         resource_size_t size;
> >         const char *name;
> >         void __iomem *dest_ptr;
> >
> >         BUG_ON(!dev);
> >
> >         if (!res || resource_type(res) != IORESOURCE_MEM) {
> >                 dev_err(dev, "invalid resource\n");
> >                 return IOMEM_ERR_PTR(-EINVAL);
> >         }
> >
> In the above error case there is no indication of which resource failed
> (mainly relevant if the resource name is missing in the devicetree,
> since in the drivers you are changing platform_get_resource_byname() is
> mostly used). In the existing drivers' code, on return from this
> function in this case, the name would be printed by the caller.

A driver should only have one call to devm_pci_remap_cfg_resource() as
there's only 1 config space. However, it looks like this function is
frequently used on what is not config space which is a bigger issue.

If this error happens, it's almost always going to be a NULL ptr as
platform_get_resource_byname() would have set IORESOURCE_MEM. Perhaps
a WARN here so you get a backtrace to the caller location.

> >         size = resource_size(res);
> >         name = res->name ?: dev_name(dev);
> >
> >         if (!devm_request_mem_region(dev, res->start, size, name)) {
> >                 dev_err(dev, "can't request region for resource
> > %pR\n", res);
> >                 return IOMEM_ERR_PTR(-EBUSY);
> >         }
> >
> >         dest_ptr = devm_pci_remap_cfgspace(dev, res->start, size);
> >         if (!dest_ptr) {
> >                 dev_err(dev, "ioremap failed for resource %pR\n",
> > res);
> >                 devm_release_mem_region(dev, res->start, size);
> >                 dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
> >         }
> >
> The other 2 error cases as well don't print the resource name as far as
> I recall (they will at least print the resource start/end).

Start/end are what are important for why either of these functions failed.

But sure, we could add 'name' here. That's a separate patch IMO.

Rob
