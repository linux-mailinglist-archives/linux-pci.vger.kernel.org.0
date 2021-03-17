Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B4633F795
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 18:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhCQRyk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 13:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbhCQRyV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Mar 2021 13:54:21 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D99DC06174A;
        Wed, 17 Mar 2021 10:54:21 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id u3so41427655ybk.6;
        Wed, 17 Mar 2021 10:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFox+WQoGmBtFaVoOb6me+4dqOYmy2dsI6pAyvrJ7Ug=;
        b=qUCUtBKuD0sm4NUE8e/dJb/pk8lgbgtPQq5Q4qagYStJIIzKGlUihX9aaVJD2eAoGR
         +UyPjxTahvEejf2kqNh6PP9Icf5lRXoZeG9xeNKIRof1tnHulDeyWPyEipPUkgh/8jWX
         EG1HPRm+PdOEdE041Bh/+uo/JTvMyh3N3PqLVJumXWYXVJRrxCEJeXD5kDtnkTPdZmRF
         WR3GRzjAF5tk1t1VxbrJg+oQTaxRpsfuH8vtInOB34AMytfWx9HYhUTvN0a3qCpqgm9S
         wq7saMAU+QqMpMwqIXtP4gCzFx80obG684ckG9wgO6EN4fmF7Fa/P9cKDG+2rh/nkcvU
         3T1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFox+WQoGmBtFaVoOb6me+4dqOYmy2dsI6pAyvrJ7Ug=;
        b=L/Laa1Pg5GSG4LT1ZQvz22cZ1MceVSeM8NrF9pZOthVqIqLoluYMHPncUBrNUL7den
         ksoKp/jT7DtDDKk5HCcZWjnMAaDgHWWjXrfZJ45Qm/moN8ceq8becMGRJ6KRTVFXYwQn
         lHHsTyuCwn988qks8qMSK8m4CiBnzwMwn3lKHCRVJ9u5IFJeb4NuWjpdxzyMZLMReICN
         eXNbTH5uhnzMhI627VJD9o6Z/FdsrKHMc3JGa0Fc4UEtBOaMlmc88rUEoOmxAkmnRejS
         ziXxvKW2AhLo7HsEta5B9e97gkkWC20WuG+5/YtmQtKYsLpf4POwmtKig0bQ5bOh0MFn
         tYHQ==
X-Gm-Message-State: AOAM532TbFj6gIh+8Khdq2Ux91TnUKjsl+ynR9iW23yBuKecRsEadpNp
        AdZeiPgzWQd/7mqDI9LvHDOWVNPznEX+HsNX/PU=
X-Google-Smtp-Source: ABdhPJwCzFGwYg+DdtzEyFd2JGoKMixoLlIGppha4cTB0w5uTCYfKjYugrkMIOSys7Ttg77pBX3t6UxGch+F5K7VhO8=
X-Received: by 2002:a5b:4a:: with SMTP id e10mr6043294ybp.436.1616003660969;
 Wed, 17 Mar 2021 10:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <59cb30f5e5ac6d65427ceaadf1012b2ba8dbf66c.1615606143.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210317041342.GA19198@wunner.de> <CAPcyv4jxTcUEgcfPRckHqrUPy8gR7ZJsxDaeU__pSq6PqJERAQ@mail.gmail.com>
 <20210317053114.GA32370@wunner.de> <CAPcyv4j8t4Y=kpRSvOjOfVHd107YemiRcW0BNQRwp-d9oCddUw@mail.gmail.com>
 <CAC41dw8sX4T-FrwBju2H3TbjDhJMLGw_KHqs+20qzvKU1b5QTA@mail.gmail.com> <CAPcyv4gfBTuEj494aeg0opeL=PSbk_Cs16fX7A-cLvSV6EZg-Q@mail.gmail.com>
In-Reply-To: <CAPcyv4gfBTuEj494aeg0opeL=PSbk_Cs16fX7A-cLvSV6EZg-Q@mail.gmail.com>
From:   Sathyanarayanan Kuppuswamy Natarajan 
        <sathyanarayanan.nkuppuswamy@gmail.com>
Date:   Wed, 17 Mar 2021 10:54:09 -0700
Message-ID: <CAC41dw_BJBMdwyccdvWNZsdAzzh7ko=q4oSpQXo-jJDTfQGkZw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: pciehp: Skip DLLSC handling if DPC is triggered
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>, knsathya@kernel.org,
        Sinan Kaya <okaya@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Mar 17, 2021 at 10:45 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Mar 17, 2021 at 10:20 AM Sathyanarayanan Kuppuswamy Natarajan
