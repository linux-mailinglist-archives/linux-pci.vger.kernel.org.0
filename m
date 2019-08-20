Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB10F968DD
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 21:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfHTTFl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 15:05:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41660 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbfHTTFk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Aug 2019 15:05:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so4955096lfa.8
        for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2019 12:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/4iavkOEUl8X6C7IxT6wezlzlf31KbmYXPDJ0PjRBcA=;
        b=XHqYpNv52Zl2CQ3ahc2IDC4HYNRxphP/tKzP4AUKZYIFz+vFf3FajyjXl9rYD8fEOW
         7fnCmU3I2+X66vqavae2gs0QTCj2AyZPUpdW3TA/H8KOtlWkx0fIkaR1w6ztqlCWe24e
         YpZm/AcodsUnyrhLEybGax+wQ5atzoWTKVZOgDJumNZAOeIK21iXtnWOR2TluDJdD6JE
         eZcHyv4IBsBc2p11VvMNVS+onWK4pkEnqV33zg29YLAWl8wOJRNc+sygQav4QEDGDRok
         W/7to6FD/djbZGorbOhUo/oUks+bqmbLWthOjNWumSZno2p89QHsgwZsorLB9EkiVKMi
         DtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4iavkOEUl8X6C7IxT6wezlzlf31KbmYXPDJ0PjRBcA=;
        b=OsedAFPCZ51ZhuDKMEUeXkxLPGhTB9i3AVP8fCFrwT+v7FghnRCyoVuEHeUrhoMCZP
         QhB7ECwQc6y265my0nBKQogSA7TJO3YPBsM06wH88Y4FYD4E+IozeIGn570UIPsHzUbc
         FCTrAW8OtnIjgZKz0DrejAmQ4ZC4BpclWj3Aqm9gW5UKOiqyn8MnjHymrKDipdl+ZbMx
         YuxQcKKygstnRJg9xs1Sk2m5k8d25vVcui2RusMUVpkvNj8sDZMcX6Vhn0hjXrE/XqGn
         RRT43Q/Dx8ZKP8DZvLnS+tSIOWegO/Eozas5KR9hTyFplNzy4pSKj1dLcGkTqmBsyUuT
         w3QQ==
X-Gm-Message-State: APjAAAXyC9Fwc4De1IM/OCuhZHNXeEeFEgeAJ4rZgR4dsmHBTdhE+y74
        a771EnlKG6Me20B8ch+5qmEoA6sJLM/yX3iYgY4biFlTwH2Pnw==
X-Google-Smtp-Source: APXvYqzRdCdmsX9yUUH9Y9IEpc2u/wA2ZCApq6NzHyzVH8/A/mhklbeHaoeaN4mVUut39FEN6YAPKJPS1qTyLp8UqEE=
X-Received: by 2002:a05:6512:288:: with SMTP id j8mr17879743lfp.181.1566327938099;
 Tue, 20 Aug 2019 12:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <7a6d2f14-f2a6-99ad-3a93-fdaa0726ce86@gmail.com>
 <a0c090cd-e3a4-f667-b99d-f31c48c2e0a3@gmail.com> <20190820103400.GY253360@google.com>
In-Reply-To: <20190820103400.GY253360@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 20 Aug 2019 12:05:01 -0700
Message-ID: <CACK8Z6HJBoJ_OkHEHY6oYtABDVwRx9eCh9GngHxGE63UPsOHig@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI/ASPM: add sysfs attribute for controlling ASPM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 20, 2019 at 3:34 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Greg, Rajat]
>
> On Thu, May 23, 2019 at 10:05:35PM +0200, Heiner Kallweit wrote:
> > Background of this extension is a problem with the r8169 network driver.
> > Several combinations of board chipsets and network chip versions have
> > problems if ASPM is enabled, therefore we have to disable ASPM per default.
> > However especially on notebooks ASPM can provide significant power-saving,
> > therefore we want to give users the option to enable ASPM. With the new sysfs
> > attribute users can control which ASPM link-states are enabled/disabled.
> >
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-pci |  13 ++
> >  drivers/pci/pci.h                       |   8 +-
> >  drivers/pci/pcie/aspm.c                 | 180 +++++++++++++++++++++++-
> >  3 files changed, 193 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > index 8bfee557e..38fe358de 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -347,3 +347,16 @@ Description:
> >               If the device has any Peer-to-Peer memory registered, this
> >               file contains a '1' if the memory has been published for
> >               use outside the driver that owns the device.
> > +
> > +What:                /sys/bus/pci/devices/.../power/aspm_link_states
> > +Date:                May 2019
> > +Contact:     Heiner Kallweit <hkallweit1@gmail.com>
> > +Description:
> > +             If ASPM is supported for an endpoint, then this file can be
> > +             used to enable / disable link states. A link state
> > +             displayed in brackets is enabled, otherwise it's disabled.
> > +             To control link states (case insensitive):
> > +             +state : enables a supported state
> > +             -state : disables a state
> > +             none : disables all link states
> > +             all : enables all supported link states
>
> IIUC this "aspm_link_states" file will contain things like this:
>
>   L0S L1 L1.1 L1.2                 # All states supported, all disabled
>   [L0S] L1                         # L0s enabled, L1 supported but disabled
>   [L0S] [L1]                       # L0s and L1 enabled
>   ...
>
> and the control is by writing things like this to it:
>
>   +L1                              # enables L1
>   +L1.1                            # enables L1.1
>   -L0S                             # disables L0s
>
> I know this file structure is similar to protocol handling in
> drivers/media/rc/rc-main.c, but Documentation/filesystems/sysfs.txt
> suggests single values in a file, and Greg recently pointed out that
> we screwed up some PCI AER stats [1].
>
> So I'm thinking maybe we should split this into several files, e.g.,
>
>   /sys/devices/pci*/.../power/aspm_l0s
>   /sys/devices/pci*/.../power/aspm_l1
>   /sys/devices/pci*/.../power/aspm_l1.1
>   /sys/devices/pci*/.../power/aspm_l1.2
>
> which would contain just 1/0 values, and we'd write 1/0 to
> enable/disable things.
>
> Since the L1 PM Substates control register has separate enable bits
> for PCI-PM L1.1 and L1.2, we might also want a way to manage those.
>
> Bjorn
>
> [1] https://lore.kernel.org/r/20190621072911.GA21600@kroah.com


Sorry, this has been sitting on my plate for some time now. I'll work
on it and send out a patch later in this week.

Thanks,

Rajat
