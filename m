Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5953396FB
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 19:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhCLS6c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 13:58:32 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:35568 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbhCLS6K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 13:58:10 -0500
Received: by mail-qt1-f176.google.com with SMTP id a11so4600385qto.2;
        Fri, 12 Mar 2021 10:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+adyhmn/QdTDG7E3DjMxdyy1U3vHIp1uzLz5u790+TM=;
        b=U/aUdmeiePAQMd58C1rW+yoYrwo4cGVgP/F+YsPwloUKn3lrF0A931vu/TyD+u9n2x
         0gEEfi5LHlr21fGblvCRmkB9c8mEyVbfnzSKN/0acK2LiFmu7ocvCpgx+mVO7Rbu0jyH
         AiKCgbPdMX3VbP3Q9LpsbHQmvpUiL9mJpXxvG5nKjtI7OHg2GAgDGUZOPSJbsf/c7l3g
         v+oKHq/YNR5Ie5LV3jquRk9ZeBDermkzxJcQ5N6jZH8CgtjzcoVatfmrlM3JDvvqGri1
         I23LI872z4lTegJELMnsMYLhPwGIsyfgYSmpQzXp4bANZO8e9lRsEFXGfVyUU8+yQzLD
         /xyQ==
X-Gm-Message-State: AOAM533tIqozvpqw9k/6OTU+AHjXw6OAgAh+YK+XpFB36PlomTv3yyhG
        TJ06AYWU5y3thfaM0DoHSmE=
X-Google-Smtp-Source: ABdhPJxAlVg0CUhAO5wpdykoPW2HYAEOqhQzeg1AaJpztGa/COvTeOu2OmdeaeGfXhyrbV5qlIpCdw==
X-Received: by 2002:a05:622a:486:: with SMTP id p6mr13115325qtx.81.1615575490216;
        Fri, 12 Mar 2021 10:58:10 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id v2sm4735733qkp.119.2021.03.12.10.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 10:58:09 -0800 (PST)
Date:   Fri, 12 Mar 2021 19:58:06 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        raphael.norwitz@nutanix.com
Subject: Re: [PATCH 0/4] Expose and manage PCI device reset
Message-ID: <YEu5vq4ACcupBpRC@rocinante>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
 <20210312112043.3f2954e3@omen.home.shazbot.org>
 <20210312184038.to3g3px6ep4xfavn@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210312184038.to3g3px6ep4xfavn@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Amey,

Thank you for sending the series over!

[...]
> > Reviews/Acks/Sign-off-by from others (aside from Tested/Reported-by)
> > really need to be explicit, IMO.  This is a common issue for new
> > developers, but it really needs to be more formal.  I wouldn't claim to
> > be able to speak for Raphael and interpret his comments so far as his
> > final seal of approval.
> >
> > Also in the patches, all Sign-offs/Reviews/Acks need to be above the
> > triple dash '---' line.  Anything between that line and the beginning
> > of the diff is discarded by tools.  People will often use that for
> > difference between version since it will be discarded on commit.
> > Likewise, the cover letter is not committed, so Review-by there are
> > generally not done.  I generally make my Sign-off last in the chain and
> > maintainers will generally add theirs after that.  This makes for a
> > chain where someone can read up from the bottom to see how this commit
> > entered the kernel.  Reviews, Acks, and whatnot will therefore usually
> > be collected above the author posting the patch.
> >
> > Since this is a v1 patch and it's likely there will be more revisions,
> > rather than send a v2 immediately with corrections, I'd probably just
> > reply to the cover letter retracting Raphael's Review-by for him to
> > send his own and noting that you'll fix the commit reviews formatting,
> > but will wait for a bit for further comments before sending a new
> > version.
> >
> > No big deal, nice work getting it sent out.  Thanks,
> >
> > Alex
> >
> Raphael sent me the email with
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com> that
> is why I included it.
> So basically in v2 I should reorder tags such that Sign-off will be
> the last. Did I get that right? Or am I missing something?
[...]

I am not sure about the messages outside of the mailing list between
you, Alex and Raphael, as normally conversation and any reviews would
happen here (on the mailing list, that is), but as long as everyone
involved is on the same page, then every should be fine.

In terms of how to format the patch, have a look at the following,
especially before you send another version, as there are some good tips
and recommendations there (including how to order things):

  https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/

Krzysztof
