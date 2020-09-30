Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8E927DE3E
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 04:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgI3CHX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 22:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbgI3CHW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 22:07:22 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A680C061755;
        Tue, 29 Sep 2020 19:07:22 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l24so127897edj.8;
        Tue, 29 Sep 2020 19:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xyAHQbXp/6MC70Z0VwrDxQPUEm52mhP+JTOEWvEI/ps=;
        b=owZdRZTGnUKBsLuWA5zO8Gi5OwS7aOdqwSvqfTW98I77NGMfn6e0rkJ6RPvqA/uWfW
         54MqIhXw8X0hRTcharSLheF9jjzv8TeBxU51V7Aw8IOI0lSoB94QeoMlbq+57Pqall67
         rPljp4YUxYqcoqe1Noo+SDsVEKJTohsdMAr3UkB1r0UTGxI0xCQyfnp0beo8LglOjfpG
         EIDbe7ndI5zm5q+8zIJTsECCRsIo/5mbrK0JOpkTbR0CS4etWgryVJNs5r9TkkzRIdhQ
         ZO3sX8sha3t8FK0AyjJhPDq7SF4tyvUeOxPS4TNHmnnkasvtxWXu4BpC9eg5MBqyVCuy
         U3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xyAHQbXp/6MC70Z0VwrDxQPUEm52mhP+JTOEWvEI/ps=;
        b=oAlI+cVc/EK2OA5+lN/XYLUN3bF+qbywNGgOj47maI8FDkFRR6pujzNuDoRdI+72Bl
         wacLKWaMf3akSo9uI0VD37YADlFM7lt4UkNOzXv+bP80WHVXC0pUE182wqyWeC7NrK3Z
         hjMwBgMZamGzzcM7Pw25lMGbYA7ALzWGc4X5P7AUszkXrPXaFw7a+LGQU9Q3agUCGhq3
         RLcIJfULq6KXR5IXGeMSInHyoMaCORRVSPIVFLgIamTbnpbC3Z43uUsjkVjuvqLaQkRl
         AC+GiM6WQiql1UXCmCe49BY/SyEYKKZS2p/Iubp1qWphkJuXVNwXk5KQasNsfSdEP4WN
         h4Fg==
X-Gm-Message-State: AOAM530IK5wp3/bdLACJwiaOzWw2s/3IdSNw1AoXg6YeA6i6M2Ee+Wb7
        7ZSQ772kgomwOUur728T21vL5U4EEeOQwt2ppMMpvBxT/Fs=
X-Google-Smtp-Source: ABdhPJwXBpc6cGmAhTa6kVnOYWj6hEAT/BkLi/9jX3CmaiR9ZHnh/r19EwMU8OUz1K3J+dsjQIKqTsgtgEYEQuu+Ek0=
X-Received: by 2002:a50:b063:: with SMTP id i90mr361048edd.187.1601431641331;
 Tue, 29 Sep 2020 19:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200925023423.42675-1-haifeng.zhao@intel.com>
 <20200925023423.42675-4-haifeng.zhao@intel.com> <20200925123515.GF3956970@smile.fi.intel.com>
 <CAKF3qh1j-D=6mmyjuLQu9=Pka3ZbB+43_Ec4oge0LhRNnQz-Ug@mail.gmail.com>
 <20200929085105.GA3956970@smile.fi.intel.com> <CAKF3qh28CLbt7N2MJ8WE318wYU4kFe+F5Uew3znVJ17yyTR7OA@mail.gmail.com>
 <20200929104815.GD3956970@smile.fi.intel.com>
In-Reply-To: <20200929104815.GD3956970@smile.fi.intel.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Wed, 30 Sep 2020 10:07:10 +0800
Message-ID: <CAKF3qh094jwPWLB+tegw3knOT=tPrGf=YURkb6=3Cx_ej_rH1Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI/ERR: get device before call device driver to
 avoid null pointer reference
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ethan Zhao <haifeng.zhao@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Oliver <oohall@gmail.com>,
        ruscur@russell.cc, Lukas Wunner <lukas@wunner.de>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jia, Pei P" <pei.p.jia@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 29, 2020 at 6:48 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 29, 2020 at 05:38:00PM +0800, Ethan Zhao wrote:
> > On Tue, Sep 29, 2020 at 4:51 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Sep 29, 2020 at 10:35:14AM +0800, Ethan Zhao wrote:
> > > > Preferred style, there will be cleared comment in v6.
> > >
> > > Avoid top postings.
> > >
> > > > On Sat, Sep 26, 2020 at 12:42 AM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Thu, Sep 24, 2020 at 10:34:21PM -0400, Ethan Zhao wrote:
>
> ...
>
> > > > > >  Buffer I/O error on dev nvme0n1p1, logical block 468843328,
> > > > > >  async page read
> > > > > >  BUG: kernel NULL pointer dereference, address: 0000000000000050
> > > > > >  #PF: supervisor read access in kernel mode
> > > > > >  #PF: error_code(0x0000) - not-present page
> > > > >
> > > > > Same comment about Oops.
> > >
> > > In another thread it was a good advice to move the full Oops (if you think it's
> > > very useful to have) after the cutter '---' line, so it will be in email
> > > archives but Git history.
> >
> > So git history wouldn't give any of the Oops context, and he/she has
> > to access LKML,
> > if offline, then ...lost.
>
> Tell me, do you really think the line:
>    #PF: error_code(0x0000) - not-present page
> makes any sense in the commit message?
>
> I do not think so. And so on, for almost 60% of the Oops.
> Really, to help one person you will make millions suffering. It's not okay.
>
If you and millions  feel so suffered,  why not try to simplify the
Oops code to not
output nonsense too much to console and log. :)

They might not be so important to old birds as you. but it is easy to cut off
the road for newcomers.

Anyway, it is not the focus of this patchset. help to take a look and
try the code.


Thanks,
Ethan

> --
> With Best Regards,
> Andy Shevchenko
>
>
