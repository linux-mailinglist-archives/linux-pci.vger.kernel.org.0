Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12C94C0DAE
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 23:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfI0VyD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 17:54:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfI0VyD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Sep 2019 17:54:03 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6813EC08E285
        for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2019 21:54:02 +0000 (UTC)
Received: by mail-io1-f71.google.com with SMTP id q18so15169441ios.8
        for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2019 14:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4g9/x5Yonb8KSkSOUCXWN9K/dMYoetchL0cN5h6+riE=;
        b=DYJaD2+5bc3aN0kvydMRPuZcqb1npVaIxiNBekZpNtc09biGIyjG5p5OAcOM4xmnXO
         rHbZWLuZO846I5elvWrj9SMjQN9nFrqj1Ix23Q8Ox0Vh67HHtgibQZaKCBAAA4UfiqFw
         PUurRYORxh5iGoVxWfiqpKZHACxpPfsuGl2sviXG1fRissMGwUVwUuQu2UV6PB9wTeaF
         2YLI1ERzHfRtKVL7AAokG3vh3p3skGp6PPSzyiOS27TCSeI59vaZmhswTZiQGIDCkMcN
         WJF2y1e+/cTX4LXGIz9Xr206AgwACDMvemE5VNsaNrSoM5TUXrNadUUDda1wbK8+lVjs
         6U7Q==
X-Gm-Message-State: APjAAAWpVwCI2VMpl4sO8ZH0jZ7m3hBIRwXlB8at2uixXDo3lX6fAIMT
        N/k4Rof/25OkcV4lLTjXCKI92Kb6/gf4MKskD9MPKXW+FgyDO1j0Ydd5K3i62vcGMYi3qWqZENZ
        7S927fIENtHWFXTR+4CcOuV9Avq3fT+niSbBy
X-Received: by 2002:a92:5e1b:: with SMTP id s27mr7514256ilb.178.1569621241800;
        Fri, 27 Sep 2019 14:54:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz+FeIbe9Og23DFexhulWIZdW3/wwq+ZxajFJ+W8nkrXsZiZVCo1n0yLYmOeTLRBlQJn8uY6Dgu15B7eU8kf88=
X-Received: by 2002:a92:5e1b:: with SMTP id s27mr7514223ilb.178.1569621241424;
 Fri, 27 Sep 2019 14:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190927144421.22608-1-kherbst@redhat.com> <20190927214252.GA65801@google.com>
In-Reply-To: <20190927214252.GA65801@google.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 27 Sep 2019 23:53:48 +0200
Message-ID: <CACO55tuaY1jFXpJPeC9M4PoWEDyy547_tE8MpLaTDb+C+ffsbg@mail.gmail.com>
Subject: Re: [RFC PATCH] pci: prevent putting pcie devices into lower device
 states on certain intel bridges
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Lyude Paul <lyude@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 27, 2019 at 11:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rafael, Mika, linux-pm]
>
> On Fri, Sep 27, 2019 at 04:44:21PM +0200, Karol Herbst wrote:
> > Fixes runpm breakage mainly on Nvidia GPUs as they are not able to resume.
>
> I don't know what runpm is.  Some userspace utility?  Module
> parameter?
>

runpm aka runtime powermanagement aka runtime_resume and runtime_suspend

