Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CE242869D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 08:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhJKGIU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 02:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbhJKGIU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 02:08:20 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE635C061570;
        Sun, 10 Oct 2021 23:06:20 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so3630004otr.7;
        Sun, 10 Oct 2021 23:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uCQJ1Anwx+geP4zKElVEAUByvs28wDh2TDsdOWHfmdw=;
        b=iJbLGBlJhAILk/v1nCdjf5JGrYDNkKEibH+2EcvozGNIocsceCB7ndBDfPq3m4IdMs
         jCfescr9qzeElZ9mdXuIS7BRVCrAhnpC+q3j68pa2ffCmD3bNlxqpFSMHPEkY3XbtPBa
         WWCCM273I7kC2Wa8WQwY+85qKhcaM7oIqDgv+mX6G4Ag8ba0EW8hUieT6IttW1AjuKQK
         z9d7maVAgX9k3Ijzq7URduRPrnhM+O+r/nePJ9EFcKnupKDhWj2JOcCX7K77XozPLEgk
         eSyOFbB9Ss37t+L9HB9W5Jhr6SmCuM4gQe68zWNzhoH7aKWeFmbg29zJn4JDoDxFKc4K
         A9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCQJ1Anwx+geP4zKElVEAUByvs28wDh2TDsdOWHfmdw=;
        b=H6llVjyr6atmoTPi9IbGz/8KGklDKTJyj2CzF6i70IXtbY2cSHJJWJOHJcj//QOrgD
         8hg+PhmzjK/oLje9VSmwHd0SWtuqW/QPWuiUvMlykuIXqC9/RNcC9hsGwR3B4srTZK6F
         Ohn+s8BNAhQJbbzJ8RfcmTrpARogGjXrnhhaLSvaFALGWKS/jytYVNQ19nebDB9c4VJB
         x1ny7XFM0ZgxPA2ohIELKg7HtFXgLZxOI/DHgeHeKp64EuYZf0VzZYW7Yr9CsYsoQUmR
         ONqUwSBbfndDL2oMwgQy3Dag2R6x17noABPKaUbyEAfoQegKOIxCFjoP8jYEfgeJlYvW
         0lgQ==
X-Gm-Message-State: AOAM531Z+RSYSYlN70BRvQ5+JvAK2E/5NVV6gL/RhrzAz+rcDyvBIDNb
        MIlFiugulmgNAO3Cmat7ZOJGUyYjP3a88YPN1eU=
X-Google-Smtp-Source: ABdhPJwUodNxHdIrXcAANLkyzN13fekDUC/vHgXM0eOVj37be+ynEYRXagakf675bRc95LsqJkm8NZNVjk5Y4RcT+hQ=
X-Received: by 2002:a9d:20a3:: with SMTP id x32mr19750134ota.91.1633932380184;
 Sun, 10 Oct 2021 23:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210929004400.25717-5-refactormyself@gmail.com> <20210930202000.GA906085@bhelgaas>
In-Reply-To: <20210930202000.GA906085@bhelgaas>
From:   Saheed Bolarinwa <refactormyself@gmail.com>
Date:   Mon, 11 Oct 2021 08:06:09 +0200
Message-ID: <CABGxfO6MTXX-NmrU+N55-c-F4nrbwkg8YD9zF7NjFvuhEXbMzA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/4] PCI/ASPM: Remove struct pcie_link_state.clkpm_disable
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thank you for the review.


On Thu, Sep 30, 2021 at 10:20 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Sep 29, 2021 at 02:44:00AM +0200, Saheed O. Bolarinwa wrote:
> > From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>
> >
> > The clkpm_disable member of the struct pcie_link_state indicates
> > if the Clock PM state of the device is disabled. There are two
> > situations which can cause the Clock PM state disabled.
> > 1. If the device fails sanity check as in pcie_aspm_sanity_check()
> > 2. By calling __pci_disable_link_state()
>
> And, 3. clkpm_store(), when the user writes to the "clkpm" sysfs file,
> right?
That's right and something went wrong truly. I intend to propose that
instead of setting
    link->clkpm_disable = !state_enable;
we can :
    if (!state_enable)
         pci_disable_link_state_locked(pdev, PCIE_LINK_STATE_CLKPM);