> <sathyanarayanan.nkuppuswamy@gmail.com> wrote:
> >
> > Hi,
> >
> > On Wed, Mar 17, 2021 at 9:31 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Tue, Mar 16, 2021 at 10:31 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > >
> > > > On Tue, Mar 16, 2021 at 10:08:31PM -0700, Dan Williams wrote:
> > > > > On Tue, Mar 16, 2021 at 9:14 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > > > >
> > > > > > On Fri, Mar 12, 2021 at 07:32:08PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > > > > > +     if ((events == PCI_EXP_SLTSTA_DLLSC) && is_dpc_reset_active(pdev)) {
> > > > > > > +             ctrl_info(ctrl, "Slot(%s): DLLSC event(DPC), skipped\n",
> > > > > > > +                       slot_name(ctrl));
> > > > > > > +             ret = IRQ_HANDLED;
> > > > > > > +             goto out;
> > > > > > > +     }
> > > > > >
> > > > > > Two problems here:
> > > > > >
> > > > > > (1) If recovery fails, the link will *remain* down, so there'll be
> > > > > >     no Link Up event.  You've filtered the Link Down event, thus the
> > > > > >     slot will remain in ON_STATE even though the device in the slot is
> > > > > >     no longer accessible.  That's not good, the slot should be brought
> > > > > >     down in this case.
> > > > >
> > > > > Can you elaborate on why that is "not good" from the end user
> > > > > perspective? From a driver perspective the device driver context is
> > > > > lost and the card needs servicing. The service event starts a new
> > > > > cycle of slot-attention being triggered and that syncs the slot-down
> > > > > state at that time.
> > > >
> > > > All of pciehp's code assumes that if the link is down, the slot must be
> > > > off.  A slot which is in ON_STATE for a prolonged period of time even
> > > > though the link is down is an oddity the code doesn't account for.
> > > >
> > > > If the link goes down, the slot should be brought into OFF_STATE.
> > > > (It's okay though to delay bringdown until DPC recovery has completed
> > > > unsuccessfully, which is what the patch I'm proposing does.)
> > > >
> > > > I don't understand what you mean by "service event".  Someone unplugging
> > > > and replugging the NVMe drive?
> > >
> > > Yes, service meaning a technician physically removes the card.
> > >
> > > >
> > > >
> > > > > > (2) If recovery succeeds, there's a race where pciehp may call
> > > > > >     is_dpc_reset_active() *after* dpc_reset_link() has finished.
> > > > > >     So both the DPC Trigger Status bit as well as pdev->dpc_reset_active
> > > > > >     will be cleared.  Thus, the Link Up event is not filtered by pciehp
> > > > > >     and the slot is brought down and back up even though DPC recovery
> > > > > >     was succesful, which seems undesirable.
> > > > >
> > > > > The hotplug driver never saw the Link Down, so what does it do when
> > > > > the slot transitions from Link Up to Link Up? Do you mean the Link
> > > > > Down might fire after the dpc recovery has completed if the hotplug
> > > > > notification was delayed?
> > > >
> > > > If the Link Down is filtered and the Link Up is not, pciehp will
> > > > bring down the slot and then bring it back up.  That's because pciehp
> > > > can't really tell whether a DLLSC event is Link Up or Link Down.
> > > >
> > > > It just knows that the link was previously up, is now up again,
> > > > but must have been down intermittently, so transactions to the
> > > > device in the slot may have been lost and the slot is therefore
> > > > brought down for safety.  Because the link is up, it is then
> > > > brought back up.
> > >
> > > I wonder why we're not seeing that effect in testing?
> >
> > In our test case, there is a good chance that the LINK UP event is also
> > filtered. We change the dpc_reset_active status only after we verify
> > the link is up. So if hotplug handler handles the LINK UP event before
> > we change the status of dpc_reset_active, then it will not lead to the
> > issue mentioned by Lukas.
> >
>
> Ah, ok, we're missing a flush of the hotplug event handler after the
> link is up to make sure the hotplug handler does not see the Link Up.
Flush of hotplug event after successful recovery, and a simulated hotplug link
down event after link recovery fails should solve the problems raised
by Lukas. I assume Lukas' proposal adds this support. I will check his patch
shortly.
> I'm not immediately seeing how the new proposal ensures that there is
> no Link Up event still in flight after DPC completes its work.
> Wouldn't it be required to throw away Link Up to Link Up transitions?



-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
