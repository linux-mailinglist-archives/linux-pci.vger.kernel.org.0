Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF3D33F75F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 18:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhCQRqF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 13:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbhCQRpb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Mar 2021 13:45:31 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B54C06174A
        for <linux-pci@vger.kernel.org>; Wed, 17 Mar 2021 10:45:31 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y6so3350811eds.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Mar 2021 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3+jbSQhgO2M50c8RnLTshbFAggGniObF7WgVOvlDyi8=;
        b=Kr80ORLaQlf8ECE5poODA5M3XneyW20JkaUrpc7uM49MpJEcAPLIiXzYfNAUPPSvyv
         j4Or20lvvxAaBhsMYMiC2/PBJdtLZ4n/s1e3y+R8P7zTW7cXp/HaBaImVzzbUcNbQIvL
         x7YB96PA6F4n5d9Tkv/Hgy2cOYPQDMcOxTgf5bofTpy55H/3+ZyuMC2rNWNv87kSDMk4
         fejnQl7FTuajrheyDfBDf60TLP0zZRV1MZ+Qr7UrkZRVtkVPDZD8y0udeqzkMs6Sl7aa
         ncJu4+vKFUlZtRf1Grh2qM273Eh3/0PgZjfuA3hzNle4lgqvfcJ/EW8KT1fkPuRnQjgG
         TG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+jbSQhgO2M50c8RnLTshbFAggGniObF7WgVOvlDyi8=;
        b=DjkGsZVvLIvfcbLMLeb48NkvooQ6GqjCf3eNzlINeDzqrfbbie9nOavxwTX05HLfAO
         f4VYz9Ry+8NJbmaCQ77QVKHJ8widSfPRrGpf1Ps/+21F0NHyrKADEinp3d1QpnrkTVPB
         jchfMXuLisQ1rcfhFS8AfIHb+UXUDw9ywC2sHxLTiy2qEHVykHQn7D2n/OF5mgyAdpRa
         xWWTyNqh5UDrkruxxkBQyfwClW3sFRqTzTD8MX0s7/Q65uRNBUtcvgg8wpZRdjoYukgn
         7SE2UcejwHT16v7USjB75r8VHyCNWwCedHzolkM8PPFijViJzAmXC7ETYWBaflG9kpr4
         V2Rg==
X-Gm-Message-State: AOAM531adAAK6t/mdP043SpURSGRYffDn16poIRvPOtsYqNIuFuFdEBa
        JxCs8T+dNTLcF1QKnBDHR2DxBTopJqM/oekhcXk2HaryrKo=
X-Google-Smtp-Source: ABdhPJxMxEVP4aY4veYMYEEfXD0t7oWWDbbk445JLMXjFqTiyBHrmN/5jWRXlu7v0klMLOtdzLfNdpW9ihs3ePig8eU=
X-Received: by 2002:a05:6402:11c9:: with SMTP id j9mr43442207edw.348.1616003128580;
 Wed, 17 Mar 2021 10:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <59cb30f5e5ac6d65427ceaadf1012b2ba8dbf66c.1615606143.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210317041342.GA19198@wunner.de> <CAPcyv4jxTcUEgcfPRckHqrUPy8gR7ZJsxDaeU__pSq6PqJERAQ@mail.gmail.com>
 <20210317053114.GA32370@wunner.de> <CAPcyv4j8t4Y=kpRSvOjOfVHd107YemiRcW0BNQRwp-d9oCddUw@mail.gmail.com>
 <CAC41dw8sX4T-FrwBju2H3TbjDhJMLGw_KHqs+20qzvKU1b5QTA@mail.gmail.com>
In-Reply-To: <CAC41dw8sX4T-FrwBju2H3TbjDhJMLGw_KHqs+20qzvKU1b5QTA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 17 Mar 2021 10:45:21 -0700
Message-ID: <CAPcyv4gfBTuEj494aeg0opeL=PSbk_Cs16fX7A-cLvSV6EZg-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: pciehp: Skip DLLSC handling if DPC is triggered
To:     Sathyanarayanan Kuppuswamy Natarajan 
        <sathyanarayanan.nkuppuswamy@gmail.com>
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

