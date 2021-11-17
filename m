Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87F945451A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 11:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbhKQKlC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 05:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbhKQKlB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 05:41:01 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324E8C061570;
        Wed, 17 Nov 2021 02:38:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g14so8901540edb.8;
        Wed, 17 Nov 2021 02:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qa3n/KzCMTYGN/1v+jIJEP7oktWMvAEVPnwJDJ9m/IE=;
        b=i4toUzHxlkTa/B2ubzn6iYSyEvWzvnvBBV0iKLHfCKLKZYClJorZQXXL2CXF3pU5JZ
         6p4KjvC9L/EsjT60W+/pQSSVmo35ZMHK8PVNDCf5mIzr5pnwK1y/kPTDT8c0De2zlz+W
         IvSaG5rKRFzzF3VcnsTLGSPCDkKTpv3iKQsmqp3kPGcFinuRhv5wQDXaXuXlOBpxw8ez
         bWtJlZzkyYlMaFzwrY5wAV38cKEDUQxfulJuCzzjTAfDPErC1Th5qdLHJhwwAxVcOs1X
         xRdGzK93ETEhpCgGHOMHN5aPrM/qBzK0eFFZmQ/Bp9475LYVysENKqqsifMKbA16vQw6
         3KEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qa3n/KzCMTYGN/1v+jIJEP7oktWMvAEVPnwJDJ9m/IE=;
        b=DCu299Vjt31F3CVF9CuA9OLy+GEhjDxbLhQwJFTJdK9vFSGvTJbdjv8dbBLFHjAC9u
         OoaFRsN6q/YE5EoQP5HtJ3PJBCNGXKj1BGJRdFYiT6EeXch904avoq4wh1xdGM0hLWkQ
         qXQM2yyROUpO/my+plm+NiNpQGPTWUHYpXvDZMg2zGBW2Ii8rXv7pK7sQbdNoqD6fEus
         vh5aHEKNogGxlVCFYQ5ZcolRqjwWJX52oGABQS2b9xSyDUTkLvQI9FmswA1X+23pZF7e
         muc4fZ7LMUDaBMqX1e7TPAa16EQwuEwLDuqOUVM9uyqtWx7Pp1CXqr6n9kYzHT/wVqQp
         +93g==
X-Gm-Message-State: AOAM5307En7FL/qKvE5UmyjB9p4XbM9UdMQgHpGPwjUmfefCLjlek9sV
        cvl6KlHEwvfsPvuiLeIuog8KKBZu05uqREe+AT4=
X-Google-Smtp-Source: ABdhPJxFZerd5BqAKLov7YM2joxLa/Wa/MoSzmoxDx+6jFrpXvG1C2WIXVjbYvezT/mFAw//9lwGPs4oLblykMLP1T8=
X-Received: by 2002:a17:906:ecac:: with SMTP id qh12mr20058042ejb.377.1637145481704;
 Wed, 17 Nov 2021 02:38:01 -0800 (PST)
MIME-Version: 1.0
References: <20211115112000.23693-1-andriy.shevchenko@linux.intel.com>
 <94d3f4e5-a698-134c-8264-55d31d3eafa6@arm.com> <CAHp75VeJ8ZiD=qQVfeahUjGZduFRJJ5683hn8f4810JYEzsCyw@mail.gmail.com>
 <YZJxG7JFAfIqr1/f@smile.fi.intel.com> <CAL_JsqJndi-gmenSpPtMVfsb3SrA=w+YBsSh3GigfgXC3rYDeQ@mail.gmail.com>
 <71a90592-99bb-13e1-a671-eb19c2dad3da@broadcom.com> <351fa3ec-52fa-58f5-cc57-e92498647d5c@gmail.com>
In-Reply-To: <351fa3ec-52fa-58f5-cc57-e92498647d5c@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 Nov 2021 12:37:20 +0200
Message-ID: <CAHp75Vd4bUEmneSRPTkz-YhA7GbCx2n_+v4y4kyaw4ZaBCvU_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Use BIT() as __GENMASK() is for
 internal use only
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 17, 2021 at 12:42 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 11/16/21 12:41 PM, Florian Fainelli wrote:
> > On 11/16/21 10:20 AM, Rob Herring wrote:
> >> +Marc Z
> >>
> >> On Mon, Nov 15, 2021 at 8:39 AM Andy Shevchenko
> >> <andriy.shevchenko@linux.intel.com> wrote:
> >>>
> >>> On Mon, Nov 15, 2021 at 04:14:21PM +0200, Andy Shevchenko wrote:
> >>>> On Mon, Nov 15, 2021 at 4:01 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >>>>> On 2021-11-15 11:20, Andy Shevchenko wrote:
> >>>>>> Use BIT() as __GENMASK() is for internal use only. The rationale
> >>>>>> of switching to BIT() is to provide better generated code. The
> >>>>>> GENMASK() against non-constant numbers may produce an ugly assembler
> >>>>>> code. On contrary the BIT() is simply converted to corresponding shift
> >>>>>> operation.
> >>>>>
> >>>>> FWIW, If you care about code quality and want the compiler to do the
> >>>>> obvious thing, why not specify it as the obvious thing:
> >>>>>
> >>>>>         u32 val = ~0 << msi->legacy_shift;
> >>>>
> >>>> Obvious and buggy (from the C standard point of view)? :-)
> >>>
> >>> Forgot to mention that BIT() is also makes it easy to avoid such mistake.
> >>>
> >>>>> Personally I don't think that abusing BIT() in the context of setting
> >>>>> multiple bits is any better than abusing __GENMASK()...
> >>>>
> >>>> No, BIT() is not abused here, but __GENMASK().
> >>>>
> >>>> After all it's up to you, folks, consider that as a bug report.
> >>
> >> Couldn't we get rid of legacy_shift entirely if the legacy case sets
> >> up 'hwirq' as 24-31 rather than 0-7? Though the data for the MSI msg
> >> uses the hwirq.
> >
> > I personally find it clearer and easier to reason about with the current
> > code though I suppose that with an appropriate xlate method we could
> > sort of set up the hwirq the way we want them to be to avoid any
> > shifting in brcm_pcie_msi_isr().
>
> Something like the following maybe? Completely untested as I don't
> believe I have a device with that legacy controller available at the moment:

Since it gets rid of __GENMASK (ab)use, I'm fine to see it applied at
some point.

-- 
With Best Regards,
Andy Shevchenko
