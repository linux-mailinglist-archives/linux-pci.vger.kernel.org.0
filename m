Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EEC367EF8
	for <lists+linux-pci@lfdr.de>; Thu, 22 Apr 2021 12:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbhDVKrl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Apr 2021 06:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbhDVKrk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Apr 2021 06:47:40 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF35C06174A;
        Thu, 22 Apr 2021 03:47:05 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id j7so23124515pgi.3;
        Thu, 22 Apr 2021 03:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SgUcBHCjSxAN5MicVeLUNyWUqdmAmQ3TqoQadNAUOb8=;
        b=FgTDYA88672I0jBu9n928rLjbAn2NJE8ubG685g3NoubLKWkQU087S14/5DxEB5VZ4
         mc07qLx8d3J7FWZ4EMPfkL0you27mUbOYWrZtJG4zvoXbDDijs0oJ7PreSpk9MWDX37k
         lELRL0PE2jdkh9OxHdTLQlk9eObnoU+p3MHZoAN4BtnK78OPGLzGYjR0e0PPk85zC/HV
         MtW2JmerJFiedC13VPXaCt2m03fENLHA1AOVKhJ7VP77L9+PaTH0rw1RTiLdWo9dudZh
         x8b8DZAffUgh9ZFsEBXEPSTZbg0RRye6KqkdBeS6T+dj6XTQjxXmHYQDCHIULdXaYkcL
         fjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SgUcBHCjSxAN5MicVeLUNyWUqdmAmQ3TqoQadNAUOb8=;
        b=oXKmpv3EnpRlee2Ay6LIEBXZBHmV4v3VAL6A5OlzJUDecH6Qb056LedtLMlurBM32Y
         IdZoTBCoX9jG1nWGV9yDFGBmEuXv+aFtAqm6W2qUOXdgNwIIKuHTNJbzjttTyN0zI/kI
         S17Pv6Wm6tbkcTAEPfM/GQ7jdvOJRjVv58TXBvBRBRJOzcgjnH1Cu8ktx3tu9CYLvXxg
         3/HKT5bxPRl9hTOOyf4i5QPySNTF5zjZ7lM+V/rAkEkCtMusZvhK3UjnIhMZru3SVWON
         BN4TgKRcb72MQC5+O6sCdhSxeICOROkLFREvgj6P1SQVHSHaxICVkpT+bA48HhlobIz9
         5Lug==
X-Gm-Message-State: AOAM53138KAMKUdkwub3XrLvQ9V+N4xVWCcha5BEoft6swzIS/fQtMes
        Fpr7WJvxqEeHxsiyPLB1g1Y=
X-Google-Smtp-Source: ABdhPJzFecMwA9cLSb42Fessy9xyD3NnEOAA6iXItJEJyhusBVqdCu9pnOjopTb6p/R8UyJkyaitAQ==
X-Received: by 2002:a63:e552:: with SMTP id z18mr2930604pgj.100.1619088425034;
        Thu, 22 Apr 2021 03:47:05 -0700 (PDT)
Received: from localhost ([103.248.31.176])
        by smtp.gmail.com with ESMTPSA id h18sm1631375pfv.158.2021.04.22.03.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 03:47:04 -0700 (PDT)
Date:   Thu, 22 Apr 2021 16:17:02 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Check value of resource alignment before using __ffs
Message-ID: <20210422104702.52ydplhvciuztyxv@archlinux>
References: <20210421184747.62391-1-ameynarkhede03@gmail.com>
 <YIEa/5E45SzKzvuf@unreal>
 <20210422094323.i4foiagx3hmzxpj4@archlinux>
 <YIFS720CvbjYTbLQ@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIFS720CvbjYTbLQ@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/04/22 01:41PM, Leon Romanovsky wrote:
> On Thu, Apr 22, 2021 at 03:13:23PM +0530, Amey Narkhede wrote:
> > On 21/04/22 09:43AM, Leon Romanovsky wrote:
> > > On Thu, Apr 22, 2021 at 12:17:47AM +0530, Amey Narkhede wrote:
> > > > Return value of __ffs is undefined if no set bit exists in
> > > > its argument. This indicates that the associated BAR has
> > > > invalid alignment.
> > > >
> > > > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > > > ---
> > > >  drivers/pci/setup-bus.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > > index 2ce636937c6e..44e8449418ae 100644
> > > > --- a/drivers/pci/setup-bus.c
> > > > +++ b/drivers/pci/setup-bus.c
> > > > @@ -1044,6 +1044,11 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
> > > >  			 * resources.
> > > >  			 */
> > > >  			align = pci_resource_alignment(dev, r);
> > > > +			if (!align) {
> > > > +				pci_warn(dev, "BAR %d: %pR has bogus alignment\n",
> > > > +					 i, r);
> > > > +				continue;
> > > > +			}
> > >
> > > I see that you copied it from pdev_sort_resources(), but it is
> > > incorrect change, see how negative order is handled and later
> > > ARRAY_SIZE() check.
> > >
> > > Thanks
> > >
> > Is it guaranteed that it will return value which will result
> > in negative value or >= ARRAY_SIZE? Comment on __ffs says value
> > is undefined for 0 that means it could be anything or am I missing
> > something?
>
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 2ce636937c6e..ce5380bdd2fd 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1044,10 +1044,11 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>                          * resources.
>                          */
>                         align = pci_resource_alignment(dev, r);
> -                       order = __ffs(align) - 20;
> -                       if (order < 0)
> -                               order = 0;
> -                       if (order >= ARRAY_SIZE(aligns)) {
> +                       if (align) {
> +                               order = __ffs(align) - 20;
> +                               order = (order < 0) ? 0 : order;
> +                       }
> +                       if (!align || order >= ARRAY_SIZE(aligns)) {
>                                 pci_warn(dev, "disabling BAR %d: %pR (bad alignment %#llx)\n",
>                                          i, r, (unsigned long long) align);
>                                 r->flags = 0;
>
>
Oh I see. Thanks. I'll correct this in v2.

Thanks,
Amey