> > Works perfectly with this workaround applied.
> >
> > RFC comment:
> > We are quite sure that there is a higher amount of bridges affected by this,
> > but I was only testing it on my own machine for now.
> >
> > I've stresstested runpm by doing 5000 runpm cycles with that patch applied
> > and never saw it fail.
> >
> > I mainly wanted to get a discussion going on if that's a feasable workaround
> > indeed or if we need something better.
> >
> > I am also sure, that the nouveau driver itself isn't at fault as I am able
> > to reproduce the same issue by poking into some PCI registers on the PCIe
> > bridge to put the GPU into D3cold as it's done in ACPI code.
> >
> > I've written a little python script to reproduce this issue without the need
> > of loading nouveau:
> > https://raw.githubusercontent.com/karolherbst/pci-stub-runpm/master/nv_runpm_bug_test.py
>
> Nice script, thanks for sharing it :)  I could learn a lot of useful
> python by studying it.
>
> > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: nouveau@lists.freedesktop.org
> > ---
> >  drivers/pci/pci.c | 39 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 088fcdc8d2b4..9dbd29ced1ac 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -799,6 +799,42 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
> >       return pci_platform_pm ? pci_platform_pm->bridge_d3(dev) : false;
> >  }
> >
> > +/*
> > + * some intel bridges cause serious issues with runpm if the client device
> > + * is put into D1/D2/D3hot before putting the client into D3cold via
> > + * platform means (generally ACPI).
>
> You mention Nvidia GPUs above, but I guess the same issue may affect
> other devices?  I would really like to chase this down to a more
> specific issue, e.g., a hardware defect with erratum, an ACPI defect,
> or a Linux defect.  Without the specifics, this is just a band-aid.
>

yep.. but we were trying to talk to Nvidia and Intel about it and had
no luck getting anything out of them so far. We gave up on Nvidia,
Intel is still pending.

> I don't see any relevant requirements in the _OFF description, but I
> don't know much about ACPI power control.
>
> Your script allows several scenarios; I *guess* the one that causes
> the problem is:
>
>   - write 3 (D3hot) to GPU PowerState (PCIE_PM_REG == 0x64, I assume
>     PM Capability Control Register)

correct

>   - write 3 (D3hot) to bridge PowerState (0x84, I assume PM Capability
>     Control Register)

correct, but this seems to be fine and doesn't fix the issue if that
part is skipped

>   - run _OFF on the power resource for the bridge
>
> From your script I assume you do:
>
>   - run _ON on the power resource for the bridge
>   - write 0 (D0) to the bridge PowerState
>
> You do *not* write the GPU PowerState (which we can't do if the GPU is
> in D3cold).  Is there some assumption that it comes out of D3cold via
> some other mechanism, e.g., is the _ON supposed to wake up the GPU?

if the "link" is powered up again (via 0x248, 0xbc or 0xb0 on the GPU
bridge or the ACPI _ON method) the GPU comes up in the D0 state and is
fully operational, well besides the little issue we've got with the D3
write. It can also be worked around by putting the PCIe link into 5.0
and 8.0 mode, but that's not reliable enough as it fails it around 10%
of all tries.

>
> What exactly is the serious issue?  I guess it's that the rescan
> doesn't detect the GPU, which means it's not responding to config
> accesses?  Is there any timing component here, e.g., maybe we're
> missing some delay like the ones Mika is adding to the reset paths?
>

When I was checking up on some of the PCI registers of the bridge
controller, the slot detection told me that there is no device
recognized anymore. I don't know which register it was anymore, though
I guess one could read it up in the SoC spec document by Intel.

My guess is, that the bridge controller fails to detect the GPU being
here or actively threw it of the bus or something. But a normal system
suspend/resume cycle brings the GPU back online (doing a rescan via
sysfs gets the device detected again)

> > + *
> > + * skipping this makes runpm work perfectly fine on such devices.
> > + *
> > + * As far as we know only skylake and kaby lake SoCs are affected.
> > + */
> > +static unsigned short intel_broken_d3_bridges[] = {
> > +     /* kbl */
> > +     0x1901,
> > +};
> > +
> > +static inline bool intel_broken_pci_pm(struct pci_bus *bus)
> > +{
> > +     struct pci_dev *bridge;
> > +     int i;
> > +
> > +     if (!bus || !bus->self)
> > +             return false;
> > +
> > +     bridge = bus->self;
> > +     if (bridge->vendor != PCI_VENDOR_ID_INTEL)
> > +             return false;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(intel_broken_d3_bridges); i++) {
> > +             if (bridge->device == intel_broken_d3_bridges[i]) {
> > +                     pci_err(bridge, "found broken intel bridge\n");
>
> If this ends up being a hardware defect, we should use a quirk to set
> a bit in the pci_dev once, as we do for broken_intx_masking and
> similar bits.

okay, if you think this is the preferred way then I can change the
patch accordingly.

>
> > +                     return true;
> > +             }
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  /**
> >   * pci_raw_set_power_state - Use PCI PM registers to set the power state of
> >   *                        given PCI device
> > @@ -827,6 +863,9 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
> >       if (state < PCI_D0 || state > PCI_D3hot)
> >               return -EINVAL;
> >
> > +     if (state != PCI_D0 && intel_broken_pci_pm(dev->bus))
> > +             return 0;
> > +
> >       /*
> >        * Validate current state:
> >        * Can enter D0 from any state, but if we can only go deeper
> > --
> > 2.21.0
> >
