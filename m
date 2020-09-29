Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3796027C16A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 11:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgI2JiN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 05:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI2JiN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 05:38:13 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C84EC061755;
        Tue, 29 Sep 2020 02:38:13 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dd13so1297139ejb.5;
        Tue, 29 Sep 2020 02:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tsPNVpPwM2TmXTGTvANkj2w72KlKWAnHJoLRfbXhmQs=;
        b=pzD1pP4Q3JA1YUbaQ0DYo5vT886+rz4rPQI5cIBsER9xVI6bROrUvfzdalZEnJzS20
         AMQtas/Sc0GpJyktzKpyfA2a/yrXLY/ntzwK1sGoTs88kvA0J9LzmA/DbwyAbXUPWR5x
         AKjViHi6Y5v8CXaUZsb8rTi6UFjYeSKJvD8yaLEcDQi6ZXFkzIlTgIptRQDoqf1i4e4v
         s57iVlNs170MuNBwNiUhGLpC8fK/U2IeqzpHt0OsNee40EVBk1v7JNohibw77PiyD6bo
         Ux+XBRxNcOxldtXqIu8pULHncAIh+c72/fEe+m16XYvBwITnaD+hDah0KKpGm1zv2i3C
         VxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tsPNVpPwM2TmXTGTvANkj2w72KlKWAnHJoLRfbXhmQs=;
        b=rV2LVDEfqf4kAg6IYPzPNbVEte/nMnxaeayZI4gO5F87UbYXokDeF2yg/vJxpQ7buS
         3k5xYQI7CPEPNY6lRwEjBntZVYVA0KVeXw0mcWeKpbBs+1F0B8Lef8aJwT4lW7wgPWi4
         chJ6iq7Dg3fi9/egutHGrlU/pajr+ixvkg/oLrvSmEtod41rO7wyJ0C9f7KeiS86H9e3
         6P5JHqHBFkPLP2khJJCLbd5zwWZsyC7B/5nZpcIildS9WDfbL+Ljd6q0K+vXWaOLXZs5
         fRIcJ19ol/gXFdHdcnb7i0kvJCOj2jTxogewRnWWw35R4TefPgNzX32VzvxGixtIG2li
         +vJQ==
X-Gm-Message-State: AOAM531HmBRrVtnPoRIv2Jnj+j++4pJBTI5UHlBFJffsXQqTnXRlzSvm
        xiHFlnvm9qrwjBscytbXDi5GMJIWfaWP+jZe6Rk=
X-Google-Smtp-Source: ABdhPJyuW/xNkTBUofeM6yLEtAUAU0hjrQULDZrC6kaOstWqMkFOWB+c1I0nQoPe6rc0HJMeFENufWbq2GN+05fHJEA=
X-Received: by 2002:a17:906:4956:: with SMTP id f22mr2807055ejt.62.1601372291738;
 Tue, 29 Sep 2020 02:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200925023423.42675-1-haifeng.zhao@intel.com>
 <20200925023423.42675-4-haifeng.zhao@intel.com> <20200925123515.GF3956970@smile.fi.intel.com>
 <CAKF3qh1j-D=6mmyjuLQu9=Pka3ZbB+43_Ec4oge0LhRNnQz-Ug@mail.gmail.com> <20200929085105.GA3956970@smile.fi.intel.com>
In-Reply-To: <20200929085105.GA3956970@smile.fi.intel.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Tue, 29 Sep 2020 17:38:00 +0800
Message-ID: <CAKF3qh28CLbt7N2MJ8WE318wYU4kFe+F5Uew3znVJ17yyTR7OA@mail.gmail.com>
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

Andy,

On Tue, Sep 29, 2020 at 4:51 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 29, 2020 at 10:35:14AM +0800, Ethan Zhao wrote:
> > Preferred style, there will be cleared comment in v6.
>
> Avoid top postings.
>
> > On Sat, Sep 26, 2020 at 12:42 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Thu, Sep 24, 2020 at 10:34:21PM -0400, Ethan Zhao wrote:
> > > > During DPC error injection test we found there is race condition between
> > > > pciehp and DPC driver, null pointer reference caused panic as following
> > >
> > > null -> NULL
> > >
> > > >
> > > >  # setpci -s 64:02.0 0x196.w=000a
> > > >   // 64:02.0 is rootport has DPC capability
> > > >  # setpci -s 65:00.0 0x04.w=0544
> > > >   // 65:00.0 is NVMe SSD populated in above port
> > > >  # mount /dev/nvme0n1p1 nvme
> > > >
> > > >  (tested on stable 5.8 & ICX platform)
> > > >
> > > >  Buffer I/O error on dev nvme0n1p1, logical block 468843328,
> > > >  async page read
> > > >  BUG: kernel NULL pointer dereference, address: 0000000000000050
> > > >  #PF: supervisor read access in kernel mode
> > > >  #PF: error_code(0x0000) - not-present page
> > >
> > > Same comment about Oops.
>
> In another thread it was a good advice to move the full Oops (if you think it's
> very useful to have) after the cutter '---' line, so it will be in email
> archives but Git history.

So git history wouldn't give any of the Oops context, and he/she has
to access LKML,
if offline, then ...lost.

Thanks,
Ethan
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
