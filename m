Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2A927581D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 14:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgIWMl5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 08:41:57 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45209 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgIWMl5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 08:41:57 -0400
Received: by mail-oi1-f196.google.com with SMTP id z26so24811130oih.12
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 05:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lEkuYet4ydWIPaCWFt/biIhASxA5COek0MiIoH0rjUI=;
        b=cdAvL7fO3rFb+MNE37Pwk5zEevU/j2J3sffizcYafCO/fAyCLUjxRFEXD9p0Jg8s9n
         3X4RWexjyhMlgOF6ndWSZznBNzInjr9vp+08u3bfnn9Bnf1KEk4fUuscmUHu+OkxwQQf
         7Lsq67iwyMxDk2xedwoAKwJjrG2OZIwAJJBfv7VIP39JjJ004KPhodxrLjGWyXnIUxsY
         v4kaDdD0XxxETLrtV5SFvBPNDQ5yUIBkQn4K8rnT0721oXsopLT3tul0x52AzOrWLrUL
         HvGVff0kSm8+fazhGt62QM2Q/GB+2r2inQ/PJ1bTe9B685wIrKO96LFgRU6qOfG0PIan
         0W2g==
X-Gm-Message-State: AOAM531aul+3nPfO+YWQD1er4cvKCnYPiLNKYzt7VoxrzUvLV6TO/cVL
        rmSWFNX7N2s1myBBfyAO+mzAb6FidLKFKHPNoOo=
X-Google-Smtp-Source: ABdhPJwkXvIipAzoINJ+DlGqnP5P3juj/yv02wW+Dklf1IsQxAT07cxxH1snO9VIIYmfmU7qIiYcsw4WQOeEF9vRz8s=
X-Received: by 2002:aca:df84:: with SMTP id w126mr5893124oig.103.1600864916016;
 Wed, 23 Sep 2020 05:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_PoDdSeOxGgr5TzVwTTJmLb7BapXyG0KDs92P=wXzTNfg@mail.gmail.com>
 <20200922065434.GA19668@wunner.de> <CADnq5_MfkojHbquHq4Le6ioSFOY9XdaNBapAEmyOgf0CGMTaUg@mail.gmail.com>
 <20200923121509.GA25329@wunner.de>
In-Reply-To: <20200923121509.GA25329@wunner.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Sep 2020 14:41:42 +0200
Message-ID: <CAJZ5v0j_ZMSLyQWxw2R2SJqssptOwLpKQ7a3eLR4TFiB_s0L_A@mail.gmail.com>
Subject: Re: Enabling d3 support on hotplug bridges
To:     Lukas Wunner <lukas@wunner.de>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 23, 2020 at 2:15 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> [cc += Mario Limonciello @ Dell]
>
> On Tue, Sep 22, 2020 at 10:39:17AM -0400, Alex Deucher wrote:
> > On Tue, Sep 22, 2020 at 2:54 AM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Mon, Sep 21, 2020 at 07:10:55PM -0400, Alex Deucher wrote:
> > > > Recent AMD laptops which have iGPU + dGPU have been non-functional on
> > > > Linux.  The issue is that the laptops rely on ACPI to control the dGPU
> > > > power and that is not happening because the bridges are hotplug
> > > > capable, and the current pci code does not allow runtime pm on hotplug
> > > > capable bridges.  This worked on previous laptops presumably because
> > > > the bridges did not support hotplug or they hit one of the allowed
> > > > cases.  The driver enables runtime power management, but since the
> > > > dGPU does not actually get powered down via the platform ACPI
> > > > controls, no power is saved, and things fall apart on resume leading
> > > > to an unusable GPU or a system hang.  To work around this users can
> > > > currently disable runtime pm in the GPU driver or specify
> > > > pcie_port_pm=force to force d3 on bridges.  I'm not sure what the best
> > > > solution for this is.  I'd rather not have to add device IDs to a
> > > > whitelist every time we release a new platform.  Suggestions?  What
> > > > about something like the attached patch work?
> > >
> > > What is Windows doing on these machines?  Microsoft came up with an
> > > ACPI _DSD property to tell OSPM that it's safe to suspend a hotplug
> > > port to D3:
> > >
> > > https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
>
> I've just taken a look at the ACPI dumps provided by Michal Rostecki
> and Arthur Borsboom in the Gitlab bugs linked below.  The topology
> looks like this:
>
> 00:01.1        Root Port         [\_SB.PCI0.GPP0]
>   01:00.0      Switch Upstream   [\_SB.PCI0.GPP0.SWUS]
>     02:00.0    Switch Downstream [\_SB.PCI0.GPP0.SWUS.SWDS]
>       03:00.0  dGPU              [\_SB.PCI0.GPP0.SWUS.SWDS.VGA]
>       03:00.1  dGPU Audio        [\_SB.PCI0.GPP0.SWUS.SWDS.HDAU]
>
> The Root Port is hotplug-capable but is not suspended because we only
> allow that for Thunderbolt hotplug ports or root ports with Microsoft's
> HotPlugSupportInD3 _DSD property.  However, that _DSD is not present
> in the ACPI dumps and the Root Port is obviously not a Thunderbolt
> port either.
>
> Again, it would be good to know why it's working on Windows.

Agreed.

> Could you ask AMD Windows driver folks?  The ACPI tables look very
> similar even though they're from different vendors (Dell and MSI),
> so they were probably supplied by AMD to those OEMs.
>
> It's quite possible that Windows is now using a BIOS cut-off and
> allows D3 by default on newer BIOSes, so I'm not opposed to your patch.

I would reorder this function, though, to avoid calling
dmi_get_bios_year() twice.

The blacklist can be checked before is_hotplug_bridge, so I would just
make the cut-off date depend on the latter.

> But it would be good to have some kind of confirmation before we risk
> regressing machines which do not support D3 on hotplug-capable Root Ports.

Certainly - if possible.

Cheers!


> > > > From 3a08cb6ac38c47b921b8b6f31b03fcd8f13c4018 Mon Sep 17 00:00:00 2001
> > > > From: Alex Deucher <alexander.deucher@amd.com>
> > > > Date: Mon, 21 Sep 2020 18:07:27 -0400
> > > > Subject: [PATCH] pci: allow d3 on hotplug bridges after 2018
> > > >
> > > > Newer AMD laptops have hotplug capabe bridges with dGPUs behind them.
> > > > If d3 is disabled on the bridge, the dGPU is never powered down even
> > > > though the dGPU driver may think it is because power is handled by
> > > > the pci core.  Things fall apart when the driver attempts to resume
> > > > a dGPU that was not properly powered down which leads to hangs.
> > > >
> > > > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1252
> > > > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1222
> > > > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1304
> > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > ---
> > > >  drivers/pci/pci.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index a458c46d7e39..12927d5df4b9 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -2856,7 +2856,7 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> > > >                * by vendors for runtime D3 at least until 2018 because there
> > > >                * was no OS support.
> > > >                */
> > > > -             if (bridge->is_hotplug_bridge)
> > > > +             if (bridge->is_hotplug_bridge && (dmi_get_bios_year() <= 2018))
> > > >                       return false;
> > > >
> > > >               if (dmi_check_system(bridge_d3_blacklist))
> > > > --
> > > > 2.25.4
> > > >