>
> IIUC, clkpm_disable really tells us whether we can enable clkpm.  The
> only place we test clkpm_disable is in pcie_set_clkpm():
>
>   pcie_set_clkpm(struct pcie_link_state *link, int enable)
>   {
>     if (!link->clkpm_capable || link->clkpm_disable)
>       enable = 0;
>     pcie_set_clkpm_nocheck(link, enable);
>   }
>
> So in other words, if clkpm_disable is set, we will never call
> pcie_set_clkpm_nocheck() to *enable* clkpm.  We will only call it to
> *disable* clkpm.
>
For case 1 (as stated above), this is fine. However, I am concerned that
the intention of cases 2 and 3 may require that it should be possible to
re-enable clkpm after disabling it. Is this the correct perspective?

I think the essence of this patch should have been to show that cases 2 and 3
have the same goal which is different from case 1. Hence, three and not two
checks are needed within pcie_set_clkpm().




> Tangent: I think the usefulness of pcie_set_clkpm_nocheck() being a
> separate function is gone.  I think things will be a little simpler if
> we integrate it into pcie_set_clkpm().  Separate preliminary patch, of
> course.
>
> > It is possible to set the Clock PM state of a device ON or OFF by
> > calling pcie_set_clkpm(). The state can be retieved by calling
> > pcie_get_clkpm_state().
>
> s/retieved/retrieved/
>
> > pcie_link_state.clkpm_disable is only accessed in pcie_set_clkpm()
> > to ensure that Clock PM state can be reenabled after being disabled.
> >
> > This patch:
> >   - add pm_disable to the struct pcie_link_state, to indicate that
> >     the kernel has marked the device's AS and Clock PM states disabled
> >   - removes clkpm_disable from the struct pcie_link_state
> >   - removes all instance where clkpm_disable is set
> >   - ensure that the Clock PM is always disabled if it is part of the
> >     states passed into __pci_disable_link_state(), regardless of the
> >     global policy
> >
> > Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 18 +++++-------------
> >  1 file changed, 5 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 368828cd427d..e6ae00daa7ae 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -60,8 +60,7 @@ struct pcie_link_state {
> >       u32 aspm_default:7;             /* Default ASPM state by BIOS */
> >       u32 aspm_disable:7;             /* Disabled ASPM state */
> >
> > -     /* Clock PM state */
> > -     u32 clkpm_disable:1;            /* Clock PM disabled */
> > +     u32 pm_disabled:1;              /* Disabled AS and Clock PM ? */
>
> What did we gain by renaming this?  AFAICT this only affects clkpm
> (the only test of pm_disabled is in pcie_set_clkpm()).
>
> >       /* Exit latencies */
> >       struct aspm_latency latency_up; /* Upstream direction exit latency */
> > @@ -198,7 +197,7 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
> >        * Don't enable Clock PM if the link is not Clock PM capable
> >        * or Clock PM is disabled
> >        */
> > -     if (!capable || link->clkpm_disable)
> > +     if (enable && (!capable || link->pm_disabled))
> >               enable = 0;
> >       /* Need nothing if the specified equals to current state */
> >       if (pcie_get_clkpm_state(link->pdev) == enable)
> > @@ -206,11 +205,6 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
> >       pcie_set_clkpm_nocheck(link, enable);
> >  }
> >
> > -static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
> > -{
> > -     link->clkpm_disable = blacklist ? 1 : 0;
> > -}
> > -
> >  static bool pcie_retrain_link(struct pcie_link_state *link)
> >  {
> >       struct pci_dev *parent = link->pdev;
> > @@ -952,8 +946,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
> >        */
> >       pcie_aspm_cap_init(link, blacklist);
> >
> > -     /* Setup initial Clock PM state */
> > -     pcie_clkpm_cap_init(link, blacklist);
> > +     link->pm_disabled = blacklist;
> >
> >       /*
> >        * At this stage drivers haven't had an opportunity to change the
> > @@ -1129,8 +1122,8 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
> >       pcie_config_aspm_link(link, policy_to_aspm_state(link));
> >
> >       if (state & PCIE_LINK_STATE_CLKPM)
> > -             link->clkpm_disable = 1;
> > -     pcie_set_clkpm(link, policy_to_clkpm_state(link));
> > +             pcie_set_clkpm(link, 0);
> > +
> >       mutex_unlock(&aspm_lock);
> >       if (sem)
> >               up_read(&pci_bus_sem);
> > @@ -1301,7 +1294,6 @@ static ssize_t clkpm_store(struct device *dev,
> >       down_read(&pci_bus_sem);
> >       mutex_lock(&aspm_lock);
> >
> > -     link->clkpm_disable = !state_enable;
>
> Something is seriously wrong here because clkpm_store() no longer does
> anything with "state_enable", the value we got from the user.
>
> >       pcie_set_clkpm(link, policy_to_clkpm_state(link));
> >
> >       mutex_unlock(&aspm_lock);
> > --
> > 2.20.1
> >
