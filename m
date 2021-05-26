Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC432391359
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 11:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhEZJHs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 05:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhEZJHs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 05:07:48 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71579C061574;
        Wed, 26 May 2021 02:06:16 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id v14so406568pgi.6;
        Wed, 26 May 2021 02:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b5uH/VwkogIgYy1AoASz2+F5naQxa7VLItYJqjkkYEE=;
        b=Bbe32YaQQqpd34qA7KrcSCraLsBgfm1M/WrZ8jVNnopgpPfYpbJ5WjDD2t52KRUcbJ
         Oa6AahwnuIx28ePXztRcSkctb13zoxhP+n9XEXde4IVyMXbfgy84LuVtXJRQAhQcM0PI
         pZ02I7jePMCX1S5OtY3TGQZcIbSJn14CTDMNdwv8yqvRj3LSIS1F0LJWgsUJ8aHzeGhF
         0yyLfrJMBoiHSI7QpYRQ/caGcpsaiWzoQ5BW8NrrzeXAT1FMarMNMq8e9C7kd8p+NSkf
         Y0nTecLQHP80Oy1P7DZ8vu62HLzfrQ6hJfHkgx8e7p5ROY3xaqwVLcCutz6hmWhrkOct
         LWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b5uH/VwkogIgYy1AoASz2+F5naQxa7VLItYJqjkkYEE=;
        b=KIXvaXaoOC3ec/7zctRsaQ617H84cv1Wi+mu4YFZana8RnuMay8ekv21PQpyxxdFd8
         ciwSesVJwm9vKgyf47cCyYmnX0s67m18/RAT9Phv0B0pd8AF7tcrD2AiTT8HvhUElV2F
         E0gqpNLTNbBqnlPqeEgfBWBhdESuzzub/BtRykxDWI1+U0EeCppsqBftE4VTgs2hovge
         WhCqX5dkzwB1FBg7AHZTT270EH4H+1U+DFiA8Y76yzH61xO7EtTk36WGefFCO61UB7tz
         gwufWunygoXSQpskOK6krn+GrOZuk6PZh00IbDOc30XRq/bzrEwTWgu1tSN2ihgaBqQK
         oYnA==
X-Gm-Message-State: AOAM5321FxbLc1YUuBdZuTETIxqgH0YVXVJrDL7nUvIS9BC9MLoiAiH5
        KDyU6ah/r+b4mIzDHxMac4M=
X-Google-Smtp-Source: ABdhPJwzm9HP0tFzvNkzjY1hjIhq4hqYty7Tg0vKbsL8SbqY+cBboCcYoEphZuH1xJF5c/TmndLPng==
X-Received: by 2002:a63:ff25:: with SMTP id k37mr23609751pgi.360.1622019976074;
        Wed, 26 May 2021 02:06:16 -0700 (PDT)
Received: from localhost ([103.248.31.164])
        by smtp.gmail.com with ESMTPSA id y17sm15150465pfb.183.2021.05.26.02.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 02:06:15 -0700 (PDT)
Date:   Wed, 26 May 2021 14:36:12 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2] PCI: Check value of resource alignment before using
 __ffs
Message-ID: <20210526090612.a6i66ugimoxvyomg@archlinux>
References: <20210422105538.76057-1-ameynarkhede03@gmail.com>
 <20210525220115.GA1233963@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525220115.GA1233963@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/05/25 05:01PM, Bjorn Helgaas wrote:
> On Thu, Apr 22, 2021 at 04:25:38PM +0530, Amey Narkhede wrote:
> > Return value of __ffs is undefined if no set bit exists in
> > its argument. This indicates that the associated BAR has
> > invalid alignment.
> >
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> >  drivers/pci/setup-bus.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 2ce636937c6e..ce5380bdd2fd 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1044,10 +1044,11 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
> >  			 * resources.
> >  			 */
> >  			align = pci_resource_alignment(dev, r);
> > -			order = __ffs(align) - 20;
> > -			if (order < 0)
> > -				order = 0;
> > -			if (order >= ARRAY_SIZE(aligns)) {
> > +			if (align) {
> > +				order = __ffs(align) - 20;
> > +				order = (order < 0) ? 0 : order;
> > +			}
> > +			if (!align || order >= ARRAY_SIZE(aligns)) {
> >  				pci_warn(dev, "disabling BAR %d: %pR (bad alignment %#llx)\n",
> >  					 i, r, (unsigned long long) align);
> >  				r->flags = 0;
>
> I know this is solving a theoretical problem.  Is it also solving a
> *real* problem?
>
> I dislike the way it complicates the code and the usage of "align" and
> "order".  I know that when "!align", we don't evaluate the
> "order >= ARRAY_SIZE()" (which would involve an uninitialized value),
> but it just seems ugly, and I'm not sure how much we benefit.
>
> And the "disabling BAR" part is gross.  I know you're not changing
> that part, but it's just wrong.  Setting r->flags = 0 certainly does
> not disable the BAR.  It might make Linux ignore it, but that doesn't
> mean the hardware ignores it.  When we turn on PCI_COMMAND_MEMORY, the
> BAR is enabled along with all the other memory BARs.
>
> Bjorn

Thanks for the detailed explanation. Is there any way to properly
disable the BAR?
On the side note do you think this problem is
worth solving? I came across this during code inspection.
I mean if practically there aren't chances of
this bug occuring I'm okay with dropping this patch.

Thanks,
Amey
