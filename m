Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A95274470
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 16:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgIVOjb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 10:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgIVOjb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 10:39:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD87C061755
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2020 07:39:30 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id s13so3594488wmh.4
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2020 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vusuyk5mJci9Z7FMnJVx8p3oROx4dkcdRy1WB8Sr0OU=;
        b=TRZKuuGFCcMroqN15GmllClreSzwDNFdp709TWeEFSMxgCxnwBl/hX3n0MMmrwjo3W
         sVeXVsk18dgviL8uk69e8b2DUPobmsYaMBzaORH0lhGiwDXx+kk2Auz9QYf34HLCClQT
         pkU3eqZvmZsg7cyO99Rkf+4Zw6xo3yi8gSjfPYo8HTj6nlAPY9jgFCH6xqocn5Mvd5TB
         XwiXrgjBxu+JM+ZQehSRKVpwRUAgUnOoGOlcIjOJuMPg407qsrK1ZmcKvw/XZfemOhER
         v9vd7UZPT1Ekted3ZrXjdcyYr0i93P81XBig+3oM+7nxE+CaYO9KEmO5Ha5lCOkhHeEN
         r00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vusuyk5mJci9Z7FMnJVx8p3oROx4dkcdRy1WB8Sr0OU=;
        b=miHP3lwZCiFQ6fT6d/cVUWb5vmwAIKVSdsVYwic8qUshkj/lNSatLXqBSMdaKf9n+y
         R99TcnHAwiqllfzsFUMQrlI8b1t1a/a+pv2po07204GopOtJFuSmZZuSXdiKyeZH4kq5
         Xh3TFGBwSLGdrouEUZI63oMztwhpfrT+N6LPMNaQZIuj2I/i0vvnjv7N0QvpRwWnih6i
         KLoathW91VTUX5Yh1L+UQ966GNciQvAMk6ExYk3kYWFZNgP+GdtJgIrRgEudzApL4+EO
         tLrzVurWGjZTt2wSktu10tvVFH2DrvWwUDuXnQzGLWP0tC5uzn+dW6WS53RHcagjZkMY
         prAw==
X-Gm-Message-State: AOAM53330frh0/1MlRvcrWIeQEEjtL28OjUw4F3OaVZcf0qs99D+J+Zp
        q46O/CrSg85qZRwtTLzi2SbiLte2DJCcek3pon8=
X-Google-Smtp-Source: ABdhPJw/0rv285fBxhp/LfrafXe/YoLigB/bzlQbYFlXYkVLrl+M9BAzoM9PtFUTvsW5BD5cJintnwgOAD6N9npGd9M=
X-Received: by 2002:a7b:c141:: with SMTP id z1mr1398261wmi.79.1600785569181;
 Tue, 22 Sep 2020 07:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_PoDdSeOxGgr5TzVwTTJmLb7BapXyG0KDs92P=wXzTNfg@mail.gmail.com>
 <20200922065434.GA19668@wunner.de>
In-Reply-To: <20200922065434.GA19668@wunner.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 22 Sep 2020 10:39:17 -0400
Message-ID: <CADnq5_MfkojHbquHq4Le6ioSFOY9XdaNBapAEmyOgf0CGMTaUg@mail.gmail.com>
Subject: Re: Enabling d3 support on hotplug bridges
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 22, 2020 at 2:54 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> [cc += Mika]
>
> On Mon, Sep 21, 2020 at 07:10:55PM -0400, Alex Deucher wrote:
> > Recent AMD laptops which have iGPU + dGPU have been non-functional on
> > Linux.  The issue is that the laptops rely on ACPI to control the dGPU
> > power and that is not happening because the bridges are hotplug
> > capable, and the current pci code does not allow runtime pm on hotplug
> > capable bridges.  This worked on previous laptops presumably because
> > the bridges did not support hotplug or they hit one of the allowed
> > cases.  The driver enables runtime power management, but since the
> > dGPU does not actually get powered down via the platform ACPI
> > controls, no power is saved, and things fall apart on resume leading
> > to an unusable GPU or a system hang.  To work around this users can
> > currently disable runtime pm in the GPU driver or specify
> > pcie_port_pm=force to force d3 on bridges.  I'm not sure what the best
> > solution for this is.  I'd rather not have to add device IDs to a
> > whitelist every time we release a new platform.  Suggestions?  What
> > about something like the attached patch work?
>
> What is Windows doing on these machines?  Microsoft came up with an
> ACPI _DSD property to tell OSPM that it's safe to suspend a hotplug
> port to D3:
>
> https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
>
> We support that since 26ad34d510a8 ("PCI / ACPI: Whitelist D3 for more
> PCIe hotplug ports").
>
> I've skimmed the three gitlab bugs you mention below and none of them
> seems to contain an ACPI dump.  First thing to do is request that
> from the users and check if the HotPlugSupportInD3 property is
> present.  And if it's not, we need to find out why it's working
> on Windows.

Thanks.  acpidumps posted on the bug reports.

Alex

>
> Thanks,
>
> Lukas
>
> > From 3a08cb6ac38c47b921b8b6f31b03fcd8f13c4018 Mon Sep 17 00:00:00 2001
> > From: Alex Deucher <alexander.deucher@amd.com>
> > Date: Mon, 21 Sep 2020 18:07:27 -0400
> > Subject: [PATCH] pci: allow d3 on hotplug bridges after 2018
> >
> > Newer AMD laptops have hotplug capabe bridges with dGPUs behind them.
> > If d3 is disabled on the bridge, the dGPU is never powered down even
> > though the dGPU driver may think it is because power is handled by
> > the pci core.  Things fall apart when the driver attempts to resume
> > a dGPU that was not properly powered down which leads to hangs.
> >
> > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1252
> > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1222
> > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1304
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/pci/pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index a458c46d7e39..12927d5df4b9 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -2856,7 +2856,7 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> >                * by vendors for runtime D3 at least until 2018 because there
> >                * was no OS support.
> >                */
> > -             if (bridge->is_hotplug_bridge)
> > +             if (bridge->is_hotplug_bridge && (dmi_get_bios_year() <= 2018))
> >                       return false;
> >
> >               if (dmi_check_system(bridge_d3_blacklist))
> > --
> > 2.25.4
> >