On Wed, Mar 17, 2021 at 10:20 AM Sathyanarayanan Kuppuswamy Natarajan
<sathyanarayanan.nkuppuswamy@gmail.com> wrote:
>
> Hi,
>
> On Wed, Mar 17, 2021 at 9:31 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Tue, Mar 16, 2021 at 10:31 PM Lukas Wunner <lukas@wunner.de> wrote:
> > >
> > > On Tue, Mar 16, 2021 at 10:08:31PM -0700, Dan Williams wrote:
> > > > On Tue, Mar 16, 2021 at 9:14 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > > >
> > > > > On Fri, Mar 12, 2021 at 07:32:08PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > > > > +     if ((events == PCI_EXP_SLTSTA_DLLSC) && is_dpc_reset_active(pdev)) {
> > > > > > +             ctrl_info(ctrl, "Slot(%s): DLLSC event(DPC), skipped\n",
> > > > > > +                       slot_name(ctrl));
> > > > > > +             ret = IRQ_HANDLED;
> > > > > > +             goto out;
> > > > > > +     }
> > > > >
> > > > > Two problems here:
> > > > >
> > > > > (1) If recovery fails, the link will *remain* down, so there'll be
> > > > >     no Link Up event.  You've filtered the Link Down event, thus the
> > > > >     slot will remain in ON_STATE even though the device in the slot is
> > > > >     no longer accessible.  That's not good, the slot should be brought
> > > > >     down in this case.
> > > >
> > > > Can you elaborate on why that is "not good" from the end user
> > > > perspective? From a driver perspective the device driver context is
> > > > lost and the card needs servicing. The service event starts a new
> > > > cycle of slot-attention being triggered and that syncs the slot-down
> > > > state at that time.
> > >
> > > All of pciehp's code assumes that if the link is down, the slot must be
> > > off.  A slot which is in ON_STATE for a prolonged period of time even
> > > though the link is down is an oddity the code doesn't account for.
> > >
> > > If the link goes down, the slot should be brought into OFF_STATE.
> > > (It's okay though to delay bringdown until DPC recovery has completed
> > > unsuccessfully, which is what the patch I'm proposing does.)
> > >
> > > I don't understand what you mean by "service event".  Someone unplugging
> > > and replugging the NVMe drive?
> >
> > Yes, service meaning a technician physically removes the card.
> >
> > >
> > >
> > > > > (2) If recovery succeeds, there's a race where pciehp may call
> > > > >     is_dpc_reset_active() *after* dpc_reset_link() has finished.
> > > > >     So both the DPC Trigger Status bit as well as pdev->dpc_reset_active
> > > > >     will be cleared.  Thus, the Link Up event is not filtered by pciehp
> > > > >     and the slot is brought down and back up even though DPC recovery
> > > > >     was succesful, which seems undesirable.
> > > >
> > > > The hotplug driver never saw the Link Down, so what does it do when
> > > > the slot transitions from Link Up to Link Up? Do you mean the Link
> > > > Down might fire after the dpc recovery has completed if the hotplug
> > > > notification was delayed?
> > >
> > > If the Link Down is filtered and the Link Up is not, pciehp will
> > > bring down the slot and then bring it back up.  That's because pciehp
> > > can't really tell whether a DLLSC event is Link Up or Link Down.
> > >
> > > It just knows that the link was previously up, is now up again,
> > > but must have been down intermittently, so transactions to the
> > > device in the slot may have been lost and the slot is therefore
> > > brought down for safety.  Because the link is up, it is then
> > > brought back up.
> >
> > I wonder why we're not seeing that effect in testing?
>
> In our test case, there is a good chance that the LINK UP event is also
> filtered. We change the dpc_reset_active status only after we verify
> the link is up. So if hotplug handler handles the LINK UP event before
> we change the status of dpc_reset_active, then it will not lead to the
> issue mentioned by Lukas.
>

Ah, ok, we're missing a flush of the hotplug event handler after the
link is up to make sure the hotplug handler does not see the Link Up.
I'm not immediately seeing how the new proposal ensures that there is
no Link Up event still in flight after DPC completes its work.
Wouldn't it be required to throw away Link Up to Link Up transitions?
