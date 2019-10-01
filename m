Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74B0DC30CC
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 12:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfJAKBD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 06:01:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729579AbfJAKBD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Oct 2019 06:01:03 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A48484E83E
        for <linux-pci@vger.kernel.org>; Tue,  1 Oct 2019 10:01:02 +0000 (UTC)
Received: by mail-io1-f70.google.com with SMTP id e14so37293076iot.16
        for <linux-pci@vger.kernel.org>; Tue, 01 Oct 2019 03:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SER0HV5bilLXc+Z+uUnUg2+HPb0WCkqYkasAI1B39O8=;
        b=VjL8Wc3Ge/MQtJDOUrJUe5/WnMymxBzpxT5MkCF0H9wkiKtad3HFN/1iDWmoEmLY4J
         gqw7lWZwM0ls5/3QokMIrS1VYqCwNqDfLnmAKGNhV9jyD+3OJgZOhssVUlGva7X4HRT4
         lmPB6elvuGhT4qHm8B38vTyUfXK80DefhBq4Y2fmXswmziCO50UTyv7BwJI2I6RikYhi
         0JkvhwdHGKxYPj3eI0fJhMBwTpR/6nP1DqbSVqTSaiir7vhRdeUtA8ZvZq74AKtFHsTz
         Ci2ATW4N3DI36pDzvjhz9ZHnlqyc36ZqzVtDeaXdtzVMAPwd8l3kTxCR8DeBVTAu+dJf
         hX2w==
X-Gm-Message-State: APjAAAWYMvqtplaRSaI+3DbViHcaD9BZpzbyXo8Iq0SEzFrlbzeUQo2w
        DH/Kv5TUXJ+ljzk1tE+QKsWdbkf9mLLWhpF9XZ5tMCkJKVKsIfQDStsKg+to9OIDkjQ2JgQ6/Wu
        POBrHNKN6zqtg5b+Q5DwYrB0KY905G9XDwOuH
X-Received: by 2002:a92:5e1b:: with SMTP id s27mr25108505ilb.178.1569924062062;
        Tue, 01 Oct 2019 03:01:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzzvt3UWzNOQCTDAR3FsbfyQ03KR0g0C0n9F24SJB+lnl0XJecmzf5ArnwdVKehEJpJnWWu1B7e7XCZ/k3i9wU=
X-Received: by 2002:a92:5e1b:: with SMTP id s27mr25108473ilb.178.1569924061794;
 Tue, 01 Oct 2019 03:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190927214252.GA65801@google.com> <CACO55tuaY1jFXpJPeC9M4PoWEDyy547_tE8MpLaTDb+C+ffsbg@mail.gmail.com>
 <20190930080534.GS2714@lahna.fi.intel.com> <CACO55tuMo1aAA7meGtEey6J6sOS-ZA0ebZeL52i2zfkWtPqe_g@mail.gmail.com>
 <20190930092934.GT2714@lahna.fi.intel.com> <CACO55tu9M8_TWu2MxNe_NROit+d+rHJP5_Tb+t73q5vr19sd1w@mail.gmail.com>
 <20190930163001.GX2714@lahna.fi.intel.com> <CACO55tuk4SA6-xUtJ-oRePy8MPXYAp2cfmSPxwW3J5nQuX3y2g@mail.gmail.com>
 <20191001084651.GC2714@lahna.fi.intel.com> <CACO55ts9ommYbA5g4=G+f0G=v90qGM7EsurU7AL7bU=PFzQMnw@mail.gmail.com>
 <20191001091134.GD2714@lahna.fi.intel.com>
