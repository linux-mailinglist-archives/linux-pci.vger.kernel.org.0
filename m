Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0F35251A4
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 16:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfEUONT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 10:13:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfEUONT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 May 2019 10:13:19 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A6A72173C;
        Tue, 21 May 2019 14:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558447998;
        bh=SyVKsGwREzZZGkOPILB3RUrWeHrmj1KfgVEx9b0kiN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xdVy/D/T0/iuK8zp3WZ6KcGKrbd+Wzesa4KmGyMcBcX556vESxMFF85rc55aJv2IZ
         UPRzbbHirtWeOONxWzYTTLphWc0E1IQuZoXEtH40hp5dmx/WQ2NV9sKClm7x5WnDEN
         8BCxVvsSP39+S/vjhHWdSYkbn73FszC/X4+5n3PA=
Date:   Tue, 21 May 2019 09:13:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        Lyude Paul <lyude@redhat.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/4] pci: save the boot pcie link speed and restore it
 on fini
Message-ID: <20190521141317.GD57618@google.com>
References: <20190507201245.9295-1-kherbst@redhat.com>
 <20190507201245.9295-5-kherbst@redhat.com>
 <20190520211933.GA57618@google.com>
 <CACO55tsHi+4gRMC=XqOypJttztKNe5oKxxk0eqEVxGZoMzS+4Q@mail.gmail.com>
 <20190521131033.GC57618@google.com>
 <CACO55ts=u7aZ1uZYJ4eMZPvSycwYpzr-W6Xn8oDBLrxsivLOAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACO55ts=u7aZ1uZYJ4eMZPvSycwYpzr-W6Xn8oDBLrxsivLOAw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 21, 2019 at 03:28:48PM +0200, Karol Herbst wrote:
> On Tue, May 21, 2019 at 3:11 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, May 21, 2019 at 12:30:38AM +0200, Karol Herbst wrote:
> > > On Mon, May 20, 2019 at 11:20 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Tue, May 07, 2019 at 10:12:45PM +0200, Karol Herbst wrote:
> > > > > Apperantly things go south if we suspend the device with a different PCIE
> > > > > link speed set than it got booted with. Fixes runtime suspend on my gp107.
> > > > >
> > > > > This all looks like some bug inside the pci subsystem and I would prefer a
> > > > > fix there instead of nouveau, but maybe there is no real nice way of doing
> > > > > that outside of drivers?
> > > >
> > > > I agree it would be nice to fix this in the PCI core if that's
> > > > feasible.
> > > >
> > > > It looks like this driver changes the PCIe link speed using some
> > > > device-specific mechanism.  When we suspend, we put the device in
> > > > D3cold, so it loses all its state.  When we resume, the link probably
> > > > comes up at the boot speed because nothing did that device-specific
> > > > magic to change it, so you probably end up with the link being slow
> > > > but the driver thinking it's configured to be fast, and maybe that
> > > > combination doesn't work.
> > > >
> > > > If it requires something device-specific to change that link speed, I
> > > > don't know how to put that in the PCI core.  But maybe I'm missing
> > > > something?
> > > >
> > > > Per the PCIe spec (r4.0, sec 1.2):
> > > >
> > > >   Initialization – During hardware initialization, each PCI Express
> > > >   Link is set up following a negotiation of Lane widths and frequency
> > > >   of operation by the two agents at each end of the Link. No firmware
> > > >   or operating system software is involved.
> > > >
> > > > I have been assuming that this means device-specific link speed
> > > > management is out of spec, but it seems pretty common that devices
> > > > don't come up by themselves at the fastest possible link speed.  So
> > > > maybe the spec just intends that devices can operate at *some* valid
> > > > speed.
> > >
> > > I would expect that devices kind of have to figure out what they can
> > > operate on and the operating system kind of just checks what the
> > > current state is and doesn't try to "restore" the old state or
> > > something?
> >
> > The devices at each end of the link negotiate the width and speed of
> > the link.  This is done directly by the hardware without any help from
> > the OS.
> >
> > The OS can read the current link state (Current Link Speed and
> > Negotiated Link Width, both in the Link Status register).  The OS has
> > very little control over that state.  It can't directly restore the
> > state because the hardware has to negotiate a width & speed that
> > result in reliable operation.
> >
> > > We don't do anything in the driver after the device was suspended. And
> > > the 0x88000 is a mirror of the PCI config space, but we also got some
> > > PCIe stuff at 0x8c000 which is used by newer GPUs for gen3 stuff
> > > essentially. I have no idea how much of this is part of the actual pci
> > > standard and how much is driver specific. But the driver also wants to
> > > have some control over the link speed as it's tight to performance
> > > states on GPU.
> >
> > As far as I'm aware, there is no generic PCIe way for the OS to
> > influence the link width or speed.  If the GPU driver needs to do
> > that, it would be via some device-specific mechanism.
> >
> > > The big issue here is just, that the GPU boots with 8.0, some on-gpu
> > > init mechanism decreases it to 2.5. If we suspend, the GPU or at least
> > > the communication with the controller is broken. But if we set it to
> > > the boot speed, resuming the GPU just works. So my assumption was,
> > > that _something_ (might it be the controller or the pci subsystem)
> > > tries to force to operate on an invalid link speed and because the
> > > bridge controller is actually powered down as well (as all children
> > > are in D3cold) I could imagine that something in the pci subsystem
> > > actually restores the state which lets the controller fail to
> > > establish communication again?
> >
> >   1) At boot-time, the Port and the GPU hardware negotiate 8.0 GT/s
> >      without OS/driver intervention.
> >
> >   2) Some mechanism reduces link speed to 2.5 GT/s.  This probably
> >      requires driver intervention or at least some ACPI method.
> 
> there is no driver intervention and Nouveau doesn't care at all. It's
> all done on the GPU. We just upload a script and some firmware on to
> the GPU. The script runs then on the PMU inside the GPU and this
> script also causes changing the PCIe link settings. But from a Nouveau
> point of view we don't care about the link before or after that script
> was invoked. Also there is no ACPI method involved.
> 
> But if there is something we should notify pci core about, maybe
> that's something we have to do then?

I don't think there's anything the PCI core could do with that
information anyway.  The PCI core doesn't care at all about the link
speed, and it really can't influence it directly.

> >   3) Suspend puts GPU into D3cold (powered off).
> >
> >   4) Resume restores GPU to D0, and the Port and GPU hardware again
> >      negotiate 8.0 GT/s without OS/driver intervention, just like at
> >      initial boot.
> 
> No, that negotiation fails apparently as any attempt to read anything
> from the device just fails inside pci core. Or something goes wrong
> when resuming the bridge controller.

I'm surprised the negotiation would fail even after a power cycle of
the device.  But if you can avoid the issue by running another script
on the PMU before suspend, that's probably what you'll have to do.

> >   5) Now the driver thinks the GPU is at 2.5 GT/s but it's actually at
> >      8.0 GT/s.
> 
> what is actually meant by "driver" here? The pci subsystem or Nouveau?

I was thinking Nouveau because the PCI core doesn't care about the
link speed.

> > Without knowing more about the transition to 2.5 GT/s, I can't guess
> > why the GPU wouldn't work after resume.  From a PCIe point of view,
> > the link is supposed to work and the device should be reachable
> > independent of the link speed.  But maybe there's some weird
> > dependency between the GPU and the driver here.
> 
> but the device isn't reachable at all, not even from the pci
> subsystem. All reads fail/return a default error value (0xffffffff).

Are these PCI config reads that return 0xffffffff?  Or MMIO reads?
"lspci -vvxxxx" of the bridge and the GPU might have a clue about
whether a PCI error occurred.

