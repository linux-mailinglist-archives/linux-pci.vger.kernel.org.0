Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE0E367DF7
	for <lists+linux-pci@lfdr.de>; Thu, 22 Apr 2021 11:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhDVJoN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Apr 2021 05:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbhDVJoH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Apr 2021 05:44:07 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DD7C061342;
        Thu, 22 Apr 2021 02:43:27 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id q2so1301340pfk.9;
        Thu, 22 Apr 2021 02:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZOhhMfIBG+uU3b1BF40thPwTl45IKGv6ZvRg7Wdznxs=;
        b=XT00Q88pF576La5YpPNOfex03np4a8WZmLXTEXjEvzHpZYkDu2zYPW1mYTJx+h5n9K
         YNU44UciVfRYCYEw6ihFn7PD76CC4obP/gQ1MX+hZzqBAIH5dQd7BPn/ykbADD+Wgufu
         XQToXQFZlE9hCk7zx5m2ezrZ9pUaWtFXa57z8eZ84KQacPrdpYloF0nYUNmSGqalsJ07
         XvT156aXV9YsF+Fcg8wmHq7EInSt1Kg7wllti2gVgx2Sp9WtJDzI5Z944Fcr2DZWQkaw
         lORRuFL/1khkCd7k4HmgdEpWJSh/kMtqy4rGlexY5CM8x8cGccG2DXtNj82br7tRQAfa
         sjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZOhhMfIBG+uU3b1BF40thPwTl45IKGv6ZvRg7Wdznxs=;
        b=cshD6ZhyDgzy6Y5B8BfriApYqOXl3yWIph9bOfrGZ66cy2yh7PmXAk1zzlOvcepAXJ
         rdnIHs6xaN0fiD703nzOBWKLIQgw6EJPp3vy/PM6dvbcPIISe1SFFDxFfBHaV3VzEHxq
         g9ReAeaZ6c70v6a3c7iHJ3EMVsI+7d2m+LmR61uSpj3hkhsHxgv2Rgeuouwi24UZ13jU
         mf+Is07vqKoPnjvBF8O44WKC/inpOKW0sifmbkcO+LzHhE5RG5B1QzLTEnKRKkF+d3O7
         quw20hfsB3LcCuVYljHH8EuAamMs9hQoO0Q9gfr6qiXadd53hrtGe3ss51VWXhMIt0MF
         GbpA==
X-Gm-Message-State: AOAM530oDqJEYrsxKFCwLjf6hAJ6s9K5fgxV3Pit1AceJUh1dInNpvnM
        VsUZ778ZAVyHpZ79HKdY94c=
X-Google-Smtp-Source: ABdhPJweiPx0+6LIFLMP1adOGnINvQsxWodZOCXwtbemOlcSLYOhvTUI77FBQnnlbDUhHcf0zN4xsg==
X-Received: by 2002:a63:d755:: with SMTP id w21mr2735436pgi.400.1619084607387;
        Thu, 22 Apr 2021 02:43:27 -0700 (PDT)
Received: from localhost ([103.248.31.176])
        by smtp.gmail.com with ESMTPSA id i11sm1673484pfo.183.2021.04.22.02.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 02:43:26 -0700 (PDT)
Date:   Thu, 22 Apr 2021 15:13:23 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Check value of resource alignment before using __ffs
Message-ID: <20210422094323.i4foiagx3hmzxpj4@archlinux>
References: <20210421184747.62391-1-ameynarkhede03@gmail.com>
 <YIEa/5E45SzKzvuf@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIEa/5E45SzKzvuf@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/04/22 09:43AM, Leon Romanovsky wrote:
> On Thu, Apr 22, 2021 at 12:17:47AM +0530, Amey Narkhede wrote:
> > Return value of __ffs is undefined if no set bit exists in
> > its argument. This indicates that the associated BAR has
> > invalid alignment.
> >
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> >  drivers/pci/setup-bus.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 2ce636937c6e..44e8449418ae 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1044,6 +1044,11 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
> >  			 * resources.
> >  			 */
> >  			align = pci_resource_alignment(dev, r);
> > +			if (!align) {
> > +				pci_warn(dev, "BAR %d: %pR has bogus alignment\n",
> > +					 i, r);
> > +				continue;
> > +			}
>
> I see that you copied it from pdev_sort_resources(), but it is
> incorrect change, see how negative order is handled and later
> ARRAY_SIZE() check.
>
> Thanks
>
Is it guaranteed that it will return value which will result
in negative value or >= ARRAY_SIZE? Comment on __ffs says value
is undefined for 0 that means it could be anything or am I missing
something?

Thanks,
Amey
