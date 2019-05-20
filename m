Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB0F52436F
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 00:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbfETWau convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 20 May 2019 18:30:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42242 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfETWau (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 May 2019 18:30:50 -0400
Received: by mail-io1-f65.google.com with SMTP id g16so12354884iom.9
        for <linux-pci@vger.kernel.org>; Mon, 20 May 2019 15:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xUiJthosWahySObfyTFkt97dJXWQVoCesdXWCdfrzGY=;
        b=U6oxpZxMhoLOAfbu9SHNg6f50GIpZe10/XJtBfI0EIZfeC8NpxEwtRiStxU2t3QFI0
         oyXKstVOedvqvSYYwrUsWdTOP73LpTBcF2D74Id41A/ABE+RB5Gvtr1rihszRGJG7YaO
         1XjzPsSiH46ydTzLGLgFjX/Y7JcvHXWT4L23t2Hs8rOSdwcxmCeFI23KyqdtnD+1CF2D
         Yof6way+fSt+BSv1wgep3AV8OCGtAlFZreM2R5haW2GfGE5tLncXVL6g91VsXUFfuDhE
         h/6pB4uvsTH13g/MZegfHp7AmXOS5Co5QTcpgMaUMRgsr5gtB+cjrPF/nhOMDE1M37Cr
         LVRA==
X-Gm-Message-State: APjAAAXkn3b4v4fefPLEWhJiI2RJ+FLr/kNYkQLqQ5DsubmnEdf9BfTr
        JYG9eBhP1NXl4KfEx4kgMjwW0vSIQmvFNxT1CTg08Q==
X-Google-Smtp-Source: APXvYqzUbnoqDPEmuSoQdt3F/45nkQ3yHE8efi9JUfKZXG2muNkLQMumsxXi2ywT0vRngEjMYFdh37zQyz+asTfOB6k=
X-Received: by 2002:a5e:a919:: with SMTP id c25mr19088816iod.166.1558391449228;
 Mon, 20 May 2019 15:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190507201245.9295-1-kherbst@redhat.com> <20190507201245.9295-5-kherbst@redhat.com>
 <20190520211933.GA57618@google.com>
In-Reply-To: <20190520211933.GA57618@google.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 21 May 2019 00:30:38 +0200
Message-ID: <CACO55tsHi+4gRMC=XqOypJttztKNe5oKxxk0eqEVxGZoMzS+4Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] pci: save the boot pcie link speed and restore it
 on fini
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        Lyude Paul <lyude@redhat.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 20, 2019 at 11:20 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, May 07, 2019 at 10:12:45PM +0200, Karol Herbst wrote:
> > Apperantly things go south if we suspend the device with a different PCIE
> > link speed set than it got booted with. Fixes runtime suspend on my gp107.
> >
> > This all looks like some bug inside the pci subsystem and I would prefer a
> > fix there instead of nouveau, but maybe there is no real nice way of doing
> > that outside of drivers?
>
> I agree it would be nice to fix this in the PCI core if that's
> feasible.
>
> It looks like this driver changes the PCIe link speed using some
> device-specific mechanism.  When we suspend, we put the device in
> D3cold, so it loses all its state.  When we resume, the link probably
> comes up at the boot speed because nothing did that device-specific
> magic to change it, so you probably end up with the link being slow
> but the driver thinking it's configured to be fast, and maybe that
> combination doesn't work.
>
> If it requires something device-specific to change that link speed, I
> don't know how to put that in the PCI core.  But maybe I'm missing
> something?
>
> Per the PCIe spec (r4.0, sec 1.2):
>
>   Initialization – During hardware initialization, each PCI Express
>   Link is set up following a negotiation of Lane widths and frequency
>   of operation by the two agents at each end of the Link. No firmware
>   or operating system software is involved.
>
> I have been assuming that this means device-specific link speed
> management is out of spec, but it seems pretty common that devices
> don't come up by themselves at the fastest possible link speed.  So
> maybe the spec just intends that devices can operate at *some* valid
> speed.
>

I would expect that devices kind of have to figure out what they can
operate on and the operating system kind of just checks what the
current state is and doesn't try to "restore" the old state or
something?

We don't do anything in the driver after the device was suspended. And
the 0x88000 is a mirror of the PCI config space, but we also got some
PCIe stuff at 0x8c000 which is used by newer GPUs for gen3 stuff
essentially. I have no idea how much of this is part of the actual pci
standard and how much is driver specific. But the driver also wants to
have some control over the link speed as it's tight to performance
states on GPU.

The big issue here is just, that the GPU boots with 8.0, some on-gpu
init mechanism decreases it to 2.5. If we suspend, the GPU or at least
the communication with the controller is broken. But if we set it to
the boot speed, resuming the GPU just works. So my assumption was,
that _something_ (might it be the controller or the pci subsystem)
tries to force to operate on an invalid link speed and because the
bridge controller is actually powered down as well (as all children
are in D3cold) I could imagine that something in the pci subsystem
actually restores the state which lets the controller fail to
establish communication again?

Just something which kind of would make sense to me.