> > It sounds like things work if you return to 8.0 GT/s before suspend,
> > things work.  That would make sense to me because then the driver's
> > idea of the link state after resume would match the actual state.
> 
> depends on what is meant by the driver here. Inside Nouveau we don't
> care one bit about the current link speed, so I assume you mean
> something inside the pci core code?
> 
> > But I don't see a way to deal with this in the PCI core.  The PCI core
> > does save and restore most of the architected config space around
> > suspend/resume, but since this appears to be a device-specific thing,
> > the PCI core would have no idea how to save/restore it.
> 
> if we assume that the negotiation on a device level works as intended,
> then I would expect this to be a pci core issue, which might actually
> be not fixable there. But if it's not, then we would have to put
> something like that inside the runpm documentation to tell drivers
> they have to do something about it.
> 
> But again, for me it just sounds like the negotiation on the device
> level fails or something inside pci core messes it up.

To me it sounds like the PMU script messed something up, and the PCI
core has no way to know what that was or how to fix it.

> > > > > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > > > > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > > > > ---
> > > > >  drm/nouveau/include/nvkm/subdev/pci.h |  5 +++--
> > > > >  drm/nouveau/nvkm/subdev/pci/base.c    |  9 +++++++--
> > > > >  drm/nouveau/nvkm/subdev/pci/pcie.c    | 24 ++++++++++++++++++++----
> > > > >  drm/nouveau/nvkm/subdev/pci/priv.h    |  2 ++
> > > > >  4 files changed, 32 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/drm/nouveau/include/nvkm/subdev/pci.h b/drm/nouveau/include/nvkm/subdev/pci.h
> > > > > index 1fdf3098..b23793a2 100644
> > > > > --- a/drm/nouveau/include/nvkm/subdev/pci.h
> > > > > +++ b/drm/nouveau/include/nvkm/subdev/pci.h
> > > > > @@ -26,8 +26,9 @@ struct nvkm_pci {
> > > > >       } agp;
> > > > >
> > > > >       struct {
> > > > > -             enum nvkm_pcie_speed speed;
> > > > > -             u8 width;
> > > > > +             enum nvkm_pcie_speed cur_speed;
> > > > > +             enum nvkm_pcie_speed def_speed;
> > > > > +             u8 cur_width;
> > > > >       } pcie;
> > > > >
> > > > >       bool msi;
> > > > > diff --git a/drm/nouveau/nvkm/subdev/pci/base.c b/drm/nouveau/nvkm/subdev/pci/base.c
> > > > > index ee2431a7..d9fb5a83 100644
> > > > > --- a/drm/nouveau/nvkm/subdev/pci/base.c
> > > > > +++ b/drm/nouveau/nvkm/subdev/pci/base.c
> > > > > @@ -90,6 +90,8 @@ nvkm_pci_fini(struct nvkm_subdev *subdev, bool suspend)
> > > > >
> > > > >       if (pci->agp.bridge)
> > > > >               nvkm_agp_fini(pci);
> > > > > +     else if (pci_is_pcie(pci->pdev))
> > > > > +             nvkm_pcie_fini(pci);
> > > > >
> > > > >       return 0;
> > > > >  }
> > > > > @@ -100,6 +102,8 @@ nvkm_pci_preinit(struct nvkm_subdev *subdev)
> > > > >       struct nvkm_pci *pci = nvkm_pci(subdev);
> > > > >       if (pci->agp.bridge)
> > > > >               nvkm_agp_preinit(pci);
> > > > > +     else if (pci_is_pcie(pci->pdev))
> > > > > +             nvkm_pcie_preinit(pci);
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > @@ -193,8 +197,9 @@ nvkm_pci_new_(const struct nvkm_pci_func *func, struct nvkm_device *device,
> > > > >       pci->func = func;
> > > > >       pci->pdev = device->func->pci(device)->pdev;
> > > > >       pci->irq = -1;
> > > > > -     pci->pcie.speed = -1;
> > > > > -     pci->pcie.width = -1;
> > > > > +     pci->pcie.cur_speed = -1;
> > > > > +     pci->pcie.def_speed = -1;
> > > > > +     pci->pcie.cur_width = -1;
> > > > >
> > > > >       if (device->type == NVKM_DEVICE_AGP)
> > > > >               nvkm_agp_ctor(pci);
> > > > > diff --git a/drm/nouveau/nvkm/subdev/pci/pcie.c b/drm/nouveau/nvkm/subdev/pci/pcie.c
> > > > > index 70ccbe0d..731dd30e 100644
> > > > > --- a/drm/nouveau/nvkm/subdev/pci/pcie.c
> > > > > +++ b/drm/nouveau/nvkm/subdev/pci/pcie.c
> > > > > @@ -85,6 +85,13 @@ nvkm_pcie_oneinit(struct nvkm_pci *pci)
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > +int
> > > > > +nvkm_pcie_preinit(struct nvkm_pci *pci)
> > > > > +{
> > > > > +     pci->pcie.def_speed = nvkm_pcie_get_speed(pci);
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > >  int
> > > > >  nvkm_pcie_init(struct nvkm_pci *pci)
> > > > >  {
> > > > > @@ -105,12 +112,21 @@ nvkm_pcie_init(struct nvkm_pci *pci)
> > > > >       if (pci->func->pcie.init)
> > > > >               pci->func->pcie.init(pci);
> > > > >
> > > > > -     if (pci->pcie.speed != -1)
> > > > > -             nvkm_pcie_set_link(pci, pci->pcie.speed, pci->pcie.width);
> > > > > +     if (pci->pcie.cur_speed != -1)
> > > > > +             nvkm_pcie_set_link(pci, pci->pcie.cur_speed,
> > > > > +                                pci->pcie.cur_width);
> > > > >
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > +int
> > > > > +nvkm_pcie_fini(struct nvkm_pci *pci)
> > > > > +{
> > > > > +     if (!IS_ERR_VALUE(pci->pcie.def_speed))
> > > > > +             return nvkm_pcie_set_link(pci, pci->pcie.def_speed, 16);
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > >  int
> > > > >  nvkm_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pcie_speed speed, u8 width)
> > > > >  {
> > > > > @@ -146,8 +162,8 @@ nvkm_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pcie_speed speed, u8 width)
> > > > >               speed = max_speed;
> > > > >       }
> > > > >
> > > > > -     pci->pcie.speed = speed;
> > > > > -     pci->pcie.width = width;
> > > > > +     pci->pcie.cur_speed = speed;
> > > > > +     pci->pcie.cur_width = width;
> > > > >
> > > > >       if (speed == cur_speed) {
> > > > >               nvkm_debug(subdev, "requested matches current speed\n");
> > > > > diff --git a/drm/nouveau/nvkm/subdev/pci/priv.h b/drm/nouveau/nvkm/subdev/pci/priv.h
> > > > > index a0d4c007..e7744671 100644
> > > > > --- a/drm/nouveau/nvkm/subdev/pci/priv.h
> > > > > +++ b/drm/nouveau/nvkm/subdev/pci/priv.h
> > > > > @@ -60,5 +60,7 @@ enum nvkm_pcie_speed gk104_pcie_max_speed(struct nvkm_pci *);
> > > > >  int gk104_pcie_version_supported(struct nvkm_pci *);
> > > > >
> > > > >  int nvkm_pcie_oneinit(struct nvkm_pci *);
> > > > > +int nvkm_pcie_preinit(struct nvkm_pci *);
> > > > >  int nvkm_pcie_init(struct nvkm_pci *);
> > > > > +int nvkm_pcie_fini(struct nvkm_pci *);
> > > > >  #endif
> > > > > --
> > > > > 2.21.0
> > > > >
