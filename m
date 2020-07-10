Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B8221C029
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jul 2020 00:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgGJWyi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 18:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgGJWyh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jul 2020 18:54:37 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82585C08C5DD
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2020 15:54:37 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e8so8205567ljb.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2020 15:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U7Cna4GrnjdjT+b7GHMGh/kq7NJ5oQ1TUzK9PPX6KpA=;
        b=a6gbiToyPxUK3InfnvVZBU7oEbpYuMHbk6eqF+jMiyF6wPT/Z64eZPlf9V/Zaj1LP0
         kZkRbL0Saj2MSBonD6QOvJtpDCP2I9w4TiFF2V/ooWVigvgcrvNCYundCD09B2fhaRZC
         9fPoMp36q6NZg4kG4CICGp8zwK77O+Q8BzzEEVkx6GU9J8snKkF2O8x4zqunNyNJ4C1j
         OyJQQ9d6oHiaBsXbA+I2CBySWDPATgKnetYtFn0V5V8vPhQfKZrMg6MDD8ClpR3w7qev
         HSOD61JmBfoOD566JRe76F7tSyYg9i/0gen00XoPo7Cn5Pwb5VHMJvJgGb2KNuASs9ow
         7iNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U7Cna4GrnjdjT+b7GHMGh/kq7NJ5oQ1TUzK9PPX6KpA=;
        b=RUySv1s2aWdaulLl4BWCF+wV6AD7CTdGNEF858yvkhWvouvVRZ+10OXLJdNfNa3qgF
         6xPHj2ZPzhXEu7khbkxryND2qzMxG67cKjSq6x/a1/gYdIxCflYA+w4daZ2bm+QchyoE
         eg91oH9mNlSWhmRKgXTbpb4dj/gQFTMxgc5fxrfWcP9z2r9BewhRH7G/9PYmGHdxHCww
         hQcl6/ZcfKhMbG3nXuvtfqX3JqIQcAR76Wb3q6HEI49xtPCNZ/UeTVxgIL12Bfu48Zp7
         EznIpq0f2VEWyvIwSkbXi/eFn4WY2931JNaGBOmGKHtMWTPOmGkU+D1tIBCsIm3O2ldx
         Fc+A==
X-Gm-Message-State: AOAM530+Jpa2J9dZLqFpOcYCpexZl9h9A+/Eb6UCqsP9jFaBKqqETJBN
        l0KZh2AWlHfpvsCpA2NNdTwNAXThGlWVykE0H4C5WQ==
X-Google-Smtp-Source: ABdhPJxySBKefpD6GXqZmUhmKb2r0GA3lRRZwfUZbt1FM6SOa64Lc6mTaZPiKM9y79WZNi3Ps/gP+u3VrSXigyoFpm8=
X-Received: by 2002:a2e:9644:: with SMTP id z4mr12971597ljh.333.1594421675522;
 Fri, 10 Jul 2020 15:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200707224604.3737893-4-rajatja@google.com> <20200710202922.GA77140@bjorn-Precision-5520>
 <20200710212853.GA328472@otc-nc-03>
