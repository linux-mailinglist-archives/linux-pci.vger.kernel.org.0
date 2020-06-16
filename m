Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8767C1FA599
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 03:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgFPBZM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 21:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgFPBZK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 21:25:10 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DC8C061A0E
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2020 18:25:09 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c17so21476215lji.11
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2020 18:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LP/aQidXnbqXBj86qiTpdN/LTXxXT/wIazu3HgfVB38=;
        b=eL7N9Dz2T+SYzIevLVi3JbrAtfieo/YR/WWou6r/cNQw3wlPzPML5G2TUt+Or/AhJM
         svjEFeuxsxGqWAB7UfciiWwSFtMhVOkkkXYZ+gpkNLdFIRe17YJTbN0msiMv0dKn2MzD
         doLBAfuH313vdkrUY+gIMrGmltxObRSvY4AXjgRI4LkSGpnwnaFbzkzJuHoxzpfWCGa8
         sr2FyxQ5IsA36pAhi0wsKzE4+zi+gj1C9ueu2Y7RgFyuhR79HTD8w/V15aj0pFje32ey
         KHcRb8pwlDPhIu+JIpPkaxxPSv95SEyPDvvpNYTfxIp+KQmcwFuIE5F7h8H+iQKPMEEs
         Vg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LP/aQidXnbqXBj86qiTpdN/LTXxXT/wIazu3HgfVB38=;
        b=qhxkXTzhRk07Di3jZBcJDXTLqT6pOmayOXADSTrBCBSBVp9hNOlcZ5RhrFgFXeBW7c
         AKufgAnLNhENuCTi8/MPBrLx76uumLNt38BQQFJ9nQ6l633qkEPeJWtxFojrW/Z7N9zF
         u6qUH5fWZZg1CoHVHJ20Ee+V5zPBGy6a7YsiCOUNyWW7WWPcXxra/A6dnlB06YKCacp7
         CKzaTNapgr+xV9lzfrRazdhAmYbFeNXaO+QMiueyb0oKkZsKdfLNAnX+4d9y7vrP4Pnq
         vF/FGg7NuSXgFn7hPqW1zuxOaeHcRRUYrQT1YQPYmSp2N71eOsAmGngbLqoihB71R1MF
         nYzQ==
X-Gm-Message-State: AOAM533BXGfiV0yqW9D6oA7p2h42s+hohyxFUBbLcY0O4jT3QHO3WIEX
        lUPRf2ocbP52oT85f2FksGiAL82ft9DD459cs96iOA==
X-Google-Smtp-Source: ABdhPJxF6oX/Hpl7j2LmDycbZUtjorwvc3ivf0y/ulSvOBeN9FDTVBd8MdJaYdN1qAokmmvmQP90S2+LbmZ2h+nNjl0=
X-Received: by 2002:a2e:6f19:: with SMTP id k25mr163679ljc.247.1592270707239;
 Mon, 15 Jun 2020 18:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200607113632.GA49147@kroah.com> <20200609210400.GA1461839@bjorn-Precision-5520>
 <CAOSf1CGMwHGSn18MeKYr2BESfLwq3Q8_0fC6yhiQRrAXeSosqQ@mail.gmail.com> <CAA93t1r37y-Shr+-oHoBoLSbE1vAguwdE2ak2F6L4Ecm5+3JKQ@mail.gmail.com>
In-Reply-To: <CAA93t1r37y-Shr+-oHoBoLSbE1vAguwdE2ak2F6L4Ecm5+3JKQ@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 15 Jun 2020 18:24:30 -0700
Message-ID: <CACK8Z6H-DZQYBMqtU5_H5TTwwn35Q7Yysm9a7Wj0twfQP8QBzA@mail.gmail.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     Rajat Jain <rajatxjain@gmail.com>
Cc:     "Oliver O'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 10, 2020 at 12:57 PM Rajat Jain <rajatxjain@gmail.com> wrote:
>
> On Tue, Jun 9, 2020 at 6:34 PM Oliver O'Halloran <oohall@gmail.com> wrote:
> >
> > On Wed, Jun 10, 2020 at 7:04 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > To sketch this out, my understanding of how this would work is:
> > >
> > >   - Expose the PCI pdev->untrusted bit in sysfs.  We don't expose this
> > >     today, but doing so would be trivial.  I think I would prefer a
> > >     sysfs name like "external" so it's more descriptive and less of a
> > >     judgment.
> > >
> > >     This comes from either the DT "external-facing" property or the
> > >     ACPI "ExternalFacingPort" property.
> >
> > I don't think internal / external is the right distinction to be
> > making. We have a similar trust issue with the BMC in servers even
> > though they're internal devices. They're typically network accessible
> > and infrequently updated so treating them as trustworthy isn't a great
> > idea. We have been slowly de-privileging the BMC over the last few
> > years, but the PCIe interface isn't locked down enough for my liking
> > since the SoCs we use do allow software to set the VDID and perform
> > arbitrary DMAs (thankfully limited to 32bit). If we're going to add in
> > infrastructure for handling possibly untrustworthy PCI devices then
> > I'd like to use that for BMCs too.
> >
> > >   - All devices present at boot are enumerated.  Any statically built
> > >     drivers will bind to them before any userspace code runs.
> > >
> > >     If you want to keep statically built drivers from binding, you'd
> > >     need to invent some mechanism so pci_driver_init() could clear
> > >     drivers_autoprobe after registering pci_bus_type.
> > >
> > >   - Early userspace code prevents modular drivers from automatically
> > >     binding to PCI devices:
> > >
> > >       echo 0 > /sys/bus/pci/drivers_autoprobe
> > >
> > >     This prevents modular drivers from binding to all devices, whether
> > >     present at boot or hot-added.
> >
> > I don't see why this is preferable to just disabling autoprobe for
> > untrusted devices. That would dovetail nicely with Rajat's whitelist
> > idea if we want to go down that route and I think we might want to.
> > The BMC usually provides some form of VGA console and we'd like that
> > to continue working out-of-the-box without too much user (or distro)
> > intervention.
>
> I wouldn't mind introducing a kernel parameter to disable auto-probing
> of untrusted devices if there is a wider agreement here.
> The only notch is that in my opinion, if present, that parameter
> should disable auto-probing for "external" devices only (i.e.
> "external-facing" devices should still be auto-probed).

So I looked around at my systems, and I realized that I will have to
go this way (introduce a parameter to disable auto-probing of
untrusted devices), because we do have systems on which we might not
have control over what devices will show up when (external devices'
PCI link may come up before the userspace gets a chance to run). I
shall be sending out a patch soon. I've sent out a couple of other
loosely related patches here:

https://lkml.org/lkml/2020/6/15/1447

Thanks,

Rajat

>
> Thanks,
>
> Rajat
>
> >
> > Oliver