> > v2: squashed together patch 4 and 5
> >
> > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drm/nouveau/include/nvkm/subdev/pci.h |  5 +++--
> >  drm/nouveau/nvkm/subdev/pci/base.c    |  9 +++++++--
> >  drm/nouveau/nvkm/subdev/pci/pcie.c    | 24 ++++++++++++++++++++----
> >  drm/nouveau/nvkm/subdev/pci/priv.h    |  2 ++
> >  4 files changed, 32 insertions(+), 8 deletions(-)
> >
> > diff --git a/drm/nouveau/include/nvkm/subdev/pci.h b/drm/nouveau/include/nvkm/subdev/pci.h
> > index 1fdf3098..b23793a2 100644
> > --- a/drm/nouveau/include/nvkm/subdev/pci.h
> > +++ b/drm/nouveau/include/nvkm/subdev/pci.h
> > @@ -26,8 +26,9 @@ struct nvkm_pci {
> >       } agp;
> >
> >       struct {
> > -             enum nvkm_pcie_speed speed;
> > -             u8 width;
> > +             enum nvkm_pcie_speed cur_speed;
> > +             enum nvkm_pcie_speed def_speed;
> > +             u8 cur_width;
> >       } pcie;
> >
> >       bool msi;
> > diff --git a/drm/nouveau/nvkm/subdev/pci/base.c b/drm/nouveau/nvkm/subdev/pci/base.c
> > index ee2431a7..d9fb5a83 100644
> > --- a/drm/nouveau/nvkm/subdev/pci/base.c
> > +++ b/drm/nouveau/nvkm/subdev/pci/base.c
> > @@ -90,6 +90,8 @@ nvkm_pci_fini(struct nvkm_subdev *subdev, bool suspend)
> >
> >       if (pci->agp.bridge)
> >               nvkm_agp_fini(pci);
> > +     else if (pci_is_pcie(pci->pdev))
> > +             nvkm_pcie_fini(pci);
> >
> >       return 0;
> >  }
> > @@ -100,6 +102,8 @@ nvkm_pci_preinit(struct nvkm_subdev *subdev)
> >       struct nvkm_pci *pci = nvkm_pci(subdev);
> >       if (pci->agp.bridge)
> >               nvkm_agp_preinit(pci);
> > +     else if (pci_is_pcie(pci->pdev))
> > +             nvkm_pcie_preinit(pci);
> >       return 0;
> >  }
> >
> > @@ -193,8 +197,9 @@ nvkm_pci_new_(const struct nvkm_pci_func *func, struct nvkm_device *device,
> >       pci->func = func;
> >       pci->pdev = device->func->pci(device)->pdev;
> >       pci->irq = -1;
> > -     pci->pcie.speed = -1;
> > -     pci->pcie.width = -1;
> > +     pci->pcie.cur_speed = -1;
> > +     pci->pcie.def_speed = -1;
> > +     pci->pcie.cur_width = -1;
> >
> >       if (device->type == NVKM_DEVICE_AGP)
> >               nvkm_agp_ctor(pci);
> > diff --git a/drm/nouveau/nvkm/subdev/pci/pcie.c b/drm/nouveau/nvkm/subdev/pci/pcie.c
> > index 70ccbe0d..731dd30e 100644
> > --- a/drm/nouveau/nvkm/subdev/pci/pcie.c
> > +++ b/drm/nouveau/nvkm/subdev/pci/pcie.c
> > @@ -85,6 +85,13 @@ nvkm_pcie_oneinit(struct nvkm_pci *pci)
> >       return 0;
> >  }
> >
> > +int
> > +nvkm_pcie_preinit(struct nvkm_pci *pci)
> > +{
> > +     pci->pcie.def_speed = nvkm_pcie_get_speed(pci);
> > +     return 0;
> > +}
> > +
> >  int
> >  nvkm_pcie_init(struct nvkm_pci *pci)
> >  {
> > @@ -105,12 +112,21 @@ nvkm_pcie_init(struct nvkm_pci *pci)
> >       if (pci->func->pcie.init)
> >               pci->func->pcie.init(pci);
> >
> > -     if (pci->pcie.speed != -1)
> > -             nvkm_pcie_set_link(pci, pci->pcie.speed, pci->pcie.width);
> > +     if (pci->pcie.cur_speed != -1)
> > +             nvkm_pcie_set_link(pci, pci->pcie.cur_speed,
> > +                                pci->pcie.cur_width);
> >
> >       return 0;
> >  }
> >
> > +int
> > +nvkm_pcie_fini(struct nvkm_pci *pci)
> > +{
> > +     if (!IS_ERR_VALUE(pci->pcie.def_speed))
> > +             return nvkm_pcie_set_link(pci, pci->pcie.def_speed, 16);
> > +     return 0;
> > +}
> > +
> >  int
> >  nvkm_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pcie_speed speed, u8 width)
> >  {
> > @@ -146,8 +162,8 @@ nvkm_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pcie_speed speed, u8 width)
> >               speed = max_speed;
> >       }
> >
> > -     pci->pcie.speed = speed;
> > -     pci->pcie.width = width;
> > +     pci->pcie.cur_speed = speed;
> > +     pci->pcie.cur_width = width;
> >
> >       if (speed == cur_speed) {
> >               nvkm_debug(subdev, "requested matches current speed\n");
> > diff --git a/drm/nouveau/nvkm/subdev/pci/priv.h b/drm/nouveau/nvkm/subdev/pci/priv.h
> > index a0d4c007..e7744671 100644
> > --- a/drm/nouveau/nvkm/subdev/pci/priv.h
> > +++ b/drm/nouveau/nvkm/subdev/pci/priv.h
> > @@ -60,5 +60,7 @@ enum nvkm_pcie_speed gk104_pcie_max_speed(struct nvkm_pci *);
> >  int gk104_pcie_version_supported(struct nvkm_pci *);
> >
> >  int nvkm_pcie_oneinit(struct nvkm_pci *);
> > +int nvkm_pcie_preinit(struct nvkm_pci *);
> >  int nvkm_pcie_init(struct nvkm_pci *);
> > +int nvkm_pcie_fini(struct nvkm_pci *);
> >  #endif
> > --
> > 2.21.0
> >