In-Reply-To: <20200710212853.GA328472@otc-nc-03>
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 10 Jul 2020 15:53:59 -0700
Message-ID: <CACK8Z6F-8OZNJU8wqWuZq=moCaOi+3W=CzBeppfO31VZnkqBrg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] PCI/ACS: Enable PCI_ACS_TB for untrusted/external-facing
 devices
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Fri, Jul 10, 2020 at 2:29 PM Raj, Ashok <ashok.raj@intel.com> wrote:
>
> Hi Bjorn
>
>
> On Fri, Jul 10, 2020 at 03:29:22PM -0500, Bjorn Helgaas wrote:
> > On Tue, Jul 07, 2020 at 03:46:04PM -0700, Rajat Jain wrote:
> > > When enabling ACS, enable translation blocking for external facing po=
rts
> > > and untrusted devices.
> > >
> > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > ---
> > > v4: Add braces to avoid warning from kernel robot
> > >     print warning for only external-facing devices.
> > > v3: print warning if ACS_TB not supported on external-facing/untruste=
d ports.
> > >     Minor code comments fixes.
> > > v2: Commit log change
> > >
> > >  drivers/pci/pci.c    |  8 ++++++++
> > >  drivers/pci/quirks.c | 15 +++++++++++++++
> > >  2 files changed, 23 insertions(+)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 73a8627822140..a5a6bea7af7ce 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -876,6 +876,14 @@ static void pci_std_enable_acs(struct pci_dev *d=
ev)
> > >     /* Upstream Forwarding */
> > >     ctrl |=3D (cap & PCI_ACS_UF);
> > >
> > > +   /* Enable Translation Blocking for external devices */
> > > +   if (dev->external_facing || dev->untrusted) {
> > > +           if (cap & PCI_ACS_TB)
> > > +                   ctrl |=3D PCI_ACS_TB;
> > > +           else if (dev->external_facing)
> > > +                   pci_warn(dev, "ACS: No Translation Blocking on ex=
ternal-facing dev\n");
> > > +   }
> >
> > IIUC, this means that external devices can *never* use ATS
> and can
> > never cache translations.

Yes, but it already exists today (and this patch doesn't change that):
521376741b2c2 "PCI/ATS: Only enable ATS for trusted devices"

IMHO any external device trying to send ATS traffic despite having ATS
disabled should count as a bad intent. And this patch is trying to
plug that loophole, by blocking the AT traffic from devices that we do
not expect to see AT from anyway.

Do you see any case where this is not true?

>  And (I guess, I'm not an expert) it can
> > also never use the Page Request Services?
>
> Yep, sounds like it.

Yes, from spec "Address Translation Services" Rev 1.1:
"...a device that supports ATS need not support PRI, but PRI is
dependent on ATS=E2=80=99s capabilities."
(So no ATS =3D No PRI).

>
> >
> > Is this what we want?  Do we have any idea how many external devices
> > this will affect or how much of a performance impact they will see?
> >
> > Do we need some kind of override or mechanism to authenticate certain
> > devices so they can use ATS and PRI?
>
> Sounds like we would need some form of an allow-list to start with so we
> can have something in the interim.

I assume what is being referred to, is an escape hatch to enable ATS
on certain given "external-facing" ports (and devices downstream on
that port). Do we really think a *per-port* control for ATS may be
needed? I can add if there is consensus about this.

>
> I suppose a future platform might have a facilty to ensure ATS is secure =
and
> authenticated we could enable for all of devices in the system, in additi=
on
> to PCI CMA/IDE.
>
> I think having a global override to enable all devices so platform can
> switch to current behavior, or maybe via a cmdline switch.. as much as we
> have a billion of those, it still gives an option in case someone needs i=
t.

Currently:

pci.noats =3D> No ATS on all PCI devices.
(Absense of pci.noats): ATS on all PCI devices, EXCEPT external devices.

I can look to add another parameter that is synonymous to
"trust-external-pci-devices" that can keep ATS enabled on external
ports as well. I think this is better than an allow-list of only
certain ports, because most likely an admin will trust all its
external ports, or not. Also, we can add this global override and may
be add a more granular control later, if and when really needed.

Thanks,

Rajat

>
>
>
> >
> > If we do decide this is the right thing to do, I think we need to
> > expand the commit log a bit, because this is potentially a significant
> > user-visible change.
> >
> > >     pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> > >  }
> > >
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index b341628e47527..bb22b46c1d719 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -4934,6 +4934,13 @@ static void pci_quirk_enable_intel_rp_mpc_acs(=
struct pci_dev *dev)
> > >     }
> > >  }
> > >
> > > +/*
> > > + * Currently this quirk does the equivalent of
> > > + * PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF
> > > + *
> > > + * TODO: This quirk also needs to do equivalent of PCI_ACS_TB,
> > > + * if dev->external_facing || dev->untrusted
> > > + */
> > >  static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
> > >  {
> > >     if (!pci_quirk_intel_pch_acs_match(dev))
> > > @@ -4973,6 +4980,14 @@ static int pci_quirk_enable_intel_spt_pch_acs(=
struct pci_dev *dev)
> > >     ctrl |=3D (cap & PCI_ACS_CR);
> > >     ctrl |=3D (cap & PCI_ACS_UF);
> > >
> > > +   /* Enable Translation Blocking for external devices */
> > > +   if (dev->external_facing || dev->untrusted) {
> > > +           if (cap & PCI_ACS_TB)
> > > +                   ctrl |=3D PCI_ACS_TB;
> > > +           else if (dev->external_facing)
> > > +                   pci_warn(dev, "ACS: No Translation Blocking on ex=
ternal-facing dev\n");
> > > +   }
> > > +
> > >     pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
> > >
> > >     pci_info(dev, "Intel SPT PCH root port ACS workaround enabled\n")=
;
> > > --
> > > 2.27.0.212.ge8ba1cc988-goog
> > >