In-Reply-To: <20191001091134.GD2714@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 1 Oct 2019 12:00:50 +0200
Message-ID: <CACO55ttqP8hnse0f2x0Tat-fCLBWjg9jmZHNb+ayZ5k7gSO7bw@mail.gmail.com>
Subject: Re: [RFC PATCH] pci: prevent putting pcie devices into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 1, 2019 at 11:11 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, Oct 01, 2019 at 10:56:39AM +0200, Karol Herbst wrote:
> > On Tue, Oct 1, 2019 at 10:47 AM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > On Mon, Sep 30, 2019 at 06:36:12PM +0200, Karol Herbst wrote:
> > > > On Mon, Sep 30, 2019 at 6:30 PM Mika Westerberg
> > > > <mika.westerberg@linux.intel.com> wrote:
> > > > >
> > > > > On Mon, Sep 30, 2019 at 06:05:14PM +0200, Karol Herbst wrote:
> > > > > > still happens with your patch applied. The machine simply gets shut down.
> > > > > >
> > > > > > dmesg can be found here:
> > > > > > https://gist.githubusercontent.com/karolherbst/40eb091c7b7b33ef993525de660f1a3b/raw/2380e31f566e93e5ba7c87ef545420965d4c492c/gistfile1.txt
> > > > >
> > > > > Looking your dmesg:
> > > > >
> > > > > Sep 30 17:24:27 kernel: nouveau 0000:01:00.0: DRM: DCB version 4.1
> > > > > Sep 30 17:24:27 kernel: nouveau 0000:01:00.0: DRM: MM: using COPY for buffer copies
> > > > > Sep 30 17:24:27 kernel: [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 1
> > > > >
> > > > > I would assume it runtime suspends here. Then it wakes up because of PCI
> > > > > access from userspace:
> > > > >
> > > > > Sep 30 17:24:42 kernel: pci_raw_set_power_state: 56 callbacks suppressed
> > > > >
> > > > > and for some reason it does not get resumed properly. There are also few
> > > > > warnings from ACPI that might be relevant:
> > > > >
> > > > > Sep 30 17:24:27 kernel: ACPI Warning: \_SB.PCI0.GFX0._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20190509/nsarguments-59)
> > > > > Sep 30 17:24:27 kernel: ACPI Warning: \_SB.PCI0.PEG0.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20190509/nsarguments-59)
> > > > >
> > > >
> > > > afaik this is the case for essentially every laptop out there.
> > >
> > > OK, so they are harmless?
> > >
> >
> > yes
> >
> > > > > This seems to be Dell XPS 9560 which I think has been around some time
> > > > > already so I wonder why we only see issues now. Has it ever worked for
> > > > > you or maybe there is a regression that causes it to happen now?
> > > >
> > > > oh, it's broken since forever, we just tried to get more information
> > > > from Nvidia if they know what this is all about, but we got nothing
> > > > useful.
> > > >
> > > > We were also hoping to find a reliable fix or workaround we could have
> > > > inside nouveau to fix that as I think nouveau is the only driver
> > > > actually hit by this issue, but nothing turned out to be reliable
> > > > enough.
> > >
> > > Can't you just block runtime PM from the nouveau driver until this is
> > > understood better? That can be done by calling pm_runtime_forbid() (or
> > > not calling pm_runtime_allow() in the driver). Or in case of PCI driver
> > > you just don't decrease the reference count when probe() ends.
> > >
> >
> > the thing is, it does work for a lot of laptops. We could only observe
> > this on kaby lake and skylake ones. Even on Cannon Lakes it seems to
> > work just fine.
>
> Can't you then limit it to those?
>
> I've experienced that Kabylake root ports can enter and exit in D3cold
> just fine because we do that for Thunderbolt for example. But that
> always requires help from ACPI. If the system is using non-standard ACPI
> methods for example that may require some tricks in the driver side.
>

yeah.. I am not quite sure what's actually the root cause. I was also
trying to use the same PCI registers ACPI is using to trigger this
issue on a normal desktop, no luck. Using the same registers does
trigger the issue (hence the script).

The script is essentially just doing what ACPI does, just skipping a lot.

> > > I think that would be much better than blocking any devices behind
> > > Kabylake PCIe root ports from entering D3 (I don't really think the
> > > problem is in the root ports itself but there is something we are
> > > missing when the NVIDIA GPU is put into D3cold or back from there).
> >
> > I highly doubt there is anything wrong with the GPU alone as we have
> > too many indications which tell us otherwise.
> >
> > Anyway, at this point I don't know where to look further for what's
> > actually wrong. And apparently it works on Windows, but I don't know
> > why and I have no idea what Windows does on such systems to make it
> > work reliably.
>
> By works you mean that Windows is able to put it into D3cold and back?
> If that's the case it may be that there is some ACPI magic that the
> Windows driver does and we of course are missing in Linux.

Afaik that's the case. We were talking with Nvidia about it, but they
are not aware of any issues generally. (on Windows, nor the hardware).
No idea if we can trust their statements though.

But yeah, it might be that on Windows they still do _DSM calls or
something... but until today, Nvidia didn't provide any documentation
to us for that.
